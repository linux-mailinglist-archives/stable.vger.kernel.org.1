Return-Path: <stable+bounces-247064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDwYKPwZBWrOSQIAu9opvQ
	(envelope-from <stable+bounces-247064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:40:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4853C652
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B763038F6A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466372D29C8;
	Thu, 14 May 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bryA+xMP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3243B28D;
	Thu, 14 May 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719225; cv=none; b=oA78ZXdd6+ZhZnilNnSMpq5AuSFVTJTRa5mQQOG53gMZu1v+kJt15gOw55vsWPCJm+cGdUozcrmV2SG8MYYhPddC1+0Md9evc6R4vzPe3Oj3H8P4qPEMa8L0NylppzBJzVpDO2ke/BUCDZ7h1rF4RvXbEYj4zFTDly6274+6yMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719225; c=relaxed/simple;
	bh=DHXZrYr5HpqXxV6YN7/Rh2hvdaDOXXYVl3Wbie5hkNw=;
	h=Date:To:From:Subject:Message-Id; b=rnqLi5cev2wfnbUuIqiTW6L6QQtlEloLKCwM35n4ohFCM1W8XiinD4luNvNz1ZCm+wlENZcrt/OHamSHPbVKZhdlV5eb/n7NjArtrUCWaeJriRUa2WdL2demuWXk1+iHYbVMNfx08VeNv9DvKpoLWeQqS2J3I9z3o+FPk8MEJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bryA+xMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70512C19425;
	Thu, 14 May 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778719224;
	bh=DHXZrYr5HpqXxV6YN7/Rh2hvdaDOXXYVl3Wbie5hkNw=;
	h=Date:To:From:Subject:From;
	b=bryA+xMPvWISRrNPsoxZgFZbKAkuYzMambc3saLX3fCDFPcX1Xn3uCd3aHAbGOaN0
	 ohuwpQAaeGMvmH7cDChK2Sgr1qDoTj6j01tHXGFebuo2SnVbSJ4SeqTW6aXg4mY2Qk
	 N9LRqH/KSraLpy0bgZ3jD2tCDp1crhj0UFWwkWnI=
Date: Wed, 13 May 2026 17:40:23 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,akpm@linux-foundation.org,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch removed from -mm tree
Message-Id: <20260514004024.70512C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: EDE4853C652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247064-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,sk.com,intel.com,gmail.com,gourry.net,kernel.org,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,linux-foundation.org:email,linux-foundation.org:dkim,gourry.net:email]
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/migrate_device: fix spinlock leak in migrate_vma_insert_huge_pmd_page
has been removed from the -mm tree.  Its filename was
     mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Sunny Patel <nueralspacetech@gmail.com>
Subject: mm/migrate_device: fix spinlock leak in migrate_vma_insert_huge_pmd_page
Date: Sat, 25 Apr 2026 19:05:27 +0530

When check_stable_address_space() fails after the PMD spinlock has
been acquired via pmd_lock(), the code jumps directly to the abort
label, bypassing the spin_unlock() call in unlock_abort. This causes
the PMD spinlock to be permanently held, leading to a deadlock.

Change the goto target from abort to unlock_abort to ensure the
spinlock is always released on this error path.

Link: https://lore.kernel.org/20260425133537.17463-1-nueralspacetech@gmail.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/migrate_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/migrate_device.c~mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page
+++ a/mm/migrate_device.c
@@ -850,7 +850,7 @@ static int migrate_vma_insert_huge_pmd_p
 	ptl = pmd_lock(vma->vm_mm, pmdp);
 	csa_ret = check_stable_address_space(vma->vm_mm);
 	if (csa_ret)
-		goto abort;
+		goto unlock_abort;
 
 	/*
 	 * Check for userfaultfd but do not deliver the fault. Instead,
_

Patches currently in -mm which might be from nueralspacetech@gmail.com are

mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch
mm-migrate_device-cleanup-up-pmd-checks-and-warnings.patch



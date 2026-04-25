Return-Path: <stable+bounces-241129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IU9HJPH7Gl1cgAAu9opvQ
	(envelope-from <stable+bounces-241129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 15:54:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2605466878
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84BEB300DA7C
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657637E2E9;
	Sat, 25 Apr 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zczuaMOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B13624C1;
	Sat, 25 Apr 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777125264; cv=none; b=J1TvZuIHIxjSgHfMV+ZGU+06Eh/FK8baymsp7R0T9fIpN84sJVUZdJFDD6zMM91rlN2TmRWk+J6TkeAkyrQd/OZVZScy/7kG15aMiD4908e8dRtWTDFPTGB+tebefS9jJxbn0eUBMswGkccbqPK0rzv4OMW2oqc/mVlGVv4YoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777125264; c=relaxed/simple;
	bh=gLVEs2P0QM29t0wMQ8PGBMDaRv4VyOiBEf2TF8B8CJQ=;
	h=Date:To:From:Subject:Message-Id; b=HTvAgQskkrZTnZMitiYzhs+hQtoSuCfR8+6NEamBygCztOuMTuW/UzGYxn+pZdFbLfOCnIwfgKI6a3PoXrjQygFH8gjUg1qN8ch2qwqIY9/P3dqK3gx2s5w75fgMwrYnZq5Kom/T+LYAbc5rMJnYc0ykhf5jjfn9T/m/iGae2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zczuaMOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8463C2BCB0;
	Sat, 25 Apr 2026 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777125263;
	bh=gLVEs2P0QM29t0wMQ8PGBMDaRv4VyOiBEf2TF8B8CJQ=;
	h=Date:To:From:Subject:From;
	b=zczuaMOdVh/lE66fpangfag8HxHW7dFUYong2rSOiCyojozqLQmwXrpgMX7EUF0A9
	 DgnGeN3DXhaRha+Nn8WITXxD9EpcmLvV4EPkr0/tJRKGeHzj7AkawWM9vvLyapobrL
	 vb3nG6n6SDKeNFAavXAXTST4fZx+3PyiJzGLxkFo=
Date: Sat, 25 Apr 2026 06:54:23 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,akpm@linux-foundation.org,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch added to mm-hotfixes-unstable branch
Message-Id: <20260425135423.D8463C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E2605466878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241129-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,sk.com,intel.com,gmail.com,gourry.net,kernel.org,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


The patch titled
     Subject: mm/migrate_device: fix spinlock leak in migrate_vma_insert_huge_pmd_page
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

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
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
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

mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch
mm-migrate_device-cleanup-up-pmd-checks-and-warnings.patch



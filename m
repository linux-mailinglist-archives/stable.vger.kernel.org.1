Return-Path: <stable+bounces-262161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cy9aJzRrJ2q2wQIAu9opvQ
	(envelope-from <stable+bounces-262161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:24:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAA65B97D
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="k/kTKumE";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262161-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262161-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E2030621E9
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F95302149;
	Tue,  9 Jun 2026 01:22:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50F2F9C37;
	Tue,  9 Jun 2026 01:22:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968179; cv=none; b=c/HKrG67Qxj9WWE6GfH3lteNaZeJ5XgTcCqUEshvhXV+Pr5AQmWBmWX3lRtHSogxzpgCrlBQ6wOb8YiR0vcEZECdKTE6AAiV+IOsQw8BWgmHrQ8y+z7z0UDjOp0XIEZxaK5eZV/cvfbQ/T8MaNRBdXQJ5F3rl+voJHkr+q8E/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968179; c=relaxed/simple;
	bh=0rJosYoedBTOl0baMIJP+4kCue3SCMbweyIWGu475qU=;
	h=Date:To:From:Subject:Message-Id; b=CYu+Pmhvo95yxotH8djNEsSuCg4/1SUdrSocqBRUPvaE/R19fj5EyQ+rUrdWY0pVivjzdm/kS88kK08v5rMwccH6vYAkzwaBWD6j9sAJsBAB3tPU8vTR0LFdRRpbi60D/Lny6T+XmXTKyENzZSeMU0M0tQzDeTN/6KHYImDZEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k/kTKumE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57501F00893;
	Tue,  9 Jun 2026 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780968178;
	bh=hYM5HYSm6WE7dVmU0hyCB7yR52izCnaxQTmAmcEvL84=;
	h=Date:To:From:Subject;
	b=k/kTKumEZlKL4/7wKy4Xxi/c8eCE21X9odKmlnuCxuQ4yYQ6HM6vU7doOhRhvny2G
	 qM4BlDS5brK7KZoMNznEKpqDKtYvTobDduf5gAssjBEltkE6qOp1twJSDWPkc1aqek
	 7LiIDGkIOQmnMRXqUeSLQqLgF745mPOLt4qpMfnw=
Date: Mon, 08 Jun 2026 18:22:57 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,osalvador@kernel.org,ljs@kernel.org,david@kernel.org,balbirs@nvidia.com,dev.jain@arm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] fs-proc-task_mmu-do-not-warn-on-seeing-non-migration-pmd-entry.patch removed from -mm tree
Message-Id: <20260609012257.E57501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262161-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:osalvador@kernel.org,m:ljs@kernel.org,m:david@kernel.org,m:balbirs@nvidia.com,m:dev.jain@arm.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05FAA65B97D


The quilt patch titled
     Subject: fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
has been removed from the -mm tree.  Its filename was
     fs-proc-task_mmu-do-not-warn-on-seeing-non-migration-pmd-entry.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Dev Jain <dev.jain@arm.com>
Subject: fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
Date: Thu, 4 Jun 2026 05:53:05 +0000

Patch series "mm/hmm: A fix and a selftest", v3.

Patch 1 fixes a stale warning present from the time when only migration
softleaf entries were supported at the PMD level.

Patch 2 adds some code into hmm-tests.c which exercises the pagemap path
for PMD device-private entries.


This patch (of 2):

pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
entry.  This became false once device-private entries at the PMD level
were added.

Therefore, remove the stale migration-only assertion.

Link: https://lore.kernel.org/20260604055308.1947679-1-dev.jain@arm.com
Link: https://lore.kernel.org/20260604055308.1947679-2-dev.jain@arm.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Tested-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/task_mmu.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/proc/task_mmu.c~fs-proc-task_mmu-do-not-warn-on-seeing-non-migration-pmd-entry
+++ a/fs/proc/task_mmu.c
@@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = softleaf_to_page(entry);
 	}
 
_

Patches currently in -mm which might be from dev.jain@arm.com are

mm-khugepaged-generalize-alloc_charge_folio.patch



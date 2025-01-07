Return-Path: <stable+bounces-107805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D3A038CB
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32073A52F9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F83D1E0DC0;
	Tue,  7 Jan 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ouQbHWtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15F1DB34E;
	Tue,  7 Jan 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235039; cv=none; b=Qik78+AVna3lWG8A4lAUhUQTSdUvIxfShL7o2v1AtUT0Lys6a5zJHgNxiutrVrIPL12lzr00RiiONOs1Eb6OFTNAAKX4MEIyd8VBMNeqdjzkCM71uEwe7Dugw+zIWko6lPARTfkxXpaZ6U/mckvF/MCWDEqzSmCR4SjbxJIK98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235039; c=relaxed/simple;
	bh=UAtX8AUJOrQOBYiFFFvXGZRDxyOE3yCzR96y57AQ8xM=;
	h=Date:To:From:Subject:Message-Id; b=UvetadfDEH5Z7IbHozGV2YgQPWSP7YdhWIxbULNHktt9oKJ2zw0ndxe+dDiQE1N3qVWeIuTLJ0nH9FJD6K4v0NzPVQ1+WEhYbPr3mbQe2a+bsCm/IFKFbp4TJ+Wkt2R2hTM0lUBf2mSB5BmDfodIgezeisgpvthCcod4ykIAJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ouQbHWtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7B7C4CED6;
	Tue,  7 Jan 2025 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736235039;
	bh=UAtX8AUJOrQOBYiFFFvXGZRDxyOE3yCzR96y57AQ8xM=;
	h=Date:To:From:Subject:From;
	b=ouQbHWtGSjBYxuFRSy81hX4itpaRfOBcEIkixaiyP9fgOYg3SJFjeSmESlXYND7l6
	 SX7J9R+fja0QzFgdF+3OJHdLiSAtAtVxqPEEZ36zLrp8HMp83v8VMcJY7UGZxxDzie
	 TiZCiIs+MKokPEaKlUT1nJ3hCI7DZ1ERmo1QDWlo=
Date: Mon, 06 Jan 2025 23:30:38 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,koichiro.den@canonical.com,greg@kroah.com,bp@alien8.de,bigeasy@linutronix.de,agordeev@linux.ibm.com,akpm@linux-foundation.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged] revert-vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep.patch removed from -mm tree
Message-Id: <20250107073038.EC7B7C4CED6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: revert "vmstat: disable vmstat_work on vmstat_cpu_down_prep()"
has been removed from the -mm tree.  Its filename was
     revert-vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: Andrew Morton <akpm@linux-foundation.org>
Subject: revert "vmstat: disable vmstat_work on vmstat_cpu_down_prep()"
Date: Mon Jan  6 06:24:12 PM PST 2025

Revert adcfb264c3ed ("vmstat: disable vmstat_work on
vmstat_cpu_down_prep()") due to "workqueue: work disable count
underflowed" WARNings.

Fixes: adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()") 
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Greg KH <greg@kroah.com>
Cc: Koichiro Den <koichiro.den@canonical.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmstat.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/vmstat.c~revert-vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep
+++ a/mm/vmstat.c
@@ -2148,14 +2148,13 @@ static int vmstat_cpu_online(unsigned in
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
 		node_set_state(cpu_to_node(cpu), N_CPU);
 	}
-	enable_delayed_work(&per_cpu(vmstat_work, cpu));
 
 	return 0;
 }
 
 static int vmstat_cpu_down_prep(unsigned int cpu)
 {
-	disable_delayed_work_sync(&per_cpu(vmstat_work, cpu));
+	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
 	return 0;
 }
 
_

Patches currently in -mm which might be from akpm@linux-foundation.org are

mm-swap_cgroup-allocate-swap_cgroup-map-using-vcalloc-fix.patch
mm-page_alloc-add-some-detailed-comments-in-can_steal_fallback-fix.patch
mm-introduce-mmap_lock_speculate_try_beginretry-fix.patch
mm-damon-tests-vaddr-kunith-reduce-stack-consumption.patch
mm-damon-tests-vaddr-kunith-reduce-stack-consumption-fix.patch
mm-remove-an-avoidable-load-of-page-refcount-in-page_ref_add_unless-fix.patch
mm-fix-outdated-incorrect-code-comments-for-handle_mm_fault-fix.patch
mm-huge_memoryc-rename-shadowed-local.patch
replace-free-hugepage-folios-after-migration-fix.patch
xarray-port-tests-to-kunit-fix.patch
checkpatch-check-return-of-git_commit_info-fix.patch
fault-inject-use-prandom-where-cryptographically-secure-randomness-is-not-needed-fix.patch



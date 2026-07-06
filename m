Return-Path: <stable+bounces-272329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TbyCDCgwTGr+hQEAu9opvQ
	(envelope-from <stable+bounces-272329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 00:46:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54632716216
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 00:45:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=qfnb+9l5;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272329-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272329-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C61E30356E3
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB6436BC2;
	Mon,  6 Jul 2026 22:35:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4654435AAC;
	Mon,  6 Jul 2026 22:35:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377321; cv=none; b=W/e5Qc1LWDbIfV383S1b7/qcXRHRHmZc/aZkuunPYt65w6Mq0bDOqWCa8c+EP5fA5zpZrk1cup8xATySCnaERjHX4IQaowMi9dUm9FUbHEqKh8itKtP/k7mSHzkHpTNXoQRzesUvXb2AkvyVEAtJcnhv5e3kNNsimWoYW49r7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377321; c=relaxed/simple;
	bh=6Nl2iQ6tZq+bO9CkJVUSPDv3GsulWOnR0YIBzQO4yo0=;
	h=Date:To:From:Subject:Message-Id; b=EVRs+6g09vcNTtqnA/LFET06zzq4Aj1dPznKEAmHUtcGPrV3WE6nZWH/rWGQOIZnQ14eAf9u/Jc6x168NozUT71OI3wRYW9hfL7JzueGQMgBinDehsu3hDJfMwJgfE/e+CoDfTPMtbZuV7QzsSXQ8TRSW66FKQ2DFtnadPILZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qfnb+9l5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A71F000E9;
	Mon,  6 Jul 2026 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783377319;
	bh=hGTsLnzqyox/bUn+Vll9LL7sKRpbkVRK/Zhsm92XuB8=;
	h=Date:To:From:Subject;
	b=qfnb+9l5AKoLXg3Ep9dzMjM/kUcV6yEGZE0KxDZzGrqFZPI2b5O5N9f//z3dCBkVE
	 S3LzFMQtlGjsRy8Gcbf6HjztjQ2Y294Y1C38tAORFJgZq41G7XnqIS3PBG+Mflh1TL
	 AH3opeh3sxzlVtjT3AJgeGOISYzfzJzGd86BjQJg=
Date: Mon, 06 Jul 2026 15:35:19 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,tj@kernel.org,stable@vger.kernel.org,ridong.chen@linux.dev,rakie.kim@sk.com,mkoutny@suse.com,matthew.brost@intel.com,longman@redhat.com,linux@rasmusvillemoes.dk,joshua.hahnjy@gmail.com,hannes@cmpxchg.org,gourry@gourry.net,david@kernel.org,byungchul@sk.com,apopple@nvidia.com,farhad.alemi@berkeley.edu,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + cgroup-cpuset-rebind-mm-mempolicy-to-effective_mems-not-mems_allowed.patch added to mm-hotfixes-unstable branch
Message-Id: <20260706223519.BD6A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	SUSPICIOUS_RECIPS(1.50)[];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:ziy@nvidia.com,m:ying.huang@linux.alibaba.com,m:tj@kernel.org,m:stable@vger.kernel.org,m:ridong.chen@linux.dev,m:rakie.kim@sk.com,m:mkoutny@suse.com,m:matthew.brost@intel.com,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:gourry@gourry.net,m:david@kernel.org,m:byungchul@sk.com,m:apopple@nvidia.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,kernel.org,linux.dev,sk.com,suse.com,intel.com,redhat.com,rasmusvillemoes.dk,gmail.com,cmpxchg.org,gourry.net,berkeley.edu,linux-foundation.org];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272329-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54632716216


The patch titled
     Subject: cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     cgroup-cpuset-rebind-mm-mempolicy-to-effective_mems-not-mems_allowed.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/cgroup-cpuset-rebind-mm-mempolicy-to-effective_mems-not-mems_allowed.patch

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
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
Date: Mon, 6 Jul 2026 10:20:23 +0200

Creating a child cpuset where cpuset.mems is never set leads to a div/0
when a VMA mempolicy with MPOL_F_RELATIVE_NODES rebinds in response to a
CPU hotplug event.

Reproduction steps:
 1) Create a cgroup w/ cpuset controls (do not set cpuset.mems)
 2) Move the task into the child cpuset
 3) Create a VMA mempolicy for that task with MPOL_F_RELATIVE_NODES
 4) unplug and hotplug a cpu
      echo 0 > /sys/devices/system/cpu/cpu1/online
      echo 1 > /sys/devices/system/cpu/cpu1/online
 5) mempolicy rebind does a div/0 in mpol_relative_nodemask on the
    call to __nodes_fold()

The cpuset code passes (cs->mems_allowed) which is not guaranteed to have
nodes to the rebind routine.  Use cs->effective_mems instead, which is
guaranteed to have a non-empty nodemask once we reach that code path.

[david@kernel.org: add a comment, slightly rephrase description]
Link: https://lore.kernel.org/all/CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com/
Link: https://lore.kernel.org/20260706082023.60832-1-david@kernel.org
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Suggested-by: Gregory Price <gourry@gourry.net>
Suggested-by: Waiman Long <longman@redhat.com>
Acked-by: Waiman Long <longman@redhat.com>
Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
Closes: https://lore.kernel.org/linux-mm/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ridong Chen <ridong.chen@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/cgroup/cpuset.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/cgroup/cpuset.c~cgroup-cpuset-rebind-mm-mempolicy-to-effective_mems-not-mems_allowed
+++ a/kernel/cgroup/cpuset.c
@@ -2653,7 +2653,12 @@ void cpuset_update_tasks_nodemask(struct
 
 		migrate = is_memory_migrate(cs);
 
-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		/*
+		 * For v1 we can have empty effective_mems, but we cannot
+		 * attach any tasks (see cpuset_can_attach_check()). For v2,
+		 * effective_mems is guaranteed to not be empty.
+		 */
+		mpol_rebind_mm(mm, &cs->effective_mems);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
_

Patches currently in -mm which might be from farhad.alemi@berkeley.edu are

cgroup-cpuset-rebind-mm-mempolicy-to-effective_mems-not-mems_allowed.patch



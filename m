Return-Path: <stable+bounces-237999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A76dM5zm3mk5MQAAu9opvQ
	(envelope-from <stable+bounces-237999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:15:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF633FF766
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3183C307C452
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B202D73B6;
	Wed, 15 Apr 2026 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2ZVOaoJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304CC2C1595;
	Wed, 15 Apr 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215702; cv=none; b=cbeOhFvr1xU32mCeVXrEtyyGrbf3DtgC2bubCn8Prgp3t3quToECrGsG5MTvY1m1K1Fotz5JsoW56xjhifIJEc1Ecku4dQS7tshtmfx6veLR0/8tm2lGdOceFiNWO1lcSiSQbH+uaG05MHBJHz6YaWSP41saosvajZeS8nSdPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215702; c=relaxed/simple;
	bh=zN8meoFlbPFkB/1NvjW+rIGOo+gAkht+/oBYFBE0QXo=;
	h=Date:To:From:Subject:Message-Id; b=rjCbxgtE75eckCNErXBjiAuosjYaahLBTU+b5YPoOUmGphSokuDJVTW1DmNWR4l5IUm6uF8Ez+Nzvw/rQO13LALkhoLylhxwQ33MOaaFvpIKUjaAGWxcFihOGMkSnRSQXj3aOgVOVG91l6yRnJCpZJbDs/gbAHvzn8FS+hqqiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2ZVOaoJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61ABC19425;
	Wed, 15 Apr 2026 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776215701;
	bh=zN8meoFlbPFkB/1NvjW+rIGOo+gAkht+/oBYFBE0QXo=;
	h=Date:To:From:Subject:From;
	b=2ZVOaoJqZWYq4F0698dNDIopiFUaXIWoO3PD5WHPp235m8qfXWGrGMhg2mcO4K27Q
	 QIlz/ho0rlJVGDR7wbUUcpydkDb/mjzRO2W9/oSZY4jvyWBUL0XYf6mA+4TwrxrjMS
	 3OPA5fiJbaMIFVB2snqWHtKQgUGp2i7TnSz9ytVc=
Date: Tue, 14 Apr 2026 18:14:57 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-migrate_device-fix-double-unlock.patch added to mm-hotfixes-unstable branch
Message-Id: <20260415011500.E61ABC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237999-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,intel.com:email,nvidia.com:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AF633FF766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/migrate_device: fix double unlock
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-migrate_device-fix-double-unlock.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-migrate_device-fix-double-unlock.patch

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
Subject: mm/migrate_device: fix double unlock
Date: Tue, 14 Apr 2026 02:45:49 +0530

migrate_vma_collect_huge_pmd() calls spin_unlock(ptl) after
softleaf_entry_wait_on_locked(), which already releases the ptl.

Link: https://lkml.kernel.org/r/20260413211559.20969-1-nueralspacetech@gmail.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/migrate_device.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/migrate_device.c~mm-migrate_device-fix-double-unlock
+++ a/mm/migrate_device.c
@@ -177,7 +177,6 @@ static int migrate_vma_collect_huge_pmd(
 
 		if (softleaf_is_migration(entry)) {
 			softleaf_entry_wait_on_locked(entry, ptl);
-			spin_unlock(ptl);
 			return -EAGAIN;
 		}
 
_

Patches currently in -mm which might be from nueralspacetech@gmail.com are

mm-migrate_device-fix-double-unlock.patch



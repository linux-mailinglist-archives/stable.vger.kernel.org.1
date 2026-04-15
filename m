Return-Path: <stable+bounces-238000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k8t6LS3n3mlxMQAAu9opvQ
	(envelope-from <stable+bounces-238000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:17:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 282083FF770
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC456301CFF7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002471E5B88;
	Wed, 15 Apr 2026 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eH1k7P0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB77625;
	Wed, 15 Apr 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215850; cv=none; b=qOjsQo8VlHeDXBAM+mKXP7ezhgQmMul6xzKOxfz7bXyLFfLR/9LIzWEPRUC9DFsZCfen3sa9BcvfPZOjgFzoO+qaG/P7h0vVJcjr7Ic9OhIHg5TEL1qTUYjssSdmuNqpqJ2omLBJAsFopyXRY5OmkPbQwUbZDCys/q872kh+f6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215850; c=relaxed/simple;
	bh=TQd7G15SrjbobkzvLyUfO3cmOh63ieOEZ2KwsuO5jmk=;
	h=Date:To:From:Subject:Message-Id; b=cEJ1mWtjZ4rvPl0dZZRqU0n4FRaO4YDSzkeReTqBcJ5tbx+xrVvNdmaKT1UPlh6FYdCYc4fcU1d5H5UueKtG/l66uv/b03aSFqr4flvjXu+H1w8LxA1PIpUMM69zV0HiRgYbm3+lvMDGEMOmZiu7Sfu7xvP2gHCJAdb2/9i7QW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eH1k7P0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7835C19425;
	Wed, 15 Apr 2026 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776215850;
	bh=TQd7G15SrjbobkzvLyUfO3cmOh63ieOEZ2KwsuO5jmk=;
	h=Date:To:From:Subject:From;
	b=eH1k7P0PigpuQdTuzArh5GkUkz7cDDw/BQIfH2G/4KKqaSSyhpFvEBb6yqrQBL4dM
	 1VCGQBkZ1YmZQYUxccskEJwv4wc1PGh7e5RAEvOjAuQS0ptBqHwjmB3/noLtgO7+SF
	 2SjKMWR5+Ibyb/rU3ykCmIMWkeFaK07d7jPllW+E=
Date: Tue, 14 Apr 2026 18:17:26 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [obsolete] mm-migrate_device-fix-double-unlock.patch removed from -mm tree
Message-Id: <20260415011729.D7835C19425@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238000-lists,stable=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email,sk.com:email]
X-Rspamd-Queue-Id: 282083FF770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/migrate_device: fix double unlock
has been removed from the -mm tree.  Its filename was
     mm-migrate_device-fix-double-unlock.patch

This patch was dropped because it is obsolete

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




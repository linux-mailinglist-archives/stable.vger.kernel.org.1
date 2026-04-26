Return-Path: <stable+bounces-241175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E6XN4Qs7mn6rAAAu9opvQ
	(envelope-from <stable+bounces-241175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 17:17:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D746A7BA
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494B63011108
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC63016E1;
	Sun, 26 Apr 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ifibh9L3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A792BB1D;
	Sun, 26 Apr 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777216640; cv=none; b=qGTTOr+wtVBdZff50PDlCmuYFWyLp0VG2DdqLU+Sl4mAZxsMUfWqdhTPN+3Rpv/sGZuxujk55GCPhiVZa0cVnTrwQDxAisTG3hIgbF9JKeAxyJFHiLpSvSVnqlY6x4+biHWbyBNd4wT3UuEXKLJsQv8mAXgtji/DgyNd/jxZ6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777216640; c=relaxed/simple;
	bh=Hyx1AOMdihp+Z0kWFQXE3e1vVswR/Lkb7DNRI/bRAWs=;
	h=Date:To:From:Subject:Message-Id; b=iq4R3YRlYG2UdMbn96UNrM331nNeDdRFviT1A9Un468qyK4S3jXnQDeXDgM0Owoh/5TNNX31VqLm98v3ZHvIU3Uz7zU/fAgH62Tp0YPTLKBfk2aHTYkC2pKKBpbFwOim8gwrCS7xWUcf74KevPcRjllkkbtRv65chGQIof86VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ifibh9L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7757CC2BCAF;
	Sun, 26 Apr 2026 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777216639;
	bh=Hyx1AOMdihp+Z0kWFQXE3e1vVswR/Lkb7DNRI/bRAWs=;
	h=Date:To:From:Subject:From;
	b=ifibh9L3gXb1pLC4sOkrIHMrbbPxiXRLprGVo5ZG+zcqFuqjp9kfsR6eRLAZopMPq
	 L4WT4tVj162APGpDRQY/ZxEiB/7KPk+ynL1VPw358C0bQM5Vc+ygBPmsP6LB0CjeXV
	 RElNAPltzTgUBNA100kA4F0ftstZboeugQLy92sU=
Date: Sun, 26 Apr 2026 08:17:18 -0700
To: mm-commits@vger.kernel.org,vishal.l.verma@intel.com,stable@vger.kernel.org,rafael@kernel.org,osalvador@suse.de,nao.horiguchi@gmail.com,linmiaohe@huawei.com,huang.ying.caritas@gmail.com,gregkh@linuxfoundation.org,david@kernel.org,dakr@kernel.org,songmuchun@bytedance.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-memory_hotplug-fix-memory-block-reference-leak-on-remove.patch added to mm-hotfixes-unstable branch
Message-Id: <20260426151719.7757CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3F9D746A7BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241175-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,kernel.org,suse.de,gmail.com,huawei.com,linuxfoundation.org,bytedance.com,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch titled
     Subject: mm/memory_hotplug: fix memory block reference leak on remove
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-memory_hotplug-fix-memory-block-reference-leak-on-remove.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-memory_hotplug-fix-memory-block-reference-leak-on-remove.patch

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
From: Muchun Song <songmuchun@bytedance.com>
Subject: mm/memory_hotplug: fix memory block reference leak on remove
Date: Sun, 26 Apr 2026 22:44:46 +0800

remove_memory_blocks_and_altmaps() looks up each memory block with
find_memory_block(), which acquires a reference to the memory block
device.

That reference is never dropped on this path, resulting in a leaked device
reference when removing memory blocks and their altmaps.  Drop the
reference after retrieving mem->altmap and clearing mem->altmap, before
removing the memory block device.

Link: https://lore.kernel.org/20260426144447.817722-1-songmuchun@bytedance.com
Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Huang, Ying" <huang.ying.caritas@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory_hotplug.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/memory_hotplug.c~mm-memory_hotplug-fix-memory-block-reference-leak-on-remove
+++ a/mm/memory_hotplug.c
@@ -1422,6 +1422,7 @@ static void remove_memory_blocks_and_alt
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
+		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 
_

Patches currently in -mm which might be from songmuchun@bytedance.com are

mm-memory_hotplug-fix-memory-block-reference-leak-on-remove.patch
drivers-base-memory-fix-memory-block-reference-leak-in-poison-accounting.patch
mm-sparse-remove-sparse-buffer-pre-allocation-mechanism.patch



Return-Path: <stable+bounces-270305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WEsCQDHRWoLFAsAu9opvQ
	(envelope-from <stable+bounces-270305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5106F2ECD
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=F8KjRdsl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270305-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270305-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2828E303901E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C50274641;
	Thu,  2 Jul 2026 02:03:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C592877DE;
	Thu,  2 Jul 2026 02:03:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957811; cv=none; b=khv6+q6ZRql5VR89n2ykFeTOh/dxLjs7oo20SU+qnjvLvo6Y/rxY00p+lq3Cr3Fh8jNR5O4WQO+OJnaAEgR8MLqXItF/k5C2vYmRE0OehRwKSUs8/9Jb1nYcBdiv2/xRWDXtXuiC5a9MYvLDPC0Ts+xDz44ynuCJKuCOOBw9bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957811; c=relaxed/simple;
	bh=40937JmfOOx0ITyEbxAvn2IZ2HimuLZXq8xjifaB8tw=;
	h=Date:To:From:Subject:Message-Id; b=ZtON+ZZHC61MADjB1gHJ97tAGvkuOaNWCFg0on2AiNUxp3+fFpSFSkW6rfyfcGxcd7V4Hxf7l/O5gdTXtiXEQt1UR5WtK9PjD0UTa1sEqYqz3X2dTqoo7m0PEAmZccVInOMVCGlVhLYhBEvFuGlPlyQ3f7a+1v5EPTbsTUuiJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F8KjRdsl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420D1F000E9;
	Thu,  2 Jul 2026 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782957810;
	bh=OzDDJLfNQJqIZ+/UPIJwNmxg+HcPnudLRuKNgfoDILA=;
	h=Date:To:From:Subject;
	b=F8KjRdsltdufbjsc/zrxZLZkq/uTl8rhBs9aIJcp8piXGaJ+A/okogFnXaJjf6D9d
	 pBf3SpkVSJyxj1iQsOjX/XC1Qh4VIAPEYSlI4wprGcCeeTfjJHPy4cCp7NMnD+NH5w
	 Hejns3yndpx0ez2jdro6AdOXca8IY0m0dTfwafCs=
Date: Wed, 01 Jul 2026 19:03:29 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,roman.gushchin@linux.dev,muchun.song@linux.dev,david@fromorbit.com,zhengqi.arch@bytedance.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-shrinker-fix-null-pointer-dereference-in-debugfs.patch removed from -mm tree
Message-Id: <20260702020329.F420D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270305-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:david@fromorbit.com,m:zhengqi.arch@bytedance.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,linux.dev:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA5106F2ECD


The quilt patch titled
     Subject: mm: shrinker: fix NULL pointer dereference in debugfs
has been removed from the -mm tree.  Its filename was
     mm-shrinker-fix-null-pointer-dereference-in-debugfs.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: mm: shrinker: fix NULL pointer dereference in debugfs
Date: Wed, 17 Jun 2026 17:00:52 +0800

shrinker_debugfs_add() creates both "count" and "scan" debugfs files
unconditionally.

That assumes every shrinker implements both count_objects() and
scan_objects(), which is not guaranteed.  For example, the xen-backend
shrinker sets count_objects() but leaves scan_objects() NULL, so writing
to its scan file calls through a NULL function pointer and panics the
kernel:

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
Call Trace:
 <TASK>
 shrinker_debugfs_scan_write+0x12e/0x270
 full_proxy_write+0x5f/0x90
 vfs_write+0xde/0x420
 ? filp_flush+0x75/0x90
 ? filp_close+0x1d/0x30
 ? do_dup2+0xb8/0x120
 ksys_write+0x68/0xf0
 ? filp_flush+0x75/0x90
 do_syscall_64+0xb3/0x5b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The count path has the same issue in principle if a shrinker omits
count_objects().

To fix it, only create "count" and "scan" debugfs files when the
corresponding callbacks are present.

Link: https://lore.kernel.org/20260617090052.27325-1-qi.zheng@linux.dev
Fixes: bbf535fd6f06 ("mm: shrinkers: add scan interface for shrinker debugfs")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shrinker_debug.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/mm/shrinker_debug.c~mm-shrinker-fix-null-pointer-dereference-in-debugfs
+++ a/mm/shrinker_debug.c
@@ -183,10 +183,12 @@ int shrinker_debugfs_add(struct shrinker
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0440, entry, shrinker,
-			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0220, entry, shrinker,
-			    &shrinker_debugfs_scan_fops);
+	if (shrinker->count_objects)
+		debugfs_create_file("count", 0440, entry, shrinker,
+				    &shrinker_debugfs_count_fops);
+	if (shrinker->scan_objects)
+		debugfs_create_file("scan", 0220, entry, shrinker,
+				    &shrinker_debugfs_scan_fops);
 	return 0;
 }
 
_

Patches currently in -mm which might be from zhengqi.arch@bytedance.com are




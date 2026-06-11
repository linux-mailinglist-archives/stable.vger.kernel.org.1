Return-Path: <stable+bounces-262780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1VwaLPvrKmrfzQMAu9opvQ
	(envelope-from <stable+bounces-262780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F3673E00
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=l5Y6gYkp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262780-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262780-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C8B1305B32F
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DE3D9672;
	Thu, 11 Jun 2026 16:48:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001E317145;
	Thu, 11 Jun 2026 16:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196518; cv=none; b=RbuwpTSIWZo5cbA57IKuWurp9k3y6HILyYGVgA9iwGcReNRrihazK432B/CZGCdgNvxKpqAgy/rXHzFHO9p5rzmVT4h3BrOi/lcCGaspStuxSRLg/njf+RvxmEmxUJNnRUVcTixfQ3qOxrW0UczeUjb2qwJQq2616jP8pa1FJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196518; c=relaxed/simple;
	bh=rBJ9afOA/bVjFNjhNE0EjYjuArt/4EBnlHJ19qvrP7c=;
	h=Date:To:From:Subject:Message-Id; b=mpuVV9kNVhFXGGouPh4X0JYCC5Cje81eL8i3MbqX1NPI9bVhmjb95ymSeqDx9fN/uDBqpioIZf5xAEDbyuvzsS0TCLw6y6whI9aRFbM0Dq9Club98RfX8ZcJOoQDy3wwZvacoX6GGVl6b+I8LI3nMyhEFq7xgzXMPY6JkwYk6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l5Y6gYkp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6C71F00893;
	Thu, 11 Jun 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781196516;
	bh=CDA8w4OtKvS5XoTW+gbDG90BRFfFcRfr3ZoME+3PPpw=;
	h=Date:To:From:Subject;
	b=l5Y6gYkpPKgNq+9b70QQvtP6gzRuFiYQWXTd/cNrvShwSBYlBVL1Rh5L3wEBNsq9b
	 Pll5LPDq/vjLqyZrMReI14RurmllmeFsohqiUaNbFCeC+rdpEImN9h7mYKScCniTPQ
	 G8TS0yOI3gJTv2nqLa62I56/PiwI3V69tdUuTLDs=
Date: Thu, 11 Jun 2026 09:48:36 -0700
To: mm-commits@vger.kernel.org,zenghui.yu@linux.dev,stable@vger.kernel.org,sj@kernel.org,roman.gushchin@linux.dev,qi.zheng@linux.dev,nphamcs@gmail.com,muchun.song@linux.dev,david@fromorbit.com,shakeel.butt@linux.dev,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-shrinker-do-not-hold-rcu-lock-in-shrinker_debugfs_count_show.patch added to mm-unstable branch
Message-Id: <20260611164836.6F6C71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:zenghui.yu@linux.dev,m:stable@vger.kernel.org,m:sj@kernel.org,m:roman.gushchin@linux.dev,m:qi.zheng@linux.dev,m:nphamcs@gmail.com,m:muchun.song@linux.dev,m:david@fromorbit.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262780-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.dev,kernel.org,gmail.com,fromorbit.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,fromorbit.com:email,linux.dev:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D6F3673E00


The patch titled
     Subject: mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()
has been added to the -mm mm-unstable branch.  Its filename is
     mm-shrinker-do-not-hold-rcu-lock-in-shrinker_debugfs_count_show.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-shrinker-do-not-hold-rcu-lock-in-shrinker_debugfs_count_show.patch

This patch will later appear in the mm-unstable branch at
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
From: Shakeel Butt <shakeel.butt@linux.dev>
Subject: mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()
Date: Wed, 10 Jun 2026 16:20:48 -0700

Reading the debugfs "count" file of a memcg-aware shrinker can sleep
inside an RCU read-side critical section:

  BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:421
  RCU nest depth: 1, expected: 0
   css_rstat_flush
   mem_cgroup_flush_stats
   zswap_shrinker_count
   shrinker_debugfs_count_show

shrinker_debugfs_count_show() invokes the ->count_objects() callback under
rcu_read_lock().  The zswap callback flushes memcg stats via
css_rstat_flush(), which may sleep, so it must not run under RCU.

The RCU lock is not needed here.  mem_cgroup_iter() takes RCU internally
and returns a memcg holding a css reference (dropped on the next iteration
or by mem_cgroup_iter_break()), so the memcg stays alive without it.  The
shrinker is kept alive by the open debugfs file: shrinker_free() removes
the debugfs entries via debugfs_remove_recursive(), which waits for
in-flight readers to drain, before call_rcu(..., shrinker_free_rcu_cb). 
The sibling "scan" handler already invokes the sleeping ->scan_objects()
callback with no RCU section.

Drop the rcu_read_lock()/rcu_read_unlock().

Link: https://lore.kernel.org/20260610232048.62930-1-shakeel.butt@linux.dev
Fixes: 5035ebc644ae ("mm: shrinkers: introduce debugfs interface for memory shrinkers")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Closes: https://lore.kernel.org/all/c052a064-cddb-494f-a0d8-f8a10b4b1c4d@linux.dev/
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
Tested-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shrinker_debug.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/mm/shrinker_debug.c~mm-shrinker-do-not-hold-rcu-lock-in-shrinker_debugfs_count_show
+++ a/mm/shrinker_debug.c
@@ -57,8 +57,6 @@ static int shrinker_debugfs_count_show(s
 	if (!count_per_node)
 		return -ENOMEM;
 
-	rcu_read_lock();
-
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
@@ -88,8 +86,6 @@ static int shrinker_debugfs_count_show(s
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-
 	kfree(count_per_node);
 	return ret;
 }
_

Patches currently in -mm which might be from shakeel.butt@linux.dev are

mm-shrinker-do-not-hold-rcu-lock-in-shrinker_debugfs_count_show.patch



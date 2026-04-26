Return-Path: <stable+bounces-241180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LOJLBFV7mmOsQAAu9opvQ
	(envelope-from <stable+bounces-241180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4246ABB8
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0C83012EAF
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15992299A84;
	Sun, 26 Apr 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rQ1mMg/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A2257ACF;
	Sun, 26 Apr 2026 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777227019; cv=none; b=FRL2ldQ6eTysUeL97rEtkkVcGeBu6MKlBrxU8qvarQasA41ucGmLza3UgDxtBCm1DjZUzgugmo+q28/jPESiUDtv0cOnJZErcssmYctGCIGgTdYpczIkhsCF9UweddqToi+yqDu2Op23B7X1X/UifrlxmhcydR3ePhwvrPiZXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777227019; c=relaxed/simple;
	bh=MFfB5lAxYmqbSowORzHQ3YeRtMHgWMFcHW8osSTHS2c=;
	h=Date:To:From:Subject:Message-Id; b=e7kY3BSEmnwoXmthLW+VQH58kcpmFoNJnqABcxixIy79VDY9VlR8iGq9A3+IVZc8lBT1XYqltSor7bGjD2/tEsflrjeVHGYp3mW5VbN1bxtNfcyt3vUGYTSdz57gt6q54wxWm8TaJw0N7F7nsAm2eS+Q9CEKT3EYka4WrEGBY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rQ1mMg/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67112C2BCAF;
	Sun, 26 Apr 2026 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777227019;
	bh=MFfB5lAxYmqbSowORzHQ3YeRtMHgWMFcHW8osSTHS2c=;
	h=Date:To:From:Subject:From;
	b=rQ1mMg/UzC28ninoBBz1cHfhsk9KxZidzRjQxbtYMHXnSpAir6V0ZRnYOZN09AfHr
	 PywzNUZ+3silnAM/AkPlpX4oHca0kk6ysq1u8MGBmlR+K6zi38qWHxN2f/7iwLGkUc
	 LeMPm3KANzkRBP8swYfFnQ9YrKx5kpm0F+AN1af8=
Date: Sun, 26 Apr 2026 11:10:18 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break.patch added to mm-hotfixes-unstable branch
Message-Id: <20260426181019.67112C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 94B4246ABB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch titled
     Subject: mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break.patch

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
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()
Date: Sun, 26 Apr 2026 10:36:12 -0700

damon_sysfs_memcg_path_to_id() breaks mem_cgroup_iter() loop without
calling mem_cgroup_iter_break().  This leaks the cgroup reference.  Fix
the issue by calling mem_cgroup_iter_break() before the break.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260426173625.86521-1-sj@kernel.org
Link: https://lore.kernel.org/20260423004148.74722-1-sj@kernel.org [1]
Fixes: 29cbb9a13f05 ("mm/damon/sysfs-schemes: implement scheme filters")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs-schemes.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/damon/sysfs-schemes.c~mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break
+++ a/mm/damon/sysfs-schemes.c
@@ -2594,6 +2594,7 @@ static int damon_sysfs_memcg_path_to_id(
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
 			*id = mem_cgroup_id(memcg);
 			found = true;
+			mem_cgroup_iter_break(NULL, memcg);
 			break;
 		}
 	}
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock.patch
mm-damon-sysfs-schemes-protect-path-kfree-with-damon_sysfs_lock.patch
mm-damon-reclaim-detect-and-use-fresh-enabled-and-kdamond_pid-values.patch
mm-damon-lru_sort-detect-and-use-fresh-enabled-and-kdamond_pid-values.patch
mm-damon-stat-detect-and-use-fresh-enabled-value.patch
mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break.patch
docs-mm-damon-maintainer-profile-add-ai-review-usage-guideline.patch



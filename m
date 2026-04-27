Return-Path: <stable+bounces-241313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IYwLYxd72npAgEAu9opvQ
	(envelope-from <stable+bounces-241313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C5473015
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 367FE3030987
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5553BADA3;
	Mon, 27 Apr 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L87djBdd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E43BAD89;
	Mon, 27 Apr 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294518; cv=none; b=sAmufvZrrqZwhvA27yRxwZ4s2fgmBQXqxe3LTR+lMgDmUyM531WYYLYYLZFB/171UF31NKpGewzoRrtRc2HrhRTMxZPIkvrn1kW+bEsbFo0mMkAQLbvEKjluHdlYFFa2pm5OIfSPqSmZHvtuHz98WFMyoGbW9+G7PLDFeAlI5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294518; c=relaxed/simple;
	bh=3n0DybhkH3Qj2l+bOmqurTXypgpNhSz77HdXoR7+YWw=;
	h=Date:To:From:Subject:Message-Id; b=W+1lbyATjmlSHUsuy3SbCyYmLEhvHsfNzmYroUxq4oj3+SsdOfk/K/WgbWl4dsok9x4E7jvIPLZKrTyP0xOhpevWBjkpUFe0nyq4iz5/1Ty+4UWrpo+KJW6OFP8I/mH5s1A5MbGItOsY9PNQkuY3SqA2EC6lQKVFpARn/u1/zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L87djBdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95CAC19425;
	Mon, 27 Apr 2026 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777294517;
	bh=3n0DybhkH3Qj2l+bOmqurTXypgpNhSz77HdXoR7+YWw=;
	h=Date:To:From:Subject:From;
	b=L87djBdd9nol9VCPoiEBmTxYFgg0NzQJPpAcCBT/FVlX806jHiwxnOojNt3LwN1H/
	 WNjSdDruZ3Z/roz2HL6V7oF/8qC+xFaW07flxqPWWCcZouCTMB+natYxFkP0ab9C9v
	 0x1HKcRQwdb3oB2KDa2f9Ynn7I1tjCJtIzFMQXhA=
Date: Mon, 27 Apr 2026 05:55:17 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,qjx1298677004@gmail.com,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-sysfs-schemes-protect-path-kfree-with-damon_sysfs_lock.patch removed from -mm tree
Message-Id: <20260427125517.A95CAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 298C5473015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The quilt patch titled
     Subject: mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
has been removed from the -mm tree.  Its filename was
     mm-damon-sysfs-schemes-protect-path-kfree-with-damon_sysfs_lock.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Thu, 23 Apr 2026 08:02:52 -0700

damon_sysfs_quot_goal->path can be read and written by users, via DAMON
sysfs 'path' file.  It can also be indirectly read, for the parameters
{on,off}line committing to DAMON.  The reads for parameters committing are
protected by damon_sysfs_lock to avoid the sysfs files being destroyed
while any of the parameters are being read.  But the user-driven direct
reads and writes are not protected by any lock, while the write is
deallocating the path-pointing buffer.  As a result, the readers could
read the already freed buffer (user-after-free).  Note that the user-reads
don't race when the same open file is used by the writer, due to kernfs's
open file locking.  Nonetheless, doing the reads and writes with separate
open files would be common.  Fix it by protecting both the user-direct
reads and writes with damon_sysfs_lock.

Link: https://lore.kernel.org/20260423150253.111520-3-sj@kernel.org
Fixes: c41e253a411e ("mm/damon/sysfs-schemes: implement path file under quota goal directory")
Co-developed-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs-schemes.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/mm/damon/sysfs-schemes.c~mm-damon-sysfs-schemes-protect-path-kfree-with-damon_sysfs_lock
+++ a/mm/damon/sysfs-schemes.c
@@ -1197,8 +1197,13 @@ static ssize_t path_show(struct kobject
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t path_store(struct kobject *kobj,
@@ -1213,8 +1218,13 @@ static ssize_t path_store(struct kobject
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(goal->path);
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-schemes-call-missing-mem_cgroup_iter_break.patch
mm-damon-fix-damos_stat-tracepoint-format-for-sz_applied.patch
docs-mm-damon-maintainer-profile-add-ai-review-usage-guideline.patch



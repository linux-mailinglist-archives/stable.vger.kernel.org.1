Return-Path: <stable+bounces-240517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG3fHqVD6mnqxQIAu9opvQ
	(envelope-from <stable+bounces-240517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3B454A4D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27D5830066B3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B837189C;
	Thu, 23 Apr 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M+vziTcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2636E49B;
	Thu, 23 Apr 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960416; cv=none; b=mPv5fxOU7R/8w/Hv9PikBgD/jEtd1xTiF9WivgNMz8f7SdnRvt22vEMsGJ+ZvDiJRSHpA3QPRBgetpUbjP/Qz+4hk0aeW40A7D3qESMCka6EnZHuRO4c+usHh9q7uV+VSXgqGTeDdJidgK8s2Dy/onfflC5q0390U7dW3+VU4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960416; c=relaxed/simple;
	bh=jekviPKoMgyVejEhUzk4nUdDKXHzwhm+kbW7Sfmm5t8=;
	h=Date:To:From:Subject:Message-Id; b=TnpfBMYL+kr4bj+SSWdD5hN4MMAC4y4TtDcY9M1QiMXMPMeVIB43F/Obns91j4ajfhaKgLNc/mLEQ9ki/DOZW4cMsRRrvp2Lc+PTVoXa9GFbdTTWC6S9McZVv3FFqHKbTta3wdZFZftBv47qyteWhR5swB+vnd4wg1cxmFPoXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M+vziTcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE1BC2BCB4;
	Thu, 23 Apr 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776960416;
	bh=jekviPKoMgyVejEhUzk4nUdDKXHzwhm+kbW7Sfmm5t8=;
	h=Date:To:From:Subject:From;
	b=M+vziTcnPJCSVrTGmlR2G4MiPMuFZ32dVyYNI5y6OmSOvmGUTXZCHUjIe+zK40PVs
	 rO8PJUqn6S2l9AJyPZSLGtqt86fPGLkhzps/1omPkyZrTxfp6R7/RKKCylB2bBvL/X
	 nCS1uaATveAUW4Ylwe7pYW2rkDT/I4rQ/GjR3MOM=
Date: Thu, 23 Apr 2026 09:06:55 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,qjx1298677004@gmail.com,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock.patch added to mm-hotfixes-unstable branch
Message-Id: <20260423160656.6BE1BC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240517-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 09C3B454A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock.patch

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
Subject: mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
Date: Thu, 23 Apr 2026 08:02:51 -0700

Patch series "mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path".

Reads of 'memcg_path' and 'path' files in DAMON sysfs interface could race
with their writes, results in use-after-free.  Fix those.


This patch (of 2):

damon_sysfs_scheme_filter->mmecg_path can be read and written by users,
via DAMON sysfs memcg_path file.  It can also be indirectly read, for the
parameters {on,off}line committing to DAMON.  The reads for parameters
committing are protected by damon_sysfs_lock to avoid the sysfs files
being destroyed while any of the parameters are being read.  But the
user-driven direct reads and writes are not protected by any lock, while
the write is deallocating the memcg_path-pointing buffer.  As a result,
the readers could read the already freed buffer (user-after-free).  Note
that the user-reads don't race when the same open file is used by the
writer, due to kernfs's open file locking.  Nonetheless, doing the reads
and writes with separate open files would be common.  Fix it by protecting
both the user-direct reads and writes with damon_sysfs_lock.

Link: https://lore.kernel.org/20260423150253.111520-1-sj@kernel.org
Link: https://lore.kernel.org/20260423150253.111520-2-sj@kernel.org
Fixes: 4f489fe6afb3 ("mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write")
Co-developed-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs-schemes.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/mm/damon/sysfs-schemes.c~mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock
+++ a/mm/damon/sysfs-schemes.c
@@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct ko
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n",
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n",
 			filter->memcg_path ? filter->memcg_path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t memcg_path_store(struct kobject *kobj,
@@ -550,8 +555,13 @@ static ssize_t memcg_path_store(struct k
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(filter->memcg_path);
 	filter->memcg_path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-schemes-protect-memcg_path-kfree-with-damon_sysfs_lock.patch
mm-damon-sysfs-schemes-protect-path-kfree-with-damon_sysfs_lock.patch



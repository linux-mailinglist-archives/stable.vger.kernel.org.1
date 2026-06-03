Return-Path: <stable+bounces-260207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wGD4Gxa5IGqr7AAAu9opvQ
	(envelope-from <stable+bounces-260207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:30:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A8663BDC9
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=axqAcJ16;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260207-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260207-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4454300820D
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF694A138B;
	Wed,  3 Jun 2026 23:26:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB563328FA;
	Wed,  3 Jun 2026 23:26:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529183; cv=none; b=AIZT/k0tzD4a535Xg8FZLXMzqjzEFifgtfosg/hM5bkImJjoULF6eEjKwjbIcVvKvuceK5RQwvHX1eAdgxYLEBds0BCDxCXOu+1ztivLGEwVtVLTNUAJroIV9Riyytx9K8nMppS9k7CEiW5j9BYNcncDgQJs1EkItWu6JzDxyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529183; c=relaxed/simple;
	bh=BDizDcnfvDeAD3OjRv6YP879+woxJL60sXILJVdd3jc=;
	h=Date:To:From:Subject:Message-Id; b=aQRbZi84RZNybFRML5R+o1qvujss5Yll6PR2XPA93AViEvCVXwbBGQZFy/c0VHsMW50dkGrTKxvwV9FwSGW38ltT7U6aDQgf0lvYk0wvl2Yls5IJI0ZHJXbPEsb3EqwxChQhHKVlQ48Ju1AklxS/5C18XSH1tnracbuE/2Wpjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=axqAcJ16; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997DA1F00893;
	Wed,  3 Jun 2026 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780529181;
	bh=vEgT73UytRP8pvRdIZ5COzDiisSo9MqChk1i0IHZ5xY=;
	h=Date:To:From:Subject;
	b=axqAcJ16W9V+/VsybGU+VBthwhqEvnYO2MVX7wSyJUWDNqTvuJRhCaM8dO7prlS5m
	 4AxzLTHjCT2fmBQ2rBFzc0dMsF/GzUyrIFe65QL+th61DhGu8c2QFOMTngbe+/0UxA
	 lF8m+yXBu4YFFmv6oet5YveFIfmUqhE0LT6drxbA=
Date: Wed, 03 Jun 2026 16:26:21 -0700
To: mm-commits@vger.kernel.org,yuantan098@gmail.com,yifanwucs@gmail.com,tomapufckgml@gmail.com,stable@vger.kernel.org,sergeh@kernel.org,serge@hallyn.com,segoon@openwall.com,oleg@redhat.com,n05ec@lzu.edu.cn,ljs@kernel.org,liam@infradead.org,kees@kernel.org,dave@stgolabs.net,brauner@kernel.org,bird@lzu.edu.cn,aha310510@gmail.com,zylzyl2333@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] ipc-shm-serialize-orphan-cleanup-with-shm_nattch-updates.patch removed from -mm tree
Message-Id: <20260603232621.997DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:stable@vger.kernel.org,m:sergeh@kernel.org,m:serge@hallyn.com,m:segoon@openwall.com,m:oleg@redhat.com,m:n05ec@lzu.edu.cn,m:ljs@kernel.org,m:liam@infradead.org,m:kees@kernel.org,m:dave@stgolabs.net,m:brauner@kernel.org,m:bird@lzu.edu.cn,m:aha310510@gmail.com,m:zylzyl2333@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,hallyn.com,openwall.com,redhat.com,lzu.edu.cn,infradead.org,stgolabs.net,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260207-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1A8663BDC9


The quilt patch titled
     Subject: ipc/shm: serialize orphan cleanup with shm_nattch updates
has been removed from the -mm tree.  Its filename was
     ipc-shm-serialize-orphan-cleanup-with-shm_nattch-updates.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yilin Zhu <zylzyl2333@gmail.com>
Subject: ipc/shm: serialize orphan cleanup with shm_nattch updates
Date: Thu, 30 Apr 2026 13:21:34 +0800

shm_destroy_orphaned() walks the shm idr under shm_ids(ns).rwsem, but that
does not serialize all fields tested by shm_may_destroy().  In particular,
shm_nattch is updated while holding shm_perm.lock, and attach paths can do
that without holding the rwsem.

Do not decide that an orphaned segment is unused before taking the object
lock.  Move the shm_may_destroy() check under shm_perm.lock, matching the
other destroy paths, and unlock the segment when it no longer qualifies
for removal.

Link: https://lore.kernel.org/9d97cc1031de2d0bace0edf3a668818aa2f4eca6.1777410234.git.zylzyl2333@gmail.com
Fixes: 4c677e2eefdb ("shm: optimize locking and ipc_namespace getting")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeongjun Park <aha310510@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Liam Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Serge Hallyn <sergeh@kernel.org>
Cc: Vasiliy Kulikov <segoon@openwall.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 ipc/shm.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/ipc/shm.c~ipc-shm-serialize-orphan-cleanup-with-shm_nattch-updates
+++ a/ipc/shm.c
@@ -418,15 +418,17 @@ static int shm_try_destroy_orphaned(int
 	 * We want to destroy segments without users and with already
 	 * exit'ed originating process.
 	 *
-	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
+	 * shm_nattch can be changed under shm_perm.lock without holding the
+	 * rwsem, so take the object lock before checking shm_may_destroy().
 	 */
 	if (!list_empty(&shp->shm_clist))
 		return 0;
 
-	if (shm_may_destroy(shp)) {
-		shm_lock_by_ptr(shp);
+	shm_lock_by_ptr(shp);
+	if (shm_may_destroy(shp))
 		shm_destroy(ns, shp);
-	}
+	else
+		shm_unlock(shp);
 	return 0;
 }
 
_

Patches currently in -mm which might be from zylzyl2333@gmail.com are




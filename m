Return-Path: <stable+bounces-266052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pN4zKpCVMWq8nQUAu9opvQ
	(envelope-from <stable+bounces-266052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E8694223
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Pwv1etSv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266052-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266052-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3FAA301A585
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91D47AF6E;
	Tue, 16 Jun 2026 18:26:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451A3D810C;
	Tue, 16 Jun 2026 18:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634409; cv=none; b=YA7ckwR0zb2Uh8tcm/s75TtDlP9W47/1jz5HwCZHYL/QGmJNIufeD6nS9Qp55mALwx3QmDKOsQ0Cp2aV4ddHI6k8A4jdtJpQXhlI8ojZzZWK1k88/fIa0cZmePU8xwsGSy4MrA8vhY7a5a/b9BQr6mtd1IuR9na+lQ30uzeiIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634409; c=relaxed/simple;
	bh=9D5nKbM5MpZYs9kzOIv94Uaw+0O70LygcJTCH4DcRHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFbgC2XFSWyL6W3eeU0qce9Cg+cNO1Kf8qXVmp6BEa1o09vLGfcnLo7g9aeK9+Rmh6LmHT0acEkeY/3YQ2mEzNlcw2HfA+WXMpLv+f7RMRvspAHJx3pBRZ9HwOu13iU98e1Hi8QMHLgLl5De2/oPu+5q2v1UvXQ/66zrQGWKICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pwv1etSv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADAC1F000E9;
	Tue, 16 Jun 2026 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634408;
	bh=Wq1REARUcGdOYf45/07K2wpwBnllS0gcyhsi/4d1Hqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pwv1etSvbhO+vw97az5VkvdzxWzF/YtAW/NVPI6eQQDv4dlA/aufpWyjpjW+mdOQG
	 jVuggs4p/zf6MP1jgfSZYRzXpervzXBCzcE4Hhf8QQ2BO5UJzgOaujhj4hkszTgnoW
	 fBBYrSalvyA4HCDRV96Pb4bTeaGlKPAYQd2DTLAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yilin Zhu <zylzyl2333@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Christian Brauner <brauner@kernel.org>,
	Jeongjun Park <aha310510@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Liam Howlett <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	Vasiliy Kulikov <segoon@openwall.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Serge Hallyn <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 226/411] ipc/shm: serialize orphan cleanup with shm_nattch updates
Date: Tue, 16 Jun 2026 20:27:44 +0530
Message-ID: <20260616145112.819120223@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-266052-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:zylzyl2333@gmail.com,m:n05ec@lzu.edu.cn,m:brauner@kernel.org,m:aha310510@gmail.com,m:kees@kernel.org,m:liam@infradead.org,m:ljs@kernel.org,m:sergeh@kernel.org,m:segoon@openwall.com,m:dave@stgolabs.net,m:oleg@redhat.com,m:serge@hallyn.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,kernel.org,infradead.org,openwall.com,stgolabs.net,redhat.com,hallyn.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA8E8694223

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yilin Zhu <zylzyl2333@gmail.com>

commit 2e5c6f4fd4001562781e99bbfc7f1f0127187542 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 ipc/shm.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -402,15 +402,17 @@ static int shm_try_destroy_orphaned(int
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
 




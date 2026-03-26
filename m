Return-Path: <stable+bounces-230425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAuYKEPVxGnk4AQAu9opvQ
	(envelope-from <stable+bounces-230425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:42:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A632FFD6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D211530117A8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A0133B976;
	Thu, 26 Mar 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jZMnFiA8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915933C182;
	Thu, 26 Mar 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506883; cv=none; b=C/rfIxZtnr6EXv75p9KxUTE68iawgOTTQWumzWYiC0HJFiRe5pFUnjBlYwLdzFVJb3oOkSDt7jZx1/kNioKhdOtRzOjlDq33/Y4aklpYz47DzSHLsTMq9r58+LRziz/qxy8SPJiZaPmyvJSpp3ed/6gIedDWVGewV/rGGAzbiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506883; c=relaxed/simple;
	bh=WeG3BgIYf43JjAL2Eqp4TR6FooVAd2GkCPpbpep9Tj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F/tzd+beqXjXKLoMTdgqzNJH9VrZQkvfcFmJvJpHkJ9TN5gFskDl27gGADRhVtcUQmoHEJ+fnlvi6WnuTbr4jPHgTARluB/rZHIGninAVyld5zRD2IvQW56ausNrGqai5wrZKojsvq2rMi6KexXCj/QdV2Ph2Fj364Rfrk0eer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jZMnFiA8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=br
	2CzzU5BQx5QzYEAP5urCfEIhDnDOmvxCJwRdGsIHY=; b=jZMnFiA82Lk3RO9ctJ
	acttuIxHoGB1id0Km6oRkjkVqwtYuPxMwpKyy1lmuyxQFKC2ip3jWjeartD2Xfkg
	V32qcNvSI19/28RVH8CZNhqWqIw5txHchNAbnzsZYo0bEH+OeUQ7FiwoEY9c2+2E
	GfswhUcNgGUyIcog8cuXjO104=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHSENz08RpGpkRBg--.5815S2;
	Thu, 26 Mar 2026 14:34:28 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Price <anprice@redhat.com>,
	Robert Garcia <rob_garcia@163.com>,
	Bob Peterson <rpeterso@redhat.com>,
	cluster-devel@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] gfs2: Fix unlikely race in gdlm_put_lock
Date: Thu, 26 Mar 2026 14:34:27 +0800
Message-Id: <20260326063427.1771116-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHSENz08RpGpkRBg--.5815S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4kJFyDur1ftrWfAr1kXwb_yoW8Wr4rpF
	yv9w1fuFsrXF4jga1DCFsa9F109wsYg34akrn5J3W3ZF4qqrnaqrykt348GF4Y9rWxXFW5
	u3W5Krs3ur9xJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE5Ef-UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5hSdCWnE03SdAAAA3x
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230425-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,163.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 226A632FFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 28c4d9bc0708956c1a736a9e49fee71b65deee81 ]

In gdlm_put_lock(), there is a small window of time in which the
DFL_UNMOUNT flag has been set but the lockspace hasn't been released,
yet.  In that window, dlm may still call gdlm_ast() and gdlm_bast().
To prevent it from dereferencing freed glock objects, only free the
glock if the lockspace has actually been released.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andrew Price <anprice@redhat.com>
[ Minor context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/gfs2/lock_dlm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 588760c1a5da..4f44173e8a36 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -301,11 +301,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
 
-	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-		gfs2_glock_free(gl);
-		return;
-	}
 	/* don't want to skip dlm_unlock writing the lvb when lock has one */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
@@ -322,6 +317,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		goto again;
 	}
 
+	if (error == -ENODEV) {
+		gfs2_glock_free(gl);
+		return;
+	}
+
 	if (error) {
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
 		       gl->gl_name.ln_type,
-- 
2.34.1



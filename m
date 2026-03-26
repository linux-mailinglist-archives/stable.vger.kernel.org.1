Return-Path: <stable+bounces-230434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFUnNE7oxGkz5AQAu9opvQ
	(envelope-from <stable+bounces-230434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:03:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AA330D0A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D902B30107D6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398727380A;
	Thu, 26 Mar 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hgF8eDy5"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80813D51E;
	Thu, 26 Mar 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512038; cv=none; b=ttCNtjEODrylg75SgZHeqYaOAL8oqxZkThBDFU1Fpat7/gYq6NEz9GSP3dvTf+vdgCj1NMvXGyaZMX5K/GcY9Xp9m4ImJBgOTzO3aziUPMcT9hTHX4cdox1xHc0NpiYIqiY+uUovNq1MgDVFkAOYq1yxwvDoVl4+hdCorwhsZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512038; c=relaxed/simple;
	bh=NO4rlatfGBTdpaO7MlUZ3MfiKH48GJdoeAy/KlWq+lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+liPWFjSotJrOo6H6lRnFeI4s+wTYRObXCGXJf4eEDFMZDvEBytsNB5ruQVunkk5QXVVVyDF/DDEKP7nit61wgoTGdhlNIyjEvyPkOzJ+WPq/43ti5RPOZxY0QtUNzTxnydEx1CDW+Fu9lnS6ImIFuMUWWbpgyXOhtMPJjytrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hgF8eDy5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=li
	oyNmr8e6TH2UFLCMgF0JeFQ/KK5TLmcFWtOIEOQQc=; b=hgF8eDy5sUUOfAN4K2
	XmsWHMYAm2PBV8PHa/ZRydRqB/NFvWFB5N+qJr5X7vIkwmVyK24ay/SQswgcws8/
	ZpEEhOp6IfmieJGG8qc30n75ZtxBUA7fvoGzreVLyZOKTq3X9vSllfDp5n7VJMLF
	9t/hUJexlS7R9kpx7xECHhAAE=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f92X58RpL9bPBQ--.7003S2;
	Thu, 26 Mar 2026 16:00:25 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Price <anprice@redhat.com>,
	Robert Garcia <rob_garcia@163.com>,
	Bob Peterson <rpeterso@redhat.com>,
	cluster-devel@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] gfs2: Fix unlikely race in gdlm_put_lock
Date: Thu, 26 Mar 2026 16:00:23 +0800
Message-Id: <20260326080023.1708804-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f92X58RpL9bPBQ--.7003S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4kJFyDur1ftrWfAr1kXwb_yoW8Wr4rpF
	ykuw1S9anrXF40g3WkCFsa9w109wsYg34akrn5J3W3ZF4jqrnaqrykt348Gr45ZrWxJrW5
	u3WUKFsxCr9xJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEco2UUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAhmrF2nE55lTuAAA3f
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230434-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F0AA330D0A
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
index 07aac73377d8..a72ece097034 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -311,11 +311,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
 
-	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-		gfs2_glock_free(gl);
-		return;
-	}
 	/* don't want to skip dlm_unlock writing the lvb when lock has one */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
@@ -332,6 +327,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
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



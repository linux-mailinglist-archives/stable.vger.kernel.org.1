Return-Path: <stable+bounces-224619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG8tOe3FsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:31:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0825A594
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FBF7302B19B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA051C84C0;
	Wed, 11 Mar 2026 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bEtYeutl"
X-Original-To: stable@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F712B94
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192682; cv=none; b=X7C4ZGbjdR4SxO/2urSr309mOY00oVhK6Aju7kq98QOfQtui6U01b1JSWiWjWtr42++ACGpBFrf93s6IQJpj3XmngbP3dggBsj2qGWGtZW93d7BxxfBxwcbQXu51QhRfvp/+BvaZ2HzfmM1s0B+AlzC6MeJOc+QBC1JNdP6HSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192682; c=relaxed/simple;
	bh=obXKto37n/L3FLBUQ8Sr0RlkYYDpxNaLSDH+wQB8fZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SI2Zl4Pb+gSGKCVhBLpA6RQiF7jgu6jeBmcggZqltgpLaxVjgFl9qBkYpiWiu3+OjtNpbFlCYkZ+isWAjkrjxKTl14TZbxX5WddW5GZ5PBuORJonsQkM+jRLIlim3Am3ePnXLasIFK5LwOlxG4RuRmdHYEyiLKiqE6XqcHFyuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bEtYeutl; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773192678;
	bh=6efkKjyNncn7ppuQo9a9SLPgx8BI4vtUOGh0D4MbxXM=;
	h=From:Subject:Date:Message-Id;
	b=bEtYeutlxgDsl8QLsKIdCIEpLaI3UWgOw5yA/Yihl70kHLDcOWWoqywQJCA+UDadi
	 aHNCFqcevVahhILvF3PY8Rov03k2ZhVAZSKr1Oxhp2uHlTIIfhJ+NS+p3eeWQ8UmRb
	 7TAXULcCr10NiGzkgapsobQe/jyiFpMxb39RtupE=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.24) with ESMTP
	id 69B0C5D70000071A; Wed, 11 Mar 2026 09:31:09 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 31962010748041
X-SMAIL-UIID: A30C3B3FF437409181705F69092C52FE-20260311-093109-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Chunjie Zhu <chunjie.zhu@cloud.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y] gfs2: No more self recovery
Date: Wed, 11 Mar 2026 09:31:01 +0800
Message-Id: <20260311013101.3006924-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BB0825A594
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[sina.com];
	TAGGED_FROM(0.00)[bounces-224619-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sina.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,cloud.com,sina.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit deb016c1669002e48c431d6fd32ea1c20ef41756 ]

When a node withdraws and it turns out that it is the only node that has
the filesystem mounted, gfs2 currently tries to replay the local journal
to bring the filesystem back into a consistent state.  Not only is that
a very bad idea, it has also never worked because gfs2_recover_func()
will refuse to do anything during a withdraw.

However, before even getting to this point, gfs2_recover_func()
dereferences sdp->sd_jdesc->jd_inode.  This was a use-after-free before
commit 04133b607a78 ("gfs2: Prevent double iput for journal on error")
and is a NULL pointer dereference since then.

Simply get rid of self recovery to fix that.

Fixes: 601ef0d52e96 ("gfs2: Force withdraw to replay journals and wait for it to finish")
Reported-by: Chunjie Zhu <chunjie.zhu@cloud.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[ The context change is due to the commit f80d882edcf2
("gfs2: Get rid of gfs2_glock_queue_put in signal_our_withdraw")
in v6.10 which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 fs/gfs2/util.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 30b8821c54ad..2a5a31b2cc22 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -244,32 +244,23 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	ret = gfs2_glock_nq(&sdp->sd_live_gh);
 
+	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
+	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
+
 	/*
 	 * If we actually got the "live" lock in EX mode, there are no other
-	 * nodes available to replay our journal. So we try to replay it
-	 * ourselves. We hold the "live" glock to prevent other mounters
-	 * during recovery, then just dequeue it and reacquire it in our
-	 * normal SH mode. Just in case the problem that caused us to
-	 * withdraw prevents us from recovering our journal (e.g. io errors
-	 * and such) we still check if the journal is clean before proceeding
-	 * but we may wait forever until another mounter does the recovery.
+	 * nodes available to replay our journal.
 	 */
 	if (ret == 0) {
-		fs_warn(sdp, "No other mounters found. Trying to recover our "
-			"own journal jid %d.\n", sdp->sd_lockstruct.ls_jid);
-		if (gfs2_recover_journal(sdp->sd_jdesc, 1))
-			fs_warn(sdp, "Unable to recover our journal jid %d.\n",
-				sdp->sd_lockstruct.ls_jid);
-		gfs2_glock_dq_wait(&sdp->sd_live_gh);
-		gfs2_holder_reinit(LM_ST_SHARED,
-				   LM_FLAG_NOEXP | GL_EXACT | GL_NOPID,
-				   &sdp->sd_live_gh);
-		gfs2_glock_nq(&sdp->sd_live_gh);
+		fs_warn(sdp, "No other mounters found.\n");
+		/*
+		 * We are about to release the lockspace.  By keeping live_gl
+		 * locked here, we ensure that the next mounter coming along
+		 * will be a "first" mounter which will perform recovery.
+		 */
+		goto skip_recovery;
 	}
 
-	gfs2_glock_queue_put(live_gl); /* drop extra reference we acquired */
-	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
-
 	/*
 	 * At this point our journal is evicted, so we need to get a new inode
 	 * for it. Once done, we need to call gfs2_find_jhead which
-- 
2.34.1



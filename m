Return-Path: <stable+bounces-214388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKgPEiEghGl9zQMAu9opvQ
	(envelope-from <stable+bounces-214388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 05:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4929EE908
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 05:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5117B3011BCA
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 04:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B22EB873;
	Thu,  5 Feb 2026 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Slq9P7Mx"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9D13D638;
	Thu,  5 Feb 2026 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770266652; cv=none; b=NYEsvTiXyvPxar8067/HNsIFfsRsvwWBlwUpY6MVL5w7cuxYhnOPuRRqY2U/cgclmfycP53HSdSCmOkM7rje/72VzjvgG6HSGxtmq+GKo9471QLiFVXMTIUZmquGQjA0XuZxnPi+AYoSW+SrI1iMEe8rBT0qIjgSIbxl6EFjpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770266652; c=relaxed/simple;
	bh=YRKqY4diyF8doqJDA4W4NazZaHGmEdCJXjkaWVD12eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5mQMkLAWv4NBhUOcaP+qLzh1UNdquRVah5q1WHyabjmA8KC5ilDM7r+m/agVC175A4v9zr0IKaA+BOA5dKFxqlQ0H9ih+XRYNLHcg0RSmpUShAM5t+xo8wNumMIo4NjD7JvwGTL1FXlLzWic8rbhaEVc3aaNgb+wxKmu3ThBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Slq9P7Mx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6u
	jW4S3BmnE5I/KumRvyvVLPfurFc/bwqHvYqbe8qTw=; b=Slq9P7MxuuEa/ewiE1
	kxjaBJkLkcFnxOwJDeMhCMArmS0JioB/BBwnxvbUrNZIZ3SZr14/6Ga/l5SR/T/2
	Yv4zQfJszC1Edz9ZtMgV4PmyuL3QRGjqn6Xuxj2k/9avQFHaFOMBmVNrjnX6RIC2
	4I2J3fGuKqFoI8Q+bQI6FaSRs=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCXpKgLIIRpKYGxJg--.59689S2;
	Thu, 05 Feb 2026 12:43:56 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] gfs2: Fix NULL pointer dereference in gfs2_log_flush
Date: Thu,  5 Feb 2026 12:41:47 +0800
Message-Id: <20260205044147.1948143-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXpKgLIIRpKYGxJg--.59689S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15Aw13CrW3KryUWry5CFg_yoW8ur4xpr
	ykKr1rAr4DXa15W3WUKrsYqrnYgan09F1avr4rCwsxXF4aq3ZI93W3KaykJFs3Xr4xZryj
	9FWqga13Gry5GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRjFALUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QyGIGmEIAwt5wAA38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214388-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4929EE908
X-Rspamd-Action: no action

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 35264909e9d1973ab9aaa2a1b07cda70f12bb828 ]

In gfs2_jindex_free(), set sdp->sd_jdesc to NULL under the log flush
lock to provide exclusion against gfs2_log_flush().

In gfs2_log_flush(), check if sdp->sd_jdesc is non-NULL before
dereferencing it.  Otherwise, we could run into a NULL pointer
dereference when outstanding glock work races with an unmount
(glock_work_func -> run_queue -> do_xmote -> inode_go_sync ->
gfs2_log_flush).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[ The context change is due to the commit 4d927b03a688
("gfs2: Rename gfs2_withdrawn to gfs2_withdrawing_or_withdrawn") in v6.8
which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/gfs2/log.c   | 3 ++-
 fs/gfs2/super.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 9a96842aeab3..e7867b0f6c62 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1094,7 +1094,8 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	lops_before_commit(sdp, tr);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
-	gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
+	if (sdp->sd_jdesc)
+		gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc8..3345bc071e44 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -67,9 +67,13 @@ void gfs2_jindex_free(struct gfs2_sbd *sdp)
 	sdp->sd_journals = 0;
 	spin_unlock(&sdp->sd_jindex_spin);
 
+	down_write(&sdp->sd_log_flush_lock);
 	sdp->sd_jdesc = NULL;
+	up_write(&sdp->sd_log_flush_lock);
+
 	while (!list_empty(&list)) {
 		jd = list_first_entry(&list, struct gfs2_jdesc, jd_list);
+		BUG_ON(jd->jd_log_bio);
 		gfs2_free_journal_extents(jd);
 		list_del(&jd->jd_list);
 		iput(jd->jd_inode);
-- 
2.34.1



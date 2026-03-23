Return-Path: <stable+bounces-229864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELszJDxtwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F22F89B0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5BB32F8DA0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784E3AE19E;
	Mon, 23 Mar 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQC4OcB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3413B8959;
	Mon, 23 Mar 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283068; cv=none; b=hrTQBJ1Wzw1oJ9x3FhbasIfrilJQOdIM9DWmTn0/0HE12bNGj+3L7YnDzXnaH6PtgnQ5MJkiAFbxbJeMsbt8CQkzTzrCmfvYLg1OgUEYIdYNLPSS9jVPvH3RDhHXAZIPVV6B5VFCWOjxI7gktudlUPmsCEQvFl1fYwG65RZytew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283068; c=relaxed/simple;
	bh=9ZZzGe0EO1ppOE7D2jQKW7l7iFeI4Lh/SljjxXrlHgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMX0eo6NMTx4CZWFTFOag/k6VX0TmLlkYFOhXOQlhOw8IQ2jedd4lKsG0ysrSLbZpQ5+NqRqKRyL9s7GzdVsQ/fl+7KHvrjw14xVqckzmumiCH3jYa86kZWV/A1KCaKvSBSRP/dgVntQmDvY/V9SmHOP7YFR+xWsLaKs3BRy1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQC4OcB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2D6C2BCB3;
	Mon, 23 Mar 2026 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283068;
	bh=9ZZzGe0EO1ppOE7D2jQKW7l7iFeI4Lh/SljjxXrlHgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQC4OcB0It6wM3977iy0wOiNa7ra29o3vNAYhS0bMxMTcN02QGGQSXDAk62a8SItr
	 K71zRhLr2lpkXk7yjwSNBxtkq34kv42Ia2OZRjron9yBOnDbVTxhMjOtLLmXqFzLtD
	 bWgaStMDeDHlxDXt69A0pp+bGqdhkYFwbGLtCSAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chunjie Zhu <chunjie.zhu@cloud.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1 373/481] gfs2: No more self recovery
Date: Mon, 23 Mar 2026 14:45:55 +0100
Message-ID: <20260323134534.221223668@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229864-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,cloud.com,redhat.com,sina.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 042F22F89B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/util.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -244,32 +244,23 @@ static void signal_our_withdraw(struct g
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




Return-Path: <stable+bounces-232950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FcZBZw1zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:23:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB6386D8C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDF3D31244E3
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35766365A11;
	Thu,  2 Apr 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC6u/i4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016035F162
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121169; cv=none; b=BZ+MTLolI8r+5ZUAeYeBZkHPWa8Chm03fJxRhes9wxwGD2SUhI97YxHTB3q4aBUjEqGe06oBb3LyDXuJOmQOUgc3NwixipkAc+YOk3qD0Lj4wgZc8RHjUmyXo+kEO7yx2uh3lV/LAOXWHVHI6ykjwWToPzFMSaq4NB49IeySdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121169; c=relaxed/simple;
	bh=5MlrsgcAz4ywobZCiXd1GI2vtYEXrGo89a/hjMs8Xxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCHY04Oo7mOAt1Gj0//dH/t6ugmfLPUXhJM/s8XC0t7xg8ryfui5EVjWn6LkRNKg2fAPZ1L66Ng/O5x7ElSv7UauO1BbRY7Dn7L5WVUQFCb3f20a+K/HXMaHI1vx3QwaRi19i90S7OHLIONbshJQPMBzVUpZkYUmGlA2e5rNWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC6u/i4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C313CC116C6;
	Thu,  2 Apr 2026 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775121169;
	bh=5MlrsgcAz4ywobZCiXd1GI2vtYEXrGo89a/hjMs8Xxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vC6u/i4tjhehp7jyCVjYSgKSVKh8SmMgBnjG3NNzxpHs8824bpO6LL08E1dd0IMzB
	 OxfxAaSHYrKxi7ESpi4FDPmVnGdZ2YNNogFI5dOwSwu2n5VtqVpiiQ9xyKWQ3pz9nZ
	 1lhcHnYu4yF+rby9PJUG/qLAva7lL/U/NnqNuDnNgQ2Ie7Xs0s5Oh84X0OY3xtdZAA
	 F5fHsMI89YXBNagPKxLlyAbSOVEmr3eU+TSDqKrf3H6T4Ia8tATxH0wpLYLXgAclgq
	 ptxO/Tg+5irpfwetOQS6BkzDfCbFxYmaCGJVWlsX+faNuVGHF3hnYUttPrHXsYAevz
	 FKR1eSJYAmxAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: save ailp before dropping the AIL lock in push callbacks
Date: Thu,  2 Apr 2026 05:12:46 -0400
Message-ID: <20260402091246.482124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033014-synthetic-chitchat-e547@gregkh>
References: <2026033014-synthetic-chitchat-e547@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232950-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7ADB6386D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit 394d70b86fae9fe865e7e6d9540b7696f73aa9b6 ]

In xfs_inode_item_push() and xfs_qm_dquot_logitem_push(), the AIL lock
is dropped to perform buffer IO. Once the cluster buffer no longer
protects the log item from reclaim, the log item may be freed by
background reclaim or the dquot shrinker. The subsequent spin_lock()
call dereferences lip->li_ailp, which is a use-after-free.

Fix this by saving the ailp pointer in a local variable while the AIL
lock is held and the log item is guaranteed to be valid.

Reported-by: syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=652af2b3c5569c4ab63c
Fixes: 90c60e164012 ("xfs: xfs_iflush() is no longer necessary")
Cc: stable@vger.kernel.org # v5.9
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_dquot_item.c | 9 +++++++--
 fs/xfs/xfs_inode_item.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_dquot_item.c b/fs/xfs/xfs_dquot_item.c
index 6a1aae799cf16..54eef57fbf70b 100644
--- a/fs/xfs/xfs_dquot_item.c
+++ b/fs/xfs/xfs_dquot_item.c
@@ -124,6 +124,7 @@ xfs_qm_dquot_logitem_push(
 {
 	struct xfs_dquot	*dqp = DQUOT_ITEM(lip)->qli_dquot;
 	struct xfs_buf		*bp = lip->li_buf;
+	struct xfs_ail		*ailp = lip->li_ailp;
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
@@ -152,7 +153,7 @@ xfs_qm_dquot_logitem_push(
 		goto out_unlock;
 	}
 
-	spin_unlock(&lip->li_ailp->ail_lock);
+	spin_unlock(&ailp->ail_lock);
 
 	error = xfs_qm_dqflush(dqp, &bp);
 	if (!error) {
@@ -162,7 +163,11 @@ xfs_qm_dquot_logitem_push(
 	} else if (error == -EAGAIN)
 		rval = XFS_ITEM_LOCKED;
 
-	spin_lock(&lip->li_ailp->ail_lock);
+	/*
+	 * The buffer no longer protects the log item from reclaim, so
+	 * do not reference lip after this point.
+	 */
+	spin_lock(&ailp->ail_lock);
 out_unlock:
 	xfs_dqunlock(dqp);
 	return rval;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 0659d19c211e1..cda71e0c70f60 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -540,6 +540,7 @@ xfs_inode_item_push(
 	struct xfs_inode_log_item *iip = INODE_ITEM(lip);
 	struct xfs_inode	*ip = iip->ili_inode;
 	struct xfs_buf		*bp = lip->li_buf;
+	struct xfs_ail		*ailp = lip->li_ailp;
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
@@ -555,7 +556,7 @@ xfs_inode_item_push(
 	if (!xfs_buf_trylock(bp))
 		return XFS_ITEM_LOCKED;
 
-	spin_unlock(&lip->li_ailp->ail_lock);
+	spin_unlock(&ailp->ail_lock);
 
 	/*
 	 * We need to hold a reference for flushing the cluster buffer as it may
@@ -579,7 +580,11 @@ xfs_inode_item_push(
 		rval = XFS_ITEM_LOCKED;
 	}
 
-	spin_lock(&lip->li_ailp->ail_lock);
+	/*
+	 * The buffer no longer protects the log item from reclaim, so
+	 * do not reference lip after this point.
+	 */
+	spin_lock(&ailp->ail_lock);
 	return rval;
 }
 
-- 
2.53.0



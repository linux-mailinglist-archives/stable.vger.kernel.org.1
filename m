Return-Path: <stable+bounces-231614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPRmMsr3y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C536CCD6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87C4C3083C91
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2441C30C;
	Tue, 31 Mar 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iku8xHK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CB1C861A;
	Tue, 31 Mar 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974625; cv=none; b=nPFHumQL2u4j96dhHfSPANjIrrxXBTZt7LaxHasE+BxwWWmWBlRPExxFpdD8t+QlssgQ8F8jcTrQTfcVCcuT5k4gwLNbWd8H5DxIrbUXO+vCatCNllmGZkZCOpnNHG07Qi8QBkIR7KZXsmXsnHuk0gf3zzZRB1o1+ZXHWcDUC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974625; c=relaxed/simple;
	bh=Z3bk+YBZ3wXnOP6GBqEDdzWHA+g9McQdnU/5xJtl+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVgz7d540PvYhzCXv2sOQAM27PA9Yclp3cZEz/RsAaPJrOxAw2SILyTyKLtGfksvl5VwuGrrf/BfkTTbIstZuXMLPdPAy4pVNnz+PMuxNES1PoCiuDRowqFNCklHsRU2DGu4KjBfdrxV7p1ywpHJmA9GBvtEsyqxog9svFKQ5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iku8xHK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E92CC19423;
	Tue, 31 Mar 2026 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974625;
	bh=Z3bk+YBZ3wXnOP6GBqEDdzWHA+g9McQdnU/5xJtl+dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iku8xHK5Lvwi7KZiajZ8b0jEROR+7ihubJwKl8M1hjU7S+3uTajcoaONq16LNx/bw
	 d9KWci3gvrU3+aJc0vgFCZwJh8lRDou+Rv5besHQTyzcd6lpqNS+j7fVp+WMk5qQ5g
	 ZZsO7GUTDtCzhIg3qWq05e4uTHbuTLLjKI9lhM4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Yuto Ohnuki <ytohnuki@amazon.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.6 158/175] xfs: save ailp before dropping the AIL lock in push callbacks
Date: Tue, 31 Mar 2026 18:22:22 +0200
Message-ID: <20260331161735.602928682@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-231614-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 684C536CCD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuto Ohnuki <ytohnuki@amazon.com>

commit 394d70b86fae9fe865e7e6d9540b7696f73aa9b6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot_item.c |    9 +++++++--
 fs/xfs/xfs_inode_item.c |    9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/fs/xfs/xfs_dquot_item.c
+++ b/fs/xfs/xfs_dquot_item.c
@@ -125,6 +125,7 @@ xfs_qm_dquot_logitem_push(
 {
 	struct xfs_dquot	*dqp = DQUOT_ITEM(lip)->qli_dquot;
 	struct xfs_buf		*bp = lip->li_buf;
+	struct xfs_ail		*ailp = lip->li_ailp;
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
@@ -153,7 +154,7 @@ xfs_qm_dquot_logitem_push(
 		goto out_unlock;
 	}
 
-	spin_unlock(&lip->li_ailp->ail_lock);
+	spin_unlock(&ailp->ail_lock);
 
 	error = xfs_qm_dqflush(dqp, &bp);
 	if (!error) {
@@ -163,7 +164,11 @@ xfs_qm_dquot_logitem_push(
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
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -727,6 +727,7 @@ xfs_inode_item_push(
 	struct xfs_inode_log_item *iip = INODE_ITEM(lip);
 	struct xfs_inode	*ip = iip->ili_inode;
 	struct xfs_buf		*bp = lip->li_buf;
+	struct xfs_ail		*ailp = lip->li_ailp;
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
@@ -749,7 +750,7 @@ xfs_inode_item_push(
 	if (!xfs_buf_trylock(bp))
 		return XFS_ITEM_LOCKED;
 
-	spin_unlock(&lip->li_ailp->ail_lock);
+	spin_unlock(&ailp->ail_lock);
 
 	/*
 	 * We need to hold a reference for flushing the cluster buffer as it may
@@ -773,7 +774,11 @@ xfs_inode_item_push(
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
 




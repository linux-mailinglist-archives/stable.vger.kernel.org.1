Return-Path: <stable+bounces-231342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACd4HzFzy2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D7364CF4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91CDF3068337
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE253BC667;
	Tue, 31 Mar 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HrVW8bH0"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F2386434
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940833; cv=none; b=mt0luMxPm7LHWo3YH6O4jjJ739v8zXqVLaG3g1psVF5gu0XrtXVxpcGa3p0UXFx16O4w9Df1YVCkuiRVEp7jp4Oo+giI5pmvy7uxX7rvKEYV5RgLvMXV87m57KDybv3Z9pojWbzol1GaM7YdCIkK3bLzzK9TmwgfuLnD/K11pSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940833; c=relaxed/simple;
	bh=xaO9zJykarzsl/2P/YQFTZclrK5PuYXVTcNCxEQxYTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVCys3TN2nhKd2EMHGbmtAVVlYb5yAzoSq5Hst2++SICB8SM3IOcooKfCV04B7PRSrfHfTibpGaJkjKAzx4yTrBzI/SZYVVqSj4Pn0s24yOgG1bUizySWYNIZQ8rZv9KfhEP8IyjjQb+1fLexr9G/ZA6S8IzYE51wLQSJGheUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HrVW8bH0; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1774940832; x=1806476832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUrQsLDELD9RlUpXLPVUcEMNh8kE7id6hAlSx7RjeWo=;
  b=HrVW8bH01PKC85yTegMVZh+sjT5xxMTon6/PxFJWyobjAdk/deG+WoPj
   rPsjNiA9mfnFitYSXPfWXky/yVkTQVWdI6zj+zwJXRX+IM6BfKNNVRatG
   pBoqRNUGUoL/hSMlLdBxfDkRF8U/UA54ArGsf7xClWKm5ubLeOvO+I2j3
   yKYO9JHeUEkRHT88PghFFPibcAsw8Q9Q9dEV4foR3poiOMJ8VQ9ZZG4zg
   4+xtVVfpzH2UK0fFFNL0Ldhy0ARWvlvEkm2H9MtcyK73xGzdtBNekN9qw
   NDsziDcvu9/2upEVbUeDanAoqfYq0NtRJoykPkhnza51rwaTONsg7quyT
   g==;
X-CSE-ConnectionGUID: ZQichv9jSXGKs8qYkws9Sw==
X-CSE-MsgGUID: xyODt+O6SVeBEy5tSLmUvA==
X-IronPort-AV: E=Sophos;i="6.23,151,1770595200"; 
   d="scan'208";a="15996977"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:07:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:16930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.176:2525] with esmtp (Farcaster)
 id 322029a6-8535-443e-83b4-306064ce9ba7; Tue, 31 Mar 2026 07:07:09 +0000 (UTC)
X-Farcaster-Flow-ID: 322029a6-8535-443e-83b4-306064ce9ba7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 07:07:07 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 07:07:05 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <cem@kernel.org>, <djwong@kernel.org>,
	<dchinner@redhat.com>, Yuto Ohnuki <ytohnuki@amazon.com>,
	<syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y 2/2] xfs: save ailp before dropping the AIL lock in push callbacks
Date: Tue, 31 Mar 2026 08:06:57 +0100
Message-ID: <20260331070656.61750-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2026033011-fondly-remover-82c6@gregkh>
References: <2026033011-fondly-remover-82c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231342-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA3D7364CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
(cherry picked from commit 394d70b86fae9fe865e7e6d9540b7696f73aa9b6)
---
 fs/xfs/xfs_dquot_item.c | 9 +++++++--
 fs/xfs/xfs_inode_item.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_dquot_item.c b/fs/xfs/xfs_dquot_item.c
index 7d19091215b0..74449aec81ed 100644
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
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index a734ca8d8f03..36f25a138e3b 100644
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
 
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705





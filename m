Return-Path: <stable+bounces-220768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BlcBf5Bo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:29:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE01C70A2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E515315684A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F88407A66;
	Sat, 28 Feb 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrq4Cda0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388E407A8B;
	Sat, 28 Feb 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300648; cv=none; b=EPnPE+sE3KEwgk1o2AxwDYHIhP3qqjdYixyBDb3Eqgng2opmIGj668NgaV7UfwoRN5W25IXiUX5Rkgywm64hWl9J/+eqNnFCi4oOxmK7e/iX9kgDMu42q2keSTisP3UvMPMvxW/fyS8BUBodJzoEvXPrqPPcgusrmUKI3vg3ZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300648; c=relaxed/simple;
	bh=cuz0HrJojVSCVZxXgiwczN+3ALnzoM2hqpMUZbMXo5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJjHKMgGu4MzYald26gXhlKXA4Wz7mzxT/0PFwCAy50O17J+jvGTtkAqfHf2nhFNaZjsXab33OSTfVZoyOvwABf0VMOxbKLHu5+9dS6gi/pPDG8HNs6AGW2WQM1zgGuxMEQyBm13BQ6KDXS3H9xn4LynVO9fDNAgh29wexxHlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrq4Cda0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF0EC116D0;
	Sat, 28 Feb 2026 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300648;
	bh=cuz0HrJojVSCVZxXgiwczN+3ALnzoM2hqpMUZbMXo5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yrq4Cda0mZ3KXjjrylc2Erckj3fwAViEdQX8sORo/gzz8X1ynyJvP2vpj0CvvcCaX
	 4Kk/D6thtQvaRBfMLVJ1PhqmpzBQU8ekftEy0hr7Uc5TIXJWATF1Nyixi8le36+m01
	 gOOuk8m7Pf8f0IjMxrIkEJnGOib4k7buNe0CGlK1eXHFbo9ac6KJyxp8E5NETwllMY
	 9qe3reh8jHlj/iRMDPjWGd4tusQ5Gr+8TsTj3pKouVI5hgQbOswRRlXAvduTbH9brw
	 8fQ4BZXyx8llh8xUN0bnJY0DsnR42ApB1RfV2WHAjnvKrxKOEpgYTxLy6EmgZqEZRF
	 O7dLbV1pE+6pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	r772577952@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 689/844] xfs: only call xf{array,blob}_destroy if we have a valid pointer
Date: Sat, 28 Feb 2026 12:30:02 -0500
Message-ID: <20260228173244.1509663-690-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4FE01C70A2
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ba408d299a3bb3c5309f40c5326e4fb83ead4247 ]

Only call the xfarray and xfblob destructor if we have a valid pointer,
and be sure to null out that pointer afterwards.  Note that this patch
fixes a large number of commits, most of which were merged between 6.9
and 6.10.

Cc: r772577952@gmail.com
Cc: <stable@vger.kernel.org> # v6.12
Fixes: ab97f4b1c03075 ("xfs: repair AGI unlinked inode bucket lists")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader_repair.c | 8 ++++++--
 fs/xfs/scrub/attr_repair.c     | 6 ++++--
 fs/xfs/scrub/dir_repair.c      | 8 ++++++--
 fs/xfs/scrub/dirtree.c         | 8 ++++++--
 fs/xfs/scrub/nlinks.c          | 3 ++-
 5 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index a2f6a7f71d839..6e3fef36d6614 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -837,8 +837,12 @@ xrep_agi_buf_cleanup(
 {
 	struct xrep_agi	*ragi = buf;
 
-	xfarray_destroy(ragi->iunlink_prev);
-	xfarray_destroy(ragi->iunlink_next);
+	if (ragi->iunlink_prev)
+		xfarray_destroy(ragi->iunlink_prev);
+	ragi->iunlink_prev = NULL;
+	if (ragi->iunlink_next)
+		xfarray_destroy(ragi->iunlink_next);
+	ragi->iunlink_next = NULL;
 	xagino_bitmap_destroy(&ragi->iunlink_bmp);
 }
 
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index eded354dec11e..dd24044c44efd 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -1516,8 +1516,10 @@ xrep_xattr_teardown(
 		xfblob_destroy(rx->pptr_names);
 	if (rx->pptr_recs)
 		xfarray_destroy(rx->pptr_recs);
-	xfblob_destroy(rx->xattr_blobs);
-	xfarray_destroy(rx->xattr_records);
+	if (rx->xattr_blobs)
+		xfblob_destroy(rx->xattr_blobs);
+	if (rx->xattr_records)
+		xfarray_destroy(rx->xattr_records);
 	mutex_destroy(&rx->lock);
 	kfree(rx);
 }
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 7a21b688a4715..d5a55eabf6801 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -172,8 +172,12 @@ xrep_dir_teardown(
 	struct xrep_dir		*rd = sc->buf;
 
 	xrep_findparent_scan_teardown(&rd->pscan);
-	xfblob_destroy(rd->dir_names);
-	xfarray_destroy(rd->dir_entries);
+	if (rd->dir_names)
+		xfblob_destroy(rd->dir_names);
+	rd->dir_names = NULL;
+	if (rd->dir_entries)
+		xfarray_destroy(rd->dir_entries);
+	rd->dir_names = NULL;
 }
 
 /* Set up for a directory repair. */
diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index f9c85b8b194fa..3e0bbe75c44cf 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -81,8 +81,12 @@ xchk_dirtree_buf_cleanup(
 		kfree(path);
 	}
 
-	xfblob_destroy(dl->path_names);
-	xfarray_destroy(dl->path_steps);
+	if (dl->path_names)
+		xfblob_destroy(dl->path_names);
+	dl->path_names = NULL;
+	if (dl->path_steps)
+		xfarray_destroy(dl->path_steps);
+	dl->path_steps = NULL;
 	mutex_destroy(&dl->lock);
 }
 
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 2ba686e4de8bc..dec3b9b47453e 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -971,7 +971,8 @@ xchk_nlinks_teardown_scan(
 
 	xfs_dir_hook_del(xnc->sc->mp, &xnc->dhook);
 
-	xfarray_destroy(xnc->nlinks);
+	if (xnc->nlinks)
+		xfarray_destroy(xnc->nlinks);
 	xnc->nlinks = NULL;
 
 	xchk_iscan_teardown(&xnc->collect_iscan);
-- 
2.51.0



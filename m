Return-Path: <stable+bounces-111227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CEFA2243B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F1C168524
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942051E0DDF;
	Wed, 29 Jan 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQkMYfel"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D6D1E0DFE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176469; cv=none; b=LHwOSq8Bkk9P0+1mcxViGVZgtQz8TK91PXmGv3TrF/v0vm3u0p6IXsEoA7jB6g8f+OqwgL/4GSrm5M9sLz3mfmdZYcYCRbpj59xLBMa9lYYQ+BaUvn9RwA9I944NqdhNloSi5RRXbzZ3JE/ntVb3fEl+9ZKIhjijrkrfL7vnxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176469; c=relaxed/simple;
	bh=PO9YTD3hhbu8AluTNfvr6UcaT3tHVCWLRH1w5fn2brc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFQoSXG6F9vRh4xwahdlcZkggKSAk2p8fsFxB3ouJoDa6bzIA9AMVSMNrE1xNQwE+qwYmu7FtYu9IgMcBf79B88G4ojzT6ypCAOT6ML/JSN9paMyPFJKj6oRzFkAOD/sLE8Qfg6OOsDWqNoPFUuLumfDmuULG213Kw6n0vI+RBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQkMYfel; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21654fdd5daso122938055ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176467; x=1738781267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwR79AFXJC+6r8viZENqQdOg7Tea0VYlR4llHbuMOPs=;
        b=bQkMYfel7mUkVbJL1O12+gtuyvvSrHHgJbgxi2LH3PlmJdGoktwueloJ2GYAGQxPya
         wS2wcx8ZjwtuJtv0rMiaoJv9q+43F28EudoELKbp9dfdGHmPVzJgTZKElw86IvxlOm3H
         Cy5Vajiyxtd70O68s1mQhGSphyjolqQeOKSE6JJnBt+08wqtRwKKpmJ6ApVW88Smltoq
         XU7TLf5QFdEDv5wzqJ9imlbHPaCLnolG+1nQkdj84ewTizcLGp2SNhMGGOm2qOKazzsO
         FfXy3qQaktvaeLviJtOU7XeHncpUQ00BZfDOenhvBVPNaK+zwRKzBioSl7qTs+kPRMPA
         Nakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176467; x=1738781267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwR79AFXJC+6r8viZENqQdOg7Tea0VYlR4llHbuMOPs=;
        b=hIhluEufA3XsW4PT6BL7dzlRfhWvfiP/2mKSiJSg8vuiIaSnJO6Pmh9WezKBdJc4bQ
         IKBLvGF8pvMW3NYVuKsnxiiiFb7PKOw+WnG2Zcj3AqCwrQ/LC3L/K25rYER7VXd4uqp2
         9ld3aG7bW7BlFLTkd8GcOsWC2aoxdNRcFrl4y8Xs2FzFbqSdrflr9xpnXHX712+CoQCX
         JCQrnRumzRJxR0IobRcnV8Ie2bUTBz1lOJdRxaY+KKayTT7zmB4Wf35TO6iXcYx31wRg
         qdhIphoBfmaMrMe9tXOo//bkUy+l7yULS0aErcLB0T1G6ZZy/4i9kE1/hY4pRlogVCh/
         wG5A==
X-Gm-Message-State: AOJu0YyLOsL0q93oRz5mVqynMe64w2N3FCZggFFl0ruHmDKg4FiQA3Cu
	fZ+jcFuvSgq3FFAwi3duuL/WgxjKysSvG+BkjeEA0nF6tNCCNrIZlAXWEAAz
X-Gm-Gg: ASbGnctpXTIrsOMsRDJmGDzyelqOytm9vtcHgpdm8KpCqRvpp80yYTvI7ZxQZMDnyaH
	c/pF7jwaAzLa7GifLGSvNCeuIRa/DXMR215arOgUOBHCteUaVvDazKA9JHpkCwFlk7lrG37A4v6
	U0SZ5ZgzHN7GJmmuUzHLW/8IskWwpDX6B5MyPUACGz1tGRv6Q+CYP0lR1t+vsGiAQtsNWFKbCc9
	PHUAR4waygNoJfcCckuLF34BDt+XfBRHmCSbgMUAjPwCOxdKPkZOfjgY0xLN2DhUCPIasx+SWtt
	a34LoRyW1MyjbGmbjk9X2gO8w5ee/JwFhoOOBURz868=
X-Google-Smtp-Source: AGHT+IEhZvTMG+F5qpP29o2nsFHOXWgUHGkk+5Zy3RXbI1I2YFpsInrv9pLZ4P4+N8akrkcVpXVIHg==
X-Received: by 2002:a17:902:d2c5:b0:216:386e:dbf with SMTP id d9443c01a7336-21dd7c4ed1dmr64399985ad.20.1738176467094;
        Wed, 29 Jan 2025 10:47:47 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:46 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 16/19] xfs: clean up dqblk extraction
Date: Wed, 29 Jan 2025 10:47:14 -0800
Message-ID: <20250129184717.80816-17-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ed17f7da5f0c8b65b7b5f7c98beb0aadbc0546ee ]

Since the introduction of xfs_dqblk in V5, xfs really ought to find the
dqblk pointer from the dquot buffer, then compute the xfs_disk_dquot
pointer from the dqblk pointer.  Fix the open-coded xfs_buf_offset calls
and do the type checking in the correct order.

Note that this has made no practical difference since the start of the
xfs_disk_dquot is coincident with the start of the xfs_dqblk.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_dquot.c              | 5 +++--
 fs/xfs/xfs_dquot_item_recover.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 7f071757f278..a8b2f3b278ea 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -560,11 +560,12 @@ xfs_dquot_check_type(
 STATIC int
 xfs_dquot_from_disk(
 	struct xfs_dquot	*dqp,
 	struct xfs_buf		*bp)
 {
-	struct xfs_disk_dquot	*ddqp = bp->b_addr + dqp->q_bufoffset;
+	struct xfs_dqblk	*dqb = xfs_buf_offset(bp, dqp->q_bufoffset);
+	struct xfs_disk_dquot	*ddqp = &dqb->dd_diskdq;
 
 	/*
 	 * Ensure that we got the type and ID we were looking for.
 	 * Everything else was checked by the dquot buffer verifier.
 	 */
@@ -1248,11 +1249,11 @@ xfs_qm_dqflush(
 		error = -EFSCORRUPTED;
 		goto out_abort;
 	}
 
 	/* Flush the incore dquot to the ondisk buffer. */
-	dqblk = bp->b_addr + dqp->q_bufoffset;
+	dqblk = xfs_buf_offset(bp, dqp->q_bufoffset);
 	xfs_dquot_to_disk(&dqblk->dd_diskdq, dqp);
 
 	/*
 	 * Clear the dirty field and remember the flush lsn for later use.
 	 */
diff --git a/fs/xfs/xfs_dquot_item_recover.c b/fs/xfs/xfs_dquot_item_recover.c
index 8966ba842395..db2cb5e4197b 100644
--- a/fs/xfs/xfs_dquot_item_recover.c
+++ b/fs/xfs/xfs_dquot_item_recover.c
@@ -63,10 +63,11 @@ xlog_recover_dquot_commit_pass2(
 	struct xlog_recover_item	*item,
 	xfs_lsn_t			current_lsn)
 {
 	struct xfs_mount		*mp = log->l_mp;
 	struct xfs_buf			*bp;
+	struct xfs_dqblk		*dqb;
 	struct xfs_disk_dquot		*ddq, *recddq;
 	struct xfs_dq_logformat		*dq_f;
 	xfs_failaddr_t			fa;
 	int				error;
 	uint				type;
@@ -128,28 +129,28 @@ xlog_recover_dquot_commit_pass2(
 				   &xfs_dquot_buf_ops);
 	if (error)
 		return error;
 
 	ASSERT(bp);
-	ddq = xfs_buf_offset(bp, dq_f->qlf_boffset);
+	dqb = xfs_buf_offset(bp, dq_f->qlf_boffset);
+	ddq = &dqb->dd_diskdq;
 
 	/*
 	 * If the dquot has an LSN in it, recover the dquot only if it's less
 	 * than the lsn of the transaction we are replaying.
 	 */
 	if (xfs_has_crc(mp)) {
-		struct xfs_dqblk *dqb = (struct xfs_dqblk *)ddq;
 		xfs_lsn_t	lsn = be64_to_cpu(dqb->dd_lsn);
 
 		if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 			goto out_release;
 		}
 	}
 
 	memcpy(ddq, recddq, item->ri_buf[1].i_len);
 	if (xfs_has_crc(mp)) {
-		xfs_update_cksum((char *)ddq, sizeof(struct xfs_dqblk),
+		xfs_update_cksum((char *)dqb, sizeof(struct xfs_dqblk),
 				 XFS_DQUOT_CRC_OFF);
 	}
 
 	ASSERT(dq_f->qlf_size == 2);
 	ASSERT(bp->b_mount == mp);
-- 
2.48.1.362.g079036d154-goog



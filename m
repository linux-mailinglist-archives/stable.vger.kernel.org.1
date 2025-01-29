Return-Path: <stable+bounces-111226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97EA2243C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902B93A81DC
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912961E231E;
	Wed, 29 Jan 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDF0augY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FD1E0DE3
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176468; cv=none; b=NWn7hUlvXbY6pavOycHiyj3xo1fYJYpRac7T0GM70FFq546hNMc8Hj/2/WCcGOnI0dWDALxh19TFtWWBeg2dn902pcSxKnrR5eAnlT01ooOj+u8tQWE3fmU00lWnptCTmuKyvgiA/YHwHx6p3/CZBrAn2K5gzmwMsT1FaPMY+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176468; c=relaxed/simple;
	bh=0UN1KVlBUFP1XT61yFAStuSpiwhVmwKHMM5wICFtAD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V28DsyhMPGUmjSmfp2+9xkhoEhOHDa6xoaPVDJ9q9LOhxNh5wjR9d5/5L7nSjaFVUhEm8H51/AyQgBlMRMS1E3IPP6Ta6LXTlLXAPD8ufF8JtToyW76V+xaxmTTEtweeEaRvsVDCwKWp038YKKVkAOzLgIMQaF+6yUv2BcKs7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDF0augY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163b0c09afso132972995ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176466; x=1738781266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCkVVvOX/4D0LHsbw0VCFaeBfbe8dDzkptfW/LWD8lA=;
        b=HDF0augYkj8n4J9pHKU1fcWhvGolf+eD4Fc46BoRH2lH7o0qvKtjo5QZGfaZMF4Rqv
         Jo8LZZ8XxewCQPpVEfdazj6gAHdD9c8nJJpyY/VJhkkG0tZH6s1mjAA/zph7aRXWHCoG
         okPbsV5pmeVwJGckgmCfatmJiArMBhkMJc/c3pom8a0Hlxne26g7TjEe0/HH9dm7tyx3
         /xwdUDbVjdUxrkhheG1qOcaDkEPpZcAAYNYZmyn2/SOJD/yZTDfqeXz/wWN58/3BiZsn
         zUUNINQEC+GN9+h6g4bCnDmDfLcf5BaGkatk/6JK26HM7JVrYh4qhwnvf3gdvjHcBZWJ
         bK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176466; x=1738781266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCkVVvOX/4D0LHsbw0VCFaeBfbe8dDzkptfW/LWD8lA=;
        b=rV77dFrDwxeLN5lXy95QdAQxma/lt3lO7J2/UtxhmLjTt37m27EZ8Sfz6kNoPGQN4k
         6h4DgvAGFgeSI/W9zF6Hk9LWRmC8NPnUPE/eQyZB8vZgRBgJ+PmQh05ZFXGLK3wKTnqn
         Did943FNx/WiIPiVDHeH7CAXUezqbiPEa1G27JM458rRggJQy161fydoEyyT5WX7eCTq
         D/Rm7RUlZxYCt5Le/iQJcgzMZ+5h3diza/o4mdjAMmmmuRuiL7G9AzOsw/PcJTIKR98f
         moYjQdWjHiw23kcvGMUUqtISTs8P9GVWEB9a6fDUyPgoloiuvWibxQ67go/IHXi/Nazj
         93yw==
X-Gm-Message-State: AOJu0YyZZeZrujs0waUWXxa6tZ/1b8Qbp/5ld3pxMASYPS19ocpUV6ML
	v8Xmacy6oTz2Fe+Ww1aMt20NyUlw2FqjLIeLPe8SwrkUUGweN7qpwXZz1i0E
X-Gm-Gg: ASbGncvRGhn6fUAeU4jdfUseOAbdd2z1ze7GaungX7vVc7YSMCLCthsiwF2P1ICROPf
	P2SOXxeL6KgzVO4Mstc102SjluhUawt3mqySGgc4/8R6t6PATLXlThShNSWDIDwdfWJEa4ScWWW
	h1br3n+48Y6gLr7OyMjsiZLyGyx6GJQzKwRdoAzwgxImlb3d8F5MwsF8FN7FMBsXm6X9Z0O4BXN
	iHuODRkE3WdmYt1sx1uG+XBO5Df4RDF3eRLt4gltpMvD14d+1Dv8zjVSpOY4RugjAi8KbDANlBD
	tYopNkCD2SEbSrXuWcQ0b3gzkJU0nENxOZO+XIWwhU0=
X-Google-Smtp-Source: AGHT+IHq01p9Y4SaZfXXD9ms0UTn5/0tRuMLe+VorlgV0+2aUmMZk+wB2cxtBHpVzD9wbIs/HfAakA==
X-Received: by 2002:a17:902:db02:b0:216:69ca:7714 with SMTP id d9443c01a7336-21dd7c46297mr63110075ad.11.1738176466069;
        Wed, 29 Jan 2025 10:47:46 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:45 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 15/19] xfs: inode recovery does not validate the recovered inode
Date: Wed, 29 Jan 2025 10:47:13 -0800
Message-ID: <20250129184717.80816-16-leah.rumancik@gmail.com>
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

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 038ca189c0d2c1570b4d922f25b524007c85cf94 ]

Discovered when trying to track down a weird recovery corruption
issue that wasn't detected at recovery time.

The specific corruption was a zero extent count field when big
extent counts are in use, and it turns out the dinode verifier
doesn't detect that specific corruption case, either. So fix it too.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_inode_buf.c   |  3 +++
 fs/xfs/xfs_inode_item_recover.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 758aacd8166b..601b05ca5fc2 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -505,10 +505,13 @@ xfs_dinode_verify(
 
 	/* Fork checks carried over from xfs_iformat_fork */
 	if (mode && nextents + naextents > nblocks)
 		return __this_address;
 
+	if (nextents + naextents == 0 && nblocks != 0)
+		return __this_address;
+
 	if (S_ISDIR(mode) && nextents > mp->m_dir_geo->max_extents)
 		return __this_address;
 
 	if (mode && XFS_DFORK_BOFF(dip) > mp->m_sb.sb_inodesize)
 		return __this_address;
diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index e6609067ef26..144198a6b270 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -284,10 +284,11 @@ xlog_recover_inode_commit_pass2(
 	int				attr_index;
 	uint				fields;
 	struct xfs_log_dinode		*ldip;
 	uint				isize;
 	int				need_free = 0;
+	xfs_failaddr_t			fa;
 
 	if (item->ri_buf[0].i_len == sizeof(struct xfs_inode_log_format)) {
 		in_f = item->ri_buf[0].i_addr;
 	} else {
 		in_f = kmem_alloc(sizeof(struct xfs_inode_log_format), 0);
@@ -528,12 +529,23 @@ xlog_recover_inode_commit_pass2(
 	/* Recover the swapext owner change unless inode has been deleted */
 	if ((in_f->ilf_fields & (XFS_ILOG_DOWNER|XFS_ILOG_AOWNER)) &&
 	    (dip->di_mode != 0))
 		error = xfs_recover_inode_owner_change(mp, dip, in_f,
 						       buffer_list);
-	/* re-generate the checksum. */
+	/* re-generate the checksum and validate the recovered inode. */
 	xfs_dinode_calc_crc(log->l_mp, dip);
+	fa = xfs_dinode_verify(log->l_mp, in_f->ilf_ino, dip);
+	if (fa) {
+		XFS_CORRUPTION_ERROR(
+			"Bad dinode after recovery",
+				XFS_ERRLEVEL_LOW, mp, dip, sizeof(*dip));
+		xfs_alert(mp,
+			"Metadata corruption detected at %pS, inode 0x%llx",
+			fa, in_f->ilf_ino);
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
 
 	ASSERT(bp->b_mount == mp);
 	bp->b_flags |= _XBF_LOGRECOVERY;
 	xfs_buf_delwri_queue(bp, buffer_list);
 
-- 
2.48.1.362.g079036d154-goog



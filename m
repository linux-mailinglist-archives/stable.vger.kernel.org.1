Return-Path: <stable+bounces-111229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD5A2243E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A72B1885B37
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FF1E0DFE;
	Wed, 29 Jan 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhGf/7B7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA01E102E
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176472; cv=none; b=EvDGiyQ7sfyuKC4jOWPQuXMmiHL/+5MuhrZsettZWHzKpu1QkjTx659KpJYaeABBs/+bxcU6z+bbaVEScww/IaD/FGuZAiFbO3ybNR65wYhLBqeNDXySo2GYqKJH58QJPRCLPMXz5S/CIF20/L6yUfD/V67XOD/kPSpQNyJts5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176472; c=relaxed/simple;
	bh=T9KgUQVqFROdomhPyUYoXLzNdJ+dzJr4xBH7Oa083Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE2zw6EFcVArZQYJvUp3iRKoCuxT7G/e71Nx9DuYUcDnXEFutSZWnB0Dr58n82bu9csDznRfnSXSzzmTRwFnS0r/T9B9MYrh40WSb2E8QUOqhshOLd34pY3QVOajz8NjYXxoYUtAGXQvHGegsP/ENzjR92vevSSHz46/TBQQn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhGf/7B7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21634338cfdso13965555ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176470; x=1738781270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vCO7X0PgmOfq2S86+DSat6yuAZvXJf2pbUWoPf3pcA=;
        b=RhGf/7B75IqpgGBRIfZM8yJcACOqsVgLctMt2AUqPNoNOmif+PPsxdoTqBnc1MEyWD
         epTth63Zz1a+XzWCi58qOjnaULAkAso9DO6M5zkTs3Z7XgPmwOcn1OtimZ1doWE1yOY/
         eEel7KmW7uDvUB41Ld6dG0oUBWemfmdD6ZBbpLtGkl8XEVPDS92i99GpKoAYZPw0zIck
         pjoIKtjGTnsuZTAf0/E5Bd+6z3uOUvD0/kiyDTsO/hDHCAUSc2od8ctvMLDok7fmp+a/
         K5JMVGta+rBls9FmJ/J/bQbbmjLpJJcoSbLnzjdQllWX/NNrg+vWYa/csXWXRm9lJGBw
         reeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176470; x=1738781270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vCO7X0PgmOfq2S86+DSat6yuAZvXJf2pbUWoPf3pcA=;
        b=BimJjJqDYdtTCzoemHeBgYA4GScOp0DSejic87xIkuEVKS8bu8V0QcTJGj0SI792xw
         h1/aJjgVi0YwEV0quSo0ZyutlxsnaLrwh91duGVDdp/Gf/xK4sJnLpAQNO7QbyyHWrPr
         8KGsvT3+Eud0foto+X3mZG3Pikmtn0jWzcZNgB+sL4OAq+CWTTgbZM+s1xsEYl6b+d1z
         pupXnHa+9k26vbb9mMaPyd9G4THsoB+lx0tHPnbV8BEwFa4kXtjBPql5DxF/sBHycWV1
         a7S5DKAsj+jWXCsYpa4xJr1R58UdRdyx5c9+7JD00tp8IrhD6SBlWJ0hhGOLVJe6XOVA
         srzA==
X-Gm-Message-State: AOJu0YwQH8dCNhQ60fypzqKRz7vGJipmo3DC1mcDFjCXrSHVvPgvein+
	zsAPFJyL5jxoIV7ty7IYgEOU+bPtlSXSSYCBc1yPEFrzblAvnVE16KpUHTbc
X-Gm-Gg: ASbGncsBk6jSn2pMzE7bsIjA1uQDnVNOXn7VvXxC0uVRlcNIKejNYHBv2tf/gtQ+sCf
	XCwIszeMfQFxQBrF2LDGRPtM7ruC1lvW2ObxQhxe3tsWFn3UZjCQtpJMAPa6zTqSksfqF58PXK2
	JEIkpOm/esDOsxd/gAscw7GA4UGDoOZ70yIqZYGSPt1dK8vTMUtD+/otI7KH+0puvk2ba3Gr19A
	g9DsbriY5GbLt1HYfvAnzCDkdi4DfBjWMysar3sbhCgUjBl+3ihuRAQu6aLpGpXQdvpc6WwuErC
	7s+cXlUyaxcx7ikSTg175pRS57zs32FLaIRyaqaLWYJHhNTutvcjiQ==
X-Google-Smtp-Source: AGHT+IF7aMcftsjI10iIS09BWLUWKr8Nhs2Qnl3yjNbJGfs/7/IC1Fh04Lp3XZV2nHVwWi4NpSEnLw==
X-Received: by 2002:a17:902:ebcd:b0:216:3d72:1712 with SMTP id d9443c01a7336-21dd7df0717mr73248585ad.48.1738176470189;
        Wed, 29 Jan 2025 10:47:50 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:49 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 19/19] xfs: respect the stable writes flag on the RT device
Date: Wed, 29 Jan 2025 10:47:17 -0800
Message-ID: <20250129184717.80816-20-leah.rumancik@gmail.com>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9c04138414c00ae61421f36ada002712c4bac94a ]

Update the per-folio stable writes flag dependening on which device an
inode resides on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231025141020.192413-5-hch@lst.de
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_inode.h | 8 ++++++++
 fs/xfs/xfs_ioctl.c | 8 ++++++++
 fs/xfs/xfs_iops.c  | 7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3a81477c7797..c177c92f3aa5 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -567,10 +567,18 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
 
+static inline void xfs_update_stable_writes(struct xfs_inode *ip)
+{
+	if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
+		mapping_set_stable_writes(VFS_I(ip)->i_mapping);
+	else
+		mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
+}
+
 /*
  * When setting up a newly allocated inode, we need to call
  * xfs_finish_inode_setup() once the inode is fully instantiated at
  * the VFS level to prevent the rest of the world seeing the inode
  * before we've completed instantiation. Otherwise we can do it
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f6aa9e6138ae..c7cb496dc345 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1151,10 +1151,18 @@ xfs_ioctl_setattr_xflags(
 
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
 	xfs_diflags_to_iflags(ip, false);
+
+	/*
+	 * Make the stable writes flag match that of the device the inode
+	 * resides on when flipping the RT flag.
+	 */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) && S_ISREG(VFS_I(ip)->i_mode))
+		xfs_update_stable_writes(ip);
+
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	XFS_STATS_INC(mp, xs_ig_attrchg);
 	return 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2e10e1c66ad6..6fbdc0a19e54 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1289,10 +1289,17 @@ xfs_setup_inode(
 	 * stacks or deadlocking.
 	 */
 	gfp_mask = mapping_gfp_mask(inode->i_mapping);
 	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
 
+	/*
+	 * For real-time inodes update the stable write flags to that of the RT
+	 * device instead of the data device.
+	 */
+	if (S_ISREG(inode->i_mode) && XFS_IS_REALTIME_INODE(ip))
+		xfs_update_stable_writes(ip);
+
 	/*
 	 * If there is no attribute fork no ACL can exist on this inode,
 	 * and it can't have any file capabilities attached to it either.
 	 */
 	if (!xfs_inode_has_attr_fork(ip)) {
-- 
2.48.1.362.g079036d154-goog



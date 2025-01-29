Return-Path: <stable+bounces-111228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF490A2243D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C56B188500E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3C1E2007;
	Wed, 29 Jan 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJDhaJ4y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A414F9FF
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176472; cv=none; b=cQmrJhWDTSSgzu+jrtfcqMxyRJJzaj+VnM6Vcx8uvlo+nGLFhIh6ZL5u8CBt4xzIXqKuWxng2eiMPYwVFK0l6HzUtnhUKK5zC/uP6hgZJt78wmptEg1cS4o1o31IICFJwxR9rKGLhHqIc5aChcVkOoDU5C25Tr+2Z/GAqRr+DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176472; c=relaxed/simple;
	bh=UNsZTEOHJdJEOz3cHPd7tUbmVcmNP5Op7hmiX+dcucY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1pSWhajz4wfWQnPvuOjIrjQV/CsJYrLx9I3rFbT3JVBczF7lm8M/H3s1nFpbnvcK5ongILp5dMES/+BC3HK0uhQmmN3KiLrNppXPfWlOFpn/7xkjhd+bWUuKuDWgf7vokLZr09lB+Fuj67KXfGpSVaAkXLyBX3RZi3B5YOjOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJDhaJ4y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2161eb95317so129840305ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176469; x=1738781269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v05LwmmjzBBRQJ5UtchsxdTDHHhOh+vIm3ssFM6Xucw=;
        b=hJDhaJ4yDsAdCLfyUr8OsowUabbmlPxmfgBV1GBD/gb2i4uMsPp6XWFzMk4emrBWdb
         gxaO+MirAgaAtDkHRU2cdStMlfwxdjjcvB98h7aaxY3rYamHqIGSGwio7crlxyIDWx1V
         18vh1d7Q3CccY8mUZ5kN751qOdmJnJap3jkh4LDOHu3oGKhNkKoOF/K4D+NfbYZwghyD
         GYp52mCzt4ggHFpcXJBI7PLEhGcGyB3zIWDIbDFIsdJQZh2xjl/F0R5L3tgIMz1xY5Qz
         qbdiilWz0vBNUdED62eUJYS89Wuyn+IXY2D0G2wlporYOrTBHpSq/3WDygNaDjDMIO38
         aYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176469; x=1738781269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v05LwmmjzBBRQJ5UtchsxdTDHHhOh+vIm3ssFM6Xucw=;
        b=hN8rMF84Xmisq8tPwHWSEYuXVSwstfar7sWP7JBlrpdoYm72br/Chw/m4vRT2l+Xlp
         BPrUz/pOoLDDt8ZziPNa7RsJ4T9NBjcAQIQdDCDHMhpI7W4d3EOvb+kjqsBNqwZ3A8Bb
         hDl9wGxiJxcjb/ApyeiyxhCIVWNhawjwuPDlfZyeQMg1VS/BJvf4ro0NYuG0cxbc41wL
         a8mGOp6Rtm114ZhXNKivzl7m9dqq11TLTJA5WOnjllY9o1KZmqGozONSR9ySbdmXRe1c
         LqIXVFp+KKJlb2O+XHw9YhaZfgizxbr1FL4R34fKFOsEtVsHJ/DlAcGT8Rhg5fm0KJa8
         JScw==
X-Gm-Message-State: AOJu0Yyro0vNk6Ca7dNr8kEyNZzxjnczD5b1FkS1GckLarb1LW7+MAvu
	d2aR4RfhyQJJGEbAvMu7e1X3sAs8TEcvyjwYn/DMkXS9p2R1ZLx+P94koFVs
X-Gm-Gg: ASbGncsq4n9iR4Ou5gYVgd16c4Vznqp8uSbPW2wee7PoUOrQG+0jgTAyw7YxbIouFPe
	2VS80vehAOzLN/ci15AdaFMXx7S4rPoxykpQw4MdrQd8bqi350uXJoDls599+KkZoj4pWNlaTQF
	XY9bbwmuQ0NP8HCTjfqUKhhBA+ArXmk63CAp0Cs6NRL4xqSwOqZNVn7V7aPbr1Etz+v6KVbvlSd
	JbilQE7er6HAUn7DbsAh3IfYvRn6XNo6gvGx/eNib4zA659UWbDYVqILbWzQL9MhgoTyitVj7pi
	0z3K+6d+YyC3Wq00UHqOWaecpoOjR40weKcI+rHSzrA=
X-Google-Smtp-Source: AGHT+IGe3dEmPtYZQdbA7TtlEpi4egA2ar/N7WzGpKqZuqoZY7asM4ZZpuKIGfRTHgWVvEsYw9mL2Q==
X-Received: by 2002:a17:902:e5c9:b0:216:7cbf:951f with SMTP id d9443c01a7336-21dd7d82d98mr68874735ad.21.1738176468117;
        Wed, 29 Jan 2025 10:47:48 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:47 -0800 (PST)
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
Subject: [PATCH 6.1 17/19] xfs: dquot recovery does not validate the recovered dquot
Date: Wed, 29 Jan 2025 10:47:15 -0800
Message-ID: <20250129184717.80816-18-leah.rumancik@gmail.com>
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

[ Upstream commit 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02 ]

When we're recovering ondisk quota records from the log, we need to
validate the recovered buffer contents before writing them to disk.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_dquot_item_recover.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_dquot_item_recover.c b/fs/xfs/xfs_dquot_item_recover.c
index db2cb5e4197b..2c2720ce6923 100644
--- a/fs/xfs/xfs_dquot_item_recover.c
+++ b/fs/xfs/xfs_dquot_item_recover.c
@@ -17,10 +17,11 @@
 #include "xfs_trans_priv.h"
 #include "xfs_qm.h"
 #include "xfs_log.h"
 #include "xfs_log_priv.h"
 #include "xfs_log_recover.h"
+#include "xfs_error.h"
 
 STATIC void
 xlog_recover_dquot_ra_pass2(
 	struct xlog			*log,
 	struct xlog_recover_item	*item)
@@ -150,10 +151,23 @@ xlog_recover_dquot_commit_pass2(
 	if (xfs_has_crc(mp)) {
 		xfs_update_cksum((char *)dqb, sizeof(struct xfs_dqblk),
 				 XFS_DQUOT_CRC_OFF);
 	}
 
+	/* Validate the recovered dquot. */
+	fa = xfs_dqblk_verify(log->l_mp, dqb, dq_f->qlf_id);
+	if (fa) {
+		XFS_CORRUPTION_ERROR("Bad dquot after recovery",
+				XFS_ERRLEVEL_LOW, mp, dqb,
+				sizeof(struct xfs_dqblk));
+		xfs_alert(mp,
+ "Metadata corruption detected at %pS, dquot 0x%x",
+				fa, dq_f->qlf_id);
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+
 	ASSERT(dq_f->qlf_size == 2);
 	ASSERT(bp->b_mount == mp);
 	bp->b_flags |= _XBF_LOGRECOVERY;
 	xfs_buf_delwri_queue(bp, buffer_list);
 
-- 
2.48.1.362.g079036d154-goog



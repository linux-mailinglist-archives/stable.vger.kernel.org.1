Return-Path: <stable+bounces-111218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496CA22433
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D30E3A9413
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7651E0DB0;
	Wed, 29 Jan 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6J/uinE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768191E25FE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176460; cv=none; b=R879zW1+mKCjHHczY86XO0wUOnS0U+9EWxoMAaLOn0PuzAt/GYeT2N6Nf3700hBhM8YXkUa2JPGz/PuIF30ccB2LnlatsO2vjztaAHKHtwoBtehJaDskH2MsXHizv8Pf9QNYvjuJbUEmlfkfwpTwo8P4oo5HonLREOFmWh61JpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176460; c=relaxed/simple;
	bh=J7rliugnr1XpzVevWtD5uvdGUWEIXIntqj7NgZ7tXfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u39nu4/VWR7FTi9UZslSH/77Q2DOJ5YHG4QZ1qZYClZeyBybfJb/FIqsbFsjWKISNjscF8rYMrJM+DYNubS6ZwhNlHnLSKPHPvq0HJlYosPhwOJN90heQE0lAtxz0E1PI49U3TPQmRDUJ2Fzij3j2pHAnRabXwUF9wOpCXFM+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6J/uinE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21ddb406f32so11705745ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176457; x=1738781257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V381xVjcpo0TThox2VvkVHfZgzGqs0VsFuzon9tzvKs=;
        b=Q6J/uinEe/F64XTZiuqdnp/mxgkgYF+ngLZlR5wkYYThNbF97m4myCJB8gEMjjkW7b
         sK+rslEfDoL7hV9WV7A6fkVzys7i4aaKZ3AsC6NrWVc7Q7DOryEbwTdC9Bz0eCXqdMNt
         yJFpMth8C4ThLOvpihb9lhUUM4/q8YH1Kk37kkjfJEJGIBtjh4E1infVmoItZLcoYHFy
         bp8JUWR2A2hcLpo6CVOYrM7UX00I8XnecsMhCwoMIO1IQSGN/R5sUeOb8JeRbgMrTBTQ
         03EopUlMAN+6NLGEqRD8YdHZnIdaEI7kz7+V2jEWtc2VJ9dyeK0AsHqblyP3CB/4SgAA
         zPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176457; x=1738781257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V381xVjcpo0TThox2VvkVHfZgzGqs0VsFuzon9tzvKs=;
        b=q2AZ/Rj5SbLJlWqWBU6MtrXBV3asoV41nodg6okNc3a6i1LIohvZ8Jll1IfHXz1p0K
         CX367Y68G/ITCMqs+R0wS08qrDAheHmlqc5GM9OVRda86C3qFEZPtkqQ55Or9/Uzmd7d
         0hhM04GovvrwLTQx8vToVetjIl4IvX6zyZXfZB9Ba022qQ5dsUqCGsBeCOKLcXM2uUzD
         rwlYZFg4Y/k9/FuzRqJJIrp5hpQsb2PbrlEfgdD3zoe8VvQ9T6ktwG3Gup/eRnMgUVNd
         odkZtDGfrWpg5biYtiMEnHAr+wXiUasHM+hqHfq4BboHqlDISV1ZnSLvYHl2mkK2aRtW
         ILTQ==
X-Gm-Message-State: AOJu0YyBdu4E0/wm3AwlUiRhOom8QYAJ3fN8o0v5/Z8/I/TP/P+9u0hL
	WkR0Ru3W33kOK9hgaVj4aAi9qtJUGGDYoHn0hcpKN1kApKJaD1HZDHtMvgQG
X-Gm-Gg: ASbGncuH1Pz7BF4wWZZC4R57niDmWcqi4XByyVqfhy3ArFTaL4iDUiFeODHQbMRyoXk
	+m+GluiEUn30eKFUytZ9qkwMEa+sX8uml8e7LSPMBI0EGTnTKPg1iLkqxW46RhYXzEJeNqaKIBj
	RHPh3ist6zTmLe6i1jQsIZ4bgkwkUQaQUFHAeP06zbqmXLFdgWnPdjSx9ehJtxP4tiSlvIOWUBL
	F3hDRs/pSzsQQzHyLGcnzExAji8UN9nzT3mCcmrnLGT4//cAoJuKs7a5FsX22dgW/j29JhS0NsP
	g5iHNV9MmEXx5cgctPRSfOd7ohzasBdtVBE9QCTTB7I=
X-Google-Smtp-Source: AGHT+IHzOsMLBITLWZfvPkb8YjBm8IVPk9vXjt9mE1uXxf1yH5FLqxeW2Lkuy1CLpKB/zRPFAy+imQ==
X-Received: by 2002:a17:903:24c:b0:219:eb2a:dfa5 with SMTP id d9443c01a7336-21dd7def052mr59723745ad.39.1738176457626;
        Wed, 29 Jan 2025 10:47:37 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:37 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Cheng Lin <cheng.lin130@zte.com.cn>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 07/19] xfs: introduce protection for drop nlink
Date: Wed, 29 Jan 2025 10:47:05 -0800
Message-ID: <20250129184717.80816-8-leah.rumancik@gmail.com>
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

From: Cheng Lin <cheng.lin130@zte.com.cn>

[ Upstream commit 2b99e410b28f5a75ae417e6389e767c7745d6fce ]

When abnormal drop_nlink are detected on the inode,
return error, to avoid corruption propagation.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 909085269227..1d32823d5099 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -917,10 +917,17 @@ xfs_init_new_inode(
 static int			/* error */
 xfs_droplink(
 	xfs_trans_t *tp,
 	xfs_inode_t *ip)
 {
+	if (VFS_I(ip)->i_nlink == 0) {
+		xfs_alert(ip->i_mount,
+			  "%s: Attempt to drop inode (%llu) with nlink zero.",
+			  __func__, ip->i_ino);
+		return -EFSCORRUPTED;
+	}
+
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
 
 	drop_nlink(VFS_I(ip));
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
-- 
2.48.1.362.g079036d154-goog



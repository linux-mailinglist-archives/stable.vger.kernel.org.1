Return-Path: <stable+bounces-139231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE3FAA575D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5565E4E15A6
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660B2D0ADA;
	Wed, 30 Apr 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6u3FlZv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035102D1102
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048437; cv=none; b=ZUdqaRYoE89LzGjNMaCQNEnIfFsAw5he/vSdK9dxFBDwWAwd/lbWXHQPBM57hRVwt4blr5hH7ZtEMwAfEUF6b1XJD6mN+cvHdy3JdA8Xbq3ROVM2L2Um26O2H5svLLiEvImZLG5QyvUrbWXHtRM1Ms40KU8mWwH0XZo+O3piLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048437; c=relaxed/simple;
	bh=I3F7WARLtz/Tzp8PeWxh5MvZWVrd0xspj0Q2+SQOS7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYphPxWu5E+vaa2G+r7HLKQxC85eF15dqa5hiJOErFaQ4VJkFwAPE/7qwe7XaM54W2m8VRtxT2Jpg2XuvsaKGuSXm2RjzyNeKgKTIqoJS8hxwaKkNmN+3Nqp+fqSlSk67BfSjw3DiecyhOJmopr2XJZOttKl4bkhhiQ5xrLaxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6u3FlZv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so406565b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048435; x=1746653235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP6y8tV/MBufU+zAtH98PgJW62lVroSTuZx+Ob9W8Ao=;
        b=h6u3FlZvkfHMY19vo4tMna5p7+CLvFDo8RlWnyZz9/svXtMm1vYvFY9KPX+VR7yhMU
         tU4Z/sEaM4dEGAVj4GMyUly4qrcM3heMJbbw7it0hhEmoDJnh5+A46Clu4+/9VHeyN+c
         AxKjHgPi5Jchj1Bx8YfdOJJMc3g2UduQiqlKqvcHm5eIAv3Tb0rZVt99mqcvX1lwbXw+
         QnEWSsVUCXaOUs4AnohqHiIPvVwws9I0xUrBAyJUIBtiDYCQfWdPXcOkvTFAz2oE9uyw
         qD8fL1+mjwIWvyrmFlOy+2J+cSo3NaHRqCWgr95YwlK5Kqz7T47kelok/zQgqIAwUA4K
         LZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048435; x=1746653235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP6y8tV/MBufU+zAtH98PgJW62lVroSTuZx+Ob9W8Ao=;
        b=vsrylEKDIGu6W/M/t9fn3cKIhyNUehBV6YufRpmzqodoP8biCB9OgHhG11H74Z+2nB
         1nyKFUQZ+iE5TIBK7julFLEZA1wh7/KqHfIvOf/KWh5/EyoSWvIrToVWjscRgn+GEyF8
         jiyXqTfRAxr5N3jBdbEUAko1GsdgAujDdJPeQyWPi2S5pSs8cPhNUpGP+PbLkLTzamB6
         cvqZNzrtswEFaXUWNHE83i/1sRCEj3GQihEfUThnV+VgXAwnwXqN+w8vD3zfcZRDEtaN
         9hpfgWAj9KF7OI23WxSgytzWpihG5T/VePJtkBQVNcFEwQ3dc4qsHtlsnACwtYD5fSma
         TQ2Q==
X-Gm-Message-State: AOJu0YyirvSBBNWl+MWnU2FRKc2pJBpAl1ycQmgGZ8cXePL9wLBycUSU
	pDynR95L7CMh2u4lAyUifaOU+7GkzmX0G2fBYDhA4+TmlJmk0ue2n07WmQ==
X-Gm-Gg: ASbGncukKegY4C2N9XMBVyM3JlUggG4YsI4YpvKccjSZCU7qiJyHNadh8DeSZ34MjdH
	O/i3qKfWbX02QlqYUMMHU99TVH1L4qN6Vs+UxHJIEvrpRM2f8XiCJN9eTsRHn/D/E4AZGVUe+gh
	vsjxo1NtpS81+y2mlK/jjk1r1dmwMfoLsaLLtGlEniQPYefPtVNWsKJAy8Su4D+JUGg32HYVrvS
	uqXoKIFV5lefKQYaV/tTJPqfzuItrU60RAbXzVUqMF3qyz+NdG6z/ejWzsiVHwBk5y+BTW4+4Lk
	12aSduABwZAEFSHJ+nP/7Z6IwEDIGGblDiYPhREhwYzyii2ZKgW0+eYcqnpPSG6x3EFg
X-Google-Smtp-Source: AGHT+IFIPFDumS4fZ0FhLIBobcPTzWcbel9HMYShj26RYkdxnd4Jq770dDNYDS9i8p1SpXwBaeUs2g==
X-Received: by 2002:a05:6a21:339d:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-20bd81404cbmr41289637.31.1746048434949;
        Wed, 30 Apr 2025 14:27:14 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:14 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 04/16] xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
Date: Wed, 30 Apr 2025 14:26:51 -0700
Message-ID: <20250430212704.2905795-5-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 8ef1d96a985e4dc07ffbd71bd7fc5604a80cc644 ]

The XFS_SB_FEAT_INCOMPAT_LOG_XATTRS feature bit protects a filesystem
from old kernels that do not know how to recover extended attribute log
intent items.  Make this check mandatory instead of a debugging assert.

Fixes: fd920008784ea ("xfs: Set up infrastructure for log attribute replay")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_attr_item.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 11e88a76a33c..c5bc6b72e014 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -508,10 +508,13 @@ xfs_attri_validate(
 	struct xfs_attri_log_format	*attrp)
 {
 	unsigned int			op = attrp->alfi_op_flags &
 					     XFS_ATTRI_OP_FLAGS_TYPE_MASK;
 
+	if (!xfs_sb_version_haslogxattrs(&mp->m_sb))
+		return false;
+
 	if (attrp->__pad != 0)
 		return false;
 
 	if (attrp->alfi_op_flags & ~XFS_ATTRI_OP_FLAGS_TYPE_MASK)
 		return false;
@@ -599,12 +602,10 @@ xfs_attri_item_recover(
 	args->hashval = xfs_da_hashname(args->name, args->namelen);
 	args->attr_filter = attrp->alfi_attr_filter & XFS_ATTRI_FILTER_MASK;
 	args->op_flags = XFS_DA_OP_RECOVERY | XFS_DA_OP_OKNOENT |
 			 XFS_DA_OP_LOGGED;
 
-	ASSERT(xfs_sb_version_haslogxattrs(&mp->m_sb));
-
 	switch (attr->xattri_op_flags) {
 	case XFS_ATTRI_OP_FLAGS_SET:
 	case XFS_ATTRI_OP_FLAGS_REPLACE:
 		args->value = nv->value.i_addr;
 		args->valuelen = nv->value.i_len;
-- 
2.49.0.906.g1f30a19c02-goog



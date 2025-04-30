Return-Path: <stable+bounces-139232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12018AA575E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838A34E3EC7
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04942D0276;
	Wed, 30 Apr 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXTlsUlu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059202D0AD1
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048438; cv=none; b=GoKY+D/i0vqy5R0F4Ji0GYH/2Psa7wTisnPjhadZoBUmQuQj8CKAaLcfxcHJXvRj/nPDOck4iDMj3ki9SOkF8XC232PiMEOq5CbOVwhsvTpVlUiKlD6w1Fg6Lq5KHB8pkBWpzfmKB2Joujtbo4ZcyHoAgp3G4rzWhwg3muNZgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048438; c=relaxed/simple;
	bh=/C2w/EUBO6omo2yqKA7XVDL3DzN0hzY/xz5INnQMdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmuFCxeCpOLviHauG7RX0GNio8GhaoX2aU6q4JzX0Nsw6M5QGCvhVynMDRlSoBPf+uYZ0D2UMpsVgoIQZSNr9LnfzF2FOgKXfpQGlfUb+qb4SAiYgiKWj4UBNgomudnXkR4Y9Of8pfbqJxgqmbK5qp9Dq8bdt8t8m1IqPUR21FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXTlsUlu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso410031b3a.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048436; x=1746653236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw3EsRZDPfzWHwYOgvCPj7xNPA3YvXT+Ed8WKcBVCiw=;
        b=JXTlsUluB964UOQIJIdGSub0UevsYB2CFgyXAOEoalXZquMNPYRPJl41Z4tM8GMpAp
         C1N91ytOHlTOIqHtGTLx3u7b3U9gNKmlQ2Xd4cbUK7utQiafaTgU96ivOdgPrVSRozBP
         iyt1q1VQ8bDDzcl2Z9jOOwXMgOScrC0zo0/tVKUyD6vFomCE2hoCvINgojd3F2jezgRE
         3fFO4lzcrrYKDZUHQpKbFqQB7H3Xt7nFkX3xROP7zOHVUN74mc1uCIih9fDeLabf5yQR
         MKiLtcFVXEPkm/+QITCMe5uD2jCBp8ARoZfiHWbYpcQ2Ul1q7upbTjMATfp6ZgywDfPO
         +x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048436; x=1746653236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3EsRZDPfzWHwYOgvCPj7xNPA3YvXT+Ed8WKcBVCiw=;
        b=M1wQYumHJ8IomOLmYtcGqC84DPBa/pzlU9jgJeMnMnOrsNS0kF/gSPuDoof8jBpkSb
         1l2a6bzv069xwDftIz1m5yM7IlWivuLn5hKVYaQrgJAXCIHH5ua4aA8kkqUNb1eYhnUk
         M51iVwNha8R0C3C+4QxXnEM8+bjc5ynsrZx1N11x/rDIO79cNmSElX/BYqRnPwvay3mU
         T8Suw3Od2XwlK9aKG5FsfZLQ2XFnp63wyyp7h4D7MuoZ4H+qxzFbS757hKd6w/iZ0Tu+
         OjcvDYV5TaDZBi8xNkSBtqTkoP6CAIXIB2fCQ0Wxbz5JYOlvYRrYHD0I3HdjaV0H2zRi
         MlDw==
X-Gm-Message-State: AOJu0Yy8P2jO5PVn8jT/LrfqR2v1z1+Rj9XmHUgLnzwCgYAc8GJzfvxW
	DiUc3HXJ50uaDR12lxlmO6kf5DRjU+ZaQSOWxXeZCKf/qM6EFkbaGt0dig==
X-Gm-Gg: ASbGnctiLNIDyPKxG0FKKos02FmVcnDazO8opkx0trzeMUSt/1MbfLSmp+F+92QthZL
	QO/BBO+bi+XdpO9oG56B/0Pcg5tiz0npTIArKAvc6ewaJi+dxLObtQQtBQRergDqd7BspudAm7p
	OL4PmR1nmdhcTyO6oQO+ufpLtWg9QqDMUzkzsPvilx8xFKItRhGN2+SpwPrgW1CsTg4nB7+fSsm
	+fi5ESYTrhBA8MxLCNTmuwHdR9yLBwk8SKYHhM7IEtycAWdce3FBK4iEchJYKMwGHKTJzOMUk5B
	+BPErj2aWpjZkiafPcobSYZAUBd2xK2PrLULxstTflrS8cb3z/xThqwV92WX44gEarS6
X-Google-Smtp-Source: AGHT+IEQlZ8uWmOUQw87ZwCUphxTJsaS1XSlvRcACLzinJcVeYREVjSafl62D+ySmWiw+9pqRG0xmg==
X-Received: by 2002:a05:6a00:888:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-7403a807540mr5767450b3a.16.1746048436092;
        Wed, 30 Apr 2025 14:27:16 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:15 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 05/16] xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
Date: Wed, 30 Apr 2025 14:26:52 -0700
Message-ID: <20250430212704.2905795-6-leah.rumancik@gmail.com>
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

[ Upstream commit ad206ae50eca62836c5460ab5bbf2a6c59a268e7 ]

Check that the number of recovered log iovecs is what is expected for
the xattri opcode is expecting.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_attr_item.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index c5bc6b72e014..a8e09ea2622d 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -715,28 +715,55 @@ xlog_recover_attri_commit_pass2(
 	struct xfs_attri_log_format     *attri_formatp;
 	struct xfs_attri_log_nameval	*nv;
 	const void			*attr_value = NULL;
 	const void			*attr_name;
 	size_t				len;
+	unsigned int			op;
 
 	attri_formatp = item->ri_buf[0].i_addr;
 	attr_name = item->ri_buf[1].i_addr;
 
 	/* Validate xfs_attri_log_format before the large memory allocation */
 	len = sizeof(struct xfs_attri_log_format);
 	if (item->ri_buf[0].i_len != len) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
 		return -EFSCORRUPTED;
 	}
 
 	if (!xfs_attri_validate(mp, attri_formatp)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
 		return -EFSCORRUPTED;
 	}
 
+	/* Check the number of log iovecs makes sense for the op code. */
+	op = attri_formatp->alfi_op_flags & XFS_ATTRI_OP_FLAGS_TYPE_MASK;
+	switch (op) {
+	case XFS_ATTRI_OP_FLAGS_SET:
+	case XFS_ATTRI_OP_FLAGS_REPLACE:
+		/* Log item, attr name, attr value */
+		if (item->ri_total != 3) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
+	case XFS_ATTRI_OP_FLAGS_REMOVE:
+		/* Log item, attr name */
+		if (item->ri_total != 2) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
+	default:
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				     attri_formatp, len);
+		return -EFSCORRUPTED;
+	}
+
 	/* Validate the attr name */
 	if (item->ri_buf[1].i_len !=
 			xlog_calc_iovec_len(attri_formatp->alfi_name_len)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
-- 
2.49.0.906.g1f30a19c02-goog



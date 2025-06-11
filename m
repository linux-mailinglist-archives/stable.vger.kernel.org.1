Return-Path: <stable+bounces-152469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9CAD6095
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CE31BC24CB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687372BDC28;
	Wed, 11 Jun 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRGWkvYl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C1F4CB7
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675711; cv=none; b=H5ASANM+lkUEQS/PKlG73sxkFkXbTxLNMcD6gcVyccgDHALmn1nn0umppvlI4mOz/+2nuTDQ8EyoW+5B6Jik1BRUtyadYBOkz0SdDypFFUBMbSxgspJtjKAMNdwWzM/E7WbEhdJ0gbn515MW7o6cgaS9VU6dxirB6S3gIy7tEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675711; c=relaxed/simple;
	bh=E6HuokVV46EqYg/u6VhOCJDPHsWttmL+/ZRAmcizVuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOQ6CHAnNKkZkFUdjp+lUmrHTtPHhp83SyhlXwthP4orIQh6WxPobc98MAI0PNM7VSx2bF2w4jkkdxwQlJ+wu8nu2K5/O4U9TVzldsGO783L7Jmqn+JVSzPvnmnTu+kWjTrW8QRS/XYZcEKK2rqEr570MoJBE5gkCiC8LQWiLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRGWkvYl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2352e3db62cso2593675ad.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675709; x=1750280509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/OqZHSg/WUf1DCn0zGOkY7FlNVx7KSzO6R1h+mnq3w=;
        b=PRGWkvYlDgt4vH44vxJdaumbVQ4K1x1MkDSd06hNN8OtaPj8hlTxYLVV15WiGB237y
         oTakfbYG5e2B7xNjvbmWCsAHIMqZEuI+MpZxwPpZvhsF7h5ZnOAIBc9LzrmGX912T6o1
         8iBmfrCXpUAaEQW9OJl7UXAGcdM4wfmI/auhgiuEgO0FhYWeFO4DKuSBUHmXlu5f+7y9
         uWjPTrsia2qYaCcST/CquYcsqUuMtjpLJnqTmgu2BPZCWkoM8Rx7q6zINgRApWdK7hMK
         eGiGCRQXf2DNdtQm0t+1eaVuYjJnwmwnaLXjZD97zVVlFJVe/SORgyZTyhPLC/uK4/X3
         r1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675709; x=1750280509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/OqZHSg/WUf1DCn0zGOkY7FlNVx7KSzO6R1h+mnq3w=;
        b=CID/VCQrqGmm/7joqNhpkdQN7Wn34WMj1bsLiOhp6OIFwY5+8nbd0/oB0jUtt8IskN
         YqJq6gPQMni5/PD0V4zEzWaPjSGyj659shK7ZPfYxhFTukEL6+iv7VMx4d75mK9ssGo5
         BlyIwLMsX0/Ckw5nYvX2kTjYq7sl7qwL7S7/Ss0Fz48yEPLvvMaG68r6uF2Jqmatw1xJ
         yxtu1hC0yYHHIW4mJDvH3+nSm9rDzanxooFjUfxHJkfPpiZbIeBgmdHJHUgF0pxroC/J
         qQ/vcfxg8olibHB0C/IiNx4/l/sTxFSqSsfnAYwUHxthQnFHf4YPyx8nyaJseKS9zfdG
         5Lcw==
X-Gm-Message-State: AOJu0YxcPqAkaVSd8g0YIbFbpYbZtMEsk7HnDraAdnlYIAsp4BusJQQQ
	J/CK1Ias/eMYly/Byo+kIEhq+t+qYCBxJ7vthvjxkdgay22hkTcxigxfAYJT2yVk
X-Gm-Gg: ASbGncviLoIE3Q2yGHEixeUTSZOdxX973fLa3NzKtwvTMFsufakVw3fy73FhkMX9xfP
	2zWWBteqYxxsSbg5Q7XQYxIjI9hh6DBd1dfXXgjimWMaNl/ll6rJdQKEVz4EUPfRc3EYAFVJylr
	4n4wB/I4JJX+hoycqTgmELlDO1oSJtws6U44xUe29FOGiXKB8sQWh1G/ZcJpX0bSq2El3jxibCV
	yWguZYISzBB0gHmatj2WVdohJA/6yLnsQqI8OgTfvEN/SHrVPxUezRDm/GkSrUIbMEtq0oIYast
	tAKulnV/fU4PNKkKZ5yDR/O1JnPdrxK4z/l46yl1Xw8jRpm0NlktQGgQ2opd704+x8KznoskE1/
	Fy9UQlkm5g/I=
X-Google-Smtp-Source: AGHT+IH+De31efZ6blDRg7Yb25ZZBlzqDXArzx3m2qG8g/geLhowlzjlSzlm82sH3w2R4gMVm+WNcQ==
X-Received: by 2002:a17:903:2a85:b0:234:d292:be7f with SMTP id d9443c01a7336-23641b1aa78mr63839875ad.31.1749675708865;
        Wed, 11 Jun 2025 14:01:48 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:48 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 15/23] xfs: Fix xfs_prepare_shift() range for RT
Date: Wed, 11 Jun 2025 14:01:19 -0700
Message-ID: <20250611210128.67687-16-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit f23660f059470ec7043748da7641e84183c23bc8 ]

The RT extent range must be considered in the xfs_flush_unmap_range() call
to stabilize the boundary.

This code change is originally from Dave Chinner.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index dabae6323c50..bab8ba224e10 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1057,33 +1057,35 @@ xfs_free_file_space(
 static int
 xfs_prepare_shift(
 	struct xfs_inode	*ip,
 	loff_t			offset)
 {
-	struct xfs_mount	*mp = ip->i_mount;
+	unsigned int		rounding;
 	int			error;
 
 	/*
 	 * Trim eofblocks to avoid shifting uninitialized post-eof preallocation
 	 * into the accessible region of the file.
 	 */
 	if (xfs_can_free_eofblocks(ip)) {
 		error = xfs_free_eofblocks(ip);
 		if (error)
 			return error;
 	}
 
 	/*
 	 * Shift operations must stabilize the start block offset boundary along
 	 * with the full range of the operation. If we don't, a COW writeback
 	 * completion could race with an insert, front merge with the start
 	 * extent (after split) during the shift and corrupt the file. Start
-	 * with the block just prior to the start to stabilize the boundary.
+	 * with the allocation unit just prior to the start to stabilize the
+	 * boundary.
 	 */
-	offset = round_down(offset, mp->m_sb.sb_blocksize);
+	rounding = xfs_inode_alloc_unitsize(ip);
+	offset = rounddown_64(offset, rounding);
 	if (offset)
-		offset -= mp->m_sb.sb_blocksize;
+		offset -= rounding;
 
 	/*
 	 * Writeback and invalidate cache for the remainder of the file as we're
 	 * about to shift down every extent from offset to EOF.
 	 */
-- 
2.50.0.rc1.591.g9c95f17f64-goog



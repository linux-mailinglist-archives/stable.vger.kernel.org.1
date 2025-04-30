Return-Path: <stable+bounces-139237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E617FAA5767
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1554B9A01D5
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E52D26A4;
	Wed, 30 Apr 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HApuJgWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D422D269A
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048444; cv=none; b=I8hmxyqVeS/29xOz5WQVhQfe3wyLx8YWNt5ds9mxSyidvmxjxmO+OXUhVGJNcCpDHecDWdViSwe4v/0P4n8h3/UlnqrfVPkt1SeFmlRev8VV2rEIGaq4a6GJ+CYZJVw5fuDr4RflOExd0atzDi8bNLBn+TS534pULCXRs17gL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048444; c=relaxed/simple;
	bh=AxU1PCPMNzTpK2dML3ykACJXt0GqU1WLf87wllPZ5zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbMOi0axkIunbXH05QqDEmynSSOt2/dXCfeQUZwTP0AE1yJOXocoG+SgJoPSXs/6KWFbF7zUbgmMvNEFjojavAOMpFDXcqhiUosvpiIUUMp4KbTPwWF/Bb5dnPFTkumB9XWUC2giO2Vbm5xB0FIH0bqtwXdjqA3yTV2ANAYJAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HApuJgWB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739525d4e12so414214b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048441; x=1746653241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnRmPQVA1Lv4J5tLQ1ySaelPMO4dcOIqB/814wDFbuw=;
        b=HApuJgWBr75Og6kCpTQ4yFbXYXCuWhYzlNwV7/uexLEtZj5LAsWmWMq0/kISy892Na
         +KJSw3iebfRofxtobvffQ7MIZd4PhmWDLRQ/rKxmROWV/gZ6SIkK2hpeOjSSC8Sbczok
         Oy8b5mSBcSfTWE5kqqACkzdi5E1kVPXAkaRSk6xoGAhjyYT5PEwqRm6dJIEg7Ly7WhPC
         2T/5zBiO2gk9CIHrDSTUrd7s9NzcjB601XB9/BwREpuO0SlwajN/EQynOHLrl7ZIDtOA
         zL8US6wEOdhssvJG990jD+4OIBrefsM/fzj8+ABsNA7cRfl2SlkyTsAxfinLn5+de2ZL
         8DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048441; x=1746653241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnRmPQVA1Lv4J5tLQ1ySaelPMO4dcOIqB/814wDFbuw=;
        b=aXz8KXoQ2nws8mqCnARXbXR/e2gMwUMYdwNaAlbleevehIVgSyEqY7UaRxqzlSI0Ve
         Jcxpgdz0pgZ7t4mzWMoGjTDcW4fsUTuAQP1x+h+d9YxBtnFFVaoOula2lYL5xbkRtbMC
         BGIHsY9Jtm/+9aFWF73qCOzsI05qtub6CX4YpD98qAXqO22IcPgHcs8PRCqTQugszQpD
         Q7gF9tdfkM4njSdaf3PuaDnvDTbji73WGRYw9eYJydEQyjyIThqx4q6diqIcoqV6drC5
         ru4hP5+b2BLii6uwQBYn9wRNJUlveI9D8z6R1YCPrzIkroyl0f9Nx8hU06lFi79LIrcD
         H8UQ==
X-Gm-Message-State: AOJu0YwpbwaWNvhSD0E96w+LDGaTMm1iNw30DW4CvzUngcBKEJx1sOsw
	K4qOS8QgcQTUYJSfoqXUWqwaGTeDjZdG8PKmlVPmkCC/NYQMzsKg7b+2hVTA
X-Gm-Gg: ASbGncs5JN1ST2m3blDDTIFEA7/58mZNXx0JiZA8P3A8f6ef7bHHRTVRtu1ijbHPR9v
	W58pYr/Eldu2PbWI8DH6yKSKs4VMkotBrj07R4bHBkkzQaOR86y3JjKfhhQtH10lxMA+mCk0Lxh
	qOtzjmk5grRdAkLMHZSGp88NiJuKg3WexLzjFYcZazTzHALUWyu9pvzMfPrypOEKvvSA4jo2w8A
	yH1ob8GAFUyDWK/Px+5wfgsB3aN82hJe5QabHjxtZ4NVoSFRBFVUcr8nOwjnmLqYQHkhCayH0IQ
	BtZMcWIYE+yihtatG4jvHK2BhdtpF2yVvbqAvoNtFfh8TI480k3xQyea/AUob6+AgKl8
X-Google-Smtp-Source: AGHT+IHmYwprTi/3uglvRumq27F08nzui4uIYqL2nCeabt7bSwmq5jhpoZA8Cv+PJ8u1jXAB1c5yfQ==
X-Received: by 2002:a05:6a20:12d5:b0:203:9660:9e4a with SMTP id adf61e73a8af0-20bd89429ebmr29125637.41.1746048441390;
        Wed, 30 Apr 2025 14:27:21 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:20 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Zhang Yi <yi.zhang@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 10/16] xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
Date: Wed, 30 Apr 2025 14:26:57 -0700
Message-ID: <20250430212704.2905795-11-leah.rumancik@gmail.com>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 2e08371a83f1c06fd85eea8cd37c87a224cc4cc4 ]

Since xfs_bmapi_convert_delalloc() only attempts to allocate the entire
delalloc extent and require multiple invocations to allocate the target
offset. So xfs_convert_blocks() add a loop to do this job and we call it
in the write back path, but xfs_convert_blocks() isn't a common helper.
Let's do it in xfs_bmapi_convert_delalloc() and drop
xfs_convert_blocks(), preparing for the post EOF delalloc blocks
converting in the buffered write begin path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 34 +++++++++++++++++++++++--
 fs/xfs/xfs_aops.c        | 54 +++++++++++-----------------------------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 92d321dd8944..a3c4d4a442af 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4520,12 +4520,12 @@ xfs_bmapi_write(
  * Convert an existing delalloc extent to real blocks based on file offset. This
  * attempts to allocate the entire delalloc extent and may require multiple
  * invocations to allocate the target offset if a large enough physical extent
  * is not available.
  */
-int
-xfs_bmapi_convert_delalloc(
+static int
+xfs_bmapi_convert_one_delalloc(
 	struct xfs_inode	*ip,
 	int			whichfork,
 	xfs_off_t		offset,
 	struct iomap		*iomap,
 	unsigned int		*seq)
@@ -4649,10 +4649,40 @@ xfs_bmapi_convert_delalloc(
 	xfs_trans_cancel(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
 
+/*
+ * Pass in a dellalloc extent and convert it to real extents, return the real
+ * extent that maps offset_fsb in iomap.
+ */
+int
+xfs_bmapi_convert_delalloc(
+	struct xfs_inode	*ip,
+	int			whichfork,
+	loff_t			offset,
+	struct iomap		*iomap,
+	unsigned int		*seq)
+{
+	int			error;
+
+	/*
+	 * Attempt to allocate whatever delalloc extent currently backs offset
+	 * and put the result into iomap.  Allocate in a loop because it may
+	 * take several attempts to allocate real blocks for a contiguous
+	 * delalloc extent if free space is sufficiently fragmented.
+	 */
+	do {
+		error = xfs_bmapi_convert_one_delalloc(ip, whichfork, offset,
+					iomap, seq);
+		if (error)
+			return error;
+	} while (iomap->offset + iomap->length <= offset);
+
+	return 0;
+}
+
 int
 xfs_bmapi_remap(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		bno,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 21c241e96d48..50a7f2745514 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -223,66 +223,28 @@ xfs_imap_valid(
 	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
 		return false;
 	return true;
 }
 
-/*
- * Pass in a dellalloc extent and convert it to real extents, return the real
- * extent that maps offset_fsb in wpc->iomap.
- *
- * The current page is held locked so nothing could have removed the block
- * backing offset_fsb, although it could have moved from the COW to the data
- * fork by another thread.
- */
-static int
-xfs_convert_blocks(
-	struct iomap_writepage_ctx *wpc,
-	struct xfs_inode	*ip,
-	int			whichfork,
-	loff_t			offset)
-{
-	int			error;
-	unsigned		*seq;
-
-	if (whichfork == XFS_COW_FORK)
-		seq = &XFS_WPC(wpc)->cow_seq;
-	else
-		seq = &XFS_WPC(wpc)->data_seq;
-
-	/*
-	 * Attempt to allocate whatever delalloc extent currently backs offset
-	 * and put the result into wpc->iomap.  Allocate in a loop because it
-	 * may take several attempts to allocate real blocks for a contiguous
-	 * delalloc extent if free space is sufficiently fragmented.
-	 */
-	do {
-		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
-				&wpc->iomap, seq);
-		if (error)
-			return error;
-	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
-
-	return 0;
-}
-
 static int
 xfs_map_blocks(
 	struct iomap_writepage_ctx *wpc,
 	struct inode		*inode,
 	loff_t			offset)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	ssize_t			count = i_blocksize(inode);
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
 	xfs_fileoff_t		cow_fsb;
 	int			whichfork;
 	struct xfs_bmbt_irec	imap;
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
 	int			error = 0;
+	unsigned int		*seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
 	/*
@@ -374,11 +336,23 @@ xfs_map_blocks(
 
 	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
-	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
+	/*
+	 * Convert a dellalloc extent to a real one. The current page is held
+	 * locked so nothing could have removed the block backing offset_fsb,
+	 * although it could have moved from the COW to the data fork by another
+	 * thread.
+	 */
+	if (whichfork == XFS_COW_FORK)
+		seq = &XFS_WPC(wpc)->cow_seq;
+	else
+		seq = &XFS_WPC(wpc)->data_seq;
+
+	error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+				&wpc->iomap, seq);
 	if (error) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
 		 * raced with a COW to data fork conversion or truncate.
 		 * Restart the lookup to catch the extent in the data fork for
-- 
2.49.0.906.g1f30a19c02-goog



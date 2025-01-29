Return-Path: <stable+bounces-111219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC9A22434
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8323A94DF
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6C1E0E0D;
	Wed, 29 Jan 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTwizYc0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0371E2613
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176461; cv=none; b=BWRGRgR6vCY/gfHWZ8UQZRlwBf0fEipCyvYCtfeTfWIbXvZtytZSwEZETeTdsLAlmDOmDsNCsFuf5APHV9kH2AKcfNcuXCF3UlOIQR28c3D9bh3mJTtAOKqB2n7NfPe68TJOUIMNVg4XsIFxz0a3D9KEuxN8yumcULOpb0WVMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176461; c=relaxed/simple;
	bh=TV4sdDYW00JSd42dzV4sZg+iZemw0WMZ80i7Bh3dkcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fhb9kOhQJ3FQr/zdbXwoFoeKlH+VwLK8g1SD9L7g3KjQKvA6pEDkKR7SYJrruO/DVHeYDyxKwqZI2Uy0EmSP6pJ/3T49RFMhLbcjEOJYCfk+pJhLUHwVcjKwEvsz8g2PXk3P+EZkh/P8vlNnikJ0dHW0tA6Bmo23CrCP4c5JQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTwizYc0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so13895625ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176459; x=1738781259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7LmLmxzI2Mhix3fXbpw61fE8KV02GcxRk3DwTin6Fk=;
        b=mTwizYc0Wb1Kt3OevETx+Iu/iwfItmmvLFRhhcLx8G2b+Vyy/YNhcwMVPTyCiSGc9n
         Bpn1G5Io74e2RO5WBOwX4gySCLP0x4mnXwTtNwI0XJ0zuABiDquPEIb8ec8uw/dZMCFV
         MOfNcJB6RtP2Rj4/Xv3uGqt/YAjPmyhUcz5SaWhpn6S4G1icnX7hMLw1IRsVqV/MEa0a
         earDmCK77xDzK9ovcD/EIvsiTuIzxsmp96wIxH6gU6MAXT7/F/BqVHJmSA/mpx9lyIMX
         B1dSSfAfXx1+Y3o9RqeEqRCrPxDeQC6zh8DLb1NbI0BBK9jTCywetSSutsMVzO2m3gk7
         J0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176459; x=1738781259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7LmLmxzI2Mhix3fXbpw61fE8KV02GcxRk3DwTin6Fk=;
        b=UKEjaCtX1MELAdKLybq+JmScDaL9AX0C3mJPidC2B304iII4mrSRk5F8i6Cy9PwYip
         lObtAcU3AoQHlRX3XVTnf/zhExcMejOlEZ2W2lXuGQoiro3FGiZI0gTnIJJ9KvAZ0EuG
         IAum9tp1nraxRtPvPndMy2Eoc3h72PfmUMh4FQ44qas/Z+PSQZM9g12aRyJj2abxHVCO
         NZRPZ6d54azItLaDtXeceZqTheYURopcTTCvuInC8c4wW7FvPThpXQLYdlK6yDzri4TT
         mgiNW9e+S5rtHH/xhEx3PWHjTGMT8gI7Ysyrf4c1e/kZjRxtfus33e5jZVYyx+U8P5I2
         svsQ==
X-Gm-Message-State: AOJu0Ywk69RbCCpf/NXeIHJXMqPWp+MO3vIJT8PPKn8u1C56hVzYa57T
	XHBUoed1V76dCNnKwauwPW4JsMzHFzLfvC9aK3WNGEgNDoe5cJztWhG86P/r
X-Gm-Gg: ASbGncs3YfVgw9jEI/wnDiUTnWL8F8eAWdMrlF8NJlQzQIHsJDBT39fkFpjtjN6+x6m
	nXyWoLH0dUj6mg3WoSrjEqslpwKyIY5CCEbSqfzW7uShlYhhF2IGxDlNh4vUqPAnameJui2LDEb
	WZXqkTFU71+yObwGvzmEoX586qgpmfTgVtZ4n6ICf/0r+oESF+0+f41Wwaltk9oDTDM/BNLULeR
	jThtEie6uwvIv9ZL64M52kmdcQ/5R0ZPctZXwCHPJIE4G12AIkdAmktwsEoBEEPIluYZKQ3G/Je
	f7qHvg81WTZ4/hYJQZkN+WQy5Q7OjSxKw0wMwhRSSP0=
X-Google-Smtp-Source: AGHT+IFBZ+oHH9MBdREyQZPdnr/QgaHRR/xhI+KbRO7dn9ZMm+ksHZH8nCx6ZpEbXtdBKguODSDJ4Q==
X-Received: by 2002:a17:903:244b:b0:216:4a8a:2665 with SMTP id d9443c01a7336-21dd7df43c7mr65124095ad.50.1738176458614;
        Wed, 29 Jan 2025 10:47:38 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:38 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 08/19] xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
Date: Wed, 29 Jan 2025 10:47:06 -0800
Message-ID: <20250129184717.80816-9-leah.rumancik@gmail.com>
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

[ Upstream commit 35dc55b9e80cb9ec4bcb969302000b002b2ed850 ]

If xfs_bmapi_write finds a delalloc extent at the requested range, it
tries to convert the entire delalloc extent to a real allocation.

But if the allocator cannot find a single free extent large enough to
cover the start block of the requested range, xfs_bmapi_write will
return 0 but leave *nimaps set to 0.

In that case we simply need to keep looping with the same startoffset_fsb
so that one of the following allocations will eventually reach the
requested range.

Note that this could affect any caller of xfs_bmapi_write that covers
an existing delayed allocation.  As far as I can tell we do not have
any other such caller, though - the regular writeback path uses
xfs_bmapi_convert_delalloc to convert delayed allocations to real ones,
and direct I/O invalidates the page cache first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_bmap_util.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index ce8e17ab5434..468bb61a5e46 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -778,49 +778,47 @@ xfs_alloc_file_space(
 	xfs_off_t		offset,
 	xfs_off_t		len)
 {
 	xfs_mount_t		*mp = ip->i_mount;
 	xfs_off_t		count;
-	xfs_filblks_t		allocated_fsb;
 	xfs_filblks_t		allocatesize_fsb;
 	xfs_extlen_t		extsz, temp;
 	xfs_fileoff_t		startoffset_fsb;
 	xfs_fileoff_t		endoffset_fsb;
-	int			nimaps;
 	int			rt;
 	xfs_trans_t		*tp;
 	xfs_bmbt_irec_t		imaps[1], *imapp;
 	int			error;
 
 	trace_xfs_alloc_file_space(ip);
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
 	error = xfs_qm_dqattach(ip);
 	if (error)
 		return error;
 
 	if (len <= 0)
 		return -EINVAL;
 
 	rt = XFS_IS_REALTIME_INODE(ip);
 	extsz = xfs_get_extsz_hint(ip);
 
 	count = len;
 	imapp = &imaps[0];
-	nimaps = 1;
 	startoffset_fsb	= XFS_B_TO_FSBT(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSB(mp, offset + count);
 	allocatesize_fsb = endoffset_fsb - startoffset_fsb;
 
 	/*
 	 * Allocate file space until done or until there is an error
 	 */
 	while (allocatesize_fsb && !error) {
 		xfs_fileoff_t	s, e;
 		unsigned int	dblocks, rblocks, resblks;
+		int		nimaps = 1;
 
 		/*
 		 * Determine space reservations for data/realtime.
 		 */
 		if (unlikely(extsz)) {
@@ -882,19 +880,23 @@ xfs_alloc_file_space(
 		error = xfs_trans_commit(tp);
 		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		if (error)
 			break;
 
-		allocated_fsb = imapp->br_blockcount;
-
-		if (nimaps == 0) {
-			error = -ENOSPC;
-			break;
+		/*
+		 * If the allocator cannot find a single free extent large
+		 * enough to cover the start block of the requested range,
+		 * xfs_bmapi_write will return 0 but leave *nimaps set to 0.
+		 *
+		 * In that case we simply need to keep looping with the same
+		 * startoffset_fsb so that one of the following allocations
+		 * will eventually reach the requested range.
+		 */
+		if (nimaps) {
+			startoffset_fsb += imapp->br_blockcount;
+			allocatesize_fsb -= imapp->br_blockcount;
 		}
-
-		startoffset_fsb += allocated_fsb;
-		allocatesize_fsb -= allocated_fsb;
 	}
 
 	return error;
 
 error:
-- 
2.48.1.362.g079036d154-goog



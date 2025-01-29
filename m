Return-Path: <stable+bounces-111230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA4A2243F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA35188883A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234941E102E;
	Wed, 29 Jan 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0OJW1Iu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B851E1041
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176472; cv=none; b=mf40QgOuUr44VXg0/5zAnARPoW/ThhyCFERlEzMORCxWKYoHwiDUSZMAZs6DeztQKHs1nUUGRSOIOqN9Qqd2O//6Qe4mT9IdOBwIl0LjMoxR/DY3kvrh2C5UlqeFmtXCzbzhqeL4elvVP9W7hQxfPlpbeyQQupzBA/c9ih7xbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176472; c=relaxed/simple;
	bh=Bu9CUpvj9BEBULJXWFd4WlQGMT8/l/D8J/IR1f5Fols=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdH/bBZ9ER1BT/nnBK7xGrRmRki20s4aMKZo6smxSDDCp/edFDxssNbbc1VnYD03ec3AKtNzBhVtihqLxNwNaa42DnVQPMxmY2jj2oelsxlCuMKAxO4Y/kllGZ46wsnVNKWUwR4xE5zMV4V1VMSh2bNKUTVX/52gr76Ut64dPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0OJW1Iu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so21181865ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176471; x=1738781271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eosO51oDAWxFNewJprXYX8TShlUOgBtVoy36axtGyqc=;
        b=i0OJW1IuiyBTFqSa2gxUD0VWUzbhpiehodzaMIytuvcroTAA5qPKFxiI2BwEvggeTM
         sEdooMNfpqCeCMD4MKdqWW0b+q1vkMQpHt+YvbOmEpBQ4hZt/HqYnyAoJmyk2Jtwe53o
         NRjmpRXtnAygGJ90dU85PrK12DYMtd6yJZn8I5hEXwGOAmwE5Ynoy9OM4AkW8GChlmLe
         SxE9lnuAnhNnO1E1qOnp1vk2avqJ1GKCGcqHup57h1uJ275OB9xMNNJcGmNxsU/4/c1i
         5b7If/JLIbPIMN5cQ4urebz7+qkYeJvcSnnyeYkPri3LFbWfup9rPzZB/vzjp9ag2A0N
         UrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176471; x=1738781271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eosO51oDAWxFNewJprXYX8TShlUOgBtVoy36axtGyqc=;
        b=pAxxNOw0s7LcdRStnK6hxnt9XF3qZV3t2lUm+mQ+e7Q4UPQug3Cro4TZQgwoPp0spJ
         AmukasfsqLGFEWv/hqXW01fJVlDDZRXyP56d53JWfCxuBXsxn2wLP0e1y7vLhxO0L5jr
         U9o489kaFC3p3nhWFMsH6Yv0mLwPH44FWcaGvcyGB39VY3dFh2CELIqTn9aKSaKnq31V
         /HaOkffRSOVD0V0L6HhXtafbeOR7mm9q+drDO1UiaF1K4ArJQPeOTR6kZbvclVSGVvT/
         tzj0Z4x5zsP+q/xg3jWMtfOf4dtfWkVOBN8vCaAwBMeLqG0DSSVIg2fufo0s2U1em1a0
         NkEg==
X-Gm-Message-State: AOJu0YxYhznyNPZho4bPOfdduVgxPa66BVDruFbSfnGsa5EP5h9NW2NB
	Jfav9fw08wzOWeqjDVEaXGc/v8tWlLxrbd22XKB4guovl7WygE9J+Sv/fU0Z
X-Gm-Gg: ASbGnctcO2fLTz9BUq9ByO/daOO2SpWpPGwkMffzgTcslanqwS1XoDYIHj+6+S2+S69
	1VO+HEyouwhOtDywNCj7h759LK1zdwXfuoSm5BJM05PBmzyOA4JQXb1gC6bwGx0qe10fDkiJK6e
	ytmt+p27foQvd+Q7otcVXhVmJ+eDlAepdcr9x+tzBFIsRP2L0Bo6C3YPjAGjB0s0G9iwSTKzSw8
	dWPE9SEpkieyyqgg/Pjfv19a8QwmFO9dKq+g4NlgiqiWPZM45dqYOGWwLtXvq5GLkYy/jypnK39
	qj0VcqRxem4EKZZgipvEvH5kN/DuDGq0v2EKaube7O4=
X-Google-Smtp-Source: AGHT+IFwNfIwIqVuHFOjt586BTyMvdlXXdmG+OyLKhhE8/jFgNDTGRFSQuxfP4uIFNlty9+zU0/iQA==
X-Received: by 2002:a17:903:248:b0:215:b18d:ca with SMTP id d9443c01a7336-21de195cd13mr6409065ad.18.1738176469096;
        Wed, 29 Jan 2025 10:47:49 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:48 -0800 (PST)
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
Subject: [PATCH 6.1 18/19] xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
Date: Wed, 29 Jan 2025 10:47:16 -0800
Message-ID: <20250129184717.80816-19-leah.rumancik@gmail.com>
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

[ Upstream commit c421df0b19430417a04f68919fc3d1943d20ac04 ]

Introduce a local boolean variable if FS_XFLAG_REALTIME to make the
checks for it more obvious, and de-densify a few of the conditionals
using it to make them more readable while at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231025141020.192413-4-hch@lst.de
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_ioctl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 85fbb3b71d1c..f6aa9e6138ae 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1118,27 +1118,29 @@ xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	struct fileattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
+	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
 	uint64_t		i_flags2;
 
-	/* Can't change realtime flag if any extents are allocated. */
-	if ((ip->i_df.if_nextents || ip->i_delayed_blks) &&
-	    XFS_IS_REALTIME_INODE(ip) != (fa->fsx_xflags & FS_XFLAG_REALTIME))
-		return -EINVAL;
+	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
+		/* Can't change realtime flag if any extents are allocated. */
+		if (ip->i_df.if_nextents || ip->i_delayed_blks)
+			return -EINVAL;
+	}
 
-	/* If realtime flag is set then must have realtime device */
-	if (fa->fsx_xflags & FS_XFLAG_REALTIME) {
+	if (rtflag) {
+		/* If realtime flag is set then must have realtime device */
 		if (mp->m_sb.sb_rblocks == 0 || mp->m_sb.sb_rextsize == 0 ||
 		    (ip->i_extsize % mp->m_sb.sb_rextsize))
 			return -EINVAL;
-	}
 
-	/* Clear reflink if we are actually able to set the rt flag. */
-	if ((fa->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
-		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+		/* Clear reflink if we are actually able to set the rt flag. */
+		if (xfs_is_reflink_inode(ip))
+			ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+	}
 
 	/* Don't allow us to set DAX mode for a reflinked file for now. */
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
 		return -EINVAL;
 
-- 
2.48.1.362.g079036d154-goog



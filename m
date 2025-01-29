Return-Path: <stable+bounces-111215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC3A22430
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7A91681DB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71DC1E2007;
	Wed, 29 Jan 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIkzNKSP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F211E25E8
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176456; cv=none; b=V/sVn7VxrozUalEgmee+RE91lCCPa+6elE5VlXU/+OoG76rzL7BtEXK9/4PMnhG+imUaXn+ASiu10udqtI7c//3iSCO7r5ruHYpY7N+tMhV8kyaQzTJ+kpSh5QFQoh03dWxQ0X4VFXAInLXmFL2vzyGKD3eGmueeHbv3BjAEl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176456; c=relaxed/simple;
	bh=3evpE/vEdvKDmzcEPYtsFo4LQqpsz/MZkX508oSJgzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MixTwmFUQxkk75I6HD2h0NOla2PKT/ZjGV21zRCjwg9mEnTpUx5wLj8RF75ASrxrEtanBmpTgj+D/PanYQaK1Q9pCYesfzWYbNN8CTNP9HCWKO9sLds7BJickmYmr2VoIbX3mR+GBeugFbM824HWVJp5VpxI0T9g//UyJrdvcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIkzNKSP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21661be2c2dso125378655ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176454; x=1738781254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kh2M5JHe6EolgoJwBypaKFhRMg3u/rgrILdUSJTKcs=;
        b=LIkzNKSPWv/jVLaeysdrW0+skDQNbLtADTt3f5WwcOA85h+C5H2qEZXidlVFTVAiuh
         Wq/JA+78Ci9LqoHmSx7z71vBVnRKupD8g5RZ/6Q+gia3D+9Wl+Q5wSSxVbKHWtMtVg/j
         Q3yPYCU0FK13EAYNXTikJRkzLaPh33Q2r/JegizkheBElZdcJBpq7Q0OjjPkKBJvfm03
         UT4aQZdyXX6yXtFB5yzYWKgJwdppQtJ9/mMth7enzVuI7NyoBrRycoAdaJ4Y/OOoVeq0
         fq80gQsD0/qqD8E2kPa6iZtLb1phxjVrD4Yk/FhfQP7Dyu6yB6h+2RA+DrpQ2eF/m/Kl
         RbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176454; x=1738781254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kh2M5JHe6EolgoJwBypaKFhRMg3u/rgrILdUSJTKcs=;
        b=XsTLErjXYOqB2u/Ed6Mfcob62aGay+5uzv7gFfkGMs0Owzi/Vc3dkw58Y0FmuyP5rT
         vEgB5kfNwQi/w/X94fYkdmOsldMkrWO3vWp80aAG2VT7SS1/ni7zOTM1f0PfqaBRVwES
         8/TpwaKjMjBl4CxfLmxlKE2DzFikIFOkX+ipXGyz+eG0QIcOh/weFvKeb7DsBCZKekRb
         LuU+KoJ9UIMiyUeqCclkz+6xAI4KRIRsjBFDdMFvKs90eGUvm/7lyjudw4fgINw1xwdy
         3MCLJI9DPZo32XDlB73yylu7i2XfRHgoWC6V86qmjALRDmw1Ei120uIyEXjcpq4oSOG0
         Mo4w==
X-Gm-Message-State: AOJu0YwazddkOSlgl16YME6DMZCFMfiDry6/CuQCou7rW7XIHjE3LHhM
	z/NNS5z0sLOiRQoKNvglrA/6Ruxfqo4V99Bpg3q9anmReZ0WtgrcLfrKGA==
X-Gm-Gg: ASbGnct4oH/0jX0x7rd00zIKpIvThcHfA+tVfP+CHJmh4d+Tzr8xrl2XrWzFIC2PCzD
	Fz9mWJArnHLm6aJsCImWbhLztNVMDw7Gbah7XEhnnA5gOPEx7R2glFGtGEZ+qS7WpEnZAPxtNCf
	9o3dzJIXFLqiJuNCVVOG5A/pIzA2v2+Kg/fFZpKhZytEK/0lR+FgCsihj4WKA4svmNqkgp/R3BL
	GEym+18Jv07Q29Y0SKxqt4G5/7qmEN7qsIu3UxRx74Mdy7QTFiO0/QTAFUfYI0emKOerEjj1GQO
	cTAMLij+5GNunzAqQJB0iv3jR7gtuedCzm6oPjGO/po=
X-Google-Smtp-Source: AGHT+IGlRDQgK6DH5nKXWzklyyg394zW9WcBmDvmrrHik7OE5UFJs2k5kH02ok3FUT0EzTr113floQ==
X-Received: by 2002:a17:903:2a8b:b0:216:6283:5a8c with SMTP id d9443c01a7336-21dd7dd240bmr56455015ad.39.1738176454308;
        Wed, 29 Jan 2025 10:47:34 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:33 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 04/19] xfs: rt stubs should return negative errnos when rt disabled
Date: Wed, 29 Jan 2025 10:47:02 -0800
Message-ID: <20250129184717.80816-5-leah.rumancik@gmail.com>
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

[ Upstream commit c2988eb5cff75c02bc57e02c323154aa08f55b78 ]

When realtime support is not compiled into the kernel, these functions
should return negative errnos, not positive errnos.  While we're at it,
fix a broken macro declaration.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_rtalloc.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 3b2f1b499a11..65c284e9d33e 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -139,31 +139,31 @@ bool xfs_verify_rtbno(struct xfs_mount *mp, xfs_rtblock_t rtbno);
 int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
 			       xfs_rtblock_t start, xfs_extlen_t len,
 			       bool *is_free);
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
-# define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)    (ENOSYS)
-# define xfs_rtfree_extent(t,b,l)                       (ENOSYS)
-# define xfs_rtfree_blocks(t,rb,rl)			(ENOSYS)
-# define xfs_rtpick_extent(m,t,l,rb)                    (ENOSYS)
-# define xfs_growfs_rt(mp,in)                           (ENOSYS)
-# define xfs_rtalloc_query_range(t,l,h,f,p)             (ENOSYS)
-# define xfs_rtalloc_query_all(m,t,f,p)                 (ENOSYS)
-# define xfs_rtbuf_get(m,t,b,i,p)                       (ENOSYS)
-# define xfs_verify_rtbno(m, r)			(false)
-# define xfs_rtalloc_extent_is_free(m,t,s,l,i)          (ENOSYS)
-# define xfs_rtalloc_reinit_frextents(m)                (0)
+# define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)	(-ENOSYS)
+# define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
+# define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
+# define xfs_rtpick_extent(m,t,l,rb)			(-ENOSYS)
+# define xfs_growfs_rt(mp,in)				(-ENOSYS)
+# define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
+# define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
+# define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
+# define xfs_verify_rtbno(m, r)				(false)
+# define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
+# define xfs_rtalloc_reinit_frextents(m)		(0)
 static inline int		/* error */
 xfs_rtmount_init(
 	xfs_mount_t	*mp)	/* file system mount structure */
 {
 	if (mp->m_sb.sb_rblocks == 0)
 		return 0;
 
 	xfs_warn(mp, "Not built with CONFIG_XFS_RT");
 	return -ENOSYS;
 }
-# define xfs_rtmount_inodes(m)  (((mp)->m_sb.sb_rblocks == 0)? 0 : (ENOSYS))
+# define xfs_rtmount_inodes(m)  (((mp)->m_sb.sb_rblocks == 0)? 0 : (-ENOSYS))
 # define xfs_rtunmount_inodes(m)
 #endif	/* CONFIG_XFS_RT */
 
 #endif	/* __XFS_RTALLOC_H__ */
-- 
2.48.1.362.g079036d154-goog



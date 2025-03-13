Return-Path: <stable+bounces-124382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60CA602A0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AF43BFBCC
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7B1F4618;
	Thu, 13 Mar 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8YsV3lY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057E1F4603
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897590; cv=none; b=k+Ij0pDr4Wb8hweCjyH2BGH5/WlG3iVGsITTLN/KUMlDQrYbV58QbDbtTsgMq9155c2yhTRT/wX3TlScjps1ESI62mIDCdH4JHR/F1zuXDObUyo9JVeTaaqKsZJeyqV9CSvoyQvKfpZ8WWhP91Ix2680BCK8+srISCriDrvBMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897590; c=relaxed/simple;
	bh=6IsPBRqM/7q7ko5EC4COT+TsqVVTM00wC1fGtButqkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocjrIC7z4jKoGLxIziV85fguNeMiqr0nZU/VflV/wuVKHubAxBuLqEBIuvfxz9PeaHbpJWohvbxPxnopkISebQ2y8b72a8yF6nukIFBYEHXBEw3x6lAYZu1437GGUWTNvEmWk1khyiEgK/uhvEibiAAGBKmWenPiCfNJ/dHqpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8YsV3lY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22548a28d0cso42197945ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897589; x=1742502389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5J1nEwdZJuMcozKjjHSIS6C+RNBgszoq248+dvVtE0=;
        b=F8YsV3lYNjk/xdn0DHBWkfWlQTe6k/IP6FRV26LMlDj5g2snlmSSTgp+MvXIB+Es5X
         55qQPsp2haCazQF6tGi++JkvcQd/MAQeLBvSf0kwS/1odp/eBcrmAZb+zRb2TFROZeYC
         h3cJzXl91qL2wCgPru+tE1LVOOti5n2KOedZMztVWArBQGiIAAXpVdSe3GcJ6FpafLQ2
         J0Jv0OD9rAfw4fx3kNb5M8tWAVNe13z24rQWX6tGXW43I45ank8XWDsTlIl80ix3w6l0
         ZDJakwMYa2PucIehhyx8A1VOYcN+tFzFHjIkNDydgD0VlYjP6rLt9+mT9+pP/MID9CLd
         JQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897589; x=1742502389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5J1nEwdZJuMcozKjjHSIS6C+RNBgszoq248+dvVtE0=;
        b=jdRUtozppYLMHjPQKWoPzEx0KUKVv0hNJhBRfX6zAk4UOQahMiWRyCJQyrWRZXbK6J
         qHM6Uo2L3STi++eUPQINjEQeq2AD/vx17v/aberO0a57AZLmf/OhH0KR2PLlhag4xTmo
         G3RcafK5A5Rq02THEo2ZQDUA601+iHSy73n/Ttd5ipL1YKnXFYNQt/Fngs8XMZWCnjN4
         v09JBHYdR2wb3MdOLNatcyzeBNFkrlRLrnz4ZjaeAYOJbBobR1hudfgwnyfPsJ3RAW5S
         pIb8zVYzRigURNATPSvIywVZpPCRLxDB98xS9356MxNyomClZDUf4Vs5s5pWHZMY/st4
         vFIw==
X-Gm-Message-State: AOJu0YxOOiDGnQRLotNRY+x9hZ8bQBpCOhidRoX2Xd5Sk1R6WuWYecKJ
	bLypEkOJRiV5I5gFrACmtoQi6MvFXZ8C1Rv0UHzrV0A+2pSl702501CRergg
X-Gm-Gg: ASbGncsjBGUIwIMpRnUvO/umcVW7nSCC7GMmoAFfb7vYFx7rOzgdjFI2A/o1NvKpd+c
	KgPPvtIRqxK/UM9lJf+8YrRNM+FDTfdmurH0PSaOgTy+R+Pp7edgJwbXG9yZSHWt2HV/4XoIRpI
	ncArMAxSxGuR8PagSnsVtt+iM+0IYdp/zDDWkojuM6ulDU2pG6PJDseJ+8OPjWUh19q0obOcE4Y
	iTDfVSNGdsENwqL739lP8nwPBNiHCYnfJo2dVCV1JteaWcik0b5Y13uRIzoIIk3CMAEx3WI4SeA
	2OBTNK/xzZGO8Vs2vrIOtgnM5VyXJl5EyiUk1xvTCB9HtII/hG1O2+b+aMbIQMX93y9ql5U=
X-Google-Smtp-Source: AGHT+IHgZDRuVe7UP/+9H2TNcGkG4/AmExQsAmFOxKyOWAzH9yLGtkxJYScdR5rnHX7yvrtTxYOzQw==
X-Received: by 2002:a05:6a21:4508:b0:1f5:64fd:68ea with SMTP id adf61e73a8af0-1f5c10faae7mr110285637.4.1741897588719;
        Thu, 13 Mar 2025 13:26:28 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:28 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 25/29] xfs: fix perag leak when growfs fails
Date: Thu, 13 Mar 2025 13:25:45 -0700
Message-ID: <20250313202550.2257219-26-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 7823921887750b39d02e6b44faafdd1cc617c651 ]

[ 6.1: resolved conflicts in xfs_ag.c and xfs_ag.h ]

During growfs, if new ag in memory has been initialized, however
sb_agcount has not been updated, if an error occurs at this time it
will cause perag leaks as follows, these new AGs will not been freed
during umount , because of these new AGs are not visible(that is
included in mp->m_sb.sb_agcount).

unreferenced object 0xffff88810be40200 (size 512):
  comm "xfs_growfs", pid 857, jiffies 4294909093
  hex dump (first 32 bytes):
    00 c0 c1 05 81 88 ff ff 04 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 381741e2):
    [<ffffffff8191aef6>] __kmalloc+0x386/0x4f0
    [<ffffffff82553e65>] kmem_alloc+0xb5/0x2f0
    [<ffffffff8238dac5>] xfs_initialize_perag+0xc5/0x810
    [<ffffffff824f679c>] xfs_growfs_data+0x9bc/0xbc0
    [<ffffffff8250b90e>] xfs_file_ioctl+0x5fe/0x14d0
    [<ffffffff81aa5194>] __x64_sys_ioctl+0x144/0x1c0
    [<ffffffff83c3d81f>] do_syscall_64+0x3f/0xe0
    [<ffffffff83e00087>] entry_SYSCALL_64_after_hwframe+0x62/0x6a
unreferenced object 0xffff88810be40800 (size 512):
  comm "xfs_growfs", pid 857, jiffies 4294909093
  hex dump (first 32 bytes):
    20 00 00 00 00 00 00 00 57 ef be dc 00 00 00 00   .......W.......
    10 08 e4 0b 81 88 ff ff 10 08 e4 0b 81 88 ff ff  ................
  backtrace (crc bde50e2d):
    [<ffffffff8191b43a>] __kmalloc_node+0x3da/0x540
    [<ffffffff81814489>] kvmalloc_node+0x99/0x160
    [<ffffffff8286acff>] bucket_table_alloc.isra.0+0x5f/0x400
    [<ffffffff8286bdc5>] rhashtable_init+0x405/0x760
    [<ffffffff8238dda3>] xfs_initialize_perag+0x3a3/0x810
    [<ffffffff824f679c>] xfs_growfs_data+0x9bc/0xbc0
    [<ffffffff8250b90e>] xfs_file_ioctl+0x5fe/0x14d0
    [<ffffffff81aa5194>] __x64_sys_ioctl+0x144/0x1c0
    [<ffffffff83c3d81f>] do_syscall_64+0x3f/0xe0
    [<ffffffff83e00087>] entry_SYSCALL_64_after_hwframe+0x62/0x6a

Factor out xfs_free_unused_perag_range() from xfs_initialize_perag(),
used for freeing unused perag within a specified range in error handling,
included in the error path of the growfs failure.

Fixes: 1c1c6ebcf528 ("xfs: Replace per-ag array with a radix tree")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c | 34 +++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_ag.h |  3 +++
 fs/xfs/xfs_fsops.c     |  5 ++++-
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index e7b011c42b7a..9743fa5b5388 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -257,10 +257,34 @@ xfs_agino_range(
 	xfs_agino_t		*last)
 {
 	return __xfs_agino_range(mp, xfs_ag_block_count(mp, agno), first, last);
 }
 
+/*
+ * Free perag within the specified AG range, it is only used to free unused
+ * perags under the error handling path.
+ */
+void
+xfs_free_unused_perag_range(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		agstart,
+	xfs_agnumber_t		agend)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		index;
+
+	for (index = agstart; index < agend; index++) {
+		spin_lock(&mp->m_perag_lock);
+		pag = radix_tree_delete(&mp->m_perag_tree, index);
+		spin_unlock(&mp->m_perag_lock);
+		if (!pag)
+			break;
+		xfs_buf_hash_destroy(pag);
+		kmem_free(pag);
+	}
+}
+
 int
 xfs_initialize_perag(
 	struct xfs_mount	*mp,
 	xfs_agnumber_t		agcount,
 	xfs_rfsblock_t		dblocks,
@@ -350,19 +374,11 @@ xfs_initialize_perag(
 	spin_unlock(&mp->m_perag_lock);
 out_free_pag:
 	kmem_free(pag);
 out_unwind_new_pags:
 	/* unwind any prior newly initialized pags */
-	for (index = first_initialised; index < agcount; index++) {
-		spin_lock(&mp->m_perag_lock);
-		pag = radix_tree_delete(&mp->m_perag_tree, index);
-		spin_unlock(&mp->m_perag_lock);
-		if (!pag)
-			break;
-		xfs_buf_hash_destroy(pag);
-		kmem_free(pag);
-	}
+	xfs_free_unused_perag_range(mp, first_initialised, agcount);
 	return error;
 }
 
 static int
 xfs_get_aghdr_buf(
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 191b22b9a35b..eb84af1c8628 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -104,10 +104,13 @@ struct xfs_perag {
 	struct delayed_work	pag_blockgc_work;
 
 #endif /* __KERNEL__ */
 };
 
+
+void xfs_free_unused_perag_range(struct xfs_mount *mp, xfs_agnumber_t agstart,
+			xfs_agnumber_t agend);
 int xfs_initialize_perag(struct xfs_mount *mp, xfs_agnumber_t agcount,
 			xfs_rfsblock_t dcount, xfs_agnumber_t *maxagi);
 int xfs_initialize_perag_data(struct xfs_mount *mp, xfs_agnumber_t agno);
 void xfs_free_perag(struct xfs_mount *mp);
 
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 77b14f788214..96e9d64fbe62 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -151,11 +151,11 @@ xfs_growfs_data_private(
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_growdata,
 			(delta > 0 ? XFS_GROWFS_SPACE_RES(mp) : -delta), 0,
 			XFS_TRANS_RESERVE, &tp);
 	if (error)
-		return error;
+		goto out_free_unused_perag;
 
 	last_pag = xfs_perag_get(mp, oagcount - 1);
 	if (delta > 0) {
 		error = xfs_resizefs_init_new_ags(tp, &id, oagcount, nagcount,
 				delta, last_pag, &lastag_extended);
@@ -225,10 +225,13 @@ xfs_growfs_data_private(
 	}
 	return error;
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
+out_free_unused_perag:
+	if (nagcount > oagcount)
+		xfs_free_unused_perag_range(mp, oagcount, nagcount);
 	return error;
 }
 
 static int
 xfs_growfs_log_private(
-- 
2.49.0.rc1.451.g8f38331e32-goog



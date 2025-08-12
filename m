Return-Path: <stable+bounces-167100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B55B21E41
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21332626415
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4B2E2843;
	Tue, 12 Aug 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QJsSR8+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9670254B19
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979961; cv=none; b=UIvuD1eII0+/D6EZxTXPqPhuTLQs3OcKwf8jIIebtSrvB9JZY555o1Xmkr3nX0b/WHFmOV1uTpEsTEH1EgRpprBBrMbYgxjHwc/kgY4aq9yNiY4Zxs7WAypBb45NJMHTtv6U0tD1RxohKn8eAlUr2C6pjTKZtt4PxRNtGuDeeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979961; c=relaxed/simple;
	bh=JwoVUph7JdF+eUAGcD2R4C4BHZniihsGUMw3tU+0Hjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QC5XId10n0SaLM6j7U8ZiWHh7WI6KHR9kiH41gkpgeefP8i2Ah0sZg9iG5XUVbPjd5/nnClo2ceJc+wIdYEOSUODneczkhFxXBnuVSwQuJzmfxrbYB7p92GWFRhjCgqd+Xhxt01Mbtvju8yEbeScsh15rD5FAoXv/fYSU4YUgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QJsSR8+m; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e8fd38cb2abso4216271276.0
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979959; x=1755584759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efQ/Khh+wi0B0rIIu872y8FB8xkosRs89Ye5o6WmuwM=;
        b=b0hkgOgjeS/o8x84py3f55/hWikpuGcYVd/Q4soM3PKnF0Xhvt1Vj5HFa5RFszqT6O
         gWxE5j79SV0S+b0Mx/VL12ri7vM8fsN7WwL1RGYc69BY8oKDAsTenMNCP8UUyCiRj1uI
         XuV3nK9Im15nUY3QaTRJcDBnTwgJyr68bPAlRdapq8BwnDfKUF6kQOqPpJvhTI9lGe2Z
         Za1Mn+j+8uu+mLPJMHdafk6IPkUirAbFycrtjQKFLMqMaVdVpKC+6j4zSTFBa7BymTOj
         dJl2dJNKer7NaKt6mXbT6XyNVeRcCNggR6o2ZbRBTIHsKvXcta2bSouUfmFf0meNyRYA
         7cLg==
X-Gm-Message-State: AOJu0Yy1NO5MHzF0QgzCvkmgKZfXeNGXrdmhFN38KU+GZtdVwkid3XX4
	zc5ScnEaUJej5RguBNCyAzSgxPkF72prLhMq6lWcF3zHXqk/bDik+c5Vw0M6l/n2B74BGv1JEUv
	CKBNzN1WfWzpEsjz0FRkl8JfOl2I7jbH8XeyGhN2d5R+6bXyMK2d9AZtAbskX0rbCGW7kdnVvLi
	W1S8zmcnIiuyNyf5OPgA+1va8yTRk3I2ePgS54dI1iz1VulJmIuc3f0vGDoYSHfm6TIj2N4VpT8
	8+fphM9IGl9L2t1OQ==
X-Gm-Gg: ASbGncvHu/YRGFipaGhu0KFouIwStaps1XtXOfu46gMOu9bAKz9qLUNQ64Xr1OAm3bp
	fKojEMs6Vm0g9y2ZrPXfvKAPty7Pcv4UQNX/+IZjBJiy+ozYdhYLD0UjviSIIeoF6iR/mvMRJNF
	67uyUHRRThhQRSB235GnKkCTjdk8JqmtSRD2+i7lf1jP8x1o5B0iLzU1o68HFlzW5RfSZ5FnYqa
	RNEcUn8K2s3cP4qzErSu7e1gea++aW5CkBZcXNNnFjSOUVVr9IPUnhtebrrc+G/EiszJK7AzcYu
	69M4L8Tz8LKxGQ9JgqjAeauR8/LpTnu7cNRByxz+n8OkclMEGo98Uf7Pw3+3IwncgoOWR4os8sN
	mecIZvotXSMf/MdvVgIsxLKloZIIAsaEQ7J7Fq7FS1CMb1CBhbpoRk9GJeNMkidNjcIRJy+XIQn
	FP2sbWNw==
X-Google-Smtp-Source: AGHT+IGg93Tsuti7rzN9PIa1B5OcyXPagC2Ww+ooDTwoesz4U7+OVDWXFY97FLOIbv1XShIK+5DxNHGlF6Lf
X-Received: by 2002:a05:6902:4104:b0:e8f:da14:21a8 with SMTP id 3f1490d57ef6-e917a0e8d41mr2795175276.0.1754979958531;
        Mon, 11 Aug 2025 23:25:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e92f89bd9c2sm9306276.18.2025.08.11.23.25.57
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:25:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400499ab2fso46344395ad.0
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754979956; x=1755584756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efQ/Khh+wi0B0rIIu872y8FB8xkosRs89Ye5o6WmuwM=;
        b=QJsSR8+mK50HbIV2kqKWlPi/pEbTvhnCU0996GgI+pgIm/tBeZkQYG2Mp6Uf1cbOin
         BlO5CpvOX9G/fakcXK2TwqxocxNcSrboUIWj4gV/lsSCALYzXTc15jOERQ9iS8rLvxwq
         QL9YU5CxQVihWU2NH1p983cdnt3pQo8oO1qlo=
X-Received: by 2002:a17:902:f70c:b0:240:3f39:2c73 with SMTP id d9443c01a7336-242fc0eeffamr33535375ad.0.1754979955747;
        Mon, 11 Aug 2025 23:25:55 -0700 (PDT)
X-Received: by 2002:a17:902:f70c:b0:240:3f39:2c73 with SMTP id d9443c01a7336-242fc0eeffamr33534825ad.0.1754979955053;
        Mon, 11 Aug 2025 23:25:55 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9257sm291805895ad.153.2025.08.11.23.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:25:54 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	richardcochran@gmail.com,
	monis@mellanox.com,
	kamalh@mellanox.com,
	haggaie@mellanox.com,
	amirv@mellanox.com,
	dledford@redhat.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] RDMA/rxe: Return CQE error if invalid lkey was supplied
Date: Mon, 11 Aug 2025 23:12:31 -0700
Message-Id: <20250812061231.149309-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit dc07628bd2bbc1da768e265192c28ebd301f509d ]

RXE is missing update of WQE status in LOCAL_WRITE failures.  This caused
the following kernel panic if someone sent an atomic operation with an
explicitly wrong lkey.

[leonro@vm ~]$ mkt test
test_atomic_invalid_lkey (tests.test_atomic.AtomicTest) ...
 WARNING: CPU: 5 PID: 263 at drivers/infiniband/sw/rxe/rxe_comp.c:740 rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Modules linked in: crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel rdma_ucm rdma_cm ib_umad ib_ipoib iw_cm ib_cm mlx5_ib ib_uverbs ib_core mlx5_core ptp pps_core
 CPU: 5 PID: 263 Comm: python3 Not tainted 5.13.0-rc1+ #2936
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Code: 03 0f 8e 65 0e 00 00 3b 93 10 06 00 00 0f 84 82 0a 00 00 4c 89 ff 4c 89 44 24 38 e8 2d 74 a9 e1 4c 8b 44 24 38 e9 1c f5 ff ff <0f> 0b e9 0c e8 ff ff b8 05 00 00 00 41 bf 05 00 00 00 e9 ab e7 ff
 RSP: 0018:ffff8880158af090 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888016a78000 RCX: ffffffffa0cf1652
 RDX: 1ffff9200004b442 RSI: 0000000000000004 RDI: ffffc9000025a210
 RBP: dffffc0000000000 R08: 00000000ffffffea R09: ffff88801617740b
 R10: ffffed1002c2ee81 R11: 0000000000000007 R12: ffff88800f3b63e8
 R13: ffff888016a78008 R14: ffffc9000025a180 R15: 000000000000000c
 FS:  00007f88b622a740(0000) GS:ffff88806d540000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f88b5a1fa10 CR3: 000000000d848004 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_rcv+0xb11/0x1df0 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  rxe_responder+0x5532/0x7620 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_rcv+0x9c8/0x1df0 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  rxe_requester+0x1efd/0x58c0 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_post_send+0x998/0x1860 [rdma_rxe]
  ib_uverbs_post_send+0xd5f/0x1220 [ib_uverbs]
  ib_uverbs_write+0x847/0xc80 [ib_uverbs]
  vfs_write+0x1c5/0x840
  ksys_write+0x176/0x1d0
  do_syscall_64+0x3f/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/11e7b553f3a6f5371c6bb3f57c494bb52b88af99.1620711734.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a54d80004342..b7645de067f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -346,13 +346,15 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
 			payload_size(pkt), to_mem_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
+	}
 
 	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
 		return COMPST_COMP_ACK;
-	else
-		return COMPST_UPDATE_COMP;
+
+	return COMPST_UPDATE_COMP;
 }
 
 static inline enum comp_state do_atomic(struct rxe_qp *qp,
@@ -366,10 +368,12 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
 			sizeof(u64), to_mem_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
-	else
-		return COMPST_COMP_ACK;
+	}
+
+	return COMPST_COMP_ACK;
 }
 
 static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-- 
2.40.4



Return-Path: <stable+bounces-139240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB23AA5768
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1659A546D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A62D110D;
	Wed, 30 Apr 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF/v+zln"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D42BD93D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048447; cv=none; b=C9z+BSluthZSPln+iofjFLtryij1eweO81eEeKB5brLb8oy7/vO91ceZ3FIuM77xzqe//C39mXW/+V9Rhr5Zbq6IFpnDhU5VdVXK1xpJYR5pnVukp/9qIvTaprtJJ5tc7wNhBJf3JUuXlNu3WKfBDmsiuwC44194lI7ExBWftZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048447; c=relaxed/simple;
	bh=ISeX+IgXppU09fG7eUMKWAyAE4hNwAzuzuDb08Ttg4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW8ltInyVrxladp+/ByxrbHTJAcnFzjUmqDWZgi548j0AYH8xR6rilrPbAfEbEw3ZznTCnPMu90hQIs4aJc8rwXTApZL0fwnvt7TvBayBi/KGD9OOcRyYkS/4ClqBG2hybI5rDHVs8m1DwrlLVnf8hFnkUal1NMVNJA2GZjtMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF/v+zln; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736a72220edso433637b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048445; x=1746653245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoVPLl30gtWTaN+FxdBPCH2Xo+QJmupoIuca95cb4s0=;
        b=PF/v+zlnL3rootkvOuU260fFzn4EnRfjEwtgnwCTisNjRjBmTjC/MCenyxudSwoMlR
         oiqYQOmOt1/oIapse5XC6URR7eahIzdWlIXAUUTP+B1TdB/gOnFO8aYZUckfk+kcFID2
         UlqdeR7LpHIP+y/KPRs62V211aaT76MUHFGi5CRcSKYfnMRdUPFZCROh/9RFUHlMdBc8
         OJwWjeesIkUmA9IkAyzZ89d+KA4Kedhzxqz9hE39Bn5XwNaDHqSt3wxuW8xyS7ChzLCe
         t2FY3b7pkVHsherLc47czNGJh67Zi2QA4kixtTPSHdktJuqkpuwZCWnMDZiuzcLNzeXl
         /p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048445; x=1746653245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoVPLl30gtWTaN+FxdBPCH2Xo+QJmupoIuca95cb4s0=;
        b=KrbYrsBE0h3IWchO1enlvMg14bsBM2arkNnTo1pU7uWC90yXOHLEDbPztUGoTWH381
         Eo8gSrqL1X1iTRi9C12kRil6D5UTqrUNwGB+zWe2q7cqiKs06WnU2nyJ27KJwBV6Kywr
         sM/6ul6suiS+pM12w49D9uFocwZZXPVGGDraMY64lxhTQ6IV1RPm2YBowrgM2wpD2Uis
         yC1D91+0lK4ANVz4ytfX3aquRJOnEPQuKNXyps627y5owlRgrL/HTeINSXSUSkcBNiTF
         EuyRDDiU50H0hLUgH+6FuEI7D60r3p/L/GdX1UPo3iYj7Ks7Kvoetnay42DmK207V4Kq
         WQdw==
X-Gm-Message-State: AOJu0YzGdzvzgdalCQgZxlMNCC8wSxzrYH9K1Mq3sF05JrFfwhEFRxpj
	vufVvhZl68tFE54l3G4PZ4rO4d6fQrJC1nHdXf+EziFEUjvzo8h9PUOC8sq8
X-Gm-Gg: ASbGncsf3xZC5ignpC6AMFX3NQeDq66IhZI2xb1ug60UKzjQLsqwCZUy4QTFGuqJGjd
	qy6Qat0rCBMG54GYZurfEk2Xm8mqhK8g50wmnU2KNjtMnJ0fSWwP/VY+HJqTZDxP5s3DKtaAoCW
	5qjDHeMTAjtFNccDWR19HghDn2oIbjMZmL/gy4OCyEeUvuL4JMoOiWi6Mw/4LoimazocdjHICIW
	EgiOJuF01oxlJEUR0jNvCma2nBS/8vmd14OvH9gkOrbRwtBeAqyOiSYWWXCzftIM8zsAV7ZX1ni
	b6BgwmAMRHaAiFcRwlUFJJW1k0f1mD5t+naKngrDTs6UOwfuThIYPnP6dfVcPznA4Ztw
X-Google-Smtp-Source: AGHT+IFJ2bGPPg/CNkAdu9EqJ68BKgBdwTujCwGYB/joqHGYNn/OxoIty6W6pRcKZJEhYPdEq3cBxA==
X-Received: by 2002:a05:6a00:1312:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-7404790137cmr638194b3a.19.1746048444834;
        Wed, 30 Apr 2025 14:27:24 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:24 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Wengang Wang <wen.gang.wang@oracle.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 13/16] xfs: make sure sb_fdblocks is non-negative
Date: Wed, 30 Apr 2025 14:27:00 -0700
Message-ID: <20250430212704.2905795-14-leah.rumancik@gmail.com>
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

From: Wengang Wang <wen.gang.wang@oracle.com>

[ Upstream commit 58f880711f2ba53fd5e959875aff5b3bf6d5c32e ]

A user with a completely full filesystem experienced an unexpected
shutdown when the filesystem tried to write the superblock during
runtime.
kernel shows the following dmesg:

[    8.176281] XFS (dm-4): Metadata corruption detected at xfs_sb_write_verify+0x60/0x120 [xfs], xfs_sb block 0x0
[    8.177417] XFS (dm-4): Unmount and run xfs_repair
[    8.178016] XFS (dm-4): First 128 bytes of corrupted metadata buffer:
[    8.178703] 00000000: 58 46 53 42 00 00 10 00 00 00 00 00 01 90 00 00  XFSB............
[    8.179487] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    8.180312] 00000020: cf 12 dc 89 ca 26 45 29 92 e6 e3 8d 3b b8 a2 c3  .....&E)....;...
[    8.181150] 00000030: 00 00 00 00 01 00 00 06 00 00 00 00 00 00 00 80  ................
[    8.182003] 00000040: 00 00 00 00 00 00 00 81 00 00 00 00 00 00 00 82  ................
[    8.182004] 00000050: 00 00 00 01 00 64 00 00 00 00 00 04 00 00 00 00  .....d..........
[    8.182004] 00000060: 00 00 64 00 b4 a5 02 00 02 00 00 08 00 00 00 00  ..d.............
[    8.182005] 00000070: 00 00 00 00 00 00 00 00 0c 09 09 03 17 00 00 19  ................
[    8.182008] XFS (dm-4): Corruption of in-memory data detected.  Shutting down filesystem
[    8.182010] XFS (dm-4): Please unmount the filesystem and rectify the problem(s)

When xfs_log_sb writes super block to disk, b_fdblocks is fetched from
m_fdblocks without any lock. As m_fdblocks can experience a positive ->
negative -> positive changing when the FS reaches fullness (see
xfs_mod_fdblocks). So there is a chance that sb_fdblocks is negative, and
because sb_fdblocks is type of unsigned long long, it reads super big.
And sb_fdblocks being bigger than sb_dblocks is a problem during log
recovery, xfs_validate_sb_write() complains.

Fix:
As sb_fdblocks will be re-calculated during mount when lazysbcount is
enabled, We just need to make xfs_validate_sb_write() happy -- make sure
sb_fdblocks is not nenative. This patch also takes care of other percpu
counters in xfs_log_sb.

Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 90ed55cd3d10..8e0a176b8e0b 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1020,15 +1020,16 @@ xfs_log_sb(
 	 * sb counters, despite having a percpu counter. It is always kept
 	 * consistent with the ondisk rtbitmap by xfs_trans_apply_sb_deltas()
 	 * and hence we don't need have to update it here.
 	 */
 	if (xfs_has_lazysbcount(mp)) {
-		mp->m_sb.sb_icount = percpu_counter_sum(&mp->m_icount);
+		mp->m_sb.sb_icount = percpu_counter_sum_positive(&mp->m_icount);
 		mp->m_sb.sb_ifree = min_t(uint64_t,
-				percpu_counter_sum(&mp->m_ifree),
+				percpu_counter_sum_positive(&mp->m_ifree),
 				mp->m_sb.sb_icount);
-		mp->m_sb.sb_fdblocks = percpu_counter_sum(&mp->m_fdblocks);
+		mp->m_sb.sb_fdblocks =
+				percpu_counter_sum_positive(&mp->m_fdblocks);
 	}
 
 	xfs_sb_to_disk(bp->b_addr, &mp->m_sb);
 	xfs_trans_buf_set_type(tp, bp, XFS_BLFT_SB_BUF);
 	xfs_trans_log_buf(tp, bp, 0, sizeof(struct xfs_dsb) - 1);
-- 
2.49.0.906.g1f30a19c02-goog



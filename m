Return-Path: <stable+bounces-124384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344BA602A2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B2F17E8B7
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC31F462A;
	Thu, 13 Mar 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlWFusnJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A91F4603
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897592; cv=none; b=qFlFGEE79dh5aHxbOWXXdtLiLEpd7cytl+dEol4MJSLHzAjbmwVJr1pssjcKYoj15plxLXlLqmJ6zJpIPsSg1/XHuQTTJUnB3monsqSLYpqeUTJ/w0CKTh0lzY9T65NsUC6WdutKqPgGdpDeyWmieoA2Z1qtI02J4tC3ISVsViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897592; c=relaxed/simple;
	bh=C2AYapri8dHR0vPu1kWvED7yybfdaI/1XP2EFVL7G5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0yfmFYC1nHGt+Hx3xmI38OnMkvkbFghUNUcSh1LfSarMaGiokZaP8vUs19HGBkI7/9Cj/0FtTtHf1MaDnzHCZ4KT92ok3end0C7lCxFZiC75vB9i2ykPqbw4qml2xqYaej3O6g5rtv0ULygY0MDCe91FyZvomJ5IOZ/psZgn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlWFusnJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223a7065ff8so38661015ad.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897591; x=1742502391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afiF4cfd6IcYhAZLp1rmwPsF0onksTofU0yIKwpYFzg=;
        b=SlWFusnJDVXoA68jjGBFqXKufNkU4uy5CWY0t2WFSmj0CQ490VAohIasRDhAaIqjbF
         5pnYToW3AxCmcszcehfI3v3qY6Hr+GU7lgICmG/dhPNeta49+gp+er3r4WaDe1gwxw9A
         brekCSrhbY/iVfSyO7VKQSimzJifThIOr3fFlIW7/k9P61wdRT81p1LRYEjntTtoBOBu
         Dwrg85ID0JNKNA9woBMFOrvzXvYxAFzzUipuWBy2s6h1mtrr2FpfLee8xNF8wQakFRFq
         A4sW7ZPIZy3POcX3vsVGJaYwxtud2ADk+NT/yPFSjo3WNLwvWAcQfqNuiP9i468IYyf1
         YkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897591; x=1742502391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afiF4cfd6IcYhAZLp1rmwPsF0onksTofU0yIKwpYFzg=;
        b=wFGhrZ4a7gHTR08vStYUp41iNFhh3cTnOtQEXY8mVXtRvVJaouVXZ0ripj5MRWv45R
         smGaOsyQ+/YdPFiJIaAh1Gz7Zb+8quxP4ACAuFEEAJfz/5l2Mh0dR+LYEkFe1L4wa8kS
         GZDa8NImY/lOPNlKRkBCnkABgonpMgV5461YnzDJ8jp3wQUFLMkqpIhx34O8fYVruDuO
         /7dSHqkh2BSLs1YEjjNeHYXsLKYIuAnlQJqM/P9QPMjVdmDOMy5xk7v5FmnVQ6i5eLtk
         OjLDKPf/gnaAlxR60eLM8muXRt1XYURv9JZ9FBhYLOqx+SQKBoN+KT61tqByhIgU+nfO
         MgBA==
X-Gm-Message-State: AOJu0YwGwe87ANqdedXZM/DncMF4vplntk6WHu8oyEVgtLWP0ucob0qE
	HkT4TSqyrENb3p3AhXgZZQEYOqZK/q3zCkwRCCCg0Bvzf6t5kXb8cyrft/Hp
X-Gm-Gg: ASbGncuJpXr5VPil+BXuMkkiY78VrRaN+rBRMzYKwgT8mgOADDHvMkosSXjStM0e+/n
	VH7fHvQEd7DpfrowQqJD+/IRmhw7DASiOthe5huN6w/F7ezGGpNWrnugawhTV1Ca6lBGqcljpPF
	RhjwEtYQ6PB0u5gDRTG+Q5J5GDzmRqZ7Nuy7Aoi2I8LAsgBTHGjPnU79VwyjPP0JWy46ocUC+Fv
	Vc/sXnoX1dTvwKRED+/w1eUm+wsouBd/YEbn9+vVIUKSMI6NN90oDEkLEIg5WfXIEoBckFX7x4d
	F2yqBxRaPwhOWL8ZpPRiB74sjkqqLaGDfH6m+uZGaTVO4Z8COEw4UhBUu8DzRIJdOGThDI4=
X-Google-Smtp-Source: AGHT+IHkxCJ5wwBR6C5OP9j8WmjtrYJmvU7hJi10xeE8i3QtDvK9x9o27z5PCaPvHHN8aRDF9M2DYA==
X-Received: by 2002:a05:6a21:1f81:b0:1f5:9ffc:274a with SMTP id adf61e73a8af0-1f5c11d94e9mr86060637.23.1741897590704;
        Thu, 13 Mar 2025 13:26:30 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:30 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 27/29] xfs: update dir3 leaf block metadata after swap
Date: Thu, 13 Mar 2025 13:25:47 -0700
Message-ID: <20250313202550.2257219-28-leah.rumancik@gmail.com>
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

From: Zhang Tianci <zhangtianci.1997@bytedance.com>

[ Upstream commit 5759aa4f956034b289b0ae2c99daddfc775442e1 ]

xfs_da3_swap_lastblock() copy the last block content to the dead block,
but do not update the metadata in it. We need update some metadata
for some kinds of type block, such as dir3 leafn block records its
blkno, we shall update it to the dead block blkno. Otherwise,
before write the xfs_buf to disk, the verify_write() will fail in
blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.

We will get this warning:

  XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
  XFS (dm-0): Unmount and run xfs_repair
  XFS (dm-0): First 128 bytes of corrupted metadata buffer:
  00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
  000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
  000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
  00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
  00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
  000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
  00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
  0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
  XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
  XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
  XFS (dm-0): Please umount the filesystem and rectify the problem(s)

>From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
its blkno is 0x1a0.

Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Suggested-by: Dave Chinner <david@fromorbit.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_da_btree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..282c7cf032f4 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2314,14 +2314,21 @@ xfs_da3_swap_lastblock(
 	error = xfs_da3_node_read(tp, dp, last_blkno, &last_buf, w);
 	if (error)
 		return error;
 	/*
 	 * Copy the last block into the dead buffer and log it.
+	 * On CRC-enabled file systems, also update the stamped in blkno.
 	 */
 	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
+	if (xfs_has_crc(mp)) {
+		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr;
+
+		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
+	}
 	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
+
 	/*
 	 * Get values from the moved block.
 	 */
 	if (dead_info->magic == cpu_to_be16(XFS_DIR2_LEAFN_MAGIC) ||
 	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC)) {
-- 
2.49.0.rc1.451.g8f38331e32-goog



Return-Path: <stable+bounces-179215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB8B51F9D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1888A7BCB8A
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2B335BCC;
	Wed, 10 Sep 2025 17:59:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581732ED52;
	Wed, 10 Sep 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527189; cv=none; b=kzAjSHZdM9a+LnMUm6pR5FNdOg8WyUEsdOngPsamQ8eveYGc2Yc1fFFIo1Dc4kRWO4wCND/drBB7Cu73d6Mu/AXY7w6f6EwZbXBqVYPi9j/lgeUZlsTr9m5O1+T3jsG15boYaixApEQZLASHwESI6Cemg9mTH0OBy6bVRav2C+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527189; c=relaxed/simple;
	bh=HL0DnVqY9mi1Yf4iFASas8LQH3XJXyuPD2ZIlWC4U1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjffTCJy68DObIJZT561aVY2FVvw8TO/zmYDMg21g7NxmVJF39ToNH5sdP0cnOqUx3c14CHqupsp8KFBKLDWrruI6QZWPSmEKLuwT5vFtElsQjp7pq57hIaC58LsYBY7nRiSd/gxLut6740Mf+zdfdS8G8+wyX+jezwDOCUn3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +ra5r6mqRTSvFDWVBbzDTg==
X-CSE-MsgGUID: irbc+wiWTeiMHtqvzd/txg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2025 02:59:44 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5A25440528E4;
	Thu, 11 Sep 2025 02:59:42 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Lee Jones <lee@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: rz-mtu3: fix MTU5 NFCR register offset
Date: Wed, 10 Sep 2025 20:59:06 +0300
Message-ID: <20250910175914.12956-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NFCR register for MTU5 is at 0x1a95 offset according to Datasheet
Page 725, Table 16.4. The address of all registers is offset by 0x1200,
making the proper address of MTU5 NFCR register be 0x895.

Cc: stable@vger.kernel.org
Fixes: 654c293e1687 ("mfd: Add Renesas RZ/G2L MTU3a core driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/mfd/rz-mtu3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index f3dac4a29a83..9cdfef610398 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -32,7 +32,7 @@ static const unsigned long rz_mtu3_8bit_ch_reg_offs[][13] = {
 	[RZ_MTU3_CHAN_2] = MTU_8BIT_CH_1_2(0x204, 0x092, 0x205, 0x200, 0x20c, 0x201, 0x202),
 	[RZ_MTU3_CHAN_3] = MTU_8BIT_CH_3_4_6_7(0x008, 0x093, 0x02c, 0x000, 0x04c, 0x002, 0x004, 0x005, 0x038),
 	[RZ_MTU3_CHAN_4] = MTU_8BIT_CH_3_4_6_7(0x009, 0x094, 0x02d, 0x001, 0x04d, 0x003, 0x006, 0x007, 0x039),
-	[RZ_MTU3_CHAN_5] = MTU_8BIT_CH_5(0xab2, 0x1eb, 0xab4, 0xab6, 0xa84, 0xa85, 0xa86, 0xa94, 0xa95, 0xa96, 0xaa4, 0xaa5, 0xaa6),
+	[RZ_MTU3_CHAN_5] = MTU_8BIT_CH_5(0xab2, 0x895, 0xab4, 0xab6, 0xa84, 0xa85, 0xa86, 0xa94, 0xa95, 0xa96, 0xaa4, 0xaa5, 0xaa6),
 	[RZ_MTU3_CHAN_6] = MTU_8BIT_CH_3_4_6_7(0x808, 0x893, 0x82c, 0x800, 0x84c, 0x802, 0x804, 0x805, 0x838),
 	[RZ_MTU3_CHAN_7] = MTU_8BIT_CH_3_4_6_7(0x809, 0x894, 0x82d, 0x801, 0x84d, 0x803, 0x806, 0x807, 0x839),
 	[RZ_MTU3_CHAN_8] = MTU_8BIT_CH_8(0x404, 0x098, 0x400, 0x406, 0x401, 0x402, 0x403)
-- 
2.51.0



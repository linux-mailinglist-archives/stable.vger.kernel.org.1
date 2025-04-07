Return-Path: <stable+bounces-128630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C229A7EA1C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25303BB698
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67022A80D;
	Mon,  7 Apr 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2mA9OGt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D20224882;
	Mon,  7 Apr 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049550; cv=none; b=s0g6h+TqZezaSfdNDMs0aIALoAN9vJ30YQPenryeXoDIR4cNvohxbtRMjNbudFSS/zYYgBB0AWZ7hOqLnZQyh0VpnUYw8uOEFj5T44NbbmMluizcn+nUfiay/bSGaooX//UgrywEd0Hox003U17To82rdxVU3GdEdBw4SgLsNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049550; c=relaxed/simple;
	bh=rKcpv0qsj46QwOYj+wHLn0yZ6qGctnM79WMtb6l3hzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPdzNW4RPKfNAyZ7AoNYnYPW1N+JVVE++SMvJizL4G+GQrrqHND7dHVyahezkmqmGcNSdYXa9KZqFHDT1FEuKv5/LnjNwZkTowFZM63eaVvnhkXL+vK3LdtnvBdxLne+QA8vN9z9fvQj4k3Yb3fx6XPxy7E9XkNtSZ6lj9fpUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2mA9OGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482F8C4CEDD;
	Mon,  7 Apr 2025 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049549;
	bh=rKcpv0qsj46QwOYj+wHLn0yZ6qGctnM79WMtb6l3hzc=;
	h=From:To:Cc:Subject:Date:From;
	b=I2mA9OGtICek7GdjVKIu1m1zXcQoP9x2u1/zCwnIWWTM1wEQqmGRtnDPmcSCkHPq1
	 4GySW5C2Bv2NixXJZYccRGFq1znPMIHg1BmdHmaP4etzdQQWB/DVSyDG5zu8xI7IO8
	 uWRleQ57aw/gCykptsfKg3Bx+OV8ha858x7chgyuR2NaNUUQtC5kUwerh1H1LmdAwV
	 qVmzrq2RtyNPjjueFQfGwHNxC6/covlSO8VxZEhZuXWYUdaIu+Q+ZWnFISMsAZcVrb
	 YTuewbdKG37GNN2M0CRZIkiE2kF7UONaIvu7jP7cFFcyZJTuNbCZEK/uSYMq+unESc
	 8imY50vmDrcdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	rodrigo.gobbi.7@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	salwansandeep5@gmail.com,
	matchstick@neverthere.org,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 01/28] staging: gpib: Use min for calculating transfer length
Date: Mon,  7 Apr 2025 14:11:51 -0400
Message-Id: <20250407181224.3180941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Dave Penkler <dpenkler@gmail.com>

[ Upstream commit 76d54fd5471b10ee993c217928a39d7351eaff5c ]

In the accel read and write functions the transfer length
was being calculated by an if statement setting it to
the lesser of the remaining bytes to read/write and the
fifo size.

Replace both instances with min() which is clearer and
more compact.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202501182153.qHfL4Fbc-lkp@intel.com/
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
Link: https://lore.kernel.org/r/20250120145030.29684-1-dpenkler@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 8e2334fe5c9b8..533cc956b3f6c 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -69,10 +69,7 @@ int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 		int j;
 		int count;
 
-		if (num_fifo_bytes - i < agilent_82350b_fifo_size)
-			block_size = num_fifo_bytes - i;
-		else
-			block_size = agilent_82350b_fifo_size;
+		block_size = min(num_fifo_bytes - i, agilent_82350b_fifo_size);
 		set_transfer_counter(a_priv, block_size);
 		writeb(ENABLE_TI_TO_SRAM | DIRECTION_GPIB_TO_HOST,
 		       a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
@@ -203,10 +200,7 @@ int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size_t leng
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
 
-		if (fifotransferlength - i < agilent_82350b_fifo_size)
-			block_size = fifotransferlength - i;
-		else
-			block_size = agilent_82350b_fifo_size;
+		block_size = min(fifotransferlength - i, agilent_82350b_fifo_size);
 		set_transfer_counter(a_priv, block_size);
 		for (j = 0; j < block_size; ++j, ++i) {
 			// load data into board's sram
-- 
2.39.5



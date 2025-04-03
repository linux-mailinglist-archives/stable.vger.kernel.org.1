Return-Path: <stable+bounces-127927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30418A7AD54
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E496A3B7B91
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D812BEC5D;
	Thu,  3 Apr 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRrIXOoj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7A253331;
	Thu,  3 Apr 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707410; cv=none; b=tmCUWysbNqdvHZUAhGYMEoyeB8ZwCDEe9z9ewieYyA6dhmy0hwlLSJbNDPL2RAZD/QDqP4qWLs3crhh0NP2Y1bL0x+dYd3m3KHKjU3SOCGRULUf8kpkHO0PYdPxhEYwe28vOB3USBHupWFa5meSj79DGV7pAb8U8ek+w0+WQegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707410; c=relaxed/simple;
	bh=fK2ogpiXpRoYoMpAwWAjaO9nttY7dsX12awqv0nZ1XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFRb06RAeOeKTkeHfdLa95tC/IXRDLVbsgC8Xhs8gsi1bIyoGNf64SxW3amFiTTACXCECYtAJUVhbms2BhuHEdzZzl6ww6WTfuInOmo2mq6ucz/YqLJNUAUubPeSmX631e3eNgbSjzpeueiSYiUxI/hUuPWuJSChEIpMX1zVRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRrIXOoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA63C4CEE3;
	Thu,  3 Apr 2025 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707410;
	bh=fK2ogpiXpRoYoMpAwWAjaO9nttY7dsX12awqv0nZ1XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRrIXOojZD5ltBgUIz3oZlqyZ0A2yZkf7ExDbc/4rhaqt8B4O8krbqzMKCbVwSaXi
	 V0mfY8etoCJNTphiZq1DWmV4m7Iyxn4tDtlaw0oaQm5AKAVC5/woTyW1g5qrHG+bIv
	 Wo5xr51fwa5OJlVkNpWFV2uWYp9fvtmCPsqo8uMdpk8Gxri6xec35+UsMkbS6qKlrr
	 1Y510j6c+8Vq7rjH5uqi29cV8yBnptm+hUVykce9KbdnwkdiLhqNRzL/oXt+vqx2r3
	 Cf0RFwAdEmaNpu5v4+eFMOAn23wwMi5Ql5JoTXeNmvMSC3+kyHCnc7hULLzlLxW8Kl
	 5f43uOmxDdppg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 02/15] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:09:49 -0400
Message-Id: <20250403191002.2678588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 70ca3246ad201b53a9f09380b3f29d8bac320383 ]

The expression "inactags << bmp->db_agl2size" in the function
dbFinalizeBmap() is computed using int operands. Although the
values (inactags and db_agl2size) are derived from filesystem
parameters and are usually small, there is a theoretical risk that
the shift could overflow a 32-bit int if extreme values occur.

According to the C standard, shifting a signed 32-bit int can lead
to undefined behavior if the result exceeds its range. In our
case, an overflow could miscalculate free blocks, potentially
leading to erroneous filesystem accounting.

To ensure the arithmetic is performed in 64-bit space, we cast
"inactags" to s64 before shifting. This defensive fix prevents any
risk of overflow and complies with kernel coding best practices.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index ef220709c7f51..389dafd23d15e 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3728,8 +3728,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
-- 
2.39.5



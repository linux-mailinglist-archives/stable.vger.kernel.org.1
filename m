Return-Path: <stable+bounces-127895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B7A7ACCD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E43E7A687C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0645259CB8;
	Thu,  3 Apr 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi1uT5PX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4EF259CB3;
	Thu,  3 Apr 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707339; cv=none; b=RzXykDH3xT9SWGJ9YCoBaWEXL6WSm2V4aMwhNNNp10edK1rQkQzgdOGIhdvUmLAaUsFpBC5Ac4PGKrllSnHy+j/L/fL0l4erv21l+5bHMeYS8FEIodCGrzZIjeAqnlgp1jkvGJD5HSfrtfSKtdYMRH1qrsRW7TchI7IaoqNVdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707339; c=relaxed/simple;
	bh=2S9uJOyiZQjXh+2ERamyfkU1P7eQn0isWszMBfZXM6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5AtPMdbb+jiRmzNSlAKJWIfF4+AxCnceyZUbvtSvKGBiI2YEZDfhyVrLSbJBL4Bvbu+Qs7YzvnUi+uDfdp75S8dREOoVCMdZpl05+/SpLAqX76KMQxLZfDDK+B6K7v4JvxRWN1KWPqjkhqlc6EzWbq0Nep5Ml9w1l2QtLchOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi1uT5PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFFBC4CEE3;
	Thu,  3 Apr 2025 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707337;
	bh=2S9uJOyiZQjXh+2ERamyfkU1P7eQn0isWszMBfZXM6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi1uT5PXiXStoSEZxkgGWCUOneYIBsUkkkT4x+rZ96ODY2Ro+D5xpqeQg/EzCh3PP
	 GMVy0GBK2VDoFgg85SVEa1kQFEXzMWXfRFXUuyNCjL8j3laXysV5S/f5hzVGqxqpOh
	 3RtnqGT33sAs8yc+LjDEIoZGfwXM4MRllRve4FYYLrw7dciR/MNm+If86u4uXkm6L9
	 eC33keet6Z4rtcExJgYBRkEpsIwqWHCFiQ4aWZpJJyPs5lkONUFHXFi1yYRq2Ww/aX
	 7Kk+btynEsBO9cE69lrM+9kOt3S7MElrRR7MMvhiJsesuBI38dzVWTW1cyrMaJ0mXd
	 2KNmKsHJtdjyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	ghanshyam1898@gmail.com,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 04/18] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:08:30 -0400
Message-Id: <20250403190845.2678025-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 6509102e581a1..3d4c7373a25e0 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3666,8 +3666,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
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



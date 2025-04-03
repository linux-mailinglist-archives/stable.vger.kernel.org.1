Return-Path: <stable+bounces-127736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D773A7AA21
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4CA7A10D1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A525744B;
	Thu,  3 Apr 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP4s7inB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7125744F;
	Thu,  3 Apr 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706981; cv=none; b=nDBU7BvikYMn+2MtVlz5OcZgwyC9fdX+WSu9jujApNPevU1AHqf9oTeUM/hWPQgX4mBqJBIn7RbdZLOrBVYUOBVDqY7VU4Ax00JTHRvpkCeI4Kn5Khe1hY7KUkS1WoWGFATtJf8WhkspSzN1zHT+aoatEcpg4ah4exxEJGOGGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706981; c=relaxed/simple;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gT1JKm8ccKfsdAfZrmT6Lwnx+2DmcIzh2olyUcQl84ODaokX7cOsH+xqD3L1Zf0YCI8qud5MQoPdw6wiQtnwifBFgeOQ4JlltBm808UiQyL93SMldOjL0KaSqpaHBnCmb/sI4s27VVKI9mEFpxhNAAc63qYej0hq9AFvpTGyF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP4s7inB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154AAC4CEE3;
	Thu,  3 Apr 2025 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706981;
	bh=Yi6NBWvt1kWSbty3oBCwzar1OFqmjwSEF8xkY7+ToHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UP4s7inBv/DBN+noEOPKIEc9h9RDJJ3lAytAMFuY4N4p2UvYoVujNpmNu+sVM8DfI
	 r8hrSDoFqtgU6Oss3204mtv/aE4D6a4EBrsQZOPfwyDRM8oj8Iq8IWcjhNB8MrrXwz
	 g64xEjzAmxCMzqTTEc2o/8flglhOZ7/bXLKKIHAxRq42HtTAx7PBxPRN3ksUD4MgdZ
	 5AgxP3MkCgTqDMySezF2ZEVtB1z4spkuWYm5M9ZpDkJMiYzD7llRDHTE/5/w0so3it
	 BDDyw7vCb69tkrLwAjbxdXFLrLZvPvYDkDHIPxUM4UAQUkZa0/lLiW6+eyAZgzhZHa
	 sUwQeG4DKJYtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	aha310510@gmail.com,
	niharchaithanya@gmail.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 21/54] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu,  3 Apr 2025 15:01:36 -0400
Message-Id: <20250403190209.2675485-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index f9009e4f9ffd8..f89f07c9580ea 100644
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



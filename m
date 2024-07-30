Return-Path: <stable+bounces-62796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E821F941267
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C4D281DAF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E881A01DE;
	Tue, 30 Jul 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItKIOpvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597F1A3BBF;
	Tue, 30 Jul 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343585; cv=none; b=Eob7yk3NN+Fb3wVXBGvIXI2guM7b/ZFUNlsybvsob1LELWTOSkvbU3A+4FCMODHQIoxMURF/3jgyQHOqmN5fMBf+jHSEu9U421lnwbr91YZXepQGMz29X4n7NngfJaDqc3GhHegBaYqWoxzyNFzULIvRC0JrXhgEaYzTA4LyjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343585; c=relaxed/simple;
	bh=eHE3YvL4IfRxrT0YcBksOM7MwqzaQ++K6QUcU+fB2fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR9+mqXuTX1KTVPIgyLt6P/zoW5Bbmv377yxt6+LXHSg9oRvO97T+W4sy5Qj8TdQLlwIoqN92mmZGRYdJ68FNCkCFF9ErVCIKeZ2QN86aX1ooRLGMQ/oJqZ+OJvvHgplvSPyHr0QqRGHv/vuNVm4drk3XTjMdbW3MWvCHWkB7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItKIOpvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F61C32782;
	Tue, 30 Jul 2024 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343585;
	bh=eHE3YvL4IfRxrT0YcBksOM7MwqzaQ++K6QUcU+fB2fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItKIOpvB0GGoAfSA35JzsLRyQaUcgcNahYR6Qrsf30jjv5rBjnyRr1PzncMZ4+SX2
	 9zcsO4h5XzL5srLr1+agnoRLYpzYdGKtAPol51hYemtRCG8aa78zKXkrs6LwswXDMd
	 AKUM34X3n6NgVZmlwsGvybN5LXRhcDpDzq98gzsi0c+N2x3MooqSldGEVL7Jl2YrT/
	 pNFjgHHozJNuW9/0hAO8oSo5ktulPBh6zA5ohbkPkleY7K0nZsE3e7byyOibnyW3dx
	 8Adi0T0xTheqPLBUfqvKN+aCjDWy10lbwk8Xzw6OB4oE61bJQfozI+xwzLWkTGU3ft
	 /1jfFK66ViJxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pei Li <peili.dev@gmail.com>,
	syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	osmtendev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 3/3] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:46:12 -0400
Message-ID: <20240730124616.3097556-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124616.3097556-1-sashal@kernel.org>
References: <20240730124616.3097556-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Pei Li <peili.dev@gmail.com>

[ Upstream commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 ]

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 3f5c14315719b..9ff0b292287ba 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1694,6 +1694,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
-- 
2.43.0



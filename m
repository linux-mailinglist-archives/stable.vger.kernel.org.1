Return-Path: <stable+bounces-62801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C871941279
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0718C28379D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F101AAE27;
	Tue, 30 Jul 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw5Yescp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899F1A072B;
	Tue, 30 Jul 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343609; cv=none; b=jGKVMa3RVPOSCNbj4ZuogaCzVKm035EoGpaiScsXmt2IKBXgoRgz4jpAN3NNAJRJbEYkOGVfA3mdpnxU57yKacs8eVC+OK3sat/6i2NlleuwTsuDP0jdT5/nESQH9ycP9f63ko6F8GC0JiVIN6tugPRnCJ0OJw0R/WlUFK+m5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343609; c=relaxed/simple;
	bh=Go+PWebTIdyKuRFGQRAGDJbKq3XRcGav2G0UpNBfZQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIWZsYXouGY8ztq/8PfW9/+iRR7r/VJcfWFkgWueBaDbXQ1XSM0d70jPrdTVkuxY2H/te9jwnLOhbodWO2nvOxM3RwNJfcNvA79LbuGO4MxpUbT1klmzzeNop/FuWJ5Wzoury4qxBXSWmMn8CHWdX87NRgyfFotmdlW4Yj/SjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw5Yescp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2545C4AF09;
	Tue, 30 Jul 2024 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343609;
	bh=Go+PWebTIdyKuRFGQRAGDJbKq3XRcGav2G0UpNBfZQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iw5YescpgO069eM7tQGBQa762aVClY53Yk6FeoqLyXC0dbMPnWKY7vvX33scT690U
	 fByuplsuE5cAcSz8Hs2ts6OXDcmgNfU0DJZ0pOGgwC44gu8R1Z9GMpxi1qv2LEhECt
	 BkfqfdfssLvy+TDy1Un7/otDZk259Q4QVNwKRgxR3sMNCG0I58li040I/X2mYPIgmz
	 UsZQdfS7IiGjaOeFGiTdv/o28ShFlmiBzdCeItBgkyo/2afAMjTzS2UJBRH5vGETmT
	 ZAmxPmmWcPr/3MaJIXTqu72QWWkUMJpCNpi2OfJQQClenucPzIp/UQP0mdRflyijN7
	 8MPe/IJyoCHRg==
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
Subject: [PATCH AUTOSEL 5.4 2/2] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Tue, 30 Jul 2024 08:46:38 -0400
Message-ID: <20240730124643.3099670-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124643.3099670-1-sashal@kernel.org>
References: <20240730124643.3099670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index deb54efb56013..b89d060af7405 100644
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



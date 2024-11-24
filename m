Return-Path: <stable+bounces-95285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B29D74E6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C9C1648F9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424E249AD7;
	Sun, 24 Nov 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g32Pv737"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A5249AD4;
	Sun, 24 Nov 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456584; cv=none; b=EEaCbj3m0tXkuBn5L7ih06InI33taI/7ZY3vzF6Mk/LoFBs7l4U56r27PYn4OfQdHlRYAK4y60OQwiF2vV9uwsT2/LTOC47dcDBAAExClZ454gh2lLvToOY5jNsd5vtZGkoJJ4hCbZcBkK3CDN/5T02ezesNhcgbRp+PHRijCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456584; c=relaxed/simple;
	bh=4YaxttrRGv5z7akxp5panKh+gkagcZHLBZl1qyNPYCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW1z/mPKhPo6NiZJF2YSPcqzNkKaNn9w9Xy5ivSYssvBkfmWC+KA7OvHKtvURHjzyohNg7m0ixZ70fLbAi3jQ8/SaqANGVno5eGDHOZMZW7DFhxZEPt9tF1XhyQTydB4+/Q6paRr4oymnpdFgwHyILoMkdpgebqoiA+Avb0P6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g32Pv737; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A408C4CED1;
	Sun, 24 Nov 2024 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456584;
	bh=4YaxttrRGv5z7akxp5panKh+gkagcZHLBZl1qyNPYCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g32Pv7378c0YiU0MREYRD6Km0kmO5dIMTdydCmJgQT7TkgElcuSG5PE8HfkHf7Vh4
	 3HcIxjWVtx7xHv+8qDoPcNKw4ECt0HwPp1vczytQ9wG1zEajTyuTOjoxGWH5LnhYro
	 YRFHSZFi8iWx4YntEyuAyoK/7SrBl7gEalgDLIvcAFJXxvirJdw9AINQ9gFMNDHzN8
	 sTEmNGmrxOvdEkdlSs/MWagGTRHFqna3lL7wKbv+R7Lz/gxfLDEZiXjPzmyp6fxvSC
	 pvJes6bKwhSGJ0Oz5xhYtf2oSXBnNPKIq8d5RaGC28NnLkQJGyKhet1AGQdtfLSt2L
	 5mjdIhuVwQsRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	aha310510@gmail.com,
	niharchaithanya@gmail.com,
	eadavis@qq.com,
	rbrasga@uci.edu,
	peili.dev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 17/28] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:55:17 -0500
Message-ID: <20241124135549.3350700-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit a5f5e4698f8abbb25fe4959814093fb5bfa1aa9d ]

When dmt_budmin is less than zero, it causes errors
in the later stages. Added a check to return an error beforehand
in dbAllocCtl itself.

Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 00258a551334a..d83ac5f5888a4 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1886,6 +1886,9 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
 
+		if (dp->tree.budmin < 0)
+			return -EIO;
+
 		/* try to allocate the blocks.
 		 */
 		rc = dbAllocDmapLev(bmp, dp, (int) nblocks, l2nb, results);
-- 
2.43.0



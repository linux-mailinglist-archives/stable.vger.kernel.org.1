Return-Path: <stable+bounces-95129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86929D7389
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505A4166198
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733A1E0480;
	Sun, 24 Nov 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLcUcb2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9E1DFE0F;
	Sun, 24 Nov 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456094; cv=none; b=oDJO3meAzb5XC2x1C6gtIn8onbSWby99wMBQ2kepCsaaWu+u10OxUcwW2r57VRRqFRNzHhRzpVmYW3l3gcwCvaXHvURcroWq5JHgKtj90elkHLeZ59wjsBeBhez4/q0nJpz3SoI+KWIea7WDtiSHmFzypy816gC/46760uCxdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456094; c=relaxed/simple;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bzj1fXDV0o4vGmussle1UURNmWbphQxRRIY764xzfrNa4YRgtoErf3o9XLlmESU796oPBXQxl3Qz9kkLk1NchSgzqYOjUxOkOJSpIVE8CKbJssmg4UWBu58PEmmVJhB09myv6Kz03OgTAvRBn+KR+b6fjHvtPfCi8qmIGZaeVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLcUcb2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB69C4CECC;
	Sun, 24 Nov 2024 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456094;
	bh=7SeF0gTH/JLCX/yvCisAO4zHQS3KiWhTn9A9Mtcwta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLcUcb2Woa8Do/ufm/OaiC/BdupJUDo2k/+t9qqDAHsb26ijmIX6h30PpUXCsFxqY
	 rq6oolX2T+X1Bm/ehahk1fusd2j6K4xFZfLM5+NiKT3t63aKfZ/3dCEsD0/70jrIU9
	 L3dx8zcCIGydJE81Gey4bgNevLTJy9/WVbKzjGx828GAPPNUhCfKqX6MSwqSnJX8Zm
	 MQWPaxdbTi0b8FDNA3WX3O7SFe9eP5xS9s2f+2sWrHYATDiIaucQBaoL1R4CSHEtgD
	 6OShTpTyN8EmHhMjKZhQXLvhdYmXL983/7Dlc6/x0jD8cxf/bNsST6AzDu/RpKwjy+
	 Q9B7IBvxqVKZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	niharchaithanya@gmail.com,
	eadavis@qq.com,
	peili.dev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 39/61] jfs: fix shift-out-of-bounds in dbSplit
Date: Sun, 24 Nov 2024 08:45:14 -0500
Message-ID: <20241124134637.3346391-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 3ab410059dc20..39957361a7eed 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1820,6 +1820,9 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
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



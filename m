Return-Path: <stable+bounces-59464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D87932903
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799841C21E8C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F131AA36C;
	Tue, 16 Jul 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqgCsAGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941641A08DE;
	Tue, 16 Jul 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140125; cv=none; b=tHnISlLp4g7GsajfrevVZbEbVBXmkciWOk8s0d0qZvbkjkj2SpQ2k6taXCbHnqpnyNU/bzq7yoV7KwWtoaAAqxnzXTJpLQJlgTws7+Pb7eYo9e3y7ffSA+9ZxEZQ3/vgs9teDu8jOpwu9Juq3yt894nQa/cYKrlV174gEMXsKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140125; c=relaxed/simple;
	bh=2V5yMy8fg5l7XZON4Bkmfbz1fVv90PmujY3nRMqKp8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gASoT4IjoHbGBqHI5y6veZTkiHQLW1ydDetNBSQvBGV2gniLjDOjEbAVoluQvu4KeP/9kbvdsC0lVV8iK4cK8KtXHSe8VnsL19av5xSO6flDe0ltT9cjxzh8feNulBdJNCqRIQdLqVvOgHbgsBjUAMUM/TVpF/iujhjsGK7fg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqgCsAGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FADC4AF09;
	Tue, 16 Jul 2024 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140125;
	bh=2V5yMy8fg5l7XZON4Bkmfbz1fVv90PmujY3nRMqKp8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqgCsAGNJzHiZI2ZWrTaR5uQ30Gb/UfzyPl2/SuoHTrPCvynW07ZOOlScDTltEfM7
	 sMdE9fq7WsDKtAijPth/vlUnIY8oPISE3tP32IBhbBnr6B59uviyklHpbWZi8jqLiL
	 lFsB3q4o2kVIj1g8NoDbWkAAiVQNDHcHlykHZBjF/QZTiVfLpnzvTIAWylk2ERNwHq
	 LUDZt8xqhfql4oaxlkNk2ylJE01z6P8ZtZF/dpNS46mP51O2gULBr7MOZvNUzRGbST
	 yUYPG1EncZ4o22ficN82O7vjuHbF7uuZ3sHtfQdXO1JpZAhvZ6UMG/IGBR2YUWUeHy
	 J5eVCgjOAYPOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 08/15] erofs: ensure m_llen is reset to 0 if metadata is invalid
Date: Tue, 16 Jul 2024 10:28:05 -0400
Message-ID: <20240716142825.2713416-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 9b32b063be1001e322c5f6e01f2a649636947851 ]

Sometimes, the on-disk metadata might be invalid due to user
interrupts, storage failures, or other unknown causes.

In that case, z_erofs_map_blocks_iter() may still return a valid
m_llen while other fields remain invalid (e.g., m_plen can be 0).

Due to the return value of z_erofs_scan_folio() in some path will
be ignored on purpose, the following z_erofs_scan_folio() could
then use the invalid value by accident.

Let's reset m_llen to 0 to prevent this.

Link: https://lore.kernel.org/r/20240629185743.2819229-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index abcded1acd194..4864863cd1298 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -763,6 +763,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
+	if (err)
+		map->m_llen = 0;
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 
 	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
-- 
2.43.0



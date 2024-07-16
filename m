Return-Path: <stable+bounces-59447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61329328D1
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6162A2860A4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D481A4F12;
	Tue, 16 Jul 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMnohvPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91171A4F0E;
	Tue, 16 Jul 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140055; cv=none; b=V0mp9bRH7LQFEXNtYBfOaPRFddlZ6svsqW98dhwMxLolvP45oLaUR/aFw3WRKb8QKdUxy+w617DURc2bsssGY03A0In8/hzl+HD1R+XwMs9fIV9IApUrUKWYHQq4eiBP+0nAnTs0xXOkRXuvGrEJ/+/n6CW3wgsST524KOZzQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140055; c=relaxed/simple;
	bh=uTOKARrI0amTe1Gt8kLzCi//Pwc6qVnGSFYkz8442p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR3hNKhHoIrhA5F0gikQkFSHe/20YsZ5TxMXOAZA467+TN29wzVh9dvAsWd+oRzHKNDZcbJ+bYNzZpMnoF99Cvj5mme4jVkNzzH/7DGA1wNMOGoVx8pHh7u8PxpjwEuxEUTzTJVpc1TbSk9KIROSV+/1ux+N3r1niotTPAq2n0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMnohvPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83610C4AF0F;
	Tue, 16 Jul 2024 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140054;
	bh=uTOKARrI0amTe1Gt8kLzCi//Pwc6qVnGSFYkz8442p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMnohvPaBbuck1gjojs5oPPNWL8jGfyVZKQFbaOF97FqPol03pAxj/nDMhw/v70xc
	 O8K5yXIWn5fmQpcIjyPW/5oypd4ZW384S5Uoy58Qhx5dVEx+KTbnwe2yOzZBb+86xu
	 D6fj9mK/su213+sKMV/KJAhCy+h/eBPbOu6MKtihdf9XEbwQr5vGFbaBY23O2ZNDvY
	 eqILHEOW2NcfmkCmY4qqRLIjSG8qVROji/roB0U8GL4qO44+wd2ll/CEi52FWwaWGh
	 bg/B8ySWlXprqxv3RUy2+GnKjXXnGHieEL8CWU8jTMLtgt3Qu0Vh04KJqOeZeSvg4s
	 FDRjbautcCN2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 09/18] erofs: ensure m_llen is reset to 0 if metadata is invalid
Date: Tue, 16 Jul 2024 10:26:44 -0400
Message-ID: <20240716142713.2712998-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index e313c936351d5..6bd435a565f61 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -723,6 +723,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
+	if (err)
+		map->m_llen = 0;
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 	return err;
 }
-- 
2.43.0



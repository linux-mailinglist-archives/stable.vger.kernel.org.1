Return-Path: <stable+bounces-59426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A393287A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E87285B1A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF81A0701;
	Tue, 16 Jul 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdfRkfKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5591A01D8;
	Tue, 16 Jul 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139943; cv=none; b=bkiQnbfYCs85bngw55vtc4+RaI/kGWY/OdQKUxNsdzEASC+qmTnusCZw2LkkiS96j0fNapwr3cE0NIcQIv1Y9eiFeos+0XGbpvyZWG+H01B2oI6+J1VwV5800xVq1w/djvi/DqB1iMQncVdX2RI4VWjIN+6+cau8aPvdCWmmi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139943; c=relaxed/simple;
	bh=uTOKARrI0amTe1Gt8kLzCi//Pwc6qVnGSFYkz8442p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTjbsivcwyViYD4xWZLjnQ3r0iHZYEmUSZqyiV4X/kfLLuAoFRpJrVMq6vgrSoKeGWR1nUbd84ZJ0ZYrIFduxOjYyoZt5XOKishY1cLDzsNCEEdlEV/I94D5jbEcwpvRcU7Lcg0riLTX2au8iqXCOjO05UKYmZ9hqtb0okJyUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdfRkfKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843BFC4AF09;
	Tue, 16 Jul 2024 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139943;
	bh=uTOKARrI0amTe1Gt8kLzCi//Pwc6qVnGSFYkz8442p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdfRkfKLE57Rl+/oSnU+wjJUkoAL8U4neZ8REm/ZOga1hOpPnAKxRI96YGSD/Dbp1
	 Y7JGV5FqY/cUB45EueKn5LkmcsHhaAvvk6QqBQqHcf57hXuIZxyrU2VtXjcl500bS5
	 KN5Jf7c6WD7elJ1oZ/kyRUwOR0DBa8fH5W0RcHRY6a+LGAaojTnlN9Qw2V0SJc1uAf
	 0Tw88zFNAIM9OSuHjx+FuFlNPXmmIUuvb0H3YS4wo4znd/FdjZlQtpd9xXwf8yBiA3
	 nrWPvlpy2r6+XUcklpjNQ/1LpQVk239Fbds+yj+rfjV/Px/7ZSEri2UdsR0SoYNKTD
	 vkFZuXFLaVSvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.9 10/22] erofs: ensure m_llen is reset to 0 if metadata is invalid
Date: Tue, 16 Jul 2024 10:24:17 -0400
Message-ID: <20240716142519.2712487-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
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



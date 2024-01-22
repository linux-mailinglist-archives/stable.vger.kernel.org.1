Return-Path: <stable+bounces-13226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D11837B05
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937F3292EA7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8ED1487FE;
	Tue, 23 Jan 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liGixdvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5D1487F4;
	Tue, 23 Jan 2024 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969168; cv=none; b=j6TK/J/sIf07cYaTvM2462vSRXwgi4037gOvxKhQvF8Ho5zPUI4kLSPj9TMzkM4Vk+FYdctaJsAd5uqUqb6DWj/2RqjaQobmeJVzQKW39cKsknbxBhgLDGWH3ONBqt1jiwVU6+LxDdYg+wcAK3yXWEPDG24UZ/a0+U8i/gv9blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969168; c=relaxed/simple;
	bh=VSCkUW3i/TepBje1J30bBlZwpSLqsxPLH46obW93Pf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb/I1FVxxpOSi9+lkfOOafHyKB1uM8+pVdTdtuSvdwHjL5dTjQE6e1UOsAzAj3nZpn9lA6sN+V4WTG+YuDpj+wwk4q5N2CISUDYz+81C4FpUko7+qELP/M5LAPdg1xkxBKdUm5CGQeVw6Y0eAUUYPBwHfpJgFjYZfm+5BTMPq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liGixdvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE17C433C7;
	Tue, 23 Jan 2024 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969167;
	bh=VSCkUW3i/TepBje1J30bBlZwpSLqsxPLH46obW93Pf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liGixdvxUkJ+hY7h11YJJWUzIT27qlnlELz3rYmnwTo812a0p0YI16vmIoOkCzksH
	 RDKCy4B1Lhc/28z5jqUUyW+F3aWw7b5HiPpNe3jYc/wckBhzg4kuT9XPkPgu5cA3Th
	 SGVCfWTJnAZzzcCDk6CzASoIfq50oFRbMZRYy9iE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 069/641] erofs: fix memory leak on short-lived bounced pages
Date: Mon, 22 Jan 2024 15:49:33 -0800
Message-ID: <20240122235820.201610714@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 93d6fda7f926451a0fa1121b9558d75ca47e861e ]

Both MicroLZMA and DEFLATE algorithms can use short-lived pages on
demand for the overlapped inplace I/O decompression.

However, those short-lived pages are actually added to
`be->compressed_pages`.  Thus, it should be checked instead of
`pcl->compressed_bvecs`.

The LZ4 algorithm doesn't work like this, so it won't be impacted.

Fixes: 67139e36d970 ("erofs: introduce `z_erofs_parse_in_bvecs'")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231128180431.4116991-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a7e6847f6f8f..a33cd6757f98 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1309,12 +1309,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = pcl->compressed_bvecs[i].page;
+			/* consider shortlived pages added when decompressing */
+			page = be->compressed_pages[i];
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
-
-			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
-- 
2.43.0





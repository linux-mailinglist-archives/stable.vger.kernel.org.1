Return-Path: <stable+bounces-202284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7FCC2F3E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6DF31667C6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCF36A03F;
	Tue, 16 Dec 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8mRSAFa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19836A02F;
	Tue, 16 Dec 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887404; cv=none; b=NmhXfmsYKCcRpW1RMInkZrOzK6zPrmK3NCuORGu/nkz9htJ02Ka59tgv9167LBmMCVdsGC8OM4Y6MmxOXilcjIVHKGQjVRlzDa6gsU9FFadcQ3qYoi4QvPkMkKj2HhV6Jnomd+GRwFV3Ko+MYOxQrEkJj9bOHdVEwhUbnZZJG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887404; c=relaxed/simple;
	bh=gG9YqInE5oYxalkC/cJwip4LywMw7klPPAnjXkZljJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4I1iGwSCsofypG8qwBhfmGAHYTvPurb1fFXmaFS+uH06d8NbrnkOvSBQOfYNx/zstYJFSTNFFWht0cgQsCUd04N4LpEtHBQEkxQrOsEXUGMRZYr390AP/hLKhJkUFR/ggl4Uk0NcJ+ZX3ecMKCVVoA3zVq6zBEweIjQuNrs8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8mRSAFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2065C4CEF1;
	Tue, 16 Dec 2025 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887404;
	bh=gG9YqInE5oYxalkC/cJwip4LywMw7klPPAnjXkZljJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8mRSAFaMMEa4okLrSA99oEYUpDYqfFmkla8weNKU05T+tN/qVVdyV3v09CkOhPAq
	 LWnA1XH69wQgc8HYsfCiGwfbPlvIMUBiTJsEPB+F/EkCOGtel1i5EZL1y9KM8xk+K7
	 AkvQKi570CkYzweE2V1yVc2dUxTyCdpNQNUqZDJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 220/614] hfs: fix potential use after free in hfs_correct_next_unused_CNID()
Date: Tue, 16 Dec 2025 12:09:47 +0100
Message-ID: <20251216111409.344986639@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit c105e76bb17cf4b55fe89c6ad4f6a0e3972b5b08 ]

This code calls hfs_bnode_put(node) which drops the refcount and then
dreferences "node" on the next line.  It's only safe to use "node"
when we're holding a reference so flip these two lines around.

Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/aN-Xw8KnbSnuIcLk@stanley.mountain
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index caebabb6642f1..b80ba40e38776 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -322,9 +322,9 @@ int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
 			}
 		}
 
+		node_id = node->prev;
 		hfs_bnode_put(node);
 
-		node_id = node->prev;
 	} while (node_id >= leaf_head);
 
 	return -ENOENT;
-- 
2.51.0





Return-Path: <stable+bounces-204313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CD2CEB2DB
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838CB301118C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21C2765FF;
	Wed, 31 Dec 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo0ai1PH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B731248F68
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150948; cv=none; b=ikk8Ltp382+vDUFM066xAJg5VQAW3yR0/qIa58bZ+j040Q6eDpIWA7OqBV1YYy69noSt01XMtAQ/op/PlYsEhAY+BWN6gVOHv5U7hMZm1mQ+i/8/VnhJu9wOyqF5rlYVn0rTmDR+JjvrrLnCH//bAT/+bb7RpjZHPLnWyJDGBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150948; c=relaxed/simple;
	bh=MXIlScc6wOCyIiO0FfwdxHw0SFx+TySdl0CiOVbPEgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGNm3Xzp5nxPjTsHp4x18sHafIzweOHcAXF9NJOIrgQES/e++gsL/vXc1KAJ/J/N/v90PndpKy0RyVeshcHmNvw0QLBFduNa/noVABDwioJqYljFmUNjPZKKxSJe6A6uUx7bvmPDpADEGCijCyGbwHB3D32oxxYmTayQXIg88ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo0ai1PH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE3C16AAE;
	Wed, 31 Dec 2025 03:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767150947;
	bh=MXIlScc6wOCyIiO0FfwdxHw0SFx+TySdl0CiOVbPEgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oo0ai1PHE9+ADu3Y/TBVDIMSp7wXj5BvP6WNEjIhOohnyjZV1WdfDbsHIeuHvKDQx
	 FcwgxMiySBoTtTyDIlMSDduDSzKjinIStKM/4UJ/8D4pTj3gKxtpCNruy7PWCf9kUS
	 r1s+OZ5cMQiOaVdBIuA7+JTbb0QFtkRH5JINUrxskSokYAJJNlV9wgJhovRcj7lvxB
	 iU55mPsUo4YrW+mhzb66NQZyKO8I2JGMTC8CqPMU45sIWcuqYH0Q0PUQgkkcfsCAag
	 mq3DDPqPLF3QMSJonQXQjsgCCJMrYXlKHFzbBp8y9//wHUc7WnNMr2Zu65Y/PtJAFr
	 M3ep7TDovj/aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: fix a memory leak in xfs_buf_item_init()
Date: Tue, 30 Dec 2025 22:15:44 -0500
Message-ID: <20251231031544.2684088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122919-balancing-colony-41ee@gregkh>
References: <2025122919-balancing-colony-41ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit fc40459de82543b565ebc839dca8f7987f16f62e ]

xfs_buf_item_get_format() may allocate memory for bip->bli_formats,
free the memory in the error path.

Fixes: c3d5f0c2fb85 ("xfs: complain if anyone tries to create a too-large buffer log item")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf_item.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index b1ab100c09e1..9f8225ed234e 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -825,6 +825,7 @@ xfs_buf_item_init(
 		map_size = DIV_ROUND_UP(chunks, NBWORD);
 
 		if (map_size > XFS_BLF_DATAMAP_SIZE) {
+			xfs_buf_item_free_format(bip);
 			kmem_cache_free(xfs_buf_item_zone, bip);
 			xfs_err(mp,
 	"buffer item dirty bitmap (%u uints) too small to reflect %u bytes!",
-- 
2.51.0



Return-Path: <stable+bounces-204316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDFCEB2E8
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8ECB300889B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BF23185E;
	Wed, 31 Dec 2025 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2NpN/Po"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D863A1E82
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151147; cv=none; b=V/+S7k20F92eDrlqvVnBu5NS76FXIk6F9Jc0Uf692b2NLxhFhkMO2hg0jvfCyGsgxy80hLW9tHzJNP5tmWFhrlBmfXUj9qprSffS5f0mlAzgvpgoJG0sinzEfsbwFWGKWWq014RfDcMsP4AH4XN1GGhRUpNj3+LEEh/Uz3z/2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151147; c=relaxed/simple;
	bh=/gF/wZ6KE2XyecJ048PIcWoKCWWvxq4dDHgU9AEk7UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlIEOBxfi8bMo3Ayu752Ad6FRz2YCmBp+xYSVCa9q8DtEF7DFKSifjruuMRk8cRLB2e0Wn47cZG26Vgni/tFSZoTZhHSpTM5ouLGa7KzMEQZyz9h4Ls7PP3g1l5hXKHeygZO0/dlYhyrYvFK2VEM5lLoa00W+p5VO5DcVirwZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2NpN/Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87825C116B1;
	Wed, 31 Dec 2025 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767151147;
	bh=/gF/wZ6KE2XyecJ048PIcWoKCWWvxq4dDHgU9AEk7UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2NpN/PoCgdwxKwX4gm2O/tRYOmol1pJOcLj+3YT1JFKPye592HmhCXRtYldl0caV
	 JSkS6L7KeZm0pawP0HKotCXyZtIwA+EJEPN1coJYKGZFRL3kNvIiSjOWLA36O6Dj/C
	 HoSkqhdXg+KJn/M68iPXWZF/XRrB9LSVahGVHViCvpE1aDuQox63ZP4dk0dwMZtKJ6
	 XQf++eqQ/95VHtWlTVSuEFvk2Jq9CoYWhLvy9tUKI6lmnCirgLZybjxlp89UA5zE1h
	 IlREmbaDYJwLMs+FQ7U7ntwbQ2XNMwhmvDFAu2nV7rmuno0BZ7O7EdyM4qcEQtTUbG
	 dpHwBcMqcbnFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: fix a memory leak in xfs_buf_item_init()
Date: Tue, 30 Dec 2025 22:19:04 -0500
Message-ID: <20251231031904.2685998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122919-catty-unrated-e504@gregkh>
References: <2025122919-catty-unrated-e504@gregkh>
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
index a3d5ecccfc2c..deb69740d492 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -744,6 +744,7 @@ xfs_buf_item_init(
 		map_size = DIV_ROUND_UP(chunks, NBWORD);
 
 		if (map_size > XFS_BLF_DATAMAP_SIZE) {
+			xfs_buf_item_free_format(bip);
 			kmem_cache_free(xfs_buf_item_zone, bip);
 			xfs_err(mp,
 	"buffer item dirty bitmap (%u uints) too small to reflect %u bytes!",
-- 
2.51.0



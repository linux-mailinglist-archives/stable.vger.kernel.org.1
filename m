Return-Path: <stable+bounces-90180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA39BE70E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767D91F2217E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3F1DF254;
	Wed,  6 Nov 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GVjf2Ue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300F1DEFF5;
	Wed,  6 Nov 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895006; cv=none; b=hVcQwAinInBVnNm9M19OVFPoMKUTOVodObTPEfBjsQ5VTbbj5fvEd4GnrzbvRqKU2Ser6OfL0jJmiljo1Igr6osbMWJtx52eE25cH3F4Vh4ROhJIIfvC5jAvXlHUaMwFLGGfzFq0MSaxF+ZOVjk1NMjUuV6D8KbSGeBam+tQg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895006; c=relaxed/simple;
	bh=diKATHs3z1R3XKN7FKLPM2HIhDvq4aSSOxjTZCWZ4jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ2gmWAIINA6gw3bPkbOkyhQk159yySr+lb0jx6fC8gYrQ9KaV/7bcrEIHqL3kqyrbYFJbTt2jg2VY0WG+0ko/vTOw/5hiuUtu0N/NmIIJBPuEdE86lPsPs7cdQIY2FioNjTNFVX8sIuDsZyt09WxoKYNNQIzxAGzJODWd3Q/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GVjf2Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A41DC4CED2;
	Wed,  6 Nov 2024 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895006;
	bh=diKATHs3z1R3XKN7FKLPM2HIhDvq4aSSOxjTZCWZ4jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2GVjf2UetU1vkaQ0U+ztKJyike0aQsX7jTU0v8xfoJYpsREfQiDX4j8oSaP+Sz+o9
	 LAus60r39soUQJHgph3mBrQj+3CdY4j04y2hzteZhwehx92jhCbDRcG40fsIyXXW02
	 mquh8ckdVY9SQRQKl6LoJgPhH4vUDNesshG5QxQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/350] ext4: avoid negative min_clusters in find_group_orlov()
Date: Wed,  6 Nov 2024 13:00:01 +0100
Message-ID: <20241106120322.699409837@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit bb0a12c3439b10d88412fd3102df5b9a6e3cd6dc ]

min_clusters is signed integer and will be converted to unsigned
integer when compared with unsigned number stats.free_clusters.
If min_clusters is negative, it will be converted to a huge unsigned
value in which case all groups may not meet the actual desired free
clusters.
Set negative min_clusters to 0 to avoid unexpected behavior.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Link: https://patch.msgid.link/20240820132234.2759926-4-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ialloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 5dfb34802aed5..39a824df52726 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -510,6 +510,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	if (min_inodes < 1)
 		min_inodes = 1;
 	min_clusters = avefreec - EXT4_CLUSTERS_PER_GROUP(sb)*flex_size / 4;
+	if (min_clusters < 0)
+		min_clusters = 0;
 
 	/*
 	 * Start looking in the flex group where we last allocated an
-- 
2.43.0





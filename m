Return-Path: <stable+bounces-23897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014C86911E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6A22827EE
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88F13AA20;
	Tue, 27 Feb 2024 12:59:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E41EA7A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038749; cv=none; b=cbNHiNq/9XeenQ1tW4Z/Eiix2VoYj1HSUaW5JQ3yiIqikWNRtDnriCRD/MJ76vAuU2OqnPoOGITaOAGOVLdQgz9rBuzxqxcZ1Nm/FiRMKffu19ftQp0S7gtYeiT19BPoyooPm1p9Tg76RsU1k2ufjE2ssGAITeg2EAuR30RUMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038749; c=relaxed/simple;
	bh=r/bVphFLDwABC8qoKKKIMN1y3SC7uALCjhdKLB34bWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDbP8BiswoMp9PgJvHQsfsN54UcDFe1lPoRJmAqLiyUILmEF9PsFahKmyfDhpUHriW9DufD1Zb98hIcNfS638lEw9dsuhve1/LlbBHDJ7o5tuBY6MU6PQSpBJYxxqiX8debImHpTIvLNK4uENO0OViJqTO7F3hOgD6XwmRey2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tkcv65DWhz2Bdf1;
	Tue, 27 Feb 2024 20:56:50 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id ED9531A016B;
	Tue, 27 Feb 2024 20:59:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 20:59:04 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <tytso@mit.edu>,
	<jack@suse.cz>, <patches@lists.linux.dev>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 5.15 1/2] ext4: regenerate buddy after block freeing failed if under fc replay
Date: Tue, 27 Feb 2024 21:00:49 +0800
Message-ID: <20240227130050.805571-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

commit c9b528c35795b711331ed36dc3dbee90d5812d4e upstream.

This mostly reverts commit 6bd97bf273bd ("ext4: remove redundant
mb_regenerate_buddy()") and reintroduces mb_regenerate_buddy(). Based on
code in mb_free_blocks(), fast commit replay can end up marking as free
blocks that are already marked as such. This causes corruption of the
buddy bitmap so we need to regenerate it in that case.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")
CVE: CVE-2024-26601
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-4-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 762c2f8b5b2a..63e4c3b9e608 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1168,6 +1168,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	mb_update_avg_fragment_size(sb, grp);
 }
 
+static void mb_regenerate_buddy(struct ext4_buddy *e4b)
+{
+	int count;
+	int order = 1;
+	void *buddy;
+
+	while ((buddy = mb_find_buddy(e4b, order++, &count)))
+		ext4_set_bits(buddy, 0, count);
+
+	e4b->bd_info->bb_fragments = 0;
+	memset(e4b->bd_info->bb_counters, 0,
+		sizeof(*e4b->bd_info->bb_counters) *
+		(e4b->bd_sb->s_blocksize_bits + 2));
+
+	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
+		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
+}
+
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
  * is loaded via ext4_mb_load_buddy. The information involve
@@ -1846,6 +1864,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 			ext4_mark_group_bitmap_corrupted(
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		} else {
+			mb_regenerate_buddy(e4b);
 		}
 		goto done;
 	}
-- 
2.31.1



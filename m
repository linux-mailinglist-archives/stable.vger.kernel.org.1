Return-Path: <stable+bounces-127945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51712A7AD82
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9583B5054
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146328ABB9;
	Thu,  3 Apr 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNrm/dWe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271828ABB3;
	Thu,  3 Apr 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707453; cv=none; b=JTcjwWvGVrTEPMKRHAHmgJwr6sGMrONNyyAgRBlYcqyyusEf3/04WmUEtiqWXqg5W7M6nHtTEm9C/SSbdjOIwnelHKJOz/QEw40zMo1hstq033YGXdCxehI5xcX1Boby0WG+OZJDNA5D4AnbY/GRk7lNupAonM6COGYyKIuga5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707453; c=relaxed/simple;
	bh=oUTm4z5OmT/iVoCj0+Qmo0qUIKkt7OhuyWCoc24koCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnoQY25fTfpCCSKsz4HNuNPEs+FwWEdOzCLogeFIPu8vQeHXf85hveO6P8FUKXcrNXNQ7hUK1ItUedkiiEMPbBzVEKMZRiKhSpIpiYXaylIjH00XZp1y5KMarx2F1amg/fjIFN2zQHRa8S3iywIl4+ZkfRCGj7cB5Ndhv1C19Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNrm/dWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A58CC4CEE3;
	Thu,  3 Apr 2025 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707452;
	bh=oUTm4z5OmT/iVoCj0+Qmo0qUIKkt7OhuyWCoc24koCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNrm/dWeAWkIR3rCfuImRdf5JKDi95rnV84c0SJ0rhbyYuTQJclyjie50c9EPtKi4
	 gIi0H2LBLpBvwMYyKQEQFbz/veqwpnHC/+NQMLoT0KbQvDJ/DMYl5N/rMLUtQj9p8a
	 rOmKAMXUCCjs6t88IHarP4/yGP+em+58uTjvlhOL1NlOhUShYOC5nwgq4caVTsB21Z
	 qnBU3GUr9YQGX3O52r52sqDrbQajXdjLRyylgKc3Z69fgVmUjgFM/F6xBrHzzbq6Wc
	 RGcRZTzxWhWCIGCT/dgGhaK9EtepM4Lq8Oj5L0/LSCsUWrkohWmscgEyY+6OHO3XMe
	 18AZTrY7lI4Qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c808908291a569281a9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rand.sec96@gmail.com,
	rbrasga@uci.edu,
	peili.dev@gmail.com,
	niharchaithanya@gmail.com,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 05/14] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:10:27 -0400
Message-Id: <20250403191036.2678799-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ddf2846f22e8575d6b4b6a66f2100f168b8cd73d ]

The width in dmapctl of the AG is zero, it trigger a divide error when
calculating the control page level in dbAllocAG.

To avoid this issue, add a check for agwidth in dbAllocAG.

Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index d4e26744b2005..d161bbafe77f6 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-- 
2.39.5



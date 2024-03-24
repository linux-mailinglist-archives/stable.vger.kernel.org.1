Return-Path: <stable+bounces-30286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13043888A92
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FCE1C289D1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1C1311BF;
	Sun, 24 Mar 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR3vX0NR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C798142636;
	Sun, 24 Mar 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321888; cv=none; b=uxiuS6G20qXhyuqoHVFd55OPJlCbWPjQH9YzoapuF70Qw3/qKNgG6TX2wcvlgTiXAiv6lhu19N1PJf1JCNtiTWsCFGLNWq7qX7DZ1xOfKYwDb+fvgTJLDJMEAU+BU3QF4vwPHDlcUy6+x9HpFfuoDmDK0G/xnFGqBq6rcMJb3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321888; c=relaxed/simple;
	bh=GFrPxYhwHvxppAzRKMeCfkky5NKmXxQRqJovsb+Soww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/8l3c+DrSAX6acoGUF/4bZi8mnhdSPrDvMQmvSDmZP7l3C0NqAHLkuByqRZ9PxBt6y4jxenO1AKdfdrKzIytDBso4alraEzsJ5zxorrFoTwzPqPg0Y2fC/64usLpXpQVfI5qa2YXqZw1vnxr/zkuOXuwCl/g5wlkzFXq7uFSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR3vX0NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94551C433F1;
	Sun, 24 Mar 2024 23:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321887;
	bh=GFrPxYhwHvxppAzRKMeCfkky5NKmXxQRqJovsb+Soww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PR3vX0NRI9gOP2mC3lQdTddjDL+xE6+VmEQXkqgcvUKfsxkUKxFTSQYdzhbZy6YcO
	 aSHyZGm+K5eA72tlw/+MGQbvcvy29RC877/ToXLBcfwssbxm8YhheOdzMB2yjbdTk8
	 VTH6yWhuevtUmolEpECdZhprlnvcHIy7yVnzn04SEkbrBGJDFEgkbEby5rrWt+EKQn
	 MwtKcPUcZ9A+FZXIBjRn2aZNp+SQXJ/jw2hu1AzNBlYPHDt2YzRQfV8hmwqIs0J2dy
	 Rd+UwbvVE/bMXWJ2sR6XxTsKaAyUMLIKhW/RKi1pRXprV7Dpq1l+35ktwpX5RXYhK4
	 7KwiwT6ZF+1Vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 615/638] dm-integrity: fix a memory leak when rechecking the data
Date: Sun, 24 Mar 2024 19:00:52 -0400
Message-ID: <20240324230116.1348576-616-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 55e565c42dce81a4e49c13262d5bc4eb4c2e588a ]

Memory for the "checksums" pointer will leak if the data is rechecked
after checksum failure (because the associated kfree won't happen due
to 'goto skip_io').

Fix this by freeing the checksums memory before recheck, and just use
the "checksum_onstack" memory for storing checksum during recheck.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 68923c36b6d4c..e2b57699efd74 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1858,12 +1858,12 @@ static void integrity_metadata(struct work_struct *w)
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
+				if (likely(checksums != checksums_onstack))
+					kfree(checksums);
 				if (r > 0) {
-					integrity_recheck(dio, checksums);
+					integrity_recheck(dio, checksums_onstack);
 					goto skip_io;
 				}
-				if (likely(checksums != checksums_onstack))
-					kfree(checksums);
 				goto error;
 			}
 
-- 
2.43.0



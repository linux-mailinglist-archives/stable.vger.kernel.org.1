Return-Path: <stable+bounces-10270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD399827424
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C23286C1D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3B55766;
	Mon,  8 Jan 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvpCcaNp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8B54FBE;
	Mon,  8 Jan 2024 15:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71BCC433CA;
	Mon,  8 Jan 2024 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728523;
	bh=8ASggD/YsBfgb7neWlE6d2MnvTmL0Ax3TAfPpOLlxCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvpCcaNp18SoHIi8wntNkkXIqxoazO5CBXIJujCNhqxIJrJRDgx1L9d3F63PoV59X
	 6hR5Nm5rpW+c0OODH4pxxb4ACjoIMz8IZsxAIxEJ3rr6TjszF+fNV5zR+BunsCjrQj
	 fINfrSTzYbRkPtVUr4uxtdbPxwUL826ASKoeIWyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/150] block: update the stable_writes flag in bdev_add
Date: Mon,  8 Jan 2024 16:35:55 +0100
Message-ID: <20240108153515.975880498@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1898efcdbed32bb1c67269c985a50bab0dbc9493 ]

Propagate the per-queue stable_write flags into each bdev inode in bdev_add.
This makes sure devices that require stable writes have it set for I/O
on the block device node as well.

Note that this doesn't cover the case of a flag changing on a live device
yet.  We should handle that as well, but I plan to cover it as part of a
more general rework of how changing runtime paramters on block devices
works.

Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag")
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231025141020.192413-3-hch@lst.de
Tested-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index d699ecdb32604..b61502ec8da06 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -507,6 +507,8 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	if (bdev_stable_writes(bdev))
+		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
 	bdev->bd_dev = dev;
 	bdev->bd_inode->i_rdev = dev;
 	bdev->bd_inode->i_ino = dev;
-- 
2.43.0





Return-Path: <stable+bounces-14945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71E83833F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A82B28FB82
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226F60BB6;
	Tue, 23 Jan 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A5uoCmGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662260BA5;
	Tue, 23 Jan 2024 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974746; cv=none; b=Ow0sEJzMyfjaPteYdiM22RiqvEkdHhWBn47WjSHd9LzcMmkNql0JtTYZNY5TnbVUpA9PTWnryWGKwcy/NZOAELfKnzESvhBbWqcEwWr55dVH+BZjJiO4SNciopY4i/+Kct1XLgkhi4yRWP4IgISKtVBH1LGKk5c++ucFD2B5igU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974746; c=relaxed/simple;
	bh=Qg3UMYaWSfHBs2cB+G/K0Z6fgcjyEl+Klmg5ON59WuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axC5w/l+8xWnB7EwDySm4x7MTO5cxwfmejxpSDHQfbM8PIfkb0IKDw38wR8akjI30p3DNrsq5bJyd25r+DOTUJvBi1ed0MrieTNAJBcgVeieKPY2DmQeabNXRbe16YPQ01tfrSbzGQY9FbRs40Dnalxiij9GNQIk9uOduLxAb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A5uoCmGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE7AC433F1;
	Tue, 23 Jan 2024 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974746;
	bh=Qg3UMYaWSfHBs2cB+G/K0Z6fgcjyEl+Klmg5ON59WuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5uoCmGx/hoL/d/AB6+Z0aB1k8SF+KujLWyp4BkiXc4cptv/E0nNETzl1oKoSa6AG
	 m+TDIN2PfEHQsOzkAe5XpZiRitKi/xJ5INpcj59WL21nirmKNDr3NnDkgtaQAt3RGN
	 h7//vRWxZx09MDhQCRofPLlbidiaeesQep3nHIJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 154/583] block: Set memalloc_noio to false on device_add_disk() error path
Date: Mon, 22 Jan 2024 15:53:25 -0800
Message-ID: <20240122235816.772040268@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Nan <linan122@huawei.com>

[ Upstream commit 5fa3d1a00c2d4ba14f1300371ad39d5456e890d7 ]

On the error path of device_add_disk(), device's memalloc_noio flag was
set but not cleared. As the comment of pm_runtime_set_memalloc_noio(),
"The function should be called between device_add() and device_del()".
Clear this flag before device_del() now.

Fixes: 25e823c8c37d ("block/genhd.c: apply pm_runtime_set_memalloc_noio on block devices")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231211075356.1839282-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb..95a4b8ae2aea 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -542,6 +542,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	kobject_put(disk->part0->bd_holder_dir);
 out_del_block_link:
 	sysfs_remove_link(block_depr, dev_name(ddev));
+	pm_runtime_set_memalloc_noio(ddev, false);
 out_device_del:
 	device_del(ddev);
 out_free_ext_minor:
-- 
2.43.0





Return-Path: <stable+bounces-10107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558882727C
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638F1C22902
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EF4C3D4;
	Mon,  8 Jan 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7CrlnL0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D034C3A9;
	Mon,  8 Jan 2024 15:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E6C433CC;
	Mon,  8 Jan 2024 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726782;
	bh=41R/WNvSQ9WrHLHhqV62Lzynve/Sp/C77udMbrIRinU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7CrlnL0obictG2SKd3MGt9gAi2WyKCwhROLVZMIJGqAqmJT7ntMuI/K3IK4fzDfB
	 hHUbLWEWnr6n1vxNVI2Hhoza+g9GmZUCkxxu9yqF++97KzlUiQrYq3U58zBc2ZETaV
	 KUJa2U3TaHR8BTRLnUze8MXBF+IBpQzamkfIfl+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/124] RDMA/mlx5: Fix mkey cache WQ flush
Date: Mon,  8 Jan 2024 16:08:22 +0100
Message-ID: <20240108150606.470767364@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit a53e215f90079f617360439b1b6284820731e34c ]

The cited patch tries to ensure no pending works on the mkey cache
workqueue by disabling adding new works and call flush_workqueue().
But this workqueue also has delayed works which might still be pending
the delay time to be queued.

Add cancel_delayed_work() for the delayed works which waits to be queued
and then the flush_workqueue() will flush all works which are already
queued and running.

Fixes: 374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
Link: https://lore.kernel.org/r/b8722f14e7ed81452f791764a26d2ed4cfa11478.1698256179.git.leon@kernel.org
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8a3762d9ff58c..e0629898c3c06 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,11 +1026,13 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
+	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
+		cancel_delayed_work(&ent->dwork);
 	}
 	mutex_unlock(&dev->cache.rb_lock);
 
-- 
2.43.0





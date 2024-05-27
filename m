Return-Path: <stable+bounces-46359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621998D0352
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D271F28242
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F45171070;
	Mon, 27 May 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtTXkujB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129D171068;
	Mon, 27 May 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819266; cv=none; b=kwsM+KMYhiUCILK9YmEWKvkVObQdh/N+doUUzZYAnrNXGcdsdr/qdZ76NduPLEJ2suN1xHW9M4BIyX6towXRrh9b/mjcGJkgGE6ip0gsbCAW+aR/XZEVjwHPen7V6upqboFdO3yRcozERqcHzqWCRiv4Cd0clcGU/HIWwbof28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819266; c=relaxed/simple;
	bh=qtUaOLSbwTNDTzTLaCz5ajMkhHijKLEk06TAQkcmFgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEauJhrOnxq7tfC8Z5Wj0jISJeBdoqmfRenDq2SCuj2+Abq5r5sPI29uNRO3SWb1oY/f31u4OzlBufYDJdeYCpf6EXg3DWSZo6m9c5cQntnUSfAxwT8/X28bKC/QEioFp9LQo+eVpMx0V9Q58H4IpzTSiJQ/3T/GAtkpGDYl040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtTXkujB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A5C32781;
	Mon, 27 May 2024 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819266;
	bh=qtUaOLSbwTNDTzTLaCz5ajMkhHijKLEk06TAQkcmFgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtTXkujBRFMrJ/VMVDyU4iUH/15uL8/PQlTI2nnsNN6qQxjToTJrBcCcso1EDkKjH
	 DXpR6s23CEZTd4eW8b9+dyzZ8kEeu/NG3+aE5sebw/Dm1HH9BfYUPdpZ1cU+dYbV9l
	 +8a8ePv8O6L+vvaYoPvjlWpYP1ppYB1AhPT5UAWvLl9fIDybTOS3Us/2ocGHH9HsQZ
	 BZA2Z89L+dvvF8YzM1t20UUrZZEMMbDg3ZaWDHZRZGbpg3hFLizpMWJQ43oFM+htc9
	 54IOfLBhQ7hUo1Z7Th6buTStkNhGFPUXP8SpPQRW9oJ0e4byv10oFJ1Pa2k16S9LsE
	 5xngStOfGHgqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jian Wen <wenjianhn@gmail.com>,
	Jian Wen <wenjian1@xiaomi.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/30] devlink: use kvzalloc() to allocate devlink instance resources
Date: Mon, 27 May 2024 10:13:13 -0400
Message-ID: <20240527141406.3852821-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Jian Wen <wenjianhn@gmail.com>

[ Upstream commit 730fffce4fd2eb7a0be2d0b6cd7e55e9194d76d5 ]

During live migration of a virtual machine, the SR-IOV VF need to be
re-registered. It may fail when the memory is badly fragmented.

The related log is as follows.

    kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
...
    kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
    kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
    kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
    kernel: Workqueue: events work_for_cpu_fn
    kernel: Call Trace:
    kernel: dump_stack+0x8b/0xc8
    kernel: warn_alloc+0xff/0x170
    kernel: __alloc_pages_slowpath+0x92c/0xb2b
    kernel: ? get_page_from_freelist+0x1d4/0x1140
    kernel: __alloc_pages_nodemask+0x2f9/0x320
    kernel: alloc_pages_current+0x6a/0xb0
    kernel: kmalloc_order+0x1e/0x70
    kernel: kmalloc_order_trace+0x26/0xb0
    kernel: ? __switch_to_asm+0x34/0x70
    kernel: __kmalloc+0x276/0x280
    kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
    kernel: devlink_alloc+0x29/0x110
    kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
    kernel: init_one+0x1d/0x650 [mlx5_core]
    kernel: local_pci_probe+0x46/0x90
    kernel: work_for_cpu_fn+0x1a/0x30
    kernel: process_one_work+0x16d/0x390
    kernel: worker_thread+0x1d3/0x3f0
    kernel: kthread+0x105/0x140
    kernel: ? max_active_store+0x80/0x80
    kernel: ? kthread_bind+0x20/0x20
    kernel: ret_from_fork+0x3a/0x50

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
Link: https://lore.kernel.org/r/20240327082128.942818-1-wenjian1@xiaomi.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 7f0b093208d75..f49cd83f1955f 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
-	kfree(devlink);
+	kvfree(devlink);
 }
 
 void devlink_put(struct devlink *devlink)
@@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
-	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
+	devlink = kvzalloc(struct_size(devlink, priv, priv_size), GFP_KERNEL);
 	if (!devlink)
 		return NULL;
 
@@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	return devlink;
 
 err_xa_alloc:
-	kfree(devlink);
+	kvfree(devlink);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
-- 
2.43.0



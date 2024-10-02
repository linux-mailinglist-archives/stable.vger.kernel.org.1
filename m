Return-Path: <stable+bounces-79054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64698D653
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F6328519B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EB1D07A3;
	Wed,  2 Oct 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dblgZwn2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24851D0412;
	Wed,  2 Oct 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876304; cv=none; b=mnk7kjwlTXrG+5R5qyPrGu0CejzGm954ZqddP7Vq8+PIst4HMr5mpr1YGQhmVEmhnzLy2D0bkjOhFpCHqsTIKQTc2FPUJYFKKcrRKixqcHe8my4XhlGjn5RyPQ5HBhIrwkIObxAVKHXVxOmMCNTAS6MdmIQySb7qWz5Bjx4Kw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876304; c=relaxed/simple;
	bh=hFmBU5IgRV10Ag+cq5EF83MeGsdOHJlHoBgBnjt4zn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5ORtodRjE0uPNvIJKx6uTVGHCyssfVjm2XCaJmD/jCEpDy+ZFNPzZCt3dhddGZyk2c2JKUwmBYJooAaJDWmSsoaeelHSeb9mc5+2HmSGg/shfG2BgidWa+sOUcI4tgSPHvmrqqBhM3vl/cJJuW48oW1mj6SaH4779Lov2boo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dblgZwn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF41C4CEC5;
	Wed,  2 Oct 2024 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876304;
	bh=hFmBU5IgRV10Ag+cq5EF83MeGsdOHJlHoBgBnjt4zn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dblgZwn2VTm/MZIQF3qDNuMmVm6QVMnJwzTtzARzoUiZAnO6HeFzTQMvS/Z2Z7yEp
	 MWINEnXoGfm1d1TPpZK23YSu39fMvd7oBEA0Cv4Mt5lR/VwGUznWK6ASS04vaiOlKX
	 j7n0uQ7zDQA3it0LjcLwIQfZafYPLu4x83V3rU28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mi <cmi@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 399/695] IB/mlx5: Fix UMR pd cleanup on error flow of driver init
Date: Wed,  2 Oct 2024 14:56:37 +0200
Message-ID: <20241002125838.385088764@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Mi <cmi@nvidia.com>

[ Upstream commit 112e6e83a894260cc7efe79a1fc47d4d51461742 ]

The cited commit moves the pd allocation from function
mlx5r_umr_resource_cleanup() to a new function mlx5r_umr_cleanup().
So the fix in commit [1] is broken. In error flow, will hit panic [2].

Fix it by checking pd pointer to avoid panic if it is NULL;

[1] RDMA/mlx5: Fix UMR cleanup on error flow of driver init
[2]
 [  347.567063] infiniband mlx5_0: Couldn't register device with driver model
 [  347.591382] BUG: kernel NULL pointer dereference, address: 0000000000000020
 [  347.593438] #PF: supervisor read access in kernel mode
 [  347.595176] #PF: error_code(0x0000) - not-present page
 [  347.596962] PGD 0 P4D 0
 [  347.601361] RIP: 0010:ib_dealloc_pd_user+0x12/0xc0 [ib_core]
 [  347.604171] RSP: 0018:ffff888106293b10 EFLAGS: 00010282
 [  347.604834] RAX: 0000000000000000 RBX: 000000000000000e RCX: 0000000000000000
 [  347.605672] RDX: ffff888106293ad0 RSI: 0000000000000000 RDI: 0000000000000000
 [  347.606529] RBP: 0000000000000000 R08: ffff888106293ae0 R09: ffff888106293ae0
 [  347.607379] R10: 0000000000000a06 R11: 0000000000000000 R12: 0000000000000000
 [  347.608224] R13: ffffffffa0704dc0 R14: 0000000000000001 R15: 0000000000000001
 [  347.609067] FS:  00007fdc720cd9c0(0000) GS:ffff88852c880000(0000) knlGS:0000000000000000
 [  347.610094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  347.610727] CR2: 0000000000000020 CR3: 0000000103012003 CR4: 0000000000370eb0
 [  347.611421] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [  347.612113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [  347.612804] Call Trace:
 [  347.613130]  <TASK>
 [  347.613417]  ? __die+0x20/0x60
 [  347.613793]  ? page_fault_oops+0x150/0x3e0
 [  347.614243]  ? free_msg+0x68/0x80 [mlx5_core]
 [  347.614840]  ? cmd_exec+0x48f/0x11d0 [mlx5_core]
 [  347.615359]  ? exc_page_fault+0x74/0x130
 [  347.615808]  ? asm_exc_page_fault+0x22/0x30
 [  347.616273]  ? ib_dealloc_pd_user+0x12/0xc0 [ib_core]
 [  347.616801]  mlx5r_umr_cleanup+0x23/0x90 [mlx5_ib]
 [  347.617365]  mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x36/0x40 [mlx5_ib]
 [  347.618025]  __mlx5_ib_add+0x96/0xd0 [mlx5_ib]
 [  347.618539]  mlx5r_probe+0xe9/0x310 [mlx5_ib]
 [  347.619032]  ? kernfs_add_one+0x107/0x150
 [  347.619478]  ? __mlx5_ib_add+0xd0/0xd0 [mlx5_ib]
 [  347.619984]  auxiliary_bus_probe+0x3e/0x90
 [  347.620448]  really_probe+0xc5/0x3a0
 [  347.620857]  __driver_probe_device+0x80/0x160
 [  347.621325]  driver_probe_device+0x1e/0x90
 [  347.621770]  __driver_attach+0xec/0x1c0
 [  347.622213]  ? __device_attach_driver+0x100/0x100
 [  347.622724]  bus_for_each_dev+0x71/0xc0
 [  347.623151]  bus_add_driver+0xed/0x240
 [  347.623570]  driver_register+0x58/0x100
 [  347.623998]  __auxiliary_driver_register+0x6a/0xc0
 [  347.624499]  ? driver_register+0xae/0x100
 [  347.624940]  ? 0xffffffffa0893000
 [  347.625329]  mlx5_ib_init+0x16a/0x1e0 [mlx5_ib]
 [  347.625845]  do_one_initcall+0x4a/0x2a0
 [  347.626273]  ? gcov_event+0x2e2/0x3a0
 [  347.626706]  do_init_module+0x8a/0x260
 [  347.627126]  init_module_from_file+0x8b/0xd0
 [  347.627596]  __x64_sys_finit_module+0x1ca/0x2f0
 [  347.628089]  do_syscall_64+0x4c/0x100

Fixes: 638420115cc4 ("IB/mlx5: Create UMR QP just before first reg_mr occurs")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Link: https://patch.msgid.link/778c40c60287992da5d6ec92bb07b67f7bb5e6ef.1725273295.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/umr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index ffc31b01f6905..8823ecc84e60e 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -224,6 +224,9 @@ int mlx5r_umr_init(struct mlx5_ib_dev *dev)
 
 void mlx5r_umr_cleanup(struct mlx5_ib_dev *dev)
 {
+	if (!dev->umrc.pd)
+		return;
+
 	mutex_destroy(&dev->umrc.init_lock);
 	ib_dealloc_pd(dev->umrc.pd);
 }
-- 
2.43.0





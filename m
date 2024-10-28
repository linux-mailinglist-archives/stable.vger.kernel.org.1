Return-Path: <stable+bounces-88408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04A9B25D9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E021F21BCE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637D18FDC2;
	Mon, 28 Oct 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NHkw6Fw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355918E04F;
	Mon, 28 Oct 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097263; cv=none; b=fPQezciPO3BXSuhCnXI07IrCYz7rM+pm9XjvjAAUpBoM52/UgNDlQqaqDAEOFAhDuETXnaZGQYwYHWahHbcqp1Dgu8VkWENm4EeHeC457cZ9ZcRalS0UU5Wa/T58ykKMFqh3YsbVyuQLdv/MFJ1r0LjqwXdwyFRl8HH82GJ4Rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097263; c=relaxed/simple;
	bh=/6Be8YVJdAR8RkqasctKNJ1ZVSY86SnnSfEYvMXQp44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piBiEWNusEYxod76UcCFi6Nik9coVIblugLE8Z615MYI5942hPK+6XEkAE+YgRIwKRcqmKZDqZ2f2LnFI4dqzd10MMukVBe/9bDaGy/d1YFmZCllCT8AQLrVIuSiN67YK+mjryyhizCv7ZrmLodc8LTxTSFldmf6iYaleSY2XQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NHkw6Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA01C4CEC7;
	Mon, 28 Oct 2024 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097263;
	bh=/6Be8YVJdAR8RkqasctKNJ1ZVSY86SnnSfEYvMXQp44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0NHkw6Fwd8fdDNIwuITDRZaxm5q6UWi4DY/q3155dJ4uby9rMCE4m9rm+F29RkQ6h
	 pEuDnY566T2jF6kUFDeBiEF9fV5V91TvwrAqFX84/7wc3pr7R8y8ZM4uO5xM1egR7I
	 AdnusmUYmchWoFqWwoBFX25v9ed24fYarng1wbBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 053/137] net/mlx5: Fix command bitmask initialization
Date: Mon, 28 Oct 2024 07:24:50 +0100
Message-ID: <20241028062300.210543223@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit d62b14045c6511a7b2d4948d1a83a4e592deeb05 ]

Command bitmask have a dedicated bit for MANAGE_PAGES command, this bit
isn't Initialize during command bitmask Initialization, only during
MANAGE_PAGES.

In addition, mlx5_cmd_trigger_completions() is trying to trigger
completion for MANAGE_PAGES command as well.

Hence, in case health error occurred before any MANAGE_PAGES command
have been invoke (for example, during mlx5_enable_hca()),
mlx5_cmd_trigger_completions() will try to trigger completion for
MANAGE_PAGES command, which will result in null-ptr-deref error.[1]

Fix it by Initialize command bitmask correctly.

While at it, re-write the code for better understanding.

[1]
BUG: KASAN: null-ptr-deref in mlx5_cmd_trigger_completions+0x1db/0x600 [mlx5_core]
Write of size 4 at addr 0000000000000214 by task kworker/u96:2/12078
CPU: 10 PID: 12078 Comm: kworker/u96:2 Not tainted 6.9.0-rc2_for_upstream_debug_2024_04_07_19_01 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5_health0000:08:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x7e/0xc0
 kasan_report+0xb9/0xf0
 kasan_check_range+0xec/0x190
 mlx5_cmd_trigger_completions+0x1db/0x600 [mlx5_core]
 mlx5_cmd_flush+0x94/0x240 [mlx5_core]
 enter_error_state+0x6c/0xd0 [mlx5_core]
 mlx5_fw_fatal_reporter_err_work+0xf3/0x480 [mlx5_core]
 process_one_work+0x787/0x1490
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? pwq_dec_nr_in_flight+0xda0/0xda0
 ? assign_work+0x168/0x240
 worker_thread+0x586/0xd30
 ? rescuer_thread+0xae0/0xae0
 kthread+0x2df/0x3b0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x2d/0x70
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

Fixes: 9b98d395b85d ("net/mlx5: Start health poll at earlier stage of driver load")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index c6ddf51818efe..4a1eb6cd699cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1755,6 +1755,10 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 	}
 }
 
+#define MLX5_MAX_MANAGE_PAGES_CMD_ENT 1
+#define MLX5_CMD_MASK ((1UL << (cmd->vars.max_reg_cmds + \
+			   MLX5_MAX_MANAGE_PAGES_CMD_ENT)) - 1)
+
 static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;
@@ -1766,7 +1770,7 @@ static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 	/* wait for pending handlers to complete */
 	mlx5_eq_synchronize_cmd_irq(dev);
 	spin_lock_irqsave(&dev->cmd.alloc_lock, flags);
-	vector = ~dev->cmd.vars.bitmask & ((1ul << (1 << dev->cmd.vars.log_sz)) - 1);
+	vector = ~dev->cmd.vars.bitmask & MLX5_CMD_MASK;
 	if (!vector)
 		goto no_trig;
 
@@ -2301,7 +2305,7 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 
 	cmd->state = MLX5_CMDIF_STATE_DOWN;
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
-	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
+	cmd->vars.bitmask = MLX5_CMD_MASK;
 
 	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
 	sema_init(&cmd->vars.pages_sem, 1);
-- 
2.43.0





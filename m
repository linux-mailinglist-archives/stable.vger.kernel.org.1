Return-Path: <stable+bounces-42649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBE8B73FD
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99666B2149E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8D12D76D;
	Tue, 30 Apr 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdW8O5eL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB812D762;
	Tue, 30 Apr 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476339; cv=none; b=ckE2l5ZYkQsaLxscNuhjNPkyj0UIb+ob3SDfhCCS2EMhNgOVCoouGk9mQeXa3flmxCocX4LfdosPs+4juJN6+o6t4o5KmykTB4VXD8Gop5+Tsns5/3uiKil64R4l3w+zSHlWqFphKt6a95afJvh2ckJJqC2Rboj78IHcl0HjISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476339; c=relaxed/simple;
	bh=I9oExOZVV+bB3NNOcNcRpSCzpoG/LUInjo4t7/Jcn3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8DpEhQdcQ8H5xjP9oIdOhhRWLkCa5oZPH1sNjyfpSiGh9uqGMvXQbLaANi5DO3rEfRrKHqsMo+nyYWRxzqfACeae0dYbTvnp/g2Kv29A836D5IjtLd1/UAErKw073Uppn/IdaO0YvDp19/J6kGEqqA7olV4BrF99uKZ0fwyg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DdW8O5eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C521C2BBFC;
	Tue, 30 Apr 2024 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476339;
	bh=I9oExOZVV+bB3NNOcNcRpSCzpoG/LUInjo4t7/Jcn3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdW8O5eLNCUcECgsTs/xsxqS4o+fkY3eU4ZSlh3kQxbyC+MOFpRPEXMAMYBMbTWsK
	 UFIXRpth7xueSolUGPp8nK+SBu0bz15U7jt+beX7/CMbSocjHreL7zbMEKBBxYuWnN
	 bgkJ9Xt0UNoSuNURyQH3aCsCNF3F5TBoyKSi9RHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Shifeng Li <lishifeng@sangfor.com.cn>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Subject: [PATCH 5.4 085/107] net/mlx5e: Fix a race in command alloc flow
Date: Tue, 30 Apr 2024 12:40:45 +0200
Message-ID: <20240430103047.166753948@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shifeng Li <lishifeng@sangfor.com.cn>

commit 8f5100da56b3980276234e812ce98d8f075194cd upstream.

Fix a cmd->ent use after free due to a race on command entry.
Such race occurs when one of the commands releases its last refcount and
frees its index and entry while another process running command flush
flow takes refcount to this command entry. The process which handles
commands flush may see this command as needed to be flushed if the other
process allocated a ent->idx but didn't set ent to cmd->ent_arr in
cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
the spin lock.

[70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
[70013.081968]
[70013.082028] Workqueue: events aer_isr
[70013.082053] Call Trace:
[70013.082067]  dump_stack+0x8b/0xbb
[70013.082086]  print_address_description+0x6a/0x270
[70013.082102]  kasan_report+0x179/0x2c0
[70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
[70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
[70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
[70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
[70013.082409]  pci_device_remove+0xf3/0x280
[70013.082439]  device_release_driver_internal+0x1c3/0x470
[70013.082453]  pci_stop_bus_device+0x109/0x160
[70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
[70013.082485]  pcie_do_fatal_recovery+0x167/0x550
[70013.082493]  aer_isr+0x7d2/0x960
[70013.082543]  process_one_work+0x65f/0x12d0
[70013.082556]  worker_thread+0x87/0xb50
[70013.082571]  kthread+0x2e9/0x3a0
[70013.082592]  ret_from_fork+0x1f/0x40

The logical relationship of this error is as follows:

             aer_recover_work              |          ent->work
-------------------------------------------+------------------------------
aer_recover_work_func                      |
|- pcie_do_recovery                        |
  |- report_error_detected                 |
    |- mlx5_pci_err_detected               |cmd_work_handler
      |- mlx5_enter_error_state            |  |- cmd_alloc_index
        |- enter_error_state               |    |- lock cmd->alloc_lock
          |- mlx5_cmd_flush                |    |- clear_bit
            |- mlx5_cmd_trigger_completions|    |- unlock cmd->alloc_lock
              |- lock cmd->alloc_lock      |
              |- vector = ~dev->cmd.vars.bitmask
              |- for_each_set_bit          |
                |- cmd_ent_get(cmd->ent_arr[i]) (UAF)
              |- unlock cmd->alloc_lock    |  |- cmd->ent_arr[ent->idx]=ent

The cmd->ent_arr[ent->idx] assignment and the bit clearing are not
protected by the cmd->alloc_lock in cmd_work_handler().

Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry while timeout comp handler")
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -114,15 +114,18 @@ static u8 alloc_token(struct mlx5_cmd *c
 	return token;
 }
 
-static int cmd_alloc_index(struct mlx5_cmd *cmd)
+static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
 	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
-	if (ret < cmd->max_reg_cmds)
+	if (ret < cmd->max_reg_cmds) {
 		clear_bit(ret, &cmd->bitmask);
+		ent->idx = ret;
+		cmd->ent_arr[ent->idx] = ent;
+	}
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
@@ -905,7 +908,7 @@ static void cmd_work_handler(struct work
 	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
 	down(sem);
 	if (!ent->page_queue) {
-		alloc_ret = cmd_alloc_index(cmd);
+		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err(dev, "failed to allocate command entry\n");
 			if (ent->callback) {
@@ -920,15 +923,14 @@ static void cmd_work_handler(struct work
 			up(sem);
 			return;
 		}
-		ent->idx = alloc_ret;
 	} else {
 		ent->idx = cmd->max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->bitmask);
+		cmd->ent_arr[ent->idx] = ent;
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
-	cmd->ent_arr[ent->idx] = ent;
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));




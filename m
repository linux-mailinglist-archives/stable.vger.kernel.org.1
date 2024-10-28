Return-Path: <stable+bounces-88573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F809B2690
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEDB1C2130F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B218E350;
	Mon, 28 Oct 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lx8pXgHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783E2C697;
	Mon, 28 Oct 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097639; cv=none; b=LfjOeOyAVVC4xCRaRmT84SbMn9nlxUmsBBvK0cIdeMNB7CV6rWSdQy2j6xvmpzHtJLyl+f3i5hoc1ZbtTohaK4osG2P2xwaDiP7nAXrkvNYFAk7CgUe4Dsf4qrCcmX6nUQeMJyAJOIGeV69vKkUw5eLm3Rt4j3Wp1RzbaSFu52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097639; c=relaxed/simple;
	bh=ghbpJYJq1nOGiBx2y2ygPxGRvxGnNQVtr1u9nzkhH+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjRpslbmtW1YSIbBijh/oAX5kNfvTR49muh2ekBnJF7b7tMrTAbJQGgk3l4EIG0G+GTrgIogM2z4MI474Y6ZCUwPdol9sS/FFOsAiqqHPaw+jdvpec3ft5/jfa30K6n7dXULXWB/1NcMZuv1GWO1EXNJtTbNXlP7IZXcrZLIaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lx8pXgHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F3DC4CEC3;
	Mon, 28 Oct 2024 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097638;
	bh=ghbpJYJq1nOGiBx2y2ygPxGRvxGnNQVtr1u9nzkhH+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lx8pXgHIHAgqqkNbq6zZEtn30q/GjB6oOCO8o0jtaGdhSCTeMRG10VGs2sylQLL8j
	 Xd0S0LeSnJlDeGYEzlKhyRg2K5eP5xdIqfAoOJhB8COUxDKdVmzRbIbpzBCOClvaQL
	 Oqm7Zkn8IBEO/w+LoZC49DGoWivbQ4/OBAuRDyO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/208] net/mlx5: Unregister notifier on eswitch init failure
Date: Mon, 28 Oct 2024 07:24:21 +0100
Message-ID: <20241028062308.641733993@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit 1da9cfd6c41c2e6bbe624d0568644e1521c33e12 ]

It otherwise remains registered and a subsequent attempt at eswitch
enabling might trigger warnings of the sort:

[  682.589148] ------------[ cut here ]------------
[  682.590204] notifier callback eswitch_vport_event [mlx5_core] already registered
[  682.590256] WARNING: CPU: 13 PID: 2660 at kernel/notifier.c:31 notifier_chain_register+0x3e/0x90
[...snipped]
[  682.610052] Call Trace:
[  682.610369]  <TASK>
[  682.610663]  ? __warn+0x7c/0x110
[  682.611050]  ? notifier_chain_register+0x3e/0x90
[  682.611556]  ? report_bug+0x148/0x170
[  682.611977]  ? handle_bug+0x36/0x70
[  682.612384]  ? exc_invalid_op+0x13/0x60
[  682.612817]  ? asm_exc_invalid_op+0x16/0x20
[  682.613284]  ? notifier_chain_register+0x3e/0x90
[  682.613789]  atomic_notifier_chain_register+0x25/0x40
[  682.614322]  mlx5_eswitch_enable_locked+0x1d4/0x3b0 [mlx5_core]
[  682.614965]  mlx5_eswitch_enable+0xc9/0x100 [mlx5_core]
[  682.615551]  mlx5_device_enable_sriov+0x25/0x340 [mlx5_core]
[  682.616170]  mlx5_core_sriov_configure+0x50/0x170 [mlx5_core]
[  682.616789]  sriov_numvfs_store+0xb0/0x1b0
[  682.617248]  kernfs_fop_write_iter+0x117/0x1a0
[  682.617734]  vfs_write+0x231/0x3f0
[  682.618138]  ksys_write+0x63/0xe0
[  682.618536]  do_syscall_64+0x4c/0x100
[  682.618958]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 7624e58a8b3a ("net/mlx5: E-switch, register event handler before arming the event")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 1789800faaeb6..f6022c135ec02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1489,7 +1489,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	}
 
 	if (err)
-		goto abort;
+		goto err_esw_enable;
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
@@ -1503,7 +1503,8 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	return 0;
 
-abort:
+err_esw_enable:
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_esw_acls_ns_cleanup(esw);
 	return err;
 }
-- 
2.43.0





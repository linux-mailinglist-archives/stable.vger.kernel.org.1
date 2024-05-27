Return-Path: <stable+bounces-46829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF08D0B70
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23911C210F6
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A11DFED;
	Mon, 27 May 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6HEcyAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715A17E90E;
	Mon, 27 May 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836962; cv=none; b=sWY3UQPspXV062S0TUKdfxjdLD0yixKzc8j2t4b+GTzJ4O4DoLe+/V4vIG+sN5aNUFX55VHhDg8MKjlDtD008NmIn4HdXc2NW1fMuP9UIDXaAkhngsyW7H4zqhPYrofNrm52OK5A6anw+NGVi6s/knFmwP9dm5qWrGAakhS3LQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836962; c=relaxed/simple;
	bh=3Ibr/Vik+Y1VwXyeGfE+4Vgzjt/8o4GpyOvTrAgf5ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdTk4eNfgc2QjAxIoyji6TtTmwIrv6kqf+D51Y/VTiOMIPmFDjxwwUfmhIRgq+7FzYQqqX777atjb9f+riKxEARtJ7LLAqZslDyT5W9zNrXQlOqgHnXd/Ng6B56af61FrTEF8Gp2Dwju3HzQs2Z3drQ2GIZ/7sW/sEKy11L+P6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6HEcyAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C1AC2BBFC;
	Mon, 27 May 2024 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836961;
	bh=3Ibr/Vik+Y1VwXyeGfE+4Vgzjt/8o4GpyOvTrAgf5ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6HEcyAorQkvPqhlh8bgCIo/LgCpzMIzts+qkRlKS50ZUtdcUNR6m8wZ/VxElWqDV
	 jqb22FGi7amKYBVdVZXhNaJHb9TibZUKlu521FaToqMFWmXuRjhHc24QLeno4ZpMue
	 74VC53uG6XRRHFifjO5BgfdNJBv5TyiFXaWIAOaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 255/427] net/mlx5: Discard command completions in internal error
Date: Mon, 27 May 2024 20:55:02 +0200
Message-ID: <20240527185626.327888899@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akiva Goldberger <agoldberger@nvidia.com>

[ Upstream commit db9b31aa9bc56ff0d15b78f7e827d61c4a096e40 ]

Fix use after free when FW completion arrives while device is in
internal error state. Avoid calling completion handler in this case,
since the device will flush the command interface and trigger all
completions manually.

Kernel log:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
...
RIP: 0010:refcount_warn_saturate+0xd8/0xe0
...
Call Trace:
<IRQ>
? __warn+0x79/0x120
? refcount_warn_saturate+0xd8/0xe0
? report_bug+0x17c/0x190
? handle_bug+0x3c/0x60
? exc_invalid_op+0x14/0x70
? asm_exc_invalid_op+0x16/0x20
? refcount_warn_saturate+0xd8/0xe0
cmd_ent_put+0x13b/0x160 [mlx5_core]
mlx5_cmd_comp_handler+0x5f9/0x670 [mlx5_core]
cmd_comp_notifier+0x1f/0x30 [mlx5_core]
notifier_call_chain+0x35/0xb0
atomic_notifier_call_chain+0x16/0x20
mlx5_eq_async_int+0xf6/0x290 [mlx5_core]
notifier_call_chain+0x35/0xb0
atomic_notifier_call_chain+0x16/0x20
irq_int_handler+0x19/0x30 [mlx5_core]
__handle_irq_event_percpu+0x4b/0x160
handle_irq_event+0x2e/0x80
handle_edge_irq+0x98/0x230
__common_interrupt+0x3b/0xa0
common_interrupt+0x7b/0xa0
</IRQ>
<TASK>
asm_common_interrupt+0x22/0x40

Fixes: 51d138c2610a ("net/mlx5: Fix health error state handling")
Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240509112951.590184-6-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 511e7fee39ac5..20768ef2e9d2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1634,6 +1634,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
-- 
2.43.0





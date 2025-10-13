Return-Path: <stable+bounces-184399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AFBD4303
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC075036B7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0A30CDB3;
	Mon, 13 Oct 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ujv0vAng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35C30CDBC;
	Mon, 13 Oct 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367324; cv=none; b=Pe0fg1psMJEP3CcfLlw9fjXaOi4mjmkMqXRRPE4dqwncHBoM/xxK4TCUOv9EiunBGvGzxQJXEFsGU2h4JxNo9JKV9chrPoXkX99sQ15sAEN/pyhlBeEwnx0aUIoZLwms5e7hFZLi6JnQDfsm+x9rc/rZ9HPK1+PIcQ4isp7v8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367324; c=relaxed/simple;
	bh=HWqI8NPW67XRKY0NUvxW1nQ8Z80xWx+DtfsglwslHIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh+vE+qYz07Qx+0mcLrCPT6z7bm4sb3hgK/YmtYlnkOuQw0E7+JDbg7le8cZHd5U0d0IHRjYVtlj/ej0PcgLSLslghR1dk9sopYPPhFdLzRX9ERzqWeAYI0I8pzjlyfQk6LUElMQYFLR0qbkvihtTdG4lkGUgCgi+5MRYOO2VuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ujv0vAng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995E0C4CEE7;
	Mon, 13 Oct 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367324;
	bh=HWqI8NPW67XRKY0NUvxW1nQ8Z80xWx+DtfsglwslHIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ujv0vAngUeJL3nmolzCZ+FowgDHylLN0tdgucNHmIl5rJdP4yy7mlaqmwK9Mbt7XE
	 E3sZWtnqtSvd6DXu/9T3dKC2OjIDvEmWebgEO3jO0QNNCBId1+kZUQu0HBCBdn1sQz
	 Q/lfFy7G16SW27hFyuqLvbw/ITq7wQqRxgArRE9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drori <shayd@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 170/196] net/mlx5: fw reset, add reset timeout work
Date: Mon, 13 Oct 2025 16:45:43 +0200
Message-ID: <20251013144320.846578921@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit 5cfbe7ebfa42fd3c517a701dab5bd73524da9088 ]

Add sync reset timeout to stop poll_sync_reset in case there was no
reset done or abort event within timeout. Otherwise poll sync reset will
just continue and in case of fw fatal error no health reporting will be
done.

Fixes: 38b9f903f22b ("net/mlx5: Handle sync reset request event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 1a818759a9aac..de130c75de64e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -22,6 +22,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_reload_work;
 	struct work_struct reset_now_work;
 	struct work_struct reset_abort_work;
+	struct delayed_work reset_timeout_work;
 	unsigned long reset_flags;
 	struct timer_list timer;
 	struct completion done;
@@ -180,6 +181,8 @@ static int mlx5_sync_reset_clear_reset_requested(struct mlx5_core_dev *dev, bool
 		return -EALREADY;
 	}
 
+	if (current_work() != &fw_reset->reset_timeout_work.work)
+		cancel_delayed_work(&fw_reset->reset_timeout_work);
 	mlx5_stop_sync_reset_poll(dev);
 	if (poll_health)
 		mlx5_start_health_poll(dev);
@@ -250,6 +253,11 @@ static int mlx5_sync_reset_set_reset_requested(struct mlx5_core_dev *dev)
 	}
 	mlx5_stop_health_poll(dev, true);
 	mlx5_start_sync_reset_poll(dev);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
+		      &fw_reset->reset_flags))
+		schedule_delayed_work(&fw_reset->reset_timeout_work,
+			msecs_to_jiffies(mlx5_tout_ms(dev, PCI_SYNC_UPDATE)));
 	return 0;
 }
 
@@ -445,6 +453,19 @@ static void mlx5_sync_reset_events_handle(struct mlx5_fw_reset *fw_reset, struct
 	}
 }
 
+static void mlx5_sync_reset_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work,
+						  work);
+	struct mlx5_fw_reset *fw_reset =
+		container_of(dwork, struct mlx5_fw_reset, reset_timeout_work);
+	struct mlx5_core_dev *dev = fw_reset->dev;
+
+	if (mlx5_sync_reset_clear_reset_requested(dev, true))
+		return;
+	mlx5_core_warn(dev, "PCI Sync FW Update Reset Timeout.\n");
+}
+
 static int fw_reset_event_notifier(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct mlx5_fw_reset *fw_reset = mlx5_nb_cof(nb, struct mlx5_fw_reset, nb);
@@ -513,6 +534,7 @@ void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 	cancel_work_sync(&fw_reset->reset_reload_work);
 	cancel_work_sync(&fw_reset->reset_now_work);
 	cancel_work_sync(&fw_reset->reset_abort_work);
+	cancel_delayed_work(&fw_reset->reset_timeout_work);
 }
 
 int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
@@ -535,6 +557,8 @@ int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 	INIT_WORK(&fw_reset->reset_reload_work, mlx5_sync_reset_reload_work);
 	INIT_WORK(&fw_reset->reset_now_work, mlx5_sync_reset_now_event);
 	INIT_WORK(&fw_reset->reset_abort_work, mlx5_sync_reset_abort_event);
+	INIT_DELAYED_WORK(&fw_reset->reset_timeout_work,
+			  mlx5_sync_reset_timeout_work);
 
 	init_completion(&fw_reset->done);
 	return 0;
-- 
2.51.0





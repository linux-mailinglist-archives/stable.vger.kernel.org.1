Return-Path: <stable+bounces-228492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHVDOPJOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C3D2F4B02
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A02314130B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1D3AD537;
	Mon, 23 Mar 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m07Vyppp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB03AE6E2;
	Mon, 23 Mar 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275276; cv=none; b=ObR09JeGnIuB7SKE4ThyZuFmjYFZJGdvFrsexTo8Oe3JP0jtFCCx6Q/YvhC9dQKw2X6ZKdq4keJbB2YL65OY5Tb0I9DNenUlEvcrjSF4Kwj+0k0a1Zr+aHnLmb9Y4zJIvLBiOz/J0Jjpin27+FBX1pCUR2ZmJvxqlXq+N646AIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275276; c=relaxed/simple;
	bh=8ZadGV1fXd4jxC0JJ/Mj5q3GnjNipi2KiXgIKLjxWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4dxgwYZGip0Qq7kXjBEJ9MfjDTASujUCjcYvoTlEZn8q8N0G6i5MewIf3sGeSQTPvJX9o46juY9Y7pKW4csTIE2CrashbqK1W2CqeI+GlohHijpc9pqaf4P7jCLzKw7aNJ4rR3VWPPuX1GCaHC5dJkmYaMAbbuptvtk5EZDV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m07Vyppp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85177C4CEF7;
	Mon, 23 Mar 2026 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275275;
	bh=8ZadGV1fXd4jxC0JJ/Mj5q3GnjNipi2KiXgIKLjxWno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m07VypppoePZiPKXhXnBvXbw9uN+iR8U7TdHHDhgESaK+GzSeoWwP5YH/oR2/FVzo
	 R2W3F6sJmjHSdQzdS3tg9jSSZTwk3O+0M91ftmWSjPuqOUn9IHe+w507cR9ECnxvrs
	 UVwvGSZQY9gIkrFyujepvoZeHOYKgI0UKdKADl7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 037/460] net/mlx5: Fix deadlock between devlink lock and esw->wq
Date: Mon, 23 Mar 2026 14:40:33 +0100
Message-ID: <20260323134527.619852653@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228492-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 19C3D2F4B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit aed763abf0e905b4b8d747d1ba9e172961572f57 ]

esw->work_queue executes esw_functions_changed_event_handler ->
esw_vfs_changed_event_handler and acquires the devlink lock.

.eswitch_mode_set (acquires devlink lock in devlink_nl_pre_doit) ->
mlx5_devlink_eswitch_mode_set -> mlx5_eswitch_disable_locked ->
mlx5_eswitch_event_handler_unregister -> flush_workqueue deadlocks
when esw_vfs_changed_event_handler executes.

Fix that by no longer flushing the work to avoid the deadlock, and using
a generation counter to keep track of work relevance. This avoids an old
handler manipulating an esw that has undergone one or more mode changes:
- the counter is incremented in mlx5_eswitch_event_handler_unregister.
- the counter is read and passed to the ephemeral mlx5_host_work struct.
- the work handler takes the devlink lock and bails out if the current
  generation is different than the one it was scheduled to operate on.
- mlx5_eswitch_cleanup does the final draining before destroying the wq.

No longer flushing the workqueue has the side effect of maybe no longer
cancelling pending vport_change_handler work items, but that's ok since
those are disabled elsewhere:
- mlx5_eswitch_disable_locked disables the vport eq notifier.
- mlx5_esw_vport_disable disarms the HW EQ notification and marks
  vport->enabled under state_lock to false to prevent pending vport
  handler from doing anything.
- mlx5_eswitch_cleanup destroys the workqueue and makes sure all events
  are disabled/finished.

Fixes: f1bc646c9a06 ("net/mlx5: Use devl_ API in mlx5_esw_offloads_devlink_port_register")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260305081019.1811100-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c  |  7 ++++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 +++++++++++++-----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index b26ab78006ea0..864e88f057714 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1068,10 +1068,11 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 
 static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
+	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
-
-	flush_workqueue(esw->work_queue);
+		atomic_inc(&esw->esw_funcs.generation);
+	}
 }
 
 static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index be6e60d961689..63c2b36ce967b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -312,10 +312,12 @@ struct esw_mc_addr { /* SRIOV only */
 struct mlx5_host_work {
 	struct work_struct	work;
 	struct mlx5_eswitch	*esw;
+	int			work_gen;
 };
 
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
+	atomic_t		generation;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 7cead1ba0bfa1..b122003d8bcde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3402,22 +3402,28 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 }
 
 static void
-esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
+esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
+			      const u32 *out)
 {
 	struct devlink *devlink;
 	bool host_pf_disabled;
 	u16 new_num_vfs;
 
+	devlink = priv_to_devlink(esw->dev);
+	devl_lock(devlink);
+
+	/* Stale work from one or more mode changes ago. Bail out. */
+	if (work_gen != atomic_read(&esw->esw_funcs.generation))
+		goto unlock;
+
 	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
 			       host_params_context.host_num_of_vfs);
 	host_pf_disabled = MLX5_GET(query_esw_functions_out, out,
 				    host_params_context.host_pf_disabled);
 
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
-		return;
+		goto unlock;
 
-	devlink = priv_to_devlink(esw->dev);
-	devl_lock(devlink);
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -3432,6 +3438,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, const u32 *out)
 		}
 	}
 	esw->esw_funcs.num_vfs = new_num_vfs;
+unlock:
 	devl_unlock(devlink);
 }
 
@@ -3448,7 +3455,7 @@ static void esw_functions_changed_event_handler(struct work_struct *work)
 	if (IS_ERR(out))
 		goto out;
 
-	esw_vfs_changed_event_handler(esw, out);
+	esw_vfs_changed_event_handler(esw, host_work->work_gen, out);
 	kvfree(out);
 out:
 	kfree(host_work);
@@ -3468,6 +3475,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
 	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
 
 	host_work->esw = esw;
+	host_work->work_gen = atomic_read(&esw_funcs->generation);
 
 	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
 	queue_work(esw->work_queue, &host_work->work);
-- 
2.51.0





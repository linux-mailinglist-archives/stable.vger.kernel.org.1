Return-Path: <stable+bounces-220576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGLwDxM/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861D1C6C6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B375C321F3FA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D33DD764;
	Sat, 28 Feb 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R95a87qM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650563DD75C;
	Sat, 28 Feb 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300458; cv=none; b=o/917+qm3fe2esmHcEiBifueGEwfbe/MsP24ykP1JdoTzrR+T2KroXib66mWBRl21xsVexIX1HTLeaC6sANCFgzKR9stowMdfVtrO/tOHZfzeSXipgcN6nX9AEpJzjrnWE2PVAeXGjyuC1r2yOfD52XwjgHIpQFM4wHBJck9zP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300458; c=relaxed/simple;
	bh=DmIdHrVOEh5pIXvp5DpPCo+ufBXsdDTMsz2cQjswpq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMwmbvyGohxtRxb5mrVcLDLtVCkEFIJKUKD8zccOt36rHQVejRYoOUtOL9bI/O51f8UYmiL6QN+O+LahmInztaRnLS30nqFC3xoQTnAVbLmdeqptXXnZhvMTiygucmEIVqwParitt4JlyRos0wEQLUdyzFE0OGKTCAseXkujO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R95a87qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEDBC19425;
	Sat, 28 Feb 2026 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300458;
	bh=DmIdHrVOEh5pIXvp5DpPCo+ufBXsdDTMsz2cQjswpq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R95a87qMAqSkofjirmunTAo++Vhi8Q4aQmmGVOOsjnffCZltInhQ8IG/rQXgPzAt3
	 ucJcbqryivjMJO+Qi9u+toSklxjuUemooJkWwdsF1HMjJm6fZMnTWrGaiqMFW+URbL
	 hz6n01lvRa7jtDmSTNYHyBTtFN4AaA1gRbGJxmhiz4ucYaiEzh20sGpUEZH0xENpvM
	 ng0l4tIyzwwUdeq7pN3TM3vScbx1Pm9eB+DoPJGE3WwNPCsd3UzopphNADWC2+8tiF
	 La8sazZpCiSi56928p5kIOyfHMfrrjNA7vpiM4zhSyjQfSFff8K8QbGrC7KPq0X21B
	 I4XuCmb7fmRsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 497/844] net/mlx5: LAG, disable MPESW in lag_disable_change()
Date: Sat, 28 Feb 2026 12:26:50 -0500
Message-ID: <20260228173244.1509663-498-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220576-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: 5861D1C6C6A
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit bd7b9f83fb9f85228c3ac9748d9cba9fab7fb5a2 ]

mlx5_lag_disable_change() unconditionally called mlx5_disable_lag() when
LAG was active, which is incorrect for MLX5_LAG_MODE_MPESW.
Hnece, call mlx5_disable_mpesw() when running in MPESW mode.

Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224114652.1787431-3-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c   | 8 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h | 5 +++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index a459a30f36cae..73659a0463cde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1654,8 +1654,12 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
-	if (__mlx5_lag_is_active(ldev))
-		mlx5_disable_lag(ldev);
+	if (__mlx5_lag_is_active(ldev)) {
+		if (ldev->mode == MLX5_LAG_MODE_MPESW)
+			mlx5_lag_disable_mpesw(ldev);
+		else
+			mlx5_disable_lag(ldev);
+	}
 
 	mutex_unlock(&ldev->lock);
 	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 2d86af8f0d9b8..c217998604fdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -65,7 +65,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
-static int enable_mpesw(struct mlx5_lag *ldev)
+static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev0;
 	int err;
@@ -124,7 +124,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	return err;
 }
 
-static void disable_mpesw(struct mlx5_lag *ldev)
+void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
 	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
 		mlx5_mpesw_metadata_cleanup(ldev);
@@ -150,9 +150,9 @@ static void mlx5_mpesw_work(struct work_struct *work)
 	}
 
 	if (mpesww->op == MLX5_MPESW_OP_ENABLE)
-		mpesww->result = enable_mpesw(ldev);
+		mpesww->result = mlx5_lag_enable_mpesw(ldev);
 	else if (mpesww->op == MLX5_MPESW_OP_DISABLE)
-		disable_mpesw(ldev);
+		mlx5_lag_disable_mpesw(ldev);
 unlock:
 	mutex_unlock(&ldev->lock);
 	mlx5_devcom_comp_unlock(devcom);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
index 02520f27a033c..46de93ed790de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
@@ -31,5 +31,10 @@ int mlx5_lag_mpesw_do_mirred(struct mlx5_core_dev *mdev,
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
 void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);
 int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev);
+#else
+static inline void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev) {}
+#endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_LAG_MPESW_H__ */
-- 
2.51.0



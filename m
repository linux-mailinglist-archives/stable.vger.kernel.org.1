Return-Path: <stable+bounces-220577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGU/Oes9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2521C6AC8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D01230719A0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984283DCEC4;
	Sat, 28 Feb 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrBFsggY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2E3DD779;
	Sat, 28 Feb 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300459; cv=none; b=caH4GGVo5zZYx/Z7EzoXOFSHJ2+sfapUyyDTYLX6Tg7n/UrEXg/sD/DMShFS5n7YZWsH0G+bAn+Qnarum9YTDXsDUHqqyP6rE/3zbFsoC0yzpCkHnWtyUdk+myF1SxV1R+XVOiaCoC6qWOhcyrQNYbLxjUBIS3UELV3e3t1LCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300459; c=relaxed/simple;
	bh=jDigmOKKuMiPcALnNm2j92QIQ0o6oguQ3QtcDjX4KAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTW4CAwuZV8twZNIdV7IYx9Q4LBBJIsfLC+ZXCE52d/iC3KYqRNxhqjY+KTKU7tXwU4hYZ5Z2tyhEEVvTsgUeapKzddOdhJDzWawu29r1N4xVSMLsYvY3sBCUaw+6g8/RVJ08X5hsHx8oAKDtTmx2xBQN0n72/ld+PGKJqhPmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrBFsggY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590E2C19423;
	Sat, 28 Feb 2026 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300459;
	bh=jDigmOKKuMiPcALnNm2j92QIQ0o6oguQ3QtcDjX4KAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrBFsggY8Cj1CXfhbfFQdRurUpcygAXgurcMbzfv8x+dmfnbuMf8J4Vpv/wFG9p0E
	 TE9lwmVNccXks9CRLshF59f48YQENLdB24s/1edC86Ri+KKszAl5uPB/DsdcWFeqYY
	 N2oqsmjO9q5zirGuKPGPbag0RmUcE3fLUbOJLeO1dip7sxcX7yDwR0seBz5nmhfX8c
	 x7IaKaF9PnW1TAbVlIrRhChYO7LO1GXQKb1Kjk3d+FuroPzAUhTdUcN8c+nJu+0xpq
	 W1v4yqtBafNjctrufiNnzDhDCXaNmBd+ewZa9Jc6xpmcZJWJNdoIiKH30Amx8oRAjw
	 1+OGzzY3EpziQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 498/844] net/mlx5: E-switch, Clear legacy flag when moving to switchdev
Date: Sat, 28 Feb 2026 12:26:51 -0500
Message-ID: <20260228173244.1509663-499-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220577-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2D2521C6AC8
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit d7073e8b978ae925f1f0f08754f33f84d8547ea7 ]

The cited commit introduced MLX5_PRIV_FLAGS_SWITCH_LEGACY to identify
when a transition to legacy mode is requested via devlink.  However, the
logic failed to clear this flag if the mode was subsequently changed
back to MLX5_ESWITCH_OFFLOADS (switchdev).  Consequently, if a user
toggled from legacy to switchdev, the flag remained set, leaving the
driver with wrong state indicating

Fix this by explicitly clearing the MLX5_PRIV_FLAGS_SWITCH_LEGACY bit
when the requested mode is MLX5_ESWITCH_OFFLOADS.

Fixes: 2a4f56fbcc47 ("net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224114652.1787431-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 02b7e474586d9..ccf53d4783628 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4068,6 +4068,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 
 	if (mlx5_mode == MLX5_ESWITCH_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
+		esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
-- 
2.51.0



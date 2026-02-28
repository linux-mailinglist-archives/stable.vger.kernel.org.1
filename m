Return-Path: <stable+bounces-220579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIL2H/89o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64EA1C6AD0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF1231CE080
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106653DE16E;
	Sat, 28 Feb 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkIgc0Cb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6F3DE166;
	Sat, 28 Feb 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300461; cv=none; b=K1dgZXWBqlHfAO/WpwquRldURY/ItZJgwYv1KbmAkLRuESLckiMGzgji19V2J1JXMU9Qx3LVqv0OnGJKki9fNzzZfhSbgIAI/NmeuurnnUlmFQ95M3GEQEh+GP9cOXcrOv9sj9StYYI8mHlyi/Kak1K9X9+Mv7QRvYx0QybKDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300461; c=relaxed/simple;
	bh=m8rcSrTq8JiI7juCypbu6cgYnNFLbEXxQCOdNeq9dtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGReH5b8e7+XsVT1SiojUAnQ6xN/gNX27Zo4DPay1EX81itEM0hnIJvmny3dPtJPEz3/MbdafOCaalgorStDFtoeMQ5G/iMVL3SPeWtT7DGBweo97M9hhKfkY9UYb8o7pBDDJ01BN3OPJxXCOX1387ldjFpmaI5E8JeiA0XVgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkIgc0Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D4C19423;
	Sat, 28 Feb 2026 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300461;
	bh=m8rcSrTq8JiI7juCypbu6cgYnNFLbEXxQCOdNeq9dtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkIgc0Cb+WNJNHVLPH3KZNMUfQf1BRkQrbvYmSpfNBEW4E38WfTCNkxc+crFCwRyH
	 Knbzdbd+npd7Z99rH2lE1ia9BmdM2r+oXk7LNx5jviLsbPuidz4Sy8CzeaLizklhjQ
	 kPHy9/3v438IyuaV877ru77CosjzKoR2QrcN4mbGlTiFDFcHCp07g3uDt8WILy2xyb
	 yEI+v/J0Zf+uMNhpLz2AwnZk1r9MFNxXW4fmhZBgTovyrY80Mv9sUb8w2cYWyvnNeI
	 Z0z48Bw9M5PbKQc4z7t8hyDRoG2YWKodsvkiBjgHEdbifvjjpngC3TkX/PvM2iGI5L
	 FYlJ0rYvPOLZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 500/844] net/mlx5e: Fix "scheduling while atomic" in IPsec MAC address query
Date: Sat, 28 Feb 2026 12:26:53 -0500
Message-ID: <20260228173244.1509663-501-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220579-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: E64EA1C6AD0
X-Rspamd-Action: no action

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 859380694f434597407632c29f30fdb5e763e6cc ]

Fix a "scheduling while atomic" bug in mlx5e_ipsec_init_macs() by
replacing mlx5_query_mac_address() with ether_addr_copy() to get the
local MAC address directly from netdev->dev_addr.

The issue occurs because mlx5_query_mac_address() queries the hardware
which involves mlx5_cmd_exec() that can sleep, but it is called from
the mlx5e_ipsec_handle_event workqueue which runs in atomic context.

The MAC address is already available in netdev->dev_addr, so no need
to query hardware. This avoids the sleeping call and resolves the bug.

Call trace:
  BUG: scheduling while atomic: kworker/u112:2/69344/0x00000200
  __schedule+0x7ab/0xa20
  schedule+0x1c/0xb0
  schedule_timeout+0x6e/0xf0
  __wait_for_common+0x91/0x1b0
  cmd_exec+0xa85/0xff0 [mlx5_core]
  mlx5_cmd_exec+0x1f/0x50 [mlx5_core]
  mlx5_query_nic_vport_mac_address+0x7b/0xd0 [mlx5_core]
  mlx5_query_mac_address+0x19/0x30 [mlx5_core]
  mlx5e_ipsec_init_macs+0xc1/0x720 [mlx5_core]
  mlx5e_ipsec_build_accel_xfrm_attrs+0x422/0x670 [mlx5_core]
  mlx5e_ipsec_handle_event+0x2b9/0x460 [mlx5_core]
  process_one_work+0x178/0x2e0
  worker_thread+0x2ea/0x430

Fixes: cee137a63431 ("net/mlx5e: Handle ESN update events")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224114652.1787431-6-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 9c7064187ed0f..f03507a522b4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -259,7 +259,6 @@ static void mlx5e_ipsec_init_limits(struct mlx5e_ipsec_sa_entry *sa_entry,
 static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
-	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
 	struct mlx5e_ipsec_addr *addrs = &attrs->addrs;
 	struct net_device *netdev = sa_entry->dev;
 	struct xfrm_state *x = sa_entry->x;
@@ -276,7 +275,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	mlx5_query_mac_address(mdev, addr);
+	ether_addr_copy(addr, netdev->dev_addr);
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
 		src = attrs->dmac;
-- 
2.51.0



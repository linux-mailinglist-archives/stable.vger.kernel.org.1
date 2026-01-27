Return-Path: <stable+bounces-211725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEleEnFKeGn2pAEAu9opvQ
	(envelope-from <stable+bounces-211725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 06:17:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F690005
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 06:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1069300BE18
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8D329395;
	Tue, 27 Jan 2026 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="guj7SmuJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0315B971;
	Tue, 27 Jan 2026 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769491050; cv=none; b=DDkMQP++TikaNK2LGRUWEQ0ME1z74o2OAwq2rHcKKXrO2nWTlOmRXsaxh8GH9jb+pHo482Vc+u8a8i1t1J/7M//GNM581GrRlr9WG/J05IjTVq9DZBjX/a7oQSkMqYUD4b7W+20KUkcbVZbZXpueOON6n12ZjG2OAs3yJCHE3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769491050; c=relaxed/simple;
	bh=sqqVroK96STTlZAd0E8KXlJlr9FSIaNQF38fuBZ7kOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u8cDSBpv4AaHkxW58zYGHbfU39WfjMgWcKPSdpQ0IbdpjXqpCTCIBAkWr0GyGvfAPR74yxLu+uzuFDp1wBiyzjTfP3gK239llQhN0wX67JB/UtLgVSFJmvQ65i/LN6vBIIdDbqN5YY7uo4BOc/ca/TtB6OLw+h2VbyUHWK3yFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=guj7SmuJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OF
	J6kU8johQdJ6GCIUnOi8feLiMP8M0PJagg23RxtCc=; b=guj7SmuJneAHFvcY0U
	oD7v8EfSH4I867pyv7CyUBI8e21+uiroEB+y3iyv+aVCxT5whnt1WiYdF2tc/QFv
	UzoSmtOLFUYcnMvYCSY6zLM9hz4qoVjhnwb8cvdogZspXqoOibxuPcQVsoTjKsbO
	JTZRPsXlRT3Nv0c9WNrAiy61A=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHK7hVSnhpEwKcIg--.1986S2;
	Tue, 27 Jan 2026 13:17:10 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Gavin Li <gavinl@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.1] Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"
Date: Tue, 27 Jan 2026 13:17:07 +0800
Message-Id: <20260127051707.2439076-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHK7hVSnhpEwKcIg--.1986S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15XF15GFy8KF1rCr1xKrg_yoW8tw4xpr
	W7KFyfAry8A3s0g3WUu34ru3sxWa1DJ34j9ryI93WrA3Wvyr1DtF1rtrWSvrW5Cr9rG34f
	tFyDCw1IvayUGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEb18JUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+RYguWl4SlZddwAA3R
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211725-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5A3F690005
X-Rspamd-Action: no action

From: Gavin Li <gavinl@nvidia.com>

[ Upstream commit 8deeefb24786ea7950b37bde4516b286c877db00 ]

This reverts commit 662404b24a4c4d839839ed25e3097571f5938b9b.
The revert is required due to the suspicion it is not good for anything
and cause crash.

Fixes: 662404b24a4c ("net/mlx5e: Block entering switchdev mode with ns inconsistency")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
[ The context change is due to the commit e25373416678
("net/mlx5e: Rewrite IPsec vs. TC block interface") in v6.6
which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 5237abbdcda1..f7f1eae998b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3493,18 +3493,6 @@ static int esw_inline_mode_to_devlink(u8 mlx5_mode, u8 *mode)
 	return 0;
 }
 
-static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
-{
-	struct net *devl_net, *netdev_net;
-	struct mlx5_eswitch *esw;
-
-	esw = mlx5_devlink_eswitch_get(devlink);
-	netdev_net = dev_net(esw->dev->mlx5e_res.uplink_netdev);
-	devl_net = devlink_net(devlink);
-
-	return net_eq(devl_net, netdev_net);
-}
-
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
@@ -3519,13 +3507,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
-	    !esw_offloads_devlink_ns_eq_netdev_ns(devlink)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
-		return -EPERM;
-	}
-
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
-- 
2.34.1



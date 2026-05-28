Return-Path: <stable+bounces-255976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOLPISCoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 307415F9443
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC22F3141947
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026433C51D;
	Thu, 28 May 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1OS1FgGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F5313550;
	Thu, 28 May 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000406; cv=none; b=ulHbTTfeEiMMwe4meeidE8B0FCaxJvP3sh0ws+tX2ZxS05Rl0pDd99cnJLAy3yVm8cLZ3S406xzcYulr0G1HDvdaX9I3qoUOAOihofh06Q3JYNauXlXDsRCw240T4h25nVOEfGbqN3PA051rl92zRTRDEra6BaqtMhNiDgikpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000406; c=relaxed/simple;
	bh=/tqN73Tnnh1qDJgpZuHFaoUXQ/xXUQknQQ/cEwrHaPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzhM+svOPCEXrTjrJhYin+2HqI4d7zFmStiaYcMOxE9GZ5ds+9l7i6IGvILew1r6AIHFZc9KT14+FDcJBDBsMVywSn9sd9eah0osZxeM5iSYBWyd5U6UzK6GjPX4v5BKpRDaOEk/SBd1qMO2TxnlOWsQW/4KtL/YY9Y1CCpM+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1OS1FgGb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F3A1F000E9;
	Thu, 28 May 2026 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000405;
	bh=bsraBccOPdMDw1/hniJBOfa+ssvnLrfkpD/ymRnZPZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1OS1FgGbuXyTXwJlL87hVSmGEgZU2UAe7OLT9KzxFLslRh4A8s9Ehul3YJiQYsSef
	 7OrXWtyUvy+XpAW/yEfJ/kW0dq+BFlTTJBttGGwWy8PHQ069XHFDnUNEPH/t19SZ4s
	 fy3hxxnLptPeNeQd6SXicTqvpevnoG6fpV7Q+xFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/272] net/mlx5e: Trigger neighbor resolution for unresolved destinations
Date: Thu, 28 May 2026 21:46:47 +0200
Message-ID: <20260528194630.316238023@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255976-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,msgid.link:url,amazon.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 307415F9443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

commit 9ab89bde13e5251e1d0507e1cc426edcdfe19142 upstream.

When initializing the MAC addresses for an outbound IPsec packet offload
rule in mlx5e_ipsec_init_macs, the call to dst_neigh_lookup is used to
find the next-hop neighbor (typically the gateway in tunnel mode).
This call might create a new neighbor entry if one doesn't already
exist. This newly created entry starts in the INCOMPLETE state, as the
kernel hasn't yet sent an ARP or NDISC probe to resolve the MAC
address. In this case, neigh_ha_snapshot will correctly return an
all-zero MAC address.

IPsec packet offload requires the actual next-hop MAC address to
program the rule correctly. If the neighbor state is INCOMPLETE when
the rule is created, the hardware rule is programmed with an all-zero
destination MAC address. Packets sent using this rule will be
subsequently dropped by the receiving network infrastructure or host.

This patch adds a check specifically for the outbound offload path. If
neigh_ha_snapshot returns an all-zero MAC address, it proactively
calls neigh_event_send(n, NULL). This ensures the kernel immediately
sends the initial ARP or NDISC probe if one isn't already pending,
accelerating the resolution process. This helps prevent the hardware
rule from being programmed with an invalid MAC address and avoids
packet drops due to unresolved neighbors.

Fixes: 71670f766b8f ("net/mlx5e: Support routed networks during IPsec MACs initialization")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1765284977-1363052-8-git-send-email-tariqt@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 486f05112f5a6..e2915d3143e6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -365,6 +365,9 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	neigh_ha_snapshot(addr, n, netdev);
 	ether_addr_copy(dst, addr);
+	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT &&
+	    is_zero_ether_addr(addr))
+		neigh_event_send(n, NULL);
 	dst_release(rt_dst_entry);
 	neigh_release(n);
 	return;
-- 
2.53.0





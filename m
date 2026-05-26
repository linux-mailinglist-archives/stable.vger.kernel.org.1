Return-Path: <stable+bounces-254432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNBpCxP0FWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:27:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD95DBF84
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41FA33057490
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31173C060E;
	Tue, 26 May 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="MVv6T+PW"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A373C13F0;
	Tue, 26 May 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823323; cv=none; b=jRFl/P+Ef+wMg43lS8HXRJ28tMahv29lEyoBzAbsteYBBFkVPmLGLeObDgSLLu0jVm2f8bQUWJea/fem30Tmrua/lrEFsDZ9efUuRv30paRD4CVsvFgEvX/8knCgjT2T6EZ6eMWxJgofCt9u9BQxgTvQYrl1ZAbHJwThIL1I5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823323; c=relaxed/simple;
	bh=lELZx/jaGq0ArAQrsEEMD3AkOgm4LKIW7e4ykGRx8r8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiB1/S5Pme07cp5wlfPN+BR+V0QEr4zN4TTu4qtK8qjIRWm2ozEBAs3KlYqpyBi+gfpjgxN6jO8I8WnrlQKkgIL7fGxVRigI8PdLbFgCC7RCGvZ/2BLcuNwmj0T8bPprAvTvYUfqG9SlfTOs8h6M8doOiL0TMPcHQHEI/uMwfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=MVv6T+PW; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823319; x=1811359319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hM5xkcTukrrJaBBtzjBE/yj5/BrnDoR2k7LJaBSr5e4=;
  b=MVv6T+PW4yIFgM/Tc2irj7gLszP604yZi5bEi7jLXMtbvixlbRBGuC+i
   Fq/USxyQ9SgSAMCMjveU7inqMZu26m5uAwscqtWIeSPwjSMe+Ca/qXYVN
   3kZthdkz2lHyAecAePQF8cwD7Lyx+B08YxXQpUTBHn0LH25OKH9vFQ2l0
   yPbMFWoOWrkR7v8624d60/r3ejMPNUpkluUMNNpsm9AjdM0LeJMvFL/lG
   8DeatP5fDsKsixybNwx8oyFPl2CxYRslGC4oPtCIrceXZKh2jbUspSe4V
   zUsUUv0zZwDEXr2va3N60gntQRWBqM8YR0QVoMh6Io51B1F8wdRYnGiUe
   g==;
X-CSE-ConnectionGUID: e/AUgeWkThqHWlYLmoAgLg==
X-CSE-MsgGUID: l88v73UrS9ipB0F0XMAHOg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20300940"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:21:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:3851]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.25:2525] with esmtp (Farcaster)
 id 64e3febf-c97c-4b58-a8df-d8a288b42652; Tue, 26 May 2026 19:21:54 +0000 (UTC)
X-Farcaster-Flow-ID: 64e3febf-c97c-4b58-a8df-d8a288b42652
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:21:51 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:21:48 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <jianbol@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12] net/mlx5e: Trigger neighbor resolution for unresolved destinations
Date: Tue, 26 May 2026 19:21:20 +0000
Message-ID: <20260526192120.77386-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254432-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,amazon.de:mid,amazon.de:dkim,nvidia.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8DFD95DBF84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 486f05112f5a..e2915d3143e6 100644
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
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



Return-Path: <stable+bounces-254433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jh+IgLzFWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 906935DBF09
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D9ED3014B0E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF9D3C09FC;
	Tue, 26 May 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="o+bNKdWt"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AD355F41;
	Tue, 26 May 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823350; cv=none; b=qxUiQuATkiwF/2OefOxPH3FydHwCVmoiki3YNrJlK0bWLzNgFAh4tsn7J42fL3kZwKmsnUtOvQewDbLMaOVe7xjdvJO83ZEyzdMT9h/s+7sBWQObYF9IbYyXD/4YGFp361A3m4WxQvgnvkr24nKjH0HCa1VFW1WkRefDYgC/8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823350; c=relaxed/simple;
	bh=/bqTySyUk2z8GSHc+WnVZEukIbYzavqLb/630CgWYVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAY/u3Tk/I0yLdZ4DRhk8jjlWO0iICmmSqrUleKophLIwHa8c3wsqSXX7yS/xgbZZ29yND9h7qEJ2tuq5jdSczEMGwnDcAr/SpKwhY90C2Dyg5fW7xmGFLnarQwHaq7uJwiBAHTVZuW91RtUVuwIPp/44lQYK81ZICouIu7hQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=o+bNKdWt; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823348; x=1811359348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5eLYHXPiWUVaMNYOWSFQu83WWH0oZvPAPotjVN1H1Y=;
  b=o+bNKdWt3h/IqG1P2tWd7/kgaiaWPMHGnBx/kdUwWdu3pTV0siEvCYsO
   65dMMUBhOt3yBAw5PZEW1bM4j9xcBV1BMhawsApwSyOgPnhi9kUMTXCvN
   /0TGrWo0aVUnMBzpUZiHuK2BGJ7K7MUq5gecoc+UJqLkOjWBTsiYMaJ2u
   OjdWyEsJfcNXBUl4FwbOO02bgRMsdCTKrmOLJyl4uwGg5wDi1hKQEX9hm
   yOSJwwA967cdnkuv3Q0a/Z2ZpdyELamQ4fpAGbB3V/4tH1XN5OW8Ko0Lg
   BMqzo7dx6Ffx101HeEw1dOFDVnuTpzAqWQpRebqqDPLptn43V/ooNdxUy
   w==;
X-CSE-ConnectionGUID: wHD0U0d9QCueCZ/oUQhlMw==
X-CSE-MsgGUID: kAb2Q/ncTzqGHj0qCYcJkQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20317097"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:22:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:8634]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.25:2525] with esmtp (Farcaster)
 id 6156bde8-f401-4c75-a1bc-4c1b991a89d3; Tue, 26 May 2026 19:22:27 +0000 (UTC)
X-Farcaster-Flow-ID: 6156bde8-f401-4c75-a1bc-4c1b991a89d3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:22:27 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:22:24 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <jianbol@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12] net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
Date: Tue, 26 May 2026 19:22:14 +0000
Message-ID: <20260526192214.78312-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254433-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,amazon.de:email,amazon.de:mid,amazon.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 906935DBF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianbo Liu <jianbol@nvidia.com>

commit e35d7da8dd9e55b37c3e8ab548f6793af0c2ab49 upstream.

Replace ipv6_stub->ipv6_dst_lookup_flow() with ip6_dst_lookup() in
mlx5e_ipsec_init_macs() since IPsec transformations are not needed
during Security Association setup - only basic routing information is
required for nexthop MAC address resolution.

This resolves an issue where XfrmOutNoStates error counter would be
incremented when xfrm policy is configured before xfrm state, as the
IPsec-aware routing function would attempt policy checks during SA
initialization.

Fixes: 71670f766b8f ("net/mlx5e: Support routed networks during IPsec MACs initialization")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1765284977-1363052-7-git-send-email-tariqt@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 486f05112f5a..013383dd194a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -348,9 +348,8 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		rt_dst_entry = &rt->dst;
 		break;
 	case AF_INET6:
-		rt_dst_entry = ipv6_stub->ipv6_dst_lookup_flow(
-			dev_net(netdev), NULL, &fl6, NULL);
-		if (IS_ERR(rt_dst_entry))
+		if (!IS_ENABLED(CONFIG_IPV6) ||
+		    ip6_dst_lookup(dev_net(netdev), NULL, &rt_dst_entry, &fl6))
 			goto neigh;
 		break;
 	default:
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



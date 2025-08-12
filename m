Return-Path: <stable+bounces-167420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03FB23002
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D2E685801
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064F2FDC55;
	Tue, 12 Aug 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lT3vfynq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E86221FAC;
	Tue, 12 Aug 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020759; cv=none; b=SCleCfmLz0e+uDm1Tmvum5Gem00RLhilak5TIdEYb/2a/6qndCKCWJsH71ZKtT0dIN0K5mJc+Kai9p2aKWzNeIX3LfvTdIeechV7KDjoZb1eLvr4xPznFXEltL/xxWXr8TddWxfBoN8Pe8/Q/BhdW/BTkLwW/j8iYiQW0HiOB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020759; c=relaxed/simple;
	bh=ixkx9Rj0UY9uRgviIoDICmvlZUtgcZb4eV5hrNeQ0I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gidkvVyqeuCSSAM0Pg3ky0OpC3MV03OH23pChQLaR5zEo3JNzz5ixipfAIci+6OWF9luwBAYWtZOOT7bNfVb2W1/tfHVnEcqTwgfjg8n+B/VTKVSQPQ0eHTZJLhEX434Ooa1rcTPV4Sx0kQfKMyT7NhWtJSYyIZt+CRL48gRCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lT3vfynq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD324C4CEF0;
	Tue, 12 Aug 2025 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020759;
	bh=ixkx9Rj0UY9uRgviIoDICmvlZUtgcZb4eV5hrNeQ0I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lT3vfynqEF2I5CBI/6Mt8wlPNRxB/Fiyu0GHqIiNc8dex+9nq8+0tcSjVVXmmtKwa
	 IsdM3kDCenzLQY2iePNWlttBJyPpp/s++hC/hGY6FP43eL+F5Rif8uq92SiiifXsCE
	 //qZ9rp6drb2a1OXRBw86yw01lQAPcqYh34zyrlU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/253] vrf: Drop existing dst reference in vrf_ip6_input_dst
Date: Tue, 12 Aug 2025 19:28:42 +0200
Message-ID: <20250812172954.394871918@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Stanislav Fomichev <sdf@fomichev.me>

[ Upstream commit f388f807eca1de9e6e70f9ffb1a573c3811c4215 ]

Commit ff3fbcdd4724 ("selftests: tc: Add generic erspan_opts matching support
for tc-flower") started triggering the following kmemleak warning:

unreferenced object 0xffff888015fb0e00 (size 512):
  comm "softirq", pid 0, jiffies 4294679065
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 40 d2 85 9e ff ff ff ff  ........@.......
    41 69 59 9d ff ff ff ff 00 00 00 00 00 00 00 00  AiY.............
  backtrace (crc 30b71e8b):
    __kmalloc_noprof+0x359/0x460
    metadata_dst_alloc+0x28/0x490
    erspan_rcv+0x4f1/0x1160 [ip_gre]
    gre_rcv+0x217/0x240 [ip_gre]
    gre_rcv+0x1b8/0x400 [gre]
    ip_protocol_deliver_rcu+0x31d/0x3a0
    ip_local_deliver_finish+0x37d/0x620
    ip_local_deliver+0x174/0x460
    ip_rcv+0x52b/0x6b0
    __netif_receive_skb_one_core+0x149/0x1a0
    process_backlog+0x3c8/0x1390
    __napi_poll.constprop.0+0xa1/0x390
    net_rx_action+0x59b/0xe00
    handle_softirqs+0x22b/0x630
    do_softirq+0xb1/0xf0
    __local_bh_enable_ip+0x115/0x150

vrf_ip6_input_dst unconditionally sets skb dst entry, add a call to
skb_dst_drop to drop any existing entry.

Cc: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20250725160043.350725-1-sdf@fomichev.me
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index c8a1009d659e..75e95f6dd816 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1355,6 +1355,8 @@ static void vrf_ip6_input_dst(struct sk_buff *skb, struct net_device *vrf_dev,
 	struct net *net = dev_net(vrf_dev);
 	struct rt6_info *rt6;
 
+	skb_dst_drop(skb);
+
 	rt6 = vrf_ip6_route_lookup(net, vrf_dev, &fl6, ifindex, skb,
 				   RT6_LOOKUP_F_HAS_SADDR | RT6_LOOKUP_F_IFACE);
 	if (unlikely(!rt6))
-- 
2.39.5





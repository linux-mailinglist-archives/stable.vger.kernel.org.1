Return-Path: <stable+bounces-69978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F7B95CEC2
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA031F2680F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750018CC15;
	Fri, 23 Aug 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyB1Nvhm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F0188923;
	Fri, 23 Aug 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421719; cv=none; b=Rh8sJ2yhBau4UB85luxzrqSZDJ43wvu2gjNWIiukARZVu1u8Nfiq9dJuI5Vrnf6DqLRx6+OqDUOxglGvcJYrQtt8PNXdI3MA5OLDQoaytSO4lIIZoQUfpiyllSFi4JWIsX0jnzvzQf2NCstYGs/oXB/2+ihx7ahpziGiO2lQdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421719; c=relaxed/simple;
	bh=Sdvz3JN2N2+AA+YjkYmHauR9Bgqpf+Jx6o0MR8AB/HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/HWq9LXEsLBniRrZdxRzQrYzEUHKzTF+bdeh5FLFttX42do5txfK3F0azS0UQzsMUGaio5oAaC6fjXegR3BzNt5YNgdbgUUCAM031OMBZJKO05jo7ahXoeUmE4K3ykrUbhlG1Ng0KkO1z10CT1AYcNRyw4OGPkR7M9v2MPkhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyB1Nvhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282E5C4AF09;
	Fri, 23 Aug 2024 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421719;
	bh=Sdvz3JN2N2+AA+YjkYmHauR9Bgqpf+Jx6o0MR8AB/HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyB1NvhmGihoCS64SeTm3ueRPxpureBgSrAaSNkzJV6p7U3s1HMwXFOcPs8fue4Y1
	 GxCNIbcn4uNH+Igbjsym8SVoS3zW/QxfJB5AN6cEoeK9LXcw7q6x5zIAh+t3VbQrM6
	 NVEX/xVD1IqhfTARA7MJH8S8zQNiv6YGxREucunumVTxazc4NuXDZv1YN9WYi19gO6
	 PX0c2vubNcpSZaNW8fzipo8+d1c8fQD1B+PeIR7Zcao2jmnrOt1ng4nSb2DvW+BsSj
	 wR2bgJDNKj6xTHNSigRY8WBw6Hvizg7ev5Y5vFJ5iEOw/r8QYzHUrNpOjVMhkEg9fo
	 5OsxBLULEItTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	cooldavid@cooldavid.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shannon.nelson@amd.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 11/24] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:00:33 -0400
Message-ID: <20240823140121.1974012-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Moon Yeounsu <yyyynoom@gmail.com>

[ Upstream commit 9a039eeb71a42c8b13408a1976e300f3898e1be0 ]

`ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compresses two lines to a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/jme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e245629739..d8be0e4dcb072 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.43.0



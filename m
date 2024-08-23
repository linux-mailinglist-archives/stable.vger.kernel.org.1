Return-Path: <stable+bounces-70045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91895CF9F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60981C238A5
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5B1AE037;
	Fri, 23 Aug 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3JB/mhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9D1922CE;
	Fri, 23 Aug 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421982; cv=none; b=qR5vhQ/Wg7j2X+x/fOlm0O12do8N4ukeX5dsB2YkkNOMDkixTYFaysm8pmGfH2t3mVgy+Q3GDmw8+YXxvYkWy4WTDuKi5MSDQRquL7O6Ehgqw7fA34JCHOdDv7DVfaSRce+zKCIYqWYuN9YRvSmbwR41vl2m6VJrtS4Sh+PEaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421982; c=relaxed/simple;
	bh=rOWPAKO67xoaTevQ9uPSPkXjZCQIdgr3JwOF1JCIfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwBiOfMJAu9gN+72O2QgNnj2/liVhElEWIV002oPdWFbXYaUvu0e4HsJ10EMb5s0vv8zQ6Hf+QvKSb6J10YYnoXkYMWVvqzK4CgiOrWOVR11vbzlHGZMY4qK+3hD3sAIos+njfR/IsEkM49Oxjd2Nxyl218slwois73bC67uxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3JB/mhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BC7C32786;
	Fri, 23 Aug 2024 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421981;
	bh=rOWPAKO67xoaTevQ9uPSPkXjZCQIdgr3JwOF1JCIfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3JB/mhnI5QJMrpAEegdpjmNNQ+y6xKGvcatrcqJQm4nBlHGHXs7xB7V/oFG0+R7B
	 32QOfdtXiSF43naKwxSLhg6IrYGW/jlAgWkkHlxVNODS6ixuOFIJ6NJrINNssokk5g
	 VXIeUk7XvLutB2svA/uVDhjh3xdTs0TXy1nQBoFzU0DhYpfSGdEzHbpYyBfdQ9SntI
	 zcdjHW3Xjg3ZR2TB6PouevjRhL+UdaRbrjuPH82fPaKiyIpIWjR6v3u5hcVQtd77Ig
	 aF+RTy8A4WxCTm283/TeFwRYP8dmeNpCOTxwjHWrW6eoqB3uP5L75uB1BnNnF2vJFG
	 i1UgrV5DPPkCw==
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
	sd@queasysnail.net,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/7] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:05:58 -0400
Message-ID: <20240823140611.1975950-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140611.1975950-1-sashal@kernel.org>
References: <20240823140611.1975950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
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
index 25aa400e2e3c2..773ec50d515bc 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -947,15 +947,13 @@ jme_udpsum(struct sk_buff *skb)
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



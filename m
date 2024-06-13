Return-Path: <stable+bounces-51661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E159070F8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0F1F21DA4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4C441D;
	Thu, 13 Jun 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FlbKaFZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBC384;
	Thu, 13 Jun 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281944; cv=none; b=G9+Qq/TBaWp+FRUfmBzqs79n3f7aMb5NYmsOErZZV6WSFBq10PAY6mD3OrilnEqFftWDNgghyRIeaaSsKdDruiwvTdMn7zecv2zhTmLftuuo/wTrDT9fTWSb8EnK82JcSI2Xm3fDFVrfb0E8ryXRJGsZ70Cs+VINOSz8VyFu8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281944; c=relaxed/simple;
	bh=g62hton4+K0LCUx1OABlzm1yc35vZiwbV9wfZKMN0Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3HD4pnzjU7nJBgna73Hg/kL0aYLnCyhWjAA0KE7vA1HSbA6so3ENIhIrEjX1eKS1w207bBc4FIUCdceuy2L1AzHYDU98BILlObzzfIMXybLnDPudExM0XUxVpwSGKdefiJj2Vx6sM45JXNAFYJk4JlNPmsbciU1WKehdL5yd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FlbKaFZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A4C2BBFC;
	Thu, 13 Jun 2024 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281944;
	bh=g62hton4+K0LCUx1OABlzm1yc35vZiwbV9wfZKMN0Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlbKaFZbj8/R8BoMkckOQqwnDZ3UP8+9E+IqYgYU7jp11lJFivwSUgEq58C23m0yu
	 6AKegLlxhw2XgxnZXyv4Efq1MZRa0pufmfJIn6WmZRDpvCMjtnOxkcXAZxZmxQSSXc
	 lS2thRB5u6sgqw4z85x5zZfuAAkQP4zFKMj02Hts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gao Xingwang <gaoxingwang1@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/402] net: ipv6: fix wrong start position when receive hop-by-hop fragment
Date: Thu, 13 Jun 2024 13:31:06 +0200
Message-ID: <20240613113306.383451560@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: gaoxingwang <gaoxingwang1@huawei.com>

[ Upstream commit 1cd354fe1e4864eeaff62f66ee513080ec946f20 ]

In IPv6, ipv6_rcv_core will parse the hop-by-hop type extension header and increase skb->transport_header by one extension header length.
But if there are more other extension headers like fragment header at this time, the skb->transport_header points to the second extension header,
not the transport layer header or the first extension header.

This will result in the start and nexthdrp variable not pointing to the same position in ipv6frag_thdr_trunced,
and ipv6_skip_exthdr returning incorrect offset and frag_off.Sometimes,the length of the last sharded packet is smaller than the calculated incorrect offset, resulting in packet loss.
We can use network header to offset and calculate the correct position to solve this problem.

Fixes: 9d9e937b1c8b (ipv6/netfilter: Discard first fragment not including all headers)
Signed-off-by: Gao Xingwang <gaoxingwang1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/reassembly.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 28e44782c94d1..6993675171556 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -363,7 +363,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 * the source of the fragment, with the Pointer field set to zero.
 	 */
 	nexthdr = hdr->nexthdr;
-	if (ipv6frag_thdr_truncated(skb, skb_transport_offset(skb), &nexthdr)) {
+	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
 		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 				IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
-- 
2.43.0





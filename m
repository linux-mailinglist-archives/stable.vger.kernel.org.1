Return-Path: <stable+bounces-155679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41403AE432C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B105189536C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EB25393A;
	Mon, 23 Jun 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRz//rGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91C24678E;
	Mon, 23 Jun 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685052; cv=none; b=AVvM8ZEde4H6BoVY8czD70j4GLGiGM9KHEiTB/NmmVSaqiJwDngxPndyRRnfaTgLYz2/5bdEWySiKEQYdJuK4fEybvl6lW+/+dTnsxkJsts8xtHtPWpDWBa0xDK1LR4txM3DoaGB3qTto32vwLNdMMKIos/XE7Mhkt89owWBfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685052; c=relaxed/simple;
	bh=Nz2ZKjeaVw6iuJxMCdzhyM67Iskge3+SZdiNdSp22v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYzk/T74mglVEL2SSxd1C8OEjqTcl+iolaqsspV02fuGVZZP5T/9+gyMkjlNzuhC8Q3EJ5kv66Ml/4+isVEgzKREhwEWYU0QRRZOD33D5SACG+zP9cgDhApMZcJE0hYHkEpLMiWhETfw5wwM7y5aoNgs7ObSEuQ6j2UnOQliFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRz//rGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9500C4CEF3;
	Mon, 23 Jun 2025 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685052;
	bh=Nz2ZKjeaVw6iuJxMCdzhyM67Iskge3+SZdiNdSp22v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRz//rGuNfSZCmXAZt7SSAoe4ieTLoh0klrF/XyztL9W66Jimr5BsiRfwrqiDq95O
	 c2DcjFKWhRLVs2BCgWVxpo3itWlD+Coyj++htAghGm/mCmQkHKTYo7eqZxDWeG22vg
	 uI3xN9PwMFAxGIrbkNmchC52Jjo6VMkM1mKqcCSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/355] netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
Date: Mon, 23 Jun 2025 15:04:11 +0200
Message-ID: <20250623130628.334928189@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 8b53f46eb430fe5b42d485873b85331d2de2c469 ]

With a VRF, ipv4 and ipv6 FIB expression behave differently.

   fib daddr . iif oif

Will return the input interface name for ipv4, but the real device
for ipv6.  Example:

If VRF device name is tvrf and real (incoming) device is veth0.
First round is ok, both ipv4 and ipv6 will yield 'veth0'.

But in the second round (incoming device will be set to "tvrf"), ipv4
will yield "tvrf" whereas ipv6 returns "veth0" for the second round too.

This makes ipv6 behave like ipv4.

A followup patch will add a test case for this, without this change
it will fail with:
  get element inet t fibif6iif { tvrf . dead:1::99 . tvrf }
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  FAIL: did not find tvrf . dead:1::99 . tvrf in fibif6iif

Alternatively we could either not do anything at all or change
ipv4 to also return the lower/real device, however, nft (userspace)
doc says "iif: if fib lookup provides a route then check its output
interface is identical to the packets input interface." which is what
the nft fib ipv4 behaviour is.

Fixes: f6d0cbcf09c5 ("netfilter: nf_tables: add fib expression")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 1a08b00aa3213..b7e543d4d57be 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -154,6 +154,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 {
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	int noff = skb_network_offset(pkt->skb);
+	const struct net_device *found = NULL;
 	const struct net_device *oif = NULL;
 	u32 *dest = &regs->data[priv->dreg];
 	struct ipv6hdr *iph, _iph;
@@ -198,11 +199,15 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	if (rt->rt6i_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		goto put_rt_err;
 
-	if (oif && oif != rt->rt6i_idev->dev &&
-	    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) != oif->ifindex)
-		goto put_rt_err;
+	if (!oif) {
+		found = rt->rt6i_idev->dev;
+	} else {
+		if (oif == rt->rt6i_idev->dev ||
+		    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == oif->ifindex)
+			found = oif;
+	}
 
-	nft_fib_store_result(dest, priv, rt->rt6i_idev->dev);
+	nft_fib_store_result(dest, priv, found);
  put_rt_err:
 	ip6_rt_put(rt);
 }
-- 
2.39.5





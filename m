Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF67ECFDD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjKOTvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjKOTvV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857ADC2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0673BC433C8;
        Wed, 15 Nov 2023 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077877;
        bh=W3H2Lpzkh6OfAI7Zm4TxVynzj9i3iDjMxe51JmR/z18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jcn79h0uldNW9LNknGPNgmHi6HYkT2oqdnvClo5hjPkRpk0YFhnbNHM2fa2BESI9v
         c5wiz31w1bVW3Tpr5OUkdaSKrKsfKh9r3o0VSV0bgUx5wsJpTmWuOqq+5QjxKExZ4j
         rPRiyzormJIxyTm4JF2UVPHH36nwRvS+UEZI0XL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Huhardeaux <tech@tootai.net>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 575/603] netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses
Date:   Wed, 15 Nov 2023 14:18:40 -0500
Message-ID: <20231115191651.268142404@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 80abbe8a8263106fe45a4f293b92b5c74cc9cc8a ]

The ipv6 redirect target was derived from the ipv4 one, i.e. its
identical to a 'dnat' with the first (primary) address assigned to the
network interface.  The code has been moved around to make it usable
from nf_tables too, but its still the same as it was back when this
was added in 2012.

IPv6, however, has different types of addresses, if the 'wrong' address
comes first the redirection does not work.

In Daniels case, the addresses are:
  inet6 ::ffff:192 ...
  inet6 2a01: ...

... so the function attempts to redirect to the mapped address.

Add more checks before the address is deemed correct:
1. If the packets' daddr is scoped, search for a scoped address too
2. skip tentative addresses
3. skip mapped addresses

Use the first address that appears to match our needs.

Reported-by: Daniel Huhardeaux <tech@tootai.net>
Closes: https://lore.kernel.org/netfilter/71be06b8-6aa0-4cf9-9e0b-e2839b01b22f@tootai.net/
Fixes: 115e23ac78f8 ("netfilter: ip6tables: add REDIRECT target")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_nat_redirect.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index 6616ba5d0b049..5b37487d9d11f 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -80,6 +80,26 @@ EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
 static const struct in6_addr loopback_addr = IN6ADDR_LOOPBACK_INIT;
 
+static bool nf_nat_redirect_ipv6_usable(const struct inet6_ifaddr *ifa, unsigned int scope)
+{
+	unsigned int ifa_addr_type = ipv6_addr_type(&ifa->addr);
+
+	if (ifa_addr_type & IPV6_ADDR_MAPPED)
+		return false;
+
+	if ((ifa->flags & IFA_F_TENTATIVE) && (!(ifa->flags & IFA_F_OPTIMISTIC)))
+		return false;
+
+	if (scope) {
+		unsigned int ifa_scope = ifa_addr_type & IPV6_ADDR_SCOPE_MASK;
+
+		if (!(scope & ifa_scope))
+			return false;
+	}
+
+	return true;
+}
+
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
@@ -89,14 +109,19 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 	if (hooknum == NF_INET_LOCAL_OUT) {
 		newdst.in6 = loopback_addr;
 	} else {
+		unsigned int scope = ipv6_addr_scope(&ipv6_hdr(skb)->daddr);
 		struct inet6_dev *idev;
-		struct inet6_ifaddr *ifa;
 		bool addr = false;
 
 		idev = __in6_dev_get(skb->dev);
 		if (idev != NULL) {
+			const struct inet6_ifaddr *ifa;
+
 			read_lock_bh(&idev->lock);
 			list_for_each_entry(ifa, &idev->addr_list, if_list) {
+				if (!nf_nat_redirect_ipv6_usable(ifa, scope))
+					continue;
+
 				newdst.in6 = ifa->addr;
 				addr = true;
 				break;
-- 
2.42.0




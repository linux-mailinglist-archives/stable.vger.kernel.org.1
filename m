Return-Path: <stable+bounces-178485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1679FB47EDE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9647A60E2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47467212560;
	Sun,  7 Sep 2025 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fS7RbKc/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C0189BB0;
	Sun,  7 Sep 2025 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276986; cv=none; b=oHLfps8pgRJvpmiw8JETo25VyYi2/0aQoLrD5b33Qmy6DGUiAYg51Zp2BPPRvjZcl2gYVlt4SBZ9kkjbOMrerBK9YXC64AgpfHjXnO/bwdXsqx+3AawRxQKc2jfjkO+pwkZAHxloDoo+HhIcRN6kx+o7ZkBBbQdId4uXR9/uFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276986; c=relaxed/simple;
	bh=7Zlh4VkZvRfq4MUrEEvFczAH8XzzlCPCz/v5Y9Olq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2SY5KYTS4/ROn9Kk9UzI3oQHiIL6dSd2NjlZ1zZUiVo4uGO2RfREInQrzH+PQ9sZDS2u9Ws2fEj/YiCdPxQZhhO4eDwhxtUKAWVYPWx0hF/lLNWX5mF2ILW0OGqpPUA1BhoIbftPPFRHZ9EbMiuQAkb/hV6xoduouzvuN+qEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fS7RbKc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B86C4CEF0;
	Sun,  7 Sep 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276985;
	bh=7Zlh4VkZvRfq4MUrEEvFczAH8XzzlCPCz/v5Y9Olq3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS7RbKc/xKGIPP4QWtEH91ATarBok4C+ui4fa28CsTP9Fkyaue+18eQ4FnISQKynJ
	 8LafYyGoi7K0ycG7v1HIpgo+zjzUbuQwehSqxMGqNH61XVpDCFOl0tlHqmpNaPSZCW
	 /gWAXoKvLbqcz2w3aXiWfZD7wySlduXmWn4I/vDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian@blaese.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 050/175] icmp: fix icmp_ndo_send address translation for reply direction
Date: Sun,  7 Sep 2025 21:57:25 +0200
Message-ID: <20250907195616.028371865@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabian Bläse <fabian@blaese.de>

[ Upstream commit c6dd1aa2cbb72b33e0569f3e71d95792beab5042 ]

The icmp_ndo_send function was originally introduced to ensure proper
rate limiting when icmp_send is called by a network device driver,
where the packet's source address may have already been transformed
by SNAT.

However, the original implementation only considers the
IP_CT_DIR_ORIGINAL direction for SNAT and always replaced the packet's
source address with that of the original-direction tuple. This causes
two problems:

1. For SNAT:
   Reply-direction packets were incorrectly translated using the source
   address of the CT original direction, even though no translation is
   required.

2. For DNAT:
   Reply-direction packets were not handled at all. In DNAT, the original
   direction's destination is translated. Therefore, in the reply
   direction the source address must be set to the reply-direction
   source, so rate limiting works as intended.

Fix this by using the connection direction to select the correct tuple
for source address translation, and adjust the pre-checks to handle
reply-direction packets in case of DNAT.

Additionally, wrap the `ct->status` access in READ_ONCE(). This avoids
possible KCSAN reports about concurrent updates to `ct->status`.

Fixes: 0b41713b6066 ("icmp: introduce helper for nat'd source address in network device context")
Signed-off-by: Fabian Bläse <fabian@blaese.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c     | 6 ++++--
 net/ipv6/ip6_icmp.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8111ec651b54..8f11870b77377 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -799,11 +799,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	struct sk_buff *cloned_skb = NULL;
 	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmp_send(skb_in, type, code, info, &opts);
 		return;
 	}
@@ -818,7 +819,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 		goto out;
 
 	orig_ip = ip_hdr(skb_in)->saddr;
-	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
 	__icmp_send(skb_in, type, code, info, &opts);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 9e3574880cb03..233914b63bdb8 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -54,11 +54,12 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	struct inet6_skb_parm parm = { 0 };
 	struct sk_buff *cloned_skb = NULL;
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct in6_addr orig_ip;
 	struct nf_conn *ct;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmpv6_send(skb_in, type, code, info, &parm);
 		return;
 	}
@@ -73,7 +74,8 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 		goto out;
 
 	orig_ip = ipv6_hdr(skb_in)->saddr;
-	ipv6_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.in6;
+	dir = CTINFO2DIR(ctinfo);
+	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
 	__icmpv6_send(skb_in, type, code, info, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
-- 
2.50.1





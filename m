Return-Path: <stable+bounces-200875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCACCB82BA
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 08:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF79309D95A
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956B030F949;
	Fri, 12 Dec 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="QAJCWwvH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABED30EF74
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525939; cv=none; b=JfJNsdUujGq5H/Jci4dIeWb2xpHdf9UxSRlC99BSM1f2DITZhe1vpz2drWhCnEOBQRIyXz/2qSA6aYEggvIL17xe/lji4w3v9arzxurFOFK6kM22siVBn6YZCoSayLluifhDHgivWPIwF96Fb8OQzO7EbWFmHk5p3gXdwU5B22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525939; c=relaxed/simple;
	bh=y/bvT8VZdx+5yko665QNlOLFOQbvNzV7Cf31v/zetaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEj6ADnibG5XM9OC6ZuMD4wWbB7jOT0Z4IYvMT2H7HqFJ+d38nJpr5ZDnR9bz2TVkVh7MTCnUArg6ANAaoQLG+WQ9s67ndbQMi07PkKaFXnI5AVgPnVCKV9YTBjifm1MKXjBbP7LX34vfnpM3ISi43KICQR22bDtnHnjipMunWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=QAJCWwvH; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1765525935;
 bh=5pmJtC2v5HuKgTd8XiTTdyFsEdHnMITFvy/fl8k9hdM=;
 b=QAJCWwvHP1AWv0Y69Vh9mja+eaWSifpXm4NoENYzU5l8acfnHBQpatr/blCY3W7c+zZm/NIFb
 NLlF4LYq3X9RZRj/Q9s3JVW2RFEw1WfECa2Z+pA8lW4vXXZsmHvX9eCVbgD5xA7G5zBqg6MhhMm
 5Q8jVSeyIiM69m41nKiF9SgdSADZA7Er1SsIldCq1WuPk4B4j6dtecmnZKXCChMcTpyKdn6iObW
 Z5ywTcdqG1mLncps3d6E04iilAmAns3mp9x8MoLacQJBmLmspScPGC0l5AVCmbvAIYgmF9c4nAF
 +PX9tPB4ZCko2O+hvYo53GpKDpHgypdWdxWYcrGYqOAQ==
X-Forward-Email-ID: 693bc4f9bcfd39afaeb67eae
X-Forward-Email-Sender: rfc822; fnordahl@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Frode Nordahl <fnordahl@ubuntu.com>
To: netdev@vger.kernel.org
Cc: fnordahl@ubuntu.com,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] erspan: Initialize options_len before referencing options.
Date: Fri, 12 Dec 2025 07:32:01 +0000
Message-ID: <20251212073202.13153-1-fnordahl@ubuntu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct ip_tunnel_info has a flexible array member named
options that is protected by a counted_by(options_len)
attribute.

The compiler will use this information to enforce runtime bounds
checking deployed by FORTIFY_SOURCE string helpers.

As laid out in the GCC documentation, the counter must be
initialized before the first reference to the flexible array
member.

In the normal case the ip_tunnel_info_opts_set() helper is used
which would initialize options_len properly, however in the GRE
ERSPAN code a partial update is done, preventing the use of the
helper function.

Before this change the handling of ERSPAN traffic in GRE tunnels
would cause a kernel panic when the kernel is compiled with
GCC 15+ and having FORTIFY_SOURCE configured:

memcpy: detected buffer overflow: 4 byte write of buffer size 0

Call Trace:
 <IRQ>
 __fortify_panic+0xd/0xf
 erspan_rcv.cold+0x68/0x83
 ? ip_route_input_slow+0x816/0x9d0
 gre_rcv+0x1b2/0x1c0
 gre_rcv+0x8e/0x100
 ? raw_v4_input+0x2a0/0x2b0
 ip_protocol_deliver_rcu+0x1ea/0x210
 ip_local_deliver_finish+0x86/0x110
 ip_local_deliver+0x65/0x110
 ? ip_rcv_finish_core+0xd6/0x360
 ip_rcv+0x186/0x1a0

Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
Reported-at: https://launchpad.net/bugs/2129580
Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
---
 net/ipv4/ip_gre.c  | 18 ++++++++++++++++--
 net/ipv6/ip6_gre.c | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 761a53c6a89a..285a656c9e41 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -330,6 +330,22 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			if (!tun_dst)
 				return PACKET_REJECT;
 
+			/* The struct ip_tunnel_info has a flexible array member named
+			 * options that is protected by a counted_by(options_len)
+			 * attribute.
+			 *
+			 * The compiler will use this information to enforce runtime bounds
+			 * checking deployed by FORTIFY_SOURCE string helpers.
+			 *
+			 * As laid out in the GCC documentation, the counter must be
+			 * initialized before the first reference to the flexible array
+			 * member.
+			 *
+			 * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
+			 */
+			info = &tun_dst->u.tun_info;
+			info->options_len = sizeof(*md);
+
 			/* skb can be uncloned in __iptunnel_pull_header, so
 			 * old pkt_md is no longer valid and we need to reset
 			 * it
@@ -344,10 +360,8 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
 						       ERSPAN_V2_MDSIZE);
 
-			info = &tun_dst->u.tun_info;
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
-			info->options_len = sizeof(*md);
 		}
 
 		skb_reset_mac_header(skb);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c82a75510c0e..eb840a11b93b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -535,6 +535,22 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			if (!tun_dst)
 				return PACKET_REJECT;
 
+			/* The struct ip_tunnel_info has a flexible array member named
+			 * options that is protected by a counted_by(options_len)
+			 * attribute.
+			 *
+			 * The compiler will use this information to enforce runtime bounds
+			 * checking deployed by FORTIFY_SOURCE string helpers.
+			 *
+			 * As laid out in the GCC documentation, the counter must be
+			 * initialized before the first reference to the flexible array
+			 * member.
+			 *
+			 * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
+			 */
+			info = &tun_dst->u.tun_info;
+			info->options_len = sizeof(*md);
+
 			/* skb can be uncloned in __iptunnel_pull_header, so
 			 * old pkt_md is no longer valid and we need to reset
 			 * it
@@ -543,7 +559,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			     skb_network_header_len(skb);
 			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
 							    sizeof(*ershdr));
-			info = &tun_dst->u.tun_info;
 			md = ip_tunnel_info_opts(info);
 			md->version = ver;
 			md2 = &md->u.md2;
@@ -551,7 +566,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 						       ERSPAN_V2_MDSIZE);
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
-			info->options_len = sizeof(*md);
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 
-- 
2.43.0



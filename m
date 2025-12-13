Return-Path: <stable+bounces-200951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE3CBA810
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A31030080FA
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F92F6909;
	Sat, 13 Dec 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="o8ovbwH/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03382F658D
	for <stable@vger.kernel.org>; Sat, 13 Dec 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620847; cv=none; b=Y3NoWptVPEO+2DYcKCNva/vQdlB+A7a38u784VoH59/fMjYxc0UhziNhK909GKHecQbSIesmpRKmetu+XQh2yFlRvSfWSDWD7JGeVEmUW60/6CpsMfoym+ocVcxoaI/yWbPy4qWCvVcutwQzLIeJaL1DEUJ2RO/hrIfRdmmLyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620847; c=relaxed/simple;
	bh=9lzVO6If0UtnERwkY+xkVr58h02c8XQPuta4ZwM2wfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncjz/gUz+gea6SzJ2QOXbXgcNAQJh6fqlOyUxoY788b/j4W0u353b+i6GgwITahbPaYT7FMOLz4vHsSqYPbWyQ68m90MYTB/AQsXhYls6L36tr+hf46BwaqW5fMmd5bV1rs8wLfU+9dgBOZLuAaAtlpiQ1g7fZZNcfPklpVVWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=o8ovbwH/; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1765620838;
 bh=WuJNSQ3/mwjeSko5QvWtASPtwrlMT6jMSC5uuopo+9o=;
 b=o8ovbwH/AqiZ+K2pba4bNj4yPUiZA+E/d3TSiHzDU7/CDxbewubAHmduVVATzMA3fCfa32714
 uTpjX+Oyq55McAjHm9osUog69hSQP5cz8IIfw3MF8O80cV7tVoLpWI4aBB3MUrWAQ14gTfL/xWV
 u8ucm2CJLxyOoZDVqBJtDzNNBg9wvhhvGpfes6jOYlrETyumkNGv/vb3zCB1ubf9VXtBUAZ6ImR
 mHa8KI5ial3h7Gy7WA1r9Ug+fKxStgjPPM7BG9I6Ki8cuBzqORHgEDrr9kSRm/8hOLOEekvpk1I
 hErZYiFLZpNtB1rerGiyB3JjZUbddzEvFPoiFLohPdzA==
X-Forward-Email-ID: 693d3c5afb4eeecc7f5b6f45
X-Forward-Email-Sender: rfc822; fnordahl@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Frode Nordahl <fnordahl@ubuntu.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Kees Cook <kees@kernel.org>
Cc: Frode Nordahl <fnordahl@ubuntu.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] erspan: Initialize options_len before referencing options.
Date: Sat, 13 Dec 2025 10:13:36 +0000
Message-ID: <20251213101338.4693-1-fnordahl@ubuntu.com>
X-Mailer: git-send-email 2.51.0
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

After scanning through the files that use struct ip_tunnel_info
and also refer to options or options_len, it appears the normal
case is to use the ip_tunnel_info_opts_set() helper.

Said helper would initialize options_len properly before copying
data into options, however in the GRE ERSPAN code a partial
update is done, preventing the use of the helper function.

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

Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
Reported-at: https://launchpad.net/bugs/2129580
Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
---
v2:
  - target correct netdev tree and properly cc stable in commit message.
  - replace repeated long in-line comments and link with a single line.
  - document search for any similar offenses in the code base in commit
    message.
v1: https://lore.kernel.org/all/20251212073202.13153-1-fnordahl@ubuntu.com/

 net/ipv4/ip_gre.c  | 6 ++++--
 net/ipv6/ip6_gre.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 761a53c6a89a..8178c44a3cdd 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -330,6 +330,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			if (!tun_dst)
 				return PACKET_REJECT;
 
+			/* MUST set options_len before referencing options */
+			info = &tun_dst->u.tun_info;
+			info->options_len = sizeof(*md);
+
 			/* skb can be uncloned in __iptunnel_pull_header, so
 			 * old pkt_md is no longer valid and we need to reset
 			 * it
@@ -344,10 +348,8 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
 						       ERSPAN_V2_MDSIZE);
 
-			info = &tun_dst->u.tun_info;
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
-			info->options_len = sizeof(*md);
 		}
 
 		skb_reset_mac_header(skb);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c82a75510c0e..4603554d4c7f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -535,6 +535,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			if (!tun_dst)
 				return PACKET_REJECT;
 
+			/* MUST set options_len before referencing options */
+			info = &tun_dst->u.tun_info;
+			info->options_len = sizeof(*md);
+
 			/* skb can be uncloned in __iptunnel_pull_header, so
 			 * old pkt_md is no longer valid and we need to reset
 			 * it
@@ -543,7 +547,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			     skb_network_header_len(skb);
 			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
 							    sizeof(*ershdr));
-			info = &tun_dst->u.tun_info;
 			md = ip_tunnel_info_opts(info);
 			md->version = ver;
 			md2 = &md->u.md2;
@@ -551,7 +554,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 						       ERSPAN_V2_MDSIZE);
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
-			info->options_len = sizeof(*md);
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 
-- 
2.51.0



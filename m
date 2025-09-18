Return-Path: <stable+bounces-178669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB0B47F98
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5337A4C87
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC24315A;
	Sun,  7 Sep 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="blGEBIzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC51A704B;
	Sun,  7 Sep 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277577; cv=none; b=GqZHvjj1XEdZjdLNPWyglGaBFQIIexHQjtxykVgKNg3B/CDpa37QlcDbCuNqNgXtjdFVcX75U0Qwvo8t+1J/8CASkqwGYEV5dsDg0fX4w5mu04lrR1OxhfhsctIfw5sysYWT+U5/ZHMN3Aau4wzr1ZErX6mn5TDlv9S7OqySZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277577; c=relaxed/simple;
	bh=YF8wf7dS935J4AWQ4W1tXiXutfVasMnNkUEE10SPFSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhCWEoLhCjXPc3tu3cg+KZRQ2IvaAlS74AJNVxgHxBAnGBPhK/Im1S7iOc5+q9FWsowRJyBxMNmohgjw2xNQhz+GQXIn6aMPNqh94hJtHpjP4ERQQpksUwFL7b28zKq37iM4iwOax5yJs32KCNiDmbgCx2NOeDKIOOdGU4XlA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=blGEBIzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C1DC4CEF0;
	Sun,  7 Sep 2025 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277577;
	bh=YF8wf7dS935J4AWQ4W1tXiXutfVasMnNkUEE10SPFSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blGEBIzULg1IvKAXbwym1bfjatTTwpeHEurzQ6oTC8jJCH/yu6WnkjaQIeJdw/lGg
	 6E1VxaFIjtsC7VzJftzxzbQfjqqYMe7XI/L22Wk4+dXBhXa4pA0QYGkzfbo5obiG8G
	 Wx9fCqpxm5TwFdKxXdbwY7O3RPPupYbSvK3pQtSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian@blaese.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 057/183] icmp: fix icmp_ndo_send address translation for reply direction
Date: Sun,  7 Sep 2025 21:58:04 +0200
Message-ID: <20250907195617.141512124@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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
index 717cb7d3607a1..14beae97f81b3 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -797,11 +797,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
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
@@ -816,7 +817,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
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





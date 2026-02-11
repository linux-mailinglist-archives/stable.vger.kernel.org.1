Return-Path: <stable+bounces-215755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDa+LzwyjGkAjAAAu9opvQ
	(envelope-from <stable+bounces-215755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:39:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CF121EA4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D75300381A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002542DFA2D;
	Wed, 11 Feb 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UQVP6g5R"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276A4AEE2
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795575; cv=none; b=Y2EkIbB5PvNsha4Sm4BJi30nID5/jviYSBTGDfwRXbjUfqMs4zUgtdOWyK4WSwySUNJAJAz0vC4EYyKcvu2QvVQo0bNsQNJbnv+7ybeRxCV3gQXYwN5tQ/WNQB7PpSylb3WiHeYpTyO2JnelGFAM9Dnfbpqqnm6+nTUsMm3wRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795575; c=relaxed/simple;
	bh=aqMlXqDXic8qJ3etOR6XR8dZp1a053wp62ku5llhoUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT/BATsrKwaDB4zJOP/RoYUoYUv0GRTpoVrwrpLasj7NcmjuZ5Xz7KhFKPcQNfISeu2YRKpD4eWfcTKBWIKn2iKnedxPABaPe96lX3A6GjzQUwX9ZoA5ip+0ZgpzlVzzbIpdRnUW9QmGm8KvCHcaZRugMEYkcxuttce/HUCLuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UQVP6g5R; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=cGOmk25UBJBO2C981S6X09w03v2ST7BzVdZHguDk/Fo=; b=UQVP6g5R4iPTpABiZpCvUBuGe6
	jmmYECP/iQgfSP4ZuKa8iqaZHYMDhK7FwKr+Yb9cZyJmCQKjEHSAEMNQelAm/YhgBm1qcIIXet+q5
	li56j9dQYyX+vC4X7qu2yc5QMPFpvgnEzhtMNJ6MIMWIH1KIOhQ6InQtRziovbW2JqQCvgxhu3UcC
	/u9GOY4TKS/ar+1nkz0UxiBbwGuzLJRoW6MnilfF/afmhiV8uWXe3wLL9HVNVO+iZQGvIt6mpglZe
	TSCxWw0aK8Ly7YBvfEWZ9rUkhNisiikaFY8zQOop5BEfYEWhll6SaWDjTEt6zctp+2AC0OJJWoNx0
	lxYPJ2aw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vq4ol-00AsR9-A9; Wed, 11 Feb 2026 07:39:24 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 74DC7BE2DE0; Wed, 11 Feb 2026 08:39:22 +0100 (CET)
Date: Wed, 11 Feb 2026 08:39:22 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: 1127597@bugs.debian.org, Bastien Durel <bastien@durel.org>,
	Tobias Fiebig <tobias@fiebig.nl>,
	Manu =?iso-8859-1?Q?Beno=EEt?= <tseeker@nocternity.net>
Cc: Tj <tj.iam.tj@proton.me>, Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bug#1127597: Regression: v6.12.67 ip6_tunnel: ip6gre
 decapsulation fails
Message-ID: <aYwyKiycDDI05Bkd@eldamar.lan>
References: <177076023892.578113.8206759777477389796.reportbug@sunny>
 <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
 <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me>
 <177071383551.15684.7212803445896238445.reportbug@arrakeen.geekwu.org>
 <2026021138-gleaming-overarch-7e6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6pnTu2xlGmnuYwnX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026021138-gleaming-overarch-7e6f@gregkh>
X-Debian-User: carnil
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215755-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pages.debian.net:url]
X-Rspamd-Queue-Id: F22CF121EA4
X-Rspamd-Action: no action


--6pnTu2xlGmnuYwnX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Bastien, Tobias, Manuel,

On Wed, Feb 11, 2026 at 06:29:56AM +0100, Greg KH wrote:
> On Wed, Feb 11, 2026 at 05:04:04AM +0000, Tj wrote:
> > ip6gre tunnels fail to be decapsulated in v6.12.67 so never appears on 
> > the GRE interface.
> > 
> > Reverting the following commit fixes it:
> > 
> > commit df5ffde9669314500809bc498ae73d6d3d9519ac
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Wed Jan 7 16:31:09 2026 +0000
> > 
> >      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
> > 
> >      [ Upstream commit 81c734dae203757fb3c9eee6f9896386940776bd ]
> > 
> > v6.19 works but I've not been able to identify a subsequent commit that 
> > should also be backported to the stable tree.
> 
> Please see this thread:
> 	https://lore.kernel.org/r/CANn89iL5ksZZCJr7SK9=4Sw6EejdOzr5_m6pBMM8RVtbLy_ACA@mail.gmail.com
> 
> I think that should fix this, right?

Can you test building v6.12.69 (or the Debian kernel, see instructions
below) with the attached patch which would be the above mentioned fix,
and report back here?

Manuel, you mentioned you see the problem as well on 6.1.162 (where
ineed the patches were backported as well), can you double-check as
well that the patch fixes your seen regression?

To build the Debian kernel with a single-patch on top applied follow
https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#id-1.6.6.4

Regards,
Salvatore

--6pnTu2xlGmnuYwnX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-tunnel-make-skb_vlan_inet_prepare-return-drop-re.patch"

From 9990ddf47d4168088e2246c3d418bf526e40830d Mon Sep 17 00:00:00 2001
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 9 Oct 2024 10:28:21 +0800
Subject: [PATCH] net: tunnel: make skb_vlan_inet_prepare() return drop reasons

Make skb_vlan_inet_prepare return the skb drop reasons, which is just
what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/bareudp.c          |  4 ++--
 drivers/net/geneve.c           |  4 ++--
 drivers/net/vxlan/vxlan_core.c |  2 +-
 include/net/ip_tunnels.h       | 13 ++++++++-----
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index e057526448d7..fa2dd76ba3d9 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,7 +317,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
@@ -387,7 +387,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7f611c74eb62..2f29b1386b1c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -827,7 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
@@ -937,7 +937,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6e9a3795846a..916c3880832e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2356,7 +2356,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	__be32 vni = 0;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
-	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
+	if (skb_vlan_inet_prepare(skb, no_eth_encap))
 		goto drop;
 
 	old_iph = ip_hdr(skb);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fc2f7bf837a..4e4f9e24c9c1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -467,11 +467,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,13 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.51.0


--6pnTu2xlGmnuYwnX--


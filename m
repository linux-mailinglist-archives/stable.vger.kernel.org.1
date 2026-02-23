Return-Path: <stable+bounces-217818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AazOfmfnGnqJgQAu9opvQ
	(envelope-from <stable+bounces-217818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:44:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD4317BABD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE85D30185CB
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79258368284;
	Mon, 23 Feb 2026 18:43:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684D36829D
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872212; cv=none; b=nL76X5G62taOpJtE9evaq5fdrBmb1DME6ptLUHmE3EfwyesNMUwpY5m4Wg1KO92U9xeEVOfWeA0aTlXXMvowhcEqiAo0/XLi5UsnSzziu8ewtcqMYFmyg+/tsZ42eMywVBP76tbk1ukR4TwqbqminJz7sxbk9ctWf9QQw9aq0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872212; c=relaxed/simple;
	bh=Tej2+XcjHlmhmrvEYue7AvT5ddM3d0Y6+7rrLYarivU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V83KIsUKB0xpCePkykGQlog++R5eizbb5da+oqR9PUs1Kuqn8fLdvRVT9Md/szhaEKIW9tMdv2EVWg3HyMfSurzwMS7l1IJODGDGaKHdICnMqPKKEW1TNasFQfWG2X0JfS6Ombv/ad/AJcH94PYLGDMMGmXu4YS0c4f9q8/3rDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vuats-002Xx6-1Z;
	Mon, 23 Feb 2026 18:43:19 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vuatq-00000001lQV-26yi;
	Mon, 23 Feb 2026 19:43:18 +0100
Date: Mon, 23 Feb 2026 19:43:18 +0100
From: Ben Hutchings <ben@decadent.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hostinger NOC <noc@hostinger.com>, stable <stable@vger.kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10,5.15] ip6_tunnel: Fix usage of skb_vlan_inet_prepare()
Message-ID: <aZyfxkHromvUPszw@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CwB8eHwIUUXgJXAw"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[debian.org,linuxfoundation.org,hostinger.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-217818-lists,stable=lfdr.de];
	DMARC_NA(0.00)[decadent.org.uk];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	NEURAL_HAM(-0.00)[-0.982];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFD4317BABD
X-Rspamd-Action: no action


--CwB8eHwIUUXgJXAw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Backports of commit 81c734dae203 "ip6_tunnel: use
skb_vlan_inet_prepare() in __ip6_tnl_rcv()" broke IPv6 tunnelling in
stable branches 5.10-6.12 inclusive.  This is because the return value
of skb_vlan_inet_prepare() had the opposite sense (0 for error rather
than for success) before commit 9990ddf47d416 "net: tunnel: make
skb_vlan_inet_prepare() return drop reasons".

For branches including commit c504e5c2f964 "net: skb: introduce
kfree_skb_reason()" etc. (i.e. 6.1 and newer) it was simple to
backport commit 9990ddf47d416, but for 5.10 and 5.15 that doesn't seem
to be practical.

So just reverse the sense of the return value test here.

Fixes: f9c5c5b791d3 ("ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_=
rcv()")
Fixes: 64c71d60a21a ("ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_=
rcv()")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
I built and tested 5.10.251 with this on top, but have not tested it
with the 5.15 branch.

Ben.

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -876,7 +876,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl
=20
 	skb_reset_network_header(skb);
=20
-	if (skb_vlan_inet_prepare(skb, true)) {
+	if (!skb_vlan_inet_prepare(skb, true)) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;

--CwB8eHwIUUXgJXAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmcn8EACgkQ57/I7JWG
EQnWhA//W/76Dz1r4w04CBI0c/g8/Oo9crdGHyQbUwSQMu/YsvUBa0/Xfy/92g7k
kCLYoZ1hYTIZkDslC+06fHZkk8aVqqBxOE3yR1/8dH9r0cJxgTD+JXCvwMw5Y6k+
itQ0O1dPI/dr3EgZJ5s0PHMcUw4nFigQUYouXyR5lezZfTf1iHQCTPSH0DEBilsJ
Lx4Npr6+BhI0zLDrVzV6cq5qJFhg5yLS9YyyNSAie3ZxbDjYltaU1l4psxVHkWM+
ZBNJIbcKFuuAkuUq+FpNb0YypZBeMkMz8IKyh6OkeZeThReK1mcf5e0I5vR0vKXa
yUvk6NEF/gb3cUmfkS9nPDJbG8JYvnxTXobvWxRc88Wid7izWA+KULvIUehH/Zey
OXysq/c5m8ksZhxhfFB6VOYxedaKQ1W3Hb2Amb06imtXnqZyPUvx5YCCETb0GBPv
A130KdckpxtzAQ1Yxbn5kja0veCOrJ13CeqUA48+VZZ/tNFLXwlnJb6EB/xU2ssE
rpsWOiXm4gF5mufuUzpNBSRb4/NILl3WnUKZuMO/IZJz9VuOiTF+JPQDbdunVi9Q
HzI6jc+vWQ1eh/6ddIgubJsUYbJDrk8keV661wqfwYUIm4y52LfZyY1I3Ke82bys
Wc4dpO/J5aObNfQ6B7zUaX0yRcUafFsxlrmysSKNcbzY+odfT28=
=JhGv
-----END PGP SIGNATURE-----

--CwB8eHwIUUXgJXAw--


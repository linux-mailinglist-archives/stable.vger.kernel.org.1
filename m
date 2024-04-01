Return-Path: <stable+bounces-34976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC388941BF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE77D1C21915
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203274AEF0;
	Mon,  1 Apr 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DY+nXxVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AD4AED9;
	Mon,  1 Apr 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989930; cv=none; b=B0wbtFaTsgy1z7hxZ7tCpIqy4Ek9RWdeDA3UO/7QMg+WGB/p4t0SLxZZeciOvkcH3kysgAw9gRiGKMaDtsSdfWNwZaCWUOT9FCxlgnoi48AV40m/KCKgL57xkUaQgp3S1dgYm6J4Otmiu+9brqoH5sgc64MuX5vKJkKX1L0Dlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989930; c=relaxed/simple;
	bh=E2p10WkxN6V6MHtWlLltA6qCZWMF8rqTJhHLIu1ZsuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFNUMgAOO/bMHRse3cbxDjoO3acMxHWPyj5YXINx/+fSuttKX3cTM28UKP5onkXiCrLW1CA2nu6VetCpSLMblq0if78zoIiuvSNo57LBQT7+197XPysrFCwHaVli8QAf+GNVqDvij7uzhH0ggDXxnHkYSephmCEfrRLTeBKTHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DY+nXxVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A2C43390;
	Mon,  1 Apr 2024 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989930;
	bh=E2p10WkxN6V6MHtWlLltA6qCZWMF8rqTJhHLIu1ZsuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DY+nXxVhqcNwvIRqqxNR83tHncJI5WwmdSdO5ghRis5KoJxgAHcRRCRKkYOcT4lLG
	 orjqvIpoMj7W1VHvCd6H0hDCnAx1G+uhpFOzHGSNa9Wr6vye5pfyO+J8siRYg1wqZh
	 ITmLgh4OHcvrKRqjOMqgy7X7zNe4lYcUtjYyWIbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heng Guo <heng.guo@windriver.com>,
	Kun Song <Kun.Song@windriver.com>,
	Filip Pudak <filip.pudak@windriver.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Vitezslav Samel <vitezslav@samel.cz>
Subject: [PATCH 6.6 196/396] net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams.
Date: Mon,  1 Apr 2024 17:44:05 +0200
Message-ID: <20240401152553.779343777@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heng Guo <heng.guo@windriver.com>

commit b4a11b2033b7d3dfdd46592f7036a775b18cecd1 upstream.

Reproduce environment:
network with 3 VM linuxs is connected as below:
VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
VM1: eth0 ip: 192.168.122.207 MTU 1500
VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.224 MTU 1500
VM3: eth0 ip: 192.168.123.240 MTU 1500

Reproduce:
VM1 send 1400 bytes UDP data to VM3 using tools scapy with flags=0.
scapy command:
send(IP(dst="192.168.123.240",flags=0)/UDP()/str('0'*1400),count=1,
inter=1.000000)

Result:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates
Ip: 1 64 11 0 3 4 0 0 4 7 0 0 0 0 0 0 0 0 0
......
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates
Ip: 1 64 12 0 3 5 0 0 4 8 0 0 0 0 0 0 0 0 0
......
----------------------------------------------------------------------
"ForwDatagrams" increase from 4 to 5 and "OutRequests" also increase
from 7 to 8.

Issue description and patch:
IPSTATS_MIB_OUTPKTS("OutRequests") is counted with IPSTATS_MIB_OUTOCTETS
("OutOctets") in ip_finish_output2().
According to RFC 4293, it is "OutOctets" counted with "OutTransmits" but
not "OutRequests". "OutRequests" does not include any datagrams counted
in "ForwDatagrams".
ipSystemStatsOutOctets OBJECT-TYPE
    DESCRIPTION
           "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  Octets from datagrams
            counted in ipIfStatsOutTransmits MUST be counted here.
ipSystemStatsOutRequests OBJECT-TYPE
    DESCRIPTION
           "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  Note that this counter does not include any
            datagrams counted in ipSystemStatsOutForwDatagrams.
So do patch to define IPSTATS_MIB_OUTPKTS to "OutTransmits" and add
IPSTATS_MIB_OUTREQUESTS for "OutRequests".
Add IPSTATS_MIB_OUTREQUESTS counter in __ip_local_out() for ipv4 and add
IPSTATS_MIB_OUT counter in ip6_finish_output2() for ipv6.

Test result with patch:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates OutTransmits
Ip: 1 64 9 0 5 1 0 0 3 3 0 0 0 0 0 0 0 0 0 4
......
root@qemux86-64:~# cat /proc/net/netstat
......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
  OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
  InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
  InECT0Pkts InCEPkts ReasmOverlaps
IpExt: 0 0 0 0 0 0 2976 1896 0 0 0 0 0 9 0 0 0 0
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates OutTransmits
Ip: 1 64 10 0 5 2 0 0 3 3 0 0 0 0 0 0 0 0 0 5
......
root@qemux86-64:~# cat /proc/net/netstat
......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
  OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
  InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
  InECT0Pkts InCEPkts ReasmOverlaps
IpExt: 0 0 0 0 0 0 4404 3324 0 0 0 0 0 10 0 0 0 0
----------------------------------------------------------------------
"ForwDatagrams" increase from 1 to 2 and "OutRequests" is keeping 3.
"OutTransmits" increase from 4 to 5 and "OutOctets" increase 1428.

Signed-off-by: Heng Guo <heng.guo@windriver.com>
Reviewed-by: Kun Song <Kun.Song@windriver.com>
Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/snmp.h |    3 ++-
 net/ipv4/ip_output.c      |    2 ++
 net/ipv4/proc.c           |    3 ++-
 net/ipv6/ip6_output.c     |    6 ++++--
 net/ipv6/mcast.c          |    5 ++---
 net/ipv6/ndisc.c          |    2 +-
 net/ipv6/proc.c           |    3 ++-
 net/ipv6/raw.c            |    2 +-
 8 files changed, 16 insertions(+), 10 deletions(-)

--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -24,7 +24,7 @@ enum
 	IPSTATS_MIB_INOCTETS,			/* InOctets */
 	IPSTATS_MIB_INDELIVERS,			/* InDelivers */
 	IPSTATS_MIB_OUTFORWDATAGRAMS,		/* OutForwDatagrams */
-	IPSTATS_MIB_OUTPKTS,			/* OutRequests */
+	IPSTATS_MIB_OUTREQUESTS,		/* OutRequests */
 	IPSTATS_MIB_OUTOCTETS,			/* OutOctets */
 /* other fields */
 	IPSTATS_MIB_INHDRERRORS,		/* InHdrErrors */
@@ -57,6 +57,7 @@ enum
 	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
 	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
 	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
+	IPSTATS_MIB_OUTPKTS,			/* OutTransmits */
 	__IPSTATS_MIB_MAX
 };
 
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -101,6 +101,8 @@ int __ip_local_out(struct net *net, stru
 {
 	struct iphdr *iph = ip_hdr(skb);
 
+	IP_INC_STATS(net, IPSTATS_MIB_OUTREQUESTS);
+
 	iph_set_totlen(iph, skb->len);
 	ip_send_check(iph);
 
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -83,7 +83,7 @@ static const struct snmp_mib snmp4_ipsta
 	SNMP_MIB_ITEM("InUnknownProtos", IPSTATS_MIB_INUNKNOWNPROTOS),
 	SNMP_MIB_ITEM("InDiscards", IPSTATS_MIB_INDISCARDS),
 	SNMP_MIB_ITEM("InDelivers", IPSTATS_MIB_INDELIVERS),
-	SNMP_MIB_ITEM("OutRequests", IPSTATS_MIB_OUTPKTS),
+	SNMP_MIB_ITEM("OutRequests", IPSTATS_MIB_OUTREQUESTS),
 	SNMP_MIB_ITEM("OutDiscards", IPSTATS_MIB_OUTDISCARDS),
 	SNMP_MIB_ITEM("OutNoRoutes", IPSTATS_MIB_OUTNOROUTES),
 	SNMP_MIB_ITEM("ReasmTimeout", IPSTATS_MIB_REASMTIMEOUT),
@@ -93,6 +93,7 @@ static const struct snmp_mib snmp4_ipsta
 	SNMP_MIB_ITEM("FragOKs", IPSTATS_MIB_FRAGOKS),
 	SNMP_MIB_ITEM("FragFails", IPSTATS_MIB_FRAGFAILS),
 	SNMP_MIB_ITEM("FragCreates", IPSTATS_MIB_FRAGCREATES),
+	SNMP_MIB_ITEM("OutTransmits", IPSTATS_MIB_OUTPKTS),
 	SNMP_MIB_SENTINEL
 };
 
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -117,6 +117,8 @@ static int ip6_finish_output2(struct net
 			return res;
 	}
 
+	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+
 	rcu_read_lock();
 	nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
@@ -335,7 +337,7 @@ int ip6_xmit(const struct sock *sk, stru
 
 	mtu = dst_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
-		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 		/* if egress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
@@ -1995,7 +1997,7 @@ struct sk_buff *__ip6_make_skb(struct so
 	skb->tstamp = cork->base.transmit_time;
 
 	ip6_cork_steal_dst(skb, cork);
-	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1789,7 +1789,7 @@ static void mld_sendpack(struct sk_buff
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	payload_len = (skb_tail_pointer(skb) - skb_network_header(skb)) -
 		sizeof(*pip6);
@@ -2147,8 +2147,7 @@ static void igmp6_send(struct in6_addr *
 	full_len = sizeof(struct ipv6hdr) + payload_len;
 
 	rcu_read_lock();
-	IP6_UPD_PO_STATS(net, __in6_dev_get(dev),
-		      IPSTATS_MIB_OUT, full_len);
+	IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_OUTREQUESTS);
 	rcu_read_unlock();
 
 	skb = sock_alloc_send_skb(sk, hlen + tlen + full_len, 1, &err);
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -504,7 +504,7 @@ void ndisc_send_skb(struct sk_buff *skb,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
-	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 		      net, sk, skb, NULL, dst->dev,
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -61,7 +61,7 @@ static const struct snmp_mib snmp6_ipsta
 	SNMP_MIB_ITEM("Ip6InDiscards", IPSTATS_MIB_INDISCARDS),
 	SNMP_MIB_ITEM("Ip6InDelivers", IPSTATS_MIB_INDELIVERS),
 	SNMP_MIB_ITEM("Ip6OutForwDatagrams", IPSTATS_MIB_OUTFORWDATAGRAMS),
-	SNMP_MIB_ITEM("Ip6OutRequests", IPSTATS_MIB_OUTPKTS),
+	SNMP_MIB_ITEM("Ip6OutRequests", IPSTATS_MIB_OUTREQUESTS),
 	SNMP_MIB_ITEM("Ip6OutDiscards", IPSTATS_MIB_OUTDISCARDS),
 	SNMP_MIB_ITEM("Ip6OutNoRoutes", IPSTATS_MIB_OUTNOROUTES),
 	SNMP_MIB_ITEM("Ip6ReasmTimeout", IPSTATS_MIB_REASMTIMEOUT),
@@ -84,6 +84,7 @@ static const struct snmp_mib snmp6_ipsta
 	SNMP_MIB_ITEM("Ip6InECT1Pkts", IPSTATS_MIB_ECT1PKTS),
 	SNMP_MIB_ITEM("Ip6InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("Ip6InCEPkts", IPSTATS_MIB_CEPKTS),
+	SNMP_MIB_ITEM("Ip6OutTransmits", IPSTATS_MIB_OUTPKTS),
 	SNMP_MIB_SENTINEL
 };
 
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -651,7 +651,7 @@ static int rawv6_send_hdrinc(struct sock
 	 * have been queued for deletion.
 	 */
 	rcu_read_lock();
-	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
 		      NULL, rt->dst.dev, dst_output);
 	if (err > 0)




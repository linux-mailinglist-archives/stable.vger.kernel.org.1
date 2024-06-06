Return-Path: <stable+bounces-49554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B868FEDC5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258411C23BC3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8E197509;
	Thu,  6 Jun 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufliWckB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D301ABE36;
	Thu,  6 Jun 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683523; cv=none; b=pGp8EnW7XkZsPWFTrPlIq9G87tu+Mz+J4mQFrjosDrlm1bO22vcuKP0yb9M9q8N8SOgLPuQNnZ62mnFdf2JEBQrlJah+LUDXl3wwyJnBZaQaLaKSsFNfnJ5ptlRNDwEmqy2GbVmx22x+FGfFA9n0048ttitpT8auBBbsyxW4vMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683523; c=relaxed/simple;
	bh=fZJyBhPcFIEm9ZBaU5bhWz0eWSSfmdgZrLRwqIQ505I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddnRpF0p+Ac+vOxM+mQxtnYrKAobzj/hZh7vmoRhHIqEA91pcao50dtERz9KZUQvv9PzfMm6o9U3NOtXxt2JSpMQ0JMqR1piadV+sy/dXz8vCOQx9F6lGJaJXTfb2+xBVVpgfUxKa8SzXHNG1QCLNULTudOAWE3WV5szqLLzhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufliWckB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2E2C2BD10;
	Thu,  6 Jun 2024 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683523;
	bh=fZJyBhPcFIEm9ZBaU5bhWz0eWSSfmdgZrLRwqIQ505I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufliWckBM/NLDodcMzgZzaEGRejGKAaYGd3ohqmPBIw56KNclSgdV3zw0wQ+5k4Pb
	 qDBHp00SJ8rDldsdMxjl10oJFPM4UkGrVQj4GM6EL9sWAtTZeici5oPDd0eDOlogWj
	 G3oQqUTlm8R7zz2YfS2AM6BWAyaDq/SJLydMMagc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaime Caamano <jcaamano@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 415/473] openvswitch: Set the skbuff pkt_type for proper pmtud support.
Date: Thu,  6 Jun 2024 16:05:44 +0200
Message-ID: <20240606131713.506326575@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Conole <aconole@redhat.com>

[ Upstream commit 30a92c9e3d6b073932762bef2ac66f4ee784c657 ]

Open vSwitch is originally intended to switch at layer 2, only dealing with
Ethernet frames.  With the introduction of l3 tunnels support, it crossed
into the realm of needing to care a bit about some routing details when
making forwarding decisions.  If an oversized packet would need to be
fragmented during this forwarding decision, there is a chance for pmtu
to get involved and generate a routing exception.  This is gated by the
skbuff->pkt_type field.

When a flow is already loaded into the openvswitch module this field is
set up and transitioned properly as a packet moves from one port to
another.  In the case that a packet execute is invoked after a flow is
newly installed this field is not properly initialized.  This causes the
pmtud mechanism to omit sending the required exception messages across
the tunnel boundary and a second attempt needs to be made to make sure
that the routing exception is properly setup.  To fix this, we set the
outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
to the openvswitch module via a port device or packet command.

Even for bridge ports as users, the pkt_type needs to be reset when
doing the transmit as the packet is truly outgoing and routing needs
to get involved post packet transformations, in the case of
VXLAN/GENEVE/udp-tunnel packets.  In general, the pkt_type on output
gets ignored, since we go straight to the driver, but in the case of
tunnel ports they go through IP routing layer.

This issue is periodically encountered in complex setups, such as large
openshift deployments, where multiple sets of tunnel traversal occurs.
A way to recreate this is with the ovn-heater project that can setup
a networking environment which mimics such large deployments.  We need
larger environments for this because we need to ensure that flow
misses occur.  In these environment, without this patch, we can see:

  ./ovn_cluster.sh start
  podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
  podman exec ovn-chassis-1 ip netns exec sw01p1 ip r flush cache
  podman exec ovn-chassis-1 ip netns exec sw01p1 \
         ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)

  --- 21.0.0.3 ping statistics ---
  ...

Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
sent into the server.

With this patch, setting the pkt_type, we see the following:

  podman exec ovn-chassis-1 ip netns exec sw01p1 \
         ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
  ping: local error: message too long, mtu=1222

  --- 21.0.0.3 ping statistics ---
  ...

In this case, the first ping request receives the FRAG_NEEDED message and
a local routing exception is created.

Tested-by: Jaime Caamano <jcaamano@redhat.com>
Reported-at: https://issues.redhat.com/browse/FDP-164
Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
Signed-off-by: Aaron Conole <aconole@redhat.com>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Link: https://lore.kernel.org/r/20240516200941.16152-1-aconole@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/actions.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index a8cf9a88758ef..21102ffe44709 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -924,6 +924,12 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		/* Need to set the pkt_type to involve the routing layer.  The
+		 * packet movement through the OVS datapath doesn't generally
+		 * use routing, but this is needed for tunnel cases.
+		 */
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.43.0





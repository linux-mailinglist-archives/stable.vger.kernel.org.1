Return-Path: <stable+bounces-130387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB5A80462
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C364A008D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59A269AE4;
	Tue,  8 Apr 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHiyBHC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C1269839;
	Tue,  8 Apr 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113580; cv=none; b=GUfOhXsvGD0DAyqZJvpk0O5G6MSdby8eIN7oyroItGqYZDKQwA/UsS5Le/6f22CS1fNpFY5cnbTWKdVfKbT0RZ+ct2Lob/RzEwmTINAXoo8T+rIq+jVaAZRkCTLC5WAuWyAgsAbIN3LuA2we/7716DjzOcRWscmHsmNOWzgIBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113580; c=relaxed/simple;
	bh=qXh3JprL7h8PJtYwZfWOeUorLTUT0X4Ayreajg5Mbls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep3b6/TnwZIWJyLixVm+4oo/rre4dhGDlWG4EoPD46LynVe12Bfxd37nQGSK4RnnuswGV746sxG/tN90fbpHjxFJKPOYu0axg2LlmwbCKPLYW2rGU+F7dLvhmV2QcA3gSG93NL0pn/Csh5HzJygLkn77181At2LMMqm7j1dUzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHiyBHC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081A5C4CEE5;
	Tue,  8 Apr 2025 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113580;
	bh=qXh3JprL7h8PJtYwZfWOeUorLTUT0X4Ayreajg5Mbls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHiyBHC/K2zOG8Niz7YIPwpEiIj6k9ryClNxB+U4qCJ931t1+8d9GN7qqdYl5p37Q
	 ZEnuNM1bxWV7cDw969hL7bDBh4DlDD5BEBZ3X85ZHvNwAbGAa0JBlqhNA0dtgvSBkE
	 /oW509dlN2Gmzx5SRQTogdY5pmTDbTVEUn5kNqTc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 212/268] tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().
Date: Tue,  8 Apr 2025 12:50:23 +0200
Message-ID: <20250408104834.299760083@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 8930424777e43257f5bf6f0f0f53defd0d30415c ]

Because skb_tunnel_check_pmtu() doesn't handle PACKET_HOST packets,
commit 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper
pmtud support.") forced skb->pkt_type to PACKET_OUTGOING for
openvswitch packets that are sent using the OVS_ACTION_ATTR_OUTPUT
action. This allowed such packets to invoke the
iptunnel_pmtud_check_icmp() or iptunnel_pmtud_check_icmpv6() helpers
and thus trigger PMTU update on the input device.

However, this also broke other parts of PMTU discovery. Since these
packets don't have the PACKET_HOST type anymore, they won't trigger the
sending of ICMP Fragmentation Needed or Packet Too Big messages to
remote hosts when oversized (see the skb_in->pkt_type condition in
__icmp_send() for example).

These two skb->pkt_type checks are therefore incompatible as one
requires skb->pkt_type to be PACKET_HOST, while the other requires it
to be anything but PACKET_HOST.

It makes sense to not trigger ICMP messages for non-PACKET_HOST packets
as these messages should be generated only for incoming l2-unicast
packets. However there doesn't seem to be any reason for
skb_tunnel_check_pmtu() to ignore PACKET_HOST packets.

Allow both cases to work by allowing skb_tunnel_check_pmtu() to work on
PACKET_HOST packets and not overriding skb->pkt_type in openvswitch
anymore.

Fixes: 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper pmtud support.")
Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Tested-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 net/openvswitch/actions.c | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 80ccd6661aa32..fda08e2c72899 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -415,7 +415,7 @@ int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!reply || skb->pkt_type == PACKET_HOST)
+	if (!reply)
 		return 0;
 
 	if (skb->protocol == htons(ETH_P_IP))
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 9445ca97163b4..6c5afb4ad67bb 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -931,12 +931,6 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
-		/* Need to set the pkt_type to involve the routing layer.  The
-		 * packet movement through the OVS datapath doesn't generally
-		 * use routing, but this is needed for tunnel cases.
-		 */
-		skb->pkt_type = PACKET_OUTGOING;
-
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.39.5





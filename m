Return-Path: <stable+bounces-165302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67774B15C84
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663B27A8E5B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74540275B1D;
	Wed, 30 Jul 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yaj6ByHN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8225DB1A;
	Wed, 30 Jul 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868597; cv=none; b=PhaAGvK/gLIFif2bQWhBKsvALG8WYmXDlSr1C+vlTQg1z+s9eYHbVrLu4SJax+Qe7NR7k4uqyzBcLpxIgCwo+hR2Mc0EktCaAedrkvONHQHjuEx+KC0xl7TS7eE53mr0GVtEy5hZKj4X59QKG1xXf4GNLaenXNNmPlDaUYLGWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868597; c=relaxed/simple;
	bh=56WdRDSLmE0wQGj/7XeZY1X3JEB60qLXYcYDINnyacU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLrAhws9GVAXza/BtRcAfX8jdyO93JRJHrsmhU8WsC3u/FiOaGR7J5/BFqmoA8oA3nMNiYvF/ovO62joq5G4kiZIOyNKp69D4JkjuYfzFRHyjO5OSy+aZi0dVLzYQUmtnFdP4dbHddfghwHTipn1GNhghGsngCV8Hf7XLi0eVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yaj6ByHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C52C4CEE7;
	Wed, 30 Jul 2025 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868595;
	bh=56WdRDSLmE0wQGj/7XeZY1X3JEB60qLXYcYDINnyacU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yaj6ByHN98Hx1CeWhvDGEXGAT+CsyXZAmLE8eiNXPwGTnfYzNEf3PCilnSO50ntQV
	 d+gzTDYz+8/CmffdBYEObnpxCRTS3AJVsnzh7lK/YTFeHyZLgHEff+K/bu/76uZYKm
	 z5N9y+MpmtjERDL7ORZHnCY2NtsArQVhiTWQIVtg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dennis Chen <dechen@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 026/117] i40e: report VF tx_dropped with tx_errors instead of tx_discards
Date: Wed, 30 Jul 2025 11:34:55 +0200
Message-ID: <20250730093234.587450319@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Chen <dechen@redhat.com>

[ Upstream commit 50b2af451597ca6eefe9d4543f8bbf8de8aa00e7 ]

Currently the tx_dropped field in VF stats is not updated correctly
when reading stats from the PF. This is because it reads from
i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
as it is not updated by i40e_update_eth_stats() and the corresponding
register, GLV_TDPC, is not implemented[1].

Use i40e_eth_stats.tx_errors instead, which is actually updated by
i40e_update_eth_stats() by reading from GLV_TEPC.

To test, create a VF and try to send bad packets through it:

$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ cat test.py
from scapy.all import *

vlan_pkt = Ether(dst="ff:ff:ff:ff:ff:ff") / Dot1Q(vlan=999) / IP(dst="192.168.0.1") / ICMP()
ttl_pkt = IP(dst="8.8.8.8", ttl=0) / ICMP()

print("Send packet with bad VLAN tag")
sendp(vlan_pkt, iface="enp2s0f0v0")
print("Send packet with TTL=0")
sendp(ttl_pkt, iface="enp2s0f0v0")
$ ip -s link show dev enp2s0f0
16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        0
$ python test.py
Send packet with bad VLAN tag
.
Sent 1 packets.
Send packet with TTL=0
.
Sent 1 packets.
$ ip -s link show dev enp2s0f0
16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        0

A packet with non-existent VLAN tag and a packet with TTL = 0 are sent,
but tx_dropped is not incremented.

After patch:

$ ip -s link show dev enp2s0f0
19: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
    vf 0     link/ether 4a:b7:3d:37:f7:56 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
    RX: bytes  packets  mcast   bcast   dropped
             0        0       0       0        0
    TX: bytes  packets   dropped
             0        0        2

Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
Signed-off-by: Dennis Chen <dechen@redhat.com>
Link: https://www.intel.com/content/www/us/en/content-details/596333/intel-ethernet-controller-x710-tm4-at2-carlsville-datasheet.html
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 625fa93fc18bb..8814909168039 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -5006,7 +5006,7 @@ int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
 	vf_stats->rx_dropped = stats->rx_discards + stats->rx_discards_other;
-	vf_stats->tx_dropped = stats->tx_discards;
+	vf_stats->tx_dropped = stats->tx_errors;
 
 	return 0;
 }
-- 
2.39.5





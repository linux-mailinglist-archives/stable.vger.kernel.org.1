Return-Path: <stable+bounces-228495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC1aD/dOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADE2F4B18
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA2832B4472
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF7381B03;
	Mon, 23 Mar 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4unefjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0913AE1A6;
	Mon, 23 Mar 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275283; cv=none; b=GS6DJJOnhjtmWcH0I/UGQHSR9smXxqqzBJkHFrMoVQhs+j28vIXoMmIMvhsxiatgGmOc9aLh5FWVHpk1dopNcKA6XYQT/EQAUlWuqkymAZAVdaLHzfSJx9mXLlKtNPIvge1WsHfMwSX+36u4AtI56GsuCyLoqk3cLjpmm92cnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275283; c=relaxed/simple;
	bh=zipn29Kfjx4IstzIEvQgRAfNsSKzH3eU5BRZmnqMGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khvmuVTCMUE5d4k0WziAaCi96wmSpkITAdQ+nDIv2fPQn/oRmFqUtzhEluPxAHwmlDAUNMPFl1GqDzqDHT6jpE6B2boYrsaR3owqtYG1XCV513BeyqwZI+pED/YU3yoLuIEh4qItpfjtZMcVG2ifPc8HiBVZQuqrgaTkAuWt3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4unefjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52855C4CEF7;
	Mon, 23 Mar 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275283;
	bh=zipn29Kfjx4IstzIEvQgRAfNsSKzH3eU5BRZmnqMGXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4unefjODxKHHKGTpz5DUem8iJqzfW4jkcwoBy07v99PuJw8+U1ifGFsHmF7EeyHp
	 hO7aUp/kcbEU2VnFJFxRia+sus8vZPGHQUylkc5gx05O7khOiuYcaeX9TZAAt+ZFRr
	 hBa5FXzDYCtQOMgygCBwR1jq5U07zXgK60PxyufU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 040/460] net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
Date: Mon, 23 Mar 2026 14:40:36 +0100
Message-ID: <20260323134527.692196142@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228495-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D9ADE2F4B18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 0cc0c2e661af418bbf7074179ea5cfffc0a5c466 ]

teql_master_xmit() calls netdev_start_xmit(skb, slave) to transmit
through slave devices, but does not update skb->dev to the slave device
beforehand.

When a gretap tunnel is a TEQL slave, the transmit path reaches
iptunnel_xmit() which saves dev = skb->dev (still pointing to teql0
master) and later calls iptunnel_xmit_stats(dev, pkt_len). This
function does:

    get_cpu_ptr(dev->tstats)

Since teql_master_setup() does not set dev->pcpu_stat_type to
NETDEV_PCPU_STAT_TSTATS, the core network stack never allocates tstats
for teql0, so dev->tstats is NULL. get_cpu_ptr(NULL) computes
NULL + __per_cpu_offset[cpu], resulting in a page fault.

 BUG: unable to handle page fault for address: ffff8880e6659018
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 68bc067 P4D 68bc067 PUD 0
 Oops: Oops: 0002 [#1] SMP KASAN PTI
 RIP: 0010:iptunnel_xmit (./include/net/ip_tunnels.h:664 net/ipv4/ip_tunnel_core.c:89)
 Call Trace:
  <TASK>
  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
  __gre_xmit (net/ipv4/ip_gre.c:478)
  gre_tap_xmit (net/ipv4/ip_gre.c:779)
  teql_master_xmit (net/sched/sch_teql.c:319)
  dev_hard_start_xmit (net/core/dev.c:3887)
  sch_direct_xmit (net/sched/sch_generic.c:347)
  __dev_queue_xmit (net/core/dev.c:4802)
  neigh_direct_output (net/core/neighbour.c:1660)
  ip_finish_output2 (net/ipv4/ip_output.c:237)
  __ip_finish_output.part.0 (net/ipv4/ip_output.c:315)
  ip_mc_output (net/ipv4/ip_output.c:369)
  ip_send_skb (net/ipv4/ip_output.c:1508)
  udp_send_skb (net/ipv4/udp.c:1195)
  udp_sendmsg (net/ipv4/udp.c:1485)
  inet_sendmsg (net/ipv4/af_inet.c:859)
  __sys_sendto (net/socket.c:2206)

Fix this by setting skb->dev = slave before calling
netdev_start_xmit(), so that tunnel xmit functions see the correct
slave device with properly allocated tstats.

Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Link: https://patch.msgid.link/20260304044216.3517851-3-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_teql.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 6e4bdaa876ed6..783300d8b0197 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -315,6 +315,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 
+				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
-- 
2.51.0





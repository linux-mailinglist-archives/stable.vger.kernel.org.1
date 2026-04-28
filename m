Return-Path: <stable+bounces-241789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMOSKGo58WkmewEAu9opvQ
	(envelope-from <stable+bounces-241789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:49:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9948CD19
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18F6D30065C8
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2638229C;
	Tue, 28 Apr 2026 22:49:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B4364E92;
	Tue, 28 Apr 2026 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416551; cv=none; b=PB+2qA/vhByvgpY+SRcKwnhCKbNRc6JPS6yrVtiG/Zl/g3XxSCKbg0sYsQyBycvTEW3NJk1njKYz5C2GWGvvopv4kb0qIrObyf5ZHYhrfx7IkuXHQHunc01QKvGxe68ARGWaRoFbf3FwtxjNSUgJ9/21ant6Ux1V7BkGk82YZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416551; c=relaxed/simple;
	bh=nLEfbRIRvnlwTITh/nE8m/FFx0nDjwrbG1AUcQ7QqoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QcYfyPoZYa/3q6pdmJSYbjUKzaHY50SKo/fBdb+WdQEjINEbil+6NpCpXVRNeKtGyWVdVww9nrc6dq81kdVgPsBrcYPrWvB+49Jc3VXIZAWF0Ky7dGzK5vfUuOJjBfbPKnTeG0t9UOf70pC30xSvNGWKxzfQWojcV2Tr3UdBOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 63SMmTio003354;
	Wed, 29 Apr 2026 00:48:34 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
        Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
Date: Wed, 29 Apr 2026 00:48:16 +0200
Message-Id: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Queue-Id: 38A9948CD19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241789-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,uniroma2.it];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.946];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without
a NULL check when reading idev->cnf.rpl_seg_enabled.
When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown()
clears dev->ip6_ptr through RCU_INIT_POINTER(), which is immediately
visible to concurrent readers. A packet that already passed the idev
check in ip6_rcv_core() can race with this and hit a NULL pointer
dereference.

Reproduced by flooding traffic through a route with RPL source routing
while rapidly flapping the receiving interface's MTU between 1500 and
1200:

 BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xae/0x1050
 Read of size 4 at addr 00000000000006b4 by task ping6/318

 CPU: 0 UID: 0 PID: 318 Comm: ping6 Not tainted 7.1.0-rc1-micro-vm-dev-g46f74a3f7d57 #82 PREEMPT(full)
 Call Trace:
  <IRQ>
  kasan_report+0xc6/0x100
  ipv6_rpl_srh_rcv+0xae/0x1050
  ip6_protocol_deliver_rcu+0x717/0x960
  ip6_input_finish+0xa3/0x1b0
  ip6_input+0xdc/0x490
  ipv6_rcv+0x338/0x460
  __netif_receive_skb_one_core+0xd1/0x130
  process_backlog+0x2c7/0x9f0
  __napi_poll.constprop.0+0x51/0x270
  net_rx_action+0x322/0x730
  handle_softirqs+0x119/0x640
  do_softirq+0xae/0xe0
  </IRQ>

Add a NULL check for idev after __in6_dev_get() and drop the skb if
idev is NULL, consistent with the SRv6 fix in commit 064137935262
("ipv6: add NULL checks for idev in SRv6 paths").

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/exthdrs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 03cbce842c1a..e398a8851031 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u32 r;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb(skb);
+		return -1;
+	}
 
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
-- 
2.20.1



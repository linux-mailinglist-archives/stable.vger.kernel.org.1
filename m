Return-Path: <stable+bounces-249302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3HFnYiC2omDwUAu9opvQ
	(envelope-from <stable+bounces-249302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:30:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4E56ECD3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83C5A30166B4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A40A3F6C2E;
	Mon, 18 May 2026 14:22:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA5481FBE;
	Mon, 18 May 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114178; cv=none; b=PHv7irrsh4C6cHreJBFW5867igpl9lCCI3KylMJd/jhVnaQODmNFJtfY86oI6Xd9r73WXvnhv4reguk/Fv/g74w8bejFcVWBy00FTHnIWcTc8Ee69gVNqSX4yL1myiwFBsPTI7V93hBuLoBQQ9y68hboX9gaH2+h7SWCvUcdvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114178; c=relaxed/simple;
	bh=EisR7jxzd2LeRIwSiy1K1n3M2UViEZOmNv0A6dl9SLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ju8LbvX3KAZqh6qPfz/Zq5XarGhBbC0PIijfAs6WJC3x9+SFWGwFD4xubM5rDEZPDY91aKVCMwQie4OOFeAexKfMhEEyBKMtukUOv3X4tnpwR/JJNkrdgwiWhztA4s1pWlxaZtqXsy7e85LAgPA3WkaVrUeN6G/y15mU50tgSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64IE8HKq002141;
	Mon, 18 May 2026 16:08:22 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
        justin.iurman@gmail.com, bestswngs@gmail.com,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>,
        stable@vger.kernel.org
Subject: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
Date: Mon, 18 May 2026 16:06:30 +0200
Message-Id: <20260518140630.24280-1-andrea.mayer@uniroma2.it>
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
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249302-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,uniroma2.it];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,uniroma2.it:mid,uniroma2.it:email]
X-Rspamd-Queue-Id: 62A4E56ECD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without a
NULL check when reading idev->cnf.rpl_seg_enabled.

When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown()
clears dev->ip6_ptr through RCU_INIT_POINTER(), which is immediately
visible to concurrent readers. A packet that already passed the idev
check in ip6_rcv_core() can race with this and hit a NULL pointer
dereference.

Reproduced by flooding traffic while rapidly flapping the receiving
interface's MTU between 1500 and 1200:

 BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xae/0x1050
 Read of size 4 at addr 00000000000006b4 by task ping6/386

 CPU: 0 UID: 0 PID: 386 Comm: ping6 Not tainted 7.1.0-rc3 #114 PREEMPT(full)
 Call Trace:
  <IRQ>
  kasan_report+0xc6/0x100
  ipv6_rpl_srh_rcv+0xae/0x1050
  ip6_protocol_deliver_rcu+0x754/0x9a0
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

Add a NULL check for idev after __in6_dev_get(), dropping the skb
with SKB_DROP_REASON_IPV6DISABLED when the device has no IPv6
configuration.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
v2:
  - use SKB_DROP_REASON_IPV6DISABLED as drop reason (Eric Dumazet)
v1: https://lore.kernel.org/netdev/20260428224816.11223-1-andrea.mayer@uniroma2.it/
---
 net/ipv6/exthdrs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 03cbce842c1a..a4af6e63349c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u32 r;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
+		return -1;
+	}
 
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
-- 
2.43.0



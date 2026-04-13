Return-Path: <stable+bounces-237663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C+JBoJh3WlpdQkAu9opvQ
	(envelope-from <stable+bounces-237663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:34:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D83F391F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252BB3025E7A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972839526B;
	Mon, 13 Apr 2026 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+bjq8D+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAD3909A2
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116094; cv=none; b=AXa6lOlp+S7Sp/ZfCOELOBY+2rfsYwXEoNRhC2OlCDBORdYpOzr8r+YVcH5PB+42uukUH4APWNzxrpDINEfPlj2lqaJRMpsnKItbuQZ7ONihlgbKzrV1XIAQJ21pAdB19zR1M6CzbzZZrK+1er2NTX3J+gKJvnDRNWbokMCyoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116094; c=relaxed/simple;
	bh=Rmtg62i0qDtaCHpgyhlGYP4JOIqwIV0+Cp48SGL0eY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lLxe2KWY61dbTvKe2gjEwuo6CYPrnMm3gM5AKhz++uBPgIZEjRz+3Vu7O/PYmH0MUEn7l0G75/NtGtod4NPYzCGHzmJds6VVEpTC03J2Bk3+TlLhLLNEwh/ufj/7tZsPn7UftZGUaWn1PkQT8a0/gxVuDHyKi89NBJ1jcjkPni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chenglongtang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+bjq8D+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chenglongtang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so2416628a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776116093; x=1776720893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nS8GXUr4YHNuQ33afnCqiNAVZmLxJz/PiZVElYCckUU=;
        b=e+bjq8D+hUnJNEYC2iOPa9YmqZCpQS0iVOX47y62VQyDwE8H3NOY3+lda5H7nWx+cP
         gYAetRWxIMPkweZsc93XRKrUP7CEXotIxTFSHaIJYtxhQz5Pv5N2MipdsHZbeSfHm8IP
         y186e9jv9wWCoB8/5HHTHpobaKiTQCUV6OAfANZdd36VwJjANllk5TG7q4fklNtbKbsF
         mPgwzw7aufObs9IxkvvHgQrApVb8KgaP9JKsrDG9l/RBHrKBcOBmKvyoTDlCYuCwbXgP
         I2kNfgCZ4iNN6C4P6l1DWB0JCtYjxCb8lTPI2Bh2xGbFW7Vb+xIBRZ36T/OV4iKflpFb
         V9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116093; x=1776720893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nS8GXUr4YHNuQ33afnCqiNAVZmLxJz/PiZVElYCckUU=;
        b=ALguNneWijUWPPU3H57sEwD9QDH12Fbnd6p2V/5n/GDQ2Xxmvxs5ibELyhP8zjQSsz
         UWlVj4WuVbu14+CCPFaMNZJJNF9VuRaiGAvehlDQ5E6dNNoDqeYGWr93FR9K1IQnvQWB
         LMdtA0F5D0UTFJtJng53gw6NEgNxYMHkkckwHoN+P10jFJIvaFiw2OT4FCZwFC+QRECK
         /VMojDPJtp5rOMZewU35nQCI6kW3JlMyDdWGhs9CzCHzVcrYZbJ/HTF+4l5uynl4wf8/
         zg0NzYaJQWOW62EEcl3YNnCd6597LEbO4szVMBNrfR00tGP7E9OYSqob7uRBvATIsofv
         YASw==
X-Gm-Message-State: AOJu0Yw7d40CB0aKb9Tz1f0cN9r5h3SNzo7sNXPOnJGcUQGljYb6T/9P
	yZu4PxCaS08yg4w/SmDcPDfuMrHD+y2beAt59fhJsaMsKL5gog3GyvDH2mFw+cvNH3xXD45a0lk
	0mcuplhsZoqWnQh83MkxUksafHfv/oKHEXZYH47akjvg+olDBam1rrGyK4g1iyP6Gc31dAFCNlK
	9Fy0Us/PLz0eL4CPdHIYmgOGH8V5srbyak0UNF1CQ0ytWLWISdtZKx3si15L88y2nDUVyUyzbqu
	w==
X-Received: from pgc11.prod.google.com ([2002:a05:6a02:2f8b:b0:c6d:caaa:3364])
 (user=chenglongtang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a1c:b0:39c:3543:b8ca with SMTP id adf61e73a8af0-39fe47084ecmr13476641637.29.1776116092454;
 Mon, 13 Apr 2026 14:34:52 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:34:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413213409.1674678-1-chenglongtang@google.com>
Subject: [PATCH 6.12.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Chenglong Tang <chenglongtang@google.com>
To: stable@vger.kernel.org
Cc: kpberry@google.com, rnj@google.com, joneslee@google.com, 
	Chenglong Tang <chenglongtang@google.com>, Weiming Shi <bestswngs@gmail.com>, 
	Xiang Mei <xmei5@asu.edu>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237663-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,asu.edu,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenglongtang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email,msgid.link:url]
X-Rspamd-Queue-Id: 7D4D83F391F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 2884bf72fb8f03409e423397319205de48adca16 upstream.

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Change-Id: I2349f4953b5760b7f4a12da583aa779c19c4b59c
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Kevin Berry <kpberry@google.com>: fixed merge conflicts and adapted
to 6.12 struct]
Signed-off-by: Chenglong Tang <chenglongtang@google.com>
---
 drivers/net/bonding/bond_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2ac455a9d1bb..fb8d7fec27ee 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5346,23 +5346,33 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 	return bond_tx_drop(dev, skb);
 }
 
-/* in broadcast mode, we send everything to all usable interfaces. */
+/* in broadcast mode, we send everything to all or usable slave interfaces.
+ * under rcu_read_lock when this function is called.
+ */
 static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
-				       struct net_device *bond_dev)
+				       struct net_device *bond_dev,
+				       bool all_slaves)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *slave = NULL;
-	struct list_head *iter;
+	struct bond_up_slave *slaves;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i;
 
-	bond_for_each_slave_rcu(bond, slave, iter) {
+	if (all_slaves)
+		slaves = rcu_dereference(bond->all_slaves);
+	else
+		slaves = rcu_dereference(bond->usable_slaves);
+
+	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+	for (i = 0; i < slaves_count; i++) {
+		struct slave *slave = slaves->arr[i];
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
@@ -5597,7 +5607,7 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
 	case BOND_MODE_XOR:
 		return bond_3ad_xor_xmit(skb, dev);
 	case BOND_MODE_BROADCAST:
-		return bond_xmit_broadcast(skb, dev);
+		return bond_xmit_broadcast(skb, dev, true);
 	case BOND_MODE_ALB:
 		return bond_alb_xmit(skb, dev);
 	case BOND_MODE_TLB:
-- 
2.54.0.rc0.605.g598a273b03-goog



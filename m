Return-Path: <stable+bounces-241732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ5LFBrx8Gn9bAEAu9opvQ
	(envelope-from <stable+bounces-241732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DAF48A1CA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BFAE30C46E3
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A592D5432;
	Tue, 28 Apr 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9Tf/5O4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4142DDA9
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393935; cv=none; b=p/6RwSbCEOasQbPZVIr7fK/RPcLIaqVo8BBSCkFzfqPMyM5yNkrT018qDGoi055pd0hm4AECbCn8F6YMzDPDl2N+mwDhOWJyZlsXVSLHr6PcmoiraiDtY4hp5j+UUEUg4grXoqtMYOl3q47GV4i4fiBSvHigSerelavsjE6b540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393935; c=relaxed/simple;
	bh=+sU4XCLUoFB8fRhNO3eN/ZXWBYJUzMMzukc44pMotiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMa2bwCKFZEL3RSUnLfxNcf9uMmJLZiS4+bn7O50mbNkcCbdh90PpQA8ZtNFaI7H2xtCqQGqmFwb5v+nhizPVw7sgs8viGca50CZTTNS46cWDSo54b0KSbP7oY6VBx3nTUt5wc/t+GmEPkICcle9FQy+uQT1eFNacwop7FEsbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9Tf/5O4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f2138a9e0so7408703b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777393933; x=1777998733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6ZXXHA8w3KYlTHJv6KyoGFLgNYb30vzsCCTHpgraVA=;
        b=B9Tf/5O4UGEItBegrb9pldUKaBygiYb0QJ+pLq2K++4Rlo0nD5QcExPZcJZqMDYl5g
         BfD6eiJFvZhwdMd6y6PZuHokU1YTdHaBanA3qd6x0/UJmCQtNqC0xkNWlzQD5JJrZ7VU
         uNdahc3JGQp9vS2mPqhtx2OoQqMfeaD6ImmCOmu9J2xsIpINEUFZZBWvH705zsA3sVvJ
         5NkySuLFoCNK3LHPOm4ZjHH7ehE6q4Nei2dMSxUTdFJzctSGg14k+9xl326uG0eqWOes
         AMcqfHrXq6UKMupKFiiH3lG0gXNbLz4VeW+cK1PHExa2ma5dqQ6VnbaO0vZaG0t56fKk
         fhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393933; x=1777998733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6ZXXHA8w3KYlTHJv6KyoGFLgNYb30vzsCCTHpgraVA=;
        b=WSh97eTmyXp+qyHzEsUw7IsKBDIYNT7H7aOCJ0rNeDyLZZc9yvgekZFhZN1Ui2Urcd
         sznq9Dy4Sn3comA/D4k2/qqltK9aSL0mdo3NajcxwBw21ItdhEUAsy75un3vWi4AXEuJ
         LGH/EeGzCVb0C04L5YmEfond6ZH82r2La7LIzrLvlg2Tn560LDAdaBoblmOg/R089udm
         I3KmGN2d4TQQjafib7Tyjwe/tMxSBG0XTfzsYUfpr0rTM8FhGAw9GFAU3Y/o1N18fFRa
         Kg+tDaWxOOy0UWUAxHxqM86Ji1uD+XVIAgGx01yvipHBd2zHWfdZ5hGXDrj99NDTgqxQ
         IO1g==
X-Forwarded-Encrypted: i=1; AFNElJ/D1Fpm/KlmjzbVzKXgwUnm/AamzNDiNR8XL7qUpDA0EptNiQx+54C3aE7RHfO6VSMQDoQ9grg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6Cch17Kp5xxx93pUbLY+PGBX8g7W7QY5XDyxP4l81NM55Acu
	v7gwe/EdSu8GSQIU6JSu30MQO/2c9HgDVGNQbPr8fFjaUwd6qxH37FcpLyx3pBkP3oWzRqnxE6P
	p4nNTTTB7Kw==
X-Received: from pfjd1.prod.google.com ([2002:a05:6a00:2441:b0:82f:af79:9f3])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da8:b0:82f:9300:cc44
 with SMTP id d2e1a72fcca58-834ea32b5cemr42118b3a.8.1777393933101; Tue, 28 Apr
 2026 09:32:13 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:32:03 +0000
In-Reply-To: <20260428104138.reply-bonding-6.12@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428104138.reply-bonding-6.12@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428163203.796681-1-kpberry@google.com>
Subject: [PATCH v2] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B8DAF48A1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241732-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	R_DKIM_ALLOW(0.00)[google.com:s=20251104];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	NEURAL_SPAM(0.00)[0.948];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,asu.edu:email]

From: Xiang Mei <xmei5@asu.edu>

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
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 drivers/net/bonding/bond_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5035cfa74f1a..9f1a189d46f1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5326,14 +5326,21 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 	struct list_head *iter;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i = 0;
 
+	slaves_count = READ_ONCE(bond->slave_cnt);
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
+		bool is_last;
+
+		if (++i > slaves_count)
+			break;
+		is_last = (i == slaves_count);
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (is_last) {
 			skb2 = skb;
 			skb_used = true;
 		} else {

base-commit: c286ea5e62389897291fa742d2bb909ecc9ef2d0
-- 
2.54.0.545.g6539524ca2-goog



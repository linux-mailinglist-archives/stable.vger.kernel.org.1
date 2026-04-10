Return-Path: <stable+bounces-235665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXVDkBo2Wn5pQgAu9opvQ
	(envelope-from <stable+bounces-235665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 23:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C33DCC86
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 23:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F113006B72
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4DD366548;
	Fri, 10 Apr 2026 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0WxbzTU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EC33D4FB
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855397; cv=pass; b=hDAEMywoeWlY4ddsiCWCZ3NM2ThFOZt+pl464YPJ5HEJcolGXSfgXhhaX9vaev9R2sF9CYl8y8xpWxFlHzgend5WZD6VNjjxBCJh8eKe9HVhjx6LfEjJTu7/qHbx6IvIZAdBtJjCU2PA/m5Gd90DtGnPO+PEjNMXg9G3H28IwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855397; c=relaxed/simple;
	bh=6a6H7Qr//b7nvmCemreUm3sVAxJ7uj+IGCY1qpFkgXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jHkCHBe3cA13y7x0IItKS8H32jW04rRSVd4V1zhWedJrELlJ/ew/dneWZy+1ddE/kIkEwEhcowiEsETDw/9r1nJmOkdFG+OBwnpJRPZ9fKTJtDX5b8UIj+xqDR7MySFIo9JtXEa5AMj1iC3KGIZIh9EF3bk/XfxyIhuWX2yKqsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0WxbzTU; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b393d60so1851261cf.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 14:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775855394; cv=none;
        d=google.com; s=arc-20240605;
        b=QeqKTLZxrif9NPMCcegoW3l1XXjz4o0fxFtE1NW8OzNgWfDNs9AyOzSzlXdkKfqaSv
         7ggoIp/b9Z99KgBgVgyVULf77qzn9Mwmfs5p1bm4aimTvFnwVgVPs0Ieho4d5TISh5kA
         fs6nh6eDo7wrzrB8rPGUKUujclstcDVmB5FkCaj34AtzH50yeYnCTTKLCBAsbYy/rINX
         3u7FTl9Y920ovtKrGyKsPhbeKeyCSjHhJHwecK/BfnApYpfoFMs6DyPB11f2x7FZqf36
         cVOEiFCp00Rm3CQEGBuh2BDWvOZ2gPaqmWaY2nMuPBW4H7Kwi9Q8HfSsmXH2xCUSvo/3
         FOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6a6H7Qr//b7nvmCemreUm3sVAxJ7uj+IGCY1qpFkgXc=;
        fh=f1FLub//XbByRgBL+CUT4OoPeQMqzg/JjzXWMDs/Mg8=;
        b=YnaqR4M7de5l4gnofFTGPyFccz7OdvvRREBYus4IY2/AQqNRPKS4k8ENNYfQVoUPL2
         UuKetsw4lVjaPjn+m4/w7OmkJs2PdRewgOEiAl4kfoZvUUusvAKQHm2gYlu27yFM1dlf
         1zFRI0sJi2DacxoK0Nr3xITbyTgWGLbJx3uYK0WOOog86fgsF2EC4sZkphjuRdnYP2V5
         YDEA5wfgsbnEWvd/moZETfibupVKhde5rTw84wCwq2m/8wunligeyWTtHyc2seJAyREg
         qWSuBlPf8hwb0lej87+sUNT3GZIY9XJ4AnK4QCAmoXUGOy46BUhJJ4HDEjXPzFeEEMnL
         LL0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855394; x=1776460194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6a6H7Qr//b7nvmCemreUm3sVAxJ7uj+IGCY1qpFkgXc=;
        b=G0WxbzTUXtdwwVJ47vOS3TP0YtivPWS1zBv98v5jeuKfzBMb9X8tdYey5LI5ouxWqD
         vUkgeJ1aeskhWjtmSCR0zQU5+pCDm3VFFpQVF+AHJ0DjF68Ht00I736L9r+DlMM6oYXe
         CWr/Eqyf/53/i7lGqTvGs8m0J+UeprPq71m7ACL5KPRQUQyKilT3P2dX2dTXL62QEhov
         0jIPDFDMm2xP4kLNhnvsAgCT+L6Ot4w3Lao4KdEpZ8CmKdQWzW0sF1FVIFWQH8v2oUa0
         0XgtTGT95Dn80+BEkU2C6Zc7XPnuTEWIAwWMy/D09lrk1f72xG1uTBYBQTHa+ZfVyWPy
         2O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855394; x=1776460194;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a6H7Qr//b7nvmCemreUm3sVAxJ7uj+IGCY1qpFkgXc=;
        b=azaNsbQG8Wk6ajuLArcOk4atyuKyTCOsEKpKo5lLRkQAKlCt7zWG+hMYzsKEVifksX
         ugDw7PKRoyRd9/AOpr+1HPfB4ctYh8trWJNLEeDkArGzY+dPJ1SwCrXRYykTZVFQ6cTn
         TaUJYclJX9fl1KNiW79CDdRzvZoEwv4US0+gizejU3QcPvmYkJ3pj5W710M16K5f8adN
         OuFVADgYLlQiqb/HUeIR1gVOouc+ZvUmxZ0mM6ogmMDHLmooYY0bVO3T8opn/rVk7HdD
         mrGiA6cmhkfq6+d4TYl357oWVjUEKZuiHk7tZdWKsm/Z7tRicyWSRvuR6i+bhRaGJgzW
         HCGg==
X-Gm-Message-State: AOJu0Yxry7YPHFqBgawNJ5YPq2CBN2oQdfInzkBLz2GxlOBNHcUaiHrP
	389xYS+tKVFbFTljxwN8zsw/NWU49d3Tsoq48S9Ek1l/ZsMD/aY7WMjCJYBR1FfomWvV1R4nWQB
	qzbogwnZbp8hiI+NnOF9V8jHKZxCSA5JpXAisMMscYeFeDkHyT5bzTEXbZoo=
X-Gm-Gg: AeBDieuE223SnnPhrqq8esB80FBKJsI5/QIoAhdgkVIn6Ud+o5MoXxO+PYdy2IzNWpM
	R8ABfiEBkTHjADcgSMPJqOdUxqIX1rIboLjiamVXQwz6rQgt/AkoWpkltLO2AawACITYdSSnUPN
	k92qsjhZX+08JqPSKmYJr6rJoO+ZlC2/rTt3LbHDwtBTQs7w11YVnr3O2mzUWZHga1R/J4nFpud
	Ki1pVqe+yc/C/JLRYfJWBbBD3teai9KJocMZYIkOs4G4vcQiAVv9wNNK6VSqoec/C33A4URIWRZ
	X/G+YzmOLO1ZL6282Q==
X-Received: by 2002:a05:622a:4d43:b0:509:25c5:42b4 with SMTP id
 d75a77b69052e-50dc42d244amr36573571cf.13.1775855394062; Fri, 10 Apr 2026
 14:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenglong Tang <chenglongtang@google.com>
Date: Fri, 10 Apr 2026 14:09:42 -0700
X-Gm-Features: AQROBzCd0MQ2XDdBZVWmc9Pwp7LjObonxAxnoa3pGiZN7SbExc35-PscByvqjGE
Message-ID: <CAOdxtTZ7=S=oEK1TPHoXWtw9V6=QWh5Jygad_-SjtF66_vv-cQ@mail.gmail.com>
Subject: [PATCH 6.12.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: stable@vger.kernel.org
Cc: xmei5@asu.edu, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	sashal@kernel.org, Kevin Berry <kpberry@google.com>, Lee Jones <joneslee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235665-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenglongtang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 546C33DCC86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 2884bf72fb8f03409e423397319205de48adca16 upstream.

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop. This
causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop. This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:
==================================================================
BUG: KASAN: slab-use-after-free in skb_clone Read of size 8 at addr
ffff888100ef8d40 by task exploit/147 CPU: 1 UID: 0 PID: 147 Comm:
exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY Call Trace: <TASK>
dump_stack_lvl (lib/dump_stack.c:123) print_report
(mm/kasan/report.c:379 mm/kasan/report.c:482) kasan_report
(mm/kasan/report.c:597) skb_clone (include/linux/skbuff.h:1724
include/linux/skbuff.h:1792 include/linux/skbuff.h:3396
net/core/skbuff.c:2108) bond_xmit_broadcast
(drivers/net/bonding/bond_main.c:5334) bond_start_xmit
(drivers/net/bonding/bond_main.c:5567
drivers/net/bonding/bond_main.c:5593) dev_hard_start_xmit
(include/linux/netdevice.h:5325 include/linux/netdevice.h:5334
net/core/dev.c:3871 net/core/dev.c:3887) __dev_queue_xmit
(include/linux/netdevice.h:3601 net/core/dev.c:4838)
ip6_finish_output2 (include/net/neighbour.h:540
include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
ip6_finish_output (net/ipv6/ip6_output.c:208
net/ipv6/ip6_output.c:219) ip6_output (net/ipv6/ip6_output.c:250)
ip6_send_skb (net/ipv6/ip6_output.c:1985) udp_v6_send_skb
(net/ipv6/udp.c:1442) udpv6_sendmsg (net/ipv6/udp.c:1733) __sys_sendto
(net/socket.c:730 net/socket.c:742 net/socket.c:2206) __x64_sys_sendto
(net/socket.c:2209) do_syscall_64 (arch/x86/entry/syscall_64.c:63
arch/x86/entry/syscall_64.c:94) entry_SYSCALL_64_after_hwframe
(arch/x86/entry/entry_64.S:130) </TASK> Allocated by task 147: Freed
by task 147: The buggy address belongs to the object at
ffff888100ef8c80 which belongs to the cache skbuff_head_cache of size
224 The buggy address is located 192 bytes inside of freed 224-byte
region [ffff888100ef8c80, ffff888100ef8d60) Memory state around the
buggy address: ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc
fc fc fc fc ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc
fc fc ^ ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
fb ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return
value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Kevin Berry <kpberry@google.com>: fixed merge conflicts and adapted
to 6.12 struct]
Signed-off-by: Chenglong Tang <chenglongtang@google.com>

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2ac455a9d1bb..fb8d7fec27ee 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5346,23 +5346,33 @@ static netdev_tx_t bond_3ad_xor_xmit(struct
sk_buff *skb,
return bond_tx_drop(dev, skb);
}
-/* in broadcast mode, we send everything to all usable interfaces. */
+/* in broadcast mode, we send everything to all or usable slave interfaces.
+ * under rcu_read_lock when this function is called.
+ */
static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
- struct net_device *bond_dev)
+ struct net_device *bond_dev,
+ bool all_slaves)
{
struct bonding *bond = netdev_priv(bond_dev);
- struct slave *slave = NULL;
- struct list_head *iter;
+ struct bond_up_slave *slaves;
bool xmit_suc = false;
bool skb_used = false;
+ int slaves_count, i;
- bond_for_each_slave_rcu(bond, slave, iter) {
+ if (all_slaves)
+ slaves = rcu_dereference(bond->all_slaves);
+ else
+ slaves = rcu_dereference(bond->usable_slaves);
+
+ slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+ for (i = 0; i < slaves_count; i++) {
+ struct slave *slave = slaves->arr[i];
struct sk_buff *skb2;
if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
continue;
- if (bond_is_last_slave(bond, slave)) {
+ if (i + 1 == slaves_count) {
skb2 = skb;
skb_used = true;
} else {
@@ -5597,7 +5607,7 @@ static netdev_tx_t __bond_start_xmit(struct
sk_buff *skb, struct net_device *dev
case BOND_MODE_XOR:
return bond_3ad_xor_xmit(skb, dev);
case BOND_MODE_BROADCAST:
- return bond_xmit_broadcast(skb, dev);
+ return bond_xmit_broadcast(skb, dev, true);
case BOND_MODE_ALB:
return bond_alb_xmit(skb, dev);
case BOND_MODE_TLB:


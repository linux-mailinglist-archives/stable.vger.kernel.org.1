Return-Path: <stable+bounces-254639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB2rCAMlF2qu6wcAu9opvQ
	(envelope-from <stable+bounces-254639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:08:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2C5E829C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761DF3021D05
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040842E00B;
	Wed, 27 May 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/win7JC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA24399CE4
	for <stable@vger.kernel.org>; Wed, 27 May 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901694; cv=none; b=iC5wY+6UDD13d/M3NCxf2HaIty7+ctUtOnxTFXeJ45hhf0PGFGwdCL6Rsb/psVyPjNGssVzT+93ytMrLM1Jo+JUVUOJ2hpNR1m46bC7Z2N8SlIXLlPFarbdN13YfxU/s2y0/mkBaem30l2lfUHjiMrD0I9Ftg0e833C/q8nQ8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901694; c=relaxed/simple;
	bh=HIrkNkLPX0WP6bD8jAqDyZNaY0hlCaXzykPbqSERkHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQrzBU7kOonyeUDEOXy/HvwE3NNwK+6EDgik3c9GOhC6n+jFvTmeD9qeerdI0+r6OEwyZX3Upp9W6zo1r1u1uS7cP7/ktFIv7nudTdwC+gebMx2sj+y7Bsvi8T5ujFafY3aaqEZspObv1g9USBoZquHQxL5s1SfEbtMjrjmKjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/win7JC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49083c865f7so543745e9.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779901692; x=1780506492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHAbIBOe3Gsbuk1qhmrF0rf8qzMpDcWVUgQaeCjlWyA=;
        b=M/win7JCuzwTSaicHHIHVuNtwXsX0a9N1xvuB3GwjrSmIw1bh/v5DHtsL4GbDIFywC
         AvyN4K56zJG0qTU8iitQcA2mtcLscMT+OEzvC3R17vZa7BXJBp365co4Jtay77TlgfEM
         pvuGgNlLiW9kr1OKSgPyvFHpTI9qa/Hdpv4oaDCYE3Dj53xiBnmgZ2eALMVItQ9GcP++
         BK3sXO91n9K+0P/eBoGKDpbdqSiSgN2RZH1hHhur6tagGbuCInuZpy7rdKeyRYS30b4A
         QjBx6k3XfN7BYqrhGQ1S1M9bOsBT1s1GOnaaNxEwnAVfeo26JMAJ05lhiXky0c/Gd2Cb
         UeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901692; x=1780506492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHAbIBOe3Gsbuk1qhmrF0rf8qzMpDcWVUgQaeCjlWyA=;
        b=tZO3BNjbqnQumBxJcMGLJE+c2YlZwfxyP6GcUlHpqgKV+8HZPj7Y/fT8QYtY2C7n8i
         rCWAAgDUwlRFExSsuKeenTnH4LhaucLd8TcHs5xKxnetY6DHoI7ak/4LOKBA/rYNozvY
         SzS0ow/vBL2fiG3JeiHbbrCpQ/P8JqpsMQUfTbA7GxoLybeE6BJ+LMqGgAxIW29vEJ7E
         +t1giQlTASzMJ3Z3Uq0cjRjtBG6WalMoa05Zvz1YWp/SmCl3m2UvMFIOdlwezRv/nRGN
         UfJidVFHd22yhTcmvanf23y8VQuFZvh9LL9cRRTcE4N1ZKSWCF48w/bT60ECIY9TOmHh
         b/lg==
X-Forwarded-Encrypted: i=1; AFNElJ9AgWxdRWRJB8tdpm2aLXMRtA11v/a4sMvXbN0A+08M5uGFAMiT9g7lM1FcCVyCtdXVRli17Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0ZCn6BZxZubR1UFIGD6kJwv6bkmbkt4xrQJXLFHM+YtmMyIT
	9+m4pHKG4nOuKCk9LiyMnd5ZHhes3Qo0IwfW25RSXxqcLVVRu3x1Ickj
X-Gm-Gg: Acq92OH10EdkVDodulUPD0eveHGDIViQJJFwYwtEBqGLt5uJbIShd/VPMa0+PC19Odo
	LdBM5gK1KjKVuVgFkWF0pKXg4iLlT2rio+uAfDYiykFVBiQPuicv1syZa19mmxb8Ux+zTBd1CX3
	K4iEa9ntXBwmxjSBt08k8mVfhgx+QviqqPxm5BCsI4pFJJ7qp1EfRcVkEAiAN4mPQZiMOWzgiYf
	YNeFhRMkt71BjJ9dylyjArCCPEu2hnPJ9yHG8M0grcBuTE2OTNEFzYEokNjLepG8erIAv1PJvSC
	aig3XqYAhelChaR3C9yAp6ossT1IqVWsOEcXsoY2/Y/Ehv6WU2acZBFIYU29sTUH++HEBPFC7AX
	I6IPfP5LMRUhoc2TYqvswDF3eDzKT2cAZX/MyskoblqlfkWDZgSRDHovKqj1yHchPFrxZ82nl1R
	tlvgF8bE5kTgXB5Szsd4keqFGbPpsG2aRc74Y9Y/DQDIfy/vZOnDlQcNW8Qj6IYP6HBMqw2qTtU
	TwZmrsrQreJ8OAg9w==
X-Received: by 2002:a05:600c:4ecc:b0:490:502:8422 with SMTP id 5b1f17b1804b1-490428e2ceamr164934155e9.6.1779901691511;
        Wed, 27 May 2026 10:08:11 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb548dfasm6899862f8f.4.2026.05.27.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:08:11 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: hsr: remove VLAN filters from slave devices on port deletion
Date: Wed, 27 May 2026 10:08:04 -0700
Message-ID: <20260527170805.3376866-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254639-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75F2C5E829C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While fuzzing with a customized syzkaller, I hit a WARNING in netdevsim's
nsim_destroy(): a netdevsim port is freed while it still has a VLAN RX
filter installed (a bit left set in ns->vlan.ctag):

  WARNING: drivers/net/netdevsim/netdev.c:1205 at nsim_destroy+0x340/0x590, CPU#0: kworker/u4:5/49
  Workqueue: netns cleanup_net
  RIP: 0010:nsim_destroy+0x340/0x590
  Call Trace:
   <TASK>
   __nsim_dev_port_del+0x11d/0x1e0
   nsim_dev_reload_destroy+0x27d/0x490
   nsim_dev_reload_down+0x8e/0xc0
   devlink_reload+0x16f/0x810
   devlink_pernet_pre_exit+0x18c/0x370
   ops_undo_list+0x13a/0x8e0
   cleanup_net+0x491/0x660
   process_scheduled_works+0x8ff/0x1350
   worker_thread+0x9b8/0xed0
   kthread+0x359/0x440
   ret_from_fork+0x3bc/0x820
   </TASK>

It is triggered by creating an HSR device on top of a netdevsim port and
then tearing down the network namespace while the netdevsim port is still
an HSR slave. The reproducer is listed below.

The netdevsim port should have no VLAN filter left by the time it is
destroyed. It has one because of the way HSR manages VLAN filtering on
its slaves.

HSR offloads VLAN CTAG filtering to its slave devices: it advertises
NETIF_F_HW_VLAN_CTAG_FILTER and forwards every ndo_vlan_rx_add_vid() and
ndo_vlan_rx_kill_vid() to each slave by calling vlan_vid_add() or
vlan_vid_del() on it (hsr_ndo_vlan_rx_add_vid(), net/hsr/hsr_device.c).
Because the master advertises that feature, the 8021q core also installs
VID 0 on it (vlan_vid0_add(), net/8021q/vlan.c), and HSR mirrors that
onto every slave as well, so a netdevsim slave ends up carrying a VLAN
filter even when the user configured no VLAN.

HSR drops those propagated filters only from hsr_ndo_vlan_rx_kill_vid(),
which walks the slave ports that are currently attached. hsr_del_port()
detaches a slave without removing them. When a slave is removed - here
netdevsim is destroyed by the devlink reload on namespace exit while it
is still an HSR slave - the filter HSR installed is never deleted, leaks
on the slave, and trips netdevsim's destroy-time leak check.

Remove the propagated VLAN filters when a slave port is deleted, the
same way bonding and team do in their slave-release paths (see the
vlan_vids_del_by_dev() callers in drivers/net/bonding/bond_main.c and
drivers/net/team/team_core.c). The HSR_PT_SLAVE_A / HSR_PT_SLAVE_B guard
mirrors hsr_ndo_vlan_rx_add_vid(), which never propagates VIDs to the
master or interlink ports. It is also safe in the normal teardown order
(master brought down first): the master's VLAN list is already empty by
then, so vlan_vids_del_by_dev() does nothing.

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
Reproducer: https://pastebin.com/raw/V5PY9jue

 net/hsr/hsr_slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f..157533aaf 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -237,6 +237,9 @@ void hsr_del_port(struct hsr_port *port)
 	list_del_rcu(&port->port_list);
 
 	if (port != master) {
+		if (port->type == HSR_PT_SLAVE_A ||
+		    port->type == HSR_PT_SLAVE_B)
+			vlan_vids_del_by_dev(port->dev, master->dev);
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
-- 
2.43.0



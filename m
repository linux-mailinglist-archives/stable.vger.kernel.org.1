Return-Path: <stable+bounces-233724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEReGNV21WlC6gcAu9opvQ
	(envelope-from <stable+bounces-233724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:27:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88B3B509A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC26E300A609
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE31370D73;
	Tue,  7 Apr 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="X6GAkcee"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEC1A262A;
	Tue,  7 Apr 2026 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597033; cv=none; b=kwdq/Gm/MFAjZ0tMIIw9uIr863xHuxkftppAQNwtWVI6hu34Yd8yCMKO+hF5KI76afLyvqUTo0M9gBV2ITObmauDyeyh6BIJ56ES9Ey+BnC3sXVP5nO1SPiMHZwscYSreD88aGS5vzjCIugCFySUt9lzncgDrUH2SjkTrghXTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597033; c=relaxed/simple;
	bh=D2FV4mmR3Mv3FZcepcDCPIBpYElD6Alzkwfl2bNaCOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rb9ap10GDHXMazZ2vrw0Y6kKD3OjPzQU6mqEBBWa0wMaE6GYPyecwDf/E0RGZ1o26nbnP02xZeccOgWjbeJ8XkCI4RbGc8K7bUXZ2D2BctwdSAfN/sDFDirkjPELN6SfoazcWlhAJ6eSRoSkBGFA8hFTrW12nrdHUO0iOgelms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=X6GAkcee; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF9131133B5;
	Tue,  7 Apr 2026 23:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775597029; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5pruJMXvEGtxNqSK13NCzI9Ss3op0hP30Lb+hUiwnMA=;
	b=X6GAkceeZy+f+dJ3dAEHeeF/JDDZUc5v7UCEl6BLMOCP8qOvrBpZyjsBRLFh7kpeA4EmJz
	2eponU61Q/nkVDSBQLOPZmQIPRzs+d00x3DDN+J2JN7lTLHcng2JujTVL0xTJa6VAvup6S
	ltHj4Mi+D9yXnlTLopaPKgceHb80j9JaoxBF6jluD840eUnPEJYHYi2AJIskTdFcqe7/zx
	IUFc+j40i3l/xmjZn2vrRob95yfE6TOiahpKpHQqg3SYZU03OKKxus6F9mTL+OQrQqxQdt
	yyfIpkff1ixuqwnqFi0urDSNwwESpA8wuAQOn4cu+lk3+oS4Ap1cD1tWdLhB3g==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH] net: ks8851: Reinstate disabling of BHs around IRQ handler
Date: Tue,  7 Apr 2026 23:23:33 +0200
Message-ID: <20260407212344.80265-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233724-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:email,nabladev.com:mid,raritan.com:email]
X-Rspamd-Queue-Id: BD88B3B509A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
will call __local_bh_enable_ip(), which will call __do_softirq(), which
may trigger net_tx_action() softirq, which may ultimately call the xmit
callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
to lock struct ks8851_net_par .lock spinlock, which is already locked
by ks8851_irq() from which ks8851_start_xmit_par() was called. This
leads to a deadlock, which is reported by the kernel, including a trace
listed below.

Fix the problem by disabling BH around the IRQ handler, thus preventing
the net_tx_action() softirq from triggering during the IRQ handler. The
net_tx_action() softirq is now triggered at the end of the IRQ handler,
once all the other IRQ handler actions have been completed.

  __schedule from schedule_rtlock+0x1c/0x34
  schedule_rtlock from rtlock_slowlock_locked+0x538/0x894
  rtlock_slowlock_locked from rt_spin_lock+0x44/0x5c
  rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
  ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40
  netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
  dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
  sch_direct_xmit from __qdisc_run+0x20c/0x4fc
  __qdisc_run from qdisc_run+0x1c/0x28
  qdisc_run from net_tx_action+0x1f4/0x244
  net_tx_action from handle_softirqs+0x1c0/0x29c
  handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
  __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
  __netdev_alloc_skb from ks8851_irq+0x348/0x4d8
  ks8851_irq from irq_thread_fn+0x24/0x64
  irq_thread_fn from irq_thread+0x110/0x1dc
  irq_thread from kthread+0x104/0x10c
  kthread from ret_from_fork+0x14/0x28

Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/micrel/ks8851_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 8048770958d60..dadedea016fac 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -316,6 +316,7 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	unsigned int status;
 	struct sk_buff *skb;
 
+	local_bh_disable();
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
@@ -381,6 +382,7 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_RXI)
 		while ((skb = __skb_dequeue(&rxq)))
 			netif_rx(skb);
+	local_bh_enable();
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0



Return-Path: <stable+bounces-263896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWHYH6JpMWruigUAu9opvQ
	(envelope-from <stable+bounces-263896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85363690EC3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0p6qt28r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263896-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263896-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E2C9303675D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333843E49F;
	Tue, 16 Jun 2026 15:17:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062543E4B4;
	Tue, 16 Jun 2026 15:17:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623044; cv=none; b=JcIoLdm27QPcgytgeMxIpPLxfV4Ox1BvsQ/EXpQuVLLOMgi5tEPz0w9Zg2McvrEH9avXwL5D2c8POzeV6m4CN5PtI/vMkYpHryl/e0Is7lm4R/EG3Dl3usxZREthHngUuTRcU2uT/ewLBwuoeh3CTAwprWfoxUVrXZsbVnu/ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623044; c=relaxed/simple;
	bh=TJI57fZ+4EfDq/nF7kNQta449fR/Z+91k9rVojlPhS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INyEMCHWmoaQ+TwdpiQyBAZUu/P4J9A9lB/F69LV38zOcRV3c7AAilU99rPC6mroYXSIDHxhvai5OE9p1wJVfO9a2A1Kt6ajpK+7iDI/yo1a9XYXJw+RCBDds6HhjqXJEqzRIZeHaim9WvmbQKDpzZxpKCZ28u2QbqGOXbprmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0p6qt28r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C9B1F000E9;
	Tue, 16 Jun 2026 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623043;
	bh=Me28Zuw3CjkFOIDJTUhPg73qHYNBc2WcHe0KHBQxtBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0p6qt28rfwrpz4EsPTp5VpJaz/mibtUYJgvL/j+go5RUcma2845SbycCM9j8ugebG
	 WDr+2HzTb9XwLT2HWnbeSabWuKebw46Hwj1FSWJ8dm8Ejj5HhZ4s9Upzv+bj1fCzQ7
	 z6nBk29ZB18szBsMndXuzCLMu8o1S8Vo+vLx+q2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 070/378] bonding: annotate data-races arcound churn variables
Date: Tue, 16 Jun 2026 20:25:01 +0530
Message-ID: <20260616145113.806438793@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85363690EC3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b47ff80f280e18ad2310f44293cc057d9b64ff11 ]

These fields are updated asynchronously by the bonding state machine
in ad_churn_machine() while holding bond->mode_lock.

bond_info_show_slave() and bond_fill_slave_info() read them without
bond->mode_lock being held, we need to add READ_ONCE() and
WRITE_ONCE() annotations.

Note that AD_CHURN_MONITOR, AD_CHURN, and AD_NO_CHURN are defined
exclusively in (kernel private) include/net/bond_3ad.h header.

They should be moved to include/uapi/linux/if_bonding.h or userspace
tools will have to hardcode their values.

Fixes: 4916f2e2f3fc ("bonding: print churn state via netlink")
Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260603123514.388226-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_3ad.c     | 18 ++++++++++--------
 drivers/net/bonding/bond_netlink.c |  4 ++--
 drivers/net/bonding/bond_procfs.c  |  8 ++++----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index f0aa7d2f21717a..985ef66dc3331e 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1386,8 +1386,8 @@ static void ad_churn_machine(struct port *port)
 {
 	if (port->sm_vars & AD_PORT_CHURNED) {
 		port->sm_vars &= ~AD_PORT_CHURNED;
-		port->sm_churn_actor_state = AD_CHURN_MONITOR;
-		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+		WRITE_ONCE(port->sm_churn_actor_state, AD_CHURN_MONITOR);
+		WRITE_ONCE(port->sm_churn_partner_state, AD_CHURN_MONITOR);
 		port->sm_churn_actor_timer_counter =
 			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
 		port->sm_churn_partner_timer_counter =
@@ -1398,20 +1398,22 @@ static void ad_churn_machine(struct port *port)
 	    !(--port->sm_churn_actor_timer_counter) &&
 	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
 		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_actor_state = AD_NO_CHURN;
+			WRITE_ONCE(port->sm_churn_actor_state, AD_NO_CHURN);
 		} else {
-			port->churn_actor_count++;
-			port->sm_churn_actor_state = AD_CHURN;
+			WRITE_ONCE(port->churn_actor_count,
+				   port->churn_actor_count + 1);
+			WRITE_ONCE(port->sm_churn_actor_state, AD_CHURN);
 		}
 	}
 	if (port->sm_churn_partner_timer_counter &&
 	    !(--port->sm_churn_partner_timer_counter) &&
 	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
 		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_partner_state = AD_NO_CHURN;
+			WRITE_ONCE(port->sm_churn_partner_state, AD_NO_CHURN);
 		} else {
-			port->churn_partner_count++;
-			port->sm_churn_partner_state = AD_CHURN;
+			WRITE_ONCE(port->churn_partner_count,
+				   port->churn_partner_count + 1);
+			WRITE_ONCE(port->sm_churn_partner_state, AD_CHURN);
 		}
 	}
 }
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index c7d3e0602c831d..90365d3f7ebff7 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -82,10 +82,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 				goto nla_put_failure_rcu;
 
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
-				       ad_port->sm_churn_actor_state))
+				       READ_ONCE(ad_port->sm_churn_actor_state)))
 				goto nla_put_failure_rcu;
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
-				       ad_port->sm_churn_partner_state))
+				       READ_ONCE(ad_port->sm_churn_partner_state)))
 				goto nla_put_failure_rcu;
 		}
 		rcu_read_unlock();
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 0c0146b7617721..62a5b40b43a28e 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -220,13 +220,13 @@ static void bond_info_show_slave(struct seq_file *seq,
 			seq_printf(seq, "Aggregator ID: %d\n",
 				   agg->aggregator_identifier);
 			seq_printf(seq, "Actor Churn State: %s\n",
-				   bond_3ad_churn_desc(port->sm_churn_actor_state));
+				   bond_3ad_churn_desc(READ_ONCE(port->sm_churn_actor_state)));
 			seq_printf(seq, "Partner Churn State: %s\n",
-				   bond_3ad_churn_desc(port->sm_churn_partner_state));
+				   bond_3ad_churn_desc(READ_ONCE(port->sm_churn_partner_state)));
 			seq_printf(seq, "Actor Churned Count: %d\n",
-				   port->churn_actor_count);
+				   READ_ONCE(port->churn_actor_count));
 			seq_printf(seq, "Partner Churned Count: %d\n",
-				   port->churn_partner_count);
+				   READ_ONCE(port->churn_partner_count));
 
 			if (capable(CAP_NET_ADMIN)) {
 				seq_puts(seq, "details actor lacp pdu:\n");
-- 
2.53.0





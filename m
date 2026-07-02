Return-Path: <stable+bounces-271113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rYM/IziYRmpHZgsAu9opvQ
	(envelope-from <stable+bounces-271113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123B6FAC5A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JijPeJso;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271113-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271113-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB83C30DB4D1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A83AFCF6;
	Thu,  2 Jul 2026 16:45:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F23B1EFB;
	Thu,  2 Jul 2026 16:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010705; cv=none; b=JIcQyPieVbcabCj32XJPPRSIsQlmhPu/eQKV9pCO0AiNR1EXcybSUDNec2cmBeoA5OqGpadnCNxys8UyLt+adtQNXAeQN3XJDmC3669aAGKdTaKof1gaNcCqYoVqs+uM13rFiN+o4aSZWI4QsQA0LNBPw+uPmh3V2GDqPpO/Rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010705; c=relaxed/simple;
	bh=cyYmOsaEAzbe2352YFvmS8SH2TnijEcct6M+OXDW9JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av83cvNOd0rqQ69RiwLMhWpEQjNqc3F39TSbJUJuvf4XR+WlZz2s+f8G/gJjZvbOiw2xYAADvrWVBbmkLEQrKgWbFxnmGWB1DJOunsmTvTX5cAWZJdE8l83/TqlTJAJsVhmEnyNuOk2eqpC5wIEGVcgmWQ9rozF2se7Gv7Xyq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JijPeJso; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9B61F000E9;
	Thu,  2 Jul 2026 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010703;
	bh=tI3UERc3zbZkB2IXcpVxlButoOA7G3NtzVaasvcM/1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JijPeJsoSt78lD/xIkdN1mUBQv2Tyg6axaGSC3Qx4zaXF/WIAlEAAeiu20Tj4jm2Q
	 Emg6q7ubxustOsJziwXYNaPLmEC1YZKUx4QD/bnjcuDkpFVfIt4xcvIhAKfmslx8fw
	 w8lJVmVcAWbujKatZl9BxRhOHbeQD6+YynBVf7wI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 203/204] bonding: annotate data-races arcound churn variables
Date: Thu,  2 Jul 2026 18:21:00 +0200
Message-ID: <20260702155122.916738331@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271113-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3123B6FAC5A

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b47ff80f280e18ad2310f44293cc057d9b64ff11 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_3ad.c     |   18 ++++++++++--------
 drivers/net/bonding/bond_netlink.c |    4 ++--
 drivers/net/bonding/bond_procfs.c  |    8 ++++----
 3 files changed, 16 insertions(+), 14 deletions(-)

--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1348,8 +1348,8 @@ static void ad_churn_machine(struct port
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
@@ -1360,20 +1360,22 @@ static void ad_churn_machine(struct port
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
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -82,10 +82,10 @@ static int bond_fill_slave_info(struct s
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
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -220,13 +220,13 @@ static void bond_info_show_slave(struct
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




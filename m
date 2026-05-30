Return-Path: <stable+bounces-257727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFqkM1IfG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D560FE56
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199F5306466A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E333F5A0;
	Sat, 30 May 2026 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Il/v1dE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83182FDC5E;
	Sat, 30 May 2026 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161969; cv=none; b=mgeUWM+uXMykfRrJ8DyWxPCQI+EFvAgTjnFZ7TlNMCD80uNYUZAkLCXX2kFRzLKVzHx/hJcCExyD3Gri7zJCNhgnsQ6QUj6N87DGi5PhZqFcHjR3LBuVT6CAh8+oyJo3R5JuLahcVvMRVRY1GAiSYM0rnpNpuQbnFiiQQnW+4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161969; c=relaxed/simple;
	bh=O+tEGWlSxZYqmqCYwOJAenVoPe6Mg2A6vZrjGWuPUNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz4TYKN+4tgwpWUOdL9y48mbMOx8P2iFEdyNq4CZvyIFKe+k++9Wd/E7a96x149xFqmAcoU5QSsxOsueB6f1H75Vh+1I401oLtBBJopNWFoKwIxh25/iv+HlyDX4cosNbLl0vcJdesrNZ3qMY0pdLVFmMgNAaAS1NCC1jLzyEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Il/v1dE8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E420F1F00893;
	Sat, 30 May 2026 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161968;
	bh=pz0fRWX7aPfX+Br3F8I3gxt2qkKR4FdjHpU+/vyi6ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Il/v1dE8OTsD37Jsd3YgPPYyc1EYF5yahHTVTPzatgPc9xNdt0styM80EO0hHLkSw
	 RbgZAPBlOvIvTQU++UnqArczkU1u6ivPmRnsZkG84aWsJZFp7QDM4XkT/03t++cDhn
	 R0c/GXqb6daIzdBUwwp0Sg+9fGOTCxeGE9ii3W1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 781/969] bonding: print churn state via netlink
Date: Sat, 30 May 2026 18:05:05 +0200
Message-ID: <20260530160322.164960531@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257727-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7E4D560FE56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 4916f2e2f3fc9aef289fcd07949301e5c29094c2 ]

Currently, the churn state is printed only in sysfs. Add netlink support
so users could get the state via netlink.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20260224020215.6012-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->aggregator")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_netlink.c | 9 +++++++++
 include/uapi/linux/if_link.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 7e47d405d74aa..086233dce9c8d 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -29,6 +29,8 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE */
 		0;
 }
 
@@ -76,6 +78,13 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
+
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+				       ad_port->sm_churn_actor_state))
+				goto nla_put_failure;
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
+				       ad_port->sm_churn_partner_state))
+				goto nla_put_failure;
 		}
 
 		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d255239285841..d674eb4f1a90c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -968,6 +968,8 @@ enum {
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
 	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+	IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+	IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.53.0





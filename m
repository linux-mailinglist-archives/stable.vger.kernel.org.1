Return-Path: <stable+bounces-270941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NfNRAsyVRmrHZAsAu9opvQ
	(envelope-from <stable+bounces-270941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:46:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C76FA81B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tadKgdpz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270941-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270941-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A5B230A2866
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B847346A18;
	Thu,  2 Jul 2026 16:37:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBB33B6CC;
	Thu,  2 Jul 2026 16:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010252; cv=none; b=qHlcCX9M6UbbRR8+p/jeRz5Wfp5+DM+sQS1YAqtweNrRgQ4pm4jIBGnAHDr3MqR6q2ox/KutjC3H09nGsLQcuvuk2ggCex2hYzjxI8xYk88Hw1la6Ol3zMK+jp0O+bWM1P4q8A7gqqTLCgOG/dqgWkBpjLjUb4NCYDzIm0B2Co4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010252; c=relaxed/simple;
	bh=UD+5afjpwvjxecF6kIo3wi41B+Q2miQ+fDD5N2fLFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRIVa5d2bzhpYFqrSMJOxMGYICkNR339l18J8c4bWDHKMHs96LTDWDqEeZ3kgFJrHOUYCCVmi63RlAw1RhE8yixpHjUFaf3FH7W/v10h44b4T+5KkG9+VEv1gu2BenajMnw71vnWDxkBbIV/HaSJxhkPJ2oPMfpg9HHpMiiubIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tadKgdpz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E61F000E9;
	Thu,  2 Jul 2026 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010251;
	bh=KpwgAzOLeUZ2lKSxJIgeeZwN+uYIJg7CL7lPoNJNFKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tadKgdpzQzNsKMKeKMTdugSahNmMZyuHWdCVYqM7XD1sBOwcrkEGgCdQukotDKSdo
	 CDCgy3T3slnvChlqg/ZOLcxOiEVBDCRL9uL5+gV6vGZHunOiIaebNsltRhs/FBd7ui
	 JtIg3MSX7AweY+x9eWav2PUGMlUWBKxVIiBTD4Rg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Berry <kpberry@google.com>
Subject: [PATCH 6.12 038/204] Revert "net: bonding: fix use-after-free in bond_xmit_broadcast()"
Date: Thu,  2 Jul 2026 18:18:15 +0200
Message-ID: <20260702155119.454624163@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270941-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kpberry@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C88C76FA81B

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Berry <kpberry@google.com>

This reverts commit 3453882f36c40d2339267093676585a89808a73d.

There are two versions of this use-after-free fix commit: this one,
which was written to avoid taking a dependency on ce7a381697cb3 ("net:
bonding: add broadcast_neighbor option for 802.3ad"), and the original,
simpler version 2884bf72fb8f ("net: bonding: fix use-after-free in
bond_xmit_broadcast()"), which implicitly depends on the slave counting
changes in ce7a381697cb3. In both the 6.1 and 6.6 stable branches,
commit ce7a381697cb3 was included as a stable dep of c4f050ce06c56
("bonding: 3ad: implement proper RCU rules for port->aggregator"), and
the original version of this fix was subsequently applied.

For consistency, and to be able to apply both bug fixes, we should
revert this commit, apply the series for ce7a381697cb3 ("net: bonding:
add broadcast_neighbor option for 802.3ad"), and then apply
the original version of this fix, 2884bf72fb8f ("net: bonding: fix
use-after-free in bond_xmit_broadcast()").

Signed-off-by: Kevin Berry <kpberry@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5328,22 +5328,18 @@ static netdev_tx_t bond_xmit_broadcast(s
 				       struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct bond_up_slave *slaves;
+	struct slave *slave = NULL;
+	struct list_head *iter;
 	bool xmit_suc = false;
 	bool skb_used = false;
-	int slaves_count, i;
 
-	slaves = rcu_dereference(bond->all_slaves);
-
-	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
-	for (i = 0; i < slaves_count; i++) {
-		struct slave *slave = slaves->arr[i];
+	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (i + 1 == slaves_count) {
+		if (bond_is_last_slave(bond, slave)) {
 			skb2 = skb;
 			skb_used = true;
 		} else {




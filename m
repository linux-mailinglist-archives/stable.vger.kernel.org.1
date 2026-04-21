Return-Path: <stable+bounces-240159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MqVGGN752nC9QEAu9opvQ
	(envelope-from <stable+bounces-240159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:28:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438843B554
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C7E303BB19
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D383D16F9;
	Tue, 21 Apr 2026 13:24:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56D3A3E87;
	Tue, 21 Apr 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777892; cv=none; b=JHArWKLlkH6yoIpE/Jm9AKINUH954PhZyeQ4f9CcONa4/ykPmwb21oT47jQ0QjM4549dJ8pR5WPRL9pqA1cAV2gKVX9zYD/aYkfeCiapdF26CvqRY3kgB8FSJxWzla7wefRXlpmG5EmFzpG05obswdt953KNpgFoKdaAdFC6x8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777892; c=relaxed/simple;
	bh=/xu8AWmRVVuh11eqNmE0WUAxXfoJ86ZTHSflhs1t3ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rg3AITUVS6G+oXp09i95XpDrXbOFFWBhbuSptL5PlMFWio9g1+8g4a+fpGdyM/6IHgE+BgwPhlbdHaCRIFJ2vpEQYWoED7/J5LjIEnrex3pbre7vC9krOOFjiOsllVnwvSRZ7+VcWUe+yEBkthZ2dDBYAdaRvuvZwcI8+v/zeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 85D4E2338F;
	Tue, 21 Apr 2026 16:24:48 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] net/sched: act_ct: fix ref leak when switching zones
Date: Tue, 21 Apr 2026 16:24:47 +0300
Message-Id: <20260421132447.38455-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240159-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,mojatatu.com,gmail.com,vger.kernel.org,linuxtesting.org,altlinux.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,davemloft.net:email,altlinux.org:mid,altlinux.org:email]
X-Rspamd-Queue-Id: 0438843B554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

commit bcb74e132a76ce0502bb33d5b65533a4ed72d159 upstream.

When switching zones or network namespaces without doing a ct clear in
between, it is now leaking a reference to the old ct entry. That's
because tcf_ct_skb_nfct_cached() returns false and
tcf_ct_flow_table_lookup() may simply overwrite it.

The fix is to, as the ct entry is not reusable, free it already at
tcf_ct_skb_nfct_cached().

Reported-by: Florian Westphal <fw@strlen.de>
Fixes: 2f131de361f6 ("net/sched: act_ct: Fix flow table lookup after ct clear or switching zones")
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ kovalev: bp to fix CVE-2022-49183; used nf_conntrack_put(&ct->ct_general)
  instead of nf_ct_put(ct) due to the older kernel not yet having the
  conversion from the indirect call (see upstream commit 408bdcfce8df) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/sched/act_ct.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index d9748c917a50..d75f4b2b97da 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -589,22 +589,25 @@ static bool tcf_ct_skb_nfct_cached(struct net *net, struct sk_buff *skb,
 	if (!ct)
 		return false;
 	if (!net_eq(net, read_pnet(&ct->ct_net)))
-		return false;
+		goto drop_ct;
 	if (nf_ct_zone(ct)->id != zone_id)
-		return false;
+		goto drop_ct;
 
 	/* Force conntrack entry direction. */
 	if (force && CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL) {
 		if (nf_ct_is_confirmed(ct))
 			nf_ct_kill(ct);
 
-		nf_conntrack_put(&ct->ct_general);
-		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-
-		return false;
+		goto drop_ct;
 	}
 
 	return true;
+
+drop_ct:
+	nf_conntrack_put(&ct->ct_general);
+	nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
+
+	return false;
 }
 
 /* Trim the skb to the length specified by the IP/IPv6 header,
-- 
2.50.1



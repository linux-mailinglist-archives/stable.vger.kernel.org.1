Return-Path: <stable+bounces-258767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8La9BGUrG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A17611A91
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D0823004433
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2A17555;
	Sat, 30 May 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uC8Rm7YZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC72219303;
	Sat, 30 May 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165470; cv=none; b=Ke8/55gdRq/wx9/HsGr6y2t9J/ass8GgfDPXE3HfLi4q0IQssfFjwYGrlsrNnpNgGp5Upd07QKuV0SibamWtwzn33GLHEO/91l45VEB01m8PU3lSMnUCCdAyso5ItHe56rRfMiouY7Ghd0KxIQFXKLwp8o7eA0TzWWiDUzrdQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165470; c=relaxed/simple;
	bh=9i397wQPDcq6v3Mh4D90KyoWhqAsAvRaU7rRToxDseA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKYUMGlLS9Hh3yb73HaNVyjZ1rjmmcEf7SfqLhatHjUbPL953+8zSoGKYluXU0JaBpqWkotk5gH0LJ4go3MSGLkjoMZHHMYCkrt/bFZJZZKgAmZoZ/pdgMEFIKejAEw++fy0wJmos+gRGEtFG5aj34Lt13pN41CWqqnMGWPi5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uC8Rm7YZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC59E1F00893;
	Sat, 30 May 2026 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165469;
	bh=F8TcH6DzrfjhwYvvXgUl4KheEoNYXbW2elaUM1WdNqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uC8Rm7YZjOYi7RuUxhFWmiXsAPZyKHx8lmnWVLp06ELRWVMgyyBZqHUOQ+OVuCsTW
	 vC+hszzL/klBIlXFDV5nrHJSz5ERyeEVzuS2JChQoRfuOBe4VfBTFSlpPYx9JmjU77
	 rGuUBPN90zrdouPtEO/2IwgwyArZQA557PBFlSxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 087/589] net/sched: act_ct: fix ref leak when switching zones
Date: Sat, 30 May 2026 17:59:28 +0200
Message-ID: <20260530160226.957792863@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258767-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,strlen.de,gmail.com,davemloft.net,altlinux.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:email,davemloft.net:email]
X-Rspamd-Queue-Id: 37A17611A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index d9748c917a503..d75f4b2b97daa 100644
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
2.53.0





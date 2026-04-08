Return-Path: <stable+bounces-234796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBpfFDmi1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C843C16F1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82E373019393
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA13D9037;
	Wed,  8 Apr 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/0WJqbh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7953D9025;
	Wed,  8 Apr 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673784; cv=none; b=Q4ieB9peSGbDqE/Sz0uYDYuD5L3xIdCkxDYmSj9LWYj1bG16ugt46PKUaf12Xu1gDgNMBOA51/cahWSum1uoQk74aSQM92CN6Z9p3ANnrwf1mOiL9oEHO+QtCaXWR5FL4cagSSTerSb6iFADskkFV+1ffdFfN/QosEBG33/1Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673784; c=relaxed/simple;
	bh=8usIgmCKsRxWeYUoGbZyih4BpgNZSe5+njwWooxmmTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbQ6GO4/0jsZhm6r2Ru/XUjgUV0jTu4pwqGb/oROlL5KaMtEzzLZ5Z7hHplwACrSkphXMg7dG5ojuV16mghnRjOSUZbu99WSYfm75s1Rhm2ls/viq0vG8x9bcitOHrLMK0+k7rV+fA52CX6Zmc7Ep+MoeSwtRUoampG8swYHGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/0WJqbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F8C19421;
	Wed,  8 Apr 2026 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673784;
	bh=8usIgmCKsRxWeYUoGbZyih4BpgNZSe5+njwWooxmmTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/0WJqbhmij9JVSiqT74/gTYoe570JhNqHEkraGIHWGZLQZur6B2p+/4ntBH5vgiG
	 g2p4I08VHaAoaMvg3zpz7t4LiArrtri0SQqwvHnAlZt7PdLpt9tVD60STi9SLcPLTj
	 vpVCVNdL2HPySSmhJvt6p3GDsbHUW50EU5VncJX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/242] netfilter: ipset: use nla_strcmp for IPSET_ATTR_NAME attr
Date: Wed,  8 Apr 2026 20:01:51 +0200
Message-ID: <20260408175929.740973822@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234796-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,e.id:url,netfilter.org:email]
X-Rspamd-Queue-Id: 60C843C16F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit b7e8590987aa94c9dc51518fad0e58cb887b1db5 ]

IPSET_ATTR_NAME and IPSET_ATTR_NAMEREF are of NLA_STRING type, they
cannot be treated like a c-string.

They either have to be switched to NLA_NUL_STRING, or the compare
operations need to use the nla functions.

Fixes: f830837f0eed ("netfilter: ipset: list:set set type support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set.h | 2 +-
 net/netfilter/ipset/ip_set_core.c      | 4 ++--
 net/netfilter/ipset/ip_set_list_set.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index e9f4f845d760a..b98331572ad29 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -309,7 +309,7 @@ enum {
 
 /* register and unregister set references */
 extern ip_set_id_t ip_set_get_byname(struct net *net,
-				     const char *name, struct ip_set **set);
+				     const struct nlattr *name, struct ip_set **set);
 extern void ip_set_put_byindex(struct net *net, ip_set_id_t index);
 extern void ip_set_name_byindex(struct net *net, ip_set_id_t index, char *name);
 extern ip_set_id_t ip_set_nfnl_get_byindex(struct net *net, ip_set_id_t index);
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index cc20e6d56807c..a4e1d7951b2c6 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -821,7 +821,7 @@ EXPORT_SYMBOL_GPL(ip_set_del);
  *
  */
 ip_set_id_t
-ip_set_get_byname(struct net *net, const char *name, struct ip_set **set)
+ip_set_get_byname(struct net *net, const struct nlattr *name, struct ip_set **set)
 {
 	ip_set_id_t i, index = IPSET_INVALID_ID;
 	struct ip_set *s;
@@ -830,7 +830,7 @@ ip_set_get_byname(struct net *net, const char *name, struct ip_set **set)
 	rcu_read_lock();
 	for (i = 0; i < inst->ip_set_max; i++) {
 		s = rcu_dereference(inst->ip_set_list)[i];
-		if (s && STRNCMP(s->name, name)) {
+		if (s && nla_strcmp(name, s->name) == 0) {
 			__ip_set_get(s);
 			index = i;
 			*set = s;
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index db794fe1300e6..83e1fdcc752d6 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -367,7 +367,7 @@ list_set_uadt(struct ip_set *set, struct nlattr *tb[],
 	ret = ip_set_get_extensions(set, tb, &ext);
 	if (ret)
 		return ret;
-	e.id = ip_set_get_byname(map->net, nla_data(tb[IPSET_ATTR_NAME]), &s);
+	e.id = ip_set_get_byname(map->net, tb[IPSET_ATTR_NAME], &s);
 	if (e.id == IPSET_INVALID_ID)
 		return -IPSET_ERR_NAME;
 	/* "Loop detection" */
@@ -389,7 +389,7 @@ list_set_uadt(struct ip_set *set, struct nlattr *tb[],
 
 	if (tb[IPSET_ATTR_NAMEREF]) {
 		e.refid = ip_set_get_byname(map->net,
-					    nla_data(tb[IPSET_ATTR_NAMEREF]),
+					    tb[IPSET_ATTR_NAMEREF],
 					    &s);
 		if (e.refid == IPSET_INVALID_ID) {
 			ret = -IPSET_ERR_NAMEREF;
-- 
2.53.0





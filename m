Return-Path: <stable+bounces-256153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGs0KEuqGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B345F99B8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 524AD30A4050
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547A34B19F;
	Thu, 28 May 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQxL9x8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DE33A9FC;
	Thu, 28 May 2026 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000904; cv=none; b=llHzSBpvqBtXALer3o7wfKR+z51RLyRDAEP+NsQTQB+TA6tS42qWcjkWDv4VdOJuBzz5VGVgI/8SwSSRxVa+gQRAg37hctRT0+dbboqdoV7MjW02xSW1ttF0SXBFI4UWlHpd1K99O+1Tsw43E4JAiBN2nxtwj6gHtZiASvxgx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000904; c=relaxed/simple;
	bh=EtMWcq4ITbXUtGdwb8wFAmBILgvkk7vk19Aax76qYJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT+KVmPBgdcXBlwyz+FWHXKSoqQNMakaQ3fFX7iTb506RkxIw2DR/cDmUVjf+QSMhVKMEaoDrf3L3oGCca5o53Bvx7IEWXE2QxsBrNrxKZw/gql9/J0BLlv8YajLhpnXbkTOmgydCsV5cLrrPyrX547rIaqQ5So+nU79yuClZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQxL9x8G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF64F1F000E9;
	Thu, 28 May 2026 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000903;
	bh=ngalsQphrjPJjZ8+iXapbm9Erk2V/uAxG7OkVrMq4zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQxL9x8G4n6l31qpEXfVJ0sQiIayd6kBsKK7DNF73V5hLGP7hRJd4toXu+8uYBrlp
	 I3NV1T9hVTFz/0Stx0SR03yIEXINjzZzvJwEvvLZdyRe61Y/6E46nCXvHu0u73JcOs
	 hDcNSOqOIl1zJLqm9dtJ5VR22NAt/Nb3MnCb+Pt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 174/272] netfilter: bridge: eb_tables: close module init race
Date: Thu, 28 May 2026 21:49:08 +0200
Message-ID: <20260528194634.184606386@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256153-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,strlen.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Queue-Id: 47B345F99B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 27414ff1b287ea9a2a11675149ec28e05539f3cc ]

sashiko reports for unrelated patch:
 Does the core ebtables initialization in ebtables.c suffer from a similar race?
 Once nf_register_sockopt() completes, the sockopts are exposed globally.

sockopt has to be registered last, just like in ip/ip6/arptables.

Fixes: 5b53951cfc85 ("netfilter: ebtables: use net_generic infra")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 6240bb2b5b5b7..d480a91f081d3 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2583,19 +2583,20 @@ static int __init ebtables_init(void)
 {
 	int ret;
 
-	ret = xt_register_target(&ebt_standard_target);
+	ret = register_pernet_subsys(&ebt_net_ops);
 	if (ret < 0)
 		return ret;
-	ret = nf_register_sockopt(&ebt_sockopts);
+
+	ret = xt_register_target(&ebt_standard_target);
 	if (ret < 0) {
-		xt_unregister_target(&ebt_standard_target);
+		unregister_pernet_subsys(&ebt_net_ops);
 		return ret;
 	}
 
-	ret = register_pernet_subsys(&ebt_net_ops);
+	ret = nf_register_sockopt(&ebt_sockopts);
 	if (ret < 0) {
-		nf_unregister_sockopt(&ebt_sockopts);
 		xt_unregister_target(&ebt_standard_target);
+		unregister_pernet_subsys(&ebt_net_ops);
 		return ret;
 	}
 
-- 
2.53.0





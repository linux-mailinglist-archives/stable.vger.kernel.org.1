Return-Path: <stable+bounces-234818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEWvHkul1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6BE3C215C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 790B630C69C6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265C3D669E;
	Wed,  8 Apr 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eJPizCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBB331A44;
	Wed,  8 Apr 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673842; cv=none; b=IdGZcko1L26laTy/gnqywzwdCJxKfsKWcMBQ8kdiex8Riv2GTwQG1tjQoMPeYd/5cT/iEY1JFqqOg0AF68ZE2X0iFJyfHrHvM1nYYjCJ68IAUXeQH+rV1Pp05uI1K2IcRJt2++UBAKj5G8ngJUYx6in3mv1WpK0HuAgUl78Hqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673842; c=relaxed/simple;
	bh=0cFRT2My8LI64VjZaVY9cR6L7ANszmCpFsouDcz6BhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDUoVfUj9x1TK7rPGWNr+Vetel+VAE3VTy1CgDI9nbKJvlGI2HgcAaQZ8WCmlBUm0ysGz8vdRg+eoWOEtgmGECP17NPBVWR2T3d2bTtaIew0WT4Y738oilRtnc7N+I9m8OhWMyXeWDLmUs2Pz1T3Qsp3d6KAvjsSyAz+ZwNAsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eJPizCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEB5C19421;
	Wed,  8 Apr 2026 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673842;
	bh=0cFRT2My8LI64VjZaVY9cR6L7ANszmCpFsouDcz6BhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0eJPizCI6MXwB+WIYbT+JN/ub9tgrTFFuHrNNHmBFHHx2RLIpdT0HvQfYTiFEMCDx
	 8iQIznHduRLM71aNGsgqGdzcqN1mQFw1G+5L5VEbdC866H+nuPLptHWCLLiS5WaSUj
	 SLrj5JtjJzSjkWqe87xUgRqoEhUkls8jGdhNxeww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 078/242] netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
Date: Wed,  8 Apr 2026 20:01:58 +0200
Message-ID: <20260408175930.003336966@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234818-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,asu.edu:email,netfilter.org:email]
X-Rspamd-Queue-Id: DE6BE3C215C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 3d5d488f11776738deab9da336038add95d342d1 ]

Weiming Shi says:

xt_match and xt_target structs registered with NFPROTO_UNSPEC can be
loaded by any protocol family through nft_compat. When such a
match/target sets .hooks to restrict which hooks it may run on, the
bitmask uses NF_INET_* constants. This is only correct for families
whose hook layout matches NF_INET_*: IPv4, IPv6, INET, and bridge
all share the same five hooks (PRE_ROUTING ... POST_ROUTING).

ARP only has three hooks (IN=0, OUT=1, FORWARD=2) with different
semantics. Because NF_ARP_OUT == 1 == NF_INET_LOCAL_IN, the .hooks
validation silently passes for the wrong reasons, allowing matches to
run on ARP chains where the hook assumptions (e.g. state->in being
set on input hooks) do not hold. This leads to NULL pointer
dereferences; xt_devgroup is one concrete example:

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000044: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
 RIP: 0010:devgroup_mt+0xff/0x350
 Call Trace:
  <TASK>
  nft_match_eval (net/netfilter/nft_compat.c:407)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_arp (net/netfilter/nft_chain_filter.c:61)
  nf_hook_slow (net/netfilter/core.c:623)
  arp_xmit (net/ipv4/arp.c:666)
  </TASK>
 Kernel panic - not syncing: Fatal exception in interrupt

Fix it by restricting arptables to NFPROTO_ARP extensions only.
Note that arptables-legacy only supports:

- arpt_CLASSIFY
- arpt_mangle
- arpt_MARK

that provide explicit NFPROTO_ARP match/target declarations.

Fixes: 9291747f118d ("netfilter: xtables: add device group match")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/x_tables.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index ada27e24f7021..efe7b7d71e7f7 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -501,6 +501,17 @@ int xt_check_match(struct xt_mtchk_param *par,
 				    par->match->table, par->table);
 		return -EINVAL;
 	}
+
+	/* NFPROTO_UNSPEC implies NF_INET_* hooks which do not overlap with
+	 * NF_ARP_IN,OUT,FORWARD, allow explicit extensions with NFPROTO_ARP
+	 * support.
+	 */
+	if (par->family == NFPROTO_ARP &&
+	    par->match->family != NFPROTO_ARP) {
+		pr_info_ratelimited("%s_tables: %s match: not valid for this family\n",
+				    xt_prefix[par->family], par->match->name);
+		return -EINVAL;
+	}
 	if (par->match->hooks && (par->hook_mask & ~par->match->hooks) != 0) {
 		char used[64], allow[64];
 
@@ -1016,6 +1027,18 @@ int xt_check_target(struct xt_tgchk_param *par,
 				    par->target->table, par->table);
 		return -EINVAL;
 	}
+
+	/* NFPROTO_UNSPEC implies NF_INET_* hooks which do not overlap with
+	 * NF_ARP_IN,OUT,FORWARD, allow explicit extensions with NFPROTO_ARP
+	 * support.
+	 */
+	if (par->family == NFPROTO_ARP &&
+	    par->target->family != NFPROTO_ARP) {
+		pr_info_ratelimited("%s_tables: %s target: not valid for this family\n",
+				    xt_prefix[par->family], par->target->name);
+		return -EINVAL;
+	}
+
 	if (par->target->hooks && (par->hook_mask & ~par->target->hooks) != 0) {
 		char used[64], allow[64];
 
-- 
2.53.0





Return-Path: <stable+bounces-224153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOvpKfb+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08E24A85A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BFFA3031B07
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731138A2BE;
	Tue, 10 Mar 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWDmWsK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF351389116;
	Tue, 10 Mar 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141284; cv=none; b=Gecxn7j4PioCUG5BMU/7S5Txr6HI4XvunghKkhYJs/dBu1u6bdc4qU0xSvtaVydXPEWTou0nNLFMYp8sD56GqBiSIFKSPMKdORTY/AunZeVKmu/pOvG1+hxsHqmF12uuDklcw1HFCp+v/vvW+WGYtfLG/xaERMVOghptQJKQd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141284; c=relaxed/simple;
	bh=NdV50ClC6Ia0Q0/uzFVJPmUDgjdqiWQVks4+QSZm1xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwL2ap3+SSZzDBgHOmFAhPhanehu2aUsNoMMHodl1mqyQFvIg1A3EBRo5IU/6JcTfMTqRb/vHkm1hSyqt07DdvbyR7+vq4ruzcU5xuyTwUL2pwWLW3K5eclJEMWW4uUvQkz8rsFRZCy83IMENTlSY8s0TEuAoFaEt8tvf4KP2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWDmWsK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD2C19423;
	Tue, 10 Mar 2026 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141284;
	bh=NdV50ClC6Ia0Q0/uzFVJPmUDgjdqiWQVks4+QSZm1xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWDmWsK6KKlrxB/OJhbUoJT78GK+bSgP04fD4IiqEjVb7gfCs47zI10vZGYmbrNNm
	 bSDFOQZsxRwC1iH2/AGTST70PcnuqQtFrNLIXZHS7obvgohpPai7oFubEfV3wZPRId
	 THCLf2v3qT5QazlY4WNVDtuhwF6OcaDymTigabf2yKBveZ4G8CH/8mjNIFVm7hUiWh
	 /wxD/0KdEKn1fpJocZLt2IVdahuzZBkN2ZEzZRISDedJX+IJZb3biTyd2SIbvEkmQm
	 /MN65Tsp2fiuSY+0FWqxSYbIdLtHGY8bNs5mh4sO9XIo1AD+ztQVPQyYz7kMZ/xCnY
	 RxJxaqmka7V2A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Inseo An <y0un9sa@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 288/311] netfilter: nf_tables: unconditionally bump set->nelems before insertion
Date: Tue, 10 Mar 2026 07:05:35 -0400
Message-ID: <071711e271d469ca27d9637223f472c85806b650.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D08E24A85A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,gmail.com,strlen.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,strlen.de:email]
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit def602e498a4f951da95c95b1b8ce8ae68aa733a ]

In case that the set is full, a new element gets published then removed
without waiting for the RCU grace period, while RCU reader can be
walking over it already.

To address this issue, add the element transaction even if set is full,
but toggle the set_full flag to report -ENFILE so the abort path safely
unwinds the set to its previous state.

As for element updates, decrement set->nelems to restore it.

A simpler fix is to call synchronize_rcu() in the error path.
However, with a large batch adding elements to already maxed-out set,
this could cause noticeable slowdown of such batches.

Fixes: 35d0ac9070ef ("netfilter: nf_tables: fix set->nelems counting with no NLM_F_EXCL")
Reported-by: Inseo An <y0un9sa@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6d1b34a97ec7f..92fed8723b8f9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7169,6 +7169,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
+	bool set_full = false;
 	u64 expiration;
 	u64 timeout;
 	int err, i;
@@ -7455,10 +7456,18 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (err < 0)
 		goto err_elem_free;
 
+	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
+		unsigned int max = nft_set_maxsize(set), nelems;
+
+		nelems = atomic_inc_return(&set->nelems);
+		if (nelems > max)
+			set_full = true;
+	}
+
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL) {
 		err = -ENOMEM;
-		goto err_elem_free;
+		goto err_set_size;
 	}
 
 	ext->genmask = nft_genmask_cur(ctx->net);
@@ -7510,7 +7519,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
 						ue->priv = elem_priv;
 						nft_trans_commit_list_add_elem(ctx->net, trans);
-						goto err_elem_free;
+						goto err_set_size;
 					}
 				}
 			}
@@ -7528,23 +7537,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_element_clash;
 	}
 
-	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
-		unsigned int max = nft_set_maxsize(set);
-
-		if (!atomic_add_unless(&set->nelems, 1, max)) {
-			err = -ENFILE;
-			goto err_set_full;
-		}
-	}
-
 	nft_trans_container_elem(trans)->elems[0].priv = elem.priv;
 	nft_trans_commit_list_add_elem(ctx->net, trans);
-	return 0;
 
-err_set_full:
-	nft_setelem_remove(ctx->net, set, elem.priv);
+	return set_full ? -ENFILE : 0;
+
 err_element_clash:
 	kfree(trans);
+err_set_size:
+	if (!(flags & NFT_SET_ELEM_CATCHALL))
+		atomic_dec(&set->nelems);
 err_elem_free:
 	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 err_parse_data:
-- 
2.51.0



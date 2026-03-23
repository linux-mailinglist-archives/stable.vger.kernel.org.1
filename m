Return-Path: <stable+bounces-229435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHPlFpRlwWkzSwQAu9opvQ
	(envelope-from <stable+bounces-229435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C372F79E7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B6D63113083
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0F3CEB82;
	Mon, 23 Mar 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFcvm/Bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7943B4E9A;
	Mon, 23 Mar 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279228; cv=none; b=c9on+ajbzIDSpc1L2F+YzMkCn3yU0AbrPyWmde6AbS8oAgXc1+OEg/q9RKa/sUwqtSfQmugcgtxTEjmHgVpnAyijb9O/I3qlAA8Ko6ZAxvMzE5MT9IsZjFMVelLmJcYYH9hbPPoJBkwoG4EmmcXtXyuYOTg41oC2YCLs91ZJA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279228; c=relaxed/simple;
	bh=8MQmmwZ/OgnXHqh8eOcQRrB4RYT0/DS1e+4dVMiX090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7aHRJSbD9m17LLwqxps0P1d4g9q4zkuGdPYc1yXlpa/tz0V7SOhtPYhGuhgW/S9catjEgbkUG3xqr+0Hjc3bThMH4T/Y2yxA+iPHfULbDo3UGXroMA6j9ta0SNDnRLt78hDhYnKazxgL3czh8CbHJHOFvs8vjrHIAGPkw2s2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFcvm/Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91998C2BC9E;
	Mon, 23 Mar 2026 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279228;
	bh=8MQmmwZ/OgnXHqh8eOcQRrB4RYT0/DS1e+4dVMiX090=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFcvm/Bq+95BSnubVMzEBwFbto8Q5EIoRr6y9qgN2i3aL0DdKlVS6q0TU0XLfJl6F
	 oexxRh5x7QNxPbZebDf1e6+hZJ0r7KCL76yT4tHGkdE0ncthfNP1D3Mv3J2npKOcr8
	 teaRxqIdbfVfCJNkuRrF7dZfwt5X6lYKoDzLjgME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 518/567] netfilter: nft_ct: drop pending enqueued packets on removal
Date: Mon, 23 Mar 2026 14:47:18 +0100
Message-ID: <20260323134546.826629385@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,netfilter.org,strlen.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-229435-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,netfilter.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 20C372F79E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 36eae0956f659e48d5366d9b083d9417f3263ddc ]

Packets sitting in nfqueue might hold a reference to:

- templates that specify the conntrack zone, because a percpu area is
  used and module removal is possible.
- conntrack timeout policies and helper, where object removal leave
  a stale reference.

Since these objects can just go away, drop enqueued packets to avoid
stale reference to them.

If there is a need for finer grain removal, this logic can be revisited
to make selective packet drop upon dependencies.

Fixes: 7e0b2b57f01d ("netfilter: nft_ct: add ct timeout support")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_ct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 1070d68f9e77f..128eb0ac37742 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -23,6 +23,7 @@
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
+#include "nf_internals.h"
 
 struct nft_ct_helper_obj  {
 	struct nf_conntrack_helper *helper4;
@@ -527,6 +528,7 @@ static void __nft_ct_set_destroy(const struct nft_ctx *ctx, struct nft_ct *priv)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	case NFT_CT_ZONE:
+		nf_queue_nf_hook_drop(ctx->net);
 		mutex_lock(&nft_ct_pcpu_mutex);
 		if (--nft_ct_pcpu_template_refcnt == 0)
 			nft_ct_tmpl_put_pcpu();
@@ -997,6 +999,7 @@ static void nft_ct_timeout_obj_destroy(const struct nft_ctx *ctx,
 	struct nft_ct_timeout_obj *priv = nft_obj_data(obj);
 	struct nf_ct_timeout *timeout = priv->timeout;
 
+	nf_queue_nf_hook_drop(ctx->net);
 	nf_ct_untimeout(ctx->net, timeout);
 	nf_ct_netns_put(ctx->net, ctx->family);
 	kfree(priv->timeout);
@@ -1129,6 +1132,7 @@ static void nft_ct_helper_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_ct_helper_obj *priv = nft_obj_data(obj);
 
+	nf_queue_nf_hook_drop(ctx->net);
 	if (priv->helper4)
 		nf_conntrack_helper_put(priv->helper4);
 	if (priv->helper6)
-- 
2.51.0





Return-Path: <stable+bounces-228345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PPyKX1NwWmxSAQAu9opvQ
	(envelope-from <stable+bounces-228345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8972F4746
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590A13220C34
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBF3B3880;
	Mon, 23 Mar 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siecbw8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806F3ACEF1;
	Mon, 23 Mar 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274869; cv=none; b=bOZ6fFjcMxdSSZKuxTcyvojLncYzah+0Frla/lHgFa52fQtagIEWwG5oCNLZRLPSKZIpTxF9szy5P8gpXKMj5+QHmVGaepCOx7SI3N3L5XgnLAkoL5Eu51n+ESHsNv8N1M/jDQ+sLeC9YYbtULGEWTOWZod9zOeD7LC9DpysjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274869; c=relaxed/simple;
	bh=osOvGxUWGgG8G4ZUdbM8NFzvqfeUVN831SS0E2nObSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVrlwjalOg6wBW2qTP8nco5yqWct/uCbR3rDDYhBL7sZYwqs/Vlbsqwi/PZew+YuOVdI3n44iA5wUhK7Axf9w6o8Z7D/eonZ03Wv4vEQmiIXqZyqTg4eN3hZZnpzizfZquUUaTUDLwWxY+fsP/Q7jkSMI3ZY31OfFp/taj3PDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siecbw8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38500C4CEF7;
	Mon, 23 Mar 2026 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274868;
	bh=osOvGxUWGgG8G4ZUdbM8NFzvqfeUVN831SS0E2nObSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siecbw8h1grQeEE208s/wxSXC3u7e+0MGON7FPrm2kzvfvfyGZigdoZFVpl5tAWo1
	 2EEID9vkUoMomWL6GSZQNZ9ItrjXmS0+i5TQzHirdB33SOivBQPfNLWSxOFQTH9mJF
	 FlNyJDz/j+ZOAKmiIM9rjF0TvcJk493hrzXZnZiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 138/212] netfilter: nft_ct: drop pending enqueued packets on removal
Date: Mon, 23 Mar 2026 14:45:59 +0100
Message-ID: <20260323134508.135941858@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228345-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,netfilter.org,strlen.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3A8972F4746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 6f2ae7cad7310..db1bf69f87750 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -23,6 +23,7 @@
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
+#include "nf_internals.h"
 
 struct nft_ct_helper_obj  {
 	struct nf_conntrack_helper *helper4;
@@ -543,6 +544,7 @@ static void __nft_ct_set_destroy(const struct nft_ctx *ctx, struct nft_ct *priv)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	case NFT_CT_ZONE:
+		nf_queue_nf_hook_drop(ctx->net);
 		mutex_lock(&nft_ct_pcpu_mutex);
 		if (--nft_ct_pcpu_template_refcnt == 0)
 			nft_ct_tmpl_put_pcpu();
@@ -1016,6 +1018,7 @@ static void nft_ct_timeout_obj_destroy(const struct nft_ctx *ctx,
 	struct nft_ct_timeout_obj *priv = nft_obj_data(obj);
 	struct nf_ct_timeout *timeout = priv->timeout;
 
+	nf_queue_nf_hook_drop(ctx->net);
 	nf_ct_untimeout(ctx->net, timeout);
 	nf_ct_netns_put(ctx->net, ctx->family);
 	kfree(priv->timeout);
@@ -1148,6 +1151,7 @@ static void nft_ct_helper_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_ct_helper_obj *priv = nft_obj_data(obj);
 
+	nf_queue_nf_hook_drop(ctx->net);
 	if (priv->helper4)
 		nf_conntrack_helper_put(priv->helper4);
 	if (priv->helper6)
-- 
2.51.0





Return-Path: <stable+bounces-228346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEvxLIBNwWmxSAQAu9opvQ
	(envelope-from <stable+bounces-228346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D662F475B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75923322110A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949893AEF55;
	Mon, 23 Mar 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UbgFCiTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC23ACEF1;
	Mon, 23 Mar 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274871; cv=none; b=YxGcVayywSQf8/IX00RxRWt+x9oR04MH5Ge91fDqboN5I14rLpwLs4Tu5fDzTr9nTxJOyEAUun1zC62Ou/DHllWbXf7OwGPaNJAH/gCDsD+7RDY25SV2jpI+sJpv9c/kPGvTzjpj7YPSYt5hNTGSCixAEOFEFfV16fsrjmrwhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274871; c=relaxed/simple;
	bh=l9sKKAr2JxbCi+YGnbJxUwQtQSTJSqMKZx8zM3hAUgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR1vz2zLEmrTrL9JSOyWzqQ1BWQ9SkKOBVP0NlXHSs8gT82LLuZRh8b06VGR+M+IpJCznJG2Q9WIfcWDpucEkh/6UpvoSKtdQJxvzn8jNQMpPV+KAxzUcMdwlloc3wKMyZEzLIpr7lM3DfpIRgrX7yejGfutOiFiUxuS4CYFT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UbgFCiTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF57BC4CEF7;
	Mon, 23 Mar 2026 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274871;
	bh=l9sKKAr2JxbCi+YGnbJxUwQtQSTJSqMKZx8zM3hAUgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbgFCiTvY2btFf4DLOqbyAk4rlpoH6ZVzzDCUOkKKaoXjIHGVQIPtaDlq6bpaIG6n
	 aBMGu1qErBtRcZs5msD/pZLVNxjusKZ5g9izOo+rE+xGl8EWPmz7b1X55PuL2/ryqW
	 68dLRuC9kr+EQrOwelMzwqh9wmC2uNtb1kFO/Z4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 139/212] netfilter: xt_CT: drop pending enqueued packets on template removal
Date: Mon, 23 Mar 2026 14:46:00 +0100
Message-ID: <20260323134508.166321351@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228346-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,netfilter.org,strlen.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 41D662F475B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit f62a218a946b19bb59abdd5361da85fa4606b96b ]

Templates refer to objects that can go away while packets are sitting in
nfqueue refer to:

- helper, this can be an issue on module removal.
- timeout policy, nfnetlink_cttimeout might remove it.

The use of templates with zone and event cache filter are safe, since
this just copies values.

Flush these enqueued packets in case the template rule gets removed.

Fixes: 24de58f46516 ("netfilter: xt_CT: allow to attach timeout policy + glue code")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_CT.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 3ba94c34297cf..498f5871c84a0 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_zones.h>
+#include "nf_internals.h"
 
 static inline int xt_ct_target(struct sk_buff *skb, struct nf_conn *ct)
 {
@@ -283,6 +284,9 @@ static void xt_ct_tg_destroy(const struct xt_tgdtor_param *par,
 	struct nf_conn_help *help;
 
 	if (ct) {
+		if (info->helper[0] || info->timeout[0])
+			nf_queue_nf_hook_drop(par->net);
+
 		help = nfct_help(ct);
 		xt_ct_put_helper(help);
 
-- 
2.51.0





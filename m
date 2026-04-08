Return-Path: <stable+bounces-233741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN+xINqz1Wmo8wcAu9opvQ
	(envelope-from <stable+bounces-233741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:48:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891063B6150
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E15643005989
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E72E4247;
	Wed,  8 Apr 2026 01:48:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC331E1C11
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612887; cv=none; b=f3Rb84PpcSJ0RcKpeMqpNXJ22iMWNCj+3cRCHPA0nGApEB8QFsEENxCQaPdLFIZJn1++ej9Pe5FGwT2ClbzLeh0ttk/A7ENwkOITZTfGdWi5ox27CQjhhoNtMRZDGJN1JO53ylUcIv+Y3/g+eWie4F3o9tESX+m0/f/S7VsrUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612887; c=relaxed/simple;
	bh=efsM5h04QLt77TAJ2M+uqdQf9hOOuaTiLk9alNDBp9I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=K0OgjlqMc6i1nOEWt8brPcbnHKJ388VCRQCLsUfT2Uzrhz74iT73BrEyZ9QbmGeOUppBsMAwP7TLMSuspi1zbeo5jA/lHr/iD6kTnzIlBcHP/qjLxAl2DZk+F5OfmCwSjhQTHL+035u/HEZnbPsW4DqzG2najshDK1x8gyZu92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:0.686670516
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.144.79.172 (unknown [10.158.243.18])
	by mail.189.cn (HERMES) with SMTP id 4BE4C4002AA;
	Wed,  8 Apr 2026 09:43:54 +0800 (CST)
Received: from  ([39.144.79.172])
	by gateway-153622-dep-76cc7bc9cd-8dbpn with ESMTP id 7cc9a9f39f6a4816ae8c5c17136e4bcd for stable@vger.kernel.org;
	Wed, 08 Apr 2026 09:43:56 CST
X-Transaction-ID: 7cc9a9f39f6a4816ae8c5c17136e4bcd
X-Real-From: charles_xu@189.cn
X-Receive-IP: 39.144.79.172
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: Charles Xu <charles_xu@189.cn>
To: stable@vger.kernel.org,
	pablo@netfilter.org,
	yimingqian591@gmail.com,
	fw@strlen.de
Subject: [PATCH 5.15.y] netfilter: xt_CT: drop pending enqueued packets on template removal
Date: Wed,  8 Apr 2026 09:43:53 +0800
Message-Id: <20260408014353.3046-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-233741-lists,stable=lfdr.de];
	DMARC_NA(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,netfilter.org,gmail.com,strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:email,strlen.de:email]
X-Rspamd-Queue-Id: 891063B6150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 net/netfilter/xt_CT.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 5d19cb059b19..3dd02482b437 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_zones.h>
+#include "nf_internals.h"
 
 static inline int xt_ct_target(struct sk_buff *skb, struct nf_conn *ct)
 {
@@ -269,6 +270,9 @@ static void xt_ct_tg_destroy(const struct xt_tgdtor_param *par,
 	struct nf_conn_help *help;
 
 	if (ct) {
+		if (info->helper[0] || info->timeout[0])
+			nf_queue_nf_hook_drop(par->net);
+
 		help = nfct_help(ct);
 		if (help)
 			nf_conntrack_helper_put(help->helper);
-- 
2.35.3



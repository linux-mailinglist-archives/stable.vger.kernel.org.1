Return-Path: <stable+bounces-252831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA6XOaL+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB15969BA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E3D33101F68
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1E371048;
	Wed, 20 May 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dM4gn52j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADE3F7ABC;
	Wed, 20 May 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301703; cv=none; b=pfUbM8FbNPNti3iUkvOeGKF4PvFMix5BHGGtGxmA4qSy+tQ9R8yNv5/7+rXtsI+1uMqdij3Ll+/mlzlAfv+sOKXdJJhH/+bLjDW04QsUo7vnom3IoEW0Ght5qQykFw2+u/aim/A1lUUICBLvwwHHdjXB4KJLBQq54RGCDDr8Xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301703; c=relaxed/simple;
	bh=It9YfZcBTt5ozID7Jfg83bD12PXHu8ijwuV6KoKwm6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/sCv1KHXqoEkrfe1Lq2dQjlsrjRcg/Ykgx1yxFhclyqMXF5yzNhUGzXgjng+aiqmX1VHyA44peoCNuJgpVUcXL91tgXfSWIvJ4nL0lfqnGmdZACaLgWLPRf9tWqG7nO5waDJXY8jahtnItuyvZqcWl04CiGArkzCPHJlZcuKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dM4gn52j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C675F1F000E9;
	Wed, 20 May 2026 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301702;
	bh=IjJ553zKZ/LYNyCN4ogHGtRo5aYwdVvyAOdsvuRrAYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dM4gn52jrONQ7dfDHhfVH3aaoEyh3PGm7Vq6z/6bISpfh+jLBVEnnFOqXKgjxmdV8
	 ZkIN3crJDLeyR7uGGqGdFGeeqgEFRCV84pvmgT7nzsoiRo5jBhiWvtoh+lNMoazR6V
	 GVE8MoSJ4bMViCCXiFaDU9NK1FuVfwxsAlP7LoQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Xiasong <lixiasong1@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.12 613/666] netfilter: nf_conntrack_sip: get helper before allocating expectation
Date: Wed, 20 May 2026 18:23:44 +0200
Message-ID: <20260520162124.557608413@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252831-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,netfilter.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8CDB15969BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Xiasong <lixiasong1@huawei.com>

commit eb6317739b1ea3ab28791e1f91b24781905fa815 upstream.

process_register_request() allocates an expectation and then checks
whether a conntrack helper is available. If helper lookup fails, the
function returns early and the allocated expectation is left behind.

Reorder the code to fetch and validate helper before calling
nf_ct_expect_alloc(). This keeps the logic simpler and removes the leak
path while preserving existing behavior.

Fixes: e14575fa7529 ("netfilter: nf_conntrack: use rcu accessors where needed")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_sip.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1367,6 +1367,10 @@ static int process_register_request(stru
 		goto store_cseq;
 	}
 
+	helper = rcu_dereference(nfct_help(ct)->helper);
+	if (!helper)
+		return NF_DROP;
+
 	exp = nf_ct_expect_alloc(ct);
 	if (!exp) {
 		nf_ct_helper_log(skb, ct, "cannot alloc expectation");
@@ -1377,10 +1381,6 @@ static int process_register_request(stru
 	if (sip_direct_signalling)
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 
-	helper = rcu_dereference(nfct_help(ct)->helper);
-	if (!helper)
-		return NF_DROP;
-
 	nf_ct_expect_init(exp, SIP_EXPECT_SIGNALLING, nf_ct_l3num(ct),
 			  saddr, &daddr, proto, NULL, &port);
 	exp->timeout.expires = sip_timeout * HZ;




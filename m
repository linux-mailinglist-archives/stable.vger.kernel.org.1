Return-Path: <stable+bounces-264840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZsgKlh9MWrLkgUAu9opvQ
	(envelope-from <stable+bounces-264840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA2969265B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cviYj3zZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264840-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264840-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E84430398B4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690F4779B1;
	Tue, 16 Jun 2026 16:42:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B328610;
	Tue, 16 Jun 2026 16:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628166; cv=none; b=R1jOY+tckoE6cGGFoW3q6iM5+ANXmNryxLk5rE4eFOkZAMdGxXioRiCda5cDa8UP9Ly86LmznuFHyvWuEXHsQquEeii8pb9t00qLPxyzYi4I7NuzMql+fosfErJz2g+u+MVbExESWS8RDmwEInbNAq5Njh2qAxhwWPQ6zkqzVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628166; c=relaxed/simple;
	bh=q3VXbqYUTV4wqTcmC1q+VcubCCRMRAOfG1Vf+qW6tRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqoqn4i1hmH3+QHHZYJp9yUic35xpUzuyKWHV8sl7OcHSUlAiZ25MIGWqd5JT+ToOLXPWi+YG6Jrj/9ObHQKN02xzrmUGaE+MvvqMhqhzQE5q1n0cWXa9Po0sqSzenE+jqkTUUXjHZ/NA/EQ3+wGvZyVwCrOL4uOBNRhFJ9p7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cviYj3zZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5464C1F00A3A;
	Tue, 16 Jun 2026 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628165;
	bh=neEJK5SDAORcQ2JA6KX9XHpmxQh4xYbCtjX7lrPpa3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cviYj3zZtn8ACuTkisjo++cZ+OvyK//22yaNyqoDv06Uc/a6bjrQiCs6atcnKet5P
	 zCJ+eJvbEqMafJ38LEIhqX6rHSC2O09wssN0395FVUIZIP0yTnb4PHT8YgbIXpjWjP
	 9N9iGHH+HJfAYKOUiiM1alVCdIt9HU2iRyvsuDT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxiao Xu <rakukuip@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 014/452] netfilter: ebtables: fix OOB read in compat_mtw_from_user
Date: Tue, 16 Jun 2026 20:24:01 +0530
Message-ID: <20260616145118.555665929@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-264840-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:rakukuip@gmail.com,m:n05ec@lzu.edu.cn,m:fmancera@suse.de,m:fw@strlen.de,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,suse.de,strlen.de,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:email,vger.kernel.org:from_smtp,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DA2969265B

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f438d1786d657d57790c5d138d6db3fc9fdac392 ]

Luxiao Xu says:

 The function compat_mtw_from_user() converts ebtables extensions from
 32-bit user structures to kernel native structures. However, it lacks
 proper validation of the user-supplied match_size/target_size.

 When certain extensions are processed, the kernel-side translation
 logic may perform memory accesses based on the extension's expected
 size. If the user provides a size smaller than what the extension
 requires, it results in an out-of-bounds read as reported by KASAN.

 This fix introduces a check to ensure match_size is at least as large
 as the extension's required compatsize. This covers matches, watchers,
 and targets, while maintaining compatibility with standard targets.

AFAIU this is relevant for matches that need to go though
match->compat_from_user() call.  Those that use plain memcpy with the
user-provided size are ok because the caller checks that size vs the
start of the next rule entry offset (which itself is checked vs. total
size copied from userspace).

The ->compat_from_user() callbacks assume they can read compatsize bytes,
so they need this extra check.

Based on an earlier patch from Luxiao Xu.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f99e348c8f37fa..bc69406d103df6 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1952,6 +1952,25 @@ enum compat_mwt {
 	EBT_COMPAT_TARGET,
 };
 
+static bool match_size_ok(const struct xt_match *match, unsigned int match_size)
+{
+	u16 csize;
+
+	if (match->matchsize == -1) /* cannot validate ebt_among */
+		return true;
+
+	csize = match->compatsize ? : match->matchsize;
+
+	return match_size >= csize;
+}
+
+static bool tgt_size_ok(const struct xt_target *tgt, unsigned int tgt_size)
+{
+	u16 csize = tgt->compatsize ? : tgt->targetsize;
+
+	return tgt_size >= csize;
+}
+
 static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 				enum compat_mwt compat_mwt,
 				struct ebt_entries_buf_state *state,
@@ -1977,6 +1996,11 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 		if (IS_ERR(match))
 			return PTR_ERR(match);
 
+		if (!match_size_ok(match, match_size)) {
+			module_put(match->me);
+			return -EINVAL;
+		}
+
 		off = ebt_compat_match_offset(match, match_size);
 		if (dst) {
 			if (match->compat_from_user)
@@ -1996,6 +2020,12 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 					    mwt->u.revision);
 		if (IS_ERR(wt))
 			return PTR_ERR(wt);
+
+		if (!tgt_size_ok(wt, match_size)) {
+			module_put(wt->me);
+			return -EINVAL;
+		}
+
 		off = xt_compat_target_offset(wt);
 
 		if (dst) {
-- 
2.53.0





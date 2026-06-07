Return-Path: <stable+bounces-261090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0v8HcBFJWp7FgIAu9opvQ
	(envelope-from <stable+bounces-261090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6A64F876
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bDV0kMb+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261090-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261090-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B267A3033A9B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A70308F0A;
	Sun,  7 Jun 2026 10:13:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FA1E98EF;
	Sun,  7 Jun 2026 10:13:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827228; cv=none; b=a20HtzgtE4V6ue5KrVOFy/gCd2toLRdEWGvT4Ru1NrIjXAdZe+fd4W4mCSJ6gnWqgk1gpGeBBCmt8h01pC4Klfb8m4/SUQ3RfNYEWidYDoeYmobQLMlUOtgm/T6o7+3i499DdASrL46vfYbWppmzUA0bBmiyw5s5kbIHSZiGZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827228; c=relaxed/simple;
	bh=yOTUJ701o92C36v9v6SYKKFJYvMVq6xfkgvJt9oeVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4Twl7ooU9wH86u6Y7tvAcr5hrv8uMtVYTrUKuK8Ug/pj5GdYWLB1DhAAeV08Jq+PXPq7hlYdiOaw48JhfwuQ4q50ylCP+bmQB+4wCw5WO3+kGe8loTGm4NTufSALs6V0skgIK8f7n43LnsBPazOojAIe+yF+wplKUPH7/0g8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDV0kMb+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72D21F00893;
	Sun,  7 Jun 2026 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827227;
	bh=fG18IfQ+j5w1g+7rcmKM+knY1BXyLS7n1gFrHyg2k6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDV0kMb+BqvpTNfDIdKjhXUYX/LZKWUbxhUcwm2WAJxbm59RH7+uXicJzjaoy+c+P
	 j24Y9KwpiI5Qq8ety8Hi8+5g6gLbfR+2l+Z1YU0NksdPmP1e36kdRaVQKqsUqnKUT0
	 vieIcI9hMcw7ZGxL+QaL9LfdXb1v3n6Mn9uRMmkg=
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
Subject: [PATCH 6.12 033/307] netfilter: ebtables: fix OOB read in compat_mtw_from_user
Date: Sun,  7 Jun 2026 11:57:10 +0200
Message-ID: <20260607095728.882217541@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-261090-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:rakukuip@gmail.com,m:n05ec@lzu.edu.cn,m:fmancera@suse.de,m:fw@strlen.de,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,suse.de,strlen.de,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,suse.de:email,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4B6A64F876

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index a461c59ad28595..1bc7b5d8f76d7a 100644
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





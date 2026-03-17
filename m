Return-Path: <stable+bounces-226376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMLsJBaKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C22AEF14
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590A731DA24E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A23F23AA;
	Tue, 17 Mar 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTFTsjPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9853F23B3;
	Tue, 17 Mar 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766425; cv=none; b=S+aChyWMr1jyS7LnX8ycvADZagt80oohj3Y+0+WJUfXJ77/Skw+IGdcHjbfSXSRPTXjCnnTVYdf8FyuMGCasWq+OeoI29uuhd9sV+TBRvD09qaw9W+Cyr6wOy3yGjBteDh/UAo8rTWo0ZRsetq1ttO33zGfrp05TlCZx6CUdYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766425; c=relaxed/simple;
	bh=kBYZeSiRxcVhe6HbbzYFQtU2HtqxHwKPcAMg1HlP9OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQXsiQb/7cTornCeGkfcECGcd+jxF/o8NHwi8hNNKfGTsfoWTNJvuixBeOSrFTj8xCsK1yS4rTXYaiio4Y1O54ep7djSON7y5hWEJnDrZWBjgnJ19gDtZArjY8u2I61p7h3AyCzssvmaZFuJdYle+4mw1SdjA65NHp8IGlIJT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTFTsjPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9796FC4CEF7;
	Tue, 17 Mar 2026 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766425;
	bh=kBYZeSiRxcVhe6HbbzYFQtU2HtqxHwKPcAMg1HlP9OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTFTsjPV07+sgNxxx5MU1BfCPlTjG7W7CUl/RMFvD+C4HbntsjnqfQgzTijEgViVX
	 eQsL37/cnKJ/AV1mdFCkesZpHWoH/Pgu7pBFA0RqkNG8AaRgApLq7heHCErjXA8vbx
	 gHogI/akn8HsaQQcd84BHdmIVqG6cE3KyU+kO61A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.19 244/378] nstree: tighten permission checks for listing
Date: Tue, 17 Mar 2026 17:33:21 +0100
Message-ID: <20260317163015.995600371@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226376-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 008C22AEF14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 8d76afe84fa2babf604b3c173730d4d2b067e361 upstream.

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Link: https://patch.msgid.link/20260226-work-visibility-fixes-v1-3-d2c2853313bd@kernel.org
Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org # v6.19+
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/nstree.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index f36c59e6951d..6d12e5900ac0 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -515,32 +515,11 @@ static inline bool __must_check ns_requested(const struct klistns *kls,
 static inline bool __must_check may_list_ns(const struct klistns *kls,
 					    struct ns_common *ns)
 {
-	if (kls->user_ns) {
-		if (kls->userns_capable)
-			return true;
-	} else {
-		struct ns_common *owner;
-		struct user_namespace *user_ns;
-
-		owner = ns_owner(ns);
-		if (owner)
-			user_ns = to_user_ns(owner);
-		else
-			user_ns = &init_user_ns;
-		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN))
-			return true;
-	}
-
+	if (kls->user_ns && kls->userns_capable)
+		return true;
 	if (is_current_namespace(ns))
 		return true;
-
-	if (ns->ns_type != CLONE_NEWUSER)
-		return false;
-
-	if (ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))
-		return true;
-
-	return false;
+	return may_see_all_namespaces();
 }
 
 static inline void ns_put(struct ns_common *ns)
@@ -600,7 +579,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 
 	ret = 0;
 	head = &to_ns_common(kls->user_ns)->ns_owner_root.ns_list_head;
-	kls->userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
+	kls->userns_capable = may_see_all_namespaces();
 
 	rcu_read_lock();
 
-- 
2.53.0





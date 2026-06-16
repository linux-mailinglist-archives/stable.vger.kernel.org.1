Return-Path: <stable+bounces-266334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OM3oDSubMWpMoAUAu9opvQ
	(envelope-from <stable+bounces-266334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:51:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA46694857
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=16wdw4Zp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266334-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266334-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 479C1300A587
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE89472798;
	Tue, 16 Jun 2026 18:51:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE634FF79;
	Tue, 16 Jun 2026 18:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635878; cv=none; b=Jgf092lhACMDg3JBVaOo4bV6O8BJw5bRrPEiBSjXs/GdpA50TYWB+DAMefbBJwNOT+F1pSkzAwncxAAhi9FdR+F/1kGwB1LrVQblh0GFaj1FozQrs66OGT4nX/PgQLufwVlWI4RDUx7AY7JpJ8Z5BpyJUCJ9sRYGL5rYNvwMLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635878; c=relaxed/simple;
	bh=/mOm+Xol7C5ihxnXhMmkjKbC9QimwKk2XhVdva2BPjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4BZ3g0xx3DKFbuQEpIct4/1uvFxvd29Z9r5naLuYF/04eFF/ea1PiGCLnAfzJyPCKOtsgVTx/aPJtEaLC+W90OD+V8TmP4iiY6v9b/XjVabeHPjk0YXEnPPBBV8eqTu6qKZ2J8pCmAg22wNDZ9MTkqIWmD4TNjwfmXfiqWN77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=16wdw4Zp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1087A1F000E9;
	Tue, 16 Jun 2026 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635876;
	bh=E4wZy4NmoZLr3t5QhVw0XooIXNfvD991dYlWKa1Ve+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=16wdw4ZpzzZfG6xgC45KVMIl1StskFKQ3WZCxQclLXdDgT0g/Vdqr4TJkgzeS885E
	 y9N+SNn98SAIiutLN61btgBDcZq+7MitFDwQkB3X+2KehodBkOaa64iHYZpRuCbRVX
	 mYTw9OwinfbsCgyjrSiK4V/M5nzkhB/49/C9aCio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/342] ipvs: clear the svc scheduler ptr early on edit
Date: Tue, 16 Jun 2026 20:27:09 +0530
Message-ID: <20260616145054.389927129@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266334-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ja@ssi.bg,m:fw@strlen.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,netfilter.org:email,vger.kernel.org:from_smtp,sashiko.dev:url,strlen.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ssi.bg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA46694857

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 193989cc6d80dd8e0460fb3992e69fa03bf0ff9b ]

ip_vs_edit_service() while unbinding the old scheduler clears
the svc->scheduler ptr after the scheduler module initiates
RCU callbacks. This can cause packets to use the old
scheduler at the time when svc->sched_data is already freed
after RCU grace period.

Fix it by clearing the ptr early in ip_vs_unbind_scheduler(),
before the done_service method schedules any RCU callbacks.

Also, if the new scheduler fails to initialize when replacing
the old scheduler, try to restore the old scheduler while still
returning the error code.

Link: https://sashiko.dev/#/patchset/20260519015506.634185-1-rosenp%40gmail.com
Fixes: 05f00505a89a ("ipvs: fix crash if scheduler is changed")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_vs.h              |  3 +--
 net/netfilter/ipvs/ip_vs_ctl.c   | 13 ++++++++-----
 net/netfilter/ipvs/ip_vs_sched.c | 14 +++++++-------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index c02c3bb0fe091d..7891c17ff8b688 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1396,8 +1396,7 @@ int register_ip_vs_scheduler(struct ip_vs_scheduler *scheduler);
 int unregister_ip_vs_scheduler(struct ip_vs_scheduler *scheduler);
 int ip_vs_bind_scheduler(struct ip_vs_service *svc,
 			 struct ip_vs_scheduler *scheduler);
-void ip_vs_unbind_scheduler(struct ip_vs_service *svc,
-			    struct ip_vs_scheduler *sched);
+void ip_vs_unbind_scheduler(struct ip_vs_service *svc);
 struct ip_vs_scheduler *ip_vs_scheduler_get(const char *sched_name);
 void ip_vs_scheduler_put(struct ip_vs_scheduler *scheduler);
 struct ip_vs_conn *
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 4c9ef2ae4d6877..0805c9083eaa8f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1417,7 +1417,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	if (ret_hooks >= 0)
 		ip_vs_unregister_hooks(ipvs, u->af);
 	if (svc != NULL) {
-		ip_vs_unbind_scheduler(svc, sched);
+		ip_vs_unbind_scheduler(svc);
 		ip_vs_service_free(svc);
 	}
 	ip_vs_scheduler_put(sched);
@@ -1479,9 +1479,8 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 	old_sched = rcu_dereference_protected(svc->scheduler, 1);
 	if (sched != old_sched) {
 		if (old_sched) {
-			ip_vs_unbind_scheduler(svc, old_sched);
-			RCU_INIT_POINTER(svc->scheduler, NULL);
-			/* Wait all svc->sched_data users */
+			ip_vs_unbind_scheduler(svc);
+			/* Wait all svc->scheduler/sched_data users */
 			synchronize_rcu();
 		}
 		/* Bind the new scheduler */
@@ -1489,6 +1488,10 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 			ret = ip_vs_bind_scheduler(svc, sched);
 			if (ret) {
 				ip_vs_scheduler_put(sched);
+				/* Try to restore the old_sched */
+				if (old_sched &&
+				    !ip_vs_bind_scheduler(svc, old_sched))
+					old_sched = NULL;
 				goto out;
 			}
 		}
@@ -1545,7 +1548,7 @@ static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup)
 
 	/* Unbind scheduler */
 	old_sched = rcu_dereference_protected(svc->scheduler, 1);
-	ip_vs_unbind_scheduler(svc, old_sched);
+	ip_vs_unbind_scheduler(svc);
 	ip_vs_scheduler_put(old_sched);
 
 	/* Unbind persistence engine, keep svc->pe */
diff --git a/net/netfilter/ipvs/ip_vs_sched.c b/net/netfilter/ipvs/ip_vs_sched.c
index d4903723be7e90..49b2e5d2b2c837 100644
--- a/net/netfilter/ipvs/ip_vs_sched.c
+++ b/net/netfilter/ipvs/ip_vs_sched.c
@@ -57,19 +57,19 @@ int ip_vs_bind_scheduler(struct ip_vs_service *svc,
 /*
  *  Unbind a service with its scheduler
  */
-void ip_vs_unbind_scheduler(struct ip_vs_service *svc,
-			    struct ip_vs_scheduler *sched)
+void ip_vs_unbind_scheduler(struct ip_vs_service *svc)
 {
-	struct ip_vs_scheduler *cur_sched;
+	struct ip_vs_scheduler *sched;
 
-	cur_sched = rcu_dereference_protected(svc->scheduler, 1);
-	/* This check proves that old 'sched' was installed */
-	if (!cur_sched)
+	sched = rcu_dereference_protected(svc->scheduler, 1);
+	if (!sched)
 		return;
 
+	/* Reset the scheduler before initiating any RCU callbacks */
+	rcu_assign_pointer(svc->scheduler, NULL);
+	smp_wmb();	/* paired with smp_rmb() in ip_vs_schedule() */
 	if (sched->done_service)
 		sched->done_service(svc);
-	/* svc->scheduler can be set to NULL only by caller */
 }
 
 
-- 
2.53.0





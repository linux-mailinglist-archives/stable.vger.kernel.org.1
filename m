Return-Path: <stable+bounces-267428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q4uIAXBwNWqfwQYAu9opvQ
	(envelope-from <stable+bounces-267428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 18:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EEE6A7149
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 18:38:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=odmKolQf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267428-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267428-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F0DC300CD8E
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59513C062F;
	Fri, 19 Jun 2026 16:38:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E665396579;
	Fri, 19 Jun 2026 16:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887081; cv=none; b=BkKYP35YGqJfODC3VDIxnq4i1slYlpqzSTlmrQLSVjwVES8WgTUV5bUJXvjeDBnsr6HxxUo1vl55mzI0d2aiaT50tr3Gzqf3MZ/lBfrJH6iCQjbZt8kgJlxGXFnKgctvsUp+kUSujf7HHgSBU88eQkylEvu2FqQTkm7/Dg9FTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887081; c=relaxed/simple;
	bh=5TE/fAmXRPtPGSlZYKZiW19YWz48RJ5l1BFj7iPZLSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmMOOqHIipPJm9yGBT608lPFGEOVF4DV3Lph0n8p3sThj+N/+A9LmerrAWYS21I6KJCbiEsj3wCFq3IX76ADCdHr+4+acWvVAyas93Jpo9rzo5mteVTPA1iiL4LP9/216krnJH8HN6iTBIV87nJUdtSTUt2IRpEgEbNt2/5heAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=odmKolQf; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781887075;
	bh=ZIaJqAqwQPglNeMJRjyw5Ro90LLu19Fa82nqcYlrad0=;
	h=From:To:Cc:Subject:Date:From;
	b=odmKolQf9V+gOFhyNtzo8W7ipkFvg3gyXfqIke+gCK3l0YckWwFHQ59cKK2hcUx7x
	 iRrcRQTUGHch4e+7ccOxSAjgrEyXmPdOiu2bDDArmIXJux9vdggPnh9hvdY8XCsTzK
	 Blye44HvSluq4FU39BBx7D//OUu37w5yuR6a69tc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghjv70Z8lz115M;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghjv63xkJz114y;
	Fri, 19 Jun 2026 16:37:54 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] cpu: hotplug: preserve per instance callback errors
Date: Fri, 19 Jun 2026 16:37:17 +0000
Message-ID: <20260619163719.12103-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267428-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:peterz@infradead.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78EEE6A7149

cpuhp_invoke_callback() unwinds earlier callbacks for the same
hotplug state when one instance fails. The rollback path currently
reuses ret, so a successful rollback can hide the original error and
make the failed transition look successful.

Keep the rollback result separate from the original error.

Fixes: 724a86881d03 ("smp/hotplug: Callback vs state-machine consistency")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f975bb34915b..0f32086f9ed4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -174,7 +174,7 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	struct cpuhp_step *step = cpuhp_get_step(state);
 	int (*cbm)(unsigned int cpu, struct hlist_node *node);
 	int (*cb)(unsigned int cpu);
-	int ret, cnt;
+	int ret, cnt, rollback_ret;
 
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
@@ -238,12 +238,12 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 			break;
 
 		trace_cpuhp_multi_enter(cpu, st->target, state, cbm, node);
-		ret = cbm(cpu, node);
-		trace_cpuhp_exit(cpu, st->state, state, ret);
+		rollback_ret = cbm(cpu, node);
+		trace_cpuhp_exit(cpu, st->state, state, rollback_ret);
 		/*
 		 * Rollback must not fail,
 		 */
-		WARN_ON_ONCE(ret);
+		WARN_ON_ONCE(rollback_ret);
 	}
 	return ret;
 }
-- 
2.53.0



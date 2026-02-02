Return-Path: <stable+bounces-213100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXFNXwRgWnmDwMAu9opvQ
	(envelope-from <stable+bounces-213100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 22:05:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02334D1752
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 22:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DC4C301C6DA
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6830F804;
	Mon,  2 Feb 2026 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tJ6PSMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2P86WNe"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0E222565;
	Mon,  2 Feb 2026 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066282; cv=none; b=eVfckwzyx5ASWnG9eu/GBFbOKBzajz4ZTzSV4tbQHRKKfsB4Av6YrdpRYL0s3Bgf4FXqfbPSkX4k0xSc0CArOmstKSZzyXZIDXwhoJCL+vGXkLw8Ze2uzHX0WTnhlFifnFdhxkvVJ82UTHwk9s1/eVtWFFUdtyiDeG6OS4wGHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066282; c=relaxed/simple;
	bh=+dhCdBEsIiNm9jFTYY0OVo5eAeLFBPugkNN84DY1eB4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SZKPNHNfqKE1MYfGhu9Yw/b9dlsNft+xlEO5BsobP1CK881bNsst16h2VXEivFJLJVHRCob6E/BKoYLl+83VJ77uAIFWesz6jKh8BitVgaIk9NennRN7v5OnQ2p6O4OEdSKPk18/FFShC2ubDDbm/aErOsRvq4ZzL0TzLqgTqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tJ6PSMN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2P86WNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Feb 2026 21:04:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770066280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7xalSVKFyUhuZvK4gJlnPsI2klQoWZuADHJifLfjEg=;
	b=0tJ6PSMNPlGQUXqMMQJAobMNkcPcSktL0HfJJo/N0P12kq0GaJQS30Ge0ejJIuWOMr8aWG
	IP+fSzXzBMcqc8UG7EMq5LgV3/HKQtN3Nvp3/bHaL6RaAQe8RqAKwb32+EdKPCzX0cetmO
	LmaTKVMYrvSnePE5Rn3LnGD51QQ0b/PIp3mwq9UdCLbIOjHWLy8AXqr/4TZUKjSUu4oUAv
	MCSSs4oANOuUeVEftqla1EHBOo1NRYEtkgae5NiWxu+Yuvkt/nS+z26+U9qN9Ld55xsPKI
	KFVxwDOte1Qod1PN06qpStTaQsZuE+YoY0Zz+Kqs1cBWhKQBBFlB/7D584kyWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770066280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7xalSVKFyUhuZvK4gJlnPsI2klQoWZuADHJifLfjEg=;
	b=w2P86WNeMsogTI5NCWJezU3QvMrvjPUr++zRxx3A/I1kfaAg8ZFV5NVkBmRtbHNqqiP9Gi
	kZfDgLEfh/cr/WDA==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Fix incorrect lockdep condition in filter_chain()
Cc: Breno Leitao <leitao@debian.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org>
References: <20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177006627890.2495410.15132261871969236543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213100-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,linutronix.de:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 02334D1752
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a56a38fd9196fc89401e498d70b7aa9c9679fa6e
Gitweb:        https://git.kernel.org/tip/a56a38fd9196fc89401e498d70b7aa9c967=
9fa6e
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Wed, 28 Jan 2026 10:16:11 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Feb 2026 22:01:07 +01:00

uprobes: Fix incorrect lockdep condition in filter_chain()

The list_for_each_entry_rcu() in filter_chain() uses
rcu_read_lock_trace_held() as the lockdep condition, but the function
holds consumer_rwsem, not the RCU trace lock.

This gives me the following output when running with some locking debug
option enabled:

  kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
    filter_chain
    register_for_each_vma
    uprobe_unregister_nosync
    __probe_event_disable

Remove the incorrect lockdep condition since the rwsem provides
sufficient protection for the list traversal.

Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly unde=
r SRCU protection")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260128-uprobe_rcu-v2-1-994ea6d32730@debian.o=
rg
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index dfbce02..424ef22 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1138,7 +1138,7 @@ static bool filter_chain(struct uprobe *uprobe, struct =
mm_struct *mm)
 	bool ret =3D false;
=20
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
+	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
 		ret =3D consumer_filter(uc, mm);
 		if (ret)
 			break;


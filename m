Return-Path: <stable+bounces-242509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB0tEGUC9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:43:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CDA4AF48B
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E51B3040AB2
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6311421F05;
	Fri,  1 May 2026 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcEptR6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUvm1upa"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE95421EF3;
	Fri,  1 May 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664421; cv=none; b=RGQeciCaxXmA75oCIEGdrFNVm6jsZnRPYgtlQgfEH9v0eL0hngEjZzzLtx+TpQ5Kmg5xYVfthB1AHM3sd7Xhc5FDgVtaDUIglQ85wgvj1mcasfI6DkkKiuEdZGHRAV2I2XJJ2EkG6gC69Ie+R7JwXnjHPWUyX4Vyddl0hFMF51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664421; c=relaxed/simple;
	bh=MGiV2CQ9Vyb1E7EiYJIUlE7qW+N8hPZ8TkR+ZZeuiNU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aMFf0S+VnkRwTRl+Fn24B6ISgTGWpfPESWFSJEoJwNxVVctDT1t3a5q6/Xea3Lo3h8GUzlSIf0CKWkAA2NFnIoybbdSiaINMVrcOifGgpBYPDu4Fm6Kuo3lCUq++0hVHzJmQfRHDXuNeVVfJS7QfXrCbyXwzXd3Q1GC9QP28wlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcEptR6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUvm1upa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bCxq4gU32b2iMbrPi+qlZo5QhD3trT5POc/fEIVJrWU=;
	b=NcEptR6QGEIK0bSkuGozkaRIfCv5tHfvv/9FL/zZQmPEiopshhkRRHTc+/saU3gx/Tn4D7
	IzyL+hFXgnYKO90cWKPRdKVBvVPw/Xk7XvnpPtROvx4WeNbGH9xoNr0m8Yiej7YT9RONJH
	0kg+olZKLYRtSSKlNk3CnNu1W7vesXEAbeQI2ogHhagBsYXjluwdTtw2xwUS45Vkw+fRvJ
	xmRpUMUp5aqjjunV2YLewfXcjsh1aDrqqZ+qZguorT3SlxqiXffmtCf5fwhlnEhkSpwwTd
	EWyN2rSHKktZpWstkXxNfyl2bbo0LDc2BoiCtyPujdC8gCObpAuM/bNvziozIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bCxq4gU32b2iMbrPi+qlZo5QhD3trT5POc/fEIVJrWU=;
	b=jUvm1upa627iU/RGwmegYRriUfB6Zx0tvo04f6+dawKb2Nt48wIJgFNUYdW70shqZssE/i
	hJnSwPZEQpvmbpBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests/rseq: Skip tests if time slice
 extensions are not available
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441363.3521451.6800092404605701602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0CDA4AF48B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242509-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,vger.kernel.org:replyto]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ca124bccc9b7aea3e355e8ab71003f78320de3b9
Gitweb:        https://git.kernel.org/tip/ca124bccc9b7aea3e355e8ab71003f78320=
de3b9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 25 Apr 2026 15:46:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:21 +02:00

selftests/rseq: Skip tests if time slice extensions are not available

Don't fail, skip the test if the extensions are not enabled at compile or
runtime.

Fixes: 830969e7821a ("selftests/rseq: Implement time slice extension test")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.597838491%40kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/slice_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/slice_test.c b/tools/testing/selfte=
sts/rseq/slice_test.c
index 357122d..77e668f 100644
--- a/tools/testing/selftests/rseq/slice_test.c
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -124,6 +124,13 @@ FIXTURE_SETUP(slice_ext)
 {
 	cpu_set_t affinity;
=20
+	if (rseq_register_current_thread())
+		SKIP(return, "RSEQ not supported\n");
+
+	if (prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+		  PR_RSEQ_SLICE_EXT_ENABLE, 0, 0))
+		SKIP(return, "Time slice extension not supported\n");
+
 	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
=20
 	/* Pin it on a single CPU. Avoid CPU 0 */
@@ -137,11 +144,6 @@ FIXTURE_SETUP(slice_ext)
 		break;
 	}
=20
-	ASSERT_EQ(rseq_register_current_thread(), 0);
-
-	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
-			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
-
 	self->noise_params.noise_nsecs =3D variant->noise_nsecs;
 	self->noise_params.sleep_nsecs =3D variant->sleep_nsecs;
 	self->noise_params.run =3D 1;


Return-Path: <stable+bounces-242514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAJeDvIB9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:41:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A33004AF3E7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F13930387EF
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F774219E7;
	Fri,  1 May 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ONGAfKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwgq2eIJ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC9423A70;
	Fri,  1 May 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664427; cv=none; b=FU8Sf7DS4HTifGE+WXP0xCi6vcGWAFp6IzIQSkIersfbKzIPi1GHPb4+rTlV0xo0KNJnj0u4hYOZql5P0ZQVPPxWBCJoI6pjt7GPio0GKmLoXOrnBzQxMFWdrcrL/4Y8vJMK1bOyCWPkUfxDIW7Lqw9ysbphH3/QUg7LTHwnxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664427; c=relaxed/simple;
	bh=eFPqvEar2auv/z/TJHu5IpzWB7vgkbor6CVtKMUc2Os=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9Y9aT7VzLoalw6Eex1WOEzAwpcT9LizLytHrV1mrreWqc1pY/29Tl2cBWMKIFQovqvsGyM15PISp2X3NJJOps9jTwrqEE3y7+Efb+g/2yPEQhBjTiHTI1sULxAcM2W2I7xR85J+hUD+0lbdkF454QZ8OsvxIBGCNAGxwAlS8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ONGAfKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwgq2eIJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoWojLEx9qctu1YX6lRhz1e+vkr6rI4wypVizJfcqVY=;
	b=2ONGAfKNj9IqiB0Xod8ESPNAZxdSTdfDvmRqGVOjYnBfZPx8Sn89MJ2wXkbXFlZiey8Mih
	PTGxgVGVCW4XkGGGBFptKj333rNE9kfaTwwP/SkfV0SDC3XnoMfsVFX04A70JcRlTTXVWh
	r9VV+4XMygwX3vonQYhntN78p1P+z9KUcCrrMGXzbrj0Fr4NnDIkYyzDnzUKU2us6jSDNV
	JnYIFiWPndkp/w/lq6veHt0bnKeAQqBBpNM8LJPqpW2k0QfVqR1Y+tQUC74oISwbxVwznv
	cTZXxjLpmt9Ed13Iz9+pssx32kCh+G06oEcelYE+GpG4oV+bStoGY7OSj14JWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoWojLEx9qctu1YX6lRhz1e+vkr6rI4wypVizJfcqVY=;
	b=hwgq2eIJMfyOUKa+X42bV/dlclzgrBSXscC+rJb4GXgZH1QfmvP4267wfvy6o38SC9L1/1
	0IPcvVOrZn8HM/DA==
From: "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests/rseq: Don't run tests with runner
 scripts outside of the scripts
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260423-selftests-rseq-use-runner-v1-1-e13a133754c1@kernel.org>
References: <20260423-selftests-rseq-use-runner-v1-1-e13a133754c1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441989.3521451.13825655179450483150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A33004AF3E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242514-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run_syscall_errors_test.sh:url,linutronix.de:dkim,run_param_test.sh:url,infradead.org:email,msgid.link:url,librseq.so:url,vger.kernel.org:replyto]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cb48828f06afa232cc330f0f4d6be101067810b3
Gitweb:        https://git.kernel.org/tip/cb48828f06afa232cc330f0f4d6be101067=
810b3
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Thu, 23 Apr 2026 20:17:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:20 +02:00

selftests/rseq: Don't run tests with runner scripts outside of the scripts

The rseq selftests include two runner scripts run_param_test.sh and
run_syscall_errors_test.sh which set up the environment for test binaries
and run them with various parameters. Currently we list these test binaries
in TEST_GEN_PROGS but this results in the kselftest framework running them
directly as well as via the runners, resulting in duplication and spurious
failures when the environment is not correctly set up (eg, if glibc tries
to use rseq).

Move the binaries the runners invoke to TEST_GEN_PROGS_EXTENDED, binaries
listed there are built but not run by the framework.  The param_test
benchmarks are not moved since they are not run by run_param_test.sh.

Fixes: 830969e7821a ("selftests/rseq: Implement time slice extension test")

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260423-selftests-rseq-use-runner-v1-1-e13a13=
3754c1@kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/Makefile | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/=
rseq/Makefile
index 4ef9082..0d1947c 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,12 +14,15 @@ LDLIBS +=3D -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS =3D 1
=20
-TEST_GEN_PROGS =3D basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_=
test param_test \
-		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test slice_test
-
-TEST_GEN_PROGS_EXTENDED =3D librseq.so
+TEST_GEN_PROGS =3D basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_=
test \
+		 param_test_benchmark param_test_mm_cid_benchmark slice_test
+
+TEST_GEN_PROGS_EXTENDED =3D librseq.so \
+	param_test \
+	param_test_compare_twice \
+	param_test_mm_cid \
+	param_test_mm_cid_compare_twice \
+	syscall_errors_test
=20
 TEST_PROGS =3D run_param_test.sh run_syscall_errors_test.sh
=20


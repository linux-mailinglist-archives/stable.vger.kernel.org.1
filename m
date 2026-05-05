Return-Path: <stable+bounces-244162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CxuOoX7+WmNFgMAu9opvQ
	(envelope-from <stable+bounces-244162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:15:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859C64CF353
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D380230041D6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40E480357;
	Tue,  5 May 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfBumEIE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7OBqj2KK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7548095E;
	Tue,  5 May 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990425; cv=none; b=gSQztLfQTTBgRaGVwX9S2a9HoWEpopaHgk7eWk7PtxuPiraLNWvG8JchQFB/0QKHRKvyz7Ls144WWEIgMciILssTOH0MuPNHYimJECV1hiTOGg87igINuYxsh+jEkGaDFz7VkxSSAeyR/gak+kAPRuzVBMQHqcRz20VPxecmG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990425; c=relaxed/simple;
	bh=nlI3okgVuepq9gm3/hGWPhtDnDyB3AKHm7P/sYDDGw8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cw4VXhuv9E1Uv8hKI2fScflzZk1pFMnxIayrsZd7+OCK5J3uTa7Xg6GR94J+vBdX4nQYxhpyfPcaetqhhrXAASM9AMYzz3067hsKIwx51gEU1m8aXad0pXJGU4GHFdPH2ojU8Bd676qjWWYTZ9RJsMm+xFcdMXszG2UD0s6jVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfBumEIE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7OBqj2KK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 14:13:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777990420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oAYpv/cfPpdJAlws997uawUDJs6ngsf2/LU3b/+x2Q=;
	b=PfBumEIEGq1Tyt6U938pwBvpDP4dwpuxUQWYSLpcrNjbKX2DLk7wgNlOwaAkEPqpJwErRg
	RrIK2wC1zIMC9Z8sdt8QVv2cuj6+jQhb0DZZuf8Wy57usg9LvnDC0SRdJDy5SlsJKidWbo
	piFiiQO1RiHvjkFetTDt4iLCL+VqLGTa3JRH4EAYTG5jq5xUKwcGbiWHgY9/GMlacEfLVl
	SfCD8NJDrLuboYosGS6lV6yfsBsxnYfexqd3/8S56b8mjXZocxKygQZXmyMw/SrE5bmic1
	nzHhKnTDaa/oriPFFqYHFqBQ9cjmZQE6PMZYn6EzzN5btdfKAD0RlYj7swgCHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777990420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oAYpv/cfPpdJAlws997uawUDJs6ngsf2/LU3b/+x2Q=;
	b=7OBqj2KK0ffCYrAVPefUMUMSOfnmaz25jmrug1xzCIU+2rEBtstWt0E9agBN7Zd7Qwr3U1
	siLnhgtmN3UztbAg==
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
In-Reply-To: <20260428224427.597838491@kernel.org>
References: <20260428224427.597838491@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177799041870.424702.14171552670641972492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 859C64CF353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244162-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:email,vger.kernel.org:replyto,msgid.link:url,infradead.org:email]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     02b44d943b3adddc3a15c1da97045e205b7d14c1
Gitweb:        https://git.kernel.org/tip/02b44d943b3adddc3a15c1da97045e205b7=
d14c1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 25 Apr 2026 15:46:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 16:03:11 +02:00

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


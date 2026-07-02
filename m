Return-Path: <stable+bounces-270818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FvJmE1mTRmqEYwsAu9opvQ
	(envelope-from <stable+bounces-270818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:35:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D058D6FA45B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:35:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tmcu4ouf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270818-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270818-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC0F7300B982
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2439657B;
	Thu,  2 Jul 2026 16:32:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED345399D0B;
	Thu,  2 Jul 2026 16:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009929; cv=none; b=sO/ZVd8x8fl0wwu7YwksgY8MlPlK8fPLIBJV9J/5xU/WJ4zjSo9d1vtvIO8kj6BaI2GQJferkVONE5TO06k20pUFYuJoWq4WlrT2wIHWTQBKb1kZRItDQsrhK8oULJwd4XSFczH5e18Y6HV9OqJUCPGldU3CUfyng5K8b25Vo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009929; c=relaxed/simple;
	bh=Cop8LwCTYseH4o15AMzNgkfbPqirzkXQMc+X08Ce6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCjE0tEcsCfzYg25Ramw05Ip2QVDPK5becsSjLJPuypO4W8hbDOTY4ic+kRbtM8Vo8OMRsyaRRTSKkFr7lji3gyZcJK1OsY++TUkPpKV7gLBbqkY3xrk5lhONd7doHFn1k8oQ60QJSPl4kt6XK6UhuBj7U1Fx2a81PKzUX/g9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tmcu4ouf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664D31F000E9;
	Thu,  2 Jul 2026 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009927;
	bh=LC8zkf9P22T0osGcVlQFuTECARMp3DeJt5KzCtccioM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tmcu4oufVncIxBDf38ou6V7rz9joG14U8G8Dwk0XHG6G+esDLCVxhdp+5KnQ2OrFS
	 b7/0J/OKkMEVbDnPzLoUck9dva8DzIUAnANJxRHo8l4OnbkvjeXcrvJSg4VdUCEs1f
	 /460Htre0GGweTuykG5JXSjPTBXB7LFdX11YbhbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Simon Liebold <simonlie@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/129] perf bench: Avoid NDEBUG warning
Date: Thu,  2 Jul 2026 18:19:23 +0200
Message-ID: <20260702155113.061237939@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270818-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:irogers@google.com,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:mingo@redhat.com,m:jolsa@kernel.org,m:mark.rutland@arm.com,m:namhyung@kernel.org,m:pbonzini@redhat.com,m:peterz@infradead.org,m:seanjc@google.com,m:acme@redhat.com,m:simonlie@amazon.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D058D6FA45B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit d1babea9c38282b58a6f822ab95027cba3165a42 ]

With NDEBUG set the asserts are compiled out. This yields
"unused-but-set-variable" variables. Move these variables behind
NDEBUG to avoid the warning.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230330183827.1412303-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/bench/find-bit-bench.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 22b5cfe9702370..80f051f9c20fd9 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -61,7 +61,6 @@ static int do_for_each_set_bit(unsigned int num_bits)
 	double time_average, time_stddev;
 	unsigned int bit, i, j;
 	unsigned int set_bits, skip;
-	unsigned int old;
 
 	init_stats(&fb_time_stats);
 	init_stats(&tb_time_stats);
@@ -73,7 +72,10 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			set_bit(i, to_test);
 
 		for (i = 0; i < outer_iterations; i++) {
-			old = accumulator;
+#ifndef NDEBUG
+			unsigned int old = accumulator;
+#endif
+
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for_each_set_bit(bit, to_test, num_bits)
@@ -85,7 +87,9 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
 			update_stats(&fb_time_stats, runtime_us);
 
+#ifndef NDEBUG
 			old = accumulator;
+#endif
 			gettimeofday(&start, NULL);
 			for (j = 0; j < inner_iterations; j++) {
 				for (bit = 0; bit < num_bits; bit++) {
-- 
2.53.0





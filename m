Return-Path: <stable+bounces-220096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ13N6Yno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223F1C4F45
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEAFA308D44E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694953590A9;
	Sat, 28 Feb 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8KmuQE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E43563C7;
	Sat, 28 Feb 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300000; cv=none; b=mgZiUTCHoSQJJ0f5mjlLvDsxyTAi7dgRtWTXB8+gnCGunOVsEdVTGWYKrNNV69SUAkEyZVOGxLN4xyYJPiwA9AXy6PqUzXK45ErOzMewGcesc4oXV1u0wNrszkpdEas2qY11vnQRWdH3TBXCi867pbRAJT9hirED7F7z1NuQuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300000; c=relaxed/simple;
	bh=b6+1gnxBezrGNZf3K8NI12Al8ckqgqSf2o1BUGhHJOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlVz0+GZDlakQvfA5f5qnZRBpA8+L8VcYfbix7ecVE+QzI4Y1aAa9td7srgzHo2q4YRVzI3ZG4vdJKwE7GHiLk7CStCEA2CZddIROcXigF2Yu6vAdAyUPceZC9RXbUwaPacqlhOBnoJpZhaignAQTTWPRx7w6EurhNEim0ys8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8KmuQE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26EC116D0;
	Sat, 28 Feb 2026 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300000;
	bh=b6+1gnxBezrGNZf3K8NI12Al8ckqgqSf2o1BUGhHJOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8KmuQE8wuZznHG/1Vmv4PCj3tw3/iXKK9/EwE4+6J9SjSrGikUcupvpwRqzhiDGR
	 yR05SQ52BMxICwDeybGwp7M4c9HjoFwn0a+w6EfhdToPrgbX6XuiQ2ijntDswAi0tf
	 lzGeAXm1cC4ESmwc2lka4+qiv8LSTUXLynNKmJFmqXYAEwkpiD0N6mEgmLSWKDAZlS
	 aEGtWqjSgERtvU3eewewtHOh5qpzjqpNh+7MfurlhL1DNNK/pJOEZzpaaLPeYliPeE
	 d/VKg1QbvpfCqv+dRfVd8en14Zjkbjlq6etNNRAX7LL+KSvmydnCEIstVWMOh21naZ
	 +El4v1Ay59t9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 018/844] perf tests sched: Avoid error in cleanup on loaded machines
Date: Sat, 28 Feb 2026 12:18:51 -0500
Message-ID: <20260228173244.1509663-19-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220096-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 8223F1C4F45
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit c5e47e4d00fbc15f2390bb6ed8d9c21836363291 ]

The stop_noploops function will kill the noploop processes that are
running for 10 seconds.

On a loaded machine they may have already terminated meaning the kill
will return an error of no such process.

This doesn't matter and so ignore the error to avoid the test
terminating in the cleanup.

Fixes: 0e22c5ca44e68798 ("perf test: Add sched latency and script shell tests")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/sched.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index b9b81eaf856e6..b9637069adb1f 100755
--- a/tools/perf/tests/shell/sched.sh
+++ b/tools/perf/tests/shell/sched.sh
@@ -53,7 +53,7 @@ start_noploops() {
 }
 
 cleanup_noploops() {
-  kill "$PID1" "$PID2"
+  kill "$PID1" "$PID2" || true
 }
 
 test_sched_record() {
-- 
2.51.0



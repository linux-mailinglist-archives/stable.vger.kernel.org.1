Return-Path: <stable+bounces-220084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gj4ASkno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AC1C4ED7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D9C330452C4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B14340A59;
	Sat, 28 Feb 2026 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZUMess8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BD34028B;
	Sat, 28 Feb 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299976; cv=none; b=WFBZHYz9CEh5m/vDExUKIA8xir3j88dPBwERYBk2KVEmEgPZN70JpRVNsVg5wgpQbZhD6jsQH/6UT/0nTVriibb30vWkG8tHxQ5GlU/44OQiGqI8ggHhAyCH1vCYZv8gTuX2+6/tsQeJ92G3hCMBfdiUXlrCsQClofcNBbq6pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299976; c=relaxed/simple;
	bh=ZOzanoFOH5DzZMWofm4R8GIYtFn755rOXfZ3brBRN94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck+KEBTPMC+sxSuQCDJh+OHQ+T6JK5Bf1cXzeDv/aU5Cf3jS0nc0pEs21xx5kcmuejENcsEnvqHuKF/Oby1tyzxz8y7Q22lklcBLACm3pg/VJOCQRDME+XsQ52HffbwVr3AVhwCBh30Fhr9Ee9QD6UT0CjsO53f3dXgfdeztjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZUMess8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE76C2BC87;
	Sat, 28 Feb 2026 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299975;
	bh=ZOzanoFOH5DzZMWofm4R8GIYtFn755rOXfZ3brBRN94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZUMess8FNw0gR7iiu1ieHsojmKzmtCDrnRBSkjsbASiu69FC3zmQFBuhn/Q/r4SD
	 2qHKlrpTyiE6YD0ydDUBz4UGVOuO03rO4Kla8qBCu8Rs74l4ZyYj1PIY37Rzgd/XlR
	 uIAbg+TmzMI/V1FEGhKrRFUX4KIxKPeU7Afo0c97bm2M7ioSTA1QXQbINzyILqFHYn
	 /VxLtY0ffyH2fGaqAx9QNT5R5X66PSHe9N8b7VwUn3knSvMOyguMKMzp5DXSNvdLkN
	 R7OAlGqcJtRvnunHymz1+xmiwJKv5HvVFDRIxhUIv8zV8dyglI60qirGGedKkOtVgQ
	 5/c/soby5scew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Schier <n.schier@avm.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Philipp Hahn <p.hahn@avm.de>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 006/844] perf build: Raise minimum shellcheck version to 0.7.2
Date: Sat, 28 Feb 2026 12:18:39 -0500
Message-ID: <20260228173244.1509663-7-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220084-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E8AC1C4ED7
X-Rspamd-Action: no action

From: Nicolas Schier <n.schier@avm.de>

[ Upstream commit 383f8e26e2c483e25453f8c3d0839877708ac701 ]

Raise the minimum shellcheck version for perf builds to 0.7.2, so that
systems with shellcheck versions below 0.7.2 will automatically skip the
shell script checking, even if NO_SHELLCHECK is unset.

Since commit 241f21be7d0fdf3c ("perf test perftool_testsuite: Use
absolute paths"), shellcheck versions before 0.7.2 break the perf build
with several SC1090 [2] warnings due to its too strict dynamic source
handling [1], e.g.:

  In tests/shell/base_probe/test_line_semantics.sh line 20:
  . "$DIR_PATH/../common/init.sh"
    ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.

Fixes: 241f21be7d0fdf3c ("perf test perftool_testsuite: Use absolute paths")
Signed-off-by: Nicolas Schier <n.schier@avm.de>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jakub Brnak <jbrnak@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philipp Hahn <p.hahn@avm.de>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
Link: https://www.shellcheck.net/wiki/SC1090
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.perf | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3f481a626afa..e6895626c1872 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -251,11 +251,12 @@ else
 endif
 
 # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
-# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0). So make the
-# minimal shellcheck version as v0.6.0.
+# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0) as well as
+# dynamic source inclusions (properly handled since v0.7.2).
+# So make the minimal shellcheck version as v0.7.2.
 ifneq ($(SHELLCHECK),)
   ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
-        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 060), 1)
+        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 072), 1)
     SHELLCHECK :=
   else
     SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning
-- 
2.51.0



Return-Path: <stable+bounces-220104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDy+Nssoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0011C5076
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 145F030C9963
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDF47D924;
	Sat, 28 Feb 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ritUV/BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC847CC9B;
	Sat, 28 Feb 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300012; cv=none; b=EZQdJ/qDbjtCAaIUhG1SXODN38qFsqRVBiFcyXSNw/BYLKg4Wfzd5Bxjjxl3T/302gsRdHaaw3VoP+yDMiXjZOySPsXJsQNbiJIOkuQpa2yB74kvEOKmeP9hFmAjPKRFuhYMaor3pXlV/+Rmrn1tgjl4e2Kc3d/fcAuLyuJ5DU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300012; c=relaxed/simple;
	bh=arL/7RVLXJxrKVxhxcK9OJ/+zcoX0CjtV+x8HUGf0ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhNVqjYY7nZv6yamfRdRZWoyA2DqzbBqT9fYJPxpBRJtRyKfSBSARPO4qgewHd5Aun+hddK76vtTdsHI7Opaw5mSp/FtAotebFEQ3GKW92ghTrmQ3KeackqOeebRPlQSuunFPMfQ7nAqrtDgVp19D/vuE+ZjDIY82w10a1BBLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ritUV/BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB84C2BCB3;
	Sat, 28 Feb 2026 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300012;
	bh=arL/7RVLXJxrKVxhxcK9OJ/+zcoX0CjtV+x8HUGf0ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ritUV/BClRe5EopSH+p/1AxrG1cPNBUw6oUjebWHzSarws8T61xMeJWXGjnQwopYY
	 1x9LjxYbmzoX8deY1o4ahAQKOkn3r6UTEV8gL2lxZUz2mazhNcogG/iVHhvx6cuG4f
	 +bMzb6nNgrpk79jjL+ZHyshGVErj6BASKWHDy861S7a20EkuEIh7YyLghWf4/mNX1j
	 5DxSAa/WmjvCvMZ1qRcdryBEur6jPBL/0/hEUDCh/RcV6ZAmjDgxbN9SKecDObg41T
	 APHRcR3qPKD+CDzsmeCp6JZrxeuTfRR4XS0hJejbOdWOMm+7r6bkbDdVKHkiLpHlcw
	 93vabIoCAbj1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 026/844] libperf build: Always place libperf includes first
Date: Sat, 28 Feb 2026 12:18:59 -0500
Message-ID: <20260228173244.1509663-27-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220104-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,intel.com:email,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E0011C5076
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 8c5b40678c63be6b85f1c2dc8c8b89d632faf988 ]

When building tools/perf the CFLAGS can contain a directory for the
installed headers.

As the headers may be being installed while building libperf.a this can
cause headers to be partially installed and found in the include path
while building an object file for libperf.a.

The installed header may reference other installed headers that are
missing given the partial nature of the install and then the build fails
with a missing header file.

Avoid this by ensuring the libperf source headers are always first in
the CFLAGS.

Fixes: 3143504918105156 ("libperf: Make libperf.a part of the perf build")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 7fbb50b74c00b..5c64122bf5374 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -51,9 +51,9 @@ INCLUDES = \
 -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
+override CFLAGS := $(INCLUDES) $(CFLAGS)
 override CFLAGS += -g -Werror -Wall
 override CFLAGS += -fPIC
-override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += $(EXTRA_CFLAGS)
-- 
2.51.0



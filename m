Return-Path: <stable+bounces-226612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEX5FkeMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E952AF359
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B270C30BA0C4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37743F54C2;
	Tue, 17 Mar 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQJV1A21"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C9373C18;
	Tue, 17 Mar 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767466; cv=none; b=KFMKYu2iUzAyUFVwK1gw4HjTiuk05mWBI5M+3zKL2vT6XXIxsyd8kU7hkQm/uvvWYNXV8BEhMBxsQEVmVTWOTPl2zqVQ5X5+xcJQD8oD94KmGe0mnUI/Kgk22BVbyRGm6mOgmYjxc52bcyFkKfassWRv5Jy/gx8KdPBiQwVh7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767466; c=relaxed/simple;
	bh=KLe9a0b9eDjp+S3RtBUBY9mEC7CW/9UoC6wuwBzZ3DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7B+wHEtanIWr/AJUQQ4w5Y3uK0aonp0jsRZz51SFLKMtjg605DwMPA1dbRG1NUTyhFw6/cZ8Qz3jAvUPa+bMKdwu39ddhrqYDdcCdgq/M8n+OCMZXPlhOsHalL+bzQGQtzsfEJO0pk4GssaFJygsHlFoiw2tHdwvqm6fDtSV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQJV1A21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22109C4CEF7;
	Tue, 17 Mar 2026 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767466;
	bh=KLe9a0b9eDjp+S3RtBUBY9mEC7CW/9UoC6wuwBzZ3DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQJV1A21JdOY71BEkupXBJYfJ8O+LiF+BEsINhMndh6qH3Au7KIjUaPcdzT1q6hZG
	 zgr9XHkzuzclKV4mykjXPy84f2pqleEf0wimqUmx8qXIT/mHNWHDwR+lX5zmgPpO+Q
	 rrMvh/BdyjxRtrFbGbDkMhvPzFGFQvE+yP6tGTUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 092/333] perf synthetic-events: Fix stale build ID in module MMAP2 records
Date: Tue, 17 Mar 2026 17:32:01 +0100
Message-ID: <20260317163002.782970469@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226612-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email,infradead.org:email,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: 07E952AF359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 35b16a7a2c4fc458304447128b86514ce9f70f3c ]

perf_event__synthesize_modules() allocates a single union perf_event and
reuses it across every kernel module callback.

After the first module is processed, perf_record_mmap2__read_build_id()
sets PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
module's build ID into the event.

On subsequent iterations the callback overwrites start, len, pid, and
filename for the next module but never clears the stale build ID fields
or the MMAP_BUILD_ID flag.

When perf_record_mmap2__read_build_id() runs for the second module it
sees the flag, reads the stale build ID into a dso_id, and
__dso__improve_id() permanently poisons the DSO with the wrong build ID.

Every module after the first therefore receives the first module's build
ID in its MMAP2 record.

On a system with the sunrpc and nfsd modules loaded, this causes perf
script and perf report to show [unknown] for all module symbols.

The latent bug has existed since commit d9f2ecbc5e47fca7 ("perf dso:
Move build_id to dso_id") introduced the PERF_RECORD_MISC_MMAP_BUILD_ID
check in perf_record_mmap2__read_build_id().

Commit 53b00ff358dc75b1 ("perf record: Make --buildid-mmap the default")
then exposed it to all users by making the MMAP2-with-build-ID path the
default.  Both commits were merged in the same series.

Clear the MMAP_BUILD_ID flag and zero the build_id union before each
call to perf_record_mmap2__read_build_id() so that every module starts
with a clean slate.

Fixes: d9f2ecbc5e47fca7 ("perf dso: Move build_id to dso_id")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/synthetic-events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index fcd1fd13c30e6..c85d219928d47 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 
+		/* Clear stale build ID from previous module iteration */
+		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
+		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
+		event->mmap2.build_id_size = 0;
+
 		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
 	} else {
 		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
-- 
2.51.0





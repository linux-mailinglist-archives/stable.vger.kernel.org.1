Return-Path: <stable+bounces-84418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2AA99D019
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43850285A19
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1A11B85C4;
	Mon, 14 Oct 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qyvAvhmh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B11BDC3;
	Mon, 14 Oct 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917945; cv=none; b=hyvQmhgdMWF1D6od5UJLjZAL/J7PvbnV0/sTldNLg3kub+7ApXzIFfpJu7k+LLwZ/swRJaxZBxQWatpWUstTBPVsaVsySVRiA55MQrwIs20Ek5p8BPiebF6cPRprcY8NAZe6bs0TX0GOn4gUv6VdG4S5bj+MfNCSLU+ZmxjZYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917945; c=relaxed/simple;
	bh=G1TgVCRMxZ5//Lgc0rC8BOAgZ2qNVh70Y+PBT0uyREE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu7zXas1PYkK+ce99LJZLVUpSCDMMwsmXs93/Pt4BaQcTM68Do7wgPty35MZFyoDkRX9tBYQA5bAwKlQbbGxGNd+xCFqFaqkogXRdHF/UR2ZLkd+nL/CmFgTx8/gET1n2fNfqAdTJPjpdlYUz4UW6Xn8u3numSS1S6kIx0DGlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qyvAvhmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51537C4CEC3;
	Mon, 14 Oct 2024 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917945;
	bh=G1TgVCRMxZ5//Lgc0rC8BOAgZ2qNVh70Y+PBT0uyREE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyvAvhmh+Lz14FUxydjAl5BuOaMOqUSH47SO8Cv0xOsjdL67Q+8Izq2CytlfhVwFZ
	 s6f65KgTOUorujplDw+vzi9JANRywPcqIinv48GHt2NW5a9Qqr//Ki6r1ZcJyydahu
	 aDA6f1Z6sqZG8mS826ROTGgjiiCharQPQi4vFbcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jiri Olsa <jolsa@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/798] perf inject: Fix leader sampling inserting additional samples
Date: Mon, 14 Oct 2024 16:12:12 +0200
Message-ID: <20241014141224.920461660@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 79bcd34e0f3da39fda841406ccc957405e724852 ]

The processing of leader samples would turn an individual sample with
a group of read values into multiple samples. 'perf inject' would pass
through the additional samples increasing the output data file size:

  $ perf record -g -e "{instructions,cycles}:S" -o perf.orig.data true
  $ perf script -D -i perf.orig.data | sed -e 's/perf.orig.data/perf.data/g' > orig.txt
  $ perf inject -i perf.orig.data -o perf.new.data
  $ perf script -D -i perf.new.data | sed -e 's/perf.new.data/perf.data/g' > new.txt
  $ diff -u orig.txt new.txt
  --- orig.txt    2024-07-29 14:29:40.606576769 -0700
  +++ new.txt     2024-07-29 14:30:04.142737434 -0700
  ...
  -0xc550@perf.data [0x30]: event: 3
  +0xc550@perf.data [0xd0]: event: 9
  +.
  +. ... raw event: size 208 bytes
  +.  0000:  09 00 00 00 01 00 d0 00 fc 72 01 86 ff ff ff ff  .........r......
  +.  0010:  74 7d 2c 00 74 7d 2c 00 fb c3 79 f9 ba d5 05 00  t},.t},...y.....
  +.  0020:  e6 cb 1a 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
  +.  0030:  02 00 00 00 00 00 00 00 76 01 00 00 00 00 00 00  ........v.......
  +.  0040:  e6 cb 1a 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  +.  0050:  62 18 00 00 00 00 00 00 f6 cb 1a 00 00 00 00 00  b...............
  +.  0060:  00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00  ................
  +.  0070:  80 ff ff ff ff ff ff ff fc 72 01 86 ff ff ff ff  .........r......
  +.  0080:  f3 0e 6e 85 ff ff ff ff 0c cb 7f 85 ff ff ff ff  ..n.............
  +.  0090:  bc f2 87 85 ff ff ff ff 44 af 7f 85 ff ff ff ff  ........D.......
  +.  00a0:  bd be 7f 85 ff ff ff ff 26 d0 7f 85 ff ff ff ff  ........&.......
  +.  00b0:  6d a4 ff 85 ff ff ff ff ea 00 20 86 ff ff ff ff  m......... .....
  +.  00c0:  00 fe ff ff ff ff ff ff 57 14 4f 43 fc 7e 00 00  ........W.OC.~..
  +
  +1642373909693435 0xc550 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 2915700/2915700: 0xffffffff860172fc period: 1 addr: 0
  +... FP chain: nr:12
  +.....  0: ffffffffffffff80
  +.....  1: ffffffff860172fc
  +.....  2: ffffffff856e0ef3
  +.....  3: ffffffff857fcb0c
  +.....  4: ffffffff8587f2bc
  +.....  5: ffffffff857faf44
  +.....  6: ffffffff857fbebd
  +.....  7: ffffffff857fd026
  +.....  8: ffffffff85ffa46d
  +.....  9: ffffffff862000ea
  +..... 10: fffffffffffffe00
  +..... 11: 00007efc434f1457
  +... sample_read:
  +.... group nr 2
  +..... id 00000000001acbe6, value 0000000000000176, lost 0
  +..... id 00000000001acbf6, value 0000000000001862, lost 0
  +
  +0xc620@perf.data [0x30]: event: 3
  ...

This behavior is incorrect as in the case above 'perf inject' should
have done nothing. Fix this behavior by disabling separating samples
for a tool that requests it. Only request this for `perf inject` so as
to not affect other perf tools. With the patch and the test above
there are no differences between the orig.txt and new.txt.

Fixes: e4caec0d1af3d608 ("perf evsel: Add PERF_SAMPLE_READ sample related processing")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240729220620.2957754-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-inject.c | 1 +
 tools/perf/util/session.c   | 3 +++
 tools/perf/util/tool.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 333d8941ce4de..bcd510d9b4345 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2173,6 +2173,7 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.dont_split_sample_group = true,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a4f10de29ffe..c8f7634f9846c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1497,6 +1497,9 @@ static int deliver_sample_group(struct evlist *evlist,
 	int ret = -EINVAL;
 	struct sample_read_value *v = sample->read.group.values;
 
+	if (tool->dont_split_sample_group)
+		return deliver_sample_value(evlist, tool, event, sample, v, machine);
+
 	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
 		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index c957fb849ac63..62bbc9cec151b 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -85,6 +85,7 @@ struct perf_tool {
 	bool		namespace_events;
 	bool		cgroup_events;
 	bool		no_warn;
+	bool		dont_split_sample_group;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.43.0





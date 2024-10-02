Return-Path: <stable+bounces-80249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2041D98DCA0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADF01F27E1D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808671D1E6F;
	Wed,  2 Oct 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTxY5Hxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA741D04A8;
	Wed,  2 Oct 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879817; cv=none; b=koKXs+3gnpm3uNyyw32pb7KuSheDJ28O4uIBcmM9exXuDipqxBv1lvRI+JsObEnMJbpcippk2r4Eyr4cQgsvFU0X3QSx3D8Ousnr/HO0Jfo4uvynZ+9jkrRujNDxY12BHf+PTdFyWZap5k7DRdLQlEfwjaRA2F5W/A0/LgkQPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879817; c=relaxed/simple;
	bh=hyw2oYbtI5MSEJUahrZI86IwhsT5jrtNmj8zRI+EY1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxvhrfO7V3JHNFCqbJOJcfEY6eiTG8bZvacP8ArpAe5zK/5UTTCMI/wTmHxhYwkY+M8CQjHfYV8LWMmcxVKXV3dVJTGzN+sLRVoUwl3aWUxriGZoOw/FctD4kmNEbPiX+HQtk4Yzutw+ybu4Xb7Vq25sMec6aQwHp8CGAJ/N8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTxY5Hxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44815C4CEC2;
	Wed,  2 Oct 2024 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879816;
	bh=hyw2oYbtI5MSEJUahrZI86IwhsT5jrtNmj8zRI+EY1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yTxY5HxbMuvN8ZkK2WOI2GMKW4u9jtcRmTQNX3bR9a7qYATS3iKGkl9RAb8emGc/n
	 UnJN8zD8EFGidtlHNB5um9x5ZtlZ6kXh5tSr+G3Exn4F6+zKY4pgVtgbVXWW26GDlf
	 B7VImXWj92EsqB6Q6N/dvxMWlVSrI4STfCbdzCcs=
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
Subject: [PATCH 6.6 248/538] perf inject: Fix leader sampling inserting additional samples
Date: Wed,  2 Oct 2024 14:58:07 +0200
Message-ID: <20241002125802.042552480@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index eb3ef5c24b662..8aba056654679 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2200,6 +2200,7 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.dont_split_sample_group = true,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c6afba7ab1a51..277b2cbd51861 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1500,6 +1500,9 @@ static int deliver_sample_group(struct evlist *evlist,
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





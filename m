Return-Path: <stable+bounces-85372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2999E706
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC721F21D68
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC51E9078;
	Tue, 15 Oct 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yb2cYcAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287E1E7C34;
	Tue, 15 Oct 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992891; cv=none; b=Qa+DbYwDCy9voKC8q1zmQvjoeuEfBIebngoHiHnOP49Yu4um0czPjyPw5JT/zu6ZFwtrqo8cA61DHCaOvTdhC58GoA6uA5Fu3QjZaJMIEuMxgREigjeoHwBO5xvQGQF/rvE0RgkZe6wQb6GWizEn8X2FT8XWR9rtnRvztjmtN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992891; c=relaxed/simple;
	bh=y2Bwl3S5bKhGO+CkaIjAclA3p3qcmOFr/EE+LvEBqAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni6ljmeZKJT22kMsx7ITBbSiteO+vl52hAELCMglLImr2+1qq1EEBlxJGrbVUxRM1Xm2/PLtI423WosRCWF/1f2gQo0KrHxFJJ5L2qIDLkOpZ554p9gHiPVByxx+6X5Jy5y5DzBB+Y640aOkvTja/YrtWrNjGAmcOlGBb/5kF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yb2cYcAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D89C4CEC6;
	Tue, 15 Oct 2024 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992891;
	bh=y2Bwl3S5bKhGO+CkaIjAclA3p3qcmOFr/EE+LvEBqAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yb2cYcAFpWE6hIwnCfg0v6EEiKge+UX7m6CE98BE670NslViYDycQ7zWEaC7ua6n2
	 5V0E/hPhj20GUg4ZMp33/SJ+7YUnU4aFUwv/gAZhYJFD+mcEXdgkTKqF6/yo+b+rIf
	 xMrLtANq2SqyI9nkguxgDRPGpc9M48D38CXgu3Ew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 218/691] perf tools: Support reading PERF_FORMAT_LOST
Date: Tue, 15 Oct 2024 13:22:46 +0200
Message-ID: <20241015112449.012727885@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit f52679b78877f17e95a317e18a4c9c46cc3d845a ]

The recent kernel added lost count can be read from either read(2) or
ring buffer data with PERF_SAMPLE_READ.  As it's a variable length data
we need to access it according to the format info.

But for perf tools use cases, PERF_FORMAT_ID is always set.  So we can
only check PERF_FORMAT_LOST bit to determine the data format.

Add sample_read_value_size() and next_sample_read_value() helpers to
make it a bit easier to access.  Use them in all places where it reads
the struct sample_read_value.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220819003644.508916-5-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 79bcd34e0f3d ("perf inject: Fix leader sampling inserting additional samples")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/sample-parsing.c             | 14 +++++---
 tools/perf/util/event.h                       | 21 ++++++++++-
 tools/perf/util/evsel.c                       | 29 +++++++++------
 .../scripting-engines/trace-event-python.c    | 19 +++++++---
 tools/perf/util/session.c                     | 35 +++++++++++--------
 tools/perf/util/synthetic-events.c            | 32 +++++++++++++----
 6 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index c83a115141291..ac2c21d402a4b 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -86,10 +86,15 @@ static bool samples_same(const struct perf_sample *s1,
 			COMP(read.time_running);
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			for (i = 0; i < s1->read.group.nr; i++)
-				MCOMP(read.group.values[i]);
+			for (i = 0; i < s1->read.group.nr; i++) {
+				/* FIXME: check values without LOST */
+				if (read_format & PERF_FORMAT_LOST)
+					MCOMP(read.group.values[i]);
+			}
 		} else {
 			COMP(read.one.id);
+			if (read_format & PERF_FORMAT_LOST)
+				COMP(read.one.lost);
 		}
 	}
 
@@ -263,7 +268,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.data	= (void *)aux_data,
 		},
 	};
-	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
+	struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
 	struct perf_sample sample_out, sample_out_endian;
 	size_t i, sz, bufsz;
 	int err, ret = -1;
@@ -286,6 +291,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	} else {
 		sample.read.one.value = 0x08789faeb786aa87ULL;
 		sample.read.one.id    = 99;
+		sample.read.one.lost  = 1;
 	}
 
 	sz = perf_event__sample_event_size(&sample, sample_type, read_format);
@@ -370,7 +376,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
  */
 int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
+	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15, 20, 21, 22, 28, 29, 30, 31};
 	u64 sample_type;
 	u64 sample_regs;
 	size_t i;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 19ad64f2bd830..144c82f8e7ffd 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -62,7 +62,8 @@ struct stack_dump {
 
 struct sample_read_value {
 	u64 value;
-	u64 id;
+	u64 id;   /* only if PERF_FORMAT_ID */
+	u64 lost; /* only if PERF_FORMAT_LOST */
 };
 
 struct sample_read {
@@ -77,6 +78,24 @@ struct sample_read {
 	};
 };
 
+static inline size_t sample_read_value_size(u64 read_format)
+{
+	/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+	if (read_format & PERF_FORMAT_LOST)
+		return sizeof(struct sample_read_value);
+	else
+		return offsetof(struct sample_read_value, lost);
+}
+
+static inline struct sample_read_value *
+next_sample_read_value(struct sample_read_value *v, u64 read_format)
+{
+	return (void *)v + sample_read_value_size(read_format);
+}
+
+#define sample_read_group__for_each(v, nr, rf)		\
+	for (int __i = 0; __i < (int)nr; v = next_sample_read_value(v, rf), __i++)
+
 struct ip_callchain {
 	u64 nr;
 	u64 ips[];
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f4226f380d1c..1a6f42924cca8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1493,7 +1493,7 @@ static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
 }
 
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
-			     u64 val, u64 ena, u64 run)
+			     u64 val, u64 ena, u64 run, u64 lost)
 {
 	struct perf_counts_values *count;
 
@@ -1502,6 +1502,7 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
+	count->lost   = lost;
 
 	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
@@ -1510,7 +1511,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 {
 	u64 read_format = leader->core.attr.read_format;
 	struct sample_read_value *v;
-	u64 nr, ena = 0, run = 0, i;
+	u64 nr, ena = 0, run = 0, lost = 0;
 
 	nr = *data++;
 
@@ -1523,18 +1524,18 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		run = *data++;
 
-	v = (struct sample_read_value *) data;
-
-	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
-
-	for (i = 1; i < nr; i++) {
+	v = (void *)data;
+	sample_read_group__for_each(v, nr, read_format) {
 		struct evsel *counter;
 
-		counter = evlist__id2evsel(leader->evlist, v[i].id);
+		counter = evlist__id2evsel(leader->evlist, v->id);
 		if (!counter)
 			return -EINVAL;
 
-		evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
+		if (read_format & PERF_FORMAT_LOST)
+			lost = v->lost;
+
+		evsel__set_count(counter, cpu_map_idx, thread, v->value, ena, run, lost);
 	}
 
 	return 0;
@@ -2358,8 +2359,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 			if (data->read.group.nr > max_group_nr)
 				return -EFAULT;
-			sz = data->read.group.nr *
-			     sizeof(struct sample_read_value);
+
+			sz = data->read.group.nr * sample_read_value_size(read_format);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->read.group.values =
 					(struct sample_read_value *)array;
@@ -2368,6 +2369,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			OVERFLOW_CHECK_u64(array);
 			data->read.one.id = *array;
 			array++;
+
+			if (read_format & PERF_FORMAT_LOST) {
+				OVERFLOW_CHECK_u64(array);
+				data->read.one.lost = *array;
+				array++;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c0c010350bc2a..ec547bf99182b 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -622,15 +622,19 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 	return pylist;
 }
 
-static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
+static PyObject *get_sample_value_as_tuple(struct sample_read_value *value,
+					   u64 read_format)
 {
 	PyObject *t;
 
-	t = PyTuple_New(2);
+	t = PyTuple_New(3);
 	if (!t)
 		Py_FatalError("couldn't create Python tuple");
 	PyTuple_SetItem(t, 0, PyLong_FromUnsignedLongLong(value->id));
 	PyTuple_SetItem(t, 1, PyLong_FromUnsignedLongLong(value->value));
+	if (read_format & PERF_FORMAT_LOST)
+		PyTuple_SetItem(t, 2, PyLong_FromUnsignedLongLong(value->lost));
+
 	return t;
 }
 
@@ -661,12 +665,17 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 		Py_FatalError("couldn't create Python list");
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		for (i = 0; i < sample->read.group.nr; i++) {
-			PyObject *t = get_sample_value_as_tuple(&sample->read.group.values[i]);
+		struct sample_read_value *v = sample->read.group.values;
+
+		i = 0;
+		sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+			PyObject *t = get_sample_value_as_tuple(v, read_format);
 			PyList_SET_ITEM(values, i, t);
+			i++;
 		}
 	} else {
-		PyObject *t = get_sample_value_as_tuple(&sample->read.one);
+		PyObject *t = get_sample_value_as_tuple(&sample->read.one,
+							read_format);
 		PyList_SET_ITEM(values, 0, t);
 	}
 	pydict_set_item_string_decref(dict_sample, "values", values);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 562e9b8080272..7ba9dd1402ed2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1254,21 +1254,25 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 		       sample->read.time_running);
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		u64 i;
+		struct sample_read_value *value = sample->read.group.values;
 
 		printf(".... group nr %" PRIu64 "\n", sample->read.group.nr);
 
-		for (i = 0; i < sample->read.group.nr; i++) {
-			struct sample_read_value *value;
-
-			value = &sample->read.group.values[i];
+		sample_read_group__for_each(value, sample->read.group.nr, read_format) {
 			printf("..... id %016" PRIx64
-			       ", value %016" PRIx64 "\n",
+			       ", value %016" PRIx64,
 			       value->id, value->value);
+			if (read_format & PERF_FORMAT_LOST)
+				printf(", lost %" PRIu64, value->lost);
+			printf("\n");
 		}
-	} else
-		printf("..... id %016" PRIx64 ", value %016" PRIx64 "\n",
+	} else {
+		printf("..... id %016" PRIx64 ", value %016" PRIx64,
 			sample->read.one.id, sample->read.one.value);
+		if (read_format & PERF_FORMAT_LOST)
+			printf(", lost %" PRIu64, sample->read.one.lost);
+		printf("\n");
+	}
 }
 
 static void dump_event(struct evlist *evlist, union perf_event *event,
@@ -1381,6 +1385,9 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 
 	if (read_format & PERF_FORMAT_ID)
 		printf("... id           : %" PRI_lu64 "\n", read_event->id);
+
+	if (read_format & PERF_FORMAT_LOST)
+		printf("... lost         : %" PRI_lu64 "\n", read_event->lost);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
@@ -1440,14 +1447,14 @@ static int deliver_sample_group(struct evlist *evlist,
 				struct perf_tool *tool,
 				union  perf_event *event,
 				struct perf_sample *sample,
-				struct machine *machine)
+				struct machine *machine,
+				u64 read_format)
 {
 	int ret = -EINVAL;
-	u64 i;
+	struct sample_read_value *v = sample->read.group.values;
 
-	for (i = 0; i < sample->read.group.nr; i++) {
-		ret = deliver_sample_value(evlist, tool, event, sample,
-					   &sample->read.group.values[i],
+	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
 		if (ret)
 			break;
@@ -1471,7 +1478,7 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
 		return deliver_sample_group(evlist, tool, event, sample,
-					    machine);
+					    machine, read_format);
 	else
 		return deliver_sample_value(evlist, tool, event, sample,
 					    &sample->read.one, machine);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c69ad7a1a6a78..d020f286b9c1f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1436,11 +1436,12 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 			result += sizeof(u64);
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			result += sz;
+			sz = sample_read_value_size(read_format);
+			result += sz * sample->read.group.nr;
 		} else {
 			result += sizeof(u64);
+			if (read_format & PERF_FORMAT_LOST)
+				result += sizeof(u64);
 		}
 	}
 
@@ -1525,6 +1526,20 @@ void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 	*array = data->weight;
 }
 
+static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
+				     const struct perf_sample *sample)
+{
+	size_t sz = sample_read_value_size(read_format);
+	struct sample_read_value *v = sample->read.group.values;
+
+	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+		memcpy(array, v, sz);
+		array = (void *)array + sz;
+	}
+	return array;
+}
+
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
 				  const struct perf_sample *sample)
 {
@@ -1606,13 +1621,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			memcpy(array, sample->read.group.values, sz);
-			array = (void *)array + sz;
+			array = copy_read_group_values(array, read_format,
+						       sample);
 		} else {
 			*array = sample->read.one.id;
 			array++;
+
+			if (read_format & PERF_FORMAT_LOST) {
+				*array = sample->read.one.lost;
+				array++;
+			}
 		}
 	}
 
-- 
2.43.0





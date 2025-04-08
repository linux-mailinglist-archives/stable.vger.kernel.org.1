Return-Path: <stable+bounces-131528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECBA80AE9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96D6174AC3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB36281344;
	Tue,  8 Apr 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJIm3OIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C8280CFF;
	Tue,  8 Apr 2025 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116639; cv=none; b=Azx1104+jEfJq1JKtGHt5rbvknU4YUHiqHIxDNIqTQJ7k981obxpZqbYgeCh5rhWL+QfkC5UIFjJRupGyvH5p5YCl+9THe5dqgkeQ83JgJuxvdcn89LWPxlWzf/a0nhUJH9U9wGPxTZ+5rUn6C8tH6waUz6hgVDLJvf3kNLadfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116639; c=relaxed/simple;
	bh=xeqk4ac3rIPIrWDYncNq+3kJYcQR/1Wdc6BTvjCUBLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfA6HZLTyKWKgxPvFjHD4Icoip3s8/58vBjG/3RksczKCXZU6IdH9r8DrSwfaLZwgedzRGsHo0mhgVHWvIMBTJ4+H+XIcmcSc5FFZNn6fh6DB7OOPWX8yw1LIy9noVCD3P5ZWddHs9Lrr4ysrrgTlMrRHP9SLyDXEJMn4VEU99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJIm3OIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA0CC4CEE5;
	Tue,  8 Apr 2025 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116639;
	bh=xeqk4ac3rIPIrWDYncNq+3kJYcQR/1Wdc6BTvjCUBLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJIm3OIPqKbTTJ1KGbzWvqCnkZxYW2L0kJRN1eWwoo88UUkRf1f8Rz75EjQ/3Zbbv
	 QmKGYzK2oyB32XWZUN4hgzByWpnA1JeUWg+9a5IXZQkDsMnMeNlbM59uqQ6sNoJeUO
	 wfFGTUgZ3bJ4xRXx6n2suF4S5woLafMP4bUmhcQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 213/423] perf python: Dont keep a raw_data pointer to consumed ring buffer space
Date: Tue,  8 Apr 2025 12:48:59 +0200
Message-ID: <20250408104850.693158941@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit f3fed3ae34d606819d87a63d970cc3092a5be7ab ]

When processing tracepoints the perf python binding was parsing the
event before calling perf_mmap__consume(&md->core) in
pyrf_evlist__read_on_cpu().

But part of this event parsing was to set the perf_sample->raw_data
pointer to the payload of the event, which then could be overwritten by
other event before tracepoint fields were asked for via event.prev_comm
in a python program, for instance.

This also happened with other fields, but strings were were problems
were surfacing, as there is UTF-8 validation for the potentially garbled
data.

This ended up showing up as (with some added debugging messages):

  ( field 'prev_comm' ret=0x7f7c31f65110, raw_size=68 )  ( field 'prev_pid' ret=0x7f7c23b1bed0, raw_size=68 )  ( field 'prev_prio' ret=0x7f7c239c0030, raw_size=68 )  ( field 'prev_state' ret=0x7f7c239c0250, raw_size=68 ) time 14771421785867 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x303a32313175 ==>
  ( XXX '��' len=16, raw_size=68)  ( field 'next_comm' ret=(nil), raw_size=68 ) Traceback (most recent call last):
   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
     main()
   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
     event.next_comm,
     ^^^^^^^^^^^^^^^
  AttributeError: 'perf.sample_event' object has no attribute 'next_comm'

When event.next_comm was asked for, the PyUnicode_FromString() python
API would fail and that tracepoint field wouldn't be available, stopping
the tools/perf/python/tracepoint.py test tool.

But, since we already do a copy of the whole event in pyrf_event__new,
just use it and while at it remove what was done in in e8968e654191390a
("perf python: Fix pyrf_evlist__read_on_cpu event consuming") because we
don't really need to wait for parsing the sample before declaring the
event as consumed.

This copy is questionable as is now, as it limits the maximum event +
sample_type and tracepoint payload to sizeof(union perf_event), this all
has been "working" because 'struct perf_event_mmap2', the largest entry
in 'union perf_event' is:

  $ pahole -C perf_event ~/bin/perf | grep mmap2
	struct perf_record_mmap2   mmap2;              /*     0  4168 */
  $

Fixes: bae57e3825a3dded ("perf python: Add support to resolve tracepoint fields")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250312203141.285263-6-acme@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/python.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3cd2ea99d6b6c..71c37bde178a2 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1018,11 +1018,9 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		pevent->evsel = evsel;
 
-		err = evsel__parse_sample(evsel, event, &pevent->sample);
-
-		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
 
+		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
 		if (err) {
 			Py_DECREF(pyevent);
 			return PyErr_Format(PyExc_OSError,
-- 
2.39.5





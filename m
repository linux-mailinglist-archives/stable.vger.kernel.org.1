Return-Path: <stable+bounces-130569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6272A8057A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495CD4A5B02
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FC52698BC;
	Tue,  8 Apr 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ev2dSJoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDE267B9C;
	Tue,  8 Apr 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114062; cv=none; b=SZ0KNH6MDrgjMEBxpw7+dBrAQ0eXW7niFG2d7cNhL46EnshccDVlxWy4PKB8LVmWWRvpQaZwcXE0ddDd50I/e3vK433LbHT5W4MpAivTmnqGy+BlB9emOF5ujuzV7fuqMOLm4G9pKZArzoiw6HX5sZPyHVUSWiI44vHQ5JdwF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114062; c=relaxed/simple;
	bh=yypgEYnn934FpRHr6hy0AAYB+IriqCUxPMLMizSrVSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2fUVwdYQt+mAJFd9+0+mpfnRs0j4IftJd/i7YGTwoZXkSV2crBti7tUt9h52CGAtFkWNmrYDWgxLcMI4aWOI+Mv1YtElM6D17EoOMBSf93PSc1/DAuG4jpdj7T4JOykIMSiELaqeT1dZjp4pPq2ZtscsuzU9JMDWG9Ln/nuJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ev2dSJoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2155BC4CEE5;
	Tue,  8 Apr 2025 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114062;
	bh=yypgEYnn934FpRHr6hy0AAYB+IriqCUxPMLMizSrVSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev2dSJoMkSj3kxG9LdjZzC5i5fRq6+ZW+OVDtor15FxCpHD095KGZu+geMkBi0XcU
	 +ezI44NzXw8Z5UCn1q89aZnwKydLeg5XarD6Ayi1yMBpAFefoDiYSCCyG8uX8ZqlNS
	 NVE+C8wBd/KKVLkEyftldug5OpGJecZdZS2WMrtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 123/154] perf python: Check if there is space to copy all the event
Date: Tue,  8 Apr 2025 12:51:04 +0200
Message-ID: <20250408104819.256125522@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
References: <20250408104815.295196624@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 89aaeaf84231157288035b366cb6300c1c6cac64 ]

The pyrf_event__new() method copies the event obtained from the perf
ring buffer to a structure that will then be turned into a python object
for further consumption, so it copies perf_event.header.size bytes to
its 'event' member:

  $ pahole -C pyrf_event /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
  struct pyrf_event {
  	PyObject                   ob_base;              /*     0    16 */
  	struct evsel *             evsel;                /*    16     8 */
  	struct perf_sample         sample;               /*    24   312 */

  	/* XXX last struct has 7 bytes of padding, 2 holes */

  	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
  	union perf_event           event;                /*   336  4168 */

  	/* size: 4504, cachelines: 71, members: 4 */
  	/* member types with holes: 1, total: 2 */
  	/* paddings: 1, sum paddings: 7 */
  	/* last cacheline: 24 bytes */
  };

  $

It was doing so without checking if the event just obtained has more
than that space, fix it.

This isn't a proper, final solution, as we need to support larger
events, but for the time being we at least bounds check and document it.

Fixes: 877108e42b1b9ba6 ("perf tools: Initial python binding")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250312203141.285263-7-acme@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/python.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 594c738e4930f..3cfaa843b6a9d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -537,6 +537,11 @@ static PyObject *pyrf_event__new(union perf_event *event)
 	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
 		return NULL;
 
+	// FIXME this better be dynamic or we need to parse everything
+	// before calling perf_mmap__consume(), including tracepoint fields.
+	if (sizeof(pevent->event) < event->header.size)
+		return NULL;
+
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL)
-- 
2.39.5





Return-Path: <stable+bounces-48358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1898FE8AA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E877284D3B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5E197A77;
	Thu,  6 Jun 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBfFREdv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E06196D8C;
	Thu,  6 Jun 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682920; cv=none; b=set8mCAqvsZXOd/C9j4S3KjpJjSqN9ScpuRqYkQ//pjNSmE/gh1BSnDzyX8kJFSTvsRoHLospi9CYiKcG1lF8F4ugWiC0BUdZyat+WKSvzqZEXpN4i3j/QYvXCf7wvVGr0APzzPHc7aXrC1UL05rdSlEdmxke0u/qItkoT1305Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682920; c=relaxed/simple;
	bh=HKzUL7aHnbZ13mO6lNmw8nteaKbGJrnxXBMJNAJ+eKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0SrJ9PpI+hXKfWkpHgbQK1LwwWaKVlO2cyMETs9+C888ivhzC/s3EY0mB9ED0Eex+Am0gv033qKVFhU8kSRLkzHJ5TngsXQkZp2uYkBU/luFkw7m0pRXezKapZBICkvear+zyn+AW0shxlanb3N2mWtDuLd6y5APLUnzXlBls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBfFREdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA3C32781;
	Thu,  6 Jun 2024 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682920;
	bh=HKzUL7aHnbZ13mO6lNmw8nteaKbGJrnxXBMJNAJ+eKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBfFREdvAgJ9T6f3fhcpRltEXCjIqhwuPGh6TlO8eFYJJCZhlnKMJaml0sIvkTbWn
	 jtLgucpTIPZ1eDHzUxxfsemWsk4gwS3MnBZA59d43jBKPSTBBy2UMXNGWHHQv45iCN
	 1pSaaJam3f1Te0gHBeCLBppRaFcn5y0Tl0zifUYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Song Liu <song@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 051/374] perf docs: Document bpf event modifier
Date: Thu,  6 Jun 2024 16:00:30 +0200
Message-ID: <20240606131653.537196703@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit eb4d27cf9aef3e6c9bcaf8fa1a1cadc2433d847b ]

Document that 'b' is used as a modifier to make an event use a BPF
counter.

Fixes: 01bd8efcec444468 ("perf stat: Introduce ':b' modifier")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Song Liu <song@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lore.kernel.org/r/20240416170014.985191-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Documentation/perf-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 3b12595193c9f..6bf2468f59d31 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -71,6 +71,7 @@ counted. The following modifiers exist:
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
  e - group or event are exclusive and do not share the PMU
+ b - use BPF aggregration (see perf stat --bpf-counters)
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
-- 
2.43.0





Return-Path: <stable+bounces-96988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A39E232F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BB6B436F7
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362D1F7560;
	Tue,  3 Dec 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0dNJWHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AB1DA3D;
	Tue,  3 Dec 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239194; cv=none; b=ebK1jDN8mxb8y3hbbqyHKjZHy1i+kz3kzLTz8tMCwIhok21+BqsOUpCGM+LS8D+6g5BXWZ0CkTXOz5dZKkFTgPY+O297mc/W4Beryr2Kjuy9kWdWBu7wuPOKIZM7UbNKxfijOc5g50y3Bh7rkB1MEQKosMPGCT5c/RR4pKcrBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239194; c=relaxed/simple;
	bh=3aUDGQSaMCnjE9ixGNXeYu6KfIwrNZBaejFWr8ka81c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nkc9eKPrkc/jbDNAuhKKTsJeLcG64WGdjnwgc6RMGBbb+5HsBNktMYAPicBdecTfDewq+XHU8Y0QpgLGbopH6inK4NGZ4zaUD8yqI92stLnNLnoR9wdEkTEL2FGPHLCf+mVIoCkkINWccjoQhYmsr//nFgz7o0ES0+gmFjlmHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0dNJWHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8081FC4CEDD;
	Tue,  3 Dec 2024 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239194;
	bh=3aUDGQSaMCnjE9ixGNXeYu6KfIwrNZBaejFWr8ka81c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0dNJWHdqQtRfZHdVYcia84GaBqRCp3muDXs2umR+yYSmlTqAzOIoDqWKtEkUuPav
	 W4qtQ2482x+kiHknXuQS63zT4x5KDZEoEO2QlijvHKb5fjFP2dQb0WUGJ8VSBhHUjE
	 pRbdY/fZoVnrijBIQ5L2DMx0e6KfOHeDaKn3gIbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 531/817] perf trace: Fix tracing itself, creating feedback loops
Date: Tue,  3 Dec 2024 15:41:43 +0100
Message-ID: <20241203144016.626845259@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Howard Chu <howardchu95@gmail.com>

[ Upstream commit fe4f9b4124967ffb75d66994520831231b779550 ]

There exists a pids_filtered map in augmented_raw_syscalls.bpf.c that
ceases to provide functionality after the BPF skeleton migration done
in:

5e6da6be3082f77b ("perf trace: Migrate BPF augmentation to use a skeleton")

Before the migration, pid_filtered map works, courtesy of Arnaldo
Carvalho de Melo <acme@kernel.org>:

  ⬢ [acme@toolbox perf-tools]$ git log --oneline -5
  6f769c3458b6cf2d (HEAD) perf tests trace+probe_vfs_getname.sh: Accept quotes surrounding the filename
  7777ac3dfe29f55d perf test trace+probe_vfs_getname.sh: Remove stray \ before /
  33d9c5062113a4bd perf script python: Add stub for PMU symbol to the python binding
  e59fea47f83e8a9a perf symbols: Fix DSO kernel load and symbol process to correctly map DSO to its long_name, type and adjust_symbols
  878460e8d0ff84a0 perf build: Remove -Wno-unused-but-set-variable from the flex flags when building with clang < 13.0.0

  root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_syscalls.o -e write* --max-events=30  &
  [1] 180632
  root@x1:/home/acme/git/perf-tools#      0.000 ( 0.051 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
       0.115 ( 0.010 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
       0.916 ( 0.068 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 246)                         = 246
       1.699 ( 0.047 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       2.167 ( 0.041 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       2.739 ( 0.042 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       3.138 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       3.477 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       3.738 ( 0.023 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       3.946 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       4.195 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
       4.212 ( 0.026 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
       4.285 ( 0.006 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
       4.445 ( 0.018 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 260)                         = 260
       4.508 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 124)                         = 124
       4.592 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 116)                         = 116
       4.666 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 130)                         = 130
       4.715 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 95)                          = 95
       4.765 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 102)                         = 102
       4.815 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 79)                          = 79
       4.890 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 57)                          = 57
       4.937 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 89)                          = 89
       5.009 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 112)                         = 112
       5.059 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 112)                         = 112
       5.116 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 79)                          = 79
       5.152 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 33)                          = 33
       5.215 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 37)                          = 37
       5.293 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 128)                         = 128
       5.339 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 89)                          = 89
       5.384 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 100)                         = 100

  [1]+  Done                    perf trace -e /tmp/augmented_raw_syscalls.o -e write* --max-events=30
  root@x1:/home/acme/git/perf-tools#

No events for the 'perf trace' (pid 180632), i.e. no feedback loop.

If we leave it running:

  root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_syscalls.o -e landlock_add_rule &
  [1] 181068
  root@x1:/home/acme/git/perf-tools#

  And then look at what maps it sets up:

  root@x1:/home/acme/git/perf-tools# bpftool map | grep pids_filtered -A3
  1190: hash  name pids_filtered  flags 0x0
          key 4B  value 1B  max_entries 64  memlock 7264B
          btf_id 1613
          pids perf(181068)
  root@x1:/home/acme/git/perf-tools#

  And ask for dumping its contents:

  We see that we are _also_ setting it to filter those:

  root@x1:/home/acme/git/perf-tools# bpftool map dump id 1190
  [{
          "key": 181068,
          "value": 1
      },{
          "key": 156801,
          "value": 1
      }
  ]

Now testing the migration commit:

  perf $ git log
  commit 5e6da6be3082f77be06894a1a94d52a90b4007dc (HEAD)
  Author: Ian Rogers <irogers@google.com>
  Date:   Thu Aug 10 11:48:51 2023 -0700

      perf trace: Migrate BPF augmentation to use a skeleton

  perf $ ./perf trace -e write --max-events=10 & echo #!
  [1] 1808653
  perf $
       0.000 ( 0.010 ms): :1808671/1808671 write(fd: 1, buf: 0x6003f5b26fc0, count: 11) = 11
       0.162 (         ): perf/1808653 write(fd: 2, buf: 0x7fffc2174e50, count: 11)     ...
       0.174 (         ): perf/1808653 write(fd: 2, buf: 0x74ce21804563, count: 1)      ...
       0.184 (         ): perf/1808653 write(fd: 2, buf: 0x57b936589052, count: 5)

The feedback loop is there.

Keep it running, look into the bpf map:

  perf $ bpftool map | grep pids_filtered
  10675: hash  name pids_filtered  flags 0x0

  perf $ bpftool map dump id 10675
  []

The map is empty.

Now, this commit:

  64917f4df048a064 ("perf trace: Use heuristic when deciding if a syscall tracepoint "const char *" field is really a string")

Temporarily fixed the feedback loop for perf trace -e write, that's
because before using the heuristic, write is hooked to sys_enter_openat:

  perf $ git log
  commit 83a0943b1870944612a8aa0049f910826ebfd4f7 (HEAD)
  Author: Arnaldo Carvalho de Melo <acme@redhat.com>
  Date:   Thu Aug 17 12:11:51 2023 -0300

      perf trace: Use the augmented_raw_syscall BPF skel only for tracing syscalls

  perf $ ./perf trace -e write --max-events=10 -v 2>&1 | grep Reusing
  Reusing "openat" BPF sys_enter augmenter for "write"

And after the heuristic fix, it's unaugmented:

  perf $ git log
  commit 64917f4df048a0649ea7901c2321f020e71e6f24 (HEAD)
  Author: Arnaldo Carvalho de Melo <acme@redhat.com>
  Date:   Thu Aug 17 15:14:21 2023 -0300

      perf trace: Use heuristic when deciding if a syscall tracepoint "const char *" field is really a string

  perf $ ./perf trace -e write --max-events=10 -v 2>&1 | grep Reusing
  perf $

After using the heuristic, write is hooked to syscall_unaugmented, which
returns 1.

  SEC("tp/raw_syscalls/sys_enter")
  int syscall_unaugmented(struct syscall_enter_args *args)
  {
  	return 1;
  }

If the BPF program returns 1, the tracepoint filter will filter it
(since the tracepoint filter for perf is correctly set), but before the
heuristic, when it was hooked to a sys_enter_openat(), which is a BPF
program that calls bpf_perf_event_output() and writes to the buffer, it
didn't get filtered, thus creating feedback loop. So switching write to
unaugmented accidentally fixed the problem.

But some syscalls are not so lucky, for example newfstatat:
perf $ ./perf trace -e newfstatat --max-events=100 & echo #!
[1] 2166948

   457.718 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...
   457.749 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/2166950/ns/mnt", statbuf: 0x7fff0132aa80) ...
   457.962 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...

Currently, write is augmented by the new BTF general augmenter (which
calls bpf_perf_event_output()). The problem, which luckily got fixed,
resurfaced, and that’s how it was discovered.

Fixes: 5e6da6be3082f77b ("perf trace: Migrate BPF augmentation to use a skeleton")
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241030052431.2220130-1-howardchu95@gmail.com
[ Check if trace->skel is non-NULL, as it is only initialized if trace->trace_syscalls is set ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5298118ffb15f..c9399bf07c4cf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3922,6 +3922,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 					sizeof(__u32), BPF_ANY);
 		}
 	}
+
+	if (trace->skel)
+		trace->filter_pids.map = trace->skel->maps.pids_filtered;
 #endif
 	err = trace__set_filter_pids(trace);
 	if (err < 0)
-- 
2.43.0





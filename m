Return-Path: <stable+bounces-82072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4249994AE8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375101F23C95
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465451DDC24;
	Tue,  8 Oct 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0p0cryt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035781DA60C;
	Tue,  8 Oct 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391071; cv=none; b=VlXyCZiwqIsrugrzzzntDDLDlMiAGV4Spw3IUPOZJtT9SdT0d1A/jxwpGq5MX2kDTIpp2LkQIE++pluw07YTKr0cO0mCx4SKVWoOd5uEdeBwFKDeT+02lYpZG2Peb9pWH2Rx/FlpwYKCo1wqGfhroL2CHRVH/84br21kOF24k5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391071; c=relaxed/simple;
	bh=b4LkmvcjeJFCkjDIhv+Fa7Qcb/krsIcDr5W7IhxM8JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkP3iCJIaW24GQ3QGWkNZwJKCEmC0JBLhxqx+p14lymWdYaFo3w+G2fmnQRjUv3x0EO2QPID4zE807cItzvAW19/CmU1ks3Gvzht6v0tHyNQVuN/W8LwjRfEUuUfZY1znefuW1OXM3PYfQjlvGpxsLYDJf+NEpf4NPsZ9onD/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0p0cryt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5B3C4CEC7;
	Tue,  8 Oct 2024 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391070;
	bh=b4LkmvcjeJFCkjDIhv+Fa7Qcb/krsIcDr5W7IhxM8JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0p0cryt5s1rDJDDcSqMjvBehhb5UwQH+gdWU3NWd7OuVJkF55J7Ozucu0HGMmsYcG
	 bZo8oVNO6WERso7uRDyERJgwpP09+P6z9T1r/sUMMxEVYdwHDfr5H/q5QbQOg7SI0X
	 l8tG7/NQGr//yf0feW+Eh4Mwp1xZSkoRGQvGEY1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.10 481/482] perf report: Fix segfault when sym sort key is not used
Date: Tue,  8 Oct 2024 14:09:04 +0200
Message-ID: <20241008115707.437679656@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

commit 9af2efee41b27a0f386fb5aa95d8d0b4b5d9fede upstream.

The fields in the hist_entry are filled on-demand which means they only
have meaningful values when relevant sort keys are used.

So if neither of 'dso' nor 'sym' sort keys are used, the map/symbols in
the hist entry can be garbage.  So it shouldn't access it
unconditionally.

I got a segfault, when I wanted to see cgroup profiles.

  $ sudo perf record -a --all-cgroups --synth=cgroup true

  $ sudo perf report -s cgroup

  Program received signal SIGSEGV, Segmentation fault.
  0x00005555557a8d90 in map__dso (map=0x0) at util/map.h:48
  48		return RC_CHK_ACCESS(map)->dso;
  (gdb) bt
  #0  0x00005555557a8d90 in map__dso (map=0x0) at util/map.h:48
  #1  0x00005555557aa39b in map__load (map=0x0) at util/map.c:344
  #2  0x00005555557aa592 in map__find_symbol (map=0x0, addr=140736115941088) at util/map.c:385
  #3  0x00005555557ef000 in hists__findnew_entry (hists=0x555556039d60, entry=0x7fffffffa4c0, al=0x7fffffffa8c0, sample_self=true)
      at util/hist.c:644
  #4  0x00005555557ef61c in __hists__add_entry (hists=0x555556039d60, al=0x7fffffffa8c0, sym_parent=0x0, bi=0x0, mi=0x0, ki=0x0,
      block_info=0x0, sample=0x7fffffffaa90, sample_self=true, ops=0x0) at util/hist.c:761
  #5  0x00005555557ef71f in hists__add_entry (hists=0x555556039d60, al=0x7fffffffa8c0, sym_parent=0x0, bi=0x0, mi=0x0, ki=0x0,
      sample=0x7fffffffaa90, sample_self=true) at util/hist.c:779
  #6  0x00005555557f00fb in iter_add_single_normal_entry (iter=0x7fffffffa900, al=0x7fffffffa8c0) at util/hist.c:1015
  #7  0x00005555557f09a7 in hist_entry_iter__add (iter=0x7fffffffa900, al=0x7fffffffa8c0, max_stack_depth=127, arg=0x7fffffffbce0)
      at util/hist.c:1260
  #8  0x00005555555ba7ce in process_sample_event (tool=0x7fffffffbce0, event=0x7ffff7c14128, sample=0x7fffffffaa90, evsel=0x555556039ad0,
      machine=0x5555560388e8) at builtin-report.c:334
  #9  0x00005555557b30c8 in evlist__deliver_sample (evlist=0x555556039010, tool=0x7fffffffbce0, event=0x7ffff7c14128,
      sample=0x7fffffffaa90, evsel=0x555556039ad0, machine=0x5555560388e8) at util/session.c:1232
  #10 0x00005555557b32bc in machines__deliver_event (machines=0x5555560388e8, evlist=0x555556039010, event=0x7ffff7c14128,
      sample=0x7fffffffaa90, tool=0x7fffffffbce0, file_offset=110888, file_path=0x555556038ff0 "perf.data") at util/session.c:1271
  #11 0x00005555557b3848 in perf_session__deliver_event (session=0x5555560386d0, event=0x7ffff7c14128, tool=0x7fffffffbce0,
      file_offset=110888, file_path=0x555556038ff0 "perf.data") at util/session.c:1354
  #12 0x00005555557affaf in ordered_events__deliver_event (oe=0x555556038e60, event=0x555556135aa0) at util/session.c:132
  #13 0x00005555557bb605 in do_flush (oe=0x555556038e60, show_progress=false) at util/ordered-events.c:245
  #14 0x00005555557bb95c in __ordered_events__flush (oe=0x555556038e60, how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:324
  #15 0x00005555557bba46 in ordered_events__flush (oe=0x555556038e60, how=OE_FLUSH__ROUND) at util/ordered-events.c:342
  #16 0x00005555557b1b3b in perf_event__process_finished_round (tool=0x7fffffffbce0, event=0x7ffff7c15bb8, oe=0x555556038e60)
      at util/session.c:780
  #17 0x00005555557b3b27 in perf_session__process_user_event (session=0x5555560386d0, event=0x7ffff7c15bb8, file_offset=117688,
      file_path=0x555556038ff0 "perf.data") at util/session.c:1406

As you can see the entry->ms.map was NULL even if he->ms.map has a
value.  This is because 'sym' sort key is not given, so it cannot assume
whether he->ms.sym and entry->ms.sym is the same.  I only checked the
'sym' sort key here as it implies 'dso' behavior (so maps are the same).

Fixes: ac01c8c4246546fd ("perf hist: Update hist symbol when updating maps")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Matt Fleming <matt@readmodwrite.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/r/20240826221045.1202305-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -636,7 +636,7 @@ static struct hist_entry *hists__findnew
 			 * mis-adjust symbol addresses when computing
 			 * the history counter to increment.
 			 */
-			if (he->ms.map != entry->ms.map) {
+			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
 					u64 addr = he->ms.sym->start;
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);




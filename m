Return-Path: <stable+bounces-99602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0679E726A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38142838A3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942981537D4;
	Fri,  6 Dec 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlQVGTvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19613D508;
	Fri,  6 Dec 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497730; cv=none; b=uJRmGvIXfHy5GhArSMqBkT6hAB8GGILcgX0HAg53o6MFXE9W7UKSGe6DuHkzIKJqNVQEVIGtUk0k8fsracejUI3K0FZKLcUZr0OHIhcDy6/6Q5Rs9Nvb86BWDMNm01H0K5S40HvrSIlcc2w6yGz7LlttmJBEc4cF7fCTKHq3Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497730; c=relaxed/simple;
	bh=/KHmmMN//ag7xujMdMxLj1eVbKTJ95RJVL3F1Aa4kg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNvjrTRzJA0fQ7DG2pwhHYLlULmQOlb4AzuXUoxkrLtKy2UN9dgnYUYZaB2Obz26EO6gYK4kz5vBfqUAvPvaaTXPk4KnGcRWZOUvMrdT9Ck0si7Cou7sFwaRDWEC4PJby2y1zewnRgpEVPvl2QpOFmGMV9UaBqiU2yIIqvxiPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlQVGTvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB4FC4CED1;
	Fri,  6 Dec 2024 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497730;
	bh=/KHmmMN//ag7xujMdMxLj1eVbKTJ95RJVL3F1Aa4kg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlQVGTvQo8f9+Lpq3qPa7EvliiQZ1atNCwfCtUaUd/kyJyWJEw2mWBdOZVixf89Bn
	 RrGhXqXyeBNWxa4kL/iTepX/yOMhM0tZohrPCBIcULgGvOK9n6jZbV9mG4yTvNnxEr
	 lczHlRXb6vUpPdlOyLA684WiiRvVXuGXGxJiBghw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 349/676] perf probe: Correct demangled symbols in C++ program
Date: Fri,  6 Dec 2024 15:32:48 +0100
Message-ID: <20241206143706.978496012@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit 314909f13cc12d47c468602c37dace512d225eeb ]

An issue can be observed when probe C++ demangled symbol with steps:

  # nm test_cpp_mangle | grep print_data
    0000000000000c94 t _GLOBAL__sub_I__Z10print_datai
    0000000000000afc T _Z10print_datai
    0000000000000b38 T _Z10print_dataR5Point

  # perf probe -x /home/niayan01/test_cpp_mangle -F --demangle
    ...
    print_data(Point&)
    print_data(int)
    ...

  # perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
    probe-definition(0): test=print_data(int)
    symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
    0 arguments
    Open Debuginfo file: /home/niayan01/test_cpp_mangle
    Try to find probe point from debuginfo.
    Symbol print_data(int) address found : afc
    Matched function: print_data [2ccf]
    Probe point found: print_data+0
    Found 1 probe_trace_events.
    Opening /sys/kernel/tracing//uprobe_events write=1
    Opening /sys/kernel/tracing//README write=0
    Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xb38
    ...

When tried to probe symbol "print_data(int)", the log shows:

    Symbol print_data(int) address found : afc

The found address is 0xafc - which is right with verifying the output
result from nm. Afterwards when write event, the command uses offset
0xb38 in the last log, which is a wrong address.

The dwarf_diename() gets a common function name, in above case, it
returns string "print_data". As a result, the tool parses the offset
based on the common name. This leads to probe at the wrong symbol
"print_data(Point&)".

To fix the issue, use the die_get_linkage_name() function to retrieve
the distinct linkage name - this is the mangled name for the C++ case.
Based on this unique name, the tool can get a correct offset for
probing. Based on DWARF doc, it is possible the linkage name is missed
in the DIE, it rolls back to use dwarf_diename().

After:

  # perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
    probe-definition(0): test=print_data(int)
    symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
    0 arguments
    Open Debuginfo file: /home/niayan01/test_cpp_mangle
    Try to find probe point from debuginfo.
    Symbol print_data(int) address found : afc
    Matched function: print_data [2d06]
    Probe point found: print_data+0
    Found 1 probe_trace_events.
    Opening /sys/kernel/tracing//uprobe_events write=1
    Opening /sys/kernel/tracing//README write=0
    Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xafc
    Added new event:
      probe_test_cpp_mangle:test (on print_data(int) in /home/niayan01/test_cpp_mangle)

    You can now use it in all perf tools, such as:

            perf record -e probe_test_cpp_mangle:test -aR sleep 1

  # perf --debug verbose=3 probe -x test_cpp_mangle --add "test2=print_data(Point&)"
    probe-definition(0): test2=print_data(Point&)
    symbol:print_data(Point&) file:(null) line:0 offset:0 return:0 lazy:(null)
    0 arguments
    Open Debuginfo file: /home/niayan01/test_cpp_mangle
    Try to find probe point from debuginfo.
    Symbol print_data(Point&) address found : b38
    Matched function: print_data [2ccf]
    Probe point found: print_data+0
    Found 1 probe_trace_events.
    Opening /sys/kernel/tracing//uprobe_events write=1
    Parsing probe_events: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0x0000000000000afc
    Group:probe_test_cpp_mangle Event:test probe:p
    Opening /sys/kernel/tracing//README write=0
    Writing event: p:probe_test_cpp_mangle/test2 /home/niayan01/test_cpp_mangle:0xb38
    Added new event:
      probe_test_cpp_mangle:test2 (on print_data(Point&) in /home/niayan01/test_cpp_mangle)

    You can now use it in all perf tools, such as:

            perf record -e probe_test_cpp_mangle:test2 -aR sleep 1

Fixes: fb1587d869a3 ("perf probe: List probes with line number and file name")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20241012141432.877894-1-leo.yan@arm.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c816191564bdf..c0c8d7f9514b0 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1745,8 +1745,21 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 
 	/* Find a corresponding function (name, baseline and baseaddr) */
 	if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
-		/* Get function entry information */
-		func = basefunc = dwarf_diename(&spdie);
+		/*
+		 * Get function entry information.
+		 *
+		 * As described in the document DWARF Debugging Information
+		 * Format Version 5, section 2.22 Linkage Names, "mangled names,
+		 * are used in various ways, ... to distinguish multiple
+		 * entities that have the same name".
+		 *
+		 * Firstly try to get distinct linkage name, if fail then
+		 * rollback to get associated name in DIE.
+		 */
+		func = basefunc = die_get_linkage_name(&spdie);
+		if (!func)
+			func = basefunc = dwarf_diename(&spdie);
+
 		if (!func ||
 		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
-- 
2.43.0





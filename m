Return-Path: <stable+bounces-229585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOiaAM5swWmqTAQAu9opvQ
	(envelope-from <stable+bounces-229585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEEF2F88E0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 694D6301E5CB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223C3AC0C2;
	Mon, 23 Mar 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mNf30NkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E83B19AC;
	Mon, 23 Mar 2026 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282318; cv=none; b=YjHuF4OarKwA5gHc6Ik1MfW+Dq5wE6HKSsinv7+RW4tDpV5xPY4tWdH2o1aOeAuEA2djDfQJfvIjqUcER1S7lbGYgx2F0WuR/LG2EZPhUvQQ9TBahgUcl9sZl4B4xDJ1SdR5EQDUXeqZACtS97CFtTYR/mTf2PbbhmvmEu9MhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282318; c=relaxed/simple;
	bh=kHwjnWTeewhXXdTUsIscWhSrRl3iPZYqGH/wsbmm35A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jonnu4EgfVXbG1MqlgkfTxXg1xWL8BvAloZ2lVIPAudIyg1ZowHpdY/jeZl8bucYNgWEuRDAVjKKgnw9wTmDBM2GBU9p1HbEueLfNDYKSojVkM2lQ9R4nhfTGTsDfbwMXbVpk89iF1DjT03oeMuAuvNkXmxHMZ7gHSNNvoxWABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mNf30NkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614D1C2BCB3;
	Mon, 23 Mar 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282317;
	bh=kHwjnWTeewhXXdTUsIscWhSrRl3iPZYqGH/wsbmm35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNf30NkAjC527+uktE4HwC6+JyivtsRwM445Cg4V8erWiwISWo11RwyyyowG//bDh
	 5A1bb3hGedZY7xUiRh/NJyxZX1sS842W3MVzSh0dmMCEVmy3aH1RcQz0C2Jty08JJ7
	 qf4D0bb1HgMTC6mdeP2J/II2y9ze/VBFta+/M7wY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Latypov <dlatypov@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/481] kunit: tool: make parser preserve whitespace when printing test log
Date: Mon, 23 Mar 2026 14:41:34 +0100
Message-ID: <20260323134528.012259478@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229585-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7BEEF2F88E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Latypov <dlatypov@google.com>

[ Upstream commit c2bb92bc4ea13842fdd27819c0d5b48df2b86ea5 ]

Currently, kunit_parser.py is stripping all leading whitespace to make
parsing easier. But this means we can't accurately show kernel output
for failing tests or when the kernel crashes.

Embarassingly, this affects even KUnit's own output, e.g.
[13:40:46] Expected 2 + 1 == 2, but
[13:40:46] 2 + 1 == 3 (0x3)
[13:40:46] not ok 1 example_simple_test
[13:40:46] [FAILED] example_simple_test

After this change, here's what the output in context would look like
[13:40:46] =================== example (4 subtests) ===================
[13:40:46] # example_simple_test: initializing
[13:40:46] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[13:40:46] Expected 2 + 1 == 2, but
[13:40:46]     2 + 1 == 3 (0x3)
[13:40:46] [FAILED] example_simple_test
[13:40:46] [SKIPPED] example_skip_test
[13:40:46] [SKIPPED] example_mark_skipped_test
[13:40:46] [PASSED] example_all_expect_macros_test
[13:40:46]     # example: initializing suite
[13:40:46] # example: pass:1 fail:1 skip:2 total:4
[13:40:46] # Totals: pass:1 fail:1 skip:2 total:4
[13:40:46] ===================== [FAILED] example =====================

This example shows one minor cosmetic defect this approach has.
The test counts lines prevent us from dedenting the suite-level output.
But at the same time, any form of non-KUnit output would do the same
unless it happened to be indented as well.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 40804c4974b8 ("kunit: tool: copy caller args in run_kernel to prevent mutation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/kunit.py           |  2 +-
 tools/testing/kunit/kunit_parser.py    | 27 +++++++++++++-------------
 tools/testing/kunit/kunit_tool_test.py |  2 ++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e7b6549712d66..43fbe96318fe1 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -202,7 +202,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		if request.raw_output == 'all':
 			pass
 		elif request.raw_output == 'kunit':
-			output = kunit_parser.extract_tap_lines(output, lstrip=False)
+			output = kunit_parser.extract_tap_lines(output)
 		for line in output:
 			print(line.rstrip())
 		parse_time = time.time() - parse_start
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index baf0430be0e33..c02100b70af62 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,6 +12,7 @@
 from __future__ import annotations
 import re
 import sys
+import textwrap
 
 from enum import Enum, auto
 from typing import Iterable, Iterator, List, Optional, Tuple
@@ -217,12 +218,12 @@ class LineStream:
 
 # Parsing helper methods:
 
-KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
-TAP_START = re.compile(r'TAP version ([0-9]+)$')
-KTAP_END = re.compile('(List of all partitions:|'
+KTAP_START = re.compile(r'\s*KTAP version ([0-9]+)$')
+TAP_START = re.compile(r'\s*TAP version ([0-9]+)$')
+KTAP_END = re.compile(r'\s*(List of all partitions:|'
 	'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
-def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
+def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 	"""Extracts KTAP lines from the kernel output."""
 	def isolate_ktap_output(kernel_output: Iterable[str]) \
 			-> Iterator[Tuple[int, str]]:
@@ -248,11 +249,8 @@ def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
 				# stop extracting KTAP lines
 				break
 			elif started:
-				# remove the prefix and optionally any leading
-				# whitespace. Our parsing logic relies on this.
+				# remove the prefix, if any.
 				line = line[prefix_len:]
-				if lstrip:
-					line = line.lstrip()
 				yield line_num, line
 	return LineStream(lines=isolate_ktap_output(kernel_output))
 
@@ -307,7 +305,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
+TEST_HEADER = re.compile(r'^\s*# Subtest: (.*)$')
 
 def parse_test_header(lines: LineStream, test: Test) -> bool:
 	"""
@@ -331,7 +329,7 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
+TEST_PLAN = re.compile(r'^\s*1\.\.([0-9]+)')
 
 def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	"""
@@ -359,9 +357,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
-TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
 
-TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
 
 def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	"""
@@ -520,8 +518,9 @@ def print_test_header(test: Test) -> None:
 
 def print_log(log: Iterable[str]) -> None:
 	"""Prints all strings in saved log for test in yellow."""
-	for m in log:
-		stdout.print_with_timestamp(stdout.yellow(m))
+	formatted = textwrap.dedent('\n'.join(log))
+	for line in formatted.splitlines():
+		stdout.print_with_timestamp(stdout.yellow(line))
 
 def format_test_result(test: Test) -> str:
 	"""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 7e2f748a24eb2..fc13326e5c47a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -354,12 +354,14 @@ class KUnitParserTest(unittest.TestCase):
 		KTAP version 1
 		1..1
 		  Test output.
+		    Indented more.
 		not ok 1 test1
 		"""
 		result = kunit_parser.parse_run_tests(output.splitlines())
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 
 		self.print_mock.assert_any_call(StrContains('Test output.'))
+		self.print_mock.assert_any_call(StrContains('  Indented more.'))
 		self.noPrintCallContains('not ok 1 test1')
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
-- 
2.51.0





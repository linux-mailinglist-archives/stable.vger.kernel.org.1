Return-Path: <stable+bounces-229584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIUFf5qwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-229584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84932F8426
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2366832856E7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B73B9D97;
	Mon, 23 Mar 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zNTul77w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC033AE6F8;
	Mon, 23 Mar 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282315; cv=none; b=rsS9SUouzJn2m4ywv4NkthJfeH1DhfdxustedX5lVVn82ZqbuOM58DyMxu8lmXDEYm4pkxbL4D9v+hA7u6EIFiQc2D1VbVBOyKm9DxuxLTLWURC6Sihs3ExvnyxkhhanD4rzrOLAHQxwA1cI6F8CqDuGPuEupzkmr3s93HkEJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282315; c=relaxed/simple;
	bh=YXp/3bjrHQvCbg/kHkZjoX1Oem7gmR/Zjj+CauinPuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fboNNhf4oby3nHbES98d8ZmNLkkUQSpTo/laMjeiN4HdsyLCXxdQTBz5qDJ907Ue1N7iGrs4AXJ6+P3SkcOepN8EZielHq6N/+wsBMsIGwXp8SByCRyx0y/cj1snqd6crNFeZe3Zb3NYyhEOgJQxMpxRZx+BBLtLXc/GtPsFOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zNTul77w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99033C2BCB0;
	Mon, 23 Mar 2026 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282315;
	bh=YXp/3bjrHQvCbg/kHkZjoX1Oem7gmR/Zjj+CauinPuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zNTul77wSrhuiXF6YYLtLiu1G/cH32ho7Tbuz8BUheXqOIIr1JLOpMbgzs0zsdH4W
	 3X+sO4mIEy719AZv6UKs9sDhR8f37IMWvCP4cOZJXifBPP5HtOQ2iyUBwH+OKKgH9w
	 3dSa0LtJbIyhCBehRb9YHgs7DSu5sm3jkipTe8xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Latypov <dlatypov@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 111/481] kunit: tool: dont include KTAP headers and the like in the test log
Date: Mon, 23 Mar 2026 14:41:33 +0100
Message-ID: <20260323134527.987142108@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229584-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C84932F8426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Latypov <dlatypov@google.com>

[ Upstream commit 5937e0c04afc7d4b7b737fda93316ba4b74183c0 ]

We print the "test log" on failure.
This is meant to be all the kernel output that happened during the test.

But we also include the special KTAP lines in it, which are often
redundant.

E.g. we include the "not ok" line in the log, right before we print
that the test case failed...
[13:51:48] Expected 2 + 1 == 2, but
[13:51:48] 2 + 1 == 3 (0x3)
[13:51:48] not ok 1 example_simple_test
[13:51:48] [FAILED] example_simple_test

More full example after this patch:
[13:51:48] =================== example (4 subtests) ===================
[13:51:48] # example_simple_test: initializing
[13:51:48] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[13:51:48] Expected 2 + 1 == 2, but
[13:51:48] 2 + 1 == 3 (0x3)
[13:51:48] [FAILED] example_simple_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 40804c4974b8 ("kunit: tool: copy caller args in run_kernel to prevent mutation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/kunit_parser.py    |  8 ++++----
 tools/testing/kunit/kunit_tool_test.py | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 259ce7696587b..baf0430be0e33 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -304,7 +304,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 		check_version(version_num, TAP_VERSIONS, 'TAP', test)
 	else:
 		return False
-	test.log.append(lines.pop())
+	lines.pop()
 	return True
 
 TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
@@ -327,8 +327,8 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
 	match = TEST_HEADER.match(lines.peek())
 	if not match:
 		return False
-	test.log.append(lines.pop())
 	test.name = match.group(1)
+	lines.pop()
 	return True
 
 TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
@@ -354,9 +354,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	if not match:
 		test.expected_count = None
 		return False
-	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
 	test.expected_count = expected_count
+	lines.pop()
 	return True
 
 TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
@@ -418,7 +418,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	# Check if line matches test result line format
 	if not match:
 		return False
-	test.log.append(lines.pop())
+	lines.pop()
 
 	# Set name of test object
 	if skip_match:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 8334d660753c4..7e2f748a24eb2 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -81,6 +81,10 @@ class KconfigTest(unittest.TestCase):
 
 class KUnitParserTest(unittest.TestCase):
 
+	def noPrintCallContains(self, substr: str):
+		for call in self.print_mock.mock_calls:
+			self.assertNotIn(substr, call.args[0])
+
 	def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
 		# Clone the iterator so we can print the contents on failure.
 		copy, backup = itertools.tee(haystack)
@@ -345,6 +349,19 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
+	def test_show_test_output_on_failure(self):
+		output = """
+		KTAP version 1
+		1..1
+		  Test output.
+		not ok 1 test1
+		"""
+		result = kunit_parser.parse_run_tests(output.splitlines())
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+
+		self.print_mock.assert_any_call(StrContains('Test output.'))
+		self.noPrintCallContains('not ok 1 test1')
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 
-- 
2.51.0





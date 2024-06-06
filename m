Return-Path: <stable+bounces-48480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E078FE930
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE92CB25501
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D9197554;
	Thu,  6 Jun 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dvx1/k6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8B197550;
	Thu,  6 Jun 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682989; cv=none; b=GfStyYVZZzhoNXO8w+ucioGTxl/OLcFqlpXIGzKEIQovX8O1pKVC7OSf77ybFR8NsMQh27K6b80WXtX9EbCvqmygvUZi813S9Vps7Y5CekJsIPbG4uRYGqZu4QJLUHqw75YJuU7h47uV6Sb2ASlJsDzfbHjFWfOBxjg/PLRL//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682989; c=relaxed/simple;
	bh=OjOkU8eBA+0SArhpV3OsDgUSOPaLDYbkQdIuPBP9Qv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiQ2WwheBilZ/b6JXPXicGF8pwWbXMy5VSJCSbge1YhHknhZqmU1aYQMyH2YQMIbvfbClKPm0enEF6gsaYZLab/jRHMFGuWR2w32/sdKmvyoxyhQJAAXVd7DxxuXr3YYB+SSzcEvKOt3OBgIRt8JyjTUow0nnDa0B/qff727NRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dvx1/k6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4689EC32782;
	Thu,  6 Jun 2024 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682989;
	bh=OjOkU8eBA+0SArhpV3OsDgUSOPaLDYbkQdIuPBP9Qv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dvx1/k6Np9ww/gHxADXj++mNiuUY7XlUV3PZKhK73dmpXv6iarPcZ30vl9dUXjzAs
	 i6KgfV3T/rgv40c5t9Ww06GZRh+1hkb7dpRHAscqywzxW4ujI+j1UG59iiRBSz1/BU
	 urgjTncyYoS6pZjBQ4GA3ukfsZR0d+u6yxVBci9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 178/374] string_kunit: Add test cases for str*cmp functions
Date: Thu,  6 Jun 2024 16:02:37 +0200
Message-ID: <20240606131657.836793082@linuxfoundation.org>
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

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 9259a4721699947ceb397037991c0e4acc496b21 ]

Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
strncasecmp) are not covered with tests. Extend the `string_kunit.c`
test by adding the test cases for them.

This patch adds 8 more test cases:

1) strcmp test
2) strcmp test on long strings (2048 chars)
3) strncmp test
4) strncmp test on long strings (2048 chars)
5) strcasecmp test
6) strcasecmp test on long strings
7) strncasecmp test
8) strncasecmp test on long strings

These test cases aim at covering as many edge cases as possible,
including the tests on empty strings, situations when the different
symbol is placed at the end of one of the strings, etc.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20240417233033.717596-1-ivan.orlov0322@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 5bb288c4abc2 ("scsi: mptfusion: Avoid possible run-time warning with long manufacturer strings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/string_kunit.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index eabf025cf77c9..dd19bd7748aa2 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -11,6 +11,12 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#define STRCMP_LARGE_BUF_LEN 2048
+#define STRCMP_CHANGE_POINT 1337
+#define STRCMP_TEST_EXPECT_EQUAL(test, fn, ...) KUNIT_EXPECT_EQ(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
+
 static void test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -179,6 +185,147 @@ static void test_strspn(struct kunit *test)
 	}
 }
 
+static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
+static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
+
+static void strcmp_fill_buffers(char fill1, char fill2)
+{
+	memset(strcmp_buffer1, fill1, STRCMP_LARGE_BUF_LEN);
+	memset(strcmp_buffer2, fill2, STRCMP_LARGE_BUF_LEN);
+	strcmp_buffer1[STRCMP_LARGE_BUF_LEN - 1] = 0;
+	strcmp_buffer2[STRCMP_LARGE_BUF_LEN - 1] = 0;
+}
+
+static void test_strcmp(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "Hello, Kernel!", "Hello, Kernel!");
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Hello, KUnit!", "Hello, Kernel!");
+	/* First string is lexicographically larger than the second */
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, "Hello, Kernel!", "Hello, KUnit!");
+	/* Empty string is always lexicographically less than any non-empty string */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "", "Non-empty string");
+	/* Two empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "", "");
+	/* Compare two strings which have only one char difference */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Abacaba", "Abadaba");
+	/* Compare two strings which have the same prefix*/
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Just a string", "Just a string and something else");
+}
+
+static void test_strcmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncmp(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, KUnit!", "Hello, KUnit!", 13);
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Hello, KUnit!", "Hello, Kernel!", 13);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, Kernel!", "Hello, KUnit!", 0);
+	/* Strings with common prefix are equal if count = length of prefix */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Abacaba", "Abadaba", 3);
+	/* Strings with common prefix are not equal when count = length of prefix + 1 */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Abacaba", "Abadaba", 4);
+	/* If one string is a prefix of another, the shorter string is lexicographically smaller */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string and something else"));
+	/*
+	 * If one string is a prefix of another, and we check first length
+	 * of prefix chars, the result is 'equal'
+	 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string"));
+}
+
+static void test_strncmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+	/* the strings are equal up to STRCMP_CHANGE_POINT */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
+static void test_strcasecmp(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "Hello, Kernel!", "HeLLO, KErNeL!");
+	/* Empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "", "");
+	/* Despite ascii code for 'a' is larger than ascii code for 'B', 'a' < 'B' */
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, "a", "B");
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, "B", "a");
+	/* Special symbols and numbers should be processed correctly */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "-+**.1230ghTTT~^", "-+**.1230Ghttt~^");
+}
+
+static void test_strcasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncasecmp(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbAcAbA", "Abacaba", strlen("Abacaba"));
+	/* strncasecmp should check 'count' chars only */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbaCaBa", "abaCaDa", 5);
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, "a", "B", 1);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, "B", "a", 1);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "Abacaba", "Not abacaba", 0);
+}
+
+static void test_strncasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
@@ -186,6 +333,14 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_strchr),
 	KUNIT_CASE(test_strnchr),
 	KUNIT_CASE(test_strspn),
+	KUNIT_CASE(test_strcmp),
+	KUNIT_CASE(test_strcmp_long_strings),
+	KUNIT_CASE(test_strncmp),
+	KUNIT_CASE(test_strncmp_long_strings),
+	KUNIT_CASE(test_strcasecmp),
+	KUNIT_CASE(test_strcasecmp_long_strings),
+	KUNIT_CASE(test_strncasecmp),
+	KUNIT_CASE(test_strncasecmp_long_strings),
 	{}
 };
 
-- 
2.43.0





Return-Path: <stable+bounces-250149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGEMIyLoDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D59592B75
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6796531F4A1E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F33A783F;
	Wed, 20 May 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ht7350k5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06E3A3E60;
	Wed, 20 May 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294672; cv=none; b=V2vqm3maQLXvqfCfPMAc5zPKzJXZIq6f/t7qCDDd0B6hpB+RJBgWtklolAPq7ZIUveI6yOCoQVTUg6DCcE0y6rys/CrAFu2uh9GB41fPIxV6p3XI2WOj3JwBq5Rsix8Cn5OfI2dv5fMzfj9oxC6YUSqMKRQdwLsguLFm8BQGg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294672; c=relaxed/simple;
	bh=70KCVLVoAxsKAFZqTsfcdsKY5WZrwjjlcNs6YWzGlI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No9D4RSway4CQwAhdQGfD8sEMu6fCVN2hQX4NFYcDDdKbl9n9+k1VmR29kDZJ0Sx3ZS/GEgPqGR8L+AGX7FgYeghDp3y4T5wH+w0bhOFAvmXn68BKHHYeF7LErvdJJWRY2mutT/vpZ40gygjNazwbPMvy+bnCNc4ApsBuzDVEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ht7350k5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDB1F000E9;
	Wed, 20 May 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294671;
	bh=Ms1Kv+p2kLXgMA8U6MjFBDams9f7oaxFkNJ366heUe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ht7350k5BglJjfQHQu9sBikLWeOMbzNEn25PdqFSa7167NkcUC3Y3B5TGn0FwOYHb
	 tL3Z0+nxcSQ5EI0Wbf+pkvpbzXUq6Hug1paf2axJuMmdQkXkK+QiVWAER9nGOKk0Ai
	 zyrpfdpuWp1tdfL9VuLBsdLbedSbNVQJisy5cYhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0088/1146] selftests/nolibc: Fix build with host headers and libc
Date: Wed, 20 May 2026 18:05:38 +0200
Message-ID: <20260520162150.344673243@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,weissschuh.net,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,weissschuh.net:email]
X-Rspamd-Queue-Id: 93D59592B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Laight <david.laight.linux@gmail.com>

[ Upstream commit 27532c645e61da541173d43fbe03d234f68232f9 ]

Many systems don't have strlcpy() or strlcat() and readdir_r() is
deprecated. This makes the tests fail to build with the host headers.
Disable the 'directories' test and define strlcpy(), strlcat() and
readdir_r() using #defines so that the code compiles.

Fixes: 6fe8360b16acb ("selftests/nolibc: also test libc-test through regular selftest framework")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
Link: https://patch.msgid.link/20260223101735.2922-4-david.laight.linux@gmail.com
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1aca8468eac4b..801b2ad188537 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -82,6 +82,20 @@ static const int is_glibc =
 #endif
 ;
 
+#if !defined(NOLIBC)
+/* Some disabled tests may not compile. */
+
+/* strlcat() and strlcpy() may not be in the system headers. */
+#undef strlcat
+#undef strlcpy
+#define strlcat(d, s, l) 0
+#define strlcpy(d, s, l) 0
+
+/* readdir_r() is likely to be marked deprecated */
+#undef readdir_r
+#define readdir_r(dir, dirent, result) ((errno = EINVAL), -1)
+#endif
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -1416,7 +1430,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork(FORK_STANDARD)); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
-		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
+		CASE_TEST(directories);       EXPECT_SYSZR(is_nolibc && proc, test_dirent()); break;
 		CASE_TEST(getrandom);         EXPECT_SYSZR(1, test_getrandom()); break;
 		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
 		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
-- 
2.53.0





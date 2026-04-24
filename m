Return-Path: <stable+bounces-240881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNFfEAZz62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:41:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64E45F648
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 308613006116
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9C3D5236;
	Fri, 24 Apr 2026 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Urel0Vx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE83537DF;
	Fri, 24 Apr 2026 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038081; cv=none; b=Ld7mcUVdJ0egwv8jRzRz0+3ErjNp3kzj0jH7YHEk51ZzBKVNksuly7bD8BRwsBNRs2oLBd7Mn4Uu056/EWvZyM59xwKAhlMjEFHBUY8ZhaqLJFBJ54h0jHQcgDvOXjxFP+JZc4I8FNEaMRM/pDzbApMUsTirZDlaURF/CqUxyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038081; c=relaxed/simple;
	bh=Ty+c2n7dfuaYEuE8fJNC/ARwKmKQMbOf+lYLo8i3TKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWafNt95OBYXICsyplF22CNuRIFTzSghpn43pN3kWg5lz3WbVFF/YcLmLr2sllvQpLiT/k3NWE02q36bsYWa1s7E3gso4nO0cHzYEDAckwjVFaSLLnEhK03nmtp3VP/dOaSR1l1B/lxZu1sp4CJ+0vdBBto3Px9YPiSdQsjRX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Urel0Vx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC6C19425;
	Fri, 24 Apr 2026 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038081;
	bh=Ty+c2n7dfuaYEuE8fJNC/ARwKmKQMbOf+lYLo8i3TKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Urel0Vx8M2QlOe8kELJ8O1AGIwBUAGZTZJrAUGV8h+ixOH+fUHdNE/zyeP5vdglGv
	 w1rl6wf/TPDwcOmf6SIWYLRsVHaKV3zmcjRPLt2+U0eMRi567VSrNruQjhCxUF2iGr
	 YojByLwbzGXLQpGvwC/G7wD9WcH1mbXlW9Q/UplY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"linux-crypto@vger.kernel.org, kunit-dev@googlegroups.com, Eric Biggers" <ebiggers@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 17/55] lib/crc: tests: Make crc_kunit test only the enabled CRC variants
Date: Fri, 24 Apr 2026 15:30:56 +0200
Message-ID: <20260424132433.709528306@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CF64E45F648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240881-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 85c9f3a2b805eb96d899da7bcc38a16459aa3c16 upstream.

Like commit 4478e8eeb871 ("lib/crypto: tests: Depend on library options
rather than selecting them") did with the crypto library tests, make
crc_kunit depend on the code it tests rather than selecting it.  This
follows the standard convention for KUnit and fixes an issue where
enabling KUNIT_ALL_TESTS enabled non-test code.

crc_kunit does differ from the crypto library tests in that it
consolidates the tests for multiple CRC variants, with 5 kconfig
options, into one KUnit suite.  Since depending on *all* of these
kconfig options would greatly restrict the ability to enable crc_kunit,
instead just depend on *any* of these options.  Update crc_kunit
accordingly to test only the reachable code.

Alternatively we could split crc_kunit into 5 test suites.  But keeping
it as one is simpler for now.

Fixes: e47d9b1a76ed ("lib/crc_kunit.c: add KUnit test suite for CRC library functions")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260306033557.250499-2-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crc/Kconfig           |    7 +------
 lib/crc/tests/crc_kunit.c |   28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 12 deletions(-)

--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -99,13 +99,8 @@ config CRC_OPTIMIZATIONS
 
 config CRC_KUNIT_TEST
 	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && (CRC7 || CRC16 || CRC_T10DIF || CRC32 || CRC64)
 	default KUNIT_ALL_TESTS
-	select CRC7
-	select CRC16
-	select CRC_T10DIF
-	select CRC32
-	select CRC64
 	help
 	  Unit tests for the CRC library functions.
 
--- a/lib/crc/tests/crc_kunit.c
+++ b/lib/crc/tests/crc_kunit.c
@@ -268,8 +268,7 @@ crc_benchmark(struct kunit *test,
 	}
 }
 
-/* crc7_be */
-
+#if IS_REACHABLE(CONFIG_CRC7)
 static u64 crc7_be_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	/*
@@ -294,9 +293,9 @@ static void crc7_be_benchmark(struct kun
 {
 	crc_benchmark(test, crc7_be_wrapper);
 }
+#endif /* CONFIG_CRC7 */
 
-/* crc16 */
-
+#if IS_REACHABLE(CONFIG_CRC16)
 static u64 crc16_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc16(crc, p, len);
@@ -318,9 +317,9 @@ static void crc16_benchmark(struct kunit
 {
 	crc_benchmark(test, crc16_wrapper);
 }
+#endif /* CONFIG_CRC16 */
 
-/* crc_t10dif */
-
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 static u64 crc_t10dif_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc_t10dif_update(crc, p, len);
@@ -342,6 +341,9 @@ static void crc_t10dif_benchmark(struct
 {
 	crc_benchmark(test, crc_t10dif_wrapper);
 }
+#endif /* CONFIG_CRC_T10DIF */
+
+#if IS_REACHABLE(CONFIG_CRC32)
 
 /* crc32_le */
 
@@ -414,6 +416,9 @@ static void crc32c_benchmark(struct kuni
 {
 	crc_benchmark(test, crc32c_wrapper);
 }
+#endif /* CONFIG_CRC32 */
+
+#if IS_REACHABLE(CONFIG_CRC64)
 
 /* crc64_be */
 
@@ -463,24 +468,35 @@ static void crc64_nvme_benchmark(struct
 {
 	crc_benchmark(test, crc64_nvme_wrapper);
 }
+#endif /* CONFIG_CRC64 */
 
 static struct kunit_case crc_test_cases[] = {
+#if IS_REACHABLE(CONFIG_CRC7)
 	KUNIT_CASE(crc7_be_test),
 	KUNIT_CASE(crc7_be_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC16)
 	KUNIT_CASE(crc16_test),
 	KUNIT_CASE(crc16_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC_T10DIF)
 	KUNIT_CASE(crc_t10dif_test),
 	KUNIT_CASE(crc_t10dif_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC32)
 	KUNIT_CASE(crc32_le_test),
 	KUNIT_CASE(crc32_le_benchmark),
 	KUNIT_CASE(crc32_be_test),
 	KUNIT_CASE(crc32_be_benchmark),
 	KUNIT_CASE(crc32c_test),
 	KUNIT_CASE(crc32c_benchmark),
+#endif
+#if IS_REACHABLE(CONFIG_CRC64)
 	KUNIT_CASE(crc64_be_test),
 	KUNIT_CASE(crc64_be_benchmark),
 	KUNIT_CASE(crc64_nvme_test),
 	KUNIT_CASE(crc64_nvme_benchmark),
+#endif
 	{},
 };
 




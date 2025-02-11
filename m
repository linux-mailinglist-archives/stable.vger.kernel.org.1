Return-Path: <stable+bounces-114922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D965BA30EF0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2926C188143A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677571F9ED2;
	Tue, 11 Feb 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJKYtolD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZL1p6f9"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF4250C1D;
	Tue, 11 Feb 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286015; cv=none; b=D2S4I1bqMilvUiRa8FfU7uWd/1nNVrQ+187LMaoWGeJdJllI0IFnSYMkTtKQ0VHcIA4iuBTWu1VSgBgqRyoh04BHSifzjYsyvEW7CdskjoDjtmlZBGa3jOzDg8WJRs1OubYHRJpY3UBAglhONkNriMkuyTDTeDgye/sAfNRS9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286015; c=relaxed/simple;
	bh=X7gsBc4YvTswGAe3ipvZe8BWphWuMO5WFT/+YrV/kNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TQNgcKtP6n4jtcH7KqPscnqXmGdY0aF4xtg1vmJEMaU4FeN3zw2pZ/5MpQlp4Av3g8TVnYWYdeKi/YplNyWYeynZJbkcV9iEOBGX+A4kPe+Z3zv7iQBDC4yOYzvsY4SmNdthKNDNtc8M1zsTBqRypyxNOSKLmkf1pUXBsK1gf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJKYtolD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZL1p6f9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739286011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MBBgFwIPM9ArG/++02kDCovbUubj1A6raG2FsdxYOuE=;
	b=tJKYtolDpLQQMdRIym5NWiwB2mwjLhhs1BcvWJujfPWs2ZDZ7GNif057a10MPMBZr2amVA
	iOFG0QiQLoeQ6jjjJWpD5g52c47SKFPqgVNwVfJ6kAP59QmKIfOS85vhsOQnpoUdjAT92z
	v6CAHQclY4VhWcc78w0P1TI0xMYXDBy02wOpMqtbbi0x/dquAXd0cI0cDcawgGG34d/77d
	nyiiKOG0TrkZF8hdVYhQqPj8DWzgnr32mmiKtp92bDyic0wfDSPoF6zDlJ5MrRqvZ7n+QT
	iGg561ts50rFsrcVUHwVl+Ca96kIFsNiU1ZJGPlt/qxsszLGPgaL9JBVKA2FZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739286011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MBBgFwIPM9ArG/++02kDCovbUubj1A6raG2FsdxYOuE=;
	b=DZL1p6f91Nar035wPIk9SrnGEGIQeCzI5Yd7bVZXkOzMcIDljzGZeflfMwxDm8LlDDdH/Z
	7v7ZQ2jvy1ITpUBw==
Date: Tue, 11 Feb 2025 16:00:02 +0100
Subject: [PATCH] firmware: cs_dsp: test_control_parse: null-terminate test
 strings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPFlq2cC/x3M0QpAQBBA0V/RPJvaHUR+RZLsYFJLO0ht/t3m8
 TzcG0E5CCu0WYTAt6jsPsHmGUzr6BdGcclAhipD1uKkg9MDt8vLiXoG8YviXBZMtakbdgQpPQL
 P8vzbrn/fD8LuW6RmAAAA
X-Change-ID: 20250211-cs_dsp-kunit-strings-f43e27078ed2
To: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739286007; l=5499;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=X7gsBc4YvTswGAe3ipvZe8BWphWuMO5WFT/+YrV/kNg=;
 b=hxNYiKtuDcPhzRD4UnAaXybfto5jOrZDWGSbfJG3+XB4mIo0DR98Go1CKKjogVG1Pohs2lUcE
 NWJw+nD5ao+CdFkioBDNxtmRBW1y65nd9FOAqRAXWrUwUlG824KbkrH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The char pointers in 'struct cs_dsp_mock_coeff_def' are expected to
point to C strings. They need to be terminated by a null byte.
However the code does not allocate that trailing null byte and only
works if by chance the allocation is followed by such a null byte.

Refactor the repeated string allocation logic into a new helper which
makes sure the terminating null is always present.
It also makes the code more readable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Fixes: 83baecd92e7c ("firmware: cs_dsp: Add KUnit testing of control parsing")
Cc: stable@vger.kernel.org
---
 .../cirrus/test/cs_dsp_test_control_parse.c        | 51 ++++++++--------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
index cb90964740ea351113dac274f0366de7cedfd3d1..942ba1af5e7c1e47e8a2fbe548a7993b94f96515 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
@@ -73,6 +73,18 @@ static const struct cs_dsp_mock_coeff_def mock_coeff_template = {
 	.length_bytes = 4,
 };
 
+static char *cs_dsp_ctl_alloc_test_string(struct kunit *test, char c, size_t len)
+{
+	char *str;
+
+	str = kunit_kmalloc(test, len + 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
+	memset(str, c, len);
+	str[len] = '\0';
+
+	return str;
+}
+
 /* Algorithm info block without controls should load */
 static void cs_dsp_ctl_parse_no_coeffs(struct kunit *test)
 {
@@ -160,12 +172,8 @@ static void cs_dsp_ctl_parse_max_v1_name(struct kunit *test)
 	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
 	struct cs_dsp_coeff_ctl *ctl;
 	struct firmware *wmfw;
-	char *name;
 
-	name = kunit_kzalloc(test, 256, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);
-	memset(name, 'A', 255);
-	def.fullname = name;
+	def.fullname = cs_dsp_ctl_alloc_test_string(test, 'A', 255);
 
 	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
 					      cs_dsp_ctl_parse_test_algs[0].id,
@@ -252,14 +260,9 @@ static void cs_dsp_ctl_parse_max_short_name(struct kunit *test)
 	struct cs_dsp_test_local *local = priv->local;
 	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
 	struct cs_dsp_coeff_ctl *ctl;
-	char *name;
 	struct firmware *wmfw;
 
-	name = kunit_kmalloc(test, 255, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);
-	memset(name, 'A', 255);
-
-	def.shortname = name;
+	def.shortname = cs_dsp_ctl_alloc_test_string(test, 'A', 255);
 
 	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
 					      cs_dsp_ctl_parse_test_algs[0].id,
@@ -273,7 +276,7 @@ static void cs_dsp_ctl_parse_max_short_name(struct kunit *test)
 	ctl = list_first_entry_or_null(&priv->dsp->ctl_list, struct cs_dsp_coeff_ctl, list);
 	KUNIT_ASSERT_NOT_NULL(test, ctl);
 	KUNIT_EXPECT_EQ(test, ctl->subname_len, 255);
-	KUNIT_EXPECT_MEMEQ(test, ctl->subname, name, ctl->subname_len);
+	KUNIT_EXPECT_MEMEQ(test, ctl->subname, def.shortname, ctl->subname_len);
 	KUNIT_EXPECT_EQ(test, ctl->flags, def.flags);
 	KUNIT_EXPECT_EQ(test, ctl->type, def.type);
 	KUNIT_EXPECT_EQ(test, ctl->len, def.length_bytes);
@@ -323,12 +326,8 @@ static void cs_dsp_ctl_parse_with_max_fullname(struct kunit *test)
 	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
 	struct cs_dsp_coeff_ctl *ctl;
 	struct firmware *wmfw;
-	char *fullname;
 
-	fullname = kunit_kmalloc(test, 255, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fullname);
-	memset(fullname, 'A', 255);
-	def.fullname = fullname;
+	def.fullname = cs_dsp_ctl_alloc_test_string(test, 'A', 255);
 
 	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
 					      cs_dsp_ctl_parse_test_algs[0].id,
@@ -392,12 +391,8 @@ static void cs_dsp_ctl_parse_with_max_description(struct kunit *test)
 	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
 	struct cs_dsp_coeff_ctl *ctl;
 	struct firmware *wmfw;
-	char *description;
 
-	description = kunit_kmalloc(test, 65535, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, description);
-	memset(description, 'A', 65535);
-	def.description = description;
+	def.description = cs_dsp_ctl_alloc_test_string(test, 'A', 65535);
 
 	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
 					      cs_dsp_ctl_parse_test_algs[0].id,
@@ -429,17 +424,9 @@ static void cs_dsp_ctl_parse_with_max_fullname_and_description(struct kunit *tes
 	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
 	struct cs_dsp_coeff_ctl *ctl;
 	struct firmware *wmfw;
-	char *fullname, *description;
-
-	fullname = kunit_kmalloc(test, 255, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fullname);
-	memset(fullname, 'A', 255);
-	def.fullname = fullname;
 
-	description = kunit_kmalloc(test, 65535, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, description);
-	memset(description, 'A', 65535);
-	def.description = description;
+	def.fullname = cs_dsp_ctl_alloc_test_string(test, 'A', 255);
+	def.description = cs_dsp_ctl_alloc_test_string(test, 'A', 65535);
 
 	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
 					      cs_dsp_ctl_parse_test_algs[0].id,

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-cs_dsp-kunit-strings-f43e27078ed2

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>



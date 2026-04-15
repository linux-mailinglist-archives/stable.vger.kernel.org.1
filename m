Return-Path: <stable+bounces-238020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PMsJdYE32khNwAAu9opvQ
	(envelope-from <stable+bounces-238020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:24:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8503FFF4D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA7323030B26
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96D31E107;
	Wed, 15 Apr 2026 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLPBVlDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD5314A82
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223436; cv=none; b=Vz1ZA4NT9U71HAjcO5R9/4URKjxw250px3UsM3NuS74zvBZrX63iY3ry48oJO+7QtLK3A6M4ATHwd5Qeo+WAztPIz60kuCia+FBJnDCHzHx+D/HafAJVDKNqcgwcWVR1Xl28csrM2fVSi/attlBJz5SjN6f0uR6zKhVc1Dwt89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223436; c=relaxed/simple;
	bh=rQDYqSU37WRbCB4Qm55uxEWs586IyL2RigYzcvg0OTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIJd5JXJlGDLC2n/wEC+nv91BtDUn5+WCZExypkDAUH1dngSZ6vuc+ORvDVF/yUe4efF1mSnnPFsyN3dRVbJgNB/Kn54h2GgQM2f0kbCvDkDlrPCaT73T9LSEBxCsiu26KdOtfPcl2rQ438l9uc+o939mvbaNFh826RfiP8RXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLPBVlDG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50da9a7928cso51954131cf.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223433; x=1776828233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH3KHfCMOZkc58NmOsw59J1qT/TVXoniVUUkFi7xDGY=;
        b=DLPBVlDG1TPk1DPbAteXLMAk7OCvTKrRVbdERoqRifebz3elsgseV60A5phfwlbLWr
         9l8xAcMPpmUv1jVeeRVXEltUpyQL0WTPDAyaE5umDrcUKrB4WSVxfT9UmibBP3ZkQRFK
         P2V/dx0c07CY0cX/nFelr/3EOvNoFUoCOQPZCdgSBl2MqDFE0irMpYl6DEVc3jGrSY7C
         MBDu3/nn9Dg13N/hTXKyH42nt9PANiBpOQBepSWsWPNiupmY8A9idC1epaEQlJV0WZB6
         x+QwiYncfCWQXUwx7AaUtmgO5P+zDwDPJ1Am5GMK+scTS89cuLs5/g0D4kSulMtJ5sb0
         IAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223433; x=1776828233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nH3KHfCMOZkc58NmOsw59J1qT/TVXoniVUUkFi7xDGY=;
        b=PxpZRXvvCkNyhbKQECaaYYnuyfxJtqu/gsj4IwMW1va4uNil+vWcYg6Pkmw0A+ylY8
         FKoDd+VPrLkHALW1F7y0YzkLgLvDdmGw7ir9nPHjvVM+W1SIAVgh/8Tweq8U0x8FMRc+
         5xEFKQLpEOGk7KkcET72czcTfmZEQlYZM9e8q18ygrp9xl7LmdRXce/0gQkIma+bHLBr
         +1+XyVhKGKe0zDUm/VbjefZcappvqutpHQNWGcoOgS3Esr4gUOeDQt1iDP0wwSXfRy1t
         mQWi67oUUXFj/xjYlZ1bg0ToqaTJia7ME5ro5UmLJj1ZSb7TCd6eBnlB76xgCIctNQ9S
         K/mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uHClo6282c+tK2L89fbizQnjxfmcCWPcz6MMwaS/RBERabdVopbpojc9OtehYRBGGMqOPecM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzilFx/qdp+CqGejGY5J9ApNIfJnlhXKS/HKN3MbI4Rq1Wff/+2
	CgctkB5SqjJQB87mahHh4unP6T1QfY9S0LGbfCmOedit6V3NYQE/kayf
X-Gm-Gg: AeBDiesKjM7fMixUsJprEFi6K/gtSseeaAQupnvDAqU+XwbAkIajLKA8Ll7po1gwa0k
	FMmR/KeRDhjVs7P0lJbUpcewRVfojfeh47sZR+TtvOAb0+8HRLIxqax51l1l3OQRZEcES4vyh0j
	KDoojnLW3bHPxx7Kyb8ni5a6nad9cI3OWXY/D8UO8l57X2fNLF7x+/uEx8JvE8ztFEAaVhEAfBJ
	aKaCXoDlsINlOSW1zQUqbLOPqjwDbaEQ5AkqACyj6tcffWpJQaiHN5eTdMS5SfzMQNCuMEd2IUU
	ITX4q6IgksGQ2ZK5+aOmbOaNu9yd1mVVGjEEQ9BSw0CaND0mwbInPfUmL7xnpWKJQceYkeoxwxe
	5S3ERohUiixDpcxXKV2SfCTPrF4Vyy1VFktV3FBgVSIhWX7HX+s9X9bXzZbEvfRAXyF5ZCRPLmc
	lflvFqi0yb5vyCYvutQgD3q/53FFLMl1UtS4thtoKNXXg8lbe9OV4kMwscOcWYOJ+AriT+BXsAW
	CkioiYorbKwLxQ+OF6w4J20qX3wJJQ=
X-Received: by 2002:ac8:7c41:0:b0:50d:a747:9e95 with SMTP id d75a77b69052e-50dd5aef3famr288781941cf.20.1776223433385;
        Tue, 14 Apr 2026 20:23:53 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b012b23sm3713071cf.30.2026.04.14.20.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:23:52 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] thunderbolt: test: add KUnit regression tests for XDomain property parser
Date: Tue, 14 Apr 2026 23:23:35 -0400
Message-ID: <20260415032335.2826412-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415032335.2826412-1-michael.bommarito@gmail.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238020-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C8503FFF4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add three KUnit cases that exercise the defects fixed by the parent
commit by feeding crafted XDomain property blocks to
tb_property_parse_dir():

  tb_test_property_parse_u32_wrap - entry->value = 0xFFFFFF00 and
    entry->length = 0x100 so their u32 sum 0x100000000 wraps to 0
    under the block_len guard; without the fix the subsequent
    parse_dwdata() reads attacker-directed OOB memory.

  tb_test_property_parse_recursion - two DIRECTORY entries pointing
    at each other, driving __tb_property_parse_dir() recursion;
    without the fix the kernel stack is exhausted.

  tb_test_property_parse_dir_len_underflow - a DIRECTORY entry with
    length < 4 so non-root content_len = dir_len - 4 wraps size_t;
    without the fix nentries is huge and the entry walk runs OOB.

Each test asserts tb_property_parse_dir() returns NULL on the
crafted input.  With CONFIG_KASAN=y, running these on the pre-fix
kernel reproduces an oops inside __tb_property_parse_dir (KASAN
shadow-memory fault for the u32_wrap case, stack-guard trip for
recursion, OOB read past block for dir_len underflow).  Post-fix
they pass cleanly.

Run with:
  ./tools/testing/kunit/kunit.py run --arch=x86_64 \\
    --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_NVMEM=y \\
    --kconfig_add CONFIG_USB4=y --kconfig_add CONFIG_USB4_KUNIT_TEST=y \\
    --kconfig_add CONFIG_KASAN=y 'thunderbolt.tb_test_property_parse_*'

Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/test.c | 127 +++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f4318249c22..22f4107fcb8d 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2852,7 +2852,134 @@ static void tb_test_property_copy(struct kunit *test)
 	tb_property_free_dir(src);
 }
 
+/*
+ * Reproducers for three memory-safety defects in
+ * drivers/thunderbolt/property.c reached from a crafted XDomain
+ * PROPERTIES_RESPONSE payload.  Without the fix these trip KASAN or
+ * smash the kernel stack; with the fix each returns NULL cleanly.
+ */
+static void tb_test_property_parse_u32_wrap(struct kunit *test)
+{
+	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct {
+		u32 key_hi, key_lo;
+		u16 length;
+		u8 reserved;
+		u8 type;
+		u32 value;
+	} *e;
+
+	/* Root header: magic + length=6 (single entry body of 4 dwords +
+	 * 2 slack, keeps walk within block[]). */
+	block[0] = 0x55584401;
+	block[1] = 6;
+
+	/* Crafted DATA entry at block[2..5]: value = 0xFFFFFF00 and
+	 * length = 0x100 are u32/u16 such that the u32 sum 0x100000000
+	 * wraps to 0, passing the sum <= block_len guard even though
+	 * the real offset is block + 0xFFFFFF00 * 4 (~16 GiB past the
+	 * block).  The subsequent parse_dwdata() at property.c:132
+	 * copies entry->length*4 = 1024 bytes from that wild address
+	 * into a fresh kcalloc buffer.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 0x100;
+	e->type   = 0x64;		/* TB_PROPERTY_TYPE_DATA */
+	e->value  = 0xFFFFFF00;
+
+	dir = tb_property_parse_dir(block, 500);
+	/* With the fix this returns NULL; without it, KASAN splats in
+	 * be32_to_cpu_array() / memcpy reading block + value*4 out of
+	 * bounds.  Assert on the safe outcome: a NULL dir. */
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_recursion(struct kunit *test)
+{
+	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct entry {
+		u32 key_hi, key_lo;
+		u16 length;
+		u8 reserved;
+		u8 type;
+		u32 value;
+	} *e, *child_e;
+
+	block[0] = 0x55584401;
+	block[1] = 4;		/* rootdir length = one entry */
+
+	/* DIRECTORY entry pointing at dir_offset=2 with length=16.
+	 * When parsed as non-root: content_offset = 6, content_len = 12,
+	 * nentries = 3.  The child's first entry at block[6] is also
+	 * DIRECTORY pointing at 2, so the recursion oscillates between
+	 * two dir_offsets until the kernel stack is exhausted.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 16;
+	e->type   = 0x44;		/* TB_PROPERTY_TYPE_DIRECTORY */
+	e->value  = 2;
+
+	child_e = (void *)&block[6];
+	child_e->key_hi = 0x62626262;
+	child_e->key_lo = 0x62626262;
+	child_e->length = 16;
+	child_e->type   = 0x44;
+	child_e->value  = 2;
+
+	dir = tb_property_parse_dir(block, 500);
+	/* With the fix this returns NULL at TB_PROPERTY_MAX_DEPTH (8).
+	 * Without it, the kernel stack-guard fires ~50-80 frames in
+	 * and the kunit thread oopses. */
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_dir_len_underflow(struct kunit *test)
+{
+	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct entry {
+		u32 key_hi, key_lo;
+		u16 length;
+		u8 reserved;
+		u8 type;
+		u32 value;
+	} *e;
+
+	block[0] = 0x55584401;
+	block[1] = 4;
+
+	/* DIRECTORY entry with length=3.  When parsed as non-root,
+	 * content_len = dir_len - 4 underflows size_t to ~SIZE_MAX,
+	 * nentries = SIZE_MAX/4.  The for-loop walks entries past the
+	 * block, reading OOB on each iteration.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 3;
+	e->type   = 0x44;
+	e->value  = 6;
+
+	dir = tb_property_parse_dir(block, 500);
+	/* With the fix: NULL.  Without: KASAN splat on
+	 * block[content_offset + i*4] for i > 124 (past the 500-dword
+	 * block). */
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
 static struct kunit_case tb_test_cases[] = {
+	KUNIT_CASE(tb_test_property_parse_u32_wrap),
+	KUNIT_CASE(tb_test_property_parse_recursion),
+	KUNIT_CASE(tb_test_property_parse_dir_len_underflow),
 	KUNIT_CASE(tb_test_path_basic),
 	KUNIT_CASE(tb_test_path_not_connected_walk),
 	KUNIT_CASE(tb_test_path_single_hop_walk),
-- 
2.53.0



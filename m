Return-Path: <stable+bounces-238120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LFZOymG32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262B4044D5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A294830F6F63
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBF3161BE;
	Wed, 15 Apr 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcqa7Pwj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A8271450
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256354; cv=none; b=i4nACxyLBpOs5Z0EHkyMDkccOksqptWXnJscGohJ3P19CtZFqAFYVKyFaDo5DOnqjdU72IYuQsfaBALJYNy6gLy3mukhcu2p/yuIZNozEPOT0vFymQd/KLjFvLqZ+pOL2vZ+SdICDtXnPgB1mYjNG8OqU5QkaFYQLVVF/nWmftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256354; c=relaxed/simple;
	bh=1l1cR5VAlx5dYOZdHqtWbaulDQgqIiBgksHXnCKMkfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fata2U2lSNkFIYrToQ2zUuwBKcJDTWxtb9j9f8bM34V/4Ztj14B08AgedxdOWIe8dgrnoqE9CUC4gUwYz7FJ63qxtDCNOkB5UqE69IQg3cSn4nh94B4FZ0IA85wshe9p5J4Ye+h/fbSP3vK/2M2Utpgc0OIBhiGUUbGT+6cG9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcqa7Pwj; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d8da3e656so64014571cf.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256351; x=1776861151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbvHAqDnj9FXaNRW0EKEP6rCGAhHRS/crPKa3pni2fo=;
        b=pcqa7PwjdoDlpQQwtix7b4biwESJAexwOb5Eqlx8QHmWXx7r5dpfC9OCXJZhcJkylF
         Y/aRxJbmgYF80u7udoSOT+8r9rt6fLr3L3twcShTFL9EFJlTl7koLCVV2RKQHyYqWHO/
         3rzba7QskLYeryHW3WuiNHbLzs0yGyVuhMnNfnwe3ABg50UjEdf7miNDrk9vWMxbAwxe
         q2pPrMZa2GyT3QlbgVQCsiFXMe5p8Qc0IyFNxmta/HTI9iGaj5UP3HtXgECjnoQ88Hfs
         UPlVbQcY36x0TWjXL6KimKNGjGTw4SFejnyDIP9CZlszdRokEVzt0pig4ieCfa7d25EK
         nzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256351; x=1776861151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbvHAqDnj9FXaNRW0EKEP6rCGAhHRS/crPKa3pni2fo=;
        b=Kvtb7j+jKtVcO1lTSb6M1fvXinlYnJDSqB/304molakWgWmvdftr6/fQQywT2UqV5m
         c0tx1C7RmrmWawHUxht094WD7h7GNglrWDSSSeIhBFd6lRHx6i/YnfkRskgJfcZ5CQKV
         yoxocHvYbAJakUmaPDKAgjVBbPr8wAGC2C0Y84w8dVg8z85GaIVxkXduao41gE+D9az2
         dTGzZsDJf7T4GI5fdthwPFIF1f9hBIe6SlTlaaXMQ+uEKzq67WqdZXxdGxtCKMCDUWfG
         21vrS2wHWhLAT2DF1kEFNF/l6ErwDcKW3LbScTLh9zDfFPioCYy2CVui1+9ZfXQd3JuX
         q2Ig==
X-Forwarded-Encrypted: i=1; AFNElJ+2BxcrUYxjJcXS8205gUFkMa/ec7ASanNGIMWpWwgdjuaigpUtQE0w4HJIkHTozj2mifXOPh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD7HyOtcYmKCrzOfhIgclHdw5XpIPhB/dtXN3o7V3oh63fM1H
	l2/9nR+mPEm9tCMbD1JrrQJOn6cU6b40lboqo926bNzM1CiTpDhzMyyH
X-Gm-Gg: AeBDietFoamljude8AI67eH/W1OVGVDVC2LTSMVd9ounSdG6h1tzgcoHyctqmWJJkss
	i9xTNP8WPRMgRoxqo77mcZQQYNInPryulOjpnpVMtrKg1nSHAKSRbYg3P8OzFRJFnx3+fJpDH+d
	5JXG75RRDOPLjAsbLpGh9IsmoM5yef/8Yb+etA7lj9AjSsEEYj9oYsOGzGHJuez9EalQBCAFcNo
	w9p7UgZY4xi70D/tMop0i6mqxfLURnlAPn2JpZp5RhGJjNKnnDbpxc6Qs/34lCEeAJ1Vq5AnAVh
	Imhk+3IQttmM7YByp5uE0yPdf8n1HU4jKG+OXEaIIsDMwLaTGE9ha6QSGVhwvdnOV9CJDKMFQM/
	YOmZN3mo9BZIDfbSiK90iB7rFCz/PEKAvYo4KzSpCorlKUN/4Ul/itl8zJ+TFnZB7R0dOzFMK0D
	dwjD+sWsL9iudT7tvangdB1ig/AEkx68XRxaPCOoCpq4XObqXI/ZyLMPCmYrJsUxXlWgpE/gY0H
	LoovBj1BfsfJJRgKo3456FlrJTpyf5zjjV76OL0nyA0K3CyljAIYsZSXmOBugEd
X-Received: by 2002:ac8:7c41:0:b0:50d:7f91:6bd8 with SMTP id d75a77b69052e-50dd5aef77emr311172841cf.28.1776256351143;
        Wed, 15 Apr 2026 05:32:31 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm11747771cf.16.2026.04.15.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:32:30 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] thunderbolt: test: add KUnit regression tests for XDomain property parser
Date: Wed, 15 Apr 2026 08:32:20 -0400
Message-ID: <20260415123221.225149-5-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415123221.225149-1-michael.bommarito@gmail.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com> <20260415045246.GR3552@black.igk.intel.com>
 <20260415123221.225149-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238120-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6262B4044D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add three KUnit cases that exercise the defects fixed by the sibling
commits in this series by feeding crafted XDomain property blocks to
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



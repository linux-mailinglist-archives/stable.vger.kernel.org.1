Return-Path: <stable+bounces-242793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANbIM+RY92mEgQIAu9opvQ
	(envelope-from <stable+bounces-242793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:17:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4E4B5FE7
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41CA1300BC5D
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923B13CF680;
	Sun,  3 May 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2qMPCZw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5583CEBB7
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817737; cv=none; b=ihQtmFEP9ayiOtoDrPXLGETELpyoe5o0KZ/vjJSuieAWt3+bYJfyqlauj3DHCwkYCERBMA1hCPrFyE4NTwK3mLuLRMWGsW+Z9VEeYA6xQZa3RCQHdVZBVXbCQMN8cKXsY1h6Da8y+6fYECtemOvr5CiQUjNV3ZGDgrINDmI+f1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817737; c=relaxed/simple;
	bh=4/h2g963/WH6kbfJPLMHWdhyI3Xrwf9EoPjbsxH/wb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCmW7/NAZa8mExhgNbf+XHrSKBC//OP1P61nLFCJXgv5wvVSlLqIAsfv9AHKHD8bldK970g1QOXRC8dkSbI6OoxDFRPYR+KEki3GNNz4kGIG4/XDZI3l0mpKtG2fleC4ZVZj4C2RH73dzmuw2UdIp2TJUHUzABNEN4s9pW4W5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2qMPCZw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ee63e91acfso256411885a.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817735; x=1778422535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnlk5QlW8PilWssNRBG7k8CDN0LxAxtZ/pUfiIBMymg=;
        b=e2qMPCZw3AoXjSc6SMZNPc/19BQ7M6JHdXBAxYrhtTlHP4BOUiqqNycwyeDx831o8L
         HhngwUNu3+/6kVw7ebBodrU4y3Kh7Bbne8gp5+Qor6PaRuHkDosIYxRh4bVLPPxpPgaJ
         fax9yv6oCTni+KZxhlnDleDAFXJwcAbIXX7SilGlikWbBtuOh+LFB8x129w/YtteYu/C
         gu3Syk4u/sgfk7SN8PvQay//YkVEO6risxcv7eEcKRgZRIrPADk8QjBSUXxuksdItrX6
         KvvWuJ05qNwJ/uFUwadZ/SbeN1e01IcimKhFr7XoQlNhWutci9kRWbiiDUBlgcHebFES
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817735; x=1778422535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnlk5QlW8PilWssNRBG7k8CDN0LxAxtZ/pUfiIBMymg=;
        b=iOBdp00KBcw6nUY8/PPSUiXn7zV2/zAPYK5gDZf8dQklExw+1FhUV18bLB83q/Er0y
         T1SoPf8CoR9bgNh1gz2jG5yK5DCVaWRRI9sLqShOHviKmhtL+gCbEdZ/7XIGGODvC5qq
         JFojI4sFDcfYSs58Jy7NehItJ9k0atEA3kp9u4Z9xKlgWOJiioiELGE2mUEZ7HArhxHN
         P5Q1YkSDcAfSd49hi0jeD5UYdCmWnAROQoH1T9EkbE/tn4wO6eMfWuL6D3KN/GZg4CEq
         bs3YZk8mVzP6S/Law4osnFTyEJ65qZTt7VV3DOLNYsV/eFvicjbQwF7LW/85D3N2Lfnf
         +V3g==
X-Forwarded-Encrypted: i=1; AFNElJ+33mkz1lq4+LfYwDdh/aFpZ9djqzCkfssUcmvlWSX6z0U4tnJGk/E47BQab5+r5oawzN0bsfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Yivea7e5nMhPgarBmuDogEL4W+byR707g+1Q0NLnzBxE0qRp
	Vbl18C+qSEuW++2f1mQEw7ZAliYb9nNxkyGCZM+HQx9XhVIlEvdNaiK8
X-Gm-Gg: AeBDieu/HNl3I8a+OK1pdmrzOIJpgEajJC3FJoe7R9iSf+qhA7naFOtXi8icImaCtNf
	zdUSbWl/crzEADwG/IUqkH2lizZv77LuwA+u1QiyxK2J58trOzVZsr1fKKwkaBw0ed30P2+xxfT
	IXK6Dir8lIgfmBKlAdefQuCHoXravs8MTpGwQOFnfBWfpJN3LQexKy5N2KOYjcfymyk4LD5dQVd
	26CqSTZm6/RjYcBZo3Hfvhfbe/J/SdbsE/nDVOiRebYwytVRsVH4qkpxkxI8Cxbuqy+cck5aOpC
	aTdOl2Lxkre0fcNLKnT7N51kMxJWiCW29PWMPcU3KQQYtGLaM4fKEF5bxq8WzDj9SmJIl+SVhJK
	PezPRCAESQO369moqt2yyKanhybKvk6FpCFgQDvrDckTOgUEv8qVDLf/ovNsph6L4zBYVqB4lPb
	JzTk99p38yLT2UH56KBR3+3BoBBT9ou2Eds1feURl5pZE8n4/rEfqXdNtT6PSjM0q6yulkxGjkH
	biiqO1hBZT0qNveazdWIgzQdMkD2yY=
X-Received: by 2002:a05:620a:4109:b0:8ec:c4a7:f8fc with SMTP id af79cd13be357-8fd1863370emr991452685a.43.1777817734572;
        Sun, 03 May 2026 07:15:34 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e0b9sm766261985a.9.2026.05.03.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:15:32 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] thunderbolt: test: add KUnit regression tests for XDomain property parser
Date: Sun,  3 May 2026 10:15:08 -0400
Message-ID: <5caddc2abbec9d4215dfc9041ab18f84eb7bbc58.1777817011.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777817011.git.michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com> <cover.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBA4E4B5FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242793-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,intel.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add three KUnit cases that exercise the defects fixed by the sibling
commits in this series by feeding crafted XDomain property blocks to
tb_property_parse_dir():

  tb_test_property_parse_u32_wrap - entry->value = 0xffffff00 and
    entry->length = 0x100 so their u32 sum 0x100000000 wraps to 0
    under the block_len guard; without the fix the subsequent
    parse_dwdata() reads attacker-directed OOB memory.

  tb_test_property_parse_recursion - two DIRECTORY entries pointing
    at each other, driving __tb_property_parse_dir() recursion;
    without the fix the kernel stack is exhausted.

  tb_test_property_parse_dir_len_underflow - a DIRECTORY entry with
    length < 4 so the non-root UUID kmemdup of 4 dwords from
    dir_offset reads past the block, and the downstream content_len
    = dir_len - 4 size_t underflow drives the entry walk OOB.

Each test asserts tb_property_parse_dir() returns NULL on the
crafted input.  On a pre-fix kernel with CONFIG_KASAN=y, u32_wrap
trips a KASAN report inside __tb_property_parse_dir() (the parser
reads ~16 GiB past the block) and recursion trips an Oops on
RIP=0 via the stack-guard.  dir_len_underflow returns NULL on
pre-fix via the downstream content_len underflow path; the UUID
kmemdup over-read happens silently because KASAN-Generic's slab
redzones do not flag a 4-byte over-read into the kmalloc-chunk
tail, so this case is the post-fix invariant pin rather than an
active pre-fix detector.  Post-fix all three pass cleanly.

Run with:
  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
    --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_NVMEM=y \
    --kconfig_add CONFIG_USB4=y --kconfig_add CONFIG_USB4_KUNIT_TEST=y \
    --kconfig_add CONFIG_KASAN=y 'thunderbolt.tb_test_property_parse_*'

Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2 -> v3:
- De-duplicate the on-wire entry layout: define a single
  struct tb_test_property_entry shared across all three tests
  instead of re-declaring an anonymous struct in each.
- Use TB_PROPERTY_TYPE_DATA / TB_PROPERTY_TYPE_DIRECTORY
  constants from <linux/thunderbolt.h> instead of bare 0x64 /
  0x44.
- Convert all multi-line block comments to put the opening "/*"
  on its own line per the thunderbolt subsystem's coding style.
- Lowercase 0xffffff00 in commit message + code + comments.
- Tighten dir_len_underflow: use a 7-dword (28-byte) buffer so
  the non-root kmemdup over-read targets the kmalloc-32 tail
  rather than slab slop within a kmalloc-2048 chunk.  KASAN-
  Generic still does not flag the 4-byte over-read here (slab
  redzones cover next-chunk metadata, not in-chunk tail), so
  the test remains a post-fix invariant pin; documented
  explicitly above.

 drivers/thunderbolt/test.c | 132 +++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f4318249c22..73de7292ee21 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2852,7 +2852,139 @@ static void tb_test_property_copy(struct kunit *test)
 	tb_property_free_dir(src);
 }
 
+/*
+ * Reproducers for three memory-safety defects in
+ * drivers/thunderbolt/property.c reached from a crafted XDomain
+ * PROPERTIES_RESPONSE payload.  Without the fix these trip KASAN or
+ * smash the kernel stack; with the fix each returns NULL cleanly.
+ *
+ * The on-wire entry layout mirrors struct tb_property_entry in
+ * property.c (private to that translation unit).
+ */
+struct tb_test_property_entry {
+	u32 key_hi, key_lo;
+	u16 length;
+	u8 reserved;
+	u8 type;
+	u32 value;
+};
+
+static void tb_test_property_parse_u32_wrap(struct kunit *test)
+{
+	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct tb_test_property_entry *e;
+
+	/*
+	 * Root header: magic + length=6 (single entry body of 4 dwords +
+	 * 2 slack, keeps walk within block[]).
+	 */
+	block[0] = 0x55584401;
+	block[1] = 6;
+
+	/*
+	 * Crafted DATA entry at block[2..5]: value = 0xffffff00 and
+	 * length = 0x100 are u32/u16 such that the u32 sum 0x100000000
+	 * wraps to 0, passing the sum <= block_len guard even though
+	 * the real offset is block + 0xffffff00 * 4 (~16 GiB past the
+	 * block).  The subsequent parse_dwdata() copies entry->length*4
+	 * = 1024 bytes from that wild address into a fresh kcalloc
+	 * buffer.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 0x100;
+	e->type   = TB_PROPERTY_TYPE_DATA;
+	e->value  = 0xffffff00;
+
+	dir = tb_property_parse_dir(block, 500);
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_recursion(struct kunit *test)
+{
+	u32 *block = kunit_kzalloc(test, 500 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct tb_test_property_entry *e, *child_e;
+
+	block[0] = 0x55584401;
+	block[1] = 4;		/* rootdir length = one entry */
+
+	/*
+	 * DIRECTORY entry pointing at dir_offset=2 with length=16.
+	 * When parsed as non-root: content_offset = 6, content_len = 12,
+	 * nentries = 3.  The child's first entry at block[6] is also
+	 * DIRECTORY pointing at 2, so the recursion oscillates between
+	 * two dir_offsets until the kernel stack is exhausted.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 16;
+	e->type   = TB_PROPERTY_TYPE_DIRECTORY;
+	e->value  = 2;
+
+	child_e = (void *)&block[6];
+	child_e->key_hi = 0x62626262;
+	child_e->key_lo = 0x62626262;
+	child_e->length = 16;
+	child_e->type   = TB_PROPERTY_TYPE_DIRECTORY;
+	child_e->value  = 2;
+
+	dir = tb_property_parse_dir(block, 500);
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_dir_len_underflow(struct kunit *test)
+{
+	/*
+	 * Request 28 bytes (7 dwords) so KASAN-Generic tags the
+	 * 4 trailing bytes of the underlying kmalloc-32 chunk as a
+	 * slab redzone.  With block_len=7, dir_offset=4, dir_len=3,
+	 * the non-root UUID kmemdup reads 16 bytes from byte 16, so
+	 * bytes 28..31 fall in the redzone and trip a KASAN
+	 * slab-out-of-bounds report on the pre-fix kernel.  Sizing
+	 * the buffer at a power of two (32, 64, ... bytes) puts the
+	 * over-read into the slab cache tail where KASAN's generic
+	 * shadow does not flag it, and the test reduces to a
+	 * tautology because the downstream content_len = dir_len - 4
+	 * underflow also returns NULL.
+	 */
+	u32 *block = kunit_kzalloc(test, 7 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+	struct tb_test_property_entry *e;
+
+	block[0] = 0x55584401;
+	block[1] = 4;		/* rootdir length = one entry */
+
+	/*
+	 * DIRECTORY entry with length=3 pointing at dir_offset=4.
+	 * tb_property_entry_valid() permits value+length=7 <=
+	 * block_len=7.  Non-root parse begins with a kmemdup of 4
+	 * dwords from dir_offset for the UUID; with the v2 ordering
+	 * that kmemdup runs before the dir_len < 4 reject and reads
+	 * past the buffer.  With the v3 ordering the reject sits
+	 * before the kmemdup and the read never happens.
+	 */
+	e = (void *)&block[2];
+	e->key_hi = 0x61616161;
+	e->key_lo = 0x61616161;
+	e->length = 3;
+	e->type   = TB_PROPERTY_TYPE_DIRECTORY;
+	e->value  = 4;
+
+	dir = tb_property_parse_dir(block, 7);
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



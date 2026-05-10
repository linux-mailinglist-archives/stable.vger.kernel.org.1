Return-Path: <stable+bounces-245088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG4MJmcSAWq4QQEAu9opvQ
	(envelope-from <stable+bounces-245088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:19:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A92506CB7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65C83038C6B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FC3B0AD7;
	Sun, 10 May 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMbJTZQQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B343AEF28
	for <stable@vger.kernel.org>; Sun, 10 May 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455043; cv=none; b=XT3h9kFFvQaXu6BzukO19bIBRB6lpT5TCsT2g8JplCDJBeEOuyYKCqCPVsF7UOcggqdVLnbZdZ0ANFG3Ilo3pfSgV2o4Sg+uG44Cp6fKm3lv7xuldNeMJEzJ/axSESWnLpmkh43BrxPJl5xsBBO8oSbn5YlHCe5xJqKZ9vTrT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455043; c=relaxed/simple;
	bh=3ZotJzSuzGicOvCuyTT04CpVUaZMCdOlnmm3Sl4A4KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQJ7u2PaFNtJpN68FBAVhFLvZBp2IZnAzpMZ56Asq1T84hCcyQ4eupz5fBI2qAH7obvuGMe1PsdNXgLuSLHGpoCwRCaweO6DWPCwUVgjeVBPZcWWVSZ9rqB7Co11/6scO/qat0hT4K8iNkEA8p3kOtsCUKFihcaSoCL101YSvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMbJTZQQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so39980326d6.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778455041; x=1779059841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRieg0Nv/MKqd0vc2qdpdsuiA8KS3tu0ewo/5761Poo=;
        b=pMbJTZQQaBayl1qRlMd7oL8+ZbL6aZX7LSpjMFyjqblfvMZ+O5mIUdEaN7SnEXr6op
         6/ZHydGLBc29mGeHh7hMf3NH3y3CZf3ZU9qkYnum0BNnAUb7ldiwkBLnisiYriEI9ViT
         AqZfPVygoHMWtnLC0eSBmlSpT1dt3jlz4LBxhMsKyisQypKuVQbzEy6GkCaGii9Tz7NK
         jBieCFi8je6ocFTXpVHHAK92q6ogpArPrxc0uSh1ohh4qqG0D9nEiP3i4rd0Sv5Zh7+n
         fQzkl7kp55jJVsVVT3zPklzcray3Ovh8n6uos/G+pMmJg3e1wX40nxkWif4tNypT+gcR
         +YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778455041; x=1779059841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRieg0Nv/MKqd0vc2qdpdsuiA8KS3tu0ewo/5761Poo=;
        b=qRA/uCVge/mLwLvN3QYoXU0ezXkOb+s1C37ZcGP/lVG5uNvyp+HEMTy0mFpdUkiqpY
         gzZoicTekVXxOKo9wb1pPSdUomoU8wJO8th8IkWjXeSR8vhIOEBP35oX1B7HzI+Ky3d7
         1YP5Ozsw7xeicxAFBNRKRBmxJZUukgsPlMODi/i9vYR5FKtc64cdyDs/or/fyHOOIk+B
         nq4rMPgmhBTjpjUOOJNkey/3xLizZsmi9IIs6GbszTseXzH7GhPLWJGq8jmDlwA6vmaY
         rDnSTlXCsfGR5X2PdESV4t+OIBXNH8CpAzek37/R0SPFxjOVwFMTQMZjL9EGtFC22HhE
         olWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vOSxbji993KPRuV1HZYyDzmBD+k2cAncIK2zZaTqpGi6S88ToUH0rOk7vJOP9MMAufZ+/oRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWOqbxIqkJAANWB1SX4Te03hc5dyprn+AeaypQnQHsiw8Khb0
	w9d6vQxBmzm9g3oxDOP9m4AfD03+vKV6KChB4eBZTG8aKMnItR0B79c/RJj9yw==
X-Gm-Gg: Acq92OFcQ15udWF2JUMABwyBsqrIWMe1raBx4GCJx8cxKTHy52wIIn0Rx2Ws4W631FL
	YEqigMDg6JD1bDNXjWlbp7jo7iTJCwLSzGtEBK04HDcrqc00YFjOtT1x6YMYkmGKF7CaDx6gcBv
	CIa/LYASYDbPIPPYugSDmHQWGgAfH44F2wkEVsMpvGPcW319fBKlKSkiON64qJT9s4MLwItMPUz
	k1Dq3BLMmLjG9Wq8pVnl9HUGCvwSix/EfZeSerwFjiAbV3PmNIG03MsCmLoj+iqbkGSeG3Cjwuu
	r0kYnC1c1XMUBWMci/hOg2rc+iaL/AtEXIevnaZbPPMsm0e5sMELzd9m6qHFT/2O7iiGyU6c9Va
	f6Xg0OhczxIwqkcPOHsk4pqqwQfjFbx62vFUIG01zcGyamhVfA22jm4SlztWQ1+C0a27dA0LFdo
	l4fAEJmzB16UsihUHEKsBoUY0eDerLbKHpMtMzbGkiD8t6BZBHhm3XXzdxW325vWGXskkkcaTeJ
	x0no0CHrXKGrz/DCoM3/Kyhh9Qs2kBb8NFUyfdqFWc=
X-Received: by 2002:a05:622a:d5:b0:50e:18f9:b5e2 with SMTP id d75a77b69052e-51475b2acdfmr182856011cf.6.1778455040887;
        Sun, 10 May 2026 16:17:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e830ddfsm75015031cf.27.2026.05.10.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:17:20 -0700 (PDT)
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
Subject: [PATCH v4 4/4] thunderbolt: test: add KUnit regression tests for XDomain property parser
Date: Sun, 10 May 2026 19:16:59 -0400
Message-ID: <20260510231715.2215605-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.v4.git.michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com> <cover.1777817011.git.michael.bommarito@gmail.com> <cover.v4.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44A92506CB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245088-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
    length < 4 placed near the end of the block so the non-root UUID
    kmemdup of 4 dwords from dir_offset reads OOB before the later
    content_len = dir_len - 4 underflow path is reached.

Each test asserts tb_property_parse_dir() returns NULL on the
crafted input.  With CONFIG_KASAN=y, running these on the pre-fix
kernel produces an oops inside __tb_property_parse_dir or its
callees: u32_wrap takes a page fault on the KASAN shadow lookup for
the wild ~16 GiB OOB offset; recursion trips a KASAN out-of-bounds
report in __unwind_start as the per-task kernel stack is consumed;
dir_len_underflow trips a KASAN slab-out-of-bounds report in
kmemdup_noprof reading 16 bytes past the 28-byte block.  Post-fix
they pass cleanly.

The crafted blocks are populated by writing u32 dwords directly,
matching the existing root_directory[] style used elsewhere in
this file rather than imposing a private struct overlay.

Run with:
  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
    --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_NVMEM=y \
    --kconfig_add CONFIG_USB4=y --kconfig_add CONFIG_USB4_KUNIT_TEST=y \
    --kconfig_add CONFIG_KASAN=y 'thunderbolt.tb_test_property_parse_*'

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/test.c | 126 +++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f4318249c22..f41fabf15456 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2852,7 +2852,133 @@ static void tb_test_property_copy(struct kunit *test)
 	tb_property_free_dir(src);
 }
 
+/*
+ * Reproducers for three memory-safety defects in
+ * drivers/thunderbolt/property.c reached from a crafted XDomain
+ * PROPERTIES_RESPONSE payload.  Without the fix these trip KASAN or
+ * smash the kernel stack; with the fix each returns NULL cleanly.
+ *
+ * The on-wire entry layout matches struct tb_property_entry in
+ * property.c (private to that translation unit): u32 key_hi, u32
+ * key_lo, then a packed u32 = (type << 24) | (reserved << 16) |
+ * length, then u32 value.  Each entry is 4 dwords.
+ */
+
+static void tb_test_property_parse_u32_wrap(struct kunit *test)
+{
+	/*
+	 * 0x102 dwords: enough for the entry's length field (0x100) to
+	 * pass the "entry->length > block_len" gate so the wrap check
+	 * is actually exercised.  parse_dwdata's downstream OOB read
+	 * lands ~16 GiB past the allocation regardless.
+	 */
+	u32 *block = kunit_kzalloc(test, 0x102 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+
+	KUNIT_ASSERT_NOT_NULL(test, block);
+
+	block[0] = 0x55584401;	/* "UXD" v1 magic */
+	block[1] = 0x00000004;	/* Root directory length: one entry */
+
+	/*
+	 * DATA entry whose value 0xffffff00 + length 0x100 wrap to 0
+	 * in u32, passing the sum <= block_len guard even though the
+	 * real offset is far past the allocation.
+	 */
+	block[2] = 0x61616161;	/* key_hi */
+	block[3] = 0x61616161;	/* key_lo */
+	block[4] = 0x64000100;	/* type=DATA, reserved=0, length=0x100 */
+	block[5] = 0xffffff00;	/* value */
+
+	dir = tb_property_parse_dir(block, 0x102);
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_recursion(struct kunit *test)
+{
+	/*
+	 * 10 dwords: rootdir header (2) + parent DIRECTORY entry (4) +
+	 * the child entry that lives at dir_offset(2) + UUID(4) = 6,
+	 * occupying block[6..9].  Each recursive level re-reads the
+	 * same block[6..9] as its first child entry, which is itself
+	 * a DIRECTORY pointing at offset 2.
+	 */
+	u32 *block = kunit_kzalloc(test, 10 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+
+	KUNIT_ASSERT_NOT_NULL(test, block);
+
+	block[0] = 0x55584401;	/* "UXD" v1 magic */
+	block[1] = 0x00000004;	/* Root directory length: one entry */
+
+	/*
+	 * DIRECTORY entry pointing at dir_offset = 2 with length = 8.
+	 * Non-root parse derives content_offset = 6, content_len = 4,
+	 * nentries = 1.  block[6..9] is read both as the parent's UUID
+	 * (kmemdup'd into dir->uuid) and as the single child entry --
+	 * which is itself a DIRECTORY pointing at offset 2, so the
+	 * recursion never terminates and the kernel stack is exhausted.
+	 */
+	block[2] = 0x61616161;	/* key_hi */
+	block[3] = 0x61616161;	/* key_lo */
+	block[4] = 0x44000008;	/* type=DIRECTORY, reserved=0, length=8 */
+	block[5] = 0x00000002;	/* value = dir_offset */
+
+	block[6] = 0x62626262;	/* doubles as UUID dword 0 / child key_hi */
+	block[7] = 0x62626262;	/* doubles as UUID dword 1 / child key_lo */
+	block[8] = 0x44000008;	/* type=DIRECTORY, reserved=0, length=8 */
+	block[9] = 0x00000002;	/* value = dir_offset (back at parent) */
+
+	dir = tb_property_parse_dir(block, 10);
+	KUNIT_EXPECT_NULL(test, dir);
+	tb_property_free_dir(dir);
+}
+
+static void tb_test_property_parse_dir_len_underflow(struct kunit *test)
+{
+	/*
+	 * Allocate exactly 7 dwords (28 bytes) so the kmalloc-32 chunk
+	 * leaves a 4-byte slab redzone tail that KASAN-Generic can flag.
+	 * With block_len = 7, dir_offset = 4, dir_len = 3, the non-root
+	 * UUID kmemdup reads 16 bytes from byte 16, so bytes 28..31 fall
+	 * in the redzone and trip a KASAN slab-out-of-bounds report on
+	 * the pre-fix kernel.  Sizing the buffer at a power of two (32,
+	 * 64, ...) puts the over-read into the slab cache tail where
+	 * KASAN's generic shadow does not flag it, and the test reduces
+	 * to the downstream content_len = dir_len - 4 underflow path
+	 * which also returns NULL.
+	 */
+	u32 *block = kunit_kzalloc(test, 7 * sizeof(u32), GFP_KERNEL);
+	struct tb_property_dir *dir;
+
+	KUNIT_ASSERT_NOT_NULL(test, block);
+
+	block[0] = 0x55584401;	/* "UXD" v1 magic */
+	block[1] = 0x00000004;	/* Root directory length: one entry */
+
+	/*
+	 * DIRECTORY entry with length = 3 pointing at dir_offset = 4.
+	 * tb_property_entry_valid() permits value(4) + length(3) <=
+	 * block_len(7).  Non-root parse begins with a kmemdup of 4
+	 * dwords from dir_offset for the UUID; that read runs past the
+	 * 28-byte allocation before the dir_len < 4 reject would fire.
+	 */
+	block[2] = 0x61616161;	/* key_hi */
+	block[3] = 0x61616161;	/* key_lo */
+	block[4] = 0x44000003;	/* type=DIRECTORY, reserved=0, length=3 */
+	block[5] = 0x00000004;	/* value = dir_offset */
+	/* block[6] is the start of the four UUID dwords; block[7..] is OOB. */
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


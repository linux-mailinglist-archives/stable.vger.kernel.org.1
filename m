Return-Path: <stable+bounces-238019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJtXB9cE32khNwAAu9opvQ
	(envelope-from <stable+bounces-238019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:24:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F403FFF4E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B719230471F2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FDA3126D0;
	Wed, 15 Apr 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8LIGHIv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDB314B9A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223434; cv=none; b=emxPcG9eUqdcOnQLGc2ManO/CK2hniB3Wm0IQa3T++TRvzzvrBlKUQOXeoVMzN+0XMG+1jmcRZre/M7X7ymc9gVF/jHKxCjQ1Bru+emheMp0aM2buBwZKZMVWALYq42T9DYvs5elwKKFetVARi8KvSjsjSHWWN5BnAmdKqn6Umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223434; c=relaxed/simple;
	bh=c7fhQU1kmA/OElXvm8TnzPS64pwv6uUDN6n799rAG68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJMzEkUIFjRmezTa0zKXZk6C6Up/S1LGIoCvRmIc4H9cobeMA/DcjPLOw+Y9LaA7GXbE8Wrc5pVz1Amkclzv6QG63cXfOT5R+7IlqdSEaLr+VE6tH37yUaOLODL0HJvGcwREGmnsSAnVbysMKGQOBlthfFN7izlRdb/j4DXi1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8LIGHIv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d87610513so62675221cf.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223432; x=1776828232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt6/nBfZ3xp0yA3aOUH7lrksq26RDqGq7BPA0rF82PY=;
        b=I8LIGHIvX4nPkX9meKsaTB7B81xLzqeQ92i/rtzw4hHJfnZiLd6BPsgGJNPNX5xAz5
         OsOqZYfPDp57fRnSoHG90B/ga+w1P6KrdG0elJtbYH9oD+O7Ic5+vCnh3tfsQuqeOGTK
         7gmtBuUoDTFy7O57kWeiUl3bCsTXpTP/uMUCZcjMy1uGVl/3dfGRT1rMuJw4yzauEpSr
         xnOb+TqDUaP+IDlBsSFzlOT31PvIe/InADfZio2jrFXcqJ7uA8jjzrP94LM7koza/xkY
         zqzSVO0JLs8W+Uea7hWJSmOmX4oiwMCYKnj/oBb+g7t1fdnMWEsZxr9OFUDet/UBbJPE
         +H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223432; x=1776828232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kt6/nBfZ3xp0yA3aOUH7lrksq26RDqGq7BPA0rF82PY=;
        b=HVOhcm7IGlAuvWsKjqeylgfeUu8ITx5cyuAdh38vNkZCskRIzKfENGs0g4OxvP4s+L
         Md5HDtGED9g1iFRE9TEuNa4Val8qqO/xwJfb5DyVDHocET25ZwCyUW3G2/6GEKfJW99H
         ftPpE/F192pOItrQGFu0rmO+mwlJLClcXUEaNa2Jzo14HJ8e+4dvsCha8SEtHZ62nA/D
         eUQYgbloE6szsakLVgNudtSCsLtZ1lp5SUuR7Ynf7j845PCSjx8ltmnkX9+JFG6yqTmM
         rKHF+yGTIlX2H//8ZMckRi/U9dubBsuW/6Rkqde7APzpf46dbDQIFm6gcHXdoPFV/d/V
         lzIA==
X-Forwarded-Encrypted: i=1; AFNElJ8infQ7/P9Qa/VCzoyU1kBlXXzE+JlxdTcTYW9uhmMwSBk0G8+C5aFXn1h8hLgSiustSJwRW0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2Q7RK920K/09PqlB8SoLwgxdFlmbQpDYQCJsC20IGQ2Yn/PO
	J10SvRi0wUeJ+SuCLk7CTzeC4T6V5OYjEfIUZcv9M8ngt4iGoLC/Y2mz
X-Gm-Gg: AeBDietDdR1iwXUfE9Ovj+1Io3xYH6uatqY4kRCwCAaobex6ynHqk6+XBr2X4XaPMqg
	CT7mxxtpFpn/gDlmO81/G4K1SVkGrr3t+Yho5KUk8YA2bE5bNW5uZZi5ximL/DBRlaakhMIFV7z
	ZV3rJWicmshYvwDQVclzoOm+iTHfw0QUUoQTUvfLy3+MPPkwJq+PgceG2Q/6Zo8DcB1dBSJMCO3
	3AxCmk/Oxvv+85xCclpybD/fvKkOl5RllVpiCAITbCsMx50HZ7qLBXYS0X9jWosa4MXL3vM+Reg
	theAP5e8GDG0hcacs2C6PvNeJAfiFy+OYmCNHcL6HcID7NUEaBqc9duojrAIneJAViTssa8I3rZ
	rjWTlc6Hpo2KRPVp5DInG/gQTkQpDWhgbO7oGtAO+8uAoFk5U9K0Yb89p3bW2HDpQ3lLNg4Z9cg
	2jAzp/b7iQBV0Gm36AvAS6crRYjrtBuIcABwd0HIiRbvK4PAhJ8xZWErzudwQRCFZHO/q38WiqY
	iXhV16+OOq3G4f7xNY3R7VSXZXkdzHn5CFB8MEvUw==
X-Received: by 2002:a05:622a:1822:b0:50d:736a:6248 with SMTP id d75a77b69052e-50dd5b30c24mr318069561cf.11.1776223432105;
        Tue, 14 Apr 2026 20:23:52 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b012b23sm3713071cf.30.2026.04.14.20.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:23:51 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] thunderbolt: property: harden XDomain property parser against crafted peer
Date: Tue, 14 Apr 2026 23:23:34 -0400
Message-ID: <20260415032335.2826412-2-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238019-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83F403FFF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three independent memory-safety defects in
drivers/thunderbolt/property.c are reachable when an untrusted
Thunderbolt/USB4 XDomain peer responds to a PROPERTIES_REQUEST
during host-to-host discovery.  The peer supplies up to
TB_XDP_PROPERTIES_MAX_LENGTH (500) dwords of attacker-controlled
property block which the local host passes to tb_property_parse_dir()
before PCIe tunnel authorization.

Bug A - u32 overflow in tb_property_entry_valid() (property.c:61).

    if (entry->value + entry->length > block_len)
            return false;

entry->value is u32, entry->length is u16.  The sum is computed in
u32 and wraps.  With block_len = 500 an attacker picks
value = 0xFFFFFF00, length = 0x100; the u32 sum 0x100000000 wraps
to 0, passing the > block_len check.  tb_property_parse() then
runs

    parse_dwdata(property->value.data, block + entry->value,
                 entry->length);

where block is const u32 * and entry->value is promoted to size_t
for the pointer arithmetic.  The read source is block +
(u64)value * 4, tens of GiB past the property-block allocation.
Up to entry->length * 4 bytes are read from there into a freshly
kcalloc'd property->value.data or property->value.text buffer.

Exfiltration path for TB_PROPERTY_TYPE_TEXT on the "deviceid" or
"vendorid" keys: populate_properties() (xdomain.c:1157,1162) runs
kstrdup(p->value.text, ...) into xd->device_name / xd->vendor_name,
which are read back via the per-XDomain device_name and vendor_name
sysfs attributes (xdomain.c:1730, 1763).  kstrdup stops at the
first NUL byte in the OOB region, so the usable leak is the prefix
up to the first zero byte at an attacker-chosen offset past the
property block.  The attacker does not know block's KASLR/slab
placement, so the read is untargeted in absolute terms - they pick
a delta, not an address.  There is no generic "properties" sysfs
blob; DATA-typed properties are parsed into property->value.data
but never generically surfaced to userspace, so only the TEXT path
with the two named keys is exfil-reachable.  NUL-bounded,
untargeted, but still an attacker-directed OOB read.

Replace the u32 addition with check_add_overflow() so a wrapped
sum is rejected.

Bug B - unbounded recursion in __tb_property_parse_dir().

A DIRECTORY entry's value field is used as dir_offset for a
recursive call with no depth counter.  A peer that crafts a back-
reference chain drives the parser until the 16 KiB kernel stack
is exhausted and the guard page fires - pre-authentication remote
DoS.  Bound the recursion to TB_PROPERTY_MAX_DEPTH = 8,
comfortably larger than any legitimate XDomain property layout.

Bug C - size_t underflow on dir_len - 4 (property.c:184).

    content_offset = dir_offset + 4;
    content_len = dir_len - 4; /* Length includes UUID */

dir_len arrives as a size_t sourced from entry->length (u16) on
the non-root path.  If entry->length < 4, the subtraction
underflows size_t to ~SIZE_MAX, nentries becomes SIZE_MAX / 4,
and the loop walks entries past the property block on each
iteration, reading OOB until either an entry fails validation or
the kernel oopses on an unmapped page.  Reject dir_len < 4
explicitly on the non-root path.

Additional hardening: move INIT_LIST_HEAD(&dir->properties) to
immediately after dir allocation so every error-return path that
calls tb_property_free_dir() (including the new dir_len path and
the pre-existing dir->uuid alloc-failure path at property.c:180)
sees a walkable empty list rather than the zero-initialized NULL
next/prev that would oops list_for_each_entry_safe().

All three defects are OOB-read plus DoS class.  No controlled OOB
write is reachable through the parser; parse_dwdata's destination
is a freshly kcalloc'd buffer sized by entry->length.

Attacker model: malicious Thunderbolt/USB4 XDomain peer (cable,
dock, in-line inspector, adjacent host).  Discovery runs as soon
as the link is trained; PCIe tunnel authorization does not gate
the control-plane PROPERTIES_REQUEST/RESPONSE path, and the host
IOMMU does not mitigate because the data arrives as a control-
plane payload the driver willingly copies into its own buffer
before parsing.

Reproduced on v7.0-rc7 + CONFIG_KASAN=y + CONFIG_USB4_KUNIT_TEST=y
via the companion KUnit suite in the sibling patch.  Pre-fix, each
of the three cases oopses inside __tb_property_parse_dir (Bug A
hits a KASAN shadow-memory fault, Bug B trips the stack guard,
Bug C OOB-reads past the property block).  Post-fix, all three
tests return NULL cleanly and pass.

The parser sites fixed here have not been touched since the
initial 2017 XDomain landing, per git log -p.  property.c has had
three prior fixes by Kangjie Lu in 2019 (106204b56f60,
e4dfdd5804cc, 6183d5a51866) for NULL-check omissions on
kzalloc/kmemdup returns, and a 2025 documentation cleanup by Alan
Borzeszkowski (d015642ad36d); none of those touch the bounds /
arithmetic / recursion sites this patch addresses.  Verified via
lei queries against lore.kernel.org/linux-usb/ for
dfn:drivers/thunderbolt/property.c,
dfhh:tb_property_parse_dir, dfhh:tb_property_entry_valid (0 hits
beyond the doc cleanup); Patchwork linux-usb "thunderbolt
property" query (0 in-flight patches); and Mika Westerberg's
westeri/thunderbolt.git next/fixes/master branches (no pending
bounds work on this file).

Fixes: e69b6c02b4c3 ("thunderbolt: Add functions for parsing and creating XDomain property blocks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/property.c | 67 +++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..57ec742ed210 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -8,11 +8,21 @@
  */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uuid.h>
 #include <linux/thunderbolt.h>
 
+/*
+ * Bounds recursion depth when parsing a malicious XDomain property
+ * block whose DIRECTORY entries are crafted to self-refer.  The
+ * XDomain spec gives no hard limit; 8 is comfortably larger than any
+ * legitimate property layout observed in practice and leaves the
+ * kernel stack headroom.
+ */
+#define TB_PROPERTY_MAX_DEPTH	8
+
 struct tb_property_entry {
 	u32 key_hi;
 	u32 key_lo;
@@ -37,7 +47,7 @@ struct tb_property_dir_entry {
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
-	bool is_root);
+	bool is_root, unsigned int depth);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -52,13 +62,23 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
 static bool tb_property_entry_valid(const struct tb_property_entry *entry,
 				  size_t block_len)
 {
+	u32 end;
+
 	switch (entry->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 	case TB_PROPERTY_TYPE_DATA:
 	case TB_PROPERTY_TYPE_TEXT:
 		if (entry->length > block_len)
 			return false;
-		if (entry->value + entry->length > block_len)
+		/*
+		 * entry->value is u32 and entry->length is u16; the sum is
+		 * performed in u32 and wraps for crafted inputs.  Use an
+		 * overflow-aware check so a wrapped sum is rejected instead
+		 * of appearing to satisfy the bound.
+		 */
+		if (check_add_overflow(entry->value, (u32)entry->length, &end))
+			return false;
+		if (end > block_len)
 			return false;
 		break;
 
@@ -93,7 +113,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -114,7 +135,8 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false,
+					      depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -159,16 +181,33 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 }
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
-	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root)
+	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root,
+	unsigned int depth)
 {
 	const struct tb_property_entry *entries;
 	size_t i, content_len, nentries;
 	unsigned int content_offset;
 	struct tb_property_dir *dir;
 
+	/*
+	 * A malicious XDomain peer can craft DIRECTORY entries whose
+	 * offsets point back at their own container, making the recursion
+	 * unbounded without this gate.
+	 */
+	if (depth > TB_PROPERTY_MAX_DEPTH)
+		return NULL;
+
 	dir = kzalloc_obj(*dir);
 	if (!dir)
 		return NULL;
+	/*
+	 * Initialize the list head immediately so every error-return path
+	 * that calls tb_property_free_dir() (the new dir_len reject and
+	 * the existing uuid-alloc failure path) sees a walkable empty
+	 * list rather than the zero-initialized NULL next/prev that
+	 * would oops list_for_each_entry_safe().
+	 */
+	INIT_LIST_HEAD(&dir->properties);
 
 	if (is_root) {
 		content_offset = dir_offset + 2;
@@ -181,18 +220,28 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 			return NULL;
 		}
 		content_offset = dir_offset + 4;
+		/*
+		 * dir_len arrives here as the u16 entry->length widened to
+		 * size_t; values below 4 underflow size_t on the subtraction
+		 * below and produce a gigantic content_len, driving the
+		 * nentries loop off the block with OOB reads on each
+		 * iteration.
+		 */
+		if (dir_len < 4) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 		content_len = dir_len - 4; /* Length includes UUID */
 	}
 
 	entries = (const struct tb_property_entry *)&block[content_offset];
 	nentries = content_len / (sizeof(*entries) / 4);
 
-	INIT_LIST_HEAD(&dir->properties);
-
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i],
+					     depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -231,7 +280,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**
-- 
2.53.0



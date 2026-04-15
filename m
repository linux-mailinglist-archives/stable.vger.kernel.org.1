Return-Path: <stable+bounces-238119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA3XOQWG32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479134044C4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D73230E58F4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B786299AB1;
	Wed, 15 Apr 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozgPSYWH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF22D7812
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256352; cv=none; b=CDX0j1eml5q0Q9CHfsDEdDupw9RvTUN6Hc0Je1E3WSeh0bCa+X4D0i/CI9sRwSzwiXt3fZ10lsg7tWehcY6E3ellQdiCeyLGdDbaR/JvHrUgLh4uqhsYg34xi3VB4p8kLp0v+xiJnBa0Hxmm8RVbFWaONmpuqUDYxzPT9rNRDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256352; c=relaxed/simple;
	bh=yy8Ncc37XYKb193wi7SYVyUlnpHGTC4Pmm6nqvvfk7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLIvHIBh/r1zGyytEwjQqUQ85bfeZTY5HTCMmkeoGw/lFKsBR3v+00F6Y5CyVlDzruzYxgcW/+OMoYXxdhXzGBorBpF7hyRo/NTWBcekhAsa7+73zYyHt1vkKqcxj7h0nnP5KxN6fEGDl9pBxW0BuLNS7daJq9+nGV9hAWRba6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozgPSYWH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d4f78fc9f6so804047385a.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256350; x=1776861150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snQIRoJJuRpCmh2yyUJKgsvwSWDhZnmvhy2vz0AOQb4=;
        b=ozgPSYWHjnMWbbuIXyxSvs9/ztHJDmRvnYgkVAX/ONc2aBicbgde6HX6ywfRPJY5fs
         w+NMbG9C1N80aQM5ZrQjCH26mFhOjke67RdjqRdGshuLWKnQdHlj2Xa0l7nZMJRUP6Rm
         UNe9S8qcWb1B8B/wwVkulvqXN8RXhO17fwVjKYdGO92oZIDXRzV9XQo69WKt250rMxaR
         e0bslEUa7tmzx2etmYF8UJS++n5NE06MH/f6NdzYfFvVlqCbksEgmOhP84zTlX83d0nb
         qEB6MtbYUI2nebMmx8YFkIETtcHOjPzuQvAA5ugI9jDdS3rH3PrAmy9ItDDqQ2Cv3V5M
         QDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256350; x=1776861150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snQIRoJJuRpCmh2yyUJKgsvwSWDhZnmvhy2vz0AOQb4=;
        b=lWBHdlKBgXImbi1/rNateBRj++JO6cyAZOqgu3mhaz/I2E6UVCPWuSqUm0BjkqD9Bb
         1oCANjpPeqv7gAy2qWbS8jC9QrYZ56N9BReddmh6Svcf36M+jAlhp68XcIEXQG0IPRJP
         4ediC2G6MUW+LR9e8mrPUJPf4U6bJhGleCoYLo8nF8rKd5JC1HRXwPNo6xltw2uLq8/+
         MLeiIbvzC7zEpKigP8pGGa33jpvNFHBvzb5q0Sp4NVtZPCJ4S4fmOlNvVlzMLyKBsYis
         ktzUgI51IrTf7OCxQ105P6RKoSvDAePJJCZrsNnIPQGAQIsr5ZBgc9ebBclB4EFMYbz0
         syUw==
X-Forwarded-Encrypted: i=1; AFNElJ8105kMJknxaoZcJMrxvVr15tnWgDQ5XGiQ+/ZTu4krZTnuH5MYJ+Vgd+zLSjQv/kvOkyOcVrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJkaReGeJ7rgxA9BbsKm3Y8sM5zufTwdyy6trMKLFHZsZ1NIU
	R5RqUr9/nc28hkBNgt7oN7CwXriDc3jz5gZm3i6CEIB/4IVIa9goK4BN
X-Gm-Gg: AeBDiesbRPmY46y4wBesXbZXwyDtp9Qxq+05/cBKYlqALqaBW0TuIQd8amZRdsTW7Z1
	vACGcqwU25Bxk43FpAAIK616ddH6AN8wBEtnplrH2LDpbuDyAep9y7g5jvtNP5LZI3jgwDqK3zg
	9oEYGs3hpoJLd/Zw5zHT1yPHyYtzCvYtx7IAHiJM8rcmGo9BbhEr0X3OAT88vgDceiJdqdnZRuN
	y7gVEIuL+mvDwQ1ApbCra82qr9JlEisxy6BCymugCTTGVP5o+7/hsPNPtFW7EMRyM8FSaM3OCyd
	fXuEb7owEReZYHI7C2B5vkJX6zHa/1fN4CSVZCRhufUNB1UkJtNZF9Ex1KiOWbawF5VlaNHskq0
	oDqL0cNYOpr9BXQTO1UUbNhw1vq3am0GC6ijEXlLjYRdQLp2bP8KpPvaDPutPUSj7BWtXFfZ6SM
	gHspseusI8XO9uhZxFyOxnSd7wzVrB4vv6nRz0m4rSqbf2+wPSmodDJL/aQVjP6timWsH2yEkZi
	8QdpLdfNscz2lgowGgvdJaNbNEtynWD0TGcWGH3IDTXBTIaDwCx6YrMCO1hRZm3
X-Received: by 2002:a05:622a:4811:b0:50d:6b06:a44e with SMTP id d75a77b69052e-50dd5ad8901mr325245731cf.17.1776256349793;
        Wed, 15 Apr 2026 05:32:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm11747771cf.16.2026.04.15.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:32:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] thunderbolt: property: cap recursion depth in __tb_property_parse_dir()
Date: Wed, 15 Apr 2026 08:32:19 -0400
Message-ID: <20260415123221.225149-4-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238119-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 479134044C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A DIRECTORY entry's value field is used as the dir_offset for a
recursive call into __tb_property_parse_dir() with no depth counter.
A crafted peer that chains DIRECTORY entries into a back-reference
loop drives the parser until the kernel stack is exhausted and the
guard page fires.  Any untrusted XDomain peer (cable, dock, in-line
inspector, adjacent host) that reaches the PROPERTIES_REQUEST
control-plane exchange can trigger this without authentication.

Thread a depth counter through tb_property_parse() and
__tb_property_parse_dir(), and reject blocks that exceed
TB_PROPERTY_MAX_DEPTH = 8.  That is comfortably larger than any
observed legitimate XDomain layout.

Operators who do not need XDomain host-to-host discovery can disable
the path entirely with thunderbolt.xdomain=0 on the kernel command
line.

Fixes: e69b6c02b4c3 ("thunderbolt: Add functions for parsing and creating XDomain property blocks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/property.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 274b555d27c8..99ee7089456c 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -35,10 +35,11 @@ struct tb_property_dir_entry {
 };
 
 #define TB_PROPERTY_ROOTDIR_MAGIC	0x55584401
+#define TB_PROPERTY_MAX_DEPTH		8
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
-	bool is_root);
+	bool is_root, unsigned int depth);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -97,7 +98,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -118,7 +120,7 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false, depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -163,13 +165,17 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
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
 
+	if (depth > TB_PROPERTY_MAX_DEPTH)
+		return NULL;
+
 	dir = kzalloc_obj(*dir);
 	if (!dir)
 		return NULL;
@@ -199,7 +205,8 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i],
+					     depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -238,7 +245,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**
-- 
2.53.0



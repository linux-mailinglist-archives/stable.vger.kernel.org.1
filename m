Return-Path: <stable+bounces-265234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3C6THaKGMWqnlgUAu9opvQ
	(envelope-from <stable+bounces-265234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F348769312A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="S/Ul5VxH";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265234-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265234-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA063054524
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927647A0A9;
	Tue, 16 Jun 2026 17:16:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2D478E50;
	Tue, 16 Jun 2026 17:16:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630164; cv=none; b=sdKEbIqaAnuLw/QArAbi2xmxsKLjQQkZbKS2if/cZx4BgVDD+BIW/loJm6xg1YVUjmJotPFciLhhMFf3XhoxrV43oqdloSNiXWwDqM6XxPs2iMkfE3eFOLzWK8KKLHHK3H9+QFFpKhYTKl+q95pvfyqqtHvCWBHxUza0pquoT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630164; c=relaxed/simple;
	bh=95DudTWTjV7RVGR8OaEmKR8EqxHvVN1qsM8DxatFgHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSIzFKieoAs+PnMJSF5a50iQ+7lpG4dmvn9IfgaEqsN2c7/JZEKd5IEgdIvGTrd9QrEfTI0mp5rvCBEHrJbYo4Fc5ZWFXXsnsBo+mt4XkcUtFWP4XbYcndrvyHLqgsxeP7iD+CYgk44U3LX0B+3ZMXhcaohOj/zQP6tRnBaUM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/Ul5VxH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15571F000E9;
	Tue, 16 Jun 2026 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630161;
	bh=AlLRMO/RyRJ4yYCORYroaXR3yXi6VmD0BFrRxQwM2zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/Ul5VxHzwjKLhcT9JYOZ599qUlR92T8iaJ7KTzE/H8z65gFWUDRR+Re1I3LlYx4M
	 lekX6nKftnUqoCpGfJJ3qgIHqOvvXUMpkX6SN5DnukJF95ocNQ3+Fsos5wi278O0Jw
	 Ws5Vjjrr0jyWRqexkqX1OFz/zdfQdB2EdjQcwSEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 423/452] thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
Date: Tue, 16 Jun 2026 20:30:50 +0530
Message-ID: <20260616145138.944965963@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265234-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:mika.westerberg@linux.intel.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F348769312A

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 928abe19fbf0127003abcb1ea69cabc1c897d0ab ]

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

Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/property.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

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
@@ -99,7 +100,8 @@ tb_property_alloc(const char *key, enum
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -120,7 +122,7 @@ static struct tb_property *tb_property_p
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false, depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -165,13 +167,17 @@ static struct tb_property *tb_property_p
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
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
 		return NULL;
@@ -206,7 +212,7 @@ static struct tb_property_dir *__tb_prop
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i], depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -243,7 +249,7 @@ struct tb_property_dir *tb_property_pars
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**




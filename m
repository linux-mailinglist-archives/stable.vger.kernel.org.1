Return-Path: <stable+bounces-269514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id glG0M/QLQWo/kgkAu9opvQ
	(envelope-from <stable+bounces-269514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 13:56:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CAE6D3BF1
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 13:56:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=C9L7MwuH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269514-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269514-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D08AC300F127
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0D3242DF;
	Sun, 28 Jun 2026 11:56:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A840D579;
	Sun, 28 Jun 2026 11:56:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647788; cv=none; b=o+gyQ2OpUGsUTNQeVLWWgUUqBBYWj0CsBkkedfe7WltO56I+u5BzLEEzylFsaLcbwY1jed9oZTegxQ/Lj3/1NmPOUpSVie5GhDiIYEkapcnb5Y4LGLbQfx2oBXoxoZE0FeOW+UeV+EaPIV3RIxNvH8xf8A1RbETR/l2FdCHs4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647788; c=relaxed/simple;
	bh=jTWWh1tKxDFXqhkSVWN1Toj4FXa5WZltnczbZ7n9RKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgiEVKcYzJcLlIXqWwbY5tJjCoInhR/EBx3zXcrzv2qU7SgOGuV6o3UEYqKzrcHYtHg5DqeS2SrHstyT3iBo0hzOS8IBIRpYLkF30ZL6dCDKjWoz6ToLKwHO0rD1s+Hhz74wQqER4lzLgUu9c2tob9sCGkWj51iSLnwg6qpLNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=C9L7MwuH; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782647776;
	bh=B/665U26R3pCtZe5u2+nqaMVhFALqRoFhzpvxj3yhEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=C9L7MwuH2bppq7GFJ2mSf+UfnxLNkSdzzsIVOB4C0KRvscnnd0RN/aPGUwJlh1n8z
	 V3nt040kU0LzqX3grHWJ1PcXO2dabKYVplxILLeS4X/fYrW/FO/64KVrqZPVMeNa+j
	 2HhLudh8Sd64d33+vzIQWoulInM0pC2jhvM98i5Y=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gp7D06zgHz10tq;
	Sun, 28 Jun 2026 11:56:16 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gp7D02dr2z10nN;
	Sun, 28 Jun 2026 11:56:16 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: leitao@debian.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH] lib/bootconfig: fix undefined behavior involving NULL pointer arithmetic
Date: Sun, 28 Jun 2026 11:56:16 +0000
Message-ID: <20260628115617.3190-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269514-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:mhiramat@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29CAE6D3BF1

When xbc_snprint_cmdline() is called during the size-probing phase
(with buf = NULL and size = 0), the function computes the end pointer
as 'buf + size' (NULL + 0) and repeatedly advances the pointer via
'buf += ret'.

Under the C standard, performing pointer arithmetic on a NULL pointer is
undefined behavior. While harmless inside the kernel, this code is also
compiled into the userspace host tool 'tools/bootconfig', where host
compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
detect NULL pointer arithmetic.

Fix this by tracking the running written length as an integer offset
('len') rather than advancing 'buf' directly. Only perform pointer
arithmetic if 'buf' is actually non-NULL.

Fixes: 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.5-flash
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 lib/bootconfig.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f445b7703fdd..0181459505b7 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -410,8 +410,6 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
-#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
-
 /**
  * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
  * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
@@ -427,8 +425,8 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 {
 	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
 	const char *val, *q;
+	size_t len = 0;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -439,10 +437,12 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			ret = snprintf(buf ? buf + len : NULL,
+				       size > len ? size - len : 0,
+				       "%s ", xbc_namebuf);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
@@ -452,17 +452,18 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 			 * whitespace.
 			 */
 			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+			ret = snprintf(buf ? buf + len : NULL,
+				       size > len ? size - len : 0,
+				       "%s=%s%s%s ",
 				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 		}
 	}
 
-	return buf - (end - size);
+	return len;
 }
-#undef rest
 
 /* XBC parse and tree build */
 
-- 
2.53.0



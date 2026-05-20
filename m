Return-Path: <stable+bounces-251271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH6fGb0WDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:17:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C553599638
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CFE33F3CF0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81A366075;
	Wed, 20 May 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRBzm0Sl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B308369999;
	Wed, 20 May 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297549; cv=none; b=FsaZwsKNzMiWBs6QTkPkJGqoYgpkvzGbYVSOMTebvlY0UP6qyYcR2ql5xwV84byaSDiAdr9u5XlNIeV/OSxV6rtGBEDWlzGbxdtvcHm2MlU+4T6A2yQOEfTrnyXZ2p34OgsVYh3vpk00O492n1wsOux3U5nbVEvX/nJMT6u/DfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297549; c=relaxed/simple;
	bh=YEL7NAqQ7oNp1EeZMQLnF/8x4uOk/g1sk5TxB7vqby0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FllB7k4mwGvbgMeMHtPj6GCJ4GDcTrHcvROM348hVN9229xTcKISp9B+RG1I48QPK/rZrOw8mCA+yNhsm8auha305KNGMj3oK4GzS7sERUr9JwjtFmH1CmDQdR5bozfpbdMJQYxw+V7MV5TQAweXZxQns5dDOYiP4SFL3xLwgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRBzm0Sl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26E81F00893;
	Wed, 20 May 2026 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297548;
	bh=lU/XJzMeakcmv6tGU655Mm0Rqu4NxwAjhvlkLxw4v+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRBzm0Sl1c6gSwf7V3yoQ8IXJRs9hEZBeuex9TmscsFO1z3djBLcuwFXqY0WDK3Ma
	 yf+qklI3Uzix1uytLBCA59gVFMizOaf+7dPtdaJyq17N58smKv4YkDkOjs9YPAJli7
	 hiKSd/5S891+UM3Os9oEdHYIHbeICKYo/fMsOiP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/957] tools/nolibc/printf: Change variables c to ch and tmpbuf[] to outbuf[]
Date: Wed, 20 May 2026 18:09:15 +0200
Message-ID: <20260520162136.126677787@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,1wt.eu,weissschuh.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1wt.eu:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6C553599638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Laight <david.laight.linux@gmail.com>

[ Upstream commit f675ae28fcdf7db93a8c1a6964f062725b1e06a0 ]

Changing 'c' makes the code slightly easier to read because the variable
stands out from the single character literals (especially 'c').

Change tmpbuf[] to outbuf[] because 'out' points into it.

The following patches pretty much rewrite the function so the
churn is limited.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://patch.msgid.link/20260223101735.2922-7-david.laight.linux@gmail.com
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Stable-dep-of: 4045e7b19bbf ("tools/nolibc/printf: Move snprintf length check to callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stdio.h | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 1f16dab2ac884..aff11d6069f6f 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -250,16 +250,16 @@ typedef int (*__nolibc_printf_cb)(intptr_t state, const char *buf, size_t size);
 static __attribute__((unused, format(printf, 4, 0)))
 int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list args)
 {
-	char escape, lpref, c;
+	char escape, lpref, ch;
 	unsigned long long v;
 	unsigned int written, width;
 	size_t len, ofs, w;
-	char tmpbuf[21];
+	char outbuf[21];
 	const char *outstr;
 
 	written = ofs = escape = lpref = 0;
 	while (1) {
-		c = fmt[ofs++];
+		ch = fmt[ofs++];
 		width = 0;
 
 		if (escape) {
@@ -267,17 +267,17 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 			escape = 0;
 
 			/* width */
-			while (c >= '0' && c <= '9') {
+			while (ch >= '0' && ch <= '9') {
 				width *= 10;
-				width += c - '0';
+				width += ch - '0';
 
-				c = fmt[ofs++];
+				ch = fmt[ofs++];
 			}
 
-			if (c == 'c' || c == 'd' || c == 'u' || c == 'x' || c == 'p') {
-				char *out = tmpbuf;
+			if (ch == 'c' || ch == 'd' || ch == 'u' || ch == 'x' || ch == 'p') {
+				char *out = outbuf;
 
-				if (c == 'p')
+				if (ch == 'p')
 					v = va_arg(args, unsigned long);
 				else if (lpref) {
 					if (lpref > 1)
@@ -287,7 +287,7 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				} else
 					v = va_arg(args, unsigned int);
 
-				if (c == 'd') {
+				if (ch == 'd') {
 					/* sign-extend the value */
 					if (lpref == 0)
 						v = (long long)(int)v;
@@ -295,7 +295,7 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 						v = (long long)(long)v;
 				}
 
-				switch (c) {
+				switch (ch) {
 				case 'c':
 					out[0] = v;
 					out[1] = 0;
@@ -314,30 +314,30 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 					u64toh_r(v, out);
 					break;
 				}
-				outstr = tmpbuf;
+				outstr = outbuf;
 			}
-			else if (c == 's') {
+			else if (ch == 's') {
 				outstr = va_arg(args, char *);
 				if (!outstr)
 					outstr="(null)";
 			}
-			else if (c == 'm') {
+			else if (ch == 'm') {
 #ifdef NOLIBC_IGNORE_ERRNO
 				outstr = "unknown error";
 #else
 				outstr = strerror(errno);
 #endif /* NOLIBC_IGNORE_ERRNO */
 			}
-			else if (c == '%') {
+			else if (ch == '%') {
 				/* queue it verbatim */
 				continue;
 			}
 			else {
 				/* modifiers or final 0 */
-				if (c == 'l') {
+				if (ch == 'l') {
 					/* long format prefix, maintain the escape */
 					lpref++;
-				} else if (c == 'j') {
+				} else if (ch == 'j') {
 					lpref = 2;
 				}
 				escape = 1;
@@ -348,7 +348,7 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 		}
 
 		/* not an escape sequence */
-		if (c == 0 || c == '%') {
+		if (ch == 0 || ch == '%') {
 			/* flush pending data on escape or end */
 			escape = 1;
 			lpref = 0;
@@ -369,7 +369,7 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 
 			written += len;
 		do_escape:
-			if (c == 0)
+			if (ch == 0)
 				break;
 			fmt += ofs;
 			ofs = 0;
-- 
2.53.0





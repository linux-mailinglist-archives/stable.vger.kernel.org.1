Return-Path: <stable+bounces-251272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOKsErsWDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:16:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AB599630
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7160833F5DF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447BC36C9D2;
	Wed, 20 May 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvZP6HzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE02DC76C;
	Wed, 20 May 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297552; cv=none; b=WQI8MLHx0lGEU7rIsXXz3ii93hTgN/08ZeZBUhBLj9ZLIMFS/+TeA0CuURpozSMjGnxLW/IarftrA80I33ADCaMNNFHRLxBlP6+26m1M1getzNieXvagtDrtQopnAa2uXXjWWdLKDs9DNEjrUEr7TRtR3tSoQnnqzK035ReOSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297552; c=relaxed/simple;
	bh=Q2wbG9+FfNh8CE31B7Q3zY41ywJQrEYX4iCh4k3b9+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTAUFWFGHsrXbs5nok2se75E8Ok6XXn535CPUW6W1Y6na14mulLChQPxB/XWfUou7IMXMNWcJywYP8+Df4WZ3zMYypQdiWcGMx9PMpii/xYLnj2U6ITOTlGr/57lqhmUKyRPf5YX1HiCWjhJBVxYvrzrAwH4Yz7x3ghvMIx92Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvZP6HzU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4879E1F000E9;
	Wed, 20 May 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297550;
	bh=jpZhS609gYl1ap+mHd7TiOu+VcqUlHyva9r8mDm/Lx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvZP6HzUt5IydaSEQ7c1wrqCQLTO54EDakB97u/iXvEq11Ykx16jQGg2+fE88bz+r
	 jT/BtiP+Wk+98okk9bLTdLvTK0YBrDxkX1mUF4qHsIdaZbh2Ani2Njch5L5bHkRSCP
	 fO1xslidOSX042wKSCj51WpzQwIuSNt58bqEgmzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 073/957] tools/nolibc/printf: Move snprintf length check to callback
Date: Wed, 20 May 2026 18:09:16 +0200
Message-ID: <20260520162136.148004937@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251272-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,1wt.eu,weissschuh.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,weissschuh.net:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1wt.eu:email]
X-Rspamd-Queue-Id: 9D3AB599630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Laight <david.laight.linux@gmail.com>

[ Upstream commit 4045e7b19bbf7338452cda11e64cfe7ae3361964 ]

Move output truncation to the snprintf() callback.
This simplifies the main code and fixes truncation of padded fields.

Add a zero length callback to 'finalise' the buffer rather than
doing it in snprintf() itself.

Fixes: e90ce42e81381 ("tools/nolibc: implement width padding in printf()")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://patch.msgid.link/20260302101815.3043-3-david.laight.linux@gmail.com
[Thomas: clean up Fixes trailer]
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stdio.h | 94 +++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index aff11d6069f6f..a2fc7c8706dfa 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -244,16 +244,25 @@ char *fgets(char *s, int size, FILE *stream)
  *  - %[l*]{d,u,c,x,p}
  *  - %s
  *  - unknown modifiers are ignored.
+ *
+ * Called by vfprintf() and snprintf() to do the actual formatting.
+ * The callers provide a callback function to save the formatted data.
+ * The callback function is called multiple times:
+ *  - for each group of literal characters in the format string.
+ *  - for field padding.
+ *  - for each conversion specifier.
+ *  - with (NULL, 0) at the end of the __nolibc_printf.
+ * If the callback returns non-zero __nolibc_printf() immediately returns -1.
  */
-typedef int (*__nolibc_printf_cb)(intptr_t state, const char *buf, size_t size);
+typedef int (*__nolibc_printf_cb)(void *state, const char *buf, size_t size);
 
-static __attribute__((unused, format(printf, 4, 0)))
-int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list args)
+static __attribute__((unused, format(printf, 3, 0)))
+int __nolibc_printf(__nolibc_printf_cb cb, void *state, const char *fmt, va_list args)
 {
 	char escape, lpref, ch;
 	unsigned long long v;
 	unsigned int written, width;
-	size_t len, ofs, w;
+	size_t len, ofs;
 	char outbuf[21];
 	const char *outstr;
 
@@ -355,17 +364,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 			outstr = fmt;
 			len = ofs - 1;
 		flush_str:
-			if (n) {
-				w = len < n ? len : n;
-				n -= w;
-				while (width-- > w) {
-					if (cb(state, " ", 1) != 0)
-						return -1;
-					written += 1;
-				}
-				if (cb(state, outstr, w) != 0)
+			while (width-- > len) {
+				if (cb(state, " ", 1) != 0)
 					return -1;
+				written += 1;
 			}
+			if (cb(state, outstr, len) != 0)
+				return -1;
 
 			written += len;
 		do_escape:
@@ -378,18 +383,25 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 
 		/* literal char, just queue it */
 	}
+
+	/* Request a final '\0' be added to the snprintf() output.
+	 * This may be the only call of the cb() function.
+	 */
+	if (cb(state, NULL, 0) != 0)
+		return -1;
+
 	return written;
 }
 
-static int __nolibc_fprintf_cb(intptr_t state, const char *buf, size_t size)
+static int __nolibc_fprintf_cb(void *stream, const char *buf, size_t size)
 {
-	return _fwrite(buf, size, (FILE *)state);
+	return _fwrite(buf, size, stream);
 }
 
 static __attribute__((unused, format(printf, 2, 0)))
 int vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-	return __nolibc_printf(__nolibc_fprintf_cb, (intptr_t)stream, SIZE_MAX, fmt, args);
+	return __nolibc_printf(__nolibc_fprintf_cb, stream, fmt, args);
 }
 
 static __attribute__((unused, format(printf, 1, 0)))
@@ -447,26 +459,54 @@ int dprintf(int fd, const char *fmt, ...)
 	return ret;
 }
 
-static int __nolibc_sprintf_cb(intptr_t _state, const char *buf, size_t size)
+struct __nolibc_sprintf_cb_state {
+	char *buf;
+	size_t space;
+};
+
+static int __nolibc_sprintf_cb(void *v_state, const char *buf, size_t size)
 {
-	char **state = (char **)_state;
+	struct __nolibc_sprintf_cb_state *state = v_state;
+	size_t space = state->space;
+	char *tgt;
+
+	/* Truncate the request to fit in the output buffer space.
+	 * The last byte is reserved for the terminating '\0'.
+	 * state->space can only be zero for snprintf(NULL, 0, fmt, args)
+	 * so this normally lets through calls with 'size == 0'.
+	 */
+	if (size >= space) {
+		if (space <= 1)
+			return 0;
+		size = space - 1;
+	}
+	tgt = state->buf;
+
+	/* __nolibc_printf() ends with cb(state, NULL, 0) to request the output
+	 * buffer be '\0' terminated.
+	 * That will be the only cb() call for, eg, snprintf(buf, sz, "").
+	 * Zero lengths can occur at other times (eg "%s" for an empty string).
+	 * Unconditionally write the '\0' byte to reduce code size, it is
+	 * normally overwritten by the data being output.
+	 * There is no point adding a '\0' after copied data - there is always
+	 * another call.
+	 */
+	*tgt = '\0';
+	if (size) {
+		state->space = space - size;
+		state->buf = tgt + size;
+		memcpy(tgt, buf, size);
+	}
 
-	memcpy(*state, buf, size);
-	*state += size;
 	return 0;
 }
 
 static __attribute__((unused, format(printf, 3, 0)))
 int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
-	char *state = buf;
-	int ret;
+	struct __nolibc_sprintf_cb_state state = { .buf = buf, .space = size };
 
-	ret = __nolibc_printf(__nolibc_sprintf_cb, (intptr_t)&state, size, fmt, args);
-	if (ret < 0)
-		return ret;
-	buf[(size_t)ret < size ? (size_t)ret : size - 1] = '\0';
-	return ret;
+	return __nolibc_printf(__nolibc_sprintf_cb, &state, fmt, args);
 }
 
 static __attribute__((unused, format(printf, 3, 4)))
-- 
2.53.0





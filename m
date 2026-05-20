Return-Path: <stable+bounces-250112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMEwLfvjDWpN4gUAu9opvQ
	(envelope-from <stable+bounces-250112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EC59233C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A615306F0DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7E3E832A;
	Wed, 20 May 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNbwXiYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE3E2764;
	Wed, 20 May 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294575; cv=none; b=hHnlGjvrhnxesoaJlCgb8MUKZNNZh6Mv/zXVa+gIJjKG9YPy6N4Hu+EzdYMnAJ/53BIkWdnVhfohHh0+Tpco3D2Lrpc/GEoSePsPnaz1FLZ96df7rz0M//e//kQpe7Mx3s+/9XEjjqsKveHHKn8R3K3JBZ7RsFs3GZ8BrbHrr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294575; c=relaxed/simple;
	bh=fhDd1YU2p0BTQeKO9tS6XvwCKi8+hhy5kShgz4hSgFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYOGflT88k1axtWH9oaLPpbpcJDuye8pZzTD2a8DyuIXzHtGk9ytA7ZychyQPN2GRR7CcfQWVGfe+wVeV199egT8FHv80KkzeuTqiYFRfcaHKR2O9YpiDjBKJ47O0X+OyJGYOOlekLLBgeMatyVfodQlt5h68cRjmeKtx8d3eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNbwXiYM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E051F00893;
	Wed, 20 May 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294574;
	bh=gjcZOsWjHsWo4vdVR/8x4gzKH6QV9dvQHPUPI6EYGhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNbwXiYMzTXLR03jXCJ4nYXK6u/o5QKgNcJW9SGZ7NTQasO/QXmvw/g/2ttokzOon
	 yTPV0j5i1BR/GuwwvG1YDZWqqOnHeji2A1uTFOUW+U82XwcXiXBWHScSaCu8lHzvca
	 C2WGyU4euVbmpFF/9wXKYaQd6IxhHcl/Z7arc+5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0092/1146] tools/nolibc: avoid -Wundef warning for __STDC_VERSION__
Date: Wed, 20 May 2026 18:05:42 +0200
Message-ID: <20260520162150.434519168@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250112-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,weissschuh.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7E6EC59233C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 3eb97c4cbd4d874e7e327ec512f6169934e12b8a ]

With -std=c89 the macro __STDC_VERSION__ is not defined.
While undefined identifiers in '#if' directives are assumed to be '0',
with -Wundef a warning is emitted.

Avoid the warning by explicitly falling back to '0' if __STDC_VERSION__
is not provided by the preprocessor.

Fixes: 37219aa5b123 ("tools/nolibc: add __nolibc_static_assert()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://patch.msgid.link/20260318-nolibc-wundef-v1-1-fcb7f9ac7298@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/compiler.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index a8c7619dcdde2..a8d5ca58dd632 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -47,6 +47,12 @@
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
 
+#if defined(__STDC_VERSION__)
+#  define __nolibc_stdc_version __STDC_VERSION__
+#else
+#  define __nolibc_stdc_version 0
+#endif
+
 #define __nolibc_version(_major, _minor, _patch) ((_major) * 10000 + (_minor) * 100 + (_patch))
 
 #ifdef __GNUC__
@@ -63,7 +69,7 @@
 #  define __nolibc_clang_version 0
 #endif /* __clang__ */
 
-#if __STDC_VERSION__ >= 201112L || \
+#if __nolibc_stdc_version >= 201112L || \
 	__nolibc_gnuc_version >= __nolibc_version(4, 6, 0) || \
 	__nolibc_clang_version >= __nolibc_version(3, 0, 0)
 #  define __nolibc_static_assert(_t) _Static_assert(_t, "")
-- 
2.53.0





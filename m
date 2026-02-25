Return-Path: <stable+bounces-219588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOxZJBvgnmmCXgQAu9opvQ
	(envelope-from <stable+bounces-219588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:42:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C5196BF1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB2C531423D0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5939E6D8;
	Wed, 25 Feb 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DT38Dg0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L52sHMMi"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03739B4BC
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019321; cv=none; b=HBnuXy5v43GKTCen/VR3KjTy4sMGD//hkSxxAEyh0i2PUuhjFvwMUe64rLcAiw7a4psn58+OPfZUPq0RnYnTxBb3OQzaKWVr9g0uGYe2EZyA1S7+RtpVxwYJ2BjjPG3+LJqN+dpMLnjLtThdYLzTXy/PMneLeCX0grLLfUkT1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019321; c=relaxed/simple;
	bh=/iL768wrkbgbRiOTBywjkoKVrZeqgYHhX79dn2PbqRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dPBHXvJUYFtv3F0PsNsAgfGlpH6SgDHdSUjhMOj1l+Bxj3jmDu+Rc0OH44DBPeE7JvBc3mE8gBWAV18xWpAJkx/pqgvXJssEAcxsPhPoknvCdyHXLSEkx8ksj7XYTmNV4uYA4xnw4tdGqj7acRMzNJNWR+smFFw/3KF6x650heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DT38Dg0h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L52sHMMi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772019312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jK/Tw373BHnWppkmA4XB3+tjL35wAyvMdvylFj+nWKY=;
	b=DT38Dg0hrg7Ezf2fijoVgwBJrLyjZpyuZi62A5pSrxSfSpkVdxxKIhZb6dOKCe5ABNM/3c
	bpDGHoj3HgxSWhmsLfKQDGD9osABstOZIDxvjbyHavZAQM6B8U4L3q2s5BRtoi0Ic+kH3g
	v2ljHQmAa7DcMINTztpEUnCf3TTYxdA0eq4/+VY3rCIdWHhOSxWhgLvcyQj/ptM+QX8NQA
	08lwgfYiCReN5wxYIb6f0PojtiWwiuujT0dHgkDTquS37jG60Dix1u2lpdBEehmLFnUa9E
	fzo4assX+n2+3hLLP44mh09R6ta5TN1fj2AVtIjkTzkrQMEoJFbdIml0WTZDRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772019312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jK/Tw373BHnWppkmA4XB3+tjL35wAyvMdvylFj+nWKY=;
	b=L52sHMMim0VeEphJfaP52buPXcovwO3rFleNQ8Aqqb+FKZGkeUytToo12ipLGKWxYp3lq9
	tWKIhqwvAGa2zwAQ==
Date: Wed, 25 Feb 2026 12:35:09 +0100
Subject: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.18.y 6.19.y] ARM: clean
 up the memset64() C wrapper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrDIBBEf0X2XEWXKG1/peSgyaYValrcUBpC/
 j1LhGHezGFmA6aaieGuNqj0y5w/sxR3UTC84vwknUfpgBaDRfQ61qILFaYldJqXmN6kx8HalEQ
 uTiDLb6Up/8/XB3jjrFmVwAuCcaeHlrHh2nAzK/T7fgC9ZxpHlQAAAA==
X-Change-ID: 20260225-arm-memset64-stable-dc00bb0bb1af
To: stable@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772019310; l=2434;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/iL768wrkbgbRiOTBywjkoKVrZeqgYHhX79dn2PbqRc=;
 b=anvmZIgUuJlF271gicKnTtiZzwvvhmiD0zyN5vKUzjL2fkxsTTKu0R9SzV6Oqhp9lxxFKKO8w
 Hi+vSEvQcHjAzR8SXsOW4KkyJkwfzm2Ffu9dKn4mwW9rfMRQVzLWkjv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219588-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,decadent.org.uk:email,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 099C5196BF1
X-Rspamd-Action: no action

[ Upstream commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf ]

The current logic to split the 64-bit argument into its 32-bit halves is
byte-order specific and a bit clunky.  Use a union instead which is
easier to read and works in all cases.

GCC still generates the same machine code.

While at it, rename the arguments of the __memset64() prototype to
actually reflect their semantics.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
---
Hi stable team,

unfortunately the backports of commit 23ea2a4c7232 ("ARM: 9468/1: fix
memset64() on big-endian") does not work on 5.10 and 5.15 as
CONFIG_CPU_LITTLE_ENDIAN does not exist there, effectively breaking memset64()
on little-endian. Please use this variant instead which always works.
For consistency I prefer to have it backported to all versions.
---
 arch/arm/include/asm/string.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index b5ad23acb303..369781ec5511 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -33,13 +33,17 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
 }
 
 #define __HAVE_ARCH_MEMSET64
-extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
+extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
 static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
-	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
-		return __memset64(p, v, n * 8, v >> 32);
-	else
-		return __memset64(p, v >> 32, n * 8, v);
+	union {
+		uint64_t val;
+		struct {
+			uint32_t first, second;
+		};
+	} word = { .val = v };
+
+	return __memset64(p, word.first, n * 8, word.second);
 }
 
 #endif

---
base-commit: 3e2558088a1a3dc941eec8edafd002758ae97d77
change-id: 20260225-arm-memset64-stable-dc00bb0bb1af

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>



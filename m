Return-Path: <stable+bounces-233710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP+wOdhJ1Wlg4QcAu9opvQ
	(envelope-from <stable+bounces-233710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 20:15:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B13B2DA1
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0EB43031AD4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E58834;
	Tue,  7 Apr 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osLfkc7R"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACC2DF717
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585740; cv=none; b=twfIfgZGudfsYAqs1Hgf0Ucup/lYQuddlciCYANFxFYLIssV9Pt4btT86nOnCMQqC7WTFegVxeOFgsS200NNRMGEWEnPoi3nG7u6Gj/yGmGBTzpuh+uwTScQmOkhJHWV5M28BaZZ1uRSK2LkGq073bUetPEwktHwLEMrPz3QFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585740; c=relaxed/simple;
	bh=MyhOVEiw/qMJA/HKOs18Ls9TDPdBBtMhop+aDAFUy/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPYrFXrbMH4wIQPCUFJ0Zq9uyJSZLyQyuX5auZZ2DNBXitOLsj8ysBc1hr8Woh92gayNezY8jLPN8d7cONstbOe+zIOMF1FNVdBOXK87LMYAdFOR21jPYqXKKGhGmBL4w3N//Dxm65TmJ4HfRYpq//WohzoPuThUVs08yiT83vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osLfkc7R; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d8e11b948so24418521cf.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775585736; x=1776190536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl0fSOLNOL0VYWbHLlMdkEjeY0mPmotcIP2HiCQA9z8=;
        b=osLfkc7RD01PrCFneYJN1JLUFIirbUB1nuZoQoQejJjhQVji1hWwC+iZTbrO7MOHG8
         2CJniYtnQsuklHJtladBifbYUxgznMD5Kc+2V40JjXNcC/jhn9fHwPIQK5VQ0a+rcRvC
         xseaYACzV/Fmtp2Y0pg2ZRKUR3ZHcEQ7bHOIdb4JNuDLTSWsvjmkTF8tE897Wd9EOy+T
         rhn0zjsnEs762+IuHmted5fuW/vafO7cpiSeq3iZFQoanYaipHNaKNCdwwZ2FicjUcg0
         x+7J2LIXXCLnmzWQO/VKF7AqoLxpLgSLTFobks78E5EJOHdF2fOwEvV2iZWtqNWwlUT6
         +WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585736; x=1776190536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vl0fSOLNOL0VYWbHLlMdkEjeY0mPmotcIP2HiCQA9z8=;
        b=awv2d2uQ0fo6P0oxmx+Md4WF2F+50SAkTbyvBqZTCrMFRoX0xZV/rFfQVHkyIxvVV/
         qG6ZputQuZ2MxAzst7fUkuLQZxKxC4ASlYD5AHh1OmZ7DXpCYoavJ00HeoGg7cwgYHBD
         cp5XwU2sFCYQYKTCPCiR08SJa1PxHmgaMwOKpTtPz14EkSTOq4J4fcL3vYQemC8O2VhF
         UiODYVJ0P+FkJS1fJwbRcfFf8f2fM1q0t8pL2LZurA7zNtDekj1PlMH+s5Hyrc5djqUY
         9tYjwJAfjWCXCLZpaUilRro8+4XTURI0UKr3j3qTMTD1sOXTyYZ9JMCqIefktEqzlCRf
         XRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWPhFmRjSjWJ3F//upJRbvC9e1lYsM3yv204uEjsZkfiSDI0pbPdJrm7Fxui0Ot3ETqq+iwsv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzM/XrA+oshhelja10hsADJtflUESgv0Kp9/Qh7Z3BJYS3RFhC
	TVRqTWoQfVwmbsQypTGOsk1YvwPB1yA4iDMADxMqI1wyy7C4LfAalqU0
X-Gm-Gg: AeBDievmfP0JVR2sP76RsgTZ/NR2I839DoLLBW9fhGb+STYB1MVcWP2h8Y39k4LzM74
	Sg9KvnRf0O65QbIIPAxvzy+uKJcrVNLn0wtQPHNYrHAANQP8g+wtkuGiBo+lNTz9sbLLhvS2Ojv
	jTbcXWKlJrw6W9ZCnOqDUXetSzwqDaZG0xnd6Q4AZ4RuJVL1jjf13Phqzfnmm6uKlHfIrw8igqQ
	xQRIIm1OwwUijm1bqq4f/et1nmeJkCUpk50zADUAKK91NFJg/Px7vWxNrogAiVjSBFAc+CCV9XS
	fE+1MBW4nPet/H4LgFlxk0438OeKRl9lzCZwYCoGbMbFW88+1lqsuH+F/MQU3VNA6iA4k9YVxfo
	9emNGF62MIJJpnKHsFhdvnuGoeZqlZJNeef3G2nETlApeOmP8bCQIt0YfslbVffww5NTPck92Y8
	xs0oY1eO8/K/7d3Yj7x8eAJDJLTq0LDJXPugHT8+NPkvdkOiKe/9FcgsAZK3dtxYvuekgN5Qgtj
	dIimq9/0zsntLlokG4IWWuUh6TJVz1kq7+WKQ==
X-Received: by 2002:a05:622a:8d06:b0:509:15aa:cf01 with SMTP id d75a77b69052e-50d62b57d4cmr246252501cf.61.1775585736146;
        Tue, 07 Apr 2026 11:15:36 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593908b47sm186312926d6.11.2026.04.07.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:15:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Tue,  7 Apr 2026 14:15:28 -0400
Message-ID: <20260407181528.879358-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407164435.726012-1-michael.bommarito@gmail.com>
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233710-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 491B13B2DA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Building ARCH=um on a host with glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c:156:17: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

cow_user.o is a host-side helper (compiled with -D__UM_HOST__) that
calls strrchr().  It inherits the global -Dstrrchr=kernel_strrchr
remap from arch/um/Makefile, which is intentionally kept in
USER_CFLAGS to prevent libc/kernel symbol clashes.

This combination was harmless until glibc 2.43, which added (glibc
commit cd748a63ab1a, "Implement C23 const-preserving standard library
macros"):

  #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, C))

The glibc function-like macro replaces the -D object-like macro.  The
inner strrchr token in the expansion is protected from recursive
expansion, so it refers to the bare symbol strrchr -- but the header
declaration was already rewritten to kernel_strrchr by the -D.  The
result is an implicit-declaration error.

The global -Dstrrchr=kernel_strrchr remap was originally added in
commit 2c51a4bc0233 ("um: fix strrchr() problems") to resolve a
linker clash when both CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are
set.  Recently, commit a74b6c0e53a6 ("um: Don't rename vmap to
kernel_vmap") trimmed the now-obsolete vmap remap and updated the
comment in arch/um/Makefile to explicitly call out
-Dstrrchr=kernel_strrchr as one of the remaps that still prevents
libc symbol clashes.  That global remap stays in place.

Rather than exempting cow_user.o from the remap at build time, call
kernel_strrchr() explicitly in the source.  This is slightly more
honest about which strrchr the code wants (the kernel's, as it has
been since 2011), sidesteps the interaction with glibc's C23 macro
entirely, avoids adding a new libc strrchr dependency to the UML
binary, and is robust to future C23 const-preserving macros for
strchr, memchr, strstr, etc.

cow_user.o is built whenever CONFIG_BLK_DEV_UBD=y (the standard UML
block device), so this affects most non-trivial UML configurations.
cow_user.c is the only file under arch/um/ that calls strrchr(), so
no other translation units need changes.

Standalone reproducer (fails on glibc >= 2.43, succeeds on older):

  printf '#include <string.h>\nvoid f(void) { char *p = strrchr("foo", 47); }\n' \
    | gcc -c -Dstrrchr=kernel_strrchr -x c - -o /dev/null

Tested on:
  - Host:   Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
  - Kernel: v7.0-rc6 (3aae9383f42f); verified that neither
            arch/um/drivers/Makefile nor arch/um/drivers/cow_user.c
            changed between rc6 and rc7, so the fix applies and
            behaves identically on both
  - Build:  ARCH=um defconfig + CONFIG_BLK_DEV_UBD=y, clean compile
            with no warnings
  - nm:     cow_user.o references 'U kernel_strrchr' (not libc
            strrchr), and the final linux binary has no
            strrchr@GLIBC_2.2.5 symbol anywhere; kernel_strrchr is
            defined exactly once by lib/string.o and
            EXPORT_SYMBOL'd
  - Boot:   UML boots to Debian bookworm multi-user and graphical
            targets with a COW overlay (ubd0=cow,backing), which
            exercises the patched absolutize() -> kernel_strrchr()
            code path in cow_user.c

AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
assisted with debugging, test design, and drafting; the author
manually reviewed every line and executed every build and boot test
on the host.  Full disclosure was posted with v1; a shorter summary
is in the Assisted-by: trailers below.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v1:     https://lore.kernel.org/all/20260407164435.726012-2-michael.bommarito@gmail.com/
Review: https://lore.kernel.org/linux-um/1e15d25c23b444eae1dcfc01432e7ec1e19e25a0.camel@sipsolutions.net/

Changes since v1:
 - Per Johannes Berg's review (link above): rather than exempting
   cow_user.o from the global -Dstrrchr=kernel_strrchr remap via
   -Ustrrchr in arch/um/drivers/Makefile, call kernel_strrchr()
   explicitly in cow_user.c.  This keeps the existing semantic that
   cow_user.o uses the kernel's strrchr (no new libc dependency on
   the host side), and the source no longer relies on the build-time
   rewrite at all.
 - Reverted the arch/um/drivers/Makefile CFLAGS change from v1.
 - Verified locally on v7.0-rc6: clean build, cow_user.o references
   'U kernel_strrchr' (no libc strrchr), the final linux binary has
   no strrchr@GLIBC_2.2.5 reference anywhere, and the kernel boots
   to multi-user with a COW overlay that exercises the patched
   code path.  Full boot log captured locally.

 arch/um/drivers/cow_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 29b46581ddd1..ec8e6121b402 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -15,6 +15,12 @@
 #include "cow.h"
 #include "cow_sys.h"

+/*
+ * arch/um/Makefile remaps strrchr to kernel_strrchr; call the kernel
+ * name directly to avoid glibc >= 2.43's C23 strrchr macro.
+ */
+extern char *kernel_strrchr(const char *, int);
+
 #define PATH_LEN_V1 256

 /* unsigned time_t works until year 2106 */
@@ -153,7 +159,7 @@ static int absolutize(char *to, int size, char *from)
 			   errno);
 		return -1;
 	}
-	slash = strrchr(from, '/');
+	slash = kernel_strrchr(from, '/');
 	if (slash != NULL) {
 		*slash = '\0';
 		if (chdir(from)) {
--
2.49.0


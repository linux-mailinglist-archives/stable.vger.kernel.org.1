Return-Path: <stable+bounces-233689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIwTEhM11WnY2gcAu9opvQ
	(envelope-from <stable+bounces-233689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE83B200C
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE5D3038EF6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477C3CFF6C;
	Tue,  7 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwKpMidJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472623CEB8A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580332; cv=none; b=YMcWfPrR6JZ9g7pkbBG4YqVyWhO+anHrPovS63KvrEVBDnzhh0ZTQkm5P5AXSIBx3dHz92q030ZwIFhD2Vzxf2UeW7f8gBPWWLu5xDNXberFLJXQ40apyISHOjvK1Gl0UPq7E1pUV/a01E+QEzR7CGDdQoBXlVqQcuUnjUldHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580332; c=relaxed/simple;
	bh=f5xgWFoHlxDGIzM61JqlzIzWWv8eJwK0O4pMM5aCB+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCS867LUgCImRAEmsuIEZ6X6/AowpVj5n89FQffHmS+/FL1nSzsrHt2HiWjvkiba0OGJ/mQnPSay57u6cmnWfY5jgFB5KphY2lJ1Ok/Yse9rEJGUkaQxFLmm5AOGrJIUmWc1JgQBu6+KJ56+uS7uKwBfhWv3Vyfo4awOdIqtSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwKpMidJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89cc71f4311so69420596d6.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775580329; x=1776185129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVD3gsLs5pyKc/GN8/ouN0bgbaQzwLmJCimCeB/EV+Q=;
        b=HwKpMidJRnNdNtG3qGmAuXrCcZphHzBWIVDcYP4vFE83N9ro/BZ/DfQwDwqOz3lhY9
         CVv8UIb/LXWWuwCy1ekWx47zzObKPT2gw4CKZXr7RgM0tmbfrHoJDKLzRbCC16mNeeY4
         jEsHoLVlGZloQDQJUeW/Prrqh9uXdePho59W9V6ykr/E29EixkZ3RJuGkZW56c6obGT3
         +g9QMphOU2sNN3y8drvf57ctdE4J9SESJKZeAvfKdFa0/iGAsEeRrMZmmxrtoXICGUgG
         HgqiF9ZhqEDCvf+7tApH5WesmHoITjgIsxyD+Vnra8pYeNNcE08q+5GmDzca+amo2NMl
         hLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580329; x=1776185129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVD3gsLs5pyKc/GN8/ouN0bgbaQzwLmJCimCeB/EV+Q=;
        b=D1syaaVFCpSXzzgy2EmT8iLP3VTBji1Df7O4D6YAx3SxKwtCvDT6kkfR2bkcvmm9E7
         G/VX+qY38mRfoapWymKOlk/3DDWBUc4GtL6asQ64jI15JoO2bkPHf2xuQP+6r96rqkhN
         NGQlvUqQ8xild4N4MyBr/TiyzFmJxLscc1sAF+Sa5/bcPBXMdj75hUd9veJ79Z2a4JiO
         tZeTRiIc6r2mvSX6QxTWXn9E6HBsv9PqKJO1nFOQMPpgRTlhyV8z+UnyBEGcOSukWNFI
         a+gZTyhxhD39AGyOkUGSjx4u6cDOJGMpz6aC3lwPUJb0LWQOjSbQzaxGsDGDG471/XDq
         wqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtI+YK5Kim6etLs0AgiKFI6Mz+4l3E0I854gXBDfGvMMb/OtQZcJdzKHBrorUyvJ0GSfTSsXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RB/bbDveTD3k+PczPlvt0Kf9Nyp02rG98BGqOGdxCyhwPuwl
	mCwCKHAMsxz2GP9XvmkBYQ+vW5OFygWQ+TVpChN2rbi1q0TyhwsMqukd
X-Gm-Gg: AeBDieuxrsur7e9AmsHzTJvGpVXoBG6njnj7iGB9kerir0XoKa/n93xZtOnYPR1QTD5
	WEk0omQddNLX0CqAuMiQw99x0b4W840rIDahOBJmMo1gurMHGkh619N0KQ2R//lpe//1thK5V89
	ADWI7Ah57uD3wDhtO7CRc5/dsUoSsqpd7kZVMSPb6XjZMJNIucFVvny37dUf+jA89iE33Y7F5qQ
	XHoaLsE6EUNxC9spWPSROvpjW3nVA4Kiy5F/0H3x7Vcc/Lt60UeIKqQG7nVPds3D9l/HO4UerBz
	ogpkSIF6QHQK+mKEk/iUZPoZVlTXrK8eXTlV7MYdWNDbBpEp9BrB3BHHZEpcBw46+STff5oR5Tu
	5aoPrpnpqnHsYqZDngX5TUd0o77pUjYPjQK8FSi6+K3MofGE+Dg9uy8/QqEUH13qpXT8NKjoW77
	YHNZRzZjuDwCJa0j6lJ7xi+5uaBDZ69quiHpLgXRS25l399wn3XrCz/Tg779FserdqDvTpTYKgk
	z32Eg761M+Qs0PK0n9SbWW97Y4=
X-Received: by 2002:a05:6214:258c:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8a7023c032dmr293344546d6.15.1775580329106;
        Tue, 07 Apr 2026 09:45:29 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm62044156d6.22.2026.04.07.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:45:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] um: drivers: use libc strrchr() in cow_user.o
Date: Tue,  7 Apr 2026 12:44:35 -0400
Message-ID: <20260407164435.726012-2-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233689-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCDE83B200C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Building ARCH=um on a host with glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c:156:17: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

cow_user.o is a host-side helper (compiled with -D__UM_HOST__) that
calls libc strrchr().  It inherits the global -Dstrrchr=kernel_strrchr
remap from arch/um/Makefile, which is intentionally kept in USER_CFLAGS
to prevent linker clashes between libc and kernel symbols.

This combination was harmless until glibc 2.43, which added (glibc
commit cd748a63ab1a, "Implement C23 const-preserving standard library
macros"):

  #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, C))

The glibc function-like macro replaces the -D object-like macro.  The
inner strrchr token in the expansion is protected from recursive
expansion, so it refers to the bare symbol strrchr -- but the header
declaration was already rewritten to kernel_strrchr by the -D.  The
result is an implicit-declaration error.

The remap was originally added in commit 2c51a4bc0233 ("um: fix
strrchr() problems") to resolve a linker clash when both
CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are set.  Recently, commit
a74b6c0e53a6 ("um: Don't rename vmap to kernel_vmap") trimmed
the now-obsolete vmap remap from arch/um/Makefile and updated the
comment to explicitly call out -Dstrrchr=kernel_strrchr as one of the
remaps that still prevents libc symbol clashes.  That framing is kept
here: the global strrchr remap is still needed for kernel-side
objects, but cow_user.o is host-side and should use libc strrchr
directly.

cow_user.o is built whenever CONFIG_BLK_DEV_UBD=y (the standard UML
block device), so this affects most non-trivial UML configurations.
cow_user.c is the only file under arch/um/ that calls strrchr().

Fix this by undoing the remap for just this translation unit via
per-object CFLAGS.  In UML's Makefile.rules, CFLAGS_$(basetarget).o
is appended after USER_CFLAGS, so -Ustrrchr correctly overrides the
earlier -Dstrrchr=kernel_strrchr.

Standalone reproducer (fails on glibc >= 2.43, succeeds on older):

  printf '#include <string.h>\nvoid f(void) { char *p = strrchr("foo", 47); }\n' \
    | gcc -c -Dstrrchr=kernel_strrchr -x c - -o /dev/null

Tested on:
  - Host: Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
  - Kernel: v7.0.0-rc6 (3aae9383f42f)
  - Build: ARCH=um defconfig + CONFIG_BLK_DEV_UBD=y, clean compile
  - Boot: UML boots to Debian bookworm multi-user target
  - COW: UML boots with COW overlay (ubd0=cow,backing), exercising
    the absolutize() -> strrchr() path in cow_user.c

AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
assisted with debugging, test design, and drafting; the author
manually reviewed every line and executed every build and boot test
on the host.  Full disclosure in the cover letter.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 arch/um/drivers/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 36dc57840..e387ae33f 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -49,6 +49,9 @@ obj-$(CONFIG_UML_PCI_OVER_VFIO) += vfio_uml.o
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o vector_user.o
 CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
+# cow_user.o is a host-side helper that uses libc strrchr(); undo the global
+# UML remap to kernel_strrchr for this translation unit.
+CFLAGS_cow_user.o += -Ustrrchr

 CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'

--
2.49.0


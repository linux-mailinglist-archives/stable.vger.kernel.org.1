Return-Path: <stable+bounces-253854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA4hDKfIEGpIdgYAu9opvQ
	(envelope-from <stable+bounces-253854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:20:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C890A5BA4F8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74343301378A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303837104D;
	Fri, 22 May 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZh3k1Nl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BF30E821
	for <stable@vger.kernel.org>; Fri, 22 May 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484827; cv=none; b=jCcCwBOESyKv8kcMzZAHvkI+U5VjIf5KqWFouEr0D3oldQxuYugUj9wbT+z8KuAzM//0omaAx9D8xIX9vXpTiOfGCRPlkJfDmVLHYtjjuOmCqrC+4kehBwH/3reuK228ql11ojzf9NOXhLk4e5RUuMBdGt3jCLwn/UpRuOwgeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484827; c=relaxed/simple;
	bh=6m0tc5fHYugKfPyBGcdXVLCuE6V4b93aMPEqhi6SvCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BF0xo45T9MWPms8r3DaTlO78Gkjrm7nkTcCEhgYFR2SeffeHWQVWjHAIFrpisAaH0lQmv7y6izBclb9Mn2SY7oCcswBgzUyI2xwev3AJ4aF0Pta2lXej7Krn1U1BHiNb89fnvOUke8Z3O4p8s75/WqZrfvdcCYUirYxN7CSsaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZh3k1Nl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fde648a71so53438345e9.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484824; x=1780089624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccGcySGRmGIWQ9ev4EV8cr3WtrVC/pwB6DgMMTm/7tI=;
        b=oZh3k1NlSyiUI9/lOnuggasuwCBycwiiRC8HQeNlk6qFtGG3m00dJ4k46hewyRUatY
         NzCyWgJ0dMCrJ9nKLhNNf8AfS1/2+BfvRLE2knXx01ShUv6y75AS9Grq8LA/4qp6i0r9
         ySt+CBEZ69dscb8VYvwvPSYwHJC6vRfpD/Y99F06A8rWWXFsFW2yBnyJpp1QYmPz3nt0
         DWbdMJbzHuceWLaNbDZXAEVdtTrXOsyoS7fyMVvI9XlefbN/rUbegSBxNGuhanXU2JKp
         PIOO3RVsCaaOZGkciG+kgsy+nDlEbthIeI3TYZ3uHK5UgL/inIy1G1+IkQmFkIGTW/QO
         xdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484824; x=1780089624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccGcySGRmGIWQ9ev4EV8cr3WtrVC/pwB6DgMMTm/7tI=;
        b=E1DAYuiS+tlE3XAKxzfkO3cUmNy+ZWdpEQ+1R65hoWRP2VCOvvXb7FTx6aJXIHnEJg
         oS80q8V6Te6xB100hLmz061fjj4pc3UNKkXUcjU6/qqe0UmCFNDJTLZvdGbwJsDX6VKd
         Dsk4XmjiJJpJkNQ94e2chMkgg5bt5jEPdVW0mTVTR/vz7ilIROl9z1ivKLoFJOTc4SLW
         8/kGw/LWDCOkswDgIrgw1HfQkU22PE8Fo36jiGCGlFLFw/KypwzmK4LRRqYv2u/2m6jz
         JWY+ByNd/O3wM9tR1UoBOVuKio1YPDdHwcv9R33OYuk7EwzCkV94NMdHaNKFvXt9+TUG
         +OFw==
X-Forwarded-Encrypted: i=1; AFNElJ+1yZ/fcB/KZlmj+29E9F+1WuCOYisjwDIsILJYddtt4AfNLYKN94TxkYSa0RyxNrS2pRPk0LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8q4GnN9fHgJiFtnHvZWzrR1JC5A/0JnpxQ9N/RGdl1YNCfUh
	ucFwTOEwvZ6PjOSHO/+9wwOWSEP6rZmZ4YqlojFEzeEO+/vuAQt+9fMV
X-Gm-Gg: Acq92OGF3TJmk5nQAugJU/I3JLLcAjFZu/GRZ4XpW/m+0o7OjKrKfqp/6+1OjrOlHTn
	NF+5D13HGO2J3yFccBwQqZ2X+/KrM1HbvKx5C5Gc6exBKfQSPneLNMpCRCSN3uFq+D2uiWDNdav
	UPspR8wAOa6T9Zu3Y+saX/XgYmTLYjAQMbeknaU/lUvqBB2DdpDdx1Obb18xsKHeTXSN1JJCI+D
	epizQxQ7MeTa/BWYfwiuggZ6iEhagtN06OrcdgbP7wmjR35q0SO6K/ooAYEdClt+RG5W6Gbt/n+
	xQh/NL3HpN/oiXST/prhWDpBT/6IDCOWswKFS5DKNcyvLMwZDXmO0iDEF25vAivPbaii87l3OQz
	Z9OF0vo3EaUpoXiVvbY5A3wgmKg3/HmcbOF//9cwalZ6usDlGUlcNa8VVFjUn+/JI0KqCiG9VNA
	P910KSAOgDB3KxAQdsT0vwabVrdC8c9hNLwJaMgef+GSz19n5jpMJS72T5lkMV1PQg4sDsGggZD
	1wHG3qE++lKRNJDL4YTLR5V2ajczEiM6yuNLWqdO+8AxplWqUcJyz6P/LLZyPrmCt1TnD4rh3Mk
	BQ==
X-Received: by 2002:a05:600c:3e12:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-49042481066mr65671825e9.9.1779484823765;
        Fri, 22 May 2026 14:20:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-002-222-217.77.2.pool.telefonica.de. [77.2.222.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm110773475e9.1.2026.05.22.14.20.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 14:20:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Abbott Liu <liuwenliang@huawei.com>,
	Linus Walleij <linusw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] ARM: io: avoid KASAN instrumentation of raw halfword I/O
Date: Fri, 22 May 2026 23:20:18 +0200
Message-Id: <20260522212018.25295-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253854-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmehltretter@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C890A5BA4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 421015713b30 ("ARM: 9017/2: Enable KASan for ARM") made KASAN
instrument ARM C memory accesses. For CPUs before ARMv6, __raw_readw()
and __raw_writew() are C volatile halfword accesses, so KASAN instruments
them as normal memory accesses.

That is not valid for MMIO. On the QEMU versatilepb machine with an
ARM926EJ-S CPU and CONFIG_KASAN=y, PL011 probing traps while registering
the UART:

  Unable to handle kernel paging request at virtual address bd23e207
  PC is at __asan_store2+0x2c/0x9c
  LR is at pl011_register_port+0x4c/0x19c

Keep the existing volatile halfword access, but move the pre-ARMv6
definitions into __no_kasan_or_inline functions so raw MMIO halfword
accesses are not instrumented by KASAN. The ARMv6-and-newer inline
assembly path is unchanged.

Fixes: 421015713b30 ("ARM: 9017/2: Enable KASan for ARM")
Cc: stable@vger.kernel.org # v5.11+
Assisted-by: Codex:gpt-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm/include/asm/io.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index bae5edf348ef..e6bd9e79737c 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -56,8 +56,19 @@ void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
  * the bus. Rather than special-case the machine, just let the compiler
  * generate the access for CPUs prior to ARMv6.
  */
-#define __raw_readw(a)         (__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
-#define __raw_writew(v,a)      ((void)(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v)))
+#define __raw_writew __raw_writew
+static __no_kasan_or_inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	__chk_io_ptr(addr);
+	*(volatile unsigned short __force *)addr = val;
+}
+
+#define __raw_readw __raw_readw
+static __no_kasan_or_inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	__chk_io_ptr(addr);
+	return *(const volatile unsigned short __force *)addr;
+}
 #else
 /*
  * When running under a hypervisor, we want to avoid I/O accesses with
-- 
2.39.5 (Apple Git-154)


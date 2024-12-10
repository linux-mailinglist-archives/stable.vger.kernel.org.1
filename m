Return-Path: <stable+bounces-100408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F39EAF99
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AF328E300
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB922FDE7;
	Tue, 10 Dec 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUQW8Zz3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299C22333D
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829206; cv=none; b=O2QhUZOSeAgFmTVGnFRfwdljy1M4S5AxFbTRyURSgY7hxwh+h9IVNjwEBwWXyKGOPliIBiUcnBA7ymeOxwBtvtTFMDCTlnIBlE0txGDuckNWc6VRoh7YXpDu62s+2KCv3MSvQARS4lpuN9fW2cfx2yk3YlYM7VzfTTf8BQBQ5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829206; c=relaxed/simple;
	bh=Gkzwo2fn2GxN83SfGI68E17ycYpAXWauu/+OgIOK90c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRpPb1qXdsRx2q8s2uujFQrusSs95ADZc+i4GlWIj1e+i8Kv85NFX7iGyI9WadYTduM0iJDGUfYC/3l7EtHvMBM0xz8DYP58lzLbIItaZ2v67h9trjpji5Ok4b947YEItsHI5VbBSFzWEGrQLfrKgi6Hd6+rS6828FTFr6CC29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AUQW8Zz3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so3548561a12.1
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733829204; x=1734434004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI/evN3cDx82/aW/tSgdtKG8Stp53t4+aRLNXIjsXpc=;
        b=AUQW8Zz3MU8k7v8kI82X88zTKzoIBL2nfL9N84wpQpIW/S4naYwBtwu6QvhVhe5Og2
         BDpf5jayBxoUY8DCBFp2ro8kvCaB9tTt3o6n0ZFhFA+ebCQHTcZrsQZtuCqFCak/201o
         DQpO3UlkPEeLVmfzdMZhwDBnQcT/UHMbAUdHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829204; x=1734434004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI/evN3cDx82/aW/tSgdtKG8Stp53t4+aRLNXIjsXpc=;
        b=j4qF+OelJn0p1HkQlvDi07vfHOyB3btyjob9nqKnRVKZZaF4JWBnxbsO0Gn/5wRpdr
         9AsPFDYw9lg6ZZU1j05OgstDWpu0rjlm+l6+SocoTguBP03xqsubRjvX1im+WYXFZ+UR
         3AXM0nVJFWJ+UBIXM82JK0gLpZH0ZyNDCnmSokeBiHs6LPBxjQ4wDbzY8U+9jSQ6OH5o
         Gdoh0081s5f0cwcToucsOjoqnNaJd1JmCX6Bi3sX/BKQpcpcsus9/9dUCrjdspjWW/y/
         3DbJ/c2ZpFWsVGdpNSkpdnqn+as6U95rhUQvcisLOLfTdydSZWY/L5Sgi9wZ8kxmkCjo
         pozw==
X-Gm-Message-State: AOJu0YxLVY7wZkZXtbisWr7QR1zYi37eryUly806blFj0SO3xGvvRJZD
	xoYHdqYZQe6r3unlFDmr5xFRjA9jDRzoIRXl5nBQ6mXuC3YNu6dLrjVu18+kDNFeaHEkQgS9hMA
	=
X-Gm-Gg: ASbGncsid3+ZLtjG5pfYk9OHTRgVfaTnL+b5hbYo0OcFGaYweRAw3zcaoVO+TZf0+Ml
	JQKAWq+0EPPIeadmoa6TDEXniufE2U9HFCgtdkYp6H0MfvknhAE2rk+x36iBBvO+G4C25MLPq1s
	rFTN79ymaimD3SWC2iKoXkR+XT5+yxe1mMqLnVXLbDor3CsqSyGErc8QQVpbep64Y5w41HMepqq
	gEiaw3YwnfE+XkdLnRzDczt8q82b/J4htneMbhW+ydbk4gjAg2Ef2X4
X-Google-Smtp-Source: AGHT+IElVLpKUE8yIIDhm+MCSNSp0goTJqLlVbL10+m7WeGHQhL5PTKYMW3VNLiAkf50QZumCb/Nsg==
X-Received: by 2002:a17:90b:4c07:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2efcf26daddmr5122645a91.31.1733829204234;
        Tue, 10 Dec 2024 03:13:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef4600d2b9sm10448763a91.46.2024.12.10.03.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:13:23 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.4.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 20:13:20 +0900
Message-ID: <20241210111320.1896474-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <2024121044-elbow-varmint-5f14@gregkh>
References: <2024121044-elbow-varmint-5f14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The compiler can fully inline the actual handler function of an interrupt
entry into the .irqentry.text entry point. If such a function contains an
access which has an exception table entry, modpost complains about a
section mismatch:

  WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...

  The relocation at __ex_table+0x447c references section ".irqentry.text"
  which is not in the list of authorized sections.

Add .irqentry.text to OTHER_SECTIONS to cure the issue.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # needed for linux-5.4-y
Link: https://lore.kernel.org/all/20241128111844.GE10431@google.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
(cherry picked from commit 7912405643a14b527cd4a4f33c1d4392da900888)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 53e276bb24ac..cb8858388a22 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -963,7 +963,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
-		".coldtext"
+		".coldtext", ".irqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
 #define MEM_INIT_SECTIONS  ".meminit.*"
-- 
2.47.1.613.gc27f4b7a9f-goog



Return-Path: <stable+bounces-177661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF8BB42A54
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8645829E8
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6D36998F;
	Wed,  3 Sep 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BFDPE4K8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBD29D0E
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929302; cv=none; b=bylDp/tVbvjBGJU3iAf46Y1wC0XYoIUbtuRwf5THpJkTxPRC08ye8ynv92q5pbVjkObNsNoFoPPM7+GMzVQcQQkZ4TmQMwbHTUZo9d5iUc8OeuImEFcyTmE0E/7XeaL6BSCOP80+dIGedP4YyLvl+rxyTUw7aCfOPT38ce101Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929302; c=relaxed/simple;
	bh=ep2ByU6Sp3PUGleU/SkPJKB1vnJZEKwUxxPzvfc2zHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z4sYUBKsDnl0WiEZYjuDuzYpI9W3kg2Menk6K8oQn+CVIk+qc3L4VkloAWF3xxc3PhP0sQparPMsGVrYOkakUegzYu/5xCDqtZU3gPzkqR4IKee8ogLfIsMmPweiGTNspowAc0yWSlcYXwx4MID/ApmLHGLzj5bd33ikR5ySqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BFDPE4K8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so719235e9.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756929298; x=1757534098; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WemNBSJgvSeExxk4SwgXWO6xPmX/LP/uVncZJ5kxq9E=;
        b=BFDPE4K8xVUXXC8Gx2hbOM8zU5TTPFUdWYAptHTWz8Yvrch7OX2kghUo/PgBAuvG2q
         8SAAXklVb3rFhxrdsTlbuNoJVVfsIiho5owfVQCvBtbcJtvO/3357YX3rMv5DvHPaIKk
         foVdKDLhYlhggvLi3pn9mn4b+aE6ZwZwpL8AX6PByewzQRyCiO7IirTDm8ZieRYirgR7
         muQ4iK/baLbsZyt9PVSr9fGneYgIzMddMrAggJ8uihi6PhmqNxJOIU1gXu9ZTVbNXS6U
         X+yCWVD0QNDeNcSAJajza0MFfJqaNfz1HANKipCzKP5PjgZog7l4P2zK5+GwyktMARuk
         jaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929298; x=1757534098;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WemNBSJgvSeExxk4SwgXWO6xPmX/LP/uVncZJ5kxq9E=;
        b=Ep/nBTSI+QukNh8gZMMZVJdPLqS9mGe5NeflvXRPR73RwoUwXrUUGKVXlkyEkhwI2x
         6eTyeXRZbW7RMNWsQxIRZn00bzrg/kBrI+Q8FYNwG6KcjtDBijPDSem3YhfU03PL9wrd
         PB3OHmMaQ1tewwNKkS4htVk/Op3Pj1+cp7K/QDtzVeytCowRKcIXJVlmgD4aSofdRbpz
         cvgT593pChKKMMg/vryvgwJZs3Pe/nheWhFvIKjmuhZLq7DlZLJ3qRGLjRmv8OQxwiK0
         oOYICW8lJZvGKvh2L7D02bPNrvjUeB65EGPL1rOAxbkT6On9hDS/mjMSXWRhDroAN2Gi
         RfBg==
X-Forwarded-Encrypted: i=1; AJvYcCX1DDpwC163QB5sgiEL4gH4S/6HQRqmLZV5voS1dbdv9MKULwTRb7Rb636JvkKweAtCnScR6iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+jxn6hQD9AmqK9T8hfEf4mtPTCtoRS4zEP65qXsBRcyCvQCf
	76F83knTG/2CuiOKZcmPr2QEr/URR8qiSJcEKfMqzdoY0TrmpLSfeRgVD7L1lbapRbw=
X-Gm-Gg: ASbGncufCvIgMITc9+ahBdXpHWCVnkoG6HsrV5nYiJ2sUimwtezlkHT13XrqEnacp/Q
	L/PZ1wfdNvStVTXwSsGravUwF0KIheFYsjYDf6qi6f7ZsXB2j4Tsa7M9sbRwCDo1knsk3N8DaXq
	EBbzv5/n6GwFvcMBlUTrhsWYi6y8XyPGrLvhr3S34F4LMFDKDuNZIY6srFtFAyUk7nMjjoWXkeN
	XcV6+e2MwIsFHVqtyN99ZJlXVlE0pLuvOQYBJK+rpvgH8mW7XC9LZMurSVnclX12G70SW4s0fU8
	o/o7Mqk35WIsEcpaMJbFFbtKPxFhOVeKuBFE3ALMtXfBGosMMYK6CJHoLKYWwvW8LqgIK0E8UoB
	z5YpAO7DYj0/s/gAybeHtvNKdepUq+ztyYedX5M6/MYW077OXDDy3nyZ5PIvcdwU4QqlPR9YfFH
	6dqh6e
X-Google-Smtp-Source: AGHT+IFJLqX9lWt48uvYEkJALLRR5ugjPDz4Bm8zdqTvK5mO3zXyFw6a/hUpgKW7TWri5+ZASWKjNQ==
X-Received: by 2002:a05:600c:3153:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b85570996mr172993485e9.17.1756929298246;
        Wed, 03 Sep 2025 12:54:58 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm9504812f8f.23.2025.09.03.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:54:57 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 03 Sep 2025 19:54:29 +0000
Subject: [PATCH RFC] riscv: Do not handle break traps from kernel as nmi
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dev-alex-break_nmi_v1-v1-1-4a3d81c29598@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAPScuGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNj3ZTUMt3EnNQK3aSi1MTs+LzczPgyQ11T82RTYyPDNONUCwMloN6
 CotS0zAqwudFKQW7OSrG1tQDR4C8EbAAAAA==
X-Change-ID: 20250903-dev-alex-break_nmi_v1-57c5321f3e80
To: Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=ep2ByU6Sp3PUGleU/SkPJKB1vnJZEKwUxxPzvfc2zHY=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ2zOUQju2NeZLt/efBtlSDKNmvc3VLoqScb2v/XMt29
 an+IY39HaUsDGIcDLJiiiwK5gldLfZn62f/ufQeZg4rE8gQBi5OAZhItxPD/zq+v5/fzr6bXrSu
 ZMPx6vftCVu/bNnvsdBf8ceyozc26KUx/M99/HGOKsOcDa2nZq0prmblyUi9l8nxo1j6aJNWYvK
 bZi4A
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

kprobe has been broken on riscv for quite some time. There is an attempt
[1] to fix that which actually works. This patch works because it enables
ARCH_HAVE_NMI_SAFE_CMPXCHG and that makes the ring buffer allocation
succeed when handling a kprobe because we handle *all* kprobes in nmi
context. We do so because Peter advised us to treat all kernel traps as
nmi [2].

But that does not seem right for kprobe handling, so instead, treat
break traps from kernel as non-nmi.

Link: https://lore.kernel.org/linux-riscv/20250711090443.1688404-1-pulehui@huaweicloud.com/ [1]
Link: https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/ [2]
Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
This is clearly an RFC and this is likely not the right way to go, it is
just a way to trigger a discussion about if handling kprobes in an nmi 
context is the right way or not.
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 80230de167def3c33db5bc190347ec5f87dbb6e3..90f36bb9b12d4ba0db0f084f87899156e3c7dc6f 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -315,11 +315,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
+		irqentry_state_t state = irqentry_enter(regs);
 
 		handle_break(regs);
 
-		irqentry_nmi_exit(regs, state);
+		irqentry_exit(regs, state);
 	}
 }
 

---
base-commit: ae9a687664d965b13eeab276111b2f97dd02e090
change-id: 20250903-dev-alex-break_nmi_v1-57c5321f3e80

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>



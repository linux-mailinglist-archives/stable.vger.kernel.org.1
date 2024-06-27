Return-Path: <stable+bounces-55939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4AE91A3D4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996721F233DA
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23913D8B6;
	Thu, 27 Jun 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/tk0kYx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777F79F0;
	Thu, 27 Jun 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484347; cv=none; b=Rk6S0Q4Uee7NyxSjqOLnevX73FzZLkiTz+QnS6eCfEfwgjWrZ11hL2JOTFWajcfqEpKXJyqeAJXpwXCoeAZNi1RLR/qzkPns5qr5crSAIOLbRNS3mBuvlqKtIQZukgj/HsY6MBdnWkE1UQgXfHaKgDYBC+skTFnGa5/jibMBJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484347; c=relaxed/simple;
	bh=uImnSU73FfppRnJFjnbhQ8DpGMuTK/5eh1Eqwdt64C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MB9enKI4UpC4rTdtJ7/tKPEbDiIq8rwk9PIs6uOMKbZcjfb1r7rXeqRJRnWYm2/H3PYsLqxEJoYfpTuT72WvaLXuPJSb7s8v5pQAYjqduqLO1JP6CNJji9NZPSDQ1JGxyG8F8kwVD+xnf3SsN+1QajMkR3lZZ05KvQUKngsx7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/tk0kYx; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7065a2f4573so4577727b3a.2;
        Thu, 27 Jun 2024 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484345; x=1720089145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmh+rI19FYvTX4VBo9RoQQF+CFlwjca98r/WMaZ3AgI=;
        b=B/tk0kYxOziKK+AE66R5tGDFi4UAhBJSgNCiL0WUMnTqSPgOXC+ayuOzGJ8M7px0Ld
         xOM6F8mgxNCXATvkXALYV9diUCES5+qCh3pmrV+tLtZqetw9ROeZYyA0NhCnvO7aExwe
         7k6WrXDwBi72Go7tdEs88rhznCN9aj2zwONiub4bxwztW8/SRdDoIylF5+8DcXEgFaBo
         L4uJ2w1zSwCLMe8bIuIW5/cu9YRf8lbLmGMOwRHRBZjdHPBGCeagFPIFLDdPZpAaCTpi
         dMmkkk+hlSDrpoTtGwhsSGZu5ByTQ8DVMRDcmmfrI6JMCa09uCSsBNa21meo3oijYJQQ
         /n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484345; x=1720089145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mmh+rI19FYvTX4VBo9RoQQF+CFlwjca98r/WMaZ3AgI=;
        b=ZHF+pqZbfRUXexUqwQQrWw6zrKkgUMVstqEiOmDjn81jexm2UunetJ9pdJsef9rP0E
         ntR1bYkbd52zKjINUTF9XCsNvMJhgm2j+NVwSPNJLxoXyB5LqLfpenBSfLEDQg/B5vj7
         /dR0eu9x6snCHLDT9TqQ3QTjm7x3PW0RMzUw176ha0PBwrGqQ3o74VYybKrqNzbC03ce
         UQ2G4Vg0DAfWHVLxcF98iFLLRJEGDG/GcQRQ5q/2PePKEJsRrftZj8agW0AIx4oJWUA1
         YDevXvZYha68mOpLSQRAl0LoxzTQVD7FNgO64J36dURsJ69DmJfjERJJBk5Z1X6Sdyrs
         MjUA==
X-Forwarded-Encrypted: i=1; AJvYcCViHyFQ1nbcwVHbNagQGILyvzsrsFgspALDXPVaBqWYM5LcYjl2c8zMTQ2JI4RVu+2rlbJuMELafjy1aDxYlg7WhBqN2d6j
X-Gm-Message-State: AOJu0YyejJ+PN9MwTJALDtWMcHssLeMtYqMAWok3l5QQcucWkkioOzpq
	8NfhB1M6CoZB1s55tiBXhFkBKmnK+pMGwLfikQP03xeUaHaickLh
X-Google-Smtp-Source: AGHT+IGH+QXTM5gHaVLPozuwgd8Aeizdbfooakik7KO6v8i735gwbRYhOSu54WAqSoHe6GUlXk+bnA==
X-Received: by 2002:a05:6a00:2d93:b0:706:8066:5cd6 with SMTP id d2e1a72fcca58-70680665df3mr13651186b3a.32.1719484344818;
        Thu, 27 Jun 2024 03:32:24 -0700 (PDT)
Received: from localhost ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a08169sm994352b3a.108.2024.06.27.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:24 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To: linux-riscv@lists.infradead.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: linux-kernel@vger.kernel.org,
	"Dmitry V . Levin" <ldv@strace.io>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS
Date: Thu, 27 Jun 2024 18:32:06 +0800
Message-ID: <20240627103205.27914-2-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=CoelacanthusHex@gmail.com; h=from:subject; bh=uImnSU73FfppRnJFjnbhQ8DpGMuTK/5eh1Eqwdt64C0=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMabX2S2McK1/saakP2s0R0KXLcMA0af+nj7u0UhOjr c3nfI8T0esoZWEQ42KQFVNkEdv59PWy0kcflvGazICZw8oEMoSBi1MAJvJLn+F/FM/dIrs57xuX vOp8wT5NySJji5qvn+/SDz6ODkfZE/9pMPwvnf8q5NEJU36D1tPSzl2l5R9Wv5DXfpVgUXWx8LT Z9b0cAI4SS+4=
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

Otherwise when the tracer changes syscall number to -1, the kernel fails
to initialize a0 with -ENOSYS and subsequently fails to return the error
code of the failed syscall to userspace. For example, it will break
strace syscall tampering.

Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..51ebfd23e007 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
+		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
@@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else if (syscall != -1)
-			regs->a0 = -ENOSYS;
+
 		/*
 		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
 		 * so the maximum stack offset is 1k bytes (10 bits).
-- 
2.45.2



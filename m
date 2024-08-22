Return-Path: <stable+bounces-69902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3095BC09
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F41C22C06
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA51CCEFF;
	Thu, 22 Aug 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSSLeKp1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43A1CDA0F
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344498; cv=none; b=DHNLdOoIUvsgYiRZ65DBCtXiSeqq1XZZo0SRqmgUBuIwZTWcofG9eAutyiObBwD8OlWPGZTYzuyQKnMt4yFx1S8qFqghlRDLqhYyifRRdplRMHsY1LGqXoUXHMT+TShJbvDXUvcKlUJNKZVqg5wOBpRZbc+TLyCIUEmGTRdvMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344498; c=relaxed/simple;
	bh=xzPorhtiqWe/45TTNSOdT6KdUj9DKOIFxe2UI3vriGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hirEFtrgPVjFBhY6RP2tQ54wBlbYI325Krv/Hjk9qcuQ8fb8499mS2Cmh1oB0vl/gfRXHs2QmIzBRo8hsmGcFKsEmXydCTM/1JI8IVNMggYBDN3No4Fd0o/yV+rSeUZb5tasxEVa3SrfgBMBEK4cf33jQYleXpdup7uhQ3sTPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSSLeKp1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-202146e93f6so10280885ad.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724344496; x=1724949296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0982JcjmJPiEefz1duiu8NPYbp/vk0YS61cHSWHx6+E=;
        b=YSSLeKp1sLt5d9KXnucmFiN6lA3/L7tiTr0klzxVgX8N4cxhqXWG+Ba9QNAUIgN6Jj
         sPs1h+musda06oJ9YqRo1+fcalqlYM6GOjQBVl7eaV3tmG3OLnXJ3OKeQ3HSQHl0xrDp
         xE6agEI/AGWTb/qcXk8/mLP2lFYb30CcozsYWhmrZi9pW7U6dn9bTF2Uxs9wALImOT15
         CE7NM0FaOSmGKK9BDHo41D2T59l53SWCkN+HNv1UXz/VkycG8d3F2HSoyb2eUQCJQikY
         y7xmTHyy7V/eLvYyjpQIOEVmolu02GkcwgQNlAQW1qZZ2UXyINBMyCfoRQ15SHmYcI6D
         BDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344496; x=1724949296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0982JcjmJPiEefz1duiu8NPYbp/vk0YS61cHSWHx6+E=;
        b=U7llDhFGTwUhOviRIaNS9pN/EQ5WicUtLOVKTW703vEevMTqHDu2m3H4n2rOWCM02p
         cAIcGZwibXm76YAO97tIgtxJj/UuIN63spjIHuImor6XFMmB9QFWMgZw2ZrMnkyeX5Ju
         wJq00dp8KhngMR4vC9A/wioms9rxhU3oOJ3wxq3fF+w+g4NJy8231miBFHgqk4at2l2T
         EUyRHQGR8mZCCy1yEqZIYSkPL9hj5OOaVRqXjwrxXqH5j4ra11z6ViVSCLmIkjSbWdwd
         jWnW9fSsz0NWXn0mQjY29qU9y3fyOXdcXQSzN2aEe/atEIgelD3EllGYM+0NjF10qz4L
         4Kkw==
X-Gm-Message-State: AOJu0YwqACPXRLoUYGWgs3voR14qWvJqYqSivsWIyOMQfWKSOHLgktFF
	dbGRtWHSndBnT2J1Yp0i46VNnumwwrbV7nsJ1FQT3mL4shqWGzamxfC1pO2+0DU=
X-Google-Smtp-Source: AGHT+IEM/f7cTXjwRmt5Lg/EDdNEehxWNAPAifJGjTxU2rdrFtMVYmngoz3fWF4r3x6yQhomdjptQA==
X-Received: by 2002:a17:902:e846:b0:1fb:415d:81ab with SMTP id d9443c01a7336-20367e64085mr67124325ad.20.1724344495705;
        Thu, 22 Aug 2024 09:34:55 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm14611115ad.65.2024.08.22.09.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:34:55 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To: stable@vger.kernel.org
Cc: Celeste Liu <coelacanthushex@gmail.com>,
	"Dmitry V. Levin" <ldv@strace.io>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.6.y] riscv: entry: always initialize regs->a0 to -ENOSYS
Date: Fri, 23 Aug 2024 00:34:02 +0800
Message-ID: <20240822163401.38104-2-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081917-flanked-clear-e564@gregkh>
References: <2024081917-flanked-clear-e564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=CoelacanthusHex@gmail.com; h=from:subject; bh=g6MM5CHnaDgLwgFDg8hcNtYK8x5sThfoP5dpD1Autmc=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMacczKrmPdj67568+KeUgj8z+dY2rbBMm7y3j1GS2n MrXn87hH9RRysIgxsUgK6bIIrbz6etlpY8+LOM1mQEzh5UJZAgDF6cATGSyKiPDvRbe6kSPO8zG n/fYW0ffuBivLscS/kV6p8q5/uNMy0t+MDLs37Yx8W7yQkd+x7z3E/ZVzJ+xRP7jy3de1q+OPfn g/0yBBQC8OUrW
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

From: Celeste Liu <coelacanthushex@gmail.com>

Otherwise when the tracer changes syscall number to -1, the kernel fails
to initialize a0 with -ENOSYS and subsequently fails to return the error
code of the failed syscall to userspace. For example, it will break
strace syscall tampering.

Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Link: https://lore.kernel.org/r/20240627142338.5114-2-CoelacanthusHex@gmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
(cherry picked from commit 61119394631f219e23ce98bcc3eb993a64a8ea64)
---
 arch/riscv/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 67d0073fb624..2158b7a65d74 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -311,6 +311,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
+		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
@@ -318,8 +319,6 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else if (syscall != -1)
-			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.46.0



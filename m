Return-Path: <stable+bounces-55968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E60C91A926
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB23C1F283CB
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA80195FC2;
	Thu, 27 Jun 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNxV92eZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48599195F22;
	Thu, 27 Jun 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498264; cv=none; b=aACOKAfBlFHMaQCVEyVgy0paAX9XlroOAV0cBXjM6QhBFKJ5oSQnotKj3WP1h1Bj91+VgYHgwkhCJlNYdfnJDyREzWE7WWSHqjUUjxbMxIQYO51XjTm556a50Xi7Sc9DTxU0kkmHn2WkbCbIuCx/Cw5q9G+U5uSlSEZ2n/mScXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498264; c=relaxed/simple;
	bh=Q2jff5QT5dahZ0NplzuKdapGzNO6RH+dDW7S1GCf5v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KJtxu4C/6721T3B5L33/qiuzaMoxSTsqdrrylFWNiOCNx9Mih9aC2fLgKeukM2yNPUXZksHWuFS9FQ5zQWH02rAdsGfYjqPX6ZR1wCnrqfbLvUSJunEe87KigMg4Fh2FjJLO2XiHjbTs7xH2fh3d9pbe//iUpIyWkZpZiVh6WN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNxV92eZ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70671ecd334so4096063b3a.0;
        Thu, 27 Jun 2024 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719498262; x=1720103062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/eLI45W/ooqVC/MA9zQHUWk1MIJ0qMRX6RqXTFEWV8=;
        b=kNxV92eZzHtv8FnLNVXDxkpXstN1yuHC5iRPqRxvzkvHRWN2wW6uCUBhIjXtlevCoc
         +cunYdZVanA2dy4OK5apl5iP0ONnqRXa8bqPFz8G9EmRuNI73UgFg6oS3pz1he6WyYVx
         78bZBFzZW4EzvrkAnLhP+0vEgrqWSY6C8oQVpj7iUhdty/etdmlQxp2eqcT3WWs1LxIL
         95bc1+VzGbMf73nUc0/6kLyqi22Qn2hZ3GWSD3cHCPdUjUPjHXJDdu9NuSlQsGWfB/hu
         wjAk7jBwzKemibsoW5I9bKGjzeYOEnGv1J0FFPWRXzbxeSAj5b/0+1KSxwDqCQQey73Y
         b8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719498262; x=1720103062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/eLI45W/ooqVC/MA9zQHUWk1MIJ0qMRX6RqXTFEWV8=;
        b=LgeBeSUDmcvC7EI47txRoj/lnMrh59N8e1lAdQcFQqeb5FojoeRA4/Hz5TtxpNBrpE
         nkiDsZ0BMTatVZKjBPYkSmpPStlC0bS6TbZTy38cuWRQetICJhv31Qk25IPSPt5ReB2+
         jsTT0D2EBiv3TcDjI9Dohp0iVzVvAVIoGMspEdmNQMItviMk+IdTijb4AcB+cn34IfzZ
         9zrwC0df482oJqkP1dxFx5VeJVo7rWFJgr7oSI/tK+4oL2cYs8dtV+gP9+b7Y5HD/AKh
         QmirmxSD3FqwpTQC9RWYAohF1L2ZLyUa4fnLAwrFjSbj2yrQ/Cjy8RafC883iA7rvNnO
         NB3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+CIFUZGyGniMunruQCllFVlZonz6Hgzyya58zputAbz48inZ/GJ2udLVOGUYBX1HwhFPNO8TftPQ+5nXzFTr/ZcUdKPw6
X-Gm-Message-State: AOJu0YyiigaDret79M3yxzzkXy2rwrykYVMo0GQLQT3XhlICuMrNcpdr
	JaAAJgot2KIhT9p9oc9Cbrmm/n7QjAKBidKYrilwIy2/JuSp5cjC
X-Google-Smtp-Source: AGHT+IFaXa2jgWVK9qwyyMjsUe+VJC/FCmmJqXZaBPd98yzohBR8g9ipU8NKxlQpPhyhZJZYUcyh6Q==
X-Received: by 2002:a62:b609:0:b0:706:4889:960d with SMTP id d2e1a72fcca58-70670ee7812mr13853487b3a.16.1719498262365;
        Thu, 27 Jun 2024 07:24:22 -0700 (PDT)
Received: from localhost ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b48d0cc0sm1403803b3a.28.2024.06.27.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:24:21 -0700 (PDT)
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
Subject: [PATCH v2] riscv: entry: always initialize regs->a0 to -ENOSYS
Date: Thu, 27 Jun 2024 22:23:39 +0800
Message-ID: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=CoelacanthusHex@gmail.com; h=from:subject; bh=Q2jff5QT5dahZ0NplzuKdapGzNO6RH+dDW7S1GCf5v4=; b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMabWlrwIU5LWUEn9rPF/0ydqKUdQyc8m/pJOixUUZJ 13/7OoyCesoZWEQ42KQFVNkEdv59PWy0kcflvGazICZw8oEMoSBi1MAJlLxmeGvREWem4374e3C c6fzxbfX3P67q/yrnX/Nzpn1sZNtBZb0MvzhrGy8bzLFos5JPNT+mve8nBXcHib3J30+45vrduH V0jYeAI3ZS6k=
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

Otherwise when the tracer changes syscall number to -1, the kernel fails
to initialize a0 with -ENOSYS and subsequently fails to return the error
code of the failed syscall to userspace. For example, it will break
strace syscall tampering.

Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
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



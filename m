Return-Path: <stable+bounces-86443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682A9A046C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66A01F2621A
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7331FCC6C;
	Wed, 16 Oct 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d6V1vFxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D61F80D9
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067852; cv=none; b=rFaPUNbI3Mr9Rzn0og3J0jkSLIKfzNoKPpQzYkX9i+Loni6rs9zRtT6yZ/TLHK6DCUcHFwloD+SimH4dapVG5vgsEO66A6FDguwi1m+TP5fMDnH+k5Db41s5IJ71jG9GFM8F96qCe1dnqrxv4BCyF6TQmOrDoVvwXV+9ryQoZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067852; c=relaxed/simple;
	bh=ELkP+/LlvaLc+XLPJhx3hY+pNjpVHD4I9RrhF1TIZYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMI2gcw0XGQSC9Ylh0v7tTYwZiq/imABTFS8LbqrAiyq2wkWofTma3KLyscVE7F1WXiiZ9p/rQjUurEbN3rg00oOCrebP72Gi5BoH1OfrvUfEnc0tG06pkYE+0t3bK6XSiLhEYQzhjQFkvK8q+aNfGSXhP+jM6yZTX9JCn/zW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d6V1vFxc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so60717675e9.1
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729067849; x=1729672649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jJdJXmZIFUypkGDe9/4mfd3DKdJwjPw93ZM7h9RdKg=;
        b=d6V1vFxcP538ogDKAAHC4xvcXZRQXTQvBNCbXNBn/b4/fStwl6so3RghLXkRFjVvfi
         23QtqR5py/tqNhgvi44yU59YDUc8xTJOvtcilMKDEobJCHXbnvGzfMQQIuzytpwtjnpZ
         OKMtpHxFoJLAgLQ98kvcr/4fmo468qDj4YS9JPNXi9RxWzfKCtCxG07F80k+L59c++V5
         XYC68xCIXR00yE7NT/R49+PP23Y47n34avGf5wI7Xk6HqgFuJziKaDjia/+hPQHt56CB
         Zdqn80r+YSsPSQBmVy+O21XYxzzTZ+uvwwvXobH3dtxcSN+V3ds1A0DBeoFPmNp177Pe
         ZqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067849; x=1729672649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jJdJXmZIFUypkGDe9/4mfd3DKdJwjPw93ZM7h9RdKg=;
        b=JOLbVf5Mku3ZceTyW0O4aQwYYgXLEudhvevT9RRRdx1RdpJiZ2+prRqnmIxICbjyqC
         Fusk3zHR//UiftxXNBpyVf82gFeuqx4pxEU/GWinI1clgcldEkdqQethakZpA6rX3o2N
         dTzmLaJfH2alRrRvy1i5kr+IkCx20jqfi2302w0uKqlBU8nDnmr1bIhXwT7PjE5XCZgc
         P2aRwOvXzfJpqk9h8dNTprft+MxDGRz/VL+SsXdbAzjl9unN5OgaNN3xtlSE3J5RbelW
         cZOKSzxNTq0uTr0aZoEY9FDtEjTjL1ae71mTBJYcVfipyPan6HCf4/PzuglnQSwEmuQe
         O5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCfisqSRcF9/hONb7TOYLse7y6az6S2Etikk9mzQkaI//g8apeh6sRaP67SiD1U3Zp5BC1tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBqxpudxhb11hROHWNJ9Z2PSHKeq8DKRUHxGN9ILJndOZbxHh
	vWI8vUWPN3W9ijS0Nby7lfXi5H/3NaX7Mqjx2d000O/Ou3B/wvmLkbc7O/jfPoGbBxUpxfcoqrX
	H
X-Google-Smtp-Source: AGHT+IFp3TkzbiKrwAorGoZodCtXXr7F5FcNaRIdRFI7+3ysQVBFKjSKd4I+hM6P7+iGyX8KPTwG+g==
X-Received: by 2002:a05:600c:1c98:b0:431:150e:4e8d with SMTP id 5b1f17b1804b1-4314a31da99mr27011475e9.21.1729067848919;
        Wed, 16 Oct 2024 01:37:28 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e9esm42168205e9.37.2024.10.16.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:37:28 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: vdso: Prevent the compiler from inserting calls to memset()
Date: Wed, 16 Oct 2024 10:36:24 +0200
Message-Id: <20241016083625.136311-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016083625.136311-1-alexghiti@rivosinc.com>
References: <20241016083625.136311-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler is smart enough to insert a call to memset() in
riscv_vdso_get_cpus(), which generates a dynamic relocation.

So prevent this by using -fno-builtin option.

Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 960feb1526ca..3f1c4b2d0b06 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
-- 
2.39.2



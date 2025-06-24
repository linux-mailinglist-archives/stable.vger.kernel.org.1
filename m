Return-Path: <stable+bounces-158434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7463FAE6D24
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BF67A9384
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ECF2DAFA5;
	Tue, 24 Jun 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOaX//n+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37181DE3A8
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784361; cv=none; b=oFCcUFvJVSfa+z3+h+63Cm/0bmD4kgC+naYK9CW4xsXE5fBGvg9IqURUr9nBaDsulCdqDJXoszflh6WmJasPsabPDWnUubyezCvNfpGmVLskdMKWaJD6azFTK7VaROcYdjbaH69QjhE/FMZcJfoJOYtHBwyrDZg66zQaYjZTLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784361; c=relaxed/simple;
	bh=58kcgFOD1RHRrBQgHHL1uMvdKxJf0WroDEhGy+lfJFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh0PlJwk4TE4L9GpSa0ueFIKDUbHdvNfYk/cVNUSTmWzxF56g7JzCbNo3Y6lTuRKiO0rZTXRYLOKDnsQy/ZrJPsFcZdCWK7HKKpLWRW/zIBAwJvEgcZF/xX/S0xmga59TQk6aYPq+bM9hcrXo/s+Hk/c1bzNhOIy1eDJLNwCvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOaX//n+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4530921461aso6282145e9.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784358; x=1751389158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmK3Mm3VnYwR1mAYmNz88dJoBd6LZQY2x4R8sZw9hDg=;
        b=kOaX//n+iEo9wUqRKNUDuBfwWHamoEV4edfKsNwgxPdYjSRIMH9KLW+dno6SwdROgL
         t44X6XzanNAld0SOb+Rfctj0wUqJDF02jvkY3+iqzPOkB1oLLMm0CYocawOlN0jjdLVm
         XZM16rYEs52CHFnCqm4ugC6B/MVCzy/wEc3nJLhNyYqBg8BpMRYfjHLDacEzG6Fov6mR
         eqVZG/WTNTs0dw9udhtuGJR6E8q1tAhr7/NmsMAcL5dOsfoB2rjatNj9VAinIalCx2mg
         82MJP6t8Jyvz3apW8B9hgPQhrMn5uoO0/lCHVubN0149Ke4+9ivFkJXLq6FPpQoTeAFV
         n07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784358; x=1751389158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmK3Mm3VnYwR1mAYmNz88dJoBd6LZQY2x4R8sZw9hDg=;
        b=Au2hWFFe8nWyor1alGGEEN8ACybdZonx8Sx+0Jgjmt4BrD3NcvtnADBp06ZO++kKPs
         /oKHfveU8Vw8Pgs6jD9PdapBRhoxWvdg0u4Oem9X9D0B8CWhbMrULzMEZJNlibo85OpC
         t+xoQv5oAi3H0IWB6zhS8gnOtsDUxt2O2dUQ8/YSUUK8NBNjcTHCJoBIq9hF2jVUQSul
         PWIZdqWKPmgbKdb9DYGFiY2kjCdm9/M5zqRpd4sI4lwUZlOkGX1JWNo8sYK6jKCs7ihT
         0jhLZkw38Sv0oG3V21isN6ij9+raVWHk+TAb2aFW0l7iTaahdfZvTAzjbK6LRg7NIQQT
         3NhQ==
X-Gm-Message-State: AOJu0YyhYDRRr8nFGNRO/bTXytD8jwkcqfgN/b6Olp/vwpfnyeftHQp6
	K0jWO96qx9zaYYNFLpvjpi7lqdskqdUQYFX8j1eVGaA2+8SGmSBap/hpw7TNt0Qr
X-Gm-Gg: ASbGnctM5SuE5+P8oxjEJ0NafDzuhkujLLVv5mSRuX8lJXdR03GKpxVIYJ7Gy3uKRd5
	oVondWVwmIy+CbFuCsz7rsz8QfdvHP9cHhgdGvyATByyuHLqkUT/s9MYQvJ4oaQoOU5lEsFaSHM
	AcOzojx3WJfL81Jr7sU+u70UheMPPhX62bKcC0mOpXFjUQYGDaVBAKBOLUAzBRVL6TEbnmHRFGK
	rj+OsMBiTreiMFsB9Y3DDallJ+aLrknvCP/Q9lRkdTV6Bhj2f2yvHBfpuZnzsKeDVMhIU1TGcAA
	sz29eYUfqE6xCPajKU8xP4/BqKMJ+F+dOIwqcizlwTw64EwDOpFsCkAPZFg1W2SWO/46bEImM6D
	GUaQZDFAJRUwBIgbKRZfl/lUywA==
X-Google-Smtp-Source: AGHT+IGd0+j/67mrI7NZ9UWQrBl4Uwi31IggVOvaJFwx4yny2yrG+9u7i3pmz4dNcZz3LBpw+HGDTg==
X-Received: by 2002:a05:600c:3515:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-4538157d995mr2416615e9.23.1750784357660;
        Tue, 24 Jun 2025 09:59:17 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebd02basm179191265e9.39.2025.06.24.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:59:17 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v2 6.1.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Tue, 24 Jun 2025 18:58:52 +0200
Message-Id: <20250624165852.7689-3-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250624165852.7689-1-sergio.collado@gmail.com>
References: <20250624165852.7689-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.

After commit c104c16073b7 ("Kunit to check the longest symbol length"),
there is a warning when building with clang because there is now a
definition of unlikely from compiler.h in tools/include/linux, which
conflicts with the one in the instruction decoder selftest:

  arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]

Remove the second unlikely() definition, as it is no longer necessary,
clearing up the warning.

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
---
 arch/x86/tools/insn_decoder_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 6c2986d2ad11..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -12,8 +12,6 @@
 #include <stdarg.h>
 #include <linux/kallsyms.h>
 
-#define unlikely(cond) (cond)
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>
-- 
2.39.2



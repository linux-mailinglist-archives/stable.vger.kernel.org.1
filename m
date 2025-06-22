Return-Path: <stable+bounces-155256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458EAE30AD
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352DF16F630
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C173FB1B;
	Sun, 22 Jun 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc9j/+hm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF438F5B
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608053; cv=none; b=uHEp67G5G4GOW8UTtEPx5xiD7qr0DHnfOgVfpaC8+1l8sZFxj99GDdzti4J90mtcHdkpJdKQlly0eYTEwG0oI3qC23q7eijEquJ1VB7DcMFuYGlr+3BfoK0K27MYiekB/32grZnvbHX/80J3IS7l6UbFjdmipMY9aafSjAkSYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608053; c=relaxed/simple;
	bh=qDdx+48h9hTa2TN/qjEDtOCXk5jMhutrVElbm/aEyhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQnWwnewLKD3AkUgAtQh+9RTV/qpkvrvP2a1GXjHCoJY/8eXlUcd2t9tpCxZVJy4aVSXnMHgIRhyAccThX+22dLIMhi9+25guKzBfsNF/UjahdwAmVPR0Nv8bODRQRA1MFtFcYjogI1eQ1QNTa8wf7eyWujYNrq4OEbqaeQZqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc9j/+hm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1125399f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750608050; x=1751212850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNjO4sDMuK+T4J0VE/NK+gi/eJODe5eq63+5j/G9To8=;
        b=Lc9j/+hm0CLAQFzI+4joI9EQOcudkRqRBdMPZlPD3bC95PFA0bQTtjNUAZH163kWss
         ylfWdYpra/ctVz+Mh/7vRS3ReBr+YHl9m5gToGkGZI/6taj/C7ixFUU9EliTp5UdtABT
         B3pgm1Y9A7aFuRrCa62PjrWB4Zefw+XbRFiqpZKPeaxOJ5CA8KcGVcuurplQK1BpoU22
         qq1lLJUS8QgNqnif62uHJ0G0Kot0shN7bxSZY7b/79uld4nk4mdtsG5x27I1lAzIuAhA
         z0YNpXgEPU7Oi0gDGZqTFwgg0iPJlklvDkS7+u1729UPByY0IPa77PZauaj2e6kiV9at
         gmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608050; x=1751212850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNjO4sDMuK+T4J0VE/NK+gi/eJODe5eq63+5j/G9To8=;
        b=HAbuPJauIJFErHwjgbXMU+cMwtPdCcSZ7ePfF/+GL88Q0+4cmG+kVmuAteamoHcRmp
         k7iyeIhoU0YlrRAag/MckTqSM5IQwDFLAif4BUhse0oXY82zMWVYQN3SvQuf8XlesJsk
         disq+ZQHIA2qs7T3EUVPhpS9/wXtLJGkUB/hyw1Olj2lIXvwjyq1sCKJFr8EX5yoilbo
         2EKxNP4oZm7di1k9j3ACBKKMjImjx3tGXV2i6/Jo1AknJWTABU+GCjEkIe2RyvenE54L
         dvI7BzSgZp0WFzqGAgC3gL8T+pqc4CGZrPi2lzjLL9gWTZ7rf7ZMabR6M6thZggL7bCV
         8MqA==
X-Gm-Message-State: AOJu0YwxYZAzbGUN1BoYuhvXpUIo2iqxiuhRZqNSgiXeISGfGW+nyUqn
	pR0/kszfch6GYzy2BnfoDqR+HuBN9jiZCKDDjEwAGgjKVtYGnqVI06PUklhmIxsJ
X-Gm-Gg: ASbGncujIdp4Pbqmp9/6rswm7i6koiTStn6mdoCCrQerXl7o5c6WmyFmc3tMHwGX44x
	oBS4fDv1oi5fsFRPTnzZeArAOiZ4VbLBqo0gAovLdXfzTBhdI57yZklbb0LHXAv8nc7PNmQKRkb
	cPOf3A69K1UB1sp8k0xA6Z5BivI1FAcnQMd+/JilTrCibfPOikOIatbQ2MFJOPInqrGSbhRQEtu
	OuPqPFgMlSr7OFy3OnAiNS3MPfozRWKcBP+aVX9NJ3jWWPfd2OQW6hY5dl4TQO1V6FxDPy+Mt1n
	M8SSzgiyg3fi3i2XjeaM08Jf+RHMZfP+R1K5GXJJeFXHi2+3l/641ZR5ZRx1xUG6x/MpP/HhoG7
	U0R7ea4TSPQeZCYpuyifvl2IlhQ==
X-Google-Smtp-Source: AGHT+IGfrO9qcq1IyD8e5MHcZCBPtoC5fLDG6pPnD/jjziPnzPopMFCYCsCBHjvkwvGkAISQJM+jSA==
X-Received: by 2002:a05:6000:41c5:b0:3a4:ed10:c14 with SMTP id ffacd0b85a97d-3a6d12a103emr8564514f8f.14.1750608049643;
        Sun, 22 Jun 2025 09:00:49 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19b30sm7408369f8f.37.2025.06.22.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:00:49 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 6.1.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun, 22 Jun 2025 18:00:08 +0200
Message-Id: <20250622160008.22195-3-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250622160008.22195-1-sergio.collado@gmail.com>
References: <20250622160008.22195-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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



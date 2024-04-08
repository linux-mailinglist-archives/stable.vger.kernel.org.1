Return-Path: <stable+bounces-36311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C586D89B7F0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F6D1F2158F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AA1CAAC;
	Mon,  8 Apr 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YE47mZNP"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7D2B9B5
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558982; cv=none; b=uPfE06gSud8HFvl9uw/7E8Pf4JWCmVT0gR6ofzf0h0IZLTihM+vjb7cnvBGN/KyOXEcfOx8QjVX0HFeoNs7po5LDWvn/PEkHBSkfwvo/RBUIsIwU9/lIlzGNbYHIyMJBvVKqk+zcNKquEYuVW9tOyLYu+OAbn+SFy2JxaECMIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558982; c=relaxed/simple;
	bh=N9zOpsDhDEgmDxpOstBSRvmZar4BE2sviG3VGBgCyGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E22Fh4w9CZ/aMjoxRYWw5V31Vt2IQzGjihI1UId7RwiUVg1KttN5yFq8ozQ2/SI6hYxYNj7RRrHjAe1Uj8gy/Gzc5IXADPHmpLVgZUFJck1Q27ouzHY/vlvEX1s/5kSjKOKlUz8QufS7XNnEKTHEOI+K9Pl548dfn18yy4DaypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YE47mZNP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe93b5cfso57982787b3.0
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558980; x=1713163780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjXyM/G2BghfvB/kc5GwU2FA84e+m23V1fXtDkm9J5Y=;
        b=YE47mZNPWB/mT1OArd+KXz9aBCRj9YgWUNNYjZFGpxwHBbe7KG1TIByDYup+9ZDrlb
         HfL3hAvO/dAaCHvrU7sRlVdndPOlNZpWh6tgBkeiZ6uzjo0J6AxesXYpjzl+8YOqJpwp
         yb5eF4KmQ6VFrpVaP6k84ibgitV3gMGcW68RoOXQlh+EJopqqFgeMWWePLF+koxZ1V3H
         y0wxrwsNXyQ8VFF9feMT9UjoP28SX4FaD+CM1n3nsFfnmEVdOK/CCKCFNAA85wCc8+hu
         US7MgRgC+gFC+whsQsW7MqtVs9Ctv+vIQlEYFGAGfOH5+r/NzNE3Aacokkrdw/6nYQpk
         zB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558980; x=1713163780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjXyM/G2BghfvB/kc5GwU2FA84e+m23V1fXtDkm9J5Y=;
        b=uQ+fYc5YO2fk1Wi1KQ7gQz5YEGE8qTLTQNP8+OeLAVc+XmJwYqWx9zLbrNAvCe3M1c
         T3So8llZ7uEfIakebtIHbd6ZTuXuVxtS6FFB8sLsujKXKCYyhYzoLU6XQwx0HPi2EWkW
         Euq87UAXcDDjWYIHGsCAjkbVNR/uj0ROwL1Qx7kna1y4mBdlPcvTtQUlccDfFoSw9mCm
         5xsFr0IYIKbtl6yTvwVpjLy6T9gd0ijOPrx1UQi1Kh1rdaafQDGFHyrYBcv+ubERRMio
         7zg1sMSV2O7TJkaDcWtlyskQaex3jlNkrtS5y6b+RwpBVFeTnoIn761ovutr/uo5BJ6Q
         N7vg==
X-Gm-Message-State: AOJu0YwDa52VPP+UnPNtEhc9ufflzoIhN2znb0tjZvlO4PYQ7sFoYrgY
	RkvI3KM6DfiwrlisNn0PjAL4iEVuszAKkHGt90kNh7OaKEPShdDAHQT8qwgPsXa1On5Uj5RGU4O
	nyxXKMvdP7C3Epj5xXR9QW08syWU6nwFLeyf9APeX674LuZjqSwGePUC/UvyDmK+J4KDl3a2J7k
	WxV5ieSieffkWnysZ4scPekg==
X-Google-Smtp-Source: AGHT+IHsgidS+5vEejvZjMrDSX4Qh24P499OT6ExLocITHbcoTfU06dXeeugTp6fSwjUea4Ma4s5JgYP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:db43:0:b0:615:3262:ffa0 with SMTP id
 d64-20020a0ddb43000000b006153262ffa0mr2296526ywe.9.1712558980091; Sun, 07 Apr
 2024 23:49:40 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:19 +0200
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=ardb@kernel.org;
 h=from:subject; bh=bRQL7OyCelBVuVgo8KRc5aNl1kPex/CC3r6VixvptmI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14cp73SZdUESX1zVJh4aZv7Se8UEtIficesXFbUs0K6
 ftra/90lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImElDP8z2LnWti6dsakmmKW
 OD3lBRefmFfxtjfoXDFnEuFZHHJgPsP/3NVmltMmX98n+zXCtb+MJ26jTNrrZZtLmL5N3SeRZtH LAAA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-9-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 1/6] x86/head/64: Move the __head definition
 to <asm/init.h>
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

[ Commit d2a285d65bfde3218fd0c3b88794d0135ced680b upstream ]

Move the __head section definition to a header to widen its use.

An upcoming patch will mark the code as __head in mem_encrypt_identity.c too.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/0583f57977be184689c373fe540cbd7d85ca2047.1697525407.git.houwenlong.hwl@antgroup.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/init.h | 2 ++
 arch/x86/kernel/head64.c    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5f1d3c421f68..cc9ccf61b6bd 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#define __head	__section(".head.text")
+
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bbc21798df10..c58213bce294 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -41,6 +41,7 @@
 #include <asm/trapnr.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/init.h>
 
 /*
  * Manage page tables very early on.
@@ -84,8 +85,6 @@ static struct desc_ptr startup_gdt_descr = {
 	.address = 0,
 };
 
-#define __head	__section(".head.text")
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
-- 
2.44.0.478.gd926399ef9-goog



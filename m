Return-Path: <stable+bounces-40240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFEF8AA9CE
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B557FB217DF
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0041C89;
	Fri, 19 Apr 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaIgfQuv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E453A1A8
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514297; cv=none; b=L6nj0EGmDDcCrmnKQe8O15PSpHhSsjx2Ft7RtEqF+Ab8FFLtF4a7818Hrm8jbJLJtOQDsS0MqR9DMcjOtI2nIi/r76BMTYrzRLMGyslZPeajw309U2pT4Qn/yWyXpoGjL5IABPiM9fiMxY0vVZm0bO8c/A7VgN7rANeSIbJaBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514297; c=relaxed/simple;
	bh=PrP4aeqcKBns5yuFlsK//fM0qE4A5Dr0qfsCrXgBzpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XxZOYoKzJKIqTzqZXYauDilXfUHP5leKWZAYwkFd/ptaYTE4cjncHa2Iw0ev/tWiWdPdFY3JErR8ZbmFCeRREoG0rq5wLiUr59LqcJxJ6wHRsw5Zm2EN7SXdC3OfQ4qOshwk+VAJjMQt2oQ3x5VFJuw3PkLUZ33hLODUFwel04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WaIgfQuv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de46f4eacd3so2693144276.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514295; x=1714119095; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQrZXC2QD6oFVrxs5VJa1FP8YL5FGNXqPaq+mUsmwG4=;
        b=WaIgfQuvjmoHAN72EQ/y/GJ3xfdtrKJLPMb5bYWUoX5/s8uSlj216FECMTuTAy/l1U
         R/CYEYTUp7j717eSyQQhdZeTnAv7mIjZZHpQQpC2t+h4Iu/f0lQ6eSkDyCm9sNwN2UfO
         +GiimQQs4Jrxs9OynyDTx4RlInVPmcbqfF32KpuFwsT1sTS95xe3qwSaKEtaoMeh4b9a
         a9G1/zJ4wrY3sVJi5Uu6RcUg/UAkXsy7NcbJEXZhjSuba1NqkPiHttN20f0BDSyHjBeM
         ZyjPJBpZVClJnYZFJ/okniDdQdhvf/10oQH8RzqkHYaP6LxiVg1RhUSDHEdTfQF/Z1cL
         apwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514295; x=1714119095;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQrZXC2QD6oFVrxs5VJa1FP8YL5FGNXqPaq+mUsmwG4=;
        b=qkhaSUYsVhMTRAkKTyj3WwAIAjiQED0pL0RlqVkczDHsY5Mt+U3D/YikPWksGFC1qM
         ZabI20Gct2rLof+RcF2q2REDgQIUAzXOULr2mYT7JfLGfrAmV+KiG8K8AE5EeLHkyCSB
         kzbRUiuNiD4bQyz6VYAuPiS1qs179blA0QD8qnoOQ3cR/tNBWNLF/3CR2Kvayk0XNCiV
         RLXyCRr6tjP19uNieRjBCDhVWejaV604gYFK8L/bPdXGwOTj2NTAoXPwxPd5htccXUHS
         LzvHazso3LEE6wNJjdUhpBs8FIdGnQwRyDqlkrGxGCkIKycuSgCifDKd85EF8Yut5dFm
         dTVA==
X-Gm-Message-State: AOJu0YzDkPGgfMWHCcqKVMRGzbA1/8/sKQRBcD+pgzYDLLI3K6KJaZFp
	TFIqCnPmg1fJo4wUKtyOeIz/J/Jjq747tlmyoa+rsRlNuCTiuvivnw7eOS7NLF+qbT2D/ACJNQk
	hFPWMs+E8dN9SiFfpYzny+Y/v0tdcNulkQ0MKS8dO3NjRe0Ay56JWZHIpGbAmFR0QNEcQX4jWdP
	jFvUbC6VKO127cSCuVbjjlSA==
X-Google-Smtp-Source: AGHT+IEP3xwFKNTpnmQdfEqDXd+r/x/Egbf3Ru48GNJt2Yw0St5IHXIBEYt8G2XTg2vmNMJReQeMMEmB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:100e:b0:de4:c2d4:e14f with SMTP id
 w14-20020a056902100e00b00de4c2d4e14fmr202791ybt.11.1713514295261; Fri, 19 Apr
 2024 01:11:35 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:10 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=ardb@kernel.org;
 h=from:subject; bh=+RJ/VhuOXXuUD1J2IELfDiowAUZFTruMyTLNyOXcd4o=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXSbLp/hezXG9AzZnPkRfWW+2zvmzyC7Fnf/f670r+
 B+ycbNYRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIBGNGhsO2fy9c3vdixq+a
 dcHvklbOOZf0mW9Tz8J6BQMD2cNuCzMZ/ml3X2abteHaqynxob2HBC9Y6vtKRRrymy3WyP2cfaH qDxMA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-29-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 04/23] x86/efi: Drop alignment flags from PE
 section headers
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit bfab35f552ab3dd6d017165bf9de1d1d20f198cc upstream ]

The section header flags for alignment are documented in the PE/COFF
spec as being applicable to PE object files only, not to PE executables
such as the Linux bzImage, so let's drop them from the PE header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-20-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index d31982509654..38b611eb1a3c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -208,8 +208,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -229,8 +228,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -248,8 +246,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -270,8 +267,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.44.0.769.g3c40516874-goog



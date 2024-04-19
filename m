Return-Path: <stable+bounces-40243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C38AA9CF
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBDE1C21EF6
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19C4EB44;
	Fri, 19 Apr 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoktE/kv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B24EB4A
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514305; cv=none; b=ah1LjkRCoAZI8yYI+udDozBF1Ss4BIvXQHSz5pMOow+pNm/y9oaBDnTFgD5FkrSF8i6dYQgOu7Hm1i3WM3/PWee7DCq44zWvCgb8ddRwj7GXXkYX7wXF4M+Wo9KldVobYm2YkaGA+yI6ONMK/EqSg4MJeXTYCnrDs5a7nlX+B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514305; c=relaxed/simple;
	bh=KBnLCbQOOi28FWcg2py0ud0vP6OQx2l17OlVh8xviE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ASu9banjbCXFcmD8jfjCCxdIS3Hq+edsw82O9go+buglpic7DczRcEf8dudrdR8V7V6LnScfGXvyCvt3XQKPHLaz5is93xFatDorP15btmzrtn4G3VBXly52wnVQLtciFoR0joETr+as8aVopiHY25VAN9J3MRNytR25Ig1dY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoktE/kv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4165339d3a5so9921715e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514302; x=1714119102; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKL5/e5Mk2T93e88LFwtKKYMoeVYV+fmWSCsfwdHf/w=;
        b=xoktE/kvahfYZCe9AhNcq4z3pkRGjWLCDZ5zYKdylbcrl2ld/qdTEWJ64OsjjIrim5
         RwznysRkH7L0NnAjZdrIf+v73UOdIY0GuNIQ/6HU8Z6MnHn9zWvUwvtPsrXTcjdh0ZOV
         BZW+yAgIQRgRwbzeEJhtzB4EGRgZtJ4MaN30ysgqfV38CQugjRQoH0DxZag1cLwM5t8t
         4CDzDF1CydDOCgoc0gLAfrMm2z/TLrNrcQMwNp9wy9twsznLXvuexE/wBug+HpWA7wJQ
         MP9aGmPx/wsdC0c72QSyc07XxryjUjJMsnepmt2hI0tO6Qkla6Wk9QJVSONHg+YMCgP/
         fxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514302; x=1714119102;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKL5/e5Mk2T93e88LFwtKKYMoeVYV+fmWSCsfwdHf/w=;
        b=V5oqBw4LKHW8cYCPsYFojLF3DKg6zkIEOazqEkf0ifPqvYvYUQE2F613xqTCjHDqYj
         ciwr64clFyWQ1dalLHX9xhsXs1w3uc54LjgA0CmLKyXT2BHLB/dAH1cItNLS7mzW0uZW
         3UxsuTc+ryBa9ZDWzgYiCjzcxGjNVG0jkWRaAWpE/wVcM+YW6qwlpzi0MNL5yoQRV+lg
         0aNlBjEup2myjb4teVxz8R6AKY7Lg4UlfvLEM2n2/BOLpZ7Ujg2bUSGyNXeTFma4gZvI
         3Z+YaPKjfepfhEH7QM1hKihyC/lgP56wV1BGG8d2ZnRD6/qkROyYDLl2DbY20HGQe6lK
         uiSg==
X-Gm-Message-State: AOJu0Yyud+sCq3n03zIpP9hfavsCoUUQTKhTmIRwgTb1i2BmDWKEzjyF
	PMHn7tuy/Fyq8YwMxjReetejCzNmTBRm9rKL3c4WGAUSZF8b1tAh72A5jAylyQB7H6pVGOIz+kV
	sJEsFjzVTmOJZkDEFCqAubFRoiMXBSNjJ5UPIIKnX9V2cxemMLJFYF+cJdIZjSO5BRVfW6pxvod
	gLJPGrSFyOBatdkfyPDNhAPA==
X-Google-Smtp-Source: AGHT+IHyU3hQBU2udthqRN8j/KPQqjRzfdBpHO4emqYYL8fxUpwhl3MEoYXfdAj3nEmNKjkQK7hPRoDo
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3107:b0:417:4ff3:3874 with SMTP id
 g7-20020a05600c310700b004174ff33874mr13366wmo.4.1713514301984; Fri, 19 Apr
 2024 01:11:41 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:13 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=ardb@kernel.org;
 h=from:subject; bh=zIBa26+T4i+VvquGqZfY0dudgMJwygAF6QKfmIzjxWY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXf72Yp+/t8onPvw4ZeZ0ydDyo0LHAp9/F3b5ub9Uw
 8ZYS6Omo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEhI/hr8RhmxP2OZEXDzg7
 Nqn8ft3y6J/12Q1yuwQ9Xml3hSzZtJrhryD3Wma++VPEhDfeubj+4aOnbG1ddrUrYqUFT/9OmP/ BnREA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-32-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 07/23] x86/boot: Drop redundant code setting
 the root device
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 7448e8e5d15a3c4df649bf6d6d460f78396f7e1e upstream ]

The root device defaults to 0,0 and is no longer configurable at build
time [0], so there is no need for the build tool to ever write to this
field.

[0] 079f85e624189292 ("x86, build: Do not set the root_dev field in bzImage")

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-23-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 98dd4c36ccca..f63bf3ec6869 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -235,7 +235,7 @@ root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
-root_dev:	.word 0			/* Filled in by build.c */
+root_dev:	.word 0			/* Default to major/minor 0/0 */
 boot_flag:	.word 0xAA55
 
 	# offset 512, entry point
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 0354c223e354..efa4e9c7d713 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -40,10 +40,6 @@ typedef unsigned char  u8;
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
-#define DEFAULT_MAJOR_ROOT 0
-#define DEFAULT_MINOR_ROOT 0
-#define DEFAULT_ROOT_DEV (DEFAULT_MAJOR_ROOT << 8 | DEFAULT_MINOR_ROOT)
-
 /* Minimal number of setup sectors */
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
@@ -399,9 +395,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_setup_and_reloc(i);
 
-	/* Set the default root device */
-	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
-- 
2.44.0.769.g3c40516874-goog



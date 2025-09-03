Return-Path: <stable+bounces-177659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA81B42922
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 20:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939FD1BC22EA
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D5369331;
	Wed,  3 Sep 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="HFdRjX2m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6B3680A0
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925624; cv=none; b=OCc2R3ag6NJECtFjLj/sKjVNGtViDc3wMAP5ptVuYT5VtrSRRXMc02KkeV0GjSO08ped3jlDsGsMGdizpzCxcEvSJ1/BFq8hjVT3nnugX01M6XinBMigaIaN85lr3ISOoUJq5t4gQcu+hk/gEcZRFVNlXnK7cFzM8CY0Dm21WsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925624; c=relaxed/simple;
	bh=WwDwWn8PUMqzNmPRX5AJQr10TNESZyHkO/C2KBJ6k40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZnpyUxHiA6ld7kSBGqvQUW8Ie21mV3JkWBoFRDVwA3aEunkm+QHHolrXNI1AiDWBGdTdeFFWEXDK5VDiRLJD3lS09MiH9KM+J/VGAQ3vBFdaCvEVoFQIhUNOuma8wBlwKD6dTAOt4hfSHXq1jw7K2m8b58YWCU0UV53SEz4bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=HFdRjX2m; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso155371f8f.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756925621; x=1757530421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw9BHN0FeRhOuxnLyFuwgicmhR7Ua+FygQwocs16V4c=;
        b=HFdRjX2m+hw1pG9m2pDERobYQRW3I0p1KwV4T/VWdoK++FP5/8fWHgCcnxpjV6qROd
         vk5bgaBw0PCDyubHlmypfN7tuAOsfseNg8FwHeVzUItsOBJRUvC1/j2eMGBOx93n96s4
         dtJW8LA2ZuRa/9q2SxidIwifv/O0H3xCERQ02XWDsc+6UUOOplsNo3E8uD91wx3JDdqh
         UgQY/Fjz2K69d5cpaYzJWiplnXS+vlTIKNjW74LLNj1PkJkNvLZTHCbfv5qSqTc3Rah7
         Db8wR6xLW7ZsquaGi21r0njmbuRflTkQxfCe8+HHvfNaxG23hBfAiVeC6OP6jWqPt1r5
         F6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925621; x=1757530421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw9BHN0FeRhOuxnLyFuwgicmhR7Ua+FygQwocs16V4c=;
        b=GJTKQNyUOSUYZyZqcDWHWXx40wKLLOXvU+2MdMy4iEtEBEmfFa6XJKJrMW8K18eKLZ
         ISANWJKrzqsoTyZQkHxj5iFkZlHYFQq4yPZRt+PCAa9c/bbarDETzVeVV8GcLqjUC7cX
         8Jfad9LHP9Bb7Qz0Lr5ZBDnNv1E3YF66taKMhe1DLegQhmq3yooEo9KJ7QtsXeo2RjXf
         RV2FltjwFQhsfXxt+qKTOGcCCTfou9MWocwSPFT7Pk+zARbJvI55qnzT/9Ol6YqRFdz8
         Acy/BtRS+eGnzHIFIwm8km+BJFo7Wt8QKNVZ7MjJW16YjHFWNAi9crpsdTCRFTN4r/IM
         SD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvSYjpfaO9mSwwB0pCINvOwRZDaNOX4vroeHdncLwNj571l8bPu1ewRntn0sHWJKMLkQagzvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVh/ZIXF0+Xw3TuLz8j1MKvyR0v51Xh3/sFmJUIt3motAmGknK
	0tPpeCwWmydn496cfvdSYZEddKJdbuHlm+GGjOR8/noFPXrgJm0zUZao73EkMX21E20=
X-Gm-Gg: ASbGnculRh8ca5acsvjPxZL2tiJSzGQ7X/FEgz2D6cwDvPnRgHmCWXKGx8kqTkTCyij
	psr3jGkgzgUS0awvGyw/511KyNEYMymys3Us69I7UdIFEVhzpdHm/DRlYKWXFx7ohoaKyq1Rymw
	Si94J8HT73HemGIGV1AR4YFJu8i/fmtEM5bzb5lceWU6jaK1w/x9/qHQm4qabu45nD/XtlYlKaG
	hu0HPq+i1jIN5RmgR4ABzBQ0CwX+JQvDp3Jcqt3LTdFh4hfls5ipzQsCmEb3e+QGYNQLSutBXcm
	UwN1LA6FHd9hIYGRpQ3JhnyKufKLc4bnBuCYu0H3H/hoeUtsmRJXu1ftxP7cDGQ1izi1yD3GBbe
	0rK3Juaj69WU2ztCUF+JuzHB+NYHzEw0Ai3xAkxZCko0iwbz7RLhP1oSZxnKZrxuH3rA3PemZt4
	IEUxmqU9CnzlFqs+c=
X-Google-Smtp-Source: AGHT+IHOk7OXAl6oV2267O8szo6YMPylYzzI4Dr46hL2gWcdyGl5LwYgLiSHECqfj11Wp5eTPIQCDQ==
X-Received: by 2002:a05:6000:2381:b0:3d7:cd09:ae1e with SMTP id ffacd0b85a97d-3d7cd09b425mr7585878f8f.17.1756925621431;
        Wed, 03 Sep 2025 11:53:41 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm13920647f8f.16.2025.09.03.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:53:40 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 03 Sep 2025 18:53:09 +0000
Subject: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
To: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=WwDwWn8PUMqzNmPRX5AJQr10TNESZyHkO/C2KBJ6k40=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ29G2qCX+T9j37/c+fnfq7dTqqNA5eXy6TvlXmVMS7P
 PGnVtNsOkpZGMQ4GGTFFFkUzBO6WuzP1s/+c+k9zBxWJpAhDFycAjARwV0M/xQO+NxrPcCz4seK
 jYcYj+6IT7lUv6Ak6sOCQHb/cyx8fr8Y/hc0d90o7N7GUtb3nifIusPw69mPluJuU+yUKnK7Jl9
 p5gUA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

We did not propagate the __user attribute of the pointers in
__get_kernel_nofault() and __put_kernel_nofault(), which results in
sparse complaining:

>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
   mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *

So fix this by correctly casting those pointers.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 551e7490737effb2c238e6a4db50293ece7c9df9..f5f4f7f85543f2a635b18e4bd1c6202b20e3b239 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
+	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
+	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {

-- 
2.34.1



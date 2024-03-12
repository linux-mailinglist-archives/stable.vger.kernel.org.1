Return-Path: <stable+bounces-27420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1F878CF5
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15650B20F2A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E7524F;
	Tue, 12 Mar 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bJEXJ4r6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91F6FB2
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210033; cv=none; b=EW+hnjwvKlo0eBmBj0xJHXwqiJ5S+Vv+aPOyrNCtxCAr9kD8deBaBQS+H58FqIu6t291XhjrO6LpHeDql2oW23Eq+wAmxItF2CEVWj8X0PIWIcEFYKOS08kmEffC67izwHMrEsPmViDchJTKfXxBriOuoB4X3x7dT4cPFW/ihY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210033; c=relaxed/simple;
	bh=PMk/rTFNC8v/WZbxXaUIU5/HY2l7wQbZqSq8PeM/KF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkMy6KPQZ6vS0gLza0ZezU9ijQoYOAiVsALyqghClhdxgquH7cYi0xTB2OU29kh1LoxbPdhQmTRPux4h/OvbhrJAgTigaEA+5RPp7FKA/ho8T1K2x5/TsXggs9slpAGuM8//CENTNuPLCWB/1kG5dAYALI8pylIVw4CE85bz1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bJEXJ4r6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd10ae77d8so38120525ad.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710210031; x=1710814831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRqA0g05W48N7EVchL2+ZCRtUYEZmKtpe/WU4nz0oWY=;
        b=bJEXJ4r6ziqnTWVMjaZd0sLhoVIkDh/U2WLBHclMcEUXAXFg/UPbMpFRYErHba9X5f
         aCaKY931bz0g7s4wOuXs974gBqwC6C4/nVfV5QVNvsVLqqVvKCZyoG/XcKsHZGZbJVyb
         sY+rXXl1yjw02OfyZiXgrVZelx31KReiGKhWpoWBIW7G5dMrW0WFlG21j+qWSKkK+qQz
         VxdzQTLsMerZznUKKAKUrfrPsbmJHm6dkANC+ztTmP06qYhKDeoiPN2iYGveG2JUzahH
         wv2vQigVU44rtguIlKg7rV0oisltxhla7kpGO1IsN67u+5InSrxaBnWc4OMJ4zZFjUce
         0YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210031; x=1710814831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRqA0g05W48N7EVchL2+ZCRtUYEZmKtpe/WU4nz0oWY=;
        b=JY93WXWJpaFtOT8PZ/hDZQQmCCUExCOI5gCF9Fyh9TrzPULr8je8H9rb3oJUXcVlil
         zsRz3pjr/k1LOy6zUDDvQG3KnrRYusWXS7FQsI9sHO6VdZx5jy+JCwepXGfuMaHO/Jg3
         UvjMGcM1J0bpzGBnV9RJd1J6541gMK7dqTvu4qGK5sjlVdIi5TgmzmxvqJZBkxMCxin/
         jZP4FGRfrQ/QRnIFJo9nCpQZK6CxeJU4+g/rmeyrY3PP/5D8iSefyi4DKHPgilJZT5tj
         okAC2j2k1n5CYjWZ5Wbpk0dEjU71Tn4Ymgd4OZG/DfVcclLf9A9TsM9ZcqxZ7COU2aLY
         RmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzTWKGsHiz+ukxn4Hq/1/+Dn2/npKTDR9IT+AEJZsnmFrHbShW6BkVLpFfYPW6aSf4ZLT9pDBu5Q5Tf2Bt55NGqnBQHCpc
X-Gm-Message-State: AOJu0YzKztn1UBHnPjGhE+RJrxImxbxOZz9+xkW082f+iQoGf1YJsjtg
	+f0I6Q10wiwcknOfraO63v8kDwGRePU55mV0TjP5Y6ZXZW16R+dsRExsYM5fESQcSkKsj/G5zI4
	o
X-Google-Smtp-Source: AGHT+IHRzmrrD/vL7SV/zQC2oOq7RNpJg6XVo2QWxnj/zrg5gCaGqRzQXEVdk40YCrf7mEvIJxwvJw==
X-Received: by 2002:a17:902:d58b:b0:1dd:b6b8:a689 with SMTP id k11-20020a170902d58b00b001ddb6b8a689mr572370plh.6.1710210031582;
        Mon, 11 Mar 2024 19:20:31 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001db5bdd5e33sm5394175plh.48.2024.03.11.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 19:20:31 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
Date: Mon, 11 Mar 2024 19:19:13 -0700
Message-ID: <20240312022030.320789-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros did not initialize __kr_err, so they could fail even if
the access did not fault.

Cc: stable@vger.kernel.org
Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
Found while testing the unaligned access speed series[1]. The observed
behavior was that with RISCV_EFFICIENT_UNALIGNED_ACCESS=y, the
copy_from_kernel_nofault() in prepend_copy() failed every time when
filling out /proc/self/mounts, so all of the mount points were "xxx".

I'm surprised this hasn't been seen before. For reference, I'm compiling
with clang 18.

[1]: https://lore.kernel.org/linux-riscv/20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com/

 arch/riscv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index ec0cab9fbddd..72ec1d9bd3f3 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
 	if (unlikely(__kr_err))						\
@@ -328,7 +328,7 @@ do {									\
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\
-- 
2.43.1



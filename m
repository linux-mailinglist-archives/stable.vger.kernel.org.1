Return-Path: <stable+bounces-76591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F197B1D3
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D281C23779
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3C19F469;
	Tue, 17 Sep 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qB93pYbb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2519F41F
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585414; cv=none; b=GDjpOXDQZnGQHgurCV42my27bBfmcMRWAQ8DyGEj7ZoSKQpjIghTCFhC7PbWTqIc3EYaNd3KMhfkCug7uv6eXBcFSHJ+0oDU5u4GViI6Il9lM9Z0UO872LkPGXUKzeUU2na6jq6a9UPMnLYPYURtckw3pJBeFOsWPdOFw2SUkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585414; c=relaxed/simple;
	bh=xY9XpkDmSD/xk6OEETkgGDk1u5UGujSDYdc4wxzsr8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxBWzIJXJ+2h1Fi5ul0aA6H8QAembSBwPb5A9fU+3m69PMUnncYaD3O7Rqkb/4YnhlE79tGYBhtv4UkUvFsIPTFFcYd0vr2q6Uyu7EKZicLNRDg3UCKxv0NP/06ICN2tPSvk0y4SVk8Ffri1igvEtBHY9bhYJ/mw+iu3OJV9N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qB93pYbb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb806623eso49477565e9.2
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726585411; x=1727190211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ND6eYc2e5z5r+zC7yHLZpkb+5DC0X9uw7m7bHoeXpy8=;
        b=qB93pYbbuazHoCUBxNhmGTV9rmDbsoCPgZJWFyKITjVWPtC0MixJJv3Ccp48vOL6nb
         ada/ssb0JH3+RBP7uLiOIbDK1DCwUKPka6dqsAfRTBc2FF/Sjafe/qztAMlxRObcL4em
         cQetQG9kWQ7CKoJEqsRy3D2GKb+l+V82BmWTRaNDG4hHoecel1xx4Uhq2GbnTw/S6akX
         CTZGbZz7TgsdunqeePl9BzEJG7HeS6O1qnJ5m1cuKmsCzxOzCwOER27N8N23nMDaRqre
         CNrEn0dreoB+p8DCQ0CKWWOVxk/HVhFLyp5RxXa+crCHFUDcDId1ev2Cc97xt6jjYxK+
         QdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585411; x=1727190211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND6eYc2e5z5r+zC7yHLZpkb+5DC0X9uw7m7bHoeXpy8=;
        b=r33lshGL5iZbiRwIE4koTTzlzsPaOSa4QmLPHR6HQempoV9Cw/v4VjrC5PUFZyn2Sp
         VVI2COcmhYGi9GRbU5vclFM6UJkfOMFxkXhZBuPi4gtG9KUHJnCofW9asq3UDs40J/zE
         Cj3fMbLpNpBYAl2mR7wsnI786yYGRfvpLskzF1836mm3do4z60Gtcrm4GFXOTVMHwFfj
         m3IAtLHKU+MG00YB9BjDTDXwVBHaMApDwLGCMqX+TSmMxbBTZhf9H2EBcFY30Rtujpr5
         w6kDWlWzKdzvAqCSltLHSmzntCqZ+iVEaPlck14RdL4BM2AoFXhCaSx7mdd8CHZJA1Vm
         8d6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUubsRxvrKce3VijUfaMXBNN81RF1vkiVCzhQQZJmDkgcGAy7XbibRpaucwBMa2icCp3VABhjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7w9zu2rUl6fFX4j4U2ma5vjho0F4/S+TxcFGSPTuPZMxGzf9
	JtlEZBxTKECWoTKEXpZSpNWfIaRzMuroI/NH6Qw4EG+EgF2SFtfRWUIL1wk4Jhs=
X-Google-Smtp-Source: AGHT+IFcVadBxh+qAbSCLQDPMzD1mmtwUDKphd/cCXTI/LhLVwku41hzZL7m/dPisydjMBeLLD04ig==
X-Received: by 2002:a05:600c:1e10:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-42cdb522cf7mr148867315e9.10.1726585410790;
        Tue, 17 Sep 2024 08:03:30 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (83-65-76-156.static.upcbusiness.at. [83.65.76.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81a5sm9812770f8f.34.2024.09.17.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:03:30 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH -fixes] riscv: Fix kernel stack size when KASAN is enabled
Date: Tue, 17 Sep 2024 17:03:28 +0200
Message-Id: <20240917150328.59831-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use Kconfig to select the kernel stack size, doubling the default
size if KASAN is enabled.

But that actually only works if KASAN is selected from the beginning,
meaning that if KASAN config is added later (for example using
menuconfig), CONFIG_THREAD_SIZE_ORDER won't be updated, keeping the
default size, which is not enough for KASAN as reported in [1].

So fix this by moving the logic to compute the right kernel stack into a
header.

Fixes: a7555f6b62e7 ("riscv: stack: Add config of thread stack size")
Reported-by: syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000eb301906222aadc2@google.com/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig                   | 3 +--
 arch/riscv/include/asm/thread_info.h | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ccbfd28f4982..b65846d02622 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -759,8 +759,7 @@ config IRQ_STACKS
 config THREAD_SIZE_ORDER
 	int "Kernel stack size (in power-of-two numbers of page size)" if VMAP_STACK && EXPERT
 	range 0 4
-	default 1 if 32BIT && !KASAN
-	default 3 if 64BIT && KASAN
+	default 1 if 32BIT
 	default 2
 	help
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index fca5c6be2b81..385b43211a71 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -13,7 +13,12 @@
 #include <linux/sizes.h>
 
 /* thread information allocation */
-#define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
+#ifdef CONFIG_KASAN
+#define KASAN_STACK_ORDER	1
+#else
+#define KASAN_STACK_ORDER	0
+#endif
+#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 /*
-- 
2.39.2



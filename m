Return-Path: <stable+bounces-172559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05342B3276F
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD93E1B65B9B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AC2206AF;
	Sat, 23 Aug 2025 07:43:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED429B0;
	Sat, 23 Aug 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755934994; cv=none; b=j6gaFk5cDxSYqoUjgoYjwR7uTsyjAHuH1B1Wxiyj/KfRQ3V+KNOl7OODgChH03Wqn+guKbehVcYJLS6B4eaXJM74mIkcqkOTexJnCGr7Bnp87Cx1MGiZAwekWjiJEIgCNalkBTxBgfowl38Zs8h/AeZZiUSp1CWHiCWwyhpako4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755934994; c=relaxed/simple;
	bh=6UIZ7ESj9tVzgEhrGqLwMkKj8QEBxY3cjbR4+80KyA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr8GWaUDu1Y+2riNME4gasmmSeYZOD0xuvxCcOcMr7+P5bv80AhtHLhJDXUe1dAU3BF/D8W7Ona0en50ZHI9qZnksvu367qD1vHqkDpMC7w3jgF9ZV+ZPat+mkzdgRH6izwweD5eZDQhIgVsQ3FIylobRJJmD/oBBGVv897DFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso2077884a12.2;
        Sat, 23 Aug 2025 00:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755934992; x=1756539792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZPX8X0B5I+s5hVLSY+6qsXOHCGUOeVZARWEgGlLC+I=;
        b=YGRYpC1Hck04VLgqXkXMXw9eKN0LzOGybUf39FSwCg+88KyPiHusdH0dEecBovqBDI
         OcCc2x5XzfAb7YrVqCCUsKMuXgwUHSzwA/ymPD/T7yOHJqDX1FZkzzl0zN7Ssdnggdgx
         qWlCuEL+qTSQNrYEt2YZ9CQV7JCag2HigmqtquWMb+6Ns+LjQ7YqXaxHui15roivF1cQ
         sqiEFLTh5+NlL4N4tsXzbIYbPl65bpEsrZvCuMFbpNWtJy1mvesyJMVY6AQshcy37kF/
         uGPCGcshAD26W8Q70Eq+fEx9WRB+ByEtNyxtfXyhl5jK+kpqPaXY+882YNbzks1sQ/AI
         nqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUZkfyq7ynwOiTxWXM28Xfg6h1Gy2dBiqb9dhaukVi8IQppgk8XdhXEjnk/8ZWIQKoGTK10eTKG0HN7LbE=@vger.kernel.org, AJvYcCX9Mk4q+qLqxKtJePC53sKxqi7fdltOLW7MnpiA1jlGSikrCIKU6S1zvejoeGZGd63Oqk2A+tyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2PU0uX14wDo57hdD2jA2PKgJR2uvZ4VWaXSIZfsGS6PpCirq
	9RmOvlkYOQ6VYNZa7V+Ra0TM/0yGgymRRknhevOwOD/6HuHC3zLp8kkR
X-Gm-Gg: ASbGncsBzabHiBzz5sFFF/Ghwf1tyShZyLGw2U0Jggh1j8SQ+yzL/smVIqZR0GV1Qa0
	xbcMP4hWCJesAYnEpzM8Kr7h3r681WSl5i6f0B8Rp6sXfDQJuUwlRz1w7dtnwqmc4dOtpEYQc/3
	CMZB8wsbamUdg3ISEm5HluZhTItYpV0gNsRgeEqrsfhoedePNjWnG17+2HsdNMvtunp2KXQZLD5
	FKBu0GgEP3v9ny6a+zh2UY+9ULzSh/nf1YnqysVHj1PAUqDvKMThEceHYRFiXWJiZ8rBOug9IiG
	QQ0GVjD6MnpiG3ZIXyNps6ENEVgdZD7RZqnP4+xNbRd45KVXR8GMlbcMn+VTe/aofMS0f1V/o3e
	U9/HX4mkb2ndQJWTKLg==
X-Google-Smtp-Source: AGHT+IF0f2BQBSqWg3im1sdbkd//7GHSpBtH/wvKmeKJ5tjPncO4wHGFIpJvnnP3TVkq8/iiJDhfaA==
X-Received: by 2002:a17:903:32c4:b0:246:5a41:e6ee with SMTP id d9443c01a7336-2465a41e7fbmr42588545ad.15.1755934991900;
        Sat, 23 Aug 2025 00:43:11 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4030])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm15592435ad.48.2025.08.23.00.43.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 Aug 2025 00:43:11 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	fthain@linux-m68k.org,
	geert@linux-m68k.org,
	mhiramat@kernel.org,
	senozhatsky@chromium.org
Cc: lance.yang@linux.dev,
	amaindex@outlook.com,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	ioworker0@gmail.com,
	joel.granados@kernel.org,
	jstultz@google.com,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	longman@redhat.com,
	mingo@redhat.com,
	mingzhe.yang@ly.com,
	oak@helsinkinet.fi,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tfiga@chromium.org,
	will@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on lock structures
Date: Sat, 23 Aug 2025 15:40:48 +0800
Message-ID: <20250823074048.92498-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
References: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The blocker tracking mechanism assumes that lock pointers are at least
4-byte aligned to use their lower bits for type encoding.

However, as reported by Geert Uytterhoeven, some architectures like m68k
only guarantee 2-byte alignment of 32-bit values. This breaks the
assumption and causes two related WARN_ON_ONCE checks to trigger.

To fix this, enforce a minimum of 4-byte alignment on the core lock
structures supported by the blocker tracking mechanism. This ensures the
algorithm's alignment assumption now holds true on all architectures.

This patch adds __aligned(4) to the definitions of "struct mutex",
"struct semaphore", and "struct rw_semaphore", resolving the warnings.

Thanks to Geert for bisecting!

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/mutex_types.h | 2 +-
 include/linux/rwsem.h       | 2 +-
 include/linux/semaphore.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
index fdf7f515fde8..de798bfbc4c7 100644
--- a/include/linux/mutex_types.h
+++ b/include/linux/mutex_types.h
@@ -51,7 +51,7 @@ struct mutex {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-};
+} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
 
 #else /* !CONFIG_PREEMPT_RT */
 /*
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f1aaf676a874..f6ecf4a4710d 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -64,7 +64,7 @@ struct rw_semaphore {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-};
+} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
 
 #define RWSEM_UNLOCKED_VALUE		0UL
 #define RWSEM_WRITER_LOCKED		(1UL << 0)
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 89706157e622..ac9b9c87bfb7 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -20,7 +20,7 @@ struct semaphore {
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	unsigned long		last_holder;
 #endif
-};
+} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 #define __LAST_HOLDER_SEMAPHORE_INITIALIZER				\
-- 
2.49.0



Return-Path: <stable+bounces-179099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD3B50057
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F8B3A9224
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925E35209D;
	Tue,  9 Sep 2025 14:55:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6633350D77;
	Tue,  9 Sep 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429726; cv=none; b=KkZNCmlCnUoN1AmTSVl/8yqrCcsejxuvGV8x5hDbYC1jYA0hJwdSRRWZPy+/xxV9oqgTNbnQ31NNCXjogYXajOC063UoJFW3/bh151gb/0dYxEEJrKHqdkmNe4/Xyb/FrqqnkNgO89S4ws5xVf7H65qt4t5FpEqbOarnvvdiTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429726; c=relaxed/simple;
	bh=ky57FsK+ZwLKbku/saNrnr9EUH82r7jT4ICfgMJnqLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWF3xArQU3j1nUrX8mkrpJ013O4h7MxOWG6Pysq9RtT9xi5m0p2pL/6BmEJdyquupsUpkFItM76fW2WOoExkoSJJaYaS8/db1Xxg8tn+cKp6ZofxSG6qWxFYKNZwfU7fgOPVbqOxp7AO/nMqFTXA0FaWxhfP+687HI4eN6I2Kh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7741991159bso5162490b3a.0;
        Tue, 09 Sep 2025 07:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429724; x=1758034524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHogqelsTwxeycQ9MTU1T+FN83tx+jucaPlsIWSCXaw=;
        b=oaAHgJp5bQcJczLf6ynRt0JVAzVQSruxiCIFYRHHr3WZ4exhH5XSP66pRld+zsP5qj
         AVclDPUJFGMPeLjq/7C6hyBpTki2fgPU8bP5H6g1/SlojeTGOa5+mF9WebsK+PnEFOl2
         xyzb+Okxvqg5Hsnx6YA07FKos9qxyf5Sy9k4GInQL3JbtI5JloFr6SgG6eGDhWN3rQRV
         9DFAOsbb/dyVivC9YPgWnxuRJwK+VZt497V5W1+LGe3j9cJXFLeSjxlSUVEPO3inPVe2
         NwSws12zwpsCwMXt6I2cj6QIpwTMPcPGwmAzcFeGLW1WUPRa7cYDgpvmyQtm10Wb+9jJ
         YMkw==
X-Forwarded-Encrypted: i=1; AJvYcCU27Pr5jdCQxUSJFEPJlnJ9iPxpCp8R+Ant8y6BpdbCzuZx8FX1e3fIUCnaviS6mpOSULLjAhKxNUC6IoM=@vger.kernel.org, AJvYcCVGFm+mu+0WgCij9VnhhglKyiumRK9NMJcr9vyz/zguXkOfzmN5hf2IkbQpozZFMXt6zZDih5Z8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo14FlSrFjFsHHdvs5FPCqyqa/NaonziBQshnPfhyOSsa+5UsM
	2lFcOxQWY5uC1z4aqn77TqymBEwwLbK7UZJSG2G1lhNMOeZGxHxcY2SW
X-Gm-Gg: ASbGnctW+xc7KzhfTGhdeKHaikgaJx0ETwR2uD2e6H127NTnM/y53w5WrXifwiKA93/
	SMU2IcYtOibTWLDU8wXNAxqFvXrt+wGoSzdt8bO3IB75Ne7NvNyZlV9jyT69IE4VvaxlfLtCtNG
	fUnq63WusNYVpnmeHYa/6MXsih4ObmlZE1mrPWE3/W7gr5TxPMOyGUnyZ3JiWwJvb+tG6hTtSEC
	bE2RCs4ybBd7Rx4BL/yUCrRt9oRfwlGx4JC+r+6rr9wTh5LiVCX0G1j0P6qg1s8K78XxuPbvSXh
	MPSHpqFwxBAOg+dGNZskIzNWzIFh7V29AfsLNAqhE1Znete5C0DqPAd8e8Za3NGyljrMPPEeZgg
	y+LkTOL2r0tSRjCJSuOB2KA==
X-Google-Smtp-Source: AGHT+IHkIshl/aWZm2fCaWybFluAZHPfI6tLwJLETX4ig8R0dYCu6Ub2msMWpJ7VlLiEPnyVDF1nyA==
X-Received: by 2002:a17:903:ace:b0:250:1c22:e7b with SMTP id d9443c01a7336-2517493933emr169088305ad.43.1757429723785;
        Tue, 09 Sep 2025 07:55:23 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::20b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a9229desm305035ad.105.2025.09.09.07.55.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 07:55:23 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: amaindex@outlook.com,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	fthain@linux-m68k.org,
	geert@linux-m68k.org,
	ioworker0@gmail.com,
	joel.granados@kernel.org,
	jstultz@google.com,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	longman@redhat.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mingzhe.yang@ly.com,
	oak@helsinkinet.fi,
	peterz@infradead.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	will@kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
Date: Tue,  9 Sep 2025 22:52:43 +0800
Message-ID: <20250909145243.17119-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
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

However, as reported by Eero Tamminen, some architectures like m68k
only guarantee 2-byte alignment of 32-bit values. This breaks the
assumption and causes two related WARN_ON_ONCE checks to trigger.

To fix this, the runtime checks are adjusted to silently ignore any lock
that is not 4-byte aligned, effectively disabling the feature in such
cases and avoiding the related warnings.

Thanks to Geert Uytterhoeven for bisecting!

Reported-by: Eero Tamminen <oak@helsinkinet.fi>
Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
Cc: <stable@vger.kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Pick RB from Masami - thanks!
 - Update the changelog and comments
 - https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev/

 include/linux/hung_task.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index 34e615c76ca5..c4403eeb7144 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -20,6 +20,10 @@
  * always zero. So we can use these bits to encode the specific blocking
  * type.
  *
+ * Note that on architectures where this is not guaranteed, or for any
+ * unaligned lock, this tracking mechanism is silently skipped for that
+ * lock.
+ *
  * Type encoding:
  * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
  * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
@@ -45,7 +49,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
 	 * without writing anything.
 	 */
-	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
+	if (lock_ptr & BLOCKER_TYPE_MASK)
 		return;
 
 	WRITE_ONCE(current->blocker, lock_ptr | type);
@@ -53,8 +57,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 
 static inline void hung_task_clear_blocker(void)
 {
-	WARN_ON_ONCE(!READ_ONCE(current->blocker));
-
 	WRITE_ONCE(current->blocker, 0UL);
 }
 
-- 
2.49.0



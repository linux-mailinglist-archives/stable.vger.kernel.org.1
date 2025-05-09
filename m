Return-Path: <stable+bounces-143032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8DAB0F98
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84E91C034CE
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192D28D8E9;
	Fri,  9 May 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW0IKNpn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34928D85C;
	Fri,  9 May 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784245; cv=none; b=M2Z1mVb40sdg/SsIN6OvqM5FAeiAgqCN+CHnPxFB7CZJEBQVtrI0Cg8E/WtMgvLd/+py5lZnMqQsz+Rbe0eeomK4lirE6CKVJDv9a+BOZS4iINUUXNpi8WmSvQXyTXQ/jNbHtcYGPnB1b8xonWcD7DcPHySTGIztEKO4bj3J2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784245; c=relaxed/simple;
	bh=jQYrurA0SVtU9Vgm5m13+oVS1uHGNfI5uZAX31EmPXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHAR3yNbvCa4Gw47WXjXrH2T1YpTWuEAOZYmRqoDDW9oGPgD7jvUK+xj+NfutAtn0TdhbF09j/EkepErV96jKBwQ+AkV8dhz7h/Wj+9XAWqPQgFCY2C0+a4Jq0eS18nuwq4Fo1mQZzV6Ghv6vkroByN0md4a+if4ASxks7DSlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW0IKNpn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1c85e77d7so741560f8f.0;
        Fri, 09 May 2025 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746784242; x=1747389042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNF/WTwb6fH59tCvVgLWV5Zr9bwM2Z/zWAmtxnfJ/g=;
        b=YW0IKNpnasXIpthKh9VqKDLM4w+hIcg1BewphLSSAL2F083JD0ZBm1fV7dIsqWYQin
         Gx44+f5XW3fD++L3/ZTg/eKULvW0kUmMO6HNNJzRkEGVeaAN+Zx9/CdAnC+kTbV1QY8C
         FTUPeppnrGBxIBi85jkL74lVXwSr2ZHjSp3tx/ChKBDsRYiJh0Y0guIr0HUmBkGp3sz3
         oYAqkjkkGsCpDVn0to/NzEXWiDiIRBXPhxNMKLbnaMO2UkNM2/NOm7dCd43FhRCFALot
         dWAyp8yBf10M0VasSNsiacwORDrOThoItVK8jjvs3JVRJ6ozLhxEzXFz8eh1/tiF3+qN
         vi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746784242; x=1747389042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TNF/WTwb6fH59tCvVgLWV5Zr9bwM2Z/zWAmtxnfJ/g=;
        b=lWycEPrHf7TJ+c0Mo43vM4mjlPD5x84UNcp+FwHLkLmEhMycb2AgKtYj4As1OeWJB6
         BRYTG36k3pkv7lsaS4s+omFWSQDLUkmCifaUqPR0PjKpwK3V9aCZvVquFEQwDiXSJR1U
         ZYabW07sMO+rNCTZrV9hUlpXMWI3C59QjiDI6uPWaZTd+3OEyfm8gWluenMaAqe/4laG
         xarK+PQfHAxZTXf+YRHu5C6w47SQ2R6e1xah8uIMYSyIc/GDTQoGgaxZItIUMsPM7r/X
         G0yLX8yXL9gyYZV0b+k5HTIEBI1mqSpI8d94mos64SuFXx5x6IPoIK6Hl51msizFhv8S
         /MnQ==
X-Forwarded-Encrypted: i=1; AJvYcCURTOwv/bBkNQ4ypNBQDDfwjc6xiY28YAsc+HDkkQV2Gz1zSQrkLCCUCrVlnQo7MBBCKfkFnjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+nRoiWk7GEKa8n4St8hXwNIy/OdYHTVgs3VLpC4kFzKkKjZQ
	JgZ5C1xyEPliTJfNkp4eU08uMjNQjF9NAM4fkfY3uNQ0QhlpMbQS
X-Gm-Gg: ASbGncuQFacl/O4iyDXWphPno+6No79UkpxnlLIqyL49y8WDdGrGKFhoW6kclC8C3uc
	SpjTWvi/LoLE4eB5TYFEPO9/inwT+TVnyV8us0pOPv0usxyagXQm1H7bUb+5gX3vHmNuj5g8co0
	r3xRR619PsShRyDV6sx+OlZJiYlhXzpHsDYn3nHpJY0iq5mcG5IORHx27bwl/gDGfeU9fJa0Hvc
	FCOgjl5bzLU/+KKGFSQmwBzCXh5MMQgsKlbO+Iz3JMqptL8WdPx0j7YHsZec1SmkEf17GK4YGVA
	s1kd9exFx7uM8YJmeu5gx7xTLKHWIbXohSVT42vpR5V4PytCkw8FpDqec1DLpHyKJPzdN4NoG/h
	sptPZ9XUP1BxX6X6ngF0ASuDkYzZoi/ghcuObyv2ArRiI
X-Google-Smtp-Source: AGHT+IGMXb7WjOlHsAN4McILuPOq3l/6AWG6K2Gldt3FlkNGZYP2N4+a8wqcjJih8Qzz9h7iz5UpcA==
X-Received: by 2002:a05:6000:2512:b0:3a0:809f:1c95 with SMTP id ffacd0b85a97d-3a1f64f1443mr2138130f8f.53.1746784241837;
        Fri, 09 May 2025 02:50:41 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7e26sm66058155e9.37.2025.05.09.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:50:41 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.98.2)
	(envelope-from <chuck@shift.daheim>)
	id 1uDKNM-000000008gK-2htd;
	Fri, 09 May 2025 11:50:40 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com,
	sashal@kernel.org,
	johannes@sipsolutions.net,
	richard@nod.at,
	stable@vger.kernel.org
Subject: [PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"
Date: Fri,  9 May 2025 11:50:39 +0200
Message-ID: <20250509095040.33355-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 887c5c12e80c ("um: work around sched_yield not yielding in time-travel mode")
added with v6.12.25.

Reason being that the patch depends on at least
commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
in order to build. Otherwise it fails with:

| /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function `handle_syscall':
|      linux-6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined
| reference to `tt_extra_sched_jiffies'
| collect2: error: ld returned 1 exit status

The author Benjamin Berg commented: "I think it is better to just not backport
commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
"

Link: https://lore.kernel.org/linux-um/8ce0b6056a9726e540f61bce77311278654219eb.camel@sipsolutions.net/
Cc: <stable@vger.kernel.org> # 6.12.y
Cc: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

---

Just in case, this throws someone else for a space-time loop:

What's interessting/very strange strange about this time-travel stuff:
|commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")

 $ git describe 0b8b2668f998
=> v6.12-rc2-43-g0b8b2668f998
(from what I know this is 43 patches on top of v6.12-rc2 as per the man page:
"The command finds the most recent tag that is reachable from a commit. [...]
it suffixes the tag name with the number of additional commits on top of the tagged
object and the abbreviated object name of the most recent commit."

But it was merged as part of: uml-for-linus-6.13-rc1 :
https://lore.kernel.org/lkml/1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at/
---
 arch/um/include/linux/time-internal.h |  2 --
 arch/um/kernel/skas/syscall.c         | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 138908b999d7..b22226634ff6 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,8 +83,6 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
-extern unsigned long tt_extra_sched_jiffies;
-
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index a5beaea2967e..b09e85279d2b 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,17 +31,6 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-
-	/*
-	 * If no time passes, then sched_yield may not actually yield, causing
-	 * broken spinlock implementations in userspace (ASAN) to hang for long
-	 * periods of time.
-	 */
-	if ((time_travel_mode == TT_MODE_INFCPU ||
-	     time_travel_mode == TT_MODE_EXTERNAL) &&
-	    syscall == __NR_sched_yield)
-		tt_extra_sched_jiffies += 1;
-
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 
-- 
2.49.0



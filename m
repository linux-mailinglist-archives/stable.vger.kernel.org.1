Return-Path: <stable+bounces-161804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF042B03754
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E8E177258
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88B221739;
	Mon, 14 Jul 2025 06:45:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A7218596
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475503; cv=none; b=iRSgypdx9ouFL3Py+7HhBDbfSzjWT8/fx0fNxLBWF6y2GpSXtD2BxFl5J9+0jU9N1nZfWuZKR9e4HX13NYNiSvtlv8Twks0B9BjhBO7qwX9PQjiydvWNsHBDTN5ZOIxX/fwI4A8KCMvvQdvd2O5E9O48ar5suG+t8qGjO13UcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475503; c=relaxed/simple;
	bh=zugDobkgVmIGPx+9HOr18ZQP1YebPEC+f2NyXkaylZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCbLzqBJxsdhqBdO9vgQeJFC495ZWL3azV49BaSV98A9MOdFXeu7AuGLfqrW8a6UJ7NrenpvkbTlZSlDH6Zg+NLXPgEbb3JLDi27prJ1Ck2Y+rAnc5K5bSRVZBdzSCzz/TMHvuokly8dGdn9Ac73UD+6Mj1q8teOWFbjOnx4Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C10B1D70;
	Sun, 13 Jul 2025 23:44:50 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 101A63F6A8;
	Sun, 13 Jul 2025 23:44:57 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ppbuk5246@gmail.com
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Yunseong Kim <ysk@kzalloc.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y 1/1] kasan: remove kasan_find_vm_area() to prevent possible deadlock
Date: Mon, 14 Jul 2025 07:44:54 +0100
Message-Id: <20250714064454.979605-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_vm_area() couldn't be called in atomic_context.  If find_vm_area() is
called to reports vm area information, kasan can trigger deadlock like:

CPU0                                CPU1
vmalloc();
 alloc_vmap_area();
  spin_lock(&vn->busy.lock)
                                    spin_lock_bh(&some_lock);
   <interrupt occurs>
   <in softirq>
   spin_lock(&some_lock);
                                    <access invalid address>
                                    kasan_report();
                                     print_report();
                                      print_address_description();
                                       kasan_find_vm_area();
                                        find_vm_area();
                                         spin_lock(&vn->busy.lock) // deadlock!

To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().

Link: https://lkml.kernel.org/r/20250703181018.580833-1-yeoreum.yun@arm.com
Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6ee9b3d84775944fb8c8a447961cd01274ac671c)
---
 mm/kasan/report.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c7c0083203cb..5675d6a412ef 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -398,17 +398,8 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		}
+		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		page = vmalloc_to_page(addr);
 	}
 
 	if (page) {
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



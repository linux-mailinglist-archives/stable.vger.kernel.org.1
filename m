Return-Path: <stable+bounces-59500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D3932A6C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D971C2314B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325D19DFAE;
	Tue, 16 Jul 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ/U/p9S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D339198E80
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143797; cv=none; b=iw0e6Uo1tr7hnDg+ERjDOZp1HC1peFT8hkdtucaj7wk39Qp5jS1BW6PUKoIM38C95Eep47lbGESA5jJVcyyZMAYLpzIpQsNZtvAdYlOTTr3qOCOAQi+fjvTclq+joRFCN4Z3hkO3vs/Q1wRgiwv35LZR/3+Lry/UcV1I7UVerhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143797; c=relaxed/simple;
	bh=SOEd0XFt5aVs8ymPN3b9ip+m6HDiMvsyQWpJEg5sJsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eetB/pshMxlvejeFrNR7u0AakzdIzrU9gUSaqbruwekutVfMLZhPeihjzU2zR28Czb2Tuxck998aaTXe4gLtxIbIZs4X4LYALMp6Z9V8bmaVgAlYeBuoyhqGNmmBwtc4NT66tr+cEhl5tmIpV5RUBZy9axVDd091SVZM293bsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ/U/p9S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3460b416so5327935ad.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721143796; x=1721748596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awK6xdP3zUkIV+GYVfymVhN+kOlSYETqwuA36TdpVfE=;
        b=ZQ/U/p9ShiBNFRw65kTvr/IYSfyDcnyxtytJNbtaZJL+pJkEvAdR7SN9x9kCUoIjXy
         mQ7MDWNu0ts8w2AbufcOx4S8+8y7mV/fC6CwgRUnlU8pjs6aHFser1YPcoeuV0VkDIFF
         wPQ2eJnuaVkVhwUW8oAqdv+ZihTpnS8nwdaN493CBLjucfDSInJkF0B073fbxLezU1u+
         sMRhHBhg6Nyx/c69f4GaJ3Bg2taM+JyJEY3Y3qwJtutGd9eCfw3uVGzAeIIpJaKWCQnU
         vx6Cj86pxN9g0Lp7M5gMtpqztFN+OdzJelcRBdsjHgIfJmXYl0QvX0+UelrJWg2V6wD+
         8MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143796; x=1721748596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awK6xdP3zUkIV+GYVfymVhN+kOlSYETqwuA36TdpVfE=;
        b=H9FqP/aUVvhLH2lFVhKAfTF1uSzMoElsnxf2UXqZA7xu+UbbB+b0m5B49iWin/K1b5
         seK7yNTpJMbMqoGjoMbnnNBFEFWchJ8b5BNH2UAm/aIJxPdxJZBryRZJCffXiNTyYFS8
         3KJKqAtNEpTX3X2biulbr/nH+4UV8XV2J44RKjK1QEkRQqhkHmr71IEuKeQjGm+KJ2qj
         Njhtj32hXE+MuH9aWEFdUjRPFcWiW7dtWzwhXmFAsw/ZxRT5teDoM0rxHlTpiLUWqpGN
         vhQGj+HSGdSIXGSR72WZMRfB/ZRPizJBcUkBaen7rzS9OkcR+xlpD/QSdWBnLIL7r9av
         47/g==
X-Forwarded-Encrypted: i=1; AJvYcCXo1C1S616IZ3bq8/HM4elAkkm0wOvczrhdcML5QpCX6/EP5Q2PmzVMKoobGmErhDfc4xLd2sA1XteurRVwoUZ8pINJcJLk
X-Gm-Message-State: AOJu0YwN021/lMP1WQClMTaf2DrJudsZUDssezgtcR5683dDmcRdpgVh
	gcuYHlwx6v1n9+vX9JZz+q1NTL+AXzByMkUai/5X7od9GbjH7vij
X-Google-Smtp-Source: AGHT+IG04fNo47zoJjZcFE7CIOgMNZlksDrUqyKNUEM4lCCRwEXp6/wbzs3HBnd1vIqPrgOgZqE4wA==
X-Received: by 2002:a17:903:191:b0:1fc:4377:e6ea with SMTP id d9443c01a7336-1fc4377e764mr5889905ad.9.1721143795581;
        Tue, 16 Jul 2024 08:29:55 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4ff36sm59792575ad.271.2024.07.16.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:29:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: 2001wayne@gmail.com
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Julian Sikorski <belegdol@gmail.com>,
	All applicable <stable@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.15.y] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue, 16 Jul 2024 23:29:41 +0800
Message-Id: <20240716152941.159841-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_cst_latency_cmp() comparison function currently used for
sorting C-state latencies does not satisfy transitivity, causing
incorrect sorting results.

Specifically, if there are two valid acpi_processor_cx elements A and B
and one invalid element C, it may occur that A < B, A = C, and B = C.
Sorting algorithms assume that if A < B and A = C, then C < B, leading
to incorrect ordering.

Given the small size of the array (<=8), we replace the library sort
function with a simple insertion sort that properly ignores invalid
elements and sorts valid ones based on latency. This change ensures
correct ordering of the C-state latencies.

Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
Reported-by: Julian Sikorski <belegdol@gmail.com>
Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Julian Sikorski <belegdol@gmail.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240701205639.117194-1-visitorckw@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
(cherry picked from commit 233323f9b9f828cd7cd5145ad811c1990b692542)
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/acpi/processor_idle.c | 40 ++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4cb44d80bf52..5289c344de90 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -16,7 +16,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -385,28 +384,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	return;
 }
 
-static int acpi_cst_latency_cmp(const void *a, const void *b)
+static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
 {
-	const struct acpi_processor_cx *x = a, *y = b;
+	int i, j, k;
 
-	if (!(x->valid && y->valid))
-		return 0;
-	if (x->latency > y->latency)
-		return 1;
-	if (x->latency < y->latency)
-		return -1;
-	return 0;
-}
-static void acpi_cst_latency_swap(void *a, void *b, int n)
-{
-	struct acpi_processor_cx *x = a, *y = b;
-	u32 tmp;
+	for (i = 1; i < length; i++) {
+		if (!states[i].valid)
+			continue;
 
-	if (!(x->valid && y->valid))
-		return;
-	tmp = x->latency;
-	x->latency = y->latency;
-	y->latency = tmp;
+		for (j = i - 1, k = i; j >= 0; j--) {
+			if (!states[j].valid)
+				continue;
+
+			if (states[j].latency > states[k].latency)
+				swap(states[j].latency, states[k].latency);
+
+			k = j;
+		}
+	}
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -451,10 +446,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 	if (buggy_latency) {
 		pr_notice("FW issue: working around C-state latencies out of order\n");
-		sort(&pr->power.states[1], max_cstate,
-		     sizeof(struct acpi_processor_cx),
-		     acpi_cst_latency_cmp,
-		     acpi_cst_latency_swap);
+		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
 	}
 
 	lapic_timer_propagate_broadcast(pr);
-- 
2.34.1



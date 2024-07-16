Return-Path: <stable+bounces-59769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E693932BAC
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA66281DD0
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ECB19AD46;
	Tue, 16 Jul 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTsS7jAy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235F17A93F
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144855; cv=none; b=FrGYgzySy+BZWYHruCUQgLsoKId+axmg/mhSh3GEtOy6dAS8rS/kIbZncZ4D7NcZHQt4jwzZHBj28nlY/J2xV1PhlsDxdU8MTiPy3gR1yvaOyBCxFM/oHWEoeEG2DDMNND/ri08FqNGDjPbYfRQyGma/9Z1P1BEtnvh1yE56ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144855; c=relaxed/simple;
	bh=BMAgAw0g0Jn+Vdtzk7cpevKrd9eFIAiJ2M0jXaf6qu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eajipwdM8oSEQW9Eh2+W49XFRbZapMOSvL15mzO46CSgnFshw6rUdevL411xZ4ex81MFL8YL5Io9lzcaicPkkmeYiXcsV2gfRrZv2UW5oFDhSfLTPqsR0/hp9nOom8WQLo2GBX6+FGqh+LnFy5PDaO4smaPaNnJNbsjQeyimVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTsS7jAy; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so565794a12.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721144853; x=1721749653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar7GDmt4I7OrF6+J0xS7CE62u1EJiLbq5y7OlQ0ki44=;
        b=WTsS7jAy589L3MYCQVUbj9NSoz6/JD6siRDrEi/xJar31eKh9ARoO7KZH4EAi+wh1M
         9LGZlV+P7QyDbSIP5Nj3Cj59qnYzC3ZhEoR6KcbXDJzhTqAUU7hKpdiPh0pPMdIe2dzx
         vLOCSFK/wsr02jUNK2MghGo2hSoPnFGU8nvsvhOjIb8STKxaJZlA9ux8/G3S4Ax5f0IY
         k/k7F6VIa1mMrxD9V6SsrGXWcdRlA5jhlpqec8fBm8dK33hCL7Uz+4POlnTnOq9/XIEt
         EGrmZGE9oZx6RrKPFOA2X5Bf/raot8XfMq0C/qC3DoLyDTO5fhI2Q1rFqtGvWu7R4Wva
         sOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144853; x=1721749653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar7GDmt4I7OrF6+J0xS7CE62u1EJiLbq5y7OlQ0ki44=;
        b=Qrrotb2b2iiJy1oZ6q71mzd6RPpTE3s6d/9lNYNNSuXGEul9B8rpINFzN2/pPK6xdb
         8NNTOU7FTPmUC7jWOB0jzmCFEHov0GxhziwY+Gfbygo9D/X1UKuKEdzrO+STbx4KtXG0
         pFG+reYd7PzM1Hm+xNHaiOZGLm6Yw1zmvvDRCU4HpNcO5NuNVCZq2XsAYrpWMOdWPIVj
         eKJEqZZOfh9BTSYZrvTasaAmoGsXnBSf3dTH4/wisS8TIoAXsibhvQHA2ZQtkvhidQuT
         kDuMBYxjmFKPuRw4n/Ij5nBjhttfH2vX/9TYNt/+Agv9dg0N+g0CoBRgWV0Uv1P5YiFq
         NCGQ==
X-Gm-Message-State: AOJu0YzJs93m/Lic8aEzzY83bVNC2ERMN68bVIgr/sZEltGcV3k1Bb8W
	aSXV/TtcjXIM0MoXhvzAeyvoDn7n7bDhbIgWBuB4XC3LHc7vBmFhL+jtJg==
X-Google-Smtp-Source: AGHT+IFwqdP0//sxE2n4PfOqusxHdjzr4A369X5fMFhnKGi/bkoNluSI7qQBqgkSEXCwMehNXOLc+w==
X-Received: by 2002:a05:6a21:680d:b0:1c1:5772:3bf3 with SMTP id adf61e73a8af0-1c3ee3d42damr2775145637.0.1721144852516;
        Tue, 16 Jul 2024 08:47:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca776esm6458692b3a.163.2024.07.16.08.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:47:32 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Julian Sikorski <belegdol@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19.y] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue, 16 Jul 2024 23:47:27 +0800
Message-Id: <20240716154727.288334-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024071531-underpaid-plop-ac0c@gregkh>
References: <2024071531-underpaid-plop-ac0c@gregkh>
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
index 22b56a6e9cca..363c149e8237 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -29,7 +29,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -545,28 +544,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
@@ -611,10 +606,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
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



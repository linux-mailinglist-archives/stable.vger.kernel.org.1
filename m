Return-Path: <stable+bounces-59679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC2932B41
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5727E281D90
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FD19F48B;
	Tue, 16 Jul 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP96tdlH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1A19F47B
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144576; cv=none; b=sjhKnYv+5kBVEYhtms68svtLqljnoLEZN/dFa3LXPWKAbHNdck49cwqDbah3Uy8J5mE0T+qeaFVM7Uc8iaV1jzfe8f7IuKKrp9oAPmbwprjqwMjhLqD84y3lPh3Kzva1FdAmAeFDRIgL6oZyMHrCkW5L6aWmLI6kP6Eu+VhMsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144576; c=relaxed/simple;
	bh=SuYkkG+qfVHkIUP+BiAV9dq32Za/KdfU+M/YTNG7Xno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+/0cVU5WQxTVz/qdr0ghOlpB6ubvWbLG25zichovWh2anVLKYNmYrPZW3MoTxG120tyh22Dvf1lNdyhEQRNu1i6jmQg6BjfeHkqggD0ANzauTq7xUWntNXeyfBX2dYfa4Uh4wz53hNAqJbLpAecrLmJSExC6N5z5ixRe4D7v6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP96tdlH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c9becdc45aso771798a91.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721144573; x=1721749373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD8b1yCXzdeJIVLHMx0DmmNjpp4xPDi1UEKaHLBOfDo=;
        b=PP96tdlHWuBzvXxp675lha/L1CvdE3BYDUYP4DBBjtmbW33dns7biNsBxCHnDNH2j0
         ohdT7biHQ8RxuwAkonXPulxI0OWObPm2EI07bnn6gT4Hu6h/2CFSFL53JIOr5tLKFVs3
         MWYa16y8KIbpdkjudiDc7YVAtXRSGULhZgdxsoZW+SxP/Ak7R/n2zvLkX0o+E/fR9nfG
         tWRThcCHru8fet3VOY/K4IU//g+nCO435vTjqBV2I2nkwHXrbcBnegWztx43JkcxZkd9
         5ODGLxz/b5drEK+QHKyWAwwHtpp3nHGm83qYR8Y6K5C/8hxrb/yWMuLYvd6KnQ5nsixD
         4rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144573; x=1721749373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD8b1yCXzdeJIVLHMx0DmmNjpp4xPDi1UEKaHLBOfDo=;
        b=wcsbgT6n1k/6tsaTMpoD6ibDjEfn6EFXQAyhNohZypq0aUXLRf+29mXqYZBzQykJEb
         SgkpuF6xehVxRA9XychHRMmV5t5bU4P9Oyie1vd1RhcQzh1PtzhbPx5Gqw5TBCLi0E3V
         pm28ytWrRQNhryiGKl8oXYx3an0EHNch0PcUSoxbu16LUVhKQS/siu5mCix8A6T6nNHT
         fHJU+3ykumuTxCvV2jKhhAKUckOJWT7gEzaDOpTPBTZNNgVcy+HSh8BLH4H8XbifoeoH
         pKas8qFD306X76EMg3+Ous/Z5llwBBg3vHzvRw0m+0+0JyEiRiR+YDlQDlvbOWih2hqT
         dDOw==
X-Gm-Message-State: AOJu0Yw2WX+EdOuBfYMUv9UAYlc4CmawXm36hCBW/xF6tCQgj6H7uYAq
	Aydiia7SH0TgL54c3pnEf829JoLncK27Q2jm8pClUWpSHa7JZymgMAESfQ==
X-Google-Smtp-Source: AGHT+IEUd79K1hxwCWt2gFdJBzPumJ0Qxwph69+PILR89BbtzfR+JctnnJ/xrUNVO5OrAhTKB7Ib2g==
X-Received: by 2002:a17:90a:4409:b0:2ca:7cc3:994b with SMTP id 98e67ed59e1d1-2cb340f937emr2464815a91.2.1721144572708;
        Tue, 16 Jul 2024 08:42:52 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd6da72csm8473701a91.36.2024.07.16.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:42:52 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Julian Sikorski <belegdol@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4.y] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue, 16 Jul 2024 23:42:47 +0800
Message-Id: <20240716154247.254888-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024071530-rambling-fable-98ea@gregkh>
References: <2024071530-rambling-fable-98ea@gregkh>
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
index 0aca77cb8301..92db8b0622b2 100644
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
@@ -541,28 +540,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
@@ -607,10 +602,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
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



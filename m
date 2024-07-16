Return-Path: <stable+bounces-59561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA5932AB2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AD1F2304E
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A951DDF5;
	Tue, 16 Jul 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl5FXvqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C1CA40
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144222; cv=none; b=HF0hgyi+SfGH1Tb2Jf3CaNbk0enPr4P4yCj636lgOt2W33A4jGhgDkUtpS3YFrUPuIli2pi8Kq0uflFgDyxO6n/5MUuwxtJrUyoXWh9DGE0+b3DPGdXj+jS+EfAl+9oezQIz5Hg7ajFonR+gJsrunhihDVLBSipLxBP0pnJJ/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144222; c=relaxed/simple;
	bh=VB2Owqtq50u7VrxMX5z85QWLrV2wRmibzdod3jc9a0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyLgw/SOYgfQDidQnYkI9bNG54l1yH0swvbypNxKgTG+mPbKIogxYZ3cmRAuzKKFnazbJcbO4KDfCOoHXF+mAyrpgOcltx1zVQiyqBBhCdR7Vmg4Z2hlpAeZyvKYseNiAsb7aRMT8y3A64qHvX0xN3r17zNexMBDyubUTEzuLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl5FXvqi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af934313aso177603b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721144219; x=1721749019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9W1SbA18Lj9YiNGpo9pngBPh/SwGd9f/jdv1vwGJFA=;
        b=Pl5FXvqijrr4F0/6kzTFCLeYBC5S9YjAQMZHWY+KR8B3cW4uPQR+V3bULPfzUrpQIj
         kzLR/t1zK3gIfIkcBBXNFC+ga3pmP9KHRjzJW2qilD42myKuHFguxns7Nnx9cWTP0VpP
         3rC6XwW9cCUIqsCQjymfmQh1Lc//VZ5jIAcTleQbePkruLL8RMbMtVQZugY/6Xt0+kUA
         7OFdtVjKrOM6PtHCNYetHDXDoNxcpWycOuSR9KoUBjs3RVzCo0EKXmPFHrkqmWyhaw5A
         E/Tt6NgoKTD8+vJJvyF/tiCVmbyTnfBA8lRct8YFn1ufxp36Ata0hOgM39BJ800mlacd
         SKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144219; x=1721749019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9W1SbA18Lj9YiNGpo9pngBPh/SwGd9f/jdv1vwGJFA=;
        b=qcY68mPaCe+AOnMHcU77apSEjfOkR4OgKst0g7dDxsld1kNy8j1/ThXcxZaURyONL2
         mjQa/iUNeU0VU4nvS6V4qstwsfcDwAKOCSiKzoXtzvM9PlK50FahuinQ5ZKuYVAGM5EO
         DUOJfmMw0eEqqnWwXOmJN6KRpAW6YCS0Wju8MIRnKxZNtG3Ev9Mo4lpK/tQsmYSlz9QF
         YeFHStL8kfw+X8Ez042jqlynaGeMZYh6nsSXdRxtnzgZ2LocnLrm6f3fHP01ESF2d5R2
         1LQ+6h5s1fhRpI96wke9sujpAzw7lv4QNTmDEOWtrFQBfE0l+0knAKZtkVWzg7dMQf5k
         4A0g==
X-Gm-Message-State: AOJu0Yx9GD8muYLpVbFLGQpKBpNFK6/UMcatV3IQNsNw5nRqJWiaJOUw
	sRhcpKaWy3EoXODKB57XvnopfVBNqc2wqurdL4NKlxHtWz+kJYS3X6xRsA==
X-Google-Smtp-Source: AGHT+IFwGCSUfnfn70rzut6BSl/JGQGTGTectLko4wMo1G9k0NWNgP4DspzmXzmXPSkzpRxWQNKGug==
X-Received: by 2002:a05:6a00:8510:b0:705:d60f:e64e with SMTP id d2e1a72fcca58-70ba4783892mr2445017b3a.1.1721144218878;
        Tue, 16 Jul 2024 08:36:58 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d963sm6437802b3a.130.2024.07.16.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:36:58 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Julian Sikorski <belegdol@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.10.y] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue, 16 Jul 2024 23:36:53 +0800
Message-Id: <20240716153653.207824-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024071529-prognosis-achiness-85fd@gregkh>
References: <2024071529-prognosis-achiness-85fd@gregkh>
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
index 3deeabb27394..ae07927910ca 100644
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
@@ -390,28 +389,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
@@ -456,10 +451,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
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



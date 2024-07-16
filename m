Return-Path: <stable+bounces-59501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A0932A6D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4701F22E22
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE211E54C;
	Tue, 16 Jul 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTIF7Gub"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBBCA40
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143839; cv=none; b=qgqfKZjnd16zTqMXAWSf7ftBRqvRU2QvWbNISxbqlpyoZxLIkY8l+/LtF+b8YsaKutDbY4WNXyumY7Hn31/0qfuVT1brxbMCIsVWAVjY34ZRKNi1Bu9Z6TRzX+cvMP6bU7++kf1HXyrknLVkEGu6AsCQPIGKEvteYQITtt31KIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143839; c=relaxed/simple;
	bh=SOEd0XFt5aVs8ymPN3b9ip+m6HDiMvsyQWpJEg5sJsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmbXdRFo/XfdO+tZAmYCCZP1xW3yhhnl/4/GCYtOr704adV4mjnUkmwmmFDjgkJ4ddc1yjg1iZSvFlg9gUlnbeHioSPm1gCmuDiDUJGigIOQXtqgv4EahXTwEdaL15CkY5+Y36VUk4HYEq/Siw2YscIIs2XWYT+yj/k+t/tmrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTIF7Gub; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb14684067so5071955ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721143836; x=1721748636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awK6xdP3zUkIV+GYVfymVhN+kOlSYETqwuA36TdpVfE=;
        b=QTIF7GubHKfbMq/dRw6zNTMKHBXvkDdVa2OzfMQliycmg/WWPXD51nLsbLUKxs89Rj
         UI9grssk1LXQTZC2z5fCf1+KFyYYjsWGjrJGOhfcamatRz7Z+Jkvoe2jRNGBDpePvTzP
         0dL5JWw56cPSXnn4ZrY/oSJWq1aQhcFUoQFJlMOIitSQwauU6lV5+uVb+W9cOxTPgJcJ
         42HiZ4PmspMrYXFFs75Vu9RAC6slE1kHz0O0BcYiFBWcgrBHrvAFijgEM4/z5osjjf5D
         JsmidKVlsFgxCqlgAX/XL9a1Z8p1mGwdvbWUnC7ii0wRzee4JtSjdF/+NoYfGXAsN0tH
         ksfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143836; x=1721748636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awK6xdP3zUkIV+GYVfymVhN+kOlSYETqwuA36TdpVfE=;
        b=bDUmYZ48Ts31yv9kslxI1uLxyujbgHANm3waveQ3867inZ7FWaFeCYdq7gNGUqAqMT
         Vm7AZXfFnpTazUqhHCWFSJ8T4sudloUlgTF2M4WFU1eEErPsQowoLXO89Y4MUG+yr0Cu
         nljufi6xxLVECH58zTbYhP7FmsyhZySH4vNLl35cM3LJM604FrkfXa8SXK3/o/PQfkCY
         W/TBdpotP4q1/+HXVvAJ8r7EEna085nZa9JEK5wiBUKJ6h3nn/C3Q2139hegEoTercfi
         udY1QFtmK/cyyomQjJtRDGO1RcfBj5HhK+IZE25QnmZanZCk01OQmjKng2djf483Qkto
         ZTvg==
X-Gm-Message-State: AOJu0Yya329pSU+XkJ0Am31JJ5RAB9HjsT3yo9RvpozKeCvEbme9yi9U
	FYwirg0RztHwKS7AZfcaYtGZ9AEgXvMiH2SdPgxnkIBMZpV3ocFBvJlR+A==
X-Google-Smtp-Source: AGHT+IGzYW/+JJUTftvTTP0fNmSCND6UQWWSlbRcSijwyH/96+CChW8OvZo2HDXaHZEddZFrQBwCKQ==
X-Received: by 2002:a05:6a20:c999:b0:1c0:e5dc:24f with SMTP id adf61e73a8af0-1c3ee490410mr2525441637.2.1721143836431;
        Tue, 16 Jul 2024 08:30:36 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc2eb2sm59546365ad.108.2024.07.16.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:30:35 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Julian Sikorski <belegdol@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.15.y] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue, 16 Jul 2024 23:30:31 +0800
Message-Id: <20240716153031.159989-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024071528-foothill-overdraft-d69a@gregkh>
References: <2024071528-foothill-overdraft-d69a@gregkh>
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



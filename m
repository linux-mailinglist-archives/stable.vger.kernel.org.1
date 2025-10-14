Return-Path: <stable+bounces-185656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E022CBD99A0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396C6582972
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073B313E2B;
	Tue, 14 Oct 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hqoz/6gc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA72313E0D
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447008; cv=none; b=UX0McSORbb86u/WFnSfTpG34u+xDoxT6gooueMxzqCmLKmMHe08zRKEMkYSCM6KdbLGn3N4+w77hJX3pNrkUkqiARd+ZkQM/jCN7RvARQ/3KgwmmNSIGJ/OqEQE0eBSsxb80emXY+b3eXc/RvXKetX09gJSOBiOgvkE16ieQqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447008; c=relaxed/simple;
	bh=SP2U989xex4C6Fto19vPYxyQ4UBx+cDWFuowar3Zxfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o97Rzvi8stRQBbZk9BQq//5bnwbJv7n4fLd+/4F32r63TzgYU21tHIffsrqjKAJM176MpKtrRKOlUBwPvtHkPuK9EsfeYaUDhEwn52/VoEuqK2xuKjpOs3gIJtI6uL1wF136Gs/3qzKIGQF5DkCJcnUHyYyBmb9GdlgwL4Ct+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hqoz/6gc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so3350938a12.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760447006; x=1761051806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcx2gdXEOdzx2axNlQonr/s0IBOWZwAKq17ub/P7vxU=;
        b=Hqoz/6gcuCXBUA/rCS1nQ+mP3ovG6LwBvGEW9elFmIuIoB3XaK4fh7EAcmkFuz0o/G
         Nmya1SBsSih0L+nMHR2KrirXETUwJuDNQiZeedYgG0crEPFCeKeXBv5ghYEyGUgThJeF
         HsQ8gdVnXIjkWRf1khTdk35VsQh4loBxNJIoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447006; x=1761051806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcx2gdXEOdzx2axNlQonr/s0IBOWZwAKq17ub/P7vxU=;
        b=ONTW0UGn/Y92LBKosFZ9Mw58vV0xNc3s7Bt/wWxWA7LRkgiA9xbO7adD8wopDX4XSV
         y8E+27yYAM5CRezP9wpy/LCp/7NM0rlkDansMlTCNXje/qubIYXunz335+5Or7nFKzCP
         g7bW6MeTg/4NF1hkMuR4ZCxHmf4w/HRg2A7E8aOq2/uJ2kAEcPyyl4KgShIWsF5UjJ4u
         lkqquBQ6gyS80Z33/VUcGh6ySA7yqVV+7T1GFU0mwu8rkDdXKKqmmmvrMtRjTm7pnwJu
         4bI5OQCFHJO2KX0yxLn/ldo4Y3i+I1N+HGk9FCXA0SWkbacTgPGnyDV0Vzt3xqM/WXS9
         1rag==
X-Gm-Message-State: AOJu0YwkpDfqFNhG+dOg1M7BqA7Wy8JIWJIRfZuHyS4Zr+4lKWoVlSt9
	k7uUCRM3qG/n7BXUlM1GFCDc8Ar7/6sidE0ohUZuyVcDNkyeAnxW9dGtmXj4twgmh3d795ag3wd
	aXQ0=
X-Gm-Gg: ASbGncsp5//b8QlT9wvbOJDRYW4HMLCQeShSHB7HPPZLd6UA+ZdATIinfHWkamHvO5y
	g+nZ0jX5huE7Hy5wMdn18lbws6whk9BDDQn5gRq8k9fiqCqQg9lUuN3cO36tKhz5+zJVOR7bdd0
	qzNqWrLqZ1AqhJm9ETO9J4rEl0bfblnyFEqfbJDyano4x1t9MsE6yAKzr/g6/gpWScChLC6/bE+
	KZJ8IXNuFZoQgUgiBOoJISu+rxuvxkCUkPld/br8k3+L/na5+09Bwh2nyGT+lORAeqg5bFiS86p
	w4ezO9wl4xOUChUtPoqZpEzyFcDE+8jrSXKirYZg+yC1Ft3In9thuXo5l181K7Rqx4XbddJGd6R
	3s+B+lX+zIFo30Ejd3frG50zBY2cwgcPed7rct6DLgDkfrYrFgNQmZmCNiAS4D6zOOQ==
X-Google-Smtp-Source: AGHT+IHZODtcpLFAQ8qmfD86hGB8K21J6ff90V6NB6tvU/644nzRccH8t67oRiqnruKfz9jHVtr4tg==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr279849765ad.14.1760447005568;
        Tue, 14 Oct 2025 06:03:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95ecbsm158967595ad.130.2025.10.14.06.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:03:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid recent intervals data
Date: Tue, 14 Oct 2025 22:03:00 +0900
Message-ID: <20251014130300.2365621-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit fa3fa55de0d6177fdcaf6fc254f13cc8f33c3eed ]

Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
discarding useful information") caused the number of wakeup interrupts
to increase on an idle system [1], which was not expected to happen
after merely allowing shallower idle states to be selected by the
governor in some cases.

However, on the system in question, all of the idle states deeper than
WFI are rejected by the driver due to a firmware issue [2].  This causes
the governor to only consider the recent interval duriation data
corresponding to attempts to enter WFI that are successful and the
recent invervals table is filled with values lower than the scheduler
tick period.  Consequently, the governor predicts an idle duration
below the scheduler tick period length and avoids stopping the tick
more often which leads to the observed symptom.

Address it by modifying the governor to update the recent intervals
table also when entering the previously selected idle state fails, so
it knows that the short idle intervals might have been the minority
had the selected idle states been actually entered every time.

Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/2793874.mvXUDI8C0e@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 7337a6356dffc93194af24ee31023b3578661a5b)
---
 drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 4edac724983a..0b3c917d505d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -158,6 +158,14 @@ static inline int performance_multiplier(unsigned int nr_iowaiters)
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
 
+static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
+{
+	/* Update the repeating-pattern data. */
+	data->intervals[data->interval_ptr++] = interval_us;
+	if (data->interval_ptr >= INTERVALS)
+		data->interval_ptr = 0;
+}
+
 static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
 
 /*
@@ -288,6 +296,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
+	} else if (!dev->last_residency_ns) {
+		/*
+		 * This happens when the driver rejects the previously selected
+		 * idle state and returns an error, so update the recent
+		 * intervals table to prevent invalid information from being
+		 * used going forward.
+		 */
+		menu_update_intervals(data, UINT_MAX);
 	}
 
 	/* determine the expected residency time, round up */
@@ -542,10 +558,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 
 	data->correction_factor[data->bucket] = new_factor;
 
-	/* update the repeating-pattern data */
-	data->intervals[data->interval_ptr++] = ktime_to_us(measured_ns);
-	if (data->interval_ptr >= INTERVALS)
-		data->interval_ptr = 0;
+	menu_update_intervals(data, ktime_to_us(measured_ns));
 }
 
 /**
-- 
2.51.0.760.g7b8bcc2412-goog



Return-Path: <stable+bounces-183552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9ABC2252
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07DD19A4EB7
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16A71DFD9A;
	Tue,  7 Oct 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Va5woYDs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507F8F6F
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855591; cv=none; b=HprIjM51YgqmC7CrnIWzTZYSzPRkuImdkWq5BTt4USUq3kYjy+6/Idskt5AX1XURi1xQ86QJh9gv6JyhCVYlEqEY7jlJrnV6CJ9Cn/x6H/gywyMX47dyaR2QHnSZnukDwowXG7lEw+s8UavizzUcxkQX3eWJdEKTVVII1AFih2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855591; c=relaxed/simple;
	bh=EhJj4u2/FM31xduvTQcVz6XExYHLwDq1UOrJeidfZww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fim7OZ38pvIy6oiN4Kzk4Q4ieF9itIwrQgoHjFxzUDq2kJifnQH2ZPxybv7oh1dwrYgWLw1m23IXlnI+F1EztYwuv/3tm/2M8Zq05+yl7GvWXx2NDH5xtcjLh0QtJffuAheh+cHm16vESt3ZsfcGBPwE2+5ysn87NRA+Wo4OIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Va5woYDs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7bc626c5461so2162310a34.3
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759855589; x=1760460389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoI3T5ojCuK3g+q6nF4QTj09iA3MoAZpjXR2jeK81cE=;
        b=Va5woYDsyUQmwY8wAoXAogX6F6YoiKrocnXos6gmSCHAC57aLoZKSoCifWAHaZH2tH
         YqyTL1FpMiPLkT448LGLAGw3euAutlcm5Cx+Gjn5yUfqK2WO0R/1Oh1bokB04JvDkm0h
         +GaAWSyBlBoAR/uPNAbSSTYnr8j5FZoznxlP7HjloAeUOsvBG9VPgldIZdHBTDoiY0I2
         kgb3ZpaKuhdwtebaCkoymEMTRkJD4/S1j68ueck9bABAeXAlL1nLY63yc56dE7G+bq9V
         pmCBwwc9qER/pa9AYeUXEGqNIsWdLiE9u3dRh/nm42uYS/WfL8L4W10PwkHsAl2hueYT
         Db2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855589; x=1760460389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoI3T5ojCuK3g+q6nF4QTj09iA3MoAZpjXR2jeK81cE=;
        b=XON9G2G3a31soxxHfDhyhuc66ZAToOPhSdm2TQJo4CGv/X/Dj7ZnXj3TVg5RqeE93P
         Rf44IidRWGHKN99IDY+zsYW31u4WGZZvn8+BCHGM+jyJWwgOeuWNzr7nCYSsn7ijkABX
         s8W74dhWVvXvz7k0N8C0P/0RO3zYjQxcyrP6/UF1jJ75Eq8zJSEr1QpU6J/wLknEC10G
         4F4glRZ38noA8hBKDKmOTTM6rS5VaT1zymoxuopfwo6qpR+LY+OH8VPCbQGlyHTryHwX
         uGE78sp6c5WZY8kibHPr7a5QUsmBHWoHAaDXFw9wLyb3WXg6PWEIhJKKzHgkV4OkGVIY
         9zlQ==
X-Gm-Message-State: AOJu0Ywpim4wzPEJE4Poxx+KYkov4SBJqxuOenlmpavt5QwSCy3L9s30
	92ZFo9yWA++BxFlArPRdpbLcgXpbpSJTFZVYMf+C8en/hSGRMsvfMymiTJTE/lwT346nYyRZ0nH
	nSkzF
X-Gm-Gg: ASbGncs5WrtYx+PS3QOtGDufkAd2ZcR30tQh3O7cWgj17JmHCLSksLL9Pe/QYQSEaw2
	eBpytjJvn3TAS5PRWmQHxtQJwA4nF3d+a8v2Addzwl8yw1uRP36FkTqoHvR9AnSskUPcgiDvARW
	RSQCjgpS/A9m+1yVoPUTwWhmzoyGv9clZ30ccu87EPxLRbvMkSXCDfnIvOMSuIEDrGTu0A4mK7K
	Ec8rbWNZ6dqyGT/dzvCIOWRlrdjtDqJ5r9mkDbA5qKB4FWRi0psTGmAysoN3J/8smMCL4PsJZxI
	w/pyrWFywzHhOUycWcFCL7pwkg8CMnqvVSjw9w9BwUS23UM7gg9NO/Dl7u3a5XUHmac0gG1fB7F
	4MJApoRAquUbJ2ElEjXP2CSxhnA4LZO7L8g==
X-Google-Smtp-Source: AGHT+IF17yyolHip4UwbxzD2TKoFFQmQZneFN/IZBpsccoqFr5kjmsjLK8nWRlU1FvjLQJZqz5HEpg==
X-Received: by 2002:a05:6830:2aa5:b0:748:cb4c:97fd with SMTP id 46e09a7af769-7c0df71656dmr287160a34.1.1759855588749;
        Tue, 07 Oct 2025 09:46:28 -0700 (PDT)
Received: from 861G6M3.. ([2a09:bac1:76a0:540::22d:10b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf43028b5esm4807403a34.25.2025.10.07.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:46:28 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: stable@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Peter Zijlstra <peterz@infradead.org>,
	David Wang <00107082@163.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH] perf: Fix dangling cgroup pointer in cpuctx
Date: Tue,  7 Oct 2025 11:45:52 -0500
Message-ID: <20251007164556.516406-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit 3b7a34aebbdf2a4b7295205bf0c654294283ec82 ]

Commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting
bug at task exit") moves the event->state update to before
list_del_event(). This makes the event->state test in list_del_event()
always false; never calling perf_cgroup_event_disable().

As a result, cpuctx->cgrp won't be cleared properly; causing havoc.

Cc: stable@vger.kernel.org # 6.6.x, 6.12.x
Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 kernel/events/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cc06ffb60c1..6688660845d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2100,18 +2100,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
 }
@@ -2456,11 +2444,14 @@ __perf_remove_from_context(struct perf_event *event,
 	 */
 	if (flags & DETACH_EXIT)
 		state = PERF_EVENT_STATE_EXIT;
-	if (flags & DETACH_DEAD) {
-		event->pending_disable = 1;
+	if (flags & DETACH_DEAD)
 		state = PERF_EVENT_STATE_DEAD;
-	}
+
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
-- 
2.43.0



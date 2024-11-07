Return-Path: <stable+bounces-91812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABC9C0601
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0459E1F22E2D
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979A20F5AB;
	Thu,  7 Nov 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIHFXHOr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74920E335;
	Thu,  7 Nov 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983288; cv=none; b=HjdpCE0zXUSuPI83ORNmpDgp8otBwZqkoNzDWNrKvULTt8nxlEfDdTbAcIR8t0SzheNcjIA5y3Oh0wyVV82tmpBIf/5ZvwYgAlxEXtOYA17M1cqITR+EMbFABdaHpLnGM7WaJPlZtLQv4IYU6H1mRN4q+FTNQwkDd3CLnkkmEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983288; c=relaxed/simple;
	bh=eTTTENaIGNiTLj2YunjZefAQuF22mOyhiCx5w9nZZew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttWI0UlbzXtT2m2hmoVpQhzpyJDPq4LoWnpdc6pxIIiocBnjr9+zKh7+Nsyx5v1ig26EVyNucObL9ZCWSBKpVva4m2yWJQk82llGuehVsWd8AU8bxFeQGEswOGJo2Vl+QoJiFDHV9/mzSQUj4kVWbmDSQ4am5H0032J8TMfktw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIHFXHOr; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20cdbe608b3so9267655ad.1;
        Thu, 07 Nov 2024 04:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983287; x=1731588087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2CJ986UJvVOmnYCWRFgLTfaGLueWOJGgrSGwHXq3Is=;
        b=kIHFXHOr0EtakkTcCtGF6OSVlDqVsdklA9JeCUgzsrMbQXxe6W/I8Hq6p3qvPf4OGR
         8Wu+X2Ux+DkQ9hYf2g5EOmGd3R+E9ypOxvck0xuRRe6s/Fp9i/yMV2CHO4X5SqRKfRkA
         4+UNJrR4ejvZ9Dras9z9NL4iRxDjbtdOb6sPql/wraQ92WQP2e/QKjVgdfXqMMr9HgIx
         E9eWoeEQzt83cOX/EDmZlOEfLwgx2giS/zj6cdy8C9fzrLm/0lUfuRf/82Em0phTSREy
         S3/lAr328kbsPHxQTLTPCz/sXLClft2JuCK+o7tnPp5IRKFh2DKetBeNRj8HhEmddYv6
         YYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983287; x=1731588087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2CJ986UJvVOmnYCWRFgLTfaGLueWOJGgrSGwHXq3Is=;
        b=ZLv6o2HHmetv0ULJKsyurx4l2qHizZLIQ7nmeaFNKDEjMCgYzAGjJTdpFAMqnRJpw0
         ScZf3V9wrOQGn6n1kOhTmLyfZ7dcDFTEU6dEnZXmTC2VY6tWY7Z4oN3a+E5FY4ylHry8
         O8zpTiF1leQY6IyBs2894yYciNpDRMuSrf3fapUUNIluGk3S0KCY+87QtYHLO5tpSveA
         tHdUDnu+JxBIeAKkzoyV+eisi7LavFbvyMN89LchZbW1ujwmA7HORUntOf4aug1YkoGT
         saGkq83fL3zUk2m8r5y/z98SWXhgY299e7tHzkivM3quwepiEs4iHwq1Pv61eGse2y9U
         +Urg==
X-Forwarded-Encrypted: i=1; AJvYcCW32AaPb08H7zFO0DWoq7lTbZWTvOK3m9r11Lrx+BtKd9PTks4N1rOPPSZrr2XrSkfuTBRnrZEFal5gmRw=@vger.kernel.org, AJvYcCX2gLzuUAdly01uGst/sp2LUVL5a6hg7eyzC+7WeUuiLcPyil0t6AGnl8Kjtpeokw3rpqaDUxmV@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQ8V9LXRWWG9ApYxfq51aY3OJmcDEkTDUL9s9My1BSmU6zNuc
	3I7LDGeR5Mvg0HVgn1g6kbFS/Si0XJMgL/DAHrSZcT+ziU8hZy/e
X-Google-Smtp-Source: AGHT+IGnJExR3DC/2QmwR+Z4/bRRQ9XGraI5dktdBuzJBr3CYwDgrgMxEs3TmN+2BvNAJj3RrnQ0dA==
X-Received: by 2002:a17:902:db06:b0:20c:af5c:fc90 with SMTP id d9443c01a7336-2117d46ca7dmr8861825ad.49.1730983286612;
        Thu, 07 Nov 2024 04:41:26 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41480sm11130145ad.116.2024.11.07.04.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:41:26 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: fix a possible null pointer dereference in setup_zone_pageset()
Date: Thu,  7 Nov 2024 20:41:16 +0800
Message-Id: <20241107124116.579108-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function call alloc_percpu() returns a pointer to the memory address,
but it hasn't been checked. Our static analysis tool indicates that null
pointer dereference may exist in pointer zone->per_cpu_pageset. It is
always safe to judge the null pointer before use.

Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
---
V2:
Fixed the incorrect code logic.
Thanks David Hildenbrand for helpful suggestion.
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..7c8a74fd02d6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5703,8 +5703,14 @@ void __meminit setup_zone_pageset(struct zone *zone)
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
+	if (!zone->per_cpu_zonestats)
+		return;
 
 	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
+	if (!zone->per_cpu_pageset) {
+		free_percpu(zone->per_cpu_zonestats);
+		return;
+	}
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_pages *pcp;
 		struct per_cpu_zonestat *pzstats;
-- 
2.34.1



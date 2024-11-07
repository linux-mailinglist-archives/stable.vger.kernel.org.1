Return-Path: <stable+bounces-91791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB1D9C0429
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FBBB20FF3
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D720ADC8;
	Thu,  7 Nov 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGc+dlDE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB31EF08E;
	Thu,  7 Nov 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979298; cv=none; b=ivpXk0u/CVy5qVpq55vEPhInPUmJ2iTEBPNHdnzajnTSnbvBx2AfokgwLGTBlGXgJ2uBQubVY2T/eWfqy4/Wj8IcvaFTDYMwxWvtY2vIaWujBqQqWmibyEmfPOxvvUGb6G19AdKL7mWMPbq5u0S0Z0zOvL8zMZZf4r2udUhJGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979298; c=relaxed/simple;
	bh=K7soTtdEbgLyUgd3YyhFr+fVUqxcAgOhY+90JQtFwnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XssHtjbGXabx2DVHTwVXzncN+MCzwoUrRLzkrRQEcwKOsjr7GJwVgr2d3HDYSOPVw+NShvJcNzw7PIlwymMW0m5fqnQXQJ4kGkbCsgkNK6FXqW/7eVvKcfZm8MaMHpHAgTwFGt239pQ9T+a4rk4qOXN3o9mUSg5elTtx5J31HcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGc+dlDE; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c805a0753so8700365ad.0;
        Thu, 07 Nov 2024 03:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730979297; x=1731584097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTYKUcTQxzsh1mvxH/LAhn9PQQYcWg2Ig+zmw8mJl8A=;
        b=XGc+dlDE0Zu2ls9+zBy26tPU/9KAxlwoYVzrgJOAuH1H3WpKXBB4KaHJRVwVMJgWpS
         1e9vLy5CtoTF3H5DZXBFYm057UCo5m2eWNMkyds4O6LSp092um4IgG+0yN9geE1sn7xc
         eUwNZnkkL4gqNICNcvlTnpluBQy0faDo4jBPG11FHAdo0+5pZVScjbTpbZdSVk2s2kiD
         wkVpo+xHIKEGyAKsqSVkWtXlajZmnyn5xW5uFlu/p16FVJPikiFude7YUVy/d9nN05R+
         KBwT91he/vwidttfJ9LC9kgxrZqP9g8v2OhrfVoFn/tb6v3zBVyrYQYxkWGdI+ufjyZu
         FzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979297; x=1731584097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTYKUcTQxzsh1mvxH/LAhn9PQQYcWg2Ig+zmw8mJl8A=;
        b=GSo/PMINg5aNsPGHnWsXm7oAn12kYU9ye0cKYuLRMJQ/fii5WEhac/9XlT9bOVgj8m
         PcuLcVKpaPrzBz6vPpX3jSGPbOME+xc1ZBzAQw1lnFrcXHwZYGCDLIV6I7uMZNiws3Wv
         GQZQUuA86ohE0XiustvPAPnvOk07t0X8/+OIPCpkk90+rINpDWaBIKiXQNI7qmgWONHi
         qR6LCk9dZBw97LFqShEPgRxYk7fvdT1KKCJQ80ZpCFFhQDi3+Sr+8Ej7jVhk4b9YOBKH
         wDwjni3UAtKtRlsUDbhdn9YAExLRd4NJ7C/2UZFWgEofvbf7j6R5xjsY7PN2bkQJ9Pw0
         gZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXRbFyGarYy9+/7omfqQcjMImeaJ+5+jSwWTDW+NWdmZa3MSEee3mKeEYI+CCdqPDu9IFNA/bWjTuQ5ffo=@vger.kernel.org, AJvYcCXmUZrDUo/hVki4DyK2GwAkkDMac1VAaXMaduJstEKjeoG6mf4RIMPGZFCzAub9+b09RdCV+iyT@vger.kernel.org
X-Gm-Message-State: AOJu0YwnkcJjNtUNbXQU2p6Qvw9ate26SDbza+KXk7LDB9IC2rCKp/Fp
	zfsPVwkoReyeOy9nQT0/ahNjvX/+z1whR0Rru2f8DS4LCA6W0yEi
X-Google-Smtp-Source: AGHT+IGvgdSx6cMQf4xfAmvWvUZOtcDEpa4o5ogRI63GYMC3f7X6zRi2BnG+oJpEXC/zMSNMxc63JQ==
X-Received: by 2002:a17:902:e886:b0:20c:d578:d72d with SMTP id d9443c01a7336-210c687963bmr575517765ad.7.1730979296673;
        Thu, 07 Nov 2024 03:34:56 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59486sm9808255ad.204.2024.11.07.03.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:34:56 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: fix a possible null pointer dereference in setup_zone_pageset()
Date: Thu,  7 Nov 2024 19:34:47 +0800
Message-Id: <20241107113447.402194-1-chenqiuji666@gmail.com>
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
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..5deae1193dc3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5703,8 +5703,14 @@ void __meminit setup_zone_pageset(struct zone *zone)
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
+	if (!zone->per_cpu_pageset)
+		return;
 
 	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
+	if (!zone->per_cpu_pageset) {
+		free_percpu(zone->per_cpu_pageset);
+		return;
+	}
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_pages *pcp;
 		struct per_cpu_zonestat *pzstats;
-- 
2.34.1



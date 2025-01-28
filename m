Return-Path: <stable+bounces-110944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D4A207C2
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CE83A6AC9
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E14194A53;
	Tue, 28 Jan 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLkn56K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487517A586
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058149; cv=none; b=CvfWpooy4u+yWut/+3GZhvawqd6GWTIXy18h/I8wj57+5o6S6pg8ySigsUUNhAskQKz9l1jg+x2nCxNNdrVlHr+nnFOQjUmCRh9ejxYSmH24xQ6OiBytCpU2eoCIxDTerZ+xyOo6ZkPwbNd9uFsAvh5EKzdwln1Rptgnfq/0eDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058149; c=relaxed/simple;
	bh=NnpuNYeJBuuHUKwNd1KND3SH4FoZCvGxli10f+PKEW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2l+bZYVsgKzhUsnMBFKCKsJdY2RupbbiwBrHcC8xwAXImOAO5RYh6IGIqB1Co6G6jx5PJ+hLIAl81KA1efZhKtyH0gDlvg6DXcMVplPj7B/JiNIzSjlI6ubtMFxxutAgKmWCWg/+oCUTHgeIchPDTC4hP2dyZ6HDzL0oMTK4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDLkn56K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so118376155ad.2
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 01:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738058147; x=1738662947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR73JREcMM77cKYf1hrqQ2m37JiPwgtQb91oVMX/AGI=;
        b=hDLkn56K02WMFVQLDSCfOpQ1jqAC/wI2YnxjmMWiuicaxylfxKk/mW+2ACtljw9Wqd
         HtQBsh4ZC9k9ntnM7irYdXUFUN/W7P4RoN+7fGcxGtxxBv5Z/so5mPfaCNd0fFgYzWdR
         AoJFyq6p+eGV3vG4BCjG3kwyBdqDMJCstEzKpzVG+DwTsoyFxJd+KGireb8yBBs0Y1XT
         KKuvI5A6aEpW5anCdbxvely55EiUux85Cu11Ti9tXLR4XqBcHdWJ3OtOVz3dCnHAedri
         3uy6Zb8VBpEIkSeK812fo4dtiHywGA/YF/tsAy+Kildxv0/JBbmi24Qo99hkTNQ9kSVb
         fiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738058147; x=1738662947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR73JREcMM77cKYf1hrqQ2m37JiPwgtQb91oVMX/AGI=;
        b=fadPLaZ9MEL+oEuzeWSzxlZnOKM532236grSVa9Wrcwhg9ROiLtGevei9VLAAuyyjt
         B15bTb2DDZ56b/qyR7WjWNkWoYUaetyJ1qQAoh5nzHM4pFcqFN3R0/OnQs1CHAZFaEm7
         XFVTqxifabECkBgPcNHJIzVIN2xC5NiRQUqxoI6v5ph0yIy4Mz7IHn4CwYBgmBip2/8y
         D6V/ydfYJvjRj9oIu+zIGpocEgdYp3/uYyz2McE9V+Y57cnSszPCBBPJUsKLavHrIN3j
         wYpG+Go9WpN+HPdZ9wdRdDKJj+NAY/rLVyQ0q7iuos6Dt4upx5EL5zL1vzv4mE8iSEgg
         sV4A==
X-Forwarded-Encrypted: i=1; AJvYcCW4N23i+QKBSxqkDHT59PoyimqCCYjt3fq/Oy36cnUSOKO6TYVATln/B2JGuK9pFBI79VtGNkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/We7KRtiBpiiZcqSsS0OCFOYMlgSzPj4wCnjpsV33BEis4Qz
	JclOqpksz7iRK1uR3OJVwXpNL+VqmfaSxbGaGgH4dz22nwtT5m5u
X-Gm-Gg: ASbGncuoGv5KsmbrF93vBgw3zeLnIPUPXq6SKUdm6rwaCXJPmWZA8hU6Wwmt8f2gwBY
	xtMRD2xU1G8L+jonHfudCQNYBf4r1x/XmPJOD2W8pwcE9Ju0qaNgRzUcGVsEQET5qDVfe8n7hZm
	k3pikINvdvP/t6sY4lorM+8ZW7cKTI/saI22yBUDi+nRY7UsF2fxos6mZCthckvCv3rwzaGpiAP
	AnzK+6hbmq2UJyD1UIXTV6AXDS+FbMIC486t2VgrkHl/lS1BbEZJ2fkGnY4eAAHyknQ/7ZaBS3q
	w1crddwyP1JGpF3cCWBtv0kmejEH/JzfVwg=
X-Google-Smtp-Source: AGHT+IGF+2R5lm3XFjfG4YmOPjpOVRqm1WJ/6wHrONmPyCPM9NFm8WFCD7ChZkvpHZELLWRSX8qHVA==
X-Received: by 2002:a17:902:e802:b0:212:615f:c1 with SMTP id d9443c01a7336-21c3540a0admr729176155ad.14.1738058147018;
        Tue, 28 Jan 2025 01:55:47 -0800 (PST)
Received: from hyeyoo-laptop.localdomain ([221.160.193.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424eea4sm77697845ad.238.2025.01.28.01.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 01:55:46 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when zswap_store_page() fails
Date: Wed, 29 Jan 2025 03:55:07 +0900
Message-ID: <20250128185507.2176-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
skips charging any zswapped base pages when it failed to zswap the entire
folio.

However, when some base pages are zswapped but it failed to zswap
the entire folio, the zswap operation is rolled back.
When freeing zswap entries for those pages, zswap_entry_free() uncharges
the pages that were not previously charged, causing zswap charging to
become inconsistent.

This inconsistency triggers two warnings with following steps:
  # On a machine with 64GiB of RAM and 36GiB of zswap
  $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
  $ sudo reboot

  Two warnings are:
    in mm/memcontrol.c:163, function obj_cgroup_release():
      WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));

    in mm/page_counter.c:60, function page_counter_cancel():
      if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
	  new, nr_pages))

While objcg events should only be accounted for when the entire folio is
zswapped, objcg charging should be performed regardlessly.
Fix accordingly.

After resolving the inconsistency, these warnings disappear.

Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

v1->v2:

 Fixed objcg events being accounted for on zswap failure.

 Fixed the incorrect description. I misunderstood that the base pages are
 going to be stored in zswap, but their zswap entries are freed immediately.

 Added a comment on why it charges pages that are going to be removed
 from zswap.

 mm/zswap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..10b30ac46deb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
 
 		bytes = zswap_store_page(page, objcg, pool);
 		if (bytes < 0)
-			goto put_pool;
+			goto charge_zswap;
 		compressed_bytes += bytes;
 	}
 
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+	if (objcg)
 		count_objcg_events(objcg, ZSWPOUT, nr_pages);
-	}
 
 	atomic_long_add(nr_pages, &zswap_stored_pages);
 	count_vm_events(ZSWPOUT, nr_pages);
 
 	ret = true;
 
+charge_zswap:
+	/*
+	 * Charge zswapped pages even when it failed to zswap the entire folio,
+	 * because zswap_entry_free() will uncharge them anyway.
+	 * Otherwise zswap charging will become inconsistent.
+	 */
+	if (objcg)
+		obj_cgroup_charge_zswap(objcg, compressed_bytes);
 put_pool:
 	zswap_pool_put(pool);
 put_objcg:
-- 
2.47.1



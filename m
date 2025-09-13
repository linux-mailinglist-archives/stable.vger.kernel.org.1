Return-Path: <stable+bounces-179536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2FB563AC
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FA174E00F8
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27432C026C;
	Sat, 13 Sep 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKfXJJNW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B597237707
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757804704; cv=none; b=NYY4U63HpC9e+/swGt7a1QkizPf27d5WyyNlYfjJA3WtAJIW6SsBCO4OnHdCEk8EXqZYngqy7Epi9GXos6azmYc6J7lvtUlawuVl1GdVGKDf3nPwtaPM3pYZRmNXrQfosow1b+D+HNs5c10ztugYJUbz4PDMv1UKGuiQxEK50G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757804704; c=relaxed/simple;
	bh=bg+2y6VWcFyBc5Dh+7LpltEIwojxmZ7utLrVrTgs/PM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MPOa+nDmBCszLDJpx5TpTz9pYp8WsNDahcHd8+ccU55mBw5eVmZvKId4uTRDeXAfeIZWwUXzD4vnFj5NwHNR25UehS5/AwaqeukOa2+NWfPgDC5VkNWn9V4OIkvkcyvKApfxFMGijRbM7gZ7N/7Hbx6YcIt9aDKGjBNqLJJDhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKfXJJNW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0418f6fc27so522650066b.3
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757804699; x=1758409499; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=33F7J4ARNlzAnkIZr8vZOyV8U844Nm1LNNk0DD954rE=;
        b=GKfXJJNW5rdI4XLCw+sN8vg3C/9KgZTcPnXqblVt+fz3sdsKtpvTs6rY/E7VUDN3ge
         ApuKQG8bC+tI6GyXAndjhtp+CiPZiv1RymmvK11GCIKL/OYC4O0Exf5QRAyzj9seHW/P
         Ht5ifwhFCEPbjG+DWtvE0snjbQtgInjdwihiLBZfTrX3UdxogIslkxyol435jGef2CjC
         MkOhwp759YJ6NSdPgPWRYBVPC/dOyTFkbzfoWAMlHKHRPxf3LXic2HC0mV49uy68f/qj
         6BrwZKLfygmu5bpdofWZVzkBn8q+2LKrT3fp2Dcm+JFkZ+9TVdXBk6qoE355YuIlqjqF
         vPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757804699; x=1758409499;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33F7J4ARNlzAnkIZr8vZOyV8U844Nm1LNNk0DD954rE=;
        b=S1xYsUyn7rPlZOvMHjP/WUKOi6We6FOM6BRY0KiYf6b0Ox+z31ld6Dy+p0YBXgJh98
         pQJXYPKskAMo/em84oUe1YBz/TOp4ZmMP6FD44WrQQ8X2Xm2b+CCdpSKe6hM9Nr6uryn
         xVPXAFRny2VI0Nfbh9JFdsP9I1Nk5r6BawtaLHU8RsvCvyi4KRcUxeDQOJkc44GjtZpN
         DtQYjorzu0fYJ5MyF5ojZrVLojknkTWuXWFKFLhjMcFJw95EBUtH1dMYkB9TsG5UsvJE
         y4cqlHssUXJ3ojGtJlT5aeKFXJU1zIJOSB16yaUMvX9UPUaKkhx4qO/Se/bFrotrFS+n
         4PyQ==
X-Gm-Message-State: AOJu0YySoInuhi2rSXtmKBe26TLVGArFNFlVnHXT0WBaboVmTfh1do/J
	A6uFygP45PdTmMHH81Za3BpqUu0aWyu1jiDCyLWJhNdowcjKB6mqSBL8m7KIcg==
X-Gm-Gg: ASbGncvZZjIkW9GrSPwJ4ocr7byi/N+BwRv/PUXZJqrqac/T7yBuMLqDMJE435Cruo/
	kPQ+iSHfioMkMV4ZjqqwiuCY8bvCMtiY91izeNfzJE5p8+vh9+0jO39P+iDku8FxnvR6NYo02d9
	kqtPIOYP6HlPhiWJe2xqElwRj895aqECtlVDWvPG3iS8aUS/8SAbRl0e+5sspwLeSjS4ualvIMo
	hyzcT5CiTqlrkHi228C/a4iF0RR+zf6Ac+iHEAaxG90ZDOdrDuvEQfDTsk9jwJg/6Fqa+Rppem5
	0rSmrvvChEu1dZq822me7V/Fr4KI0naQraLKi+P4TXAOLb1ALsgFbwOX76Xh63IJE1XGO/1nXVo
	XYNWtGbpdDIosPAKGJViCVa4wiv+PKvNK
X-Google-Smtp-Source: AGHT+IEgbiN/WY3jZ2PF1SlP71/tDTKwJQRdLUukR4hC0bpUgxC6pbF6sGDRKRh2ac/Q8eq96LsAdQ==
X-Received: by 2002:a17:906:6d13:b0:b09:c230:12dc with SMTP id a640c23a62f3a-b09c23013dbmr208234566b.8.1757804699057;
        Sat, 13 Sep 2025 16:04:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c337e785sm466599966b.25.2025.09.13.16.04.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Sep 2025 16:04:58 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm/khugepaged: fix the address passed to notifier on testing young
Date: Sat, 13 Sep 2025 23:04:55 +0000
Message-Id: <20250913230455.17170-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <2025091345-baton-doorstep-d211@gregkh>
References: <2025091345-baton-doorstep-d211@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

[ Upstream commit 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf ]

Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
mmu_notifier_test_young(), but we are passing the wrong address.
In xxx_scan_pmd(), the actual iteration address is "_address" not
"address".  We seem to misuse the variable on the very beginning.

Change it to the right one.

[akpm@linux-foundation.org fix whitespace, per everyone]
Link: https://lkml.kernel.org/r/20250822063318.11644-1-richard.weiyang@gmail.com
Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 511499e8e29a..e523bb938118 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1363,7 +1363,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_young(pteval) ||
 		    page_is_young(page) || PageReferenced(page) ||
-		    mmu_notifier_test_young(vma->vm_mm, address))
+		    mmu_notifier_test_young(vma->vm_mm, _address))
 			referenced++;
 	}
 	if (!writable) {
-- 
2.34.1



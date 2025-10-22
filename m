Return-Path: <stable+bounces-188971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC44BFB7D0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C87074E23DD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE732779B;
	Wed, 22 Oct 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8rBLIzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F541326D70
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130649; cv=none; b=o6cNMAuYxk3UWwnimHV22ozs/TvWwlnSx/oKkFlcUoEzf7ipw6WD5A6raBBT6nDPTjYWGE6xnqhsKbUvNEpsfaXA62znVftrslOr4uUy6AItK1sZdHfMO/xpN+/AJYeRiNrwcKgmyfBwio+dowYnjjhIXQu5Ke9f6xDSn3a5g5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130649; c=relaxed/simple;
	bh=Bm+cJgJrGpbVpo2k4DHQR58J+3jHfjbzIIQ76OGCebU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRlg86csYAAFFr+P8SX+bKj6MQ6Fu/Tcw6a3E/2RCh5PEc9/PCBrqOGR1vwr0Y0JaJP/boxEosTTiUh2y2uS22FkJVrDi39cr64cBv3rGdJ5ufl8U94SHbBDYgng7wDEuWwzHefZELpuQGuW97AHJQJMwOIM+aaCtIThmZs/Wkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8rBLIzo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f343231fcso4577813b3a.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130647; x=1761735447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk2BPiYFNzn3CXG6RkzldSGrwb1ZpVic8o4pFAU0ZkE=;
        b=A8rBLIzoqevJLIFI1ChgF1XZV+SVli+A/0eRmOvhnv5gLj/GyhqXXKFchjPqKteESk
         clh3X4FaO7E+dVPaIkzjuYQ6rWgYCy7TcREMxj9FTtEHVIrBNC7WMi0mRG0xC/OteSdd
         C1/R4QZHF00kkGQgMryvryGiWS362CwqM/AAzrpfnpwSqBS1K6gTk5xatA/MkLA1XlFt
         rk1XZYgoTHO65Z08OlPkfLHOKK1qXdfNoM9BKk13p4mk9tiqikwd55g/A/Er7tyVNzix
         2cgD5RO1f1zeE7i7FrQLJtBpDC3F5lIMEViSu19d4f2ORsGooN/SBGA8cFnJs2h1EA2W
         I1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130647; x=1761735447;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk2BPiYFNzn3CXG6RkzldSGrwb1ZpVic8o4pFAU0ZkE=;
        b=GCB2mS3uidP/20WN8xfAE51onPGT7bY1tSKLmhjXRV9u2MKj/L6pQuQtm2RyJp4myT
         IbN+jTHGn/TaziaVJsFCceZu5+035tm+OCcdqo0nD5YGw6F5EzLazzRUQee+ZFbIMstU
         fwV5L8BlPzv9PsAm8N8W/kpegF/+RwNQ48glP1DqDmfHlvYxFSNaou+BnMOuEakxR6ua
         qAsX4uKQRL7V15QJKWnv06uiA9jASnzAtqCOoxpZbAJCrOrcvb1TRTR/A+OLZFqgcYMD
         pjfJne2mwZEYQLHhj4bYW+2n+snzB0VW0pbT/sE7lu9q+EPiCOwl+8REv/l6pdxw8klO
         Hoig==
X-Forwarded-Encrypted: i=1; AJvYcCXPA/XxETdbiG86769Um0Kn7KYezUc4UGLO7YU/LrLhI9DPlAm2QW4OwxgLA7B1XjmhcfjGX08=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRI4JwWQ3qdfB/q7t7vhFesBWxhTtZu54EnYCEEYAQC6MON9e
	EJLLzcfyfXLXAvNuzNif/eQW2JEwK2puCJVXPyChaKTaq70Kpf3HrAH/
X-Gm-Gg: ASbGncu0GXnj2Nn6KJM8Jamq8w82+lcNbjFYWnR51DBi6ujkgMRvXbZoY1KuVGTjmnp
	FPSTtmyV/zggFMTBu+pkB8lpXGThDoBfA+I070Bk6LNx8v0ThbitBqW7DkvPaPYfNTxJXopVRHQ
	8aBIjpTGQY804TuDVIfjOy1H+9Xb1ctQcDtn0zMRLWTHAqphSqCtQcrlxfFMphpqt8m1DawnBxD
	bLjosdxYNcCDtJ1weMXh+DkGqxgBZdHaE/mK/CZpG4ei5jRxrzl/wvJ8Tic1FBoTisYAxNc1fpI
	AITFpYSaZIBdyxVgCTz/qfnwp9ZWKeKHmilK0p6swONDCmkawua6ei9QI5IXfSKEw82UVylKj5e
	P2JYst36+bJfCopHsqU0BHdE35JGg81rhf4iC3+pHC2HPpq8Bwog5llYGCuz8lLq6LN97GhMU75
	JptzEeFxb4JO/NFm9C1xF3q9cU3Qwa97M=
X-Google-Smtp-Source: AGHT+IFWysXp9eqMZj5Qi90FK5sw1pd9AH0StflzodduEPErD8Q0fn6Hmz60MpZnfpCZjB1sS9bTuA==
X-Received: by 2002:a05:6a20:5483:b0:334:93f3:9b28 with SMTP id adf61e73a8af0-334a8644249mr25233224637.56.1761130647394;
        Wed, 22 Oct 2025 03:57:27 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm13346482a12.26.2025.10.22.03.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 03:57:26 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Dev Jain <dev.jain@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
Date: Wed, 22 Oct 2025 18:57:19 +0800
Message-ID: <20251022105719.18321-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The order check and fallback loop is updating the index value on
every loop, this will cause the index to be aligned by a larger
value while the loop shrinks the order.

This may result in inserting and returning a folio of the wrong index
and cause data corruption with some userspace workloads [1].

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>
---

Changes from V1:
- Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/
- Remove unnecessary cleanup and simplify the commit message.

 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..7559773ebb30 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		order = highest_order(suitable_orders);
 		while (suitable_orders) {
 			pages = 1UL << order;
-			index = round_down(index, pages);
-			folio = shmem_alloc_folio(gfp, order, info, index);
-			if (folio)
+			folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
+			if (folio) {
+				index = round_down(index, pages);
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
-- 
2.51.0



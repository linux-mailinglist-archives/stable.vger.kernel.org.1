Return-Path: <stable+bounces-59156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AF392EF85
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 21:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E808287878
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45216DEC0;
	Thu, 11 Jul 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcg8rzW4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01B1EA85
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725603; cv=none; b=eAB50Mls5ZRmxYkoXDmupQoIGyaQ8ovSt1x4pSZd3/nZrHxew56MnNdFX1OnAXXv9CHfaX0PK1mRfbACiUt4zlBJMsaspKa1+5NS1ttUwwDKhb2dlR72CTPcG4Z8FFwiJ1YtX7qT+ugMLl+H83hdBl/hNhnWm/CWz7zNUyBj89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725603; c=relaxed/simple;
	bh=zR0RnM4zVJ2SIUV2I8MOStgCX4eKGv041KChLuf3LwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kAskoqj6muDv7OmW6XEpLKm7shwllp8it4ET+Oaf2nDlF9Es0D3JLKCIT3i1+SeYdABHImY+hXDRHH05gmr7Flpl9uHSFY0407Mqm9466VtFo2SacSa+hqIcNqJ5xPFblhrNNpM+yDfQNh58qEy79P6vkXp0jhR/QnzlJGmm63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcg8rzW4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so2210099276.3
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720725601; x=1721330401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0IJBxGEZh8aIDvEw0KmFnuORNT4a0CNIuPo7E0B6UQ=;
        b=dcg8rzW4pm4jC0iiuqKFwzHcTtODMWLDuSf82IEnmoNsDeaDPWiiRWGFC6qDc/rxU0
         o3PI2+FDhv0uq2aMBBCFR4Gs739QH8WYh3rIpnfDMd/6qI7bgZ/3yIdjctVKLe+Fnece
         Bwk0KOgqJh/O9ypH4c1g1g2UYfpB5/E+Ln0j10okRxFfhcrylUuNRv+oN9ewcNR/Qv8L
         KzhIkB86jDwgagyuFF+IcwRlvVGm9neb3+KmE4dI9D5m+A2Kpg86mREOjx5RpESvNDVi
         g7tuzb9HdWJuIGcDqDj8XwVtuFYs2SaG/vB/8nZcNawMJB4eZls6NTaIyj8Bl93SEDq3
         cObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725601; x=1721330401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0IJBxGEZh8aIDvEw0KmFnuORNT4a0CNIuPo7E0B6UQ=;
        b=XDiL1eQbmrBhWTcqja2cOmjz2MYmuvBkSU2Hu72NfosZ6j5Apuy1qAQz2MAKqAWfr3
         62FaT8FmDTd1b6uTQZqnt7uxvqCqOYqbsRNQqrnP9QtKBnj38JMOLvNsdWqOdV4fYkMH
         yJfRPnKoLbVlmuxN5WgQZADXFMYzAI58UJcnZTcRUpn1eDxl7tqQOK6UgmK8P80Fw0XX
         tvCyyckAiEmYOClAR7IRsINbLDVSeYhXeKkzUoEgfnk3EpWgycYsmXql3/oPCoeN7TMm
         cly2BbsB8EG2ua8Vtl/I2yfTA/gX2XmXODpLHSHAbl/vKR2SkB6PrRvWyEqUwvIwJdZu
         rWFg==
X-Forwarded-Encrypted: i=1; AJvYcCV6lrEkzPceYyXVfJV8cSuYJpk0BZJSRSqe+tsGGeoM2EWnCwrdGprBglt1xuUNJ+WANLgmrWOWsQRiZZRkoaFccvBX4X1w
X-Gm-Message-State: AOJu0Yz2OexVj8xoDc2AFZxwsoVCiQcsk/pog3h+KBo971jtxyUq9Ere
	EtthhlVhotD5ZqiwZW7hyFkzJo/4QzuU0t3Ugtw3+cA4M03aLdJInOjYA9xDC5UoJD6zdigDmNH
	WHQ==
X-Google-Smtp-Source: AGHT+IFl5/lwjZcmg0Gramun5B417BFKYSxf44G9wfJyYgQTaJof76xuc6ZiaGwXX8SHDS26hFf2arMicVw=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:7f87:3390:5055:fce9])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:589b:cbe1 with SMTP id
 3f1490d57ef6-e041b070dfbmr748760276.7.1720725600922; Thu, 11 Jul 2024
 12:20:00 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:19:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711191957.939105-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/2] mm/mglru: fix div-by-zero in vmpressure_calc_level()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evict_folios() uses a second pass to reclaim folios that have gone
through page writeback and become clean before it finishes the first
pass, since folio_rotate_reclaimable() cannot handle those folios due
to the isolation.

The second pass tries to avoid potential double counting by deducting
scan_control->nr_scanned. However, this can result in underflow of
nr_scanned, under a condition where shrink_folio_list() does not
increment nr_scanned, i.e., when folio_trylock() fails.

The underflow can cause the divisor, i.e., scale=scanned+reclaimed in
vmpressure_calc_level(), to become zero, resulting in the following
crash:

  [exception RIP: vmpressure_work_fn+101]
  process_one_work at ffffffffa3313f2b

Since scan_control->nr_scanned has no established semantics, the
potential double counting has minimal risks. Therefore, fix the
problem by not deducting scan_control->nr_scanned in evict_folios().

Reported-by: Wei Xu <weixugc@google.com>
Fixes: 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while isolated")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0761f91b407f..6403038c776e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4597,7 +4597,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 
 		/* retry folios that may have missed folio_rotate_reclaimable() */
 		list_move(&folio->lru, &clean);
-		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
 	spin_lock_irq(&lruvec->lru_lock);
-- 
2.45.2.993.g49e7a77208-goog



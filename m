Return-Path: <stable+bounces-23773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE69868372
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CD288717
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB0131E21;
	Mon, 26 Feb 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LpS7sDv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4012F388
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985026; cv=none; b=FQdgrexYl1+XmKBcblG3cyBQohOvkX9yhgQMgXQ7GoFpZy+NNqU1CXV6WibZiEaW9RypAz2WU/ZGMDxlNe8quP4j+MmYM4YxysKjaVYCAz1F4I0OBEU/X0FlZk2JKkvc9EvCtPWPeNtaN/ZGLRiCAPKem7YReLI3AByrI/nDnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985026; c=relaxed/simple;
	bh=p8ajBtaYBFMmX/HQaYUKETRHIHlip0BauIQis3y489g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9wgusZSOLMRb+/99vsA5rkTdfP5URFvat7XQiX9aoZNKtE2RwE+lwzs+DBW0N3Ja1jaYTTjUgSbkVDnm2CXamQlQNfVhOXl1Uz+OfPLDpd54VDM1xvpFDgryK2zgaT+EKgoEeDorcTcM67Pq4hZXICcsZTx1KImVwpFmOvD6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LpS7sDv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6293675276.3
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708985023; x=1709589823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMs4MRzvLmPUAwjVk/Qdyqlff3LWgBp6ifWzxjvOrFQ=;
        b=0LpS7sDvK/MZyizhShYCb42GIJr4/0/gnC4fAuzXatEYtTmZ91gCQKSBpJ8jE6qRTY
         M7YOhmdwQuetAke+FYKBZ5N9su3zKz3F2Ai6OFwHwFnCIq3V3228vogjnJSWm7kpQpYP
         E/5b3Dh3QV0OVH8HCQudnYO3gZEJ4a/gTTGttMISF2aYqF2k3mBdW82R7HsYu3RnfLQb
         WIPYsmgRFJ8sRrIXbAC6todABFGhqPFbYX5pwLU0OsAnYH5vSTT9L4yr7azWkwHyoLk4
         KJbUt4MAq3zGaVju4D84zHYnvf7xDU8Qp3fCpaNdQyxazWp1e04XJ++CIDpe8Y+Uh/cC
         YUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985023; x=1709589823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMs4MRzvLmPUAwjVk/Qdyqlff3LWgBp6ifWzxjvOrFQ=;
        b=r2GwnHpf10xKXZFz98qxQAA5hvim4UdKbiD/T61ChurwqtIelayj7qIddziOPtJBHj
         hiXoGjgtm50Tv98I7FqOb4Tk1n6vQ7299st7CQ9639++2tE40SBkMRf1gf6tjIBvwbS9
         0SMinL7mwd3pq9qYWTlq0fRH/LcISGW9Stm/SfRAzeviijaWdPN/zT+qYtKH1UEjStlZ
         SGdwXuuZjw0Iri+peOcMZOeCvWURUsPHNK3AlO88VdvtsryfrQ5G5IbkVk3Wh8CIzDbg
         XCvuraJvV7EG4qOlkooINyDUrQ/JBKdw/T4Qa9Y26v4KCNghByEkn6wuwMEZcOf2WA92
         1zcQ==
X-Gm-Message-State: AOJu0YzsqX2M92A+vPHtPP/ONJvpkEm+IGK8+HDQnlp4rSG/hggbvrtQ
	FwuhgX+SGw4NdQGj/QkQ70KL3ZsmXmBbUE9iCFUr0UDIT3lU5AJQE7M15kqExZtu7je0YTMtCiR
	AL75or/qbEKWkBLlO+DwtOcftJ9aF76xnZHpJJozmVKtRQn/BohdbJq+KA699JVhgiWXx0Rf5y1
	oVwmQunyP/GyAyYd0lLOmxidfvZC7wi4RX61CB1F+M6zATE9ri5vvlrA==
X-Google-Smtp-Source: AGHT+IGFqdGN3Kx1mHPNfRCQ4Nn7FDxiK3DjSQemycs4mSZEYOC2SbXGdpCPwOc+9hjbDboVneEXegqYAV6uCRhc
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:ba0d:0:b0:dcd:ad52:6932 with SMTP
 id t13-20020a25ba0d000000b00dcdad526932mr129187ybg.5.1708985023376; Mon, 26
 Feb 2024 14:03:43 -0800 (PST)
Date: Mon, 26 Feb 2024 22:03:40 +0000
In-Reply-To: <2024022612-uncloak-pretext-f4a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024022612-uncloak-pretext-f4a2@gregkh>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226220340.1238261-1-yosryahmed@google.com>
Subject: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback race path
From: Yosry Ahmed <yosryahmed@google.com>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled.  If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd.  Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path handles
a race condition that should not happen often, and the bug would not crash
the system, it will only strand the folio indefinitely.

Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)

Change-Id: I0aef4c659c6a29b45d78bf6a7e8330c7ab246f15
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index b3829ada4a413..b7cb126797f9e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1013,6 +1013,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
 			spin_unlock(&tree->lock);
 			delete_from_swap_cache(page_folio(page));
+			unlock_page(page);
+			put_page(page);
 			ret = -ENOMEM;
 			goto fail;
 		}
-- 
2.44.0.rc1.240.g4c46232300-goog



Return-Path: <stable+bounces-194621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB4C52F8C
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8B6562F0E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855CF33BBA7;
	Wed, 12 Nov 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0zsGE2s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790C338901
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959048; cv=none; b=N9/OEbFi9WPn32FN3E6puI7Zyzn2BN76dK7+o98hU8EXyRx7B7PVvg8qgIAnlnUXrbmUB+rZ9eGZYuL2UBBdl3E09QldYXjDefzswSz20qdRBqvRRFsJH7C+sobD+BzLW+3iDBH0u3MTM//WLDpepDCW67wjjL1ul1v8/etBC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959048; c=relaxed/simple;
	bh=OQCAuBQMwqTNYPMkDVHUnbO80Ao9hOqKKWxvRgX47bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaSZuISVHys9IHbzYUo0fKZz35yhxZf5VScWziv3dPxmH2X+7yjXItUuN1QBzirdgJdkLO5fkbAnlPU6MmOvTL7aCrW2KI6VqPF62ZPx9zCG8NEAQYqJ14fVV2jL2+j3CSKLJW9haAPQD9CizANiNJx/mVcFfMV9pLEgqDTGR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0zsGE2s; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so645755a12.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762959046; x=1763563846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04QlL+5Mx8OxfT7e5p1Z21nDjyi+h+Wk/vku3CS8HUg=;
        b=T0zsGE2sZ+D1IlIRZPcfTH0BPrEsr9Ym+JUKtY3mb/a28aIoYk+GKWJO5o8MZfvODM
         AyQ64kER0vuM6k3caCUIyHEkbTrRQXkrwJT3DF+LYoRj7VLc0KbSIzs7lPc3NHorUqJ9
         z3GhIJogD3uQXTpcqH7UC8Mbcjvc9C8E5I2cu/BYzDLbj1qpUk6BvlmJWkUucbKCO6HS
         6DwAzenN6+ivE4aUxiGAzDx3nZqJWfcK0VKP3PjGCvZcJxwtLnVHlQ4yYuW1by+AwE1k
         I3sUWJwwYoYCmxuoeSF2vy2zWWhKYzXRqKe0NHUDah21jkHWFFIlUtaSzrwm4njUH1n+
         OChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959046; x=1763563846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04QlL+5Mx8OxfT7e5p1Z21nDjyi+h+Wk/vku3CS8HUg=;
        b=mQiIVDJ26nEvLCdiaLghpTb18Ee6RltDryVBCDkLYeFiK4H7YfDIg5vVg9G5IXkPvO
         QA/GhTlqco62T6OHceV3tEyWvyuc8tXTeOyXN34MiSqlPqtn3EyE9ZjQpqH86p8a+1J/
         lUzj7a5bI9dfi9naVXZfnWVaM/EzOsI+YbR6Yi7VsHF4n4ekslEoFvSIMUHwJhvMCu61
         avlL3H1zDwTjcHAx2s1B50e9ZueldmyP4E6CipHXYhOv1oYKnscg3F1yT4nfbjZR+DMh
         V0IzzivymW+mxM4kahk/RB/zSRbJHanPPDSI9HwgdmjnAjlrNnpyRnpdbWSX8eUSU3sc
         og1A==
X-Forwarded-Encrypted: i=1; AJvYcCXB6ZjymvRrdc6fGKcp54ND4vkT/AjBxTYajJajyqvBEkf1tBM+xjH3hUPs7mzaHoclOGzDHGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF88QdmON1ize9q5oXA/apoQnXPho1HrbQu83nEBH5Hi1fsla3
	o8OQHbN14bEpnPz0td0cFTaO3qDImtNih5FkJuXUi6G8ntu8r6h9QBTj
X-Gm-Gg: ASbGnct5q9gwzmVliKKflVp9w8TgGXMFFXxpd1OdC0m5EeqJs6TeSb2r1CP6023ei+b
	cOYkN6TsAWFmPgCwjkojkU7DQubzEL8qHXjEDmyucZI5oTp9Q+Lu6rEjp5j4N7y/PhYvHBswyDN
	XDc+gV7PT7hRr+2RtRu5oq7l9NIH+ivlgeAFkxFH3sl1dDe4Ym2lklk2ppqd84XEpvfq961+dQw
	shFBJLoeD8cG7L0MNN8hI13ANW+hFeLLwbhvtk/nsZgdbxNvaTbbnGFpzdMXrISadPr1mVWE66U
	AY1i/zEINe/TDNKgiFFzFZSdqA4fBK43TGTEMxz7gWpVrg7L79H7GPab8rPKAeA1UyZ+va+AZLS
	p3OU/YVBs5TW48PGFvq/ppvxHpCtboVUkwW0Zd5sN7MKquXPEQM6NPl1oYSilJAGqvQRMnLLIRO
	jhp7T0jC3OH+UiQ3BGzEOBwrjq
X-Google-Smtp-Source: AGHT+IE2Jk3jIxHv0j57R0SoqELtg9Swv8OUP0MYlU3+JveRpVMaxRxaqU9rPiV1dpQNjx/a9aXLaQ==
X-Received: by 2002:a17:903:3b8b:b0:294:8c99:f318 with SMTP id d9443c01a7336-2984ed2b4b6mr40095785ad.3.1762959045905;
        Wed, 12 Nov 2025 06:50:45 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:3a14:81d0:725d:2dc7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc0df31sm33048055ad.50.2025.11.12.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:50:44 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	muchun.song@linux.dev,
	osalvador@suse.de
Cc: kraxel@redhat.com,
	airlied@redhat.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	vivek.kasireddy@intel.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/memfd: fix information leak in hugetlb folios
Date: Wed, 12 Nov 2025 20:20:34 +0530
Message-ID: <20251112145034.2320452-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating hugetlb folios for memfd, three initialization steps
are missing:

1. Folios are not zeroed, leading to kernel memory disclosure to userspace
2. Folios are not marked uptodate before adding to page cache
3. hugetlb_fault_mutex is not taken before hugetlb_add_to_page_cache()

The memfd allocation path bypasses the normal page fault handler
(hugetlb_no_page) which would handle all of these initialization steps.
This is problematic especially for udmabuf use cases where folios are
pinned and directly accessed by userspace via DMA.

Fix by matching the initialization pattern used in hugetlb_no_page():
- Zero the folio using folio_zero_user() which is optimized for huge pages
- Mark it uptodate with folio_mark_uptodate()
- Take hugetlb_fault_mutex before adding to page cache to prevent races

The folio_zero_user() change also fixes a potential security issue where
uninitialized kernel memory could be disclosed to userspace through
read() or mmap() operations on the memfd.

Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20251112031631.2315651-1-kartikey406@gmail.com/ [v1]
Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Suggested-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---

v1 -> v2:
- Use folio_zero_user() instead of folio_zero_range() (optimized for huge pages)
- Add folio_mark_uptodate() before adding to page cache
- Add hugetlb_fault_mutex locking around hugetlb_add_to_page_cache()
- Add Fixes: tag and Cc: stable for backporting
- Add Suggested-by: tags for Oscar and David
---
 mm/memfd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..d32eef58d154 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -96,9 +96,36 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 						    NULL,
 						    gfp_mask);
 		if (folio) {
+			u32 hash;
+
+			/*
+			 * Zero the folio to prevent information leaks to userspace.
+			 * Use folio_zero_user() which is optimized for huge/gigantic
+			 * pages. Pass 0 as addr_hint since this is not a faulting path
+			 *  and we don't have a user virtual address yet.
+			 */
+			folio_zero_user(folio, 0);
+
+			/*
+			 * Mark the folio uptodate before adding to page cache,
+			 * as required by filemap.c and other hugetlb paths.
+			 */
+			__folio_mark_uptodate(folio);
+
+			/*
+			 * Serialize hugepage allocation and instantiation to prevent
+			 * races with concurrent allocations, as required by all other
+			 * callers of hugetlb_add_to_page_cache().
+			 */
+			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
+
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
 			if (err) {
 				folio_put(folio);
 				goto err_unresv;
-- 
2.43.0




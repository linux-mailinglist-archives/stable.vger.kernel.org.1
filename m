Return-Path: <stable+bounces-210187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDED391B4
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 00:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AFCC300503E
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425532DA75B;
	Sat, 17 Jan 2026 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFzyXSKg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4E1DB13A
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693101; cv=none; b=aijKZOPlzPGPO21Ihl5UsjVEsBQQKLCQdoKtUKfEr26JmwXx7cCRpYLyKnJfFLKQZiuY/tJ7iFbChf6w7ZugGNxlEPNvUtFpvwuL0mYfC39t349ommZeXIYm5i9/w0/IoMi3BT39+BuEgsWqUAvFNERey6xqvqxItiXtCL0xgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693101; c=relaxed/simple;
	bh=x40IScEaCgCz1Zhs/zFJ/XU6nCoyj0uFBy7IuEeDYZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz7MJ8e7mv9WDNZvCwDt8UTkp0az/JK73XzZC3zIaOw4Xyc9KNKjGlCKm7cNkLw7gBWE2QMbToTM2SmnaUgrq7azSYAzQRo9+Dm15bmDIUbQPxNCJQ4TfzL3hn+/Elc/xnX3pTfIIAqjcs64hVx+b0WmJ0iN3sj/F5RpZDXdjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFzyXSKg; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6bf6adc65so2297515eec.0
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 15:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768693098; x=1769297898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jUU2EamMh4W73JXp6BOoG8AP25gnKEbVONTWYPvkjM=;
        b=QFzyXSKgDPMgjgCLM2JcCIxt8Jt/TU+CaNJ/r4C9h8xqP2Q47qoUJJrhHHlro7+t99
         qDBISvZ60a9E0NgADMIErndKJXpZxT4PLtspt4kVzS3YhVffufD5N+Cs9EgfqI2Q+8i6
         eRw8/UXGV/PdJwLGFS3olTf1meZTtsSVUd50tbb/bH3Rl2xKn/6u7PSfu6SoeJSZf4iE
         Vb4p07oRDDByYcQg5jp1/Xzq3Ke7UEBK4w5EI1ReDk9jBUwzXR2z/lvoRvz5jomcH/2Z
         Jb0ifExXZh5tCwu62pi2SJGdSIWRMUyeTM2I0eqZdBI+/sFSQnpIQE2MNvU2NrFhFk5c
         9SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768693098; x=1769297898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jUU2EamMh4W73JXp6BOoG8AP25gnKEbVONTWYPvkjM=;
        b=g7fmJiy/qh3yU3PZNSWh+rHkZ5KG+W3OUHIY6Ej+dpcJDvM41/rXNv0sabpmdGy3Cy
         2Zh44Kr7b4wOxL78ierqfv/AtlN37ZM+/ufiWTFgmfIENdlt96POEab0KXjpnbOBGBsA
         72Svp6JSuBNufoY9gIsV/XHe1uSE27Mch9Rt46lxny/JF8mZIinm7iS6WrhCktTP10Ua
         QzanwokxMiIoKdQxKc3FnZKIeDs+JhEOUkOG+oMKIexr6wkzOgkI51+Zbo6KQPU2eaOv
         FMfZn8/RTAP1Ti4X9WSXULyW9DNnPAuo79AFoeWxyLPGvRqxhm+i6jDaFQjiqvb322xx
         wIgg==
X-Gm-Message-State: AOJu0Yxg7Iclyeu3/iJAYdchLw+Rc3jvy03XU2ehXBCD9Qjw/eRo4km0
	1r48dStZkKhy0el5Hufwq0sd6NzW5wv7AxzA8pbEEUI1ejKbXW53vsE3hTf9HA==
X-Gm-Gg: AY/fxX466J1rFWef/HHERFDRcCaFo9Kbddou2SzkuoRFbzsvZfzcd/IJKB9fEzSrMkS
	k+DbN7STX5GtTA5vtMenxkhXcP4/0Tqpv+wtYE+nq0Jo6UDRbGYm02dxFcbIiz9UOaaiOIwKfLu
	qaMDpnIh4Kv3fZdZbJkCn7PZvFCboDXSQ/d34767dsguVR2nhXmnBYaq47uKFcQBaAp5Ay+EjUC
	1T9gRH0knMFn4ciTEmYIY/uuQ0Lkr36cKs5bGAoI06M5zJ/GBHh1eW2XOsoVv/1c7Km4AkKJBfg
	eK/CSNTocJn4eMdw+mH29dWyyCCkVBopJA9Kr5tHoCMl80LfwsSdPCf4D5BlLhZytkaxDB9pguw
	GwKccI5o/3IQ/JO7ziwxcNtvMsH7ADFl01HZgeqWwjF1HuMSFzsEtZgaciP1BB5zibnajof2NjK
	cNxKQ87JhznMSeT99tJJBpk1rffqUS/ZsYI7HeuHfiuytOU3y85ObIkXj0Yg==
X-Received: by 2002:a05:7300:a54b:b0:2ae:4ffc:d84e with SMTP id 5a478bee46e88-2b6b4e64b0bmr5727236eec.28.1768693098402;
        Sat, 17 Jan 2026 15:38:18 -0800 (PST)
Received: from ryzoh.168.0.127 ([2804:14c:5fc8:8033:57d9:5109:d588:7feb])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm7452064eec.3.2026.01.17.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 15:38:18 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 5.10.y 1/2] mm/pagewalk: add walk_page_range_vma()
Date: Sat, 17 Jan 2026 20:38:00 -0300
Message-ID: <20260117233801.339606-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025112005-turmoil-elsewhere-e83d@gregkh>
References: <2025112005-turmoil-elsewhere-e83d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit e07cda5f232fac4de0925d8a4c92e51e41fa2f6e ]

Let's add walk_page_range_vma(), which is similar to walk_page_vma(),
however, is only interested in a subset of the VMA range.

To be used in KSM code to stop using follow_page() next.

Link: https://lkml.kernel.org/r/20221021101141.84170-8-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f5548c318d6 ("ksm: use range-walk function to jump over holes in scan_get_next_rmap_item")
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 include/linux/pagewalk.h |  3 +++
 mm/pagewalk.c            | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b1cb6b753abb..3670b46cedb1 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -99,6 +99,9 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private);
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 371ec21a1989..3f5cbd6eb4e1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -461,6 +461,26 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return walk_pgd_range(start, end, &walk);
 }
 
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= vma->vm_mm,
+		.vma		= vma,
+		.private	= private,
+	};
+
+	if (start >= end || !walk.mm)
+		return -EINVAL;
+	if (start < vma->vm_start || end > vma->vm_end)
+		return -EINVAL;
+
+	mmap_assert_locked(walk.mm);
+	return __walk_page_range(start, end, &walk);
+}
+
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private)
 {
-- 
2.47.3



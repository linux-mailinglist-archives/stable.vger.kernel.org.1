Return-Path: <stable+bounces-76150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A3979340
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4002839E0
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EC583CDB;
	Sat, 14 Sep 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy2A0GOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81517BA7;
	Sat, 14 Sep 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726343030; cv=none; b=BwZ8HLtTfQ1hv7/UzKT7zRAdwfY2/C3OFo7qQ91PD9BarUBC0FlC9z5uNitgAJd7T0TUFYm8C3R+9gC5gssoRudg5EtBd/ku3E+zNhCjisNOtVjYaH/zUlyrzj2m9j0yC04tveIh4Fw+jhqNOFpvCSrXiCx+uWTHszO/pH/fRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726343030; c=relaxed/simple;
	bh=BmtGFm6jZuuKP44E8PI3imiVlUhupAEA84sNjwyZba0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDUy8LujOYa6poCuNobnUbCjb565Zj8s5is7jEkcLnW8ARj4MD4ctdN6tXOIPuyoim1v5YL5my/Z/De+X6L+phipk5CYZadpUsY336x85aSc6ubnGXULbp4X0CaJgZRfro/L+HTQIIdhjc06fUo0M8h0sDYjBXO+oc7t99FxQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy2A0GOo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e285544fso1616587b3a.1;
        Sat, 14 Sep 2024 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726343028; x=1726947828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEFv/WIVVDnR9INyh6CO+aEW/z2pecEd+lx/1UNH+Es=;
        b=fy2A0GOoxc7PVFPWJEHM3ixiJ02cMM6DouLLo4yLIZQCst1UxVMQWprGC31OCwOlEj
         Au7LPTgCUtWPm4ovVW3QTGFlKUGNXAj3JSX4bGKaPBiSHmVMo5yAlBrAgeIvU64jz4Gg
         OK9tx893C6D56SlJF2Z5JV125pQhAZdnY1qYTZm7x3WrkPbz05WBhPUvaflRORwpXGPg
         vSrvaklXTo1ttcOVjPgtofTDoImdLza5xvDEZpV9PSQhDYODOwVMhwnJTV0IoV+qle3R
         LaVoEhK9xsGVw1vDxmQc6dwakspFlyGfAvNEl0KSJCiASKdjMY9oHeNdVvNu+WEXxi4f
         N7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726343028; x=1726947828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEFv/WIVVDnR9INyh6CO+aEW/z2pecEd+lx/1UNH+Es=;
        b=Ce0FhYupRPSjZCxUhYmNbtbP3aN/Nm4O+RyO5e7Af4/P2yeWbjo8/LIm4svCawzCVC
         wQJZ0fZSvVVaJfkV2RSMUFbIo3+i31DJZdJj1XtaakxdXZ3jUlfIy9m3ZZ/tZnceH/kg
         9CxK8rw/6w20TgYaDF+A3uHfxdVkxixeW8xeBEQlGUY9FtibZRWHzOYW1reFpM6iR2Ap
         r9YiPwP5YaItj2IHrmN8ocamXZOaHnVEG8LXVP2o+8N0EvzpVPXFy34c6Aph+7AgSbf/
         fluFguBBgNEPhfg+gXDymsm+SJ5R4eM+ZDseL/bhWQcPyLxxKFScCMqPCeQZ/HX1evJK
         klQg==
X-Forwarded-Encrypted: i=1; AJvYcCWZB2oBaZ9Ci8ZRMbRTLaVbyHKYvK7rA49ER1vE+Z/JgsIcuZRfehHg/J7CWIryEXvCfAU2HYp3kWGAis8=@vger.kernel.org, AJvYcCXEdDW0OlGE9FhVMwTQQ6N3gYviiek/uBlleZ2PS4ySFWHdOw+VyvofbTJ5UagTCSjR2O/I+6FQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpj4BpqHyoJrG6gYOFwpFKubZpiCak+GSjEfmoPBjd/6Xmc3oa
	w0uBue4VIAIIXq2SNRsQMfju+o07boG8sFUr6HzFoo/8zSpXlTDW
X-Google-Smtp-Source: AGHT+IHrDIsY/QTLODnUtzDg70cOoM1IO63V2p1YyrSgtGMrwYZoljG+kzn5MdMlfDTCg2BnwTHqUw==
X-Received: by 2002:a05:6a00:1701:b0:717:8b4e:98b6 with SMTP id d2e1a72fcca58-71936adf4a5mr11079419b3a.21.1726343028008;
        Sat, 14 Sep 2024 12:43:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944a9cab5sm1294742b3a.5.2024.09.14.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:43:47 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	syzkaller-bugs@googlegroups.com
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/hugetlb.c: Fix UAF of vma in hugetlb fault pathway
Date: Sat, 14 Sep 2024 12:41:19 -0700
Message-ID: <20240914194243.245-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240914194243.245-1-vishal.moola@gmail.com>
References: <7B2E5B76-8FC6-49EA-B0B3-2452ED6ABC5D@linux.dev>
 <20240914194243.245-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a UAF in hugetlb_fault(). This happens because
vmf_anon_prepare() could drop the per-VMA lock and allow the current VMA
to be freed before hugetlb_vma_unlock_read() is called.

We can fix this by using a modified version of vmf_anon_prepare() that
doesn't release the VMA lock on failure, and then release it ourselves
after hugetlb_vma_unlock_read().

Reported-by: syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/00000000000067c20b06219fbc26@google.com/
Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c77defad295..190fa05635f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5915,7 +5915,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
 	 */
-	ret = vmf_anon_prepare(vmf);
+	ret = __vmf_anon_prepare(vmf);
 	if (unlikely(ret))
 		goto out_release_all;
 
@@ -6114,7 +6114,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
-			ret = vmf_anon_prepare(vmf);
+			ret = __vmf_anon_prepare(vmf);
 			if (unlikely(ret))
 				goto out;
 		}
@@ -6245,6 +6245,14 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() is
+	 * the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return ret;
 
@@ -6466,6 +6474,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() in
+	 * hugetlb_wp() is the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
-- 
2.45.0



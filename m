Return-Path: <stable+bounces-179535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16309B563A8
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 00:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDA317E376
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF90292B54;
	Sat, 13 Sep 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3GwTv6u"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20A1E1DE3
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757804154; cv=none; b=pUXMFIwua6FhGaVfZfzChMP1Up/hHMA53XvCg3WWy/+FIpztkcJEbbD/sBFKktPfwVa3BKMvFKhmHpEwWhzNuNRt750ccvtEoNB5Pno3lIdt6uX+e5Otou3h+oYJJL5HCp1V9kZ/IgE+FxG+bihT74knMI2ihouEdE0geFkhFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757804154; c=relaxed/simple;
	bh=VCQ2P+C1M71li+tO2fQorKx9Gj5ek/sAkJcU1DBsejI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ast3NdnCtacANpdOUMe1qjDXjM/utA4AN5G2PuQu8Vqho1pjBnr0QHkQgVKhSAMej2PHOvpb5ay723GDyt1T03Ee+8C3sQA7GoLagQCdGod/4qQ7VxcDUCFs99SOnsmra9RWI5OVY7OTWUwHcWnK8Y/lUvN5ZyWzOWI1vZIXT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3GwTv6u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so460462666b.2
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757804151; x=1758408951; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZjdoqbS4I+w3W3o7PU4SUffRuApjbUNSAnCjQf8W7M=;
        b=A3GwTv6u6Sh3mJsdSObldIPi+ypIy5vYO0WKQdk8YVeQc17NyzzCYtDoEGNFlz2+nj
         NHkg5xBWiUDAox5JUsvTvVkTpCRKb6LfEz7ulIfwISRWBGtJLNysp5UrJf1/nrzR/6FT
         NrDBcwDTyCyr3692uxzDFT5u8gMiaZH3Nhsu0GLkg9cUMnIE/683RVCOyEpQsy1kD0sf
         1jxF0GnuAEzQcSevYg8iQ78g+HVkObaDGSKNFc81pgB8f7HZPQ0GTbWVvxBGB6AArMAd
         hzi1jmx8dVjcESx1X4z3hEKua2DzknjoYJKdMNUg0RMJacE2q1qRYSYnhJZ6rr704cHR
         2uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757804151; x=1758408951;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZjdoqbS4I+w3W3o7PU4SUffRuApjbUNSAnCjQf8W7M=;
        b=bIym7VWv9C/IJZTlEmAi7Ss9xLcVCYkGr5gseJECLbFARPRCutCzje3RM1zRcr/6v6
         MEJzqR54r9RuaXsj33pz7NKH7RsNWyQv464jUQ1QlT2nS3ZTgKXKTLmHy2D7mOnGprvX
         1A0p30Tj9Eq0lWJzgDoTS+kaB529L0Cc6VFaSqSl6PAM55DAJ9gLVCRGWlFtB3IhhtfP
         lTZBwLn14s9jvC7LOLGrbGZu4UJ+mka8qO+f0lQcSIqyI0N77rLVd3xsM8M1vfQPldrO
         hzO9snLLnYTGI00yHFTAi4Vys+xvVrU3Fd0fNgmQfXhAzf5WbArqdZFbjsFycLuN6VXw
         ZY6w==
X-Gm-Message-State: AOJu0YwF3ShXrTl37M17tWnrKtTRG1VOLke+pHdGzN0JTELyP35xAv3V
	b03z6NU0TGwnZlyhd33qZrrjWuY02PcyySYfCjQP/13iMYHNLc2uI/eYfnOgwA==
X-Gm-Gg: ASbGncuntzQV88Cw/3wQcOirMbh9LNMrqfOMD/+YZTWrzcTWPl8LUFvDNFWiKSP/+v2
	sC6DqjR9afrjKgMhCKsnh1UztHgPy9GiAg3e8FIaytPBM74QDePiTF5TXh54H7hvR6ZaMbYdp94
	T0TnI8wdj4VGlCwhq8ZOAiikhfUxxko/YTWElug01sI+q8juF9rbkSlhSx7PWpC1/vEa2v8Zonc
	HDbS3vdrOiWKamMqiqNkkHROIth1k1RIQF56ojiGGO1uQxFRyp0qc0J/8dbRTpobqTVrcfWzrJm
	Co1K0HbprnxP0nyImQau/i52/9/cUDPcK8WHvEHZ/YxrMjiW8mbvRkX3b84RUfhkDNPMFC7F45w
	x6fOoSKHIQWDGirws4CvYcTwjG7aZpLh5
X-Google-Smtp-Source: AGHT+IGl53NOhsXg9cI0ZbgGMhqa7CaJkhY9NU/dknZvrHuoPx8hckkjHGZ/J9O3bxdK1kKSw8PXQw==
X-Received: by 2002:a17:906:6a02:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-b07c3a77f67mr717887966b.65.1757804151193;
        Sat, 13 Sep 2025 15:55:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07dbf5dbf5sm274371666b.79.2025.09.13.15.55.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Sep 2025 15:55:50 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] mm/khugepaged: fix the address passed to notifier on testing young
Date: Sat, 13 Sep 2025 22:55:42 +0000
Message-Id: <20250913225542.16963-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <2025091346-ambition-mangle-6099@gregkh>
References: <2025091346-ambition-mangle-6099@gregkh>
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
index d6da1fcbef6f..dbbe86bdf04e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1227,7 +1227,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_young(pteval) ||
 		    page_is_young(page) || PageReferenced(page) ||
-		    mmu_notifier_test_young(vma->vm_mm, address))
+		    mmu_notifier_test_young(vma->vm_mm, _address))
 			referenced++;
 	}
 	if (writable) {
-- 
2.34.1



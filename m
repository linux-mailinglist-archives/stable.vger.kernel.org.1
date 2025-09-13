Return-Path: <stable+bounces-179537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A64B563B3
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4111B22E59
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075B2C08AF;
	Sat, 13 Sep 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgR5bR6H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A6A57C9F
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805120; cv=none; b=HP59WFOt6FYpfSqQPfWwo7AcAH18GhZ/wl32gGdsDo2ipVtk3G1l77dIUAhCaB3yufdX/bHbyieKV4dACHrtTDDMWGVjx9Cv1mXitApkubs3d5ZasDTuBu7lGfI4QeG+tfRcOLDNl9XwG7FHwHF8FfL6kPgHY0tfNw4kuGu1qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805120; c=relaxed/simple;
	bh=M4hR+JYrTgAjsoaQMl9PQK7MNYSHDkTXEIa0odB25rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cny/FPMbmPcJOqjMZ9L1H/E4n9sx/WsiftMZl2dhqbSJDhCUfHKdFixhem0zIoNxIuAKGeoLHoo+aELY6Oopz+6Xm93SeiqKnkYFmNTbyph5x3HWH4Frgf/kKUWvS5lF5AieGNrKZtInyFVF6C6iW87HGmQBj+y4w3kJHjPgQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgR5bR6H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso5212439a12.1
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757805117; x=1758409917; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8P2s8/WKnGBe+Usb9yPUnqYqmjMi4um8kQ5h9qmMOic=;
        b=KgR5bR6H5whQop3Nu5gKVJ9PM5LOyhb1FzvsmNyneNFmla9tS90GXOoyQ18Ya4Wqvm
         DpVsTNaK4Kd+o2ceEytQLxP6q13NNzjBT5mZZGHPwv1MkEEcyq/vMv9t5eQP2Q33SiEE
         GNktS15zRvU5xBib9C3BlX+iI6GrOcw6OahGJecrGekfhKz93WuI4qA7/A9wKHw9eU2/
         rO880gTFwxB+fX6dg0MBcV1DY3QWnrFcjLGsM/NPp6/ULMoOeASqRXwkE8/+0lSuNqgf
         sAanAICFN/v96AqghwLlnRq+32x2boVlZd3iWdMLp9iRzMkXWEUvRzoky87vEp9MUrpo
         h2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757805117; x=1758409917;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P2s8/WKnGBe+Usb9yPUnqYqmjMi4um8kQ5h9qmMOic=;
        b=qDvuRhkohJYW+7z/+feg8Vi7XgDTB4MEro+3C4HmxGmgqPx00dmJiZnlu4FkEbB7wX
         VfLX8KRmPrb8ne+gunJNYEmTgcqfpHhkW5+twgspin6MD1qd8z/l7UFj3FsLjK1Hf4wV
         SXdoYjzC0+Ucax+FMm6kWji908AlTp3TyItC7JiJfdY782FBwqISKmD7V0hkE+Lwl46w
         7fadZXm7pAbNauADtsGPweB89272hI126lnhbsf2H1oqBEBRdpnGPalGPJWy+8qP+b1D
         XLxsRK35AMmU65SOEC3Ov7d6ra0uip/aVd0aK4ogt/G+Z3k9SKVXDvmXNSKLurVsoRQT
         fpSQ==
X-Gm-Message-State: AOJu0YzkSvR1GxGLynkMjM0+pDx0yp3HswQ5OIXiIe2Wefb8RxSJoLAm
	fFf+FVQ6vo6tHZpE77th46bVUSonM+Ov3hEfjLsbhqgXzQf8UAVp1I6ZSa0xcg==
X-Gm-Gg: ASbGncvZB/wpDcItbva/9HgidGX4ohfKlaJX7n08JyR6CaCFq3HabqYntOKnUnOhjFj
	jkLJ0rJP3X42eY5Xj7nar1cze3+DGtoKWd03HAnzGyuC73/8ITBTMgpoTqEBG+fuaYiwjXKQjK9
	8e77rZ4veFVcpg3PulZg5YqEfQeTwVhhwSlLb8q7gdugBwDonIedvGgeSBXgS0Zi1hThMqqVXBu
	yyzc+zypFz/WS4DM203pqBKtyDyvlFiqLXlF+A6IMGvyxmdHZNqVO9M+jgSAlKZYun6PAaYqqnP
	mG8k3HovXLMz2Qx7TLCVxiNXyECQ8WBNm+r+lLH42R6iJ2VALXrImL4s92zqmfQ9NLQtZgwVt9E
	FyBmGCPp5ynF/VbeI3mVcIqmnHKlv+I4i
X-Google-Smtp-Source: AGHT+IHtF1IIad+ztXisb8lvt9Qsu3vWTzQVf3cz7b2ShCKlZLPbzY2GGHYpVenh9QFlLFDaZQcSnQ==
X-Received: by 2002:a05:6402:3245:b0:61c:bfa7:5d0 with SMTP id 4fb4d7f45d1cf-62ed8522accmr5928324a12.30.1757805117098;
        Sat, 13 Sep 2025 16:11:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ae181sm6344396a12.22.2025.09.13.16.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Sep 2025 16:11:56 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/khugepaged: fix the address passed to notifier on testing young
Date: Sat, 13 Sep 2025 23:11:53 +0000
Message-Id: <20250913231153.17356-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <2025091345-oblong-ambiance-8200@gregkh>
References: <2025091345-oblong-ambiance-8200@gregkh>
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
index e318c1abc81f..a7a8e6bc70b0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1358,7 +1358,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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



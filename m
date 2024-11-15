Return-Path: <stable+bounces-93601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D465F9CF668
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 21:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3338AB2AA24
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B2153800;
	Fri, 15 Nov 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbLa2piO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899A1DA23
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703949; cv=none; b=s6y9sqF8FyFq13L7TnGKNuoEK81QCgmB2KgUUqUwJb0vswZfKj7EDDGWt6oR0RfGJtZtmBcxeK+NkermAqa3JhT9iK0siKs/EnfFi/EXddBFJCt4U79G+0VTo/m/iHb1z6o15DvBkVMfoUAy1x1nMXC13nyJvFGEYza95/4Hcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703949; c=relaxed/simple;
	bh=lgtrsfajWkqQhFMjso54USZ0nBjENfWXDV1JpuF+nkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZDvi/BWqSs4vEdhAZ+z1S/GjD2uDgN85GLysN7yQSFmLd5JVyj2LlHjEtA9QuwjQ3Yev6JpfItSItNVx1PBs/P95QlT81uFJVSnhselY4htKuNdD7qKW8YhxzHo4SmAPB6Wxqcp4FnXD7oWpObeA+7eOyMBeFXiJxWaYz3dpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbLa2piO; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4608e389407so26165331cf.2
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703946; x=1732308746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+JXE3B5KawPF65U6HSOHR3FL9VUAcwuxe0IMh5c68A=;
        b=lbLa2piOHKy8CgcaxQh8ksVIQS7DsYJ8IBQtcWqGAj6U097pHAMGXsVHKwIR+mJz+o
         eBOaz75etjhFz1CQAWG0H63B9d9Vt/4v8XxCBG+0ZQl20rTug30QAZx9sk9vPEPCCexT
         R/K+sieC3S7EIyjXtOx/IDsJ0BAAPEsi4sRPnf81j9s0/vgGN4jxnzKqQiQ6O5xMtYod
         po5q8mM+aEot5UCMfnsSQ4FVceB0XxNWY0vlxWXScYp4j/dCoWJ5dhGUsBw8aOmS5ZNR
         nkVqqGX592QT3f7Gj9W785hf9Z2Vt+1UqSHeC/jc8Vn9XdhW6WvzioLtePOV2U27dwcH
         uXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703946; x=1732308746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+JXE3B5KawPF65U6HSOHR3FL9VUAcwuxe0IMh5c68A=;
        b=QanH2+h6pC0113k1/sGB5p7bQj8M5pqtSjAMmhrUDxg/iAPVqdN8wPVqKM7RW0lBYU
         UYvSev35SDhxFaTq1veCCdPxxkeuw2rKLjpBGiHGzCoosGoe7Z5+KI8Y0csexuQ863d8
         d3qHBUJSPP0OASLXkjLdrr+2i8+Cdq+sfVcNY1+4ehNkjB1BPjbSU6huztMIrrI2+MWn
         mtm0SiBpQAQ8ouP06UDb8DwoPJIAi/w/ap8NM2wLQFyJCvhJ1p0m9yloosuTE8bbh5nA
         LGp+4xOOMDUM34n5NKDsTshIfmPH7eRhC9084dOtgMWoERnK4jhBrvjrY6xbsQJH59cA
         TWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMSF+JBDkDFwWEh3dsx8nCyGfMDg3KCgFG8S7DNxaMmiHIIjPTvm9oqvyyDm1aaSzzOT9I7Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVlwX6Ls2+aA/ibxhr3trZYmJtuXSRU0l35eNMs2kqfN4wFia
	n8zNYIdAvTVJT5V4PA5ASIrTxOnpkmH8PckIJU1Cw9S8yObslmaD
X-Google-Smtp-Source: AGHT+IHVkVw3cryn3SiPFqi2l6cxFQ6DtPK1Y2TsQd3PF5Xv4T1JOhWcXgQAcOPV7Er2j8fGRO+liQ==
X-Received: by 2002:ac8:5791:0:b0:463:54f1:ec3b with SMTP id d75a77b69052e-46363e0c9bbmr49897901cf.17.1731703946129;
        Fri, 15 Nov 2024 12:52:26 -0800 (PST)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab5da6bsm23831271cf.80.2024.11.15.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:52:25 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	robin.murphy@arm.com,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: uaccess: Restrict user access to kernel memory in __copy_user_flushcache()
Date: Fri, 15 Nov 2024 14:52:07 -0600
Message-Id: <20241115205206.17678-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

raw_copy_from_user() do not call access_ok(), so this code allowed
userspace to access any virtual memory address. Change it to
copy_from_user().

Fixes: 9e94fdade4d8 ("arm64: uaccess: simplify __copy_user_flushcache()")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/lib/uaccess_flushcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
index 7510d1a23124..fb138a3934db 100644
--- a/arch/arm64/lib/uaccess_flushcache.c
+++ b/arch/arm64/lib/uaccess_flushcache.c
@@ -24,7 +24,7 @@ unsigned long __copy_user_flushcache(void *to, const void __user *from,
 {
 	unsigned long rc;
 
-	rc = raw_copy_from_user(to, from, n);
+	rc = copy_from_user(to, from, n);
 
 	/* See above */
 	dcache_clean_pop((unsigned long)to, (unsigned long)to + n - rc);
-- 
2.34.1



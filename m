Return-Path: <stable+bounces-94519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4309D4D10
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38305B22409
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBED1D79B0;
	Thu, 21 Nov 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHeafUcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92D1D47A0;
	Thu, 21 Nov 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192887; cv=none; b=qCDPINhVYzUCvGN50dm4FuPEr9mdg5EyhLmzMS40uWIfI7/gX81RW0sBfTYpj2879+ePTCu0gpjkom2YQ22JiDWX9Q6ZHtmaaEJ5R++DFJuVb/gZMJRqVWW3iDbhn1gKWSg9FXUgg/BTmR1F2ocKol0PoqdgEhpSLZqeW0SXYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192887; c=relaxed/simple;
	bh=g3tfuA/UG+Z4V3lBLAMG7NiB9Eo1EihREvq4FOeAhSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LL97B8Gqyr3Xf5NoOgSJjleHBUqMWcOUBj8ZDP/eZpkfab7TG91+CWMXEd8wh1C2auJfX3wzX+dcz3eK3GdjRbhgWMrqZ2FJZL4iTTvRqTzkKZ9IH6d/huLbeJSTjw8uJS/BzM/8o7+QPyYYHDMY2rPL2m06mQqHUTu1KBahPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHeafUcQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21269c8df64so8636775ad.2;
        Thu, 21 Nov 2024 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732192885; x=1732797685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saHVPgloWCW73BS5krIAOvOiq0B6Gy9Xs2EnFsiEW50=;
        b=QHeafUcQMVTS3MWMvK+hohuiYqj5t981MYc0VXAPXMuuyfqaqjAE3pzuxzMZAOzYRH
         ru+XjZwUibwW5AQwPLKQT44KbK5WMMVxdBidiJQDD+8kkNNXEt7dD5pYYdQ4nUC/xSYP
         zsKnJven/oz+Z9c65GzsN072hh3q1VF2XzLY/INeL/6gXgna0TmANMaEqgUBQ0HlbOfT
         ya5TUO59WhVKYkHUfsv0DNplHyp1Z2mxmDKrrQnOQGCZZiQPtgOaVYtDmvH9smlzIhTX
         2B+R/BrFBekm0lo3zl/PXHJ/EUaM8AIfY6UZlu+DM1LVfmeKm/dLjWDX+R/xUorI1Enx
         zG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732192885; x=1732797685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saHVPgloWCW73BS5krIAOvOiq0B6Gy9Xs2EnFsiEW50=;
        b=mOmK0UbW1/vhUuwkdTSmjxzfJqisbXWELFtK5X8PxTtxdxKgVJUxmJbEK8bpfAQDkI
         EhipT+/1LlPCOVp2ERdIrUjy7nN5OyECvsaOAP5rmXuficRCsoCOwBWD3YFi9wayT9tH
         SfvXF/JO9678Wn8YSy9Oumo3pXQXVU4tbBna/BHMPnyeP2zHXNq+42xkBBQ4sJSad6qr
         hjvSAZNW/S27LaoENFCIfdSMHD+OfFmiqIU36Y4aauqTbqhyR/YDYJPpQuN0ETnVtW1o
         Qgt+x77CLGhuKPhQR2ZH261lWneTjdxjcWv++5eHgVqlw2XfyNV5eb6wRITJMsXDeJu4
         HT3g==
X-Forwarded-Encrypted: i=1; AJvYcCVsv4wrV8uvhE8ZgD+jtyVORZVlrG+x3a0uKAeG9PEvUssG0bJpR4gKnXobe5VGvXEu972D8wGA@vger.kernel.org, AJvYcCXoGnoxDVUgpQuDZs/D6WPg05pS/WB0c4c+8ULJB4lUnYX2z0Rdprtdfws9QEl6Cn28TrWenhCyGQbTn+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGNAzYxVf7Qw2xVPjkVUFkMMUrRo235brP0GFMpNYF7MrcUUY
	c/X7Rgsdo4NTklwKfdTjbey9UNs5Gzsx8tmIJkdpXSowhZtTvMjT
X-Google-Smtp-Source: AGHT+IHl71Cge81GkaeyNHyHp3L72kyzIqbjDHv1+AQUG60ivlEurQACwb+xPMKLWp5j7BQriPcwtw==
X-Received: by 2002:a17:902:f652:b0:20c:d428:adf4 with SMTP id d9443c01a7336-2126a435e67mr96831535ad.38.1732192884795;
        Thu, 21 Nov 2024 04:41:24 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883f3298sm12589775ad.244.2024.11.21.04.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:41:24 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: dave@stgolabs.net,
	willy@infradead.org,
	Liam.Howlett@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use find_vma() correctly
Date: Thu, 21 Nov 2024 21:41:13 +0900
Message-Id: <20241121124113.66166-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
the returned pointer without any verification, even though it may return NULL.
In this case, NULL pointer dereference may occur, so to prevent this,
vma_adjust_trans_huge() should be fix to verify the return value of find_vma().

Cc: <stable@vger.kernel.org>
Fixes: 685405020b9f ("mm/khugepaged: stop using vma linked list")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/huge_memory.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5734d5d5060f..db55b8abae2e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2941,9 +2941,12 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 */
 	if (adjust_next > 0) {
 		struct vm_area_struct *next = find_vma(vma->vm_mm, vma->vm_end);
-		unsigned long nstart = next->vm_start;
-		nstart += adjust_next;
-		split_huge_pmd_if_needed(next, nstart);
+
+		if (likely(next)) {
+			unsigned long nstart = next->vm_start;
+			nstart += adjust_next;
+			split_huge_pmd_if_needed(next, nstart);
+		}
 	}
 }
 
--


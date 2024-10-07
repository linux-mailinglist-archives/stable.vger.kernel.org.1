Return-Path: <stable+bounces-81487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB793993A94
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3945CB231FA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A018E368;
	Mon,  7 Oct 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pATyhyPH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5718BC19
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341756; cv=none; b=Bh/VU2qxJsgo4NV7E8JMqypZFFRmtOv9HOmzk0TfzEj8J5sHIvxYvZvbgpghL4c9XpiJVObTBGuHih7mScVyzok0uFO+H4EOfAiVshB9ydby9Z6G7k1hu1cjoLg6XtOIcLwnez0rAkSbYAhEiBaDucE0fnGvIobA+4sevxapkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341756; c=relaxed/simple;
	bh=n52Zcjng97SR7V16E/kiNd9Ad8nOMx616zmfBspy7bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YC+mBipaFKYVP8/H3rt+Aqx/N3jgE5Go3eTFDVP5xscFvGOK99J7/BU9eiZK0J4AwGL8a+4cjl/z1lrV3cTW+FfI4kQGKIwCQM4OaMlIB4MwjRDeuaY+s/ySpyFpQMjuOYfkLDD6t/sVDE5s6HYGI697tzNj0/cBTcbmOkYt6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pATyhyPH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbe8ec7dbso40325e9.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728341753; x=1728946553; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRtn8t3j7whUUfZUQGOBh9/Ux+u7T3Ja2jMsVhYhxY8=;
        b=pATyhyPHQjzg3yku1X15YfmZyNPV6AkTw+j1p5hQOmMmoLYQ39lVOUVWGlmL6VIlRT
         Gtjfr5DW0wpPr7I750RUZhkXvGXU9UvjbI0G/43Vuu5OaBNQMoJbVWEYj1LmCnnv9qc7
         BB8rb6UzQkpEoXSOlP1HHM1ISwzcW+UE30xURitbChlKnVJVt4s8eV8LTv2Ua5lRws+t
         qG369PTQiAC/usQXgkxHR6r/T4yua0psVnqYP0pWQ8mIkqmfmzOMZBmCgJBuS47BPJSY
         vhfCSLcp7jMrGw213ynHk1O4L0zlUPoIVj+5tl2rsW2zxZ4x+3q6eKkEEfNHE51HI8P7
         0KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728341753; x=1728946553;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRtn8t3j7whUUfZUQGOBh9/Ux+u7T3Ja2jMsVhYhxY8=;
        b=lOeeR4sBtRCIMqEzSFNog1SmIYE+0Lk6RmiP2FGyeAHp4z/iX5TNwQ7On4QW6wZ0p3
         VbfEVJfEVzEYg5FhTGYAi6KndLanajCn0CWS4N4kdA+MO1kCIcjrfDIy/uF1N0WiEb2s
         i7TFS3u3uzbXQ+DAe97iyNO8oH05TqVuSi+zH5GRgSea/ESZMTeJI1CBjRqBfUFN2ZgP
         iZ7f5DdOlUAwAJnzlLugHhE6e8BSRaneBH7esm9CcsVnO/Xor78N2sKAOVNCFAnYNU3g
         +H1DkUXpazm4J0OTvHCXX9yc/M7pAo0HspSe8aa83BgLQDd2EPFMoI+rtc0EB3Xm35fv
         /xxw==
X-Forwarded-Encrypted: i=1; AJvYcCWelBdSL4zVFg6c+ZlwBm/HMIvULtZBn3ww2lw06pfBdz2wyFzg9jcFRe82LVcCp0GZtkOFGlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymza6lXGOtiFYbTHh3PW7i09pitWWxdq7dIJSJV4MP41tAniyt
	9g8wBi22+02vDVCjX+2O2PVouusTh4Z73ZirCitoWIsHIuZWodzeUWSdTbZHJQ==
X-Google-Smtp-Source: AGHT+IHlDvzelBdkA5qpz8fIAQDStRDvKx0t6Pxm0mdU1tfYyX8BXXl+49Z6jy3NewrGS1ig5GLLNg==
X-Received: by 2002:a05:600c:c8a:b0:42c:9e35:cde6 with SMTP id 5b1f17b1804b1-42fc83dfc65mr1881355e9.2.1728341752879;
        Mon, 07 Oct 2024 15:55:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:39d2:ccab:c4ec:585b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920be2sm6645143f8f.60.2024.10.07.15.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:55:52 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 08 Oct 2024 00:55:39 +0200
Subject: [PATCH] mm: Enforce a minimal stack gap even against inaccessible
 VMAs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
X-B4-Tracking: v=1; b=H4sIAOpmBGcC/x3MSwqAMAwA0atI1gZaFfxcRVy0MWpQqjQignh3i
 8u3mHlAOQordNkDkS9R2UOCzTOgxYWZUcZkKExRWWMa1NPRirM7UIIjYlXxGyPVpW2neqy89ZD
 iI/Ik9z/uh/f9ABdgS85oAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>, 
 Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <ben@decadent.org.uk>, 
 Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@redhat.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728341748; l=4473;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=n52Zcjng97SR7V16E/kiNd9Ad8nOMx616zmfBspy7bA=;
 b=ekJkZXJWcbs+tPc806Tv4AxKiW8KTdjWR/I4EIwAEUjpjvC2nP+AnDfJ8Dy2Pq8BjY1IDootY
 Zikmp+VX8bACCd1mpHA6Vhzri5fZQbYZoX/vJBWVsJMyEcS0TCMOPEX
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

As explained in the comment block this change adds, we can't tell what
userspace's intent is when the stack grows towards an inaccessible VMA.

I have a (highly contrived) C testcase for 32-bit x86 userspace with glibc
that mixes malloc(), pthread creation, and recursion in just the right way
such that the main stack overflows into malloc() arena memory.
(Let me know if you want me to share that.)

I don't know of any specific scenario where this is actually exploitable,
but it seems like it could be a security problem for sufficiently unlucky
userspace.

I believe we should ensure that, as long as code is compiled with something
like -fstack-check, a stack overflow in it can never cause the main stack
to overflow into adjacent heap memory.

My fix effectively reverts the behavior for !vma_is_accessible() VMAs to
the behavior before commit 1be7107fbe18 ("mm: larger stack guard gap,
between vmas"), so I think it should be a fairly safe change even in
case A.

Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED holes in the stack")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested that Libreoffice still launches after this change, though
I don't know if that means anything.

Note that I haven't tested the growsup code.
---
 mm/mmap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..971bfd6c1cea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1064,10 +1064,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		gap_addr = TASK_SIZE;
 
 	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
-	if (next && vma_is_accessible(next)) {
-		if (!(next->vm_flags & VM_GROWSUP))
+	if (next && !(next->vm_flags & VM_GROWSUP)) {
+		/* see comments in expand_downwards() */
+		if (vma_is_accessible(prev))
+			return -ENOMEM;
+		if (address == next->vm_start)
 			return -ENOMEM;
-		/* Check that both stack segments have the same anon_vma? */
 	}
 
 	if (next)
@@ -1155,10 +1157,47 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	/* Enforce stack_guard_gap */
 	prev = vma_prev(&vmi);
 	/* Check that both stack segments have the same anon_vma? */
-	if (prev) {
-		if (!(prev->vm_flags & VM_GROWSDOWN) &&
-		    vma_is_accessible(prev) &&
-		    (address - prev->vm_end < stack_guard_gap))
+	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
+	    (address - prev->vm_end < stack_guard_gap)) {
+		/*
+		 * If the previous VMA is accessible, this is the normal case
+		 * where the main stack is growing down towards some unrelated
+		 * VMA. Enforce the full stack guard gap.
+		 */
+		if (vma_is_accessible(prev))
+			return -ENOMEM;
+
+		/*
+		 * If the previous VMA is not accessible, we have a problem:
+		 * We can't tell what userspace's intent is.
+		 *
+		 * Case A:
+		 * Maybe userspace wants to use the previous VMA as a
+		 * "guard region" at the bottom of the main stack, in which case
+		 * userspace wants us to grow the stack until it is adjacent to
+		 * the guard region. Apparently some Java runtime environments
+		 * and Rust do that?
+		 * That is kind of ugly, and in that case userspace really ought
+		 * to ensure that the stack is fully expanded immediately, but
+		 * we have to handle this case.
+		 *
+		 * Case B:
+		 * But maybe the previous VMA is entirely unrelated to the stack
+		 * and is only *temporarily* PROT_NONE. For example, glibc
+		 * malloc arenas create a big PROT_NONE region and then
+		 * progressively mark parts of it as writable.
+		 * In that case, we must not let the stack become adjacent to
+		 * the previous VMA. Otherwise, after the region later becomes
+		 * writable, a stack overflow will cause the stack to grow into
+		 * the previous VMA, and we won't have any stack gap to protect
+		 * against this.
+		 *
+		 * As an ugly tradeoff, enforce a single-page gap.
+		 * A single page will hopefully be small enough to not be
+		 * noticed in case A, while providing the same level of
+		 * protection in case B that normal userspace threads get.
+		 */
+		if (address == prev->vm_end)
 			return -ENOMEM;
 	}
 

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241008-stack-gap-inaccessible-c7319f7d4b1b
-- 
Jann Horn <jannh@google.com>



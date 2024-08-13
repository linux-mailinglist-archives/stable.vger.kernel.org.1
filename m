Return-Path: <stable+bounces-67545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14B950DD7
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F981F23775
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052991A7041;
	Tue, 13 Aug 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqBnqiAt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2F5588E
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580744; cv=none; b=sqqZi5Ah86Nc+MqThKimlFUKn9ujD70vnmYxE+pcUXRBBzmngeJoCMPetZ26DcHdHb/gNbmKbiI/hQjPzOF/SmzEbIqwsXn54XTuiSlbexqe0ecUZlAp30zGPSTMMIuqWGqnmRtKcKWOQahMfiNcaeBtOsm4bL/5IEjYG7x13vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580744; c=relaxed/simple;
	bh=uPZbHC8CGUlf/x8Q+x+KQ3vLMFUd1MWESPzfxfGXEFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6GHvrgW7f4ex/W4Aab6u623be5p7kkh4qgGbV1ta4IdpFtJrEESUUAms7PZXaN4JCgAPZ8oIoULnF0M9uG9ir+1dFtd53gfuvDW32LztFOPqbkdSfcb/kryaiFgWM4jcfJ3udvTRLCiz9MTFWxDg7rdsLtqykv2ImWL04mzpO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqBnqiAt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso2635e9.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723580741; x=1724185541; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urxtbyntgkmhTeVfk229QCNiMtt2bXGPf/Tk0xUU9iw=;
        b=qqBnqiAtIAJkAYpVHURHzmSyogekDHRQpVZb5w/MJB3oFY/X62YsH55mDNy0TJ5SC3
         tmftz4CE13KxmaNVKMp3Izh5Pvb+1NBVR3DD0ebAtt19Doboax2hpP7GL+FtrLV11gJt
         rGm6l1rlIQgCeSyDJM77zUPfPkNanUY6mfoaH4ef1ew+G7+cYtt+i0pRdYxvVJeZmBZp
         OQuhmnjccZUl9z4438RvBKeYsMJuycIT8CsP4QrK17B3VF7iElhkOVvkcFRkusN4xcJU
         YXMuaQiegbqLib8yJi7TjLOLH0Da9ArmReVs1thY2+S6lM+r/dDVSuuuoJHlZSDV1r1S
         +3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580741; x=1724185541;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urxtbyntgkmhTeVfk229QCNiMtt2bXGPf/Tk0xUU9iw=;
        b=L6QZ3OM7UePJUQrBeWxqOZfkw8JX83SpDhTAIu+z+q2CnYZDlOwBl32M+fVQmW+YBS
         EgmA2UKUuRBHXsAX6h6b4fM6rJEEEzjotBhGrQlZl5iEwDp8hHTejGXNUXC6mFYUYUTJ
         /viHhaPNYEhMk/W8mKGAv+1FEC/UJiSFnyTGsAdKGeKSRrJk7jkb0Gv2IgMk/rvB3WfL
         QOQpHqm23gX2f9FAA5UmSylJkPNUGRAwKEoydyPZ506Gti70mTWL1oXvNEV19TIEysZN
         rX4iol32jPs9lVKaTDbQVxiQM44MqiYrAaujljSDj/iHqthWeLKuaY1Ijtoh3CFnh9V4
         sv/w==
X-Forwarded-Encrypted: i=1; AJvYcCVM0RD+lBsoeE4axaAL8BGiRVo2vRHdztzQSiReqvvEptPn8rfEWHXQrwSAc0dGTlkQpiQ1SYznTR3nA2G67NUNQ3JZ0Zji
X-Gm-Message-State: AOJu0YyRrf2rfosvqWyzNy0twhACWpd/CFiVqUPvZCSWuAlnniXbxWWO
	/aA6AOFCUcOqPiSFYzvDDwiGyF6+ayrM5Sgdj+ZrqdOtcouZLwOao6jvtAw7+A==
X-Google-Smtp-Source: AGHT+IFoEot39/qLHaxa6y/Sw82Et10+AuC9CeTanjVjdFZOOpZp9e5OHYQltsAxMxQ/WGS4zPKfGA==
X-Received: by 2002:a05:600c:500b:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-429ddc8a1ebmr110625e9.6.1723580740634;
        Tue, 13 Aug 2024 13:25:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a608:a4cb:f4c2:6573])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429dea45445sm943535e9.6.2024.08.13.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:25:40 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v2 0/2] userfaultfd: fix races around pmd_trans_huge()
 check
Date: Tue, 13 Aug 2024 22:25:20 +0200
Message-Id: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDBu2YC/32NQQrCMBBFr1Jm7UgmVLSuvId0YZNJMlCbktSil
 Nzd2AO4+fA+/Pc3yJyEM1ybDRKvkiVOFfShARMek2cUWxm00q26kMaXcxaXMKMbpYa8USvXkSM
 60dBB3c2Ja707733lIHmJ6bNfrPRr/9lWQoWtM2SHszHWqpuP0Y98NPEJfSnlC91gx0CzAAAA
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelianov <xemul@virtuozzo.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723580736; l=2085;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=uPZbHC8CGUlf/x8Q+x+KQ3vLMFUd1MWESPzfxfGXEFE=;
 b=T2zzW+NCfodiI+EDaSAYC8DlWgR0OKZs3VhkAe8fiH7o38AHgADYuunZE4nL6DePHkDrsi+Nq
 V7e6FCKZvtHDSpQhBGqViYvRbDaHTR1ErIRFdP5Ddtww9JAY/XVgJpQ
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The pmd_trans_huge() code in mfill_atomic() is wrong in three different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. As pointed out by Qi Zheng, pmd_trans_huge() is not sufficient for
   detecting PMDs that don't point to page tables.
   On older kernels (before 6.5), you'd just have to win a single fairly
   wide race to hit this.
   I've tested this on 6.1 stable by racing migration (with a mdelay()
   patched into try_to_migrate()) against UFFDIO_ZEROPAGE - on my x86
   VM, that causes a kernel oops in ptlock_ptr().
3. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these (one fix for bugs 1+2,
one fix for bug 3), so that the first fix can be backported to kernels
affected by bugs 1+2.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- in patch 1/2:
  - change title
  - get rid of redundant early pmd_trans_huge() check
  - also check for swap PMDs and devmap PMDs (Qi Zheng)
- Link to v1: https://lore.kernel.org/r/20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com

---
Jann Horn (2):
      userfaultfd: Fix checks for huge PMDs
      userfaultfd: Don't BUG_ON() if khugepaged yanks our page table

 mm/userfaultfd.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)
---
base-commit: d4560686726f7a357922f300fc81f5964be8df04
change-id: 20240812-uffd-thp-flip-fix-20f91f1151b9
-- 
Jann Horn <jannh@google.com>



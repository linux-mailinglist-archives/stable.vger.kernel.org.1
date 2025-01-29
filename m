Return-Path: <stable+bounces-111192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BFFA221DB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328C516735F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8891DD9A8;
	Wed, 29 Jan 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffjvDOki"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063471442E8
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168632; cv=none; b=hYGNCz7XwJjTCyv2CsTX9/O9fYAjb/J1i+j8aAASfsmoKG8XyK9dLu7LwI0ycB6gqTdYi0wBHxKPFWJx+Tjc9rhYhNHAZgFAZh9UjSlORqMeLPmEyNVTkuw/PgroROQkYuBRQqXmX8fyaoU3fRFBVGm1LJVzWL1gezV6Ea/hlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168632; c=relaxed/simple;
	bh=wvlmLDf4WkfbItL+QQLyqJ0a6TkWkpTj7MV/hnR4oYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=B7zaJk0eQyVPjrP3J4raX5XuPRYS7EOCgVbNuomPJs5jvAJd/xig1WSiENGYmlNGNBYIhrwKMtmgnP36nMbUAg81rhHY/t88i0ERCs64HA9z8WoIirFXCrJuihA99aJPddu1DXwrmftsN1sLcATg9+YZpWK2kEFwQi5q8vwRTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffjvDOki; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dc5369fad7so2079112a12.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738168629; x=1738773429; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lehfg3wuaXEf1PR37LQ4lOrTe4zZ2dvzFqwGyADzrIY=;
        b=ffjvDOki4XEJNhlrgjVG7lBNY9/qNONCqvUHbYKiA2e98MKcFKZu57ECRJEWXZsorF
         2RcjO+goMR4mTN8ggu1M8j1/uWjYbYChZ+Mfu6Y3sZVL+WC578UvzMnzWi/nvP+Cc3Mj
         BCXSxJOacILDncRiYcWxl1M7KT+rF0F8qwyCbRVSMk4VU9CJ+np65+ZHlb6JUrLasHPm
         UO7ZibUaqde/6gCerbxac6jT9UDD5YImVFYlVCH6JzrqwN49c/Egy4QakvWfXv4ddTSm
         TW28lq14Y8hjAe6nyR6s+EeXTN+otUpvqNruUYthN4weaHEOvW/wjpOwZWA9BofHiQbO
         ZAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168629; x=1738773429;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lehfg3wuaXEf1PR37LQ4lOrTe4zZ2dvzFqwGyADzrIY=;
        b=miUz3aPIArMYG8KgR33Q3/H5QEKOQAMjva00luHBJTf3Chs300WNllHDFg/z+MNICT
         ByJ5LWwNUFjSGn1I0dvLf2o1O3fWiF5ORyfxQ1TvGP4AD0M911DTmqC8tf/nPglVKh59
         pNHdgzaznq9hj3unbtCuTvRD7eU7ouFDsVJ7levVPuw48TWjNo8EaZxLmQIEiuWgo63h
         k9LZjnIe8FPuEjW+eXRr2RLyuQs8doHfPGo3zfheqopyW3kfDllzoX/XUkQcZl5ilwK4
         WXBSR6+20pzgxzXtV+zeU2GHZqW8vxzpxhOpBOZsNAekJ+9KL+UGQ9rQq9aydZQxcPj8
         IF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUSbIh+ce2vl3fc2bn+irOfWJ3s5vcfxqSdUN87IibyadyXsqvRdf4aYEV/S6BpuncuZ8mmhH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYt251jsfIcmmPYomp7BZ2p0dUMixj73zqwtzyr+BkKsxPo4U6
	sxBanDgYMs/pcu77TfXl2L6AFNVfRDNpTSfrcM7+Os78dh4gVou34Szd7FuUUx70mQ3mV4EyjQH
	sN+yhJRwBRbBJ8g==
X-Google-Smtp-Source: AGHT+IHPEzUQTANQIDwbp24nmcPebb2zhYZmx2Pc7DOS9Yvyvxs1kK1bfxOagSt9y+DmFUZWpXbTJribXMYbcS8=
X-Received: from edbfj26.prod.google.com ([2002:a05:6402:2b9a:b0:5d2:7458:3fe6])
 (user=ciprietti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3587:b0:5db:67a7:e742 with SMTP id 4fb4d7f45d1cf-5dc5efbf55cmr2721415a12.8.1738168629387;
 Wed, 29 Jan 2025 08:37:09 -0800 (PST)
Date: Wed, 29 Jan 2025 16:36:30 +0000
In-Reply-To: <20250129163637.3420954-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129163637.3420954-1-ciprietti@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129163637.3420954-2-ciprietti@google.com>
Subject: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
From: ciprietti@google.com
Cc: ciprietti@google.com, Tejun Heo <tj@kernel.org>, 
	Abagail ren <renzezhongucas@gmail.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af ]

blkcg_unpin_online() walks up the blkcg hierarchy putting the online pin. To
walk up, it uses blkcg_parent(blkcg) but it was calling that after
blkcg_destroy_blkgs(blkcg) which could free the blkcg, leading to the
following UAF:

  ==================================================================
  BUG: KASAN: slab-use-after-free in blkcg_unpin_online+0x15a/0x270
  Read of size 8 at addr ffff8881057678c0 by task kworker/9:1/117

  CPU: 9 UID: 0 PID: 117 Comm: kworker/9:1 Not tainted 6.13.0-rc1-work-00182-gb8f52214c61a-dirty #48
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
  Workqueue: cgwb_release cgwb_release_workfn
  Call Trace:
   <TASK>
   dump_stack_lvl+0x27/0x80
   print_report+0x151/0x710
   kasan_report+0xc0/0x100
   blkcg_unpin_online+0x15a/0x270
   cgwb_release_workfn+0x194/0x480
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ...
  Freed by task 1944:
   kasan_save_track+0x2b/0x70
   kasan_save_free_info+0x3c/0x50
   __kasan_slab_free+0x33/0x50
   kfree+0x10c/0x330
   css_free_rwork_fn+0xe6/0xb30
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30

Note that the UAF is not easy to trigger as the free path is indirected
behind a couple RCU grace periods and a work item execution. I could only
trigger it with artifical msleep() injected in blkcg_unpin_online().

Fix it by reading the parent pointer before destroying the blkcg's blkg's.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Abagail ren <renzezhongucas@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Fixes: 4308a434e5e0 ("blkcg: don't offline parent blkcg first")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
---
 include/linux/blk-cgroup.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0e6e84db06f6..b89099360a86 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -428,10 +428,14 @@ static inline void blkcg_pin_online(struct blkcg *blkcg)
 static inline void blkcg_unpin_online(struct blkcg *blkcg)
 {
 	do {
+		struct blkcg *parent;
+
 		if (!refcount_dec_and_test(&blkcg->online_pin))
 			break;
+
+		parent = blkcg_parent(blkcg);
 		blkcg_destroy_blkgs(blkcg);
-		blkcg = blkcg_parent(blkcg);
+		blkcg = parent;
 	} while (blkcg);
 }
 
-- 
2.48.1.262.g85cc9f2d1e-goog



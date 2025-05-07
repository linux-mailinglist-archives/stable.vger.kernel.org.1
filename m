Return-Path: <stable+bounces-142762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0DAAED29
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6537E1C42A93
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F521ABA3;
	Wed,  7 May 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="K6hUY1K0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAF1DE3DB
	for <stable@vger.kernel.org>; Wed,  7 May 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650339; cv=none; b=h/EYW24ZTktl083W1Cov2+rCREOonFgb64iBZ9VNSmuJo08481FCY0pzBqwmYxktRQOR3/Hf6pDf3TlQ/aK4kyJAboae6b1//8zr2nw5JeG04nR3tXVXuormnBnIAAwamH0XRKXTgbkP7C9yXUpFT+fdxr0OlORDP8El8LPy3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650339; c=relaxed/simple;
	bh=H12n5G79M55nGs6asZ/phHaUJuYGkuHa1wBE5cwU54g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+YON1kjT7jMvKrb6PpwRkM2+fpPb2vAJFbYlGPHjUY9ZX8u9hZfJcHOrOgtk4X9roPHHuPE5P1MhimKmgsTx+R5FhRkW9rP39zp5yNLzu1TSD6IEhHRZJkSHkcQDXdBBGbdYQ+xf4Hvu9HqjWEZk4y2bZdaW+edtyncgBxyNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=K6hUY1K0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22de5af5e14so396085ad.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1746650336; x=1747255136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5G5S/7oUYe6KsPk0KKPv1/CSdjYHqfwdHXoMpV5Do4=;
        b=K6hUY1K06BnaPyB2Rbly7ihrG4O3MWKXNO7LqHanh+Kv9rVeq/DMBTQ7VAPt2FR6oU
         0Zwq/T5HuOro2E5PXXPMOPSnaTJ3iWgpJj64vkPT4EKsDz4x6OyQ1XfM5jBdOFKOjFLh
         Knd9tv3QHBD8Mvi9GyebRaM2Ge1mY7iWMktVhB8Fr5o6ZC9vmvbLt2fFxkAtNtZpsi7q
         mKtvbaVs46mJnfq5tFeAsMqfAozrFh/ltqDv/+C7zrTw0XhwRuUjjUxfhbVmbgLBm7kf
         rF8gYdPl92D2+TAfBigHTCFRS6TgapOGXygNL6Ia+mbUDolkFmz/xLhnQJvjE0pbSqfc
         TIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650336; x=1747255136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5G5S/7oUYe6KsPk0KKPv1/CSdjYHqfwdHXoMpV5Do4=;
        b=WLXI4jvv7E3zA2RDmu/GKUX5ZpXNYjTaG6QEqnuaDjmR7ilpVYMwFCQzRbj/lHX8/H
         ZOVn9up2NiKBdpQiakOewNJHYFsR137MLbMdpegaAeznw3WBGnIk3aIWH9QmspO3UpXI
         sldj888qjDMwINhj9w8oP2/7MCYOV4oTdlgKK7ibS4KBeSaxUhgKbp6WqYqKtlft24aw
         hEcDQ4QrFkq3hIJKdzkcx8prcPMzm4fkfJyOZTkd269Ss3OezpJV47TyzOj+gQwPamRf
         9Wl2DF2Tkz1iRMjtUr1YaiEskhr5tDIvMnC5ofCYLjSnK11x8Lx54VkMVOUazuV/G2ST
         J1ZQ==
X-Gm-Message-State: AOJu0Yzq5TabR2Drlfce5zX9kYAIAvlffqv3DX0Iqk4Sj9muiKcdR+/d
	lBl3ETzTmosU2tXWZvHCSI2OfH1GHRE+rmHR2U8admSC++2l+kmjDc5bMOPcKdHnH6x6N9kKPHR
	r
X-Gm-Gg: ASbGncuy6iwMeR0MK/KGZ4hAEb4fVZWRCx2JJaMoXRgBoyo0qISjZ5QC/zlq79jRKqs
	feHOdkuIkd+1LiVX76XYzfnofIdV5beyY2PaAhK5sHow2g2sKaxeqxKIaorf5MXBLQSMwNFP+lZ
	MX3mpAPajvxUzel0n9ymWBwCLRzcASzlZp11poUY0sOn4OazX4yQlkCMKaND2T7cFR+afDHnqxM
	10I0wuCaQWJ5zLgJ9I3vI+j0IvQPApYHaU4vs6GiVooqGf1FteWr5zBb8cLCgXXUgdwHXCcTaqA
	XlsD4ei5radSFVzZSqvrdF57DPQ6QWKJrrdmIV6fxHrLycCUWQ==
X-Google-Smtp-Source: AGHT+IHvsOegA0k5mpHdmlaycml4Y6XtPZ9lnlT5iYoZ6jIxmcrGtEq0tImlFTKyRYFDUe2nCpM5ug==
X-Received: by 2002:a17:903:990:b0:223:28a8:610b with SMTP id d9443c01a7336-22e5ee1cb10mr21923945ad.14.1746650336104;
        Wed, 07 May 2025 13:38:56 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::5:2b0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e3b99dce9sm39562915ad.6.2025.05.07.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:38:55 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.12] sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash
Date: Wed,  7 May 2025 13:38:37 -0700
Message-ID: <9c0ce2024e862b3ee99bda8c16fbe9d863a9b918.1746650111.git.osandov@fb.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

commit bbce3de72be56e4b5f68924b7da9630cc89aa1a8 upstream.

There is a code path in dequeue_entities() that can set the slice of a
sched_entity to U64_MAX, which sometimes results in a crash.

The offending case is when dequeue_entities() is called to dequeue a
delayed group entity, and then the entity's parent's dequeue is delayed.
In that case:

1. In the if (entity_is_task(se)) else block at the beginning of
   dequeue_entities(), slice is set to
   cfs_rq_min_slice(group_cfs_rq(se)). If the entity was delayed, then
   it has no queued tasks, so cfs_rq_min_slice() returns U64_MAX.
2. The first for_each_sched_entity() loop dequeues the entity.
3. If the entity was its parent's only child, then the next iteration
   tries to dequeue the parent.
4. If the parent's dequeue needs to be delayed, then it breaks from the
   first for_each_sched_entity() loop _without updating slice_.
5. The second for_each_sched_entity() loop sets the parent's ->slice to
   the saved slice, which is still U64_MAX.

This throws off subsequent calculations with potentially catastrophic
results. A manifestation we saw in production was:

6. In update_entity_lag(), se->slice is used to calculate limit, which
   ends up as a huge negative number.
7. limit is used in se->vlag = clamp(vlag, -limit, limit). Because limit
   is negative, vlag > limit, so se->vlag is set to the same huge
   negative number.
8. In place_entity(), se->vlag is scaled, which overflows and results in
   another huge (positive or negative) number.
9. The adjusted lag is subtracted from se->vruntime, which increases or
   decreases se->vruntime by a huge number.
10. pick_eevdf() calls entity_eligible()/vruntime_eligible(), which
    incorrectly returns false because the vruntime is so far from the
    other vruntimes on the queue, causing the
    (vruntime - cfs_rq->min_vruntime) * load calulation to overflow.
11. Nothing appears to be eligible, so pick_eevdf() returns NULL.
12. pick_next_entity() tries to dereference the return value of
    pick_eevdf() and crashes.

Dumping the cfs_rq states from the core dumps with drgn showed tell-tale
huge vruntime ranges and bogus vlag values, and I also traced se->slice
being set to U64_MAX on live systems (which was usually "benign" since
the rest of the runqueue needed to be in a particular state to crash).

Fix it in dequeue_entities() by always setting slice from the first
non-empty cfs_rq.

Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/f0c2d1072be229e1bdddc73c0703919a8b00c652.1745570998.git.osandov@fb.com
---
Stable backport to 6.12.y resolving a trivial conflict in the patch
context.

Thanks,
Omar

 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceb023629d48..990d0828bf2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7182,9 +7182,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
-	} else {
-		cfs_rq = group_cfs_rq(se);
-		slice = cfs_rq_min_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7194,6 +7191,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			if (p && &p->se == se)
 				return -1;
 
+			slice = cfs_rq_min_slice(cfs_rq);
 			break;
 		}
 
-- 
2.49.0



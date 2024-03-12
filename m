Return-Path: <stable+bounces-27417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E66878BFC
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 01:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B13B21AE7
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E7E2;
	Tue, 12 Mar 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evo7AkTb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E863A
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204303; cv=none; b=Pk2b3zFC8qcvKVDup1pmrUNeOzgt6vUJ2HlG0ykRkYjhAIhewXang6gureIfZk87zjMZutX9JQzZnGfpCc/esEhUr1gcSzNpcs98g26jGsFCR2wKjxf7SuG14ABQ5n/qSI++E5w+5svmkYPSAdLY9l4aEQnEv0YUKMKBuaB/8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204303; c=relaxed/simple;
	bh=jOPQO/sQrZbgoRL3VziEPGAiDP+LpoBeGnEkhJn/G6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjyGEGZ1WGizkoixVWgb1G4DsMtOIa4EVi0Kxgy7G9LzwKxiqdvLhrwcqYEnRK6KL7k25xdckooIn7H9fp6OZuNv1hhAQr0XSfX+0hDSqxMBApJZTfJEBRQpkeY1N9YLRsPiJLRJhMpWAD0cSO9JLe3yZI5lsZ0tvpsQk33zEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evo7AkTb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fb151752so81048407b3.2
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710204301; x=1710809101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+423QzfPGHi1Ohps0EUK15lweuc6HtRghZ2Ek0SeCrw=;
        b=evo7AkTb19XYFMs6dzZYJrK7GwSXTN0D8MhpR4qK73aX0xBEKVJmJDJ3+YjaM69xAi
         595Yu+gRlK3Gtx8u+ZWeE3EHHAmtxk0rfqvGJpmVSdQn3jot53UdyX0Lcy0zcd8Dht58
         Dlx8UHBqLaSua4zeDnZ7gCqewOLaHvS/NmBUW93f85JUM3tBsLlf9G6fftbybjo16QlS
         cengoHi/n8IgsYfXffRhTX1APcEaZn9XZMpuD1XvGxWRm7X2rAMnR1Q+arKVuJeKUTZ9
         aVpPYMxjbH/fuVMUsFW2kf09dvmd8ANGAhuCo3eL4EXjAj/S4aNifY6BsEIobD6czJZn
         R7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710204301; x=1710809101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+423QzfPGHi1Ohps0EUK15lweuc6HtRghZ2Ek0SeCrw=;
        b=w9YZHWfZSP4Z3L3U4WpK/SBU4hdgu9Q2QD8jEeoAMC3nPFLbBZJJ5UQB6tDqEACRxK
         dPibdr8pOneHmEFaOaxI71heBA/WeNu8ICgS9IDHNqW8Fl7IpdVQSlGXMKAF6SKz9pPv
         Lr6IeO//Fypp8MaFtEwETsrbQLpHw/dBQkBj4u0btz0hdcG1+baGyAdkVXm13p5MdWHw
         8hxOK4ObLnMVPvKEcVevs2pza9PPRDgKkOV7G/hgScXT3sTntfApHAzKcYwq0Jf8AP8X
         QUnP94C/igYm9rE7n3DgosrI14xN8RIs/LVKmm16kq1jTKoR2vsJcCXrx87QMlsWHrKT
         19Ew==
X-Gm-Message-State: AOJu0YyMPJsvIx1TEI09/A+NEXoSoOkn0EqRIEf1cQJbY9wxL9q32z6F
	jhmEPSzn6NEAbszq9uDkC0UDVdOKSy2HDcesjX0ktCLrHHyd7slqP7cxgxCwRNLOHkpWJ8xae+H
	FEwPDEmmbDSCadRmXmvLY/mnXyu9u1bWFcgUetY6DIzUGSDFCFySWARszuU1ob3bqFa8TP0viDz
	ZzIwL+dDD8o5SMHKXgal0esielVF3r9nA1Wm4Eyu0KDVlDtoQ0bVjhOc6qhA==
X-Google-Smtp-Source: AGHT+IHa690j43V4n/0t0pIkp8qPJerHzTcW0sTmPDMrvEOPSfhPLiT5bGX9PBYXSRhaE+1j1Ls796CvznGaI2K94g==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a05:6902:f11:b0:dc9:c54e:c5eb with
 SMTP id et17-20020a0569020f1100b00dc9c54ec5ebmr2274384ybb.7.1710204300734;
 Mon, 11 Mar 2024 17:45:00 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:44:35 -0700
In-Reply-To: <cover.1710203361.git.rkolchmeyer@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1710203361.git.rkolchmeyer@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <051c8ce7224af8ca4957e26bbd9bbc23e77f9a16.1710203361.git.rkolchmeyer@google.com>
Subject: [PATCH v5.10 2/2] bpf: Defer the free of inner map when necessary
From: Robert Kolchmeyer <rkolchmeyer@google.com>
To: stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>, Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Robert Kolchmeyer <rkolchmeyer@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 876673364161da50eed6b472d746ef88242b2368 ]

When updating or deleting an inner map in map array or map htab, the map
may still be accessed by non-sleepable program or sleepable program.
However bpf_map_fd_put_ptr() decreases the ref-counter of the inner map
directly through bpf_map_put(), if the ref-counter is the last one
(which is true for most cases), the inner map will be freed by
ops->map_free() in a kworker. But for now, most .map_free() callbacks
don't use synchronize_rcu() or its variants to wait for the elapse of a
RCU grace period, so after the invocation of ops->map_free completes,
the bpf program which is accessing the inner map may incur
use-after-free problem.

Fix the free of inner map by invoking bpf_map_free_deferred() after both
one RCU grace period and one tasks trace RCU grace period if the inner
map has been removed from the outer map before. The deferment is
accomplished by using call_rcu() or call_rcu_tasks_trace() when
releasing the last ref-counter of bpf map. The newly-added rcu_head
field in bpf_map shares the same storage space with work field to
reduce the size of bpf_map.

Fixes: bba1dc0b55ac ("bpf: Remove redundant synchronize_rcu.")
Fixes: 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in sleepable programs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-5-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 62fca83303d608ad4fec3f7428c8685680bb01b0)
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
---
 include/linux/bpf.h     |  7 ++++++-
 kernel/bpf/map_in_map.c | 11 ++++++++---
 kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bfdf40be5360..a75faf437e75 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -175,9 +175,14 @@ struct bpf_map {
 	 */
 	atomic64_t refcnt ____cacheline_aligned;
 	atomic64_t usercnt;
-	struct work_struct work;
+	/* rcu is used before freeing and work is only used during freeing */
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
 	struct mutex freeze_mutex;
 	atomic64_t writecnt;
+	bool free_after_mult_rcu_gp;
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0cf4cb685810..caa1a17cbae1 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -102,10 +102,15 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 
 void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
-	/* ptr->ops->map_free() has to go through one
-	 * rcu grace period by itself.
+	struct bpf_map *inner_map = ptr;
+
+	/* The inner map may still be used by both non-sleepable and sleepable
+	 * bpf program, so free it after one RCU grace period and one tasks
+	 * trace RCU grace period.
 	 */
-	bpf_map_put(ptr);
+	if (need_defer)
+		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	bpf_map_put(inner_map);
 }
 
 u32 bpf_map_fd_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 16affa09db5c..e1bee8cd3404 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -493,6 +493,25 @@ static void bpf_map_put_uref(struct bpf_map *map)
 	}
 }
 
+static void bpf_map_free_in_work(struct bpf_map *map)
+{
+	INIT_WORK(&map->work, bpf_map_free_deferred);
+	schedule_work(&map->work);
+}
+
+static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
+{
+	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
+}
+
+static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_map_free_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_map_free_rcu_gp);
+}
+
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (unrelying map implementation ops->map_free() might sleep)
  */
@@ -502,8 +521,11 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map, do_idr_lock);
 		btf_put(map->btf);
-		INIT_WORK(&map->work, bpf_map_free_deferred);
-		schedule_work(&map->work);
+
+		if (READ_ONCE(map->free_after_mult_rcu_gp))
+			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+		else
+			bpf_map_free_in_work(map);
 	}
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog



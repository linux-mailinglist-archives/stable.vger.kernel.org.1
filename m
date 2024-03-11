Return-Path: <stable+bounces-27410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACAB878A17
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC611C20E8F
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF157873;
	Mon, 11 Mar 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOY1/lI8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1457323
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192638; cv=none; b=K0p4LUt7IucchXFnn6aNAxe5EQQLMOYbeLBxn/9KOVjRAxQ3uS4+B6iWB1dm1bo/9WK687mMp8abeSKtZzvw9ACqkbwVMDPuRVv+2sWXRYpY1H8TTRX6PMLvZQbaBy568BAYhI/Sfs629rCDOP5nK9y+cYyCbrCJJAQHwkxDX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192638; c=relaxed/simple;
	bh=kj9c5Fkf/ZThXac1ngVsG8KrKeM0bPMBEyyZeN2zc1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j2hxkBzV3OAloIr4u/5qb7di4T2YRF3qxkVQy0WREKdni8DvV/cs/k3NIjQ5y3gEII2Z3Lz/BYGW7XmvSth3qx6jI+nPWsmt2thvGXNStj2xpXTeRuWMUFwUo2rSBJiXc11nHaX1Al6jdqfdlGcVxF8FEesIkys+jBXtasxRWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOY1/lI8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so5978666276.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192636; x=1710797436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8SqlV4fJBEcvX79ldbSndCs3zksDsh+nspZsE73jbQ=;
        b=OOY1/lI8DswSmwUye7g697VGZOLiikfeHMVJEO8RNmLcr2yMg5fX4Op5dlV8S9a8Fg
         f9s7+iARczBmOCXSvGEpKVFlupmZxNJCI8k1fCQi36MoBacWq3zbotlH/JpJkD8H0dLl
         2AGou1IvQFe7ASqok0HWXIjLlfkrVhzSlhZtNkSgGxKCvkoQGPaVUX/TvYlpyAQSEW6v
         i6U/ku3jn/1o5X3LeScxBpA5pxcJZ40drCgwMQ+HoUt+8ZWIkxObGYezJB23JEER/z30
         qgYM28hc9to2/ILRLU4y6dyRbvZBmudEyqNmuvXIOyOoOrM+R9rMy8SjZJuwPeE0LWlp
         ghaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192636; x=1710797436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8SqlV4fJBEcvX79ldbSndCs3zksDsh+nspZsE73jbQ=;
        b=J3Ceem3sd1NRvoj7R7ZyGokgIe6bCiSTOA4LX0rb3/20RnFyhSryGsi7ti/HKGoKIO
         FSVX8GHmLIIXnX1SNfyfrt2vpSJTrwoAZy3yn5oH9Oh/CYb5YH0otL2IYDY9aUKb5ZdM
         OXc0fa09/sEBK3fK5taI8l1aJPqx4aIWRKPS0fLRvKStoVge3u60NlNcsCPQ5N6vVqSR
         aJSv0o5/3TCPJRdMaPQSZYUwBLO60YjgpasASSqJQ8JH7mwnBZMJHunAeg/eM0GATTOc
         oGu9lr5Lhmi5fj+yz0fVy1iHP6odReSHqsrzKI9T6AbzhOTkUAWb0NSXkcm5g6u2A99v
         OEiA==
X-Gm-Message-State: AOJu0YwZL6+zEpb9D7w/V6gyrIU6buoxlgHR3r/u7yjNrYNiGyfi6Br2
	jmKhDHxMrjnPb9JN0IBBdqT7Ed3eCSZ12waR4dDneg5cyaHUrZLrT2sJ5U0n43qmLSjmuiPG3xH
	daXxvZ7twA9QIi0USbhPaLDLYGiDk5tLwzGj52ycTW8tr8fiTp6nHDHhmKUV08ME0vam8IwhPiJ
	sjSFXpXJ7zDs9hvRd6V4z9hZexLkjy6G6HoLyvjHyp9omX1Pvvjz8+rgkGrg==
X-Google-Smtp-Source: AGHT+IFtk7hVKltBBGssAFRgWs5pfzkXMO/QDammyiLSquLxcD0JaHnfw4oBwSjv/PEb9l2lGDvisgFvGjfPEX+jNA==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a05:6902:124b:b0:dc2:26f6:fbc8 with
 SMTP id t11-20020a056902124b00b00dc226f6fbc8mr69456ybu.7.1710192636097; Mon,
 11 Mar 2024 14:30:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:30:22 -0700
In-Reply-To: <cover.1710187165.git.rkolchmeyer@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1710187165.git.rkolchmeyer@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <364eb5612b9288ce42c3b2e579e6c53b4cc29f49.1710187165.git.rkolchmeyer@google.com>
Subject: [PATCH v5.15 2/2] bpf: Defer the free of inner map when necessary
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
index 97d94bcba131..df15d4d445dd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -192,9 +192,14 @@ struct bpf_map {
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
index af0f15db1bf9..4cf79f86bf45 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -110,10 +110,15 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 
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
index 64206856a05c..d4b4a47081b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -487,6 +487,25 @@ static void bpf_map_put_uref(struct bpf_map *map)
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
@@ -496,8 +515,11 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
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



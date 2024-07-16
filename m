Return-Path: <stable+bounces-60052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D6932D29
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5474EB20B76
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452E17623C;
	Tue, 16 Jul 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJk1UN6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3E1DDCE;
	Tue, 16 Jul 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145711; cv=none; b=Ef8W/eP5cjKU/nNj7CRoAHYyj40lgnJPofmmgkV1yU9/bRpncyOxatzBz43KQUT+7Abt3e6wUa2bU0dyQqQxgpgbN12t0HFCyJ6DRjZAeFJZbAS73i/YVIBLyvJTeArB4WB09EuExRnOsxXrX77gCpuIz94otjLasQ4I87T+8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145711; c=relaxed/simple;
	bh=tUHuPRcL6oXQRKLnHNeIBgLScdCFOG/IUyrueMdcQjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e936Ue5MkqQ428ebrL6wlBrHEsK2AyzieRPAnDZ/xw/YcMkTmpGXjGcwROPBleqINKw0Gx0BRZARHawbamN0bqgRWh/5hNnchgWrHipKZNJnaWHVfmGj/M1o3zy9GhXZN0OzEMB10Cu7ahj2tG64k1Jws3UTwDyJ9CiTbhu7nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lJk1UN6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F80C116B1;
	Tue, 16 Jul 2024 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145711;
	bh=tUHuPRcL6oXQRKLnHNeIBgLScdCFOG/IUyrueMdcQjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJk1UN6UqLWL/YR91p0KA6HrF8oMQ2rx0aoggr2B3QRZ7npp2XJSoQAVicH1NsAoR
	 Ob41/Vuc2xUZWytPsffuwgoUET4ndICuyXj2SJY1c6w6rbKpL1zzEkSqrkdSRZUh8S
	 H4FJoTG4VXM0ORCkG+KO3uyruQLYouJNVd62Qvrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 028/121] bpf: replace bpf_timer_init with a generic helper
Date: Tue, 16 Jul 2024 17:31:30 +0200
Message-ID: <20240716152752.406709084@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <bentiss@kernel.org>

[ Upstream commit 56b4a177ae6322173360a93ea828ad18570a5a14 ]

No code change except for the new flags argument being stored in the
local data struct.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/r/20240420-bpf_wq-v2-2-6c986a5a741f@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: d4523831f07a ("bpf: Fail bpf_timer_cancel when callback is being cancelled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 91 ++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b7669e1236f70..c34c93aa5a5e7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1110,7 +1110,10 @@ struct bpf_hrtimer {
 
 /* the actual struct hidden inside uapi struct bpf_timer */
 struct bpf_async_kern {
-	struct bpf_hrtimer *timer;
+	union {
+		struct bpf_async_cb *cb;
+		struct bpf_hrtimer *timer;
+	};
 	/* bpf_spin_lock is used here instead of spinlock_t to make
 	 * sure that it always fits into space reserved by struct bpf_timer
 	 * regardless of LOCKDEP and spinlock debug flags.
@@ -1118,6 +1121,10 @@ struct bpf_async_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+enum bpf_async_type {
+	BPF_ASYNC_TYPE_TIMER = 0,
+};
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1159,46 +1166,55 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
-BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
-	   u64, flags)
+static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
+			    enum bpf_async_type type)
 {
-	clockid_t clockid = flags & (MAX_CLOCKS - 1);
+	struct bpf_async_cb *cb;
 	struct bpf_hrtimer *t;
+	clockid_t clockid;
+	size_t size;
 	int ret = 0;
 
-	BUILD_BUG_ON(MAX_CLOCKS != 16);
-	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
-	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
-
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	if (flags >= MAX_CLOCKS ||
-	    /* similar to timerfd except _ALARM variants are not supported */
-	    (clockid != CLOCK_MONOTONIC &&
-	     clockid != CLOCK_REALTIME &&
-	     clockid != CLOCK_BOOTTIME))
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		size = sizeof(struct bpf_hrtimer);
+		break;
+	default:
 		return -EINVAL;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
+	}
+
+	__bpf_spin_lock_irqsave(&async->lock);
+	t = async->timer;
 	if (t) {
 		ret = -EBUSY;
 		goto out;
 	}
+
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
-	if (!t) {
+	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->cb.value = (void *)timer - map->record->timer_off;
-	t->cb.map = map;
-	t->cb.prog = NULL;
-	rcu_assign_pointer(t->cb.callback_fn, NULL);
-	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-	t->timer.function = bpf_timer_cb;
-	WRITE_ONCE(timer->timer, t);
-	/* Guarantee the order between timer->timer and map->usercnt. So
+
+	if (type == BPF_ASYNC_TYPE_TIMER) {
+		clockid = flags & (MAX_CLOCKS - 1);
+		t = (struct bpf_hrtimer *)cb;
+
+		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+		t->timer.function = bpf_timer_cb;
+		cb->value = (void *)async - map->record->timer_off;
+	}
+	cb->map = map;
+	cb->prog = NULL;
+	cb->flags = flags;
+	rcu_assign_pointer(cb->callback_fn, NULL);
+
+	WRITE_ONCE(async->cb, cb);
+	/* Guarantee the order between async->cb and map->usercnt. So
 	 * when there are concurrent uref release and bpf timer init, either
 	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
 	 * timer or atomic64_read() below returns a zero usercnt.
@@ -1208,15 +1224,34 @@ BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(timer->timer, NULL);
-		kfree(t);
+		WRITE_ONCE(async->cb, NULL);
+		kfree(cb);
 		ret = -EPERM;
 	}
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_spin_unlock_irqrestore(&async->lock);
 	return ret;
 }
 
+BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
+	   u64, flags)
+{
+	clock_t clockid = flags & (MAX_CLOCKS - 1);
+
+	BUILD_BUG_ON(MAX_CLOCKS != 16);
+	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
+	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
+
+	if (flags >= MAX_CLOCKS ||
+	    /* similar to timerfd except _ALARM variants are not supported */
+	    (clockid != CLOCK_MONOTONIC &&
+	     clockid != CLOCK_REALTIME &&
+	     clockid != CLOCK_BOOTTIME))
+		return -EINVAL;
+
+	return __bpf_async_init(timer, map, flags, BPF_ASYNC_TYPE_TIMER);
+}
+
 static const struct bpf_func_proto bpf_timer_init_proto = {
 	.func		= bpf_timer_init,
 	.gpl_only	= true,
-- 
2.43.0





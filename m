Return-Path: <stable+bounces-165814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8DB192F9
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86C43A7E75
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C79281353;
	Sun,  3 Aug 2025 07:22:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB64315C;
	Sun,  3 Aug 2025 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205757; cv=none; b=e1P+9SoSPUHUyBtOGchsLsd7QA5jnCFaDM4gKYN7gFzPwqDkeg9kysxYMbAMXlPTBLNdGBJNnZCZuSPwoEEJETwONewwzX8eiVYhlSSPALEGoZc/y7HxwoSwWGyOYCNiqqXmfsMzM1dP/7nxHLYYNZ32EB9do1O3H0f8ovrUoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205757; c=relaxed/simple;
	bh=a1wPu7qWEqbXSE3m92o14aGzkXL9K+CEYt6wZ0QdWlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neAlvVSfEF/bRBbcJ1ZmNqK9hW3nsJM1h8QA6FTEuESPcuxT+Dz4Y8fr3Lp4giwofYwUkAUbXVJqO+vy6O0n+zgtomWQ1gHp+TWCiwelMjlDa6XMMd4rbwwVFH6iT6gBgJqkvfM6C7nDCLOugRKPxNkLNnnv0o0ocv5YeH5CloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2420c9e3445so5047395ad.2;
        Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205755; x=1754810555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jgd1GNOsYadrfuybM239b5t7yZLqoDPXrAoeKpSwNM=;
        b=IItYMoWkBUpuvrXAVvGV0EYE5mrX6JTBqaPc2+d7LlPXlOKejf/HI9RyXH/VMgQLCL
         Exj6JklMBMTflv9nmDBRKuhXFUpU79zwqIH3uMjSTrcHHeDwOQOEH2ALlU7M7jAQsPUw
         asUhY7ae5/+DFI1n1F1zjd8iahs770yqYqXM0toT15xlO9HuynkFuOFXeQYyCobRH8SJ
         RqVJkpLds0mmzuyyN4+KaGhxltbPybwcuDbqyW64UQ129QAA38bQKjabAEI3Xzg/0U0x
         xKwL6wlSdLDmKNEWCJ3QuHeNXKDbm8KxfpPNfJcvKGyv911UmrauCuvxb0QflE8fA3SY
         Z2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUFFB+pq40RViIh9UeQBFBVeW4xWMZyrxumwM+r0l/2nrAh/DVZPb80oFfPzrWEINGruu2HeoIp@vger.kernel.org, AJvYcCWrJsrmXCiqSwIuRZtNyKoq/1O8j2dMi6mK3fZpfYWG7i+XQz8umeyGnbhxz0fSx3MUy36IgRAwMlt0qCw=@vger.kernel.org, AJvYcCWzEzKHkANvoiWTouuWICjTk7qFrJ7mFE8If4RZbTXrNSjexjGeeICkzizAWRrdcgFHZihcTJ1c4yY3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1y4iHbijKznacd7LmF/JammEBj2EUXu+cyO+AUBq5XEjhWnkx
	fnefwkFTNlBbP+jR8DtFUB3+BjEUbw168umVhHVjwidq/bVaoXNJ9Hav
X-Gm-Gg: ASbGnctrFoWV5v0hjYuobeeiCnrXkytEi1plIbJwuqdqoJFKwy51ocLFnfjqiKIKy0K
	Q4IfNTumgw49IiGgDc9ygdbQOHsU52Dyjv6thE9/mcUI0Log2HDPtGGDluv6F4vQ04WnD0opepY
	KiKRA8bns8DU0Q6MbRapOSun63SQKHwi+IjgwsThiraN62aZNmoTrZHjNJA2KlH+tvDW30NidTT
	tGXAjva9tBUL/laWhb1wAOSAOMEECr2Ui3o6MIbLFusav8BYFMJV2JLxhrfFikiepfmDgrAlf+q
	QyDjKDMs2LiSTfFV6YhPok3j1sRaLLEdBPB/t2DMEML+BSo4bXz0Ke9d3PRsS6ir9EXCt8voVb4
	awC93FfOOE0Hu
X-Google-Smtp-Source: AGHT+IEExGu5iIl8dO34DlMWk4OmiF1INIjAC/Q4dK9xAmegQ7x38dfO88DNWfygHfkGxkMXswX2Fw==
X-Received: by 2002:a05:6a20:748c:b0:230:aa8c:f729 with SMTP id adf61e73a8af0-23df8e3d03emr3551485637.0.1754205755356;
        Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH 2/4] kcov: Replace per-CPU local_lock with local_irq_save/restore
Date: Sun,  3 Aug 2025 07:20:45 +0000
Message-ID: <20250803072044.572733-6-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803072044.572733-2-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f85d39dd7ed8 ("kcov, usb: disable interrupts in
kcov_remote_start_usb_softirq") introduced a local_irq_save() in the
kcov_remote_start_usb_softirq() wrapper, placing kcov_remote_start() in
atomic context.

The previous patch addressed this by converting the global
kcov_remote_lock to a non-sleeping raw_spinlock_t. However, per-CPU
data in kcov_remote_start() and kcov_remote_stop() remains protected
by kcov_percpu_data.lock, which is a local_lock_t.

On PREEMPT_RT kernels, local_lock_t is implemented as a sleeping lock.
Acquiring it from atomic context triggers warnings or crashes due to
invalid sleeping behavior.

The original use of local_lock_t assumed that kcov_remote_start() would
never be called in atomic context. Now that this assumption no longer
holds, replace it with local_irq_save() and local_irq_restore(), which are
safe in all contexts and compatible with the use of raw_spinlock_t.

With this change, both global and per-CPU synchronization primitives are
guaranteed to be non-sleeping, making kcov_remote_start() safe for
use in atomic contexts.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 7d9b53385d81..faad3b288ca7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -90,7 +90,6 @@ static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
 
 struct kcov_percpu_data {
 	void			*irq_area;
-	local_lock_t		lock;
 
 	unsigned int		saved_mode;
 	unsigned int		saved_size;
@@ -99,9 +98,7 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -862,7 +859,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -870,7 +867,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode = READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -879,7 +876,7 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -887,7 +884,7 @@ void kcov_remote_start(u64 handle)
 	remote = kcov_remote_find(handle);
 	if (!remote) {
 		raw_spin_unlock(&kcov_remote_lock);
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	kcov_debug("handle = %llx, context: %s\n", handle,
@@ -912,13 +909,13 @@ void kcov_remote_start(u64 handle)
 
 	/* Can only happen when in_task(). */
 	if (!area) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
-		local_lock_irqsave(&kcov_percpu_data.lock, flags);
+		local_irq_save(flags);
 	}
 
 	/* Reset coverage size. */
@@ -930,7 +927,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -1004,12 +1001,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -1017,12 +1014,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -1052,7 +1049,7 @@ void kcov_remote_stop(void)
 		raw_spin_unlock(&kcov_remote_lock);
 	}
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
-- 
2.50.0



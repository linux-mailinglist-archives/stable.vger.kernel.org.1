Return-Path: <stable+bounces-171810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE91B2C7F3
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A87F1C24FB5
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6F283FFB;
	Tue, 19 Aug 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnw/+hur"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601B284669
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615709; cv=none; b=gEB6P8D1sWxm59NEruWCDK8e625oD5ULipEh7MVIr4w+0SXIGgtO4uywBBYaw4oDnad7TM3hY4yND4carngbaKTpDovpAtoMc8lj8Jd9QYSm4XpX5Fi7v0CuG0whTIDF+JeIa+jCwRqTfUQjnKCepvtFNclZ8aWVvKobpGZw+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615709; c=relaxed/simple;
	bh=5ZFrovl/wgxzmU7ZQUlUDz3e2Ux59O7lFGlqcOh6oUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxUx0PQ6SuWxBCtyHlFtHu+TCzMLQ2/dkMByP1aukCmGyR9ZszJKzD8E5cXC+16npAImKKrZliaKgHkHPJzMiIQP7slzhecKnrRCLZeAtYOcXXvVo9R3SmXL/QILp8PxaOUOyO2sl9kkNOWgCGJNA/m72hIeFltKF4io3Cu6rFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnw/+hur; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445827be70so59753045ad.3
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615707; x=1756220507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JmL8IAOx+wIVBxooeoV7bygpyZ9jyJFn3rB73ucFgc=;
        b=Pnw/+hurfdaltAyJN/Hp7Muf4kG0PAshUMNN/hj1ya9fB4DEKUp0Vio/Db5dRAj8t0
         w2oYf8ARJ3+VmXfZDQnsTdhi8sqD90eyyLSazhaBMhkhskC6vkM396rGWR/ATIaUglOE
         ZzRS5f5btdEXPfGJxJ6kyj7BRcEH3Ce1McFUjT/UePv1p/WmYiis5O4ZrSjdY5zcCLZZ
         Io7PGFbql4s0wdYdneaY197kG5k1PUTMhRRHbyZgrI6Spjf784J+ZzTTCQaTf41F23Ny
         aKrTUIfpKoJHmXdEVEhGbxQHiIZHFy5+3HC7TjMiZYQ8eqinS308s/5WmUrpCkZfKAgF
         fzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615707; x=1756220507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JmL8IAOx+wIVBxooeoV7bygpyZ9jyJFn3rB73ucFgc=;
        b=Cy1BG8u5plTi92i1TQBmlqen/RDpvlWSNsffU7PKg2d1mfKnjjcAs0Jur5YrV8VSRF
         7etE7TB+NuIuvKAQ1+4VyfnaTfWn1TZsJsgAGGezdDkRivi6A2kxft69ESlGWaeK1bRy
         cM+DU4jrHGd3d2Aw2UxJ6f1rt12ujLkxlq9UATTnrTLbU+3Cwsi8vNUYPmEg0YQQIdR2
         8q7SLFXj5xN6dfJfZ4y+/i0yQsMpbW3vN+fIV6qAi8r3xgrE5WTrj+Oo8fQp3yA4lP95
         Sxow6DHtx0TE0SqlSuSJ1u00/WOutiCtGKsL/3JOn5x6TNUVGKWfq/Ze5n9791vbRX0V
         LGTw==
X-Forwarded-Encrypted: i=1; AJvYcCV+FekP0JFsmrfrAdTfyvoDoz4modHiZZCRl3S8QurPPytW1/CpOKqmf+caQuhlPNM6OVGFhRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtMkxjCVeQ9oH7peTIXc+XOWXz/hNCkBrd93/MVfMa04+MnE4
	VNg87XxKPLu/bktACqrIHZVuj4LmQv2FDyeZa7RIvs+IqsDenmIx5QiV
X-Gm-Gg: ASbGncvFvxyzyTy8PV9wap9uJ7NPkE6P8a6rpkEij2FaLpphelG+F9cjm/0o1Q+ibbZ
	VMlJT3jqA86MztZCxuDxfl2DT8yi047bpu968VOLfxDc8UKb1ahARyCutumnEIjmyoRyOHKZl19
	kWLGedLFprq7roBZuOY0QmD3VOVcg99YMGSke70W/vHxgCkIoVPT+fNpsdBXWf68V1RpzN5t2hV
	QtymMO8t7eUs3lLrViiMSTz2cFl3sAIjDIYKlr4rwiclxtCIrg/P/MOgNpP+hBHprY4LJANqNpc
	lPPG35VA2ztOYjKbIKYqB9sP1rl6Mmq/dQlEXclnOU391dv1OG+RWRzUG/h7vMx+qQneLMQFbOL
	NbqbhpDY6NPcgFtQk
X-Google-Smtp-Source: AGHT+IEgp3hx06AeX/BhzhG30RJ+DaVX+u/IGmamucRk1iT/x14SlB07vl2cBagw0A+feOfOTWzbuw==
X-Received: by 2002:a17:903:98c:b0:242:9d61:2b60 with SMTP id d9443c01a7336-245e02a22edmr32444735ad.6.1755615706534;
        Tue, 19 Aug 2025 08:01:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d551493sm2724147b3a.112.2025.08.19.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:01:45 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 20 Aug 2025 00:01:23 +0900
Message-ID: <20250819150123.1532458-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And they cast unsigned value to signed to cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

In 64bit system, these might not be a problem because wrapround occurs
300 million years after the boot, assuming HZ value is 1000.

With same assuming, In 32bit system, wraparound occurs 5 minutues after
the initial boot and every 49 days after the first wraparound. And about
25 days after first wraparound, it continues quota charging window up to
next 25 days.

Example 1: initial boot
jiffies=0xFFFB6C20, charged_from+interval=0x000003E8
time_after_eq(jiffies, charged_from+interval)=(long)0xFFFB6838; In
signed values, it is considered negative so it is false.

Example 2: after about 25 days first wraparound
jiffies=0x800004E8, charged_from+interval=0x000003E8
time_after_eq(jiffies, charged_from+interval)=(long)0x80000100; In
signed values, it is considered negative so it is false

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is consider first charge window.

In theory; but almost impossible; quota->total_charged_sz and
qutoa->charged_from should be both zero even if it is not in first
charge window. But It will only delay one reset_interval, So it is not
big problem.

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]
- not change current default value of quota->charged_from
- set quota->charged_from when it is consider first charge below
- add more description of jiffies and wraparound example to commit
  messages

SeongJae, please re-check Fixes commit is valid. Thank you.

[1] https://lore.kernel.org/damon/20250818183803.1450539-1-ekffu200098@gmail.com/
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..93bad6d0da5b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-- 
2.43.0



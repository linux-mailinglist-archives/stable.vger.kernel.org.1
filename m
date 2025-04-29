Return-Path: <stable+bounces-138940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC2AA1AFF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4304A2C07
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0C2522A0;
	Tue, 29 Apr 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gM26QAy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489A2139B5
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953131; cv=none; b=juxCDJIY0RagPgAIunrh2AUIzw7CQ2LvnueaOw1/Gh69a78qLJtrPhlR5B2VeUxhI43+zHm3ZQxU/WCwynzscvkMIB20TWv1MsCMZsAS9ejVYa2HLrbO1EJzYer+kTjhBWipzLBLgjpQuzVzP3ahNxYd2ENoeoDSdP0rpGpWsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953131; c=relaxed/simple;
	bh=8DWUkgowi58Q+C6KSwBRblI0nmvZQfHYlZ0o/INoJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRjquge9oaENqypLpq4Tw1PORSgjLVt6oGB+S23UvbgmABRgnjNu9vt9RC4a3pJ9qZD6ax5181Y6SRvbw2flp2IXHTm3JKS/evdDsOhPyTuPoRgr2ZmBTUSP9VpEe+KUFPEOa2JQfCERDAgONzLrOn4AH/CXqqy5M4kzlTJunK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gM26QAy9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0782d787so39728065e9.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745953127; x=1746557927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ5gLIKdEnlHfp/ZM9aOKHXL04cwNu47lJLmXXaF2II=;
        b=gM26QAy9PFPVm0t2wYMjzl6cRHjV9vLdBez/1mkvChOBElSY8hLmeBOZFeBryMplf1
         3E61LQR9LXd/OJ+PGjeah+7n2elVhTl/B5NLh2Pfq3Kx3GaB4c9cmV1n56Moyyd5ohzq
         GuJnrOPXnJr98ci7GzaFY1cwUdIR+pmqML6fC/sbKFNWathDmCqpfW6axtX+iR5loYUa
         SS+HhnI/6Rka0V0zS3OyXOFOPDqdL+rYDa89p1hx69vopna0/fIdhpkz76KEk1z6pEJY
         zI3GmzTXngjzuKjQIuV2lK0aK47uWjXDWv5JNtVE4cpZghxFjkwu7pPfb9EF0aGpVjIh
         HyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953127; x=1746557927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ5gLIKdEnlHfp/ZM9aOKHXL04cwNu47lJLmXXaF2II=;
        b=ShuJ6Nh4J+hU0lGPf/WO4/d0r+1VXa6Pl7S2X8b2yL/vCl+D2xMWVnVPQadYP8H3zB
         d0cHh+xYxYFEnwsmc/nq+KNElZGaCUJ3WD/jPJEfw3AqR6dzWCtl7dLemP3KFjsKmJMI
         06J0Pr0pHjkBesdgK1ugGxPT+dyOtPKkaf77mf3Yc/HG5ehWrsVi0kvHSszIux/fy6P0
         G4pyDnMK1LIYayGwPAvJxXHEk55v3v78ntF+r80hYAHNIqE5UY2/Y/eGavr66TRYRnY9
         YRYuQy176Z+ed1sKu35L3vpJVMWpoMSAwxJ8FJf9ovgrd7EO10i1WuqZF6oqCoLuQosS
         uGaw==
X-Forwarded-Encrypted: i=1; AJvYcCV2SJipN/3DIK7GgIkqscJ2XUBG+aWMJN7nPX62+NksXcYo6wRHypUkql7/G7L2yqHfBppt5to=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsE+SLRQnwRTBVrlV21/NRFUPs+IM/S3BTFBjv3E61SKzwFNS
	09zIVzs/JYYnB5DZk6dTxMJF6edZ/fkM8j2L/J+0lJbl3Ndrn5IHGi5nVD5+g7c=
X-Gm-Gg: ASbGncuW8e+otBEBeihKwuT2kKfJL0ERO65EzG3SNNzNBmdy3iRE4DKDqMXTr1gEGnG
	dq4VlWQ80UVQWX6pnOOVK07Fp4TFpAXCKNVcR9muJblZC9vhZmaQ5cb1z11/4qs27rnfkTbv2/b
	G5dxZe0R7As8J8E/+Y0YF7eCsKjUIRatJLqvcnZCW1nM0sQSESol0Y1jRghdkWR0ti4Lms4pG90
	Te+1Rw3egGlpqIMLVZjUZLx2zplZs0tFPSKjsjbwPg34tBaAdtGgONKFCZT0BdlfitbNODpBp6W
	UyeIAkDBrekrpb/WvxEZB63X+hnFNiYuuwyeI30Dwneh+iFhevK1e4np/OZ1ixYA8P4ACB82PNJ
	JcCDYsooiGxjHnvXExCCG7kCODgwdn5D8iKgVzFUZ
X-Google-Smtp-Source: AGHT+IEZMwWz0zdMJ9NDjk9O5Asf64JDL54V1y9NgXWNtSz5RkuH7RmJD1LO2QHqy0LDF2oJCsnupg==
X-Received: by 2002:a05:600c:540e:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-441b1f35c1dmr3839765e9.2.1745953127536;
        Tue, 29 Apr 2025 11:58:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530a6e9sm165643035e9.16.2025.04.29.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:58:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/eventpoll: fix endless busy loop after timeout has expired
Date: Tue, 29 Apr 2025 20:58:27 +0200
Message-ID: <20250429185827.3564438-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in
the future"), the following program would immediately enter a busy
loop in the kernel:

```
int main() {
  int e = epoll_create1(0);
  struct epoll_event event = {.events = EPOLLIN};
  epoll_ctl(e, EPOLL_CTL_ADD, 0, &event);
  const struct timespec timeout = {.tv_nsec = 1};
  epoll_pwait2(e, &event, 1, &timeout, 0);
}
```

This happens because the given (non-zero) timeout of 1 nanosecond
usually expires before ep_poll() is entered and then
ep_schedule_timeout() returns false, but `timed_out` is never set
because the code line that sets it is skipped.  This quickly turns
into a soft lockup, RCU stalls and deadlocks, inflicting severe
headaches to the whole system.

When the timeout has expired, we don't need to schedule a hrtimer, but
we should set the `timed_out` variable.  Therefore, I suggest moving
the ep_schedule_timeout() check into the `timed_out` expression
instead of skipping it.

Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
Cc: Joe Damato <jdamato@fastly.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/eventpoll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4bc264b854c4..d4dbffdedd08 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2111,9 +2111,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		write_unlock_irq(&ep->lock);
 
-		if (!eavail && ep_schedule_timeout(to))
-			timed_out = !schedule_hrtimeout_range(to, slack,
-							      HRTIMER_MODE_ABS);
+		if (!eavail)
+			timed_out = !ep_schedule_timeout(to) ||
+				!schedule_hrtimeout_range(to, slack,
+							  HRTIMER_MODE_ABS);
 		__set_current_state(TASK_RUNNING);
 
 		/*
-- 
2.47.2



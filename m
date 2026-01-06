Return-Path: <stable+bounces-205073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71DCF815A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 233CC301CD2B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A933343A;
	Tue,  6 Jan 2026 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH8clGh0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B3332ECF
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699455; cv=none; b=rEEGauxvFk3rKy+L27ev1xXMa63Tnae2xqC0Bp+qThA9ojHCllps5D81xyFj7MeoRn7HqaLbyKpombImIv2XPFGQF8SlnxjsZy75EF3k7MK3LhiYiyIi2Jrfn6D4wvnuV6KEO0y25Yx9StNfRjE+AV+BSkD0u318iarYyCpCqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699455; c=relaxed/simple;
	bh=v4YuHG1rupxsoSiOid32tx2tUkEKlM5xOQlZqfA5aZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF281Ezo3SEDfKwKeFCgCozWZf6UT96CbO/Q4ol6Ni8EYQGTZfBCTGLa0uChVK+NGai0X5DffFhTJVL5KqsCl6a5yTZj++TLVxvdpYBlm5RhogtshHS1fGxvoy7Bw3Y3u+4cnu0JGDulxYTtLYXYFLPZ0s9EyqvsZTrgeeep5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH8clGh0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so9128985e9.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699451; x=1768304251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6uW+A2P9pkdDCkg7XZPcaKU2E1i1mrVtntLiN6dJWY=;
        b=aH8clGh0aGB7eBc1MCM7+h6zNBiz4ABTMAJg9hhbrbFi4nOyCRr7Oat7A+tYBQBb+A
         u32LlHWneALAikJjmB2Yl0OvLjjBRNx1JiJXj1lRKFo/ZubXBcXx3S5xB6od0wQrBWsV
         RC32c19kxeBU1uzmp9KTRZLmW6n8E0I5sz3zNu7Qad/rhe2ZD2Zi7e1a16e0RXDtsfQB
         0G2t4RHKUxprxxuIzszkCpEWnI8yptSiK+LfO9Gl9OIi09NBDiEh2MiJkgBs1nuMIl4n
         oxJwyoFgvjuu4YrCbvup8BUVo9BN7cJUFXBg6TK0NcZ1c+OofZ9I+mz3pAiyUtIQMVj2
         03TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699451; x=1768304251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6uW+A2P9pkdDCkg7XZPcaKU2E1i1mrVtntLiN6dJWY=;
        b=PaItBi9DXbVwnn89lKrqwm7er9kIMXNjv2b4bubRl392umwey/Bd8cMWhq8f8HwBqz
         QHNmRZ6eHGSjy+tMzh39iM6IaNuiMtu9WwqzCxZ+IM6ggTly8pLpxJFCz+bnbD/82QKt
         wnQXaaOS1N+0rjEfMkJuOHVU6qesaq1YLX9ad0Zese9Hq0DfU7TNfi6+b08VUZ2HzLS0
         dFm/XFqstz3O9qgjmAuxGYYHy45d0bItPxXxt56FWU4g4Jk9LBlGvrpHCTOPY0HxPka/
         HqQjFTLCOfgnsRNsVWhr0o6ijNngwro1oPLOvUdbgdzn37u/riE7whXL5mRHqoHXs6sY
         hbLA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxqev8HQHb1PPBmtN+x248cQzqi7XQ1zJTyv6u1PzZHziKLMGDRpVWoQMJIQ93ET/cs6EH9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8cRPoRfPY5bh9Pni39A05vg7Z1GoOzEgdXxa+H/mAskFOhrB
	HWaIAqpcEH2MjITZ8c4bNYnxj88YSUwd1Pkzhg5Xs3N01SKOr4nNfwgFSigzTg==
X-Gm-Gg: AY/fxX4aPAhM7nTQJEs0CAQDY1upUnRqD6Xl+yJVXldwI7+fELsejN/JycmBfW49GSE
	QutsqCznyLiX9GaDmsPOXLRObfyABHXeIzigBcREHSox+OTprqgERwINL98ieTpK19K9A5plKOz
	NU5jsdBZvVdw3SK7MJyVuCLeQAi87yqVDEftR7zxGRbiz96xzO5vLTu1ZUMDKMA0PIvPLl4jG+x
	qkeJXswiujTAVYYwDdlHLsShztXGm0zqJA/2Bkjnk+6v7DNhwMOQLirJ4dbMs2nqr6ACkkaKRIs
	kZXjjs8cO8ip4g/O4Z8gWlB1BRcpHibIJ5EAtswDkVTG/XDbea5hffTXfXtVYRChANCVqOdJAHm
	hLEEjOCVMU34VUylGLzANJHM4YlJSsDZD+FcHHdx4UokzRIbZBw8KqnD8cRf4FzUNwx8SPxHdGb
	7SxRzS+JPzvmoL+8LP2Bq5449kk21n+GKA3i1JSnRpQcHd
X-Google-Smtp-Source: AGHT+IFZ91WQ+XxVidfhxQyJyWI8jqmAirmsj1rp2dJE8QgUjcxhZbOX7ZjT1XaFm0hj6+FAliB85A==
X-Received: by 2002:a05:600c:4e86:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-47d7f066195mr30148295e9.3.1767699451299;
        Tue, 06 Jan 2026 03:37:31 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm40282735e9.1.2026.01.06.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:37:30 -0800 (PST)
From: djiony2011@gmail.com
X-Google-Original-From: ionut.nechita@windriver.com
To: muchun.song@linux.dev
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.lei@redhat.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Tue,  6 Jan 2026 13:36:27 +0200
Message-ID: <20260106113626.7319-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <73000e7f-14a7-40be-a137-060e5c2c49dc@linux.dev>
References: <73000e7f-14a7-40be-a137-060e5c2c49dc@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Muchun,

Thank you for the detailed review. Your questions about the memory barriers are
absolutely correct and highlight fundamental issues with my approach.

> Memory barriers must be used in pairs. So how to synchronize?

> Why we need another barrier? What order does this barrier guarantee?

You're right to ask these questions. After careful consideration and discussion
with Ming Lei, I've concluded that the memory barrier approach in this patch is
flawed and insufficient.

The fundamental problem is:
1. Memory barriers need proper pairing on both read and write sides
2. The write-side barriers would need to be inserted at MULTIPLE call sites
   throughout the block layer - everywhere work is added before calling
   blk_mq_run_hw_queue()
3. This is exactly why the original commit 679b1874eba7 chose the lock-based
   approach, noting that "memory barrier is not easy to be maintained"

My patch attempted to add barriers only in blk_mq_run_hw_queue(), but didn't
address the pairing barriers needed at all the call sites that add work to
dispatch lists/sw queues. This makes the synchronization incomplete.

## New approach: dedicated raw_spinlock

I'm abandoning the memory barrier approach and preparing a new patch that uses
a dedicated raw_spinlock_t (quiesce_sync_lock) instead of the general-purpose
queue_lock.

The key differences from the current problematic code:
- Current: Uses queue_lock (spinlock_t) which becomes rt_mutex in RT kernel
- New: Uses quiesce_sync_lock (raw_spinlock_t) which stays a real spinlock

Why raw_spinlock is safe:
- Critical section is provably short (only flag and counter checks)
- No sleeping operations under the lock
- Specific to quiesce synchronization, not general queue operations

This approach:
- Maintains the correct synchronization from 679b1874eba7
- Avoids sleeping in RT kernel's IRQ thread context
- Simpler and more maintainable than memory barrier pairing across many call sites

I'll send the new patch shortly. Thank you for catching these issues before
they made it into the kernel.

Best regards,
Ionut


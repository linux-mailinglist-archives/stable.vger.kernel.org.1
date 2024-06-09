Return-Path: <stable+bounces-50056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842F9017DD
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B11C20B78
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565A4DA09;
	Sun,  9 Jun 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU7S7I0N"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C481B9;
	Sun,  9 Jun 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957853; cv=none; b=WW6/KkPilokffsDdb60NIy7oOd3+A5q4bMEBMHntT39/4qhqhL3CNcGKC6M0lYWk3iWvfPUdP9PcwWiGil6tcCCyICW1xiCzyEgSTb14Ewv6qPc1C6pOZ5TY3fDDfGNBBnmzjcIbXj3uUTsZE1re6So7ggSRNSPrx+QF1n0qkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957853; c=relaxed/simple;
	bh=3UzT14NvWUR5CK3U1Fw6aNQWgadar+TXA8VhWP3bjJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PBWhI8ecNuEkexm+sW0e2WJOtdaE1FhMDe5xy9shSPEyFaqxCKA/BMkBgZU8Fy8SojjQAASVZbZH3iGZNF4dE6t5WNjqo8BU1egnWfY2i7qoX8eXvPEa4QnGkUkWVoQIaOKwu6WUCHDT1xKw43gYJDty21AT/QOCnswYy6xQ9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU7S7I0N; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5baf901ae65so234190eaf.3;
        Sun, 09 Jun 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957851; x=1718562651; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zpbot7qHztX9ltp2BIpBIvx/SpoqMXIs8jofFmr9ho=;
        b=YU7S7I0NaYTpnSFVA2NSi0qsRS3X72XrviDe5POTiJ8os412FOVOiJdqrUF7Jqe+Ps
         L27KyWq7gnVqLX2DMWq3juyun3N9VDR8cLEKws8b1hBQSbBhSg4dNW6XmDOrqxwe9E+k
         WjJw4ZgF/iB24GV9wMsSMsO4e1gJj9C7fmKtOCiNVbraXeFbDKvS/rxBukcc8VXulW2A
         SIiem8Ozmqw3J2Zqw0JezqDgDAe4LMEB/y/2IZC7n7sNg9WIeHYN0V5MRnHBgBdT6A4m
         l9ArxUbioEDqiWnvQAWbU9UIIH0tupqM0TzNE5CUhtq5PaAla412tBXa2Nnvp4/YSTBZ
         /MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957851; x=1718562651;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zpbot7qHztX9ltp2BIpBIvx/SpoqMXIs8jofFmr9ho=;
        b=MEqRWh+RxRnziaWeRfIscp5+Kv0LobORDSlBne0B/BJ6FCnHJI0TjExN1yZEUWwfXM
         pCp06cdIYTDYtfPEpC/jMUlXUS5ebL5Sw+/sk3oKZbOvErTU6kH4KLYCIM/2MAGEvN4O
         ZbhwUBObDZ7E1lc2P/Y45ZO/lRiCs/tYtx1l5ZElpTnmP6ERwJrORJAb+arVRWUSN+pH
         gnIhHtiDqLVX+eLBIh934hcKU66GXb/FIdMopNryNIY0kEjD0tDwQgLkxHrNCiZTi6b2
         CUOI7bOdA4sbf/eNTgVPFb7vmDCbC1pS4lCsNZ5o1SmyaQwhqQpWiKysUKK39TrQ41D0
         LBYg==
X-Forwarded-Encrypted: i=1; AJvYcCWckN07kPieJXbq51gLc+Vt19oq33ggsMozMweaNIWrHtpmucb46gg3RhspFbVHMUfMixvo7A1r8T3S0Qle3rgITWVdnal6
X-Gm-Message-State: AOJu0Yx6D7NWLRALwyXn/4w0VfqEhjdtvJYg/HJ/sowf6PaCoRT1Wle/
	HR/GOekLpjFMT1JunMm85exnHQe8WCK8ZgYy+Ooqy58fHDwat4eC5QVE/g==
X-Google-Smtp-Source: AGHT+IH6woehv0uiSbbq3kkFLtAZorWcW0AIJefHJXF8Cpc3HyUt+4ulg4ioylZZkoL0LoDx3daTOw==
X-Received: by 2002:a05:6358:989d:b0:19f:4d5a:c674 with SMTP id e5c5f4694b2df-19f4d5aca34mr226428455d.16.1717957850554;
        Sun, 09 Jun 2024 11:30:50 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e76d693b19sm2248211a12.92.2024.06.09.11.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2024 11:30:50 -0700 (PDT)
Date: Mon, 10 Jun 2024 02:30:46 +0800
From: Peng Liu <iwtbavbm@gmail.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, gregkh@linuxfoundation.org, maz@kernel.org,
	vincent.whitchurch@axis.com, iwtbavbm@gmail.com, 158710936@qq.com
Subject: [PATCH] genirq: Keep handle_nested_irq() from touching desc->threads_active
Message-ID: <20240609183046.GA14050@iZj6chx1xj0e0buvshuecpZ>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)

handle_nested_irq() is supposed to be running inside the parent thread
handler context. It per se has no dedicated kernel thread, thus shouldn't
touch desc->threads_active. The parent kernel thread has already taken
care of this.

Fixes: e2c12739ccf7 ("genirq: Prevent nested thread vs synchronize_hardirq() deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---

Despite of its correctness, I'm afraid the testing on my only PC can't
cover the affected code path. So the patch may be totally -UNTESTED-.

 kernel/irq/chip.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..85d4f29134e9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -478,7 +478,6 @@ void handle_nested_irq(unsigned int irq)
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	atomic_inc(&desc->threads_active);
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = IRQ_NONE;
@@ -487,8 +486,6 @@ void handle_nested_irq(unsigned int irq)
 
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
-
-	wake_threads_waitq(desc);
 }
 EXPORT_SYMBOL_GPL(handle_nested_irq);
 
-- 
2.39.2



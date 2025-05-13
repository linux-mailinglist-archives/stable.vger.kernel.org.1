Return-Path: <stable+bounces-144254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53DAB5CCD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1480C4A5C96
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132622BEC3F;
	Tue, 13 May 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqoa312t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1D49620
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162246; cv=none; b=STT6UHKec0WzgSaXhMmhW3al80fv5FkLyZuDsyFYQGPnqbA/p7Wi9QWIjdqSvlG0d9kBGpJITxhNR9AMtu8za30fDQssb5VuNpPH5Y9/FvaKdmNZBqCaoKslHZv04chMQHlGWffbKNNNMv5Aeluv19IH4QRLrES294FBXS6BU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162246; c=relaxed/simple;
	bh=oqpfDLb0fi9VrGXmlGTgREpJQgkESXn/JlpaLrB47sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0C6fuqJ/s9fTtW6e4wz2Q/fd0JwrFgDmkQ9YRBo164nv0EB2Df0GNsVuXJ9lSdpolkDUnaS61K3fbzqN7kQitniLRvspP/rsNyM6eJ17g2E3xKBZBZqUuRyo/n0BORUNBonMNmUgWdS8sKpCv/48M6HD/dKfXqfeilDXMw0eVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqoa312t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D06C4CEE4;
	Tue, 13 May 2025 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162246;
	bh=oqpfDLb0fi9VrGXmlGTgREpJQgkESXn/JlpaLrB47sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqoa312tjii7xA8ecM2jiYBhF8bW1wS++quN5Py8Kt6q1mXMeqQQA5iNWtwKlqSLt
	 XrtMI00/nbG/yJWvaTqN5TsSbkNHLRoPuE2rSuPHsxuzRh3eeKRb3/5I5xKBP+KOum
	 2w5p7X5qsPNqA8WBGSKQEFygVEdLNS94k8oxuiVa1Xo35ch7sVDcmrGdHQ22EtV1Op
	 rTGgYyHiBvnnAbMtLUaSN98C6WW+mF/U9PAsu4+yWhzVBu7f/+0x7nydINvKQ67WuZ
	 w8NA9nffK67e0WFtoa53fEhLko3ZJU3k0m1EvSCx9xg+gO38JXF78HF+Lr8F1llksr
	 4OTWIxOjW4+rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
Date: Tue, 13 May 2025 14:50:42 -0400
Message-Id: <20250513080408-03c3b9e248f87d0b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513070201.488210-1-bigeasy@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 94cff94634e506a4a44684bee1875d2dbf782722

Status in newer kernel trees:
6.14.y | Present (different SHA1: 6fdc7368341b)
6.12.y | Present (different SHA1: e0e66bb1af60)
6.6.y | Present (different SHA1: 5dd520b92acb)
6.1.y | Present (different SHA1: d2f5f71707cf)
5.15.y | Present (different SHA1: f29f5341f350)

Note: The patch differs from the upstream commit:
---
1:  94cff94634e50 ! 1:  2a4e575499d58 clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
    @@ Commit message
         raw_spinlock_irqsave() to cure this.
     
         [ tglx: Massage change log and use guard() ]
    +    [ bigeasy: Dropped guard() for stable ]
     
         Fixes: c8c4076723dac ("x86/timer: Skip PIT initialization on modern chipsets")
         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
         Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/all/20250404133116.p-XRWJXf@linutronix.de
    +    (cherry picked from commit 94cff94634e506a4a44684bee1875d2dbf782722)
    +    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
     
      ## drivers/clocksource/i8253.c ##
     @@ drivers/clocksource/i8253.c: int __init clocksource_i8253_init(void)
    @@ drivers/clocksource/i8253.c: int __init clocksource_i8253_init(void)
      void clockevent_i8253_disable(void)
      {
     -	raw_spin_lock(&i8253_lock);
    -+	guard(raw_spinlock_irqsave)(&i8253_lock);
    ++	unsigned long flags;
    ++
    ++	raw_spin_lock_irqsave(&i8253_lock, flags);
      
      	/*
      	 * Writing the MODE register should stop the counter, according to
     @@ drivers/clocksource/i8253.c: void clockevent_i8253_disable(void)
    - 	outb_p(0, PIT_CH0);
      
      	outb_p(0x30, PIT_MODE);
    --
    + 
     -	raw_spin_unlock(&i8253_lock);
    ++	raw_spin_unlock_irqrestore(&i8253_lock, flags);
      }
      
      static int pit_shutdown(struct clock_event_device *evt)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


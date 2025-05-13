Return-Path: <stable+bounces-144245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA54AB5CC2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C845D19E8424
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE02BEC3F;
	Tue, 13 May 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUQxGT6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A893748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162209; cv=none; b=LU/aSpo6Vorh06mXaphwcNC6LwqOMvAqADjmTKDaJxvDh+InFixwpHUFULZr0FjuPWboD/O9Gxik19GxPkfyGzaHuEKSLRwUDWQZYNFsPTOtG6QV4/qKzLHrhdiyy22JHjhqvClPaS8w7ADqw5hocKhIa7MSB0wFWq4GIe+eksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162209; c=relaxed/simple;
	bh=YlfY47b6q0UNwovL+1KrxojCobilr88gZuyiZR0tH10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/a9wsrEvysoUNemTlx3MZ1+1mTHssMy3BU4nWVKqg2VMLJS5Lep1Y1KPoytcnJK9nZZsRTa30QHCp7XKY4XYX4YtzdtM13VbnQyX+/VSvrZcB7LuAHyZ1d7qn8fZj3k/UlxHf/w9iBRN28h4pmFrtuk6QxxDGmFqFcHcGBZQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUQxGT6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894EDC4CEE4;
	Tue, 13 May 2025 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162209;
	bh=YlfY47b6q0UNwovL+1KrxojCobilr88gZuyiZR0tH10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUQxGT6lXyEhut/qE34LwC9ySgpxZtIe6MS+cUDQ3yaogKtfTjBJjlOT7AD2WTJKr
	 QjJYFX5EswTrhZzyc1log5ijmjZ4arkMlSPcGHa8d6vpHBl5PAQM5N7kRE80PqMoD4
	 S7yp4sf9GRF0WRVlbgokM7B+lgOPExD9wP2dumsgZXEtwCwRl7MO/9iSagCJ/94Nlm
	 scShxTvtBah5wLrOmZ1TTzDlwa4n94uEUpnwpynSel0vEk9VvH1NhiARnCaOaR+via
	 9T2dwm0hZkpJceVSFYFyecy3QwMDCNVUiuHJ/cyB71X0w1yTSQ5DkaWvrY5lfsHAdC
	 HYL9x98qw95JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
Date: Tue, 13 May 2025 14:50:04 -0400
Message-Id: <20250513114837-9cee9588eab47f20@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513071538.552838-1-bigeasy@linutronix.de>
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

Note: The patch differs from the upstream commit:
---
1:  94cff94634e50 ! 1:  8388aa8badd0d clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
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
| stable/linux-5.15.y       |  Success    |  Success   |


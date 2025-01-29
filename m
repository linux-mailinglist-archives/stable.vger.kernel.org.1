Return-Path: <stable+bounces-111088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0411BA2193A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534EA164741
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78EA1A2C04;
	Wed, 29 Jan 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9vMAKA5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98302189BB0
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140388; cv=none; b=FPcyrYtb4pEnLfXhCEZQh8Bonp2F7LLyLhE+8SwJkRyiHO4+fUFz8L90KeOI4A6ds4IJaMQKNSuCyRERwlIkaZAJmJCUFSafmkUlWbJMtXH/Mo4rTnbqDi8+LRmdsdsE8crZ9f8QcWIoH1JcpzCBWAyHC5DBM2kNU6U1EHzIAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140388; c=relaxed/simple;
	bh=7J5TuCKEYq/vixAKEtgmXkuTrv4UhcwZ1AmjO6mQf0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAUNZIibCU6nyQKm7b+ckAmtzKS7y3Dbv6Hui18sJJ4mYHpKbHIttBeVHpZvvkZL+zAbNuh/HXRA5vwuMQc6DnD6nCkjFlBZG5DtNbcAglqGQBvqZ+yHyHlLg93GGHZdMNYcx7AAALU2N3aLINlunO2T6Bxm3XFf6O12/6fDG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9vMAKA5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43624b2d453so72400475e9.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738140384; x=1738745184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibMnXE9jt2PoK54IY+NWxHRCgI0ud2bFSYx/u4aaNNU=;
        b=U9vMAKA5M3Rtskp0chBtH96RCKwXztw7KiToSaQleSL7mYt5IxzSfMhPIY/5x8pkMh
         UGeT+oGhaqpIY8ROFYK35/rTQJMehIOYLO+M9E353PxloJ213yyM1Nxk443/r3zved7q
         xaGvbGr8zeSpfuJQXtiqV+Abkim+hMMmbvIlsNJ06NtlS2Scz5zY4SANYycJOpogvdQZ
         Iz/q5IkjvjwhNTY6bWc5w5E+np5HyVSzQ8N5NoCd+SjXh3JuOr69n0UO2G+E8XZKarKZ
         GlzLCmFwwXGPO4ZIZEB4AoPmQiPPSOFSQtetP+hydJdiWLv5iZkb+BurQew14ylVcZkC
         3abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140384; x=1738745184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibMnXE9jt2PoK54IY+NWxHRCgI0ud2bFSYx/u4aaNNU=;
        b=tX21+gfYtjHydH1IHLwj1WyQgukFTLAeADR5gLb/VEcjyUEXDco3Gv85bh9BJkPXI4
         G/zbu359H83uNYExJgb01Srz+zPEtWCsWY9bRj0OkIQTCcFGGow8uwme2LH1RZ8GSQQ4
         kqvTVh4d3rVrNj0a7t6Zu2liEtPxr6C8tOl8ZX3KsCoDQaRioJ6wUQ6G7EBCKu5wIJ60
         UYBHUtVRrBFJmXvcEaumt8VFjybBfJTvfo6vayUmUSWhTfuUeRBIVPBoy+ntfJ28f24d
         8nbtpBii9bhcWZ/aaw9vOi3sAI/VX/gQGxhANNi2QiPDGWGRrCwA/R3jdHcBOe/In6Th
         mCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3y//g1ji3bn/DOggk3AlACNuRRYzFm/eaO1NRqsYjeQ9GsbkCpI5u9DzMRs3my7XyMgmxc8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgStsfB1zjirT8vduv9k3M8lqWjNRDXVN+ZDj3H8esXjFGcwg
	HB/nr+e30S28/R/zHVJJh5ZAaH756CAmOd2GTakrS1aJYo8rGN7WR+Tq7ONDREM=
X-Gm-Gg: ASbGncvL945NuHp+MLOjPLzJfSF5979rjt932g1K1mEW1ooOy9gGn0p7sdA2HmewqKc
	61PUjgo1MbD4l8QAMNtLOlx58myI7tmo/xMjyoxOHZiRijffN3EAwTq/LmTu8PQhqfhy7kZNTGl
	sntW0BNpBj29bAQ9B1cBld5RHKt2cG87t+yKePGMyYJyvUPeV7wcgx73aFY9Llq4xFvmfusygJZ
	2p5pGctfPJUgq6oRQBs/aTGWj63fG6Kp+XbTYf93Lz/QpagVxfXOed+ynbC1VxqGx1Hsciww5mZ
	zF72zdK4WRQ/Hw==
X-Google-Smtp-Source: AGHT+IE2dgGgnHSPK+T7gSqA3+zF1ANcv76giKrQo69o2LRZjDr17Z5AjaEDii4J922C4/Zpy+nrZA==
X-Received: by 2002:adf:f40a:0:b0:38a:1ba4:d066 with SMTP id ffacd0b85a97d-38c5196a2admr1619621f8f.27.1738140383476;
        Wed, 29 Jan 2025 00:46:23 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c42fcsm16612349f8f.96.2025.01.29.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:46:22 -0800 (PST)
Date: Wed, 29 Jan 2025 10:46:21 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC] soc: qcom: pmic_glink: Fix device access from worker
 during suspend
Message-ID: <Z5nq3Y7YOyxwqcmg@linaro.org>
References: <20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org>
 <8aef8331-662d-49ee-a918-8a4a5000d9ec@kernel.org>
 <7nce4if7gowtbvenqhwzw6bazgfcgml6enwufomqxs4uruj3vs@sgagkj3zpx4t>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7nce4if7gowtbvenqhwzw6bazgfcgml6enwufomqxs4uruj3vs@sgagkj3zpx4t>

On 25-01-11 13:22:12, Bjorn Andersson wrote:
> On Sat, Jan 11, 2025 at 04:35:09PM +0100, Krzysztof Kozlowski wrote:
> > On 10/01/2025 16:29, Abel Vesa wrote:
> > > The pmic_glink_altmode_worker() currently gets scheduled on the system_wq.
> > > When the system is suspended (s2idle), the fact that the worker can be
> > > scheduled to run while devices are still suspended provesto be a problem
> > > when a Type-C retimer, switch or mux that is controlled over a bus like
> > > I2C, because the I2C controller is suspended.
> > > 
> > > This has been proven to be the case on the X Elite boards where such
> > > retimers (ParadeTech PS8830) are used in order to handle Type-C
> > > orientation and altmode configuration. The following warning is thrown:
> > > 
> > > [   35.134876] i2c i2c-4: Transfer while suspended
> > > [   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
> > > [   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
> > > [   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > [   35.455242] Call trace:
> > > [   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
> > > [   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
> > > [   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
> > > [   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
> > > [   35.478659]  _regmap_raw_write_impl+0x780/0x944
> > > [   35.483401]  _regmap_bus_raw_write+0x60/0x7c
> > > [   35.487848]  _regmap_write+0x134/0x184
> > > [   35.491773]  regmap_write+0x54/0x78
> > > [   35.495418]  ps883x_set+0x58/0xec [ps883x]
> > > [   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
> > > [   35.504223]  typec_switch_set+0x48/0x74 [typec]
> > > [   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
> > > [   35.515712]  process_scheduled_works+0x1a0/0x2d0
> > > [   35.520525]  worker_thread+0x2a8/0x3c8
> > > [   35.524449]  kthread+0xfc/0x184
> > > [   35.527749]  ret_from_fork+0x10/0x20
> > > 
> > > The solution here is to schedule the altmode worker on the system_freezable_wq
> > > instead of the system_wq. This will result in the altmode worker not being
> > > scheduled to run until the devices are resumed first, which will give the
> > > controllers like I2C a chance to resume before the transfer is requested.
> > > 
> > > Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> > > Cc: stable@vger.kernel.org    # 6.3
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > 
> > This is an incomplete fix, I think. You fix one case but several other
> > possibilities are still there:
> > 
> 
> I agree, this whacks only one mole, but it's reasonable to expect that
> there are more hidden here.
> 
> > 1. Maybe the driver just lacks proper suspend/resume handling?
> > I assume all this happens during system suspend, so what certainty you
> > have that your second work - pmic_glink_altmode_pdr_notify() - is not
> > executed as well?
> > 
> > 2. Follow up: all other drivers and all other future use cases will be
> > affected as well. Basically what this patch is admitting is that driver
> > can be executed anytime, even during suspend, so each call of
> > pmic_glink_send() has to be audited. Now and in the future, because what
> > stops some developer of adding one more path calling pmic_glink_send(),
> > which also turns out to be executed during suspend?
> > 
> > 3. So qcom_battmgr.c is buggy as well?
> > 
> > 4. ucsi_glink.c? I don't see handling suspend, either...
> > 
> > Maybe the entire problem is how pmic glink was designed: not as proper
> > bus driver which handles both child-parent relationship and system suspend.
> 
> The underlying problem is that GLINK register its interrupt as
> IRQF_NO_SUSPEND (for historical reasons) and as such incoming messages
> will be delivered in late suspend and early resume. In this specific
> case, a specific message is handled by pmic_glink_altmode_callback(), by
> invoking schedule_work() which in this case happens to schedule
> pmic_glink_altmode_worker before we've resumed the I2C controller. 
> 
> I presume with your suggestion about a pmic_glink bus driver we'd come
> up with some mechanism for pmic_glink to defer these messages until
> resume has happened?

So is the suggestion here to rework the entire pmic_glink into a bus
driver? (I like the sound of that)

I'd assume the new bus driver will have to queue the messages until it
has resumed, which is fine.

But still doesn't solve the fact that we can't filter out when to
wake-up or not. What am I missing here?

> 
> As you suggest, I too suspect that we have more of these hidden in other
> rpmsg client drivers.
> 
> 
> In the discussions leading up to this patch we agreed that a better
> solution would be to change GLINK (SMEM) to not deliver messages when
> the system is suspended. But as this has an impact on how GLINK may or
> may not wake up the system, Abel's fix is a reasonable stop-gap solution
> while we work that out.
> 
> That said, this backstory, the description of the actual underlying
> problem, the planned longevity (shortgevity?) of this fix are missing
> from the commit message. As written, we could expect a good Samaritan to
> come in and replicate this fix across all those other use cases,
> contrary to the agreed plans.
> 
> 
> @Abel, can you please make sure that your commit message captures those
> aspects as well?

Sure, will through the backstory and the reason this is a temporary fix
with the hope that this is all going to be reworked soon.

> 
> Regards,
> Bjorn

Thanks for reviewing,

Abel


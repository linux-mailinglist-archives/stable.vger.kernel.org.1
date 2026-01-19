Return-Path: <stable+bounces-210377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E0D3B372
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99D130389A0
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17B39B4BF;
	Mon, 19 Jan 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="PkSc3Iq+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E139C621
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840900; cv=none; b=LRQRioHHQ3gxvG9S5QeYydJevu1cZnFLA9KjyA6Dd/xnsxQ1orh6JPMddX2V73ZHAM70cOpRgCpwnx6kzLRrP4eucZHwjppHZW70r93J4bZiM/LHttKMZio6Ub+AVi27YvFlfHRJKRY7vovesos6Qt94xhTYxupUmoJkHkIvUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840900; c=relaxed/simple;
	bh=V+ly4X6nLFmR1AJYR9jxH03Kum+GKeNv/cPwFDs+L48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mlvtk8bWhEesRyDc8R7BpLmi5bt77R3tZsfDjTzUK5V7vuFL6d1XDqZe+zlevroX3KW3vMvLIpdkAQTaTst/2XDiVfHHlrTd/bfWwPLh4YxpyQoiETnjLbw2+Fp1qwcHhm4C2qZY4rmG8sX7qNlDTGKHzADJUjGARjkrV1vc7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=PkSc3Iq+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35290e6d2e7so40207a91.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1768840898; x=1769445698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcmmiqNbU3rGTkCmxroKjD8IC24Ld60SzEtjXGdLtbM=;
        b=PkSc3Iq+APODxyT33dZL4vlVg8VkcW4feLZWDJpeNXaU6Lrz0D0iTrSw99J9eIxD4V
         DPpnQiB9ZJFfYoko8KPeoy37RwXsN85X51cSMap+RSQPkLeZy48pDT4IKbNt/wUR4kuv
         GglknYEyIxjwwiFujCwue4Tt3PmqdleYsR+guanIamFd1om+J+KVhgd53UCTrfdGKMoa
         1MauZuh35OXlEvJJFboy3oZBBkYXr6DuQl2M+ZyfZbvxFu6ySJVMo4hwUALCnufSNyjm
         x+Uptaf/vC/5L5KlrMgFOvDLH6svI5/XKe7Oqflq6xXM6oTW6RZNg6kXgfxALn1pBbiS
         rPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840898; x=1769445698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcmmiqNbU3rGTkCmxroKjD8IC24Ld60SzEtjXGdLtbM=;
        b=oBVNE3mPdp7oG385ZBw6/MXaP45h+Ju/DujVM5anhh2idQXAEjj2QGyp+X0N2rT1Bh
         C0Uc/A2hRsBK21lmtDcKKWQzUqpIxqnXcX534hFzr//wiCW0e9VfPLpGDV2LOh4o/kRT
         ckT2axalqTK2OiIHjave6nDKiNifJioOTNQSNGTquGx+9wl66Dox6+a/7037wPVNMQnU
         PzNUrK6ECVT9v81+ARAF+Mc5UXOnKtMI05D8GAJ0cHnAyiN1Mn8CAt/iuC8vmZwlIGmQ
         ZzKZazSutTcXYwn5dw1wKhgNje9bdvxTSDXJ0+Z3c2KuVIUh07eZBd8u74uSK4yv7C/j
         KkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vEKz/hpZ9RJBSQUjXRrG9lo3N/rIvLxgMi3xmSDZzw2H0l36lxex6WG9jY+4Z/4JsmO7JgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJaqsAl8qG8bQwM9k3ap6i0o3EpPWXax9/AS3d9bgAdayRSq4
	56+qzFlYFNauncYr3NyMcgBYEx1Yq0dKHgjb26vsHLaTDeSGhghD/chfmqe0PMMI8rQ=
X-Gm-Gg: AZuq6aJ7YYyLI5PfrtEQWxAVyuoGIM7skZ+07u/JIDDXyoSckwSYO5RSxVZFuc/HDUr
	o4r4VoCi2FPxRqvEApnqd2a5Aix0MaCAC3kVPLsm3HU0J4GwLGdCf0baoJyLdPSijQ+Mx+5EVNO
	CiKSX4V9z69RKoKQm5toZ/L8GImGKtjgmTTVZ49ymDwi7bfDiD0AGkNG3h+IUs8lMvb5JB0cbg5
	s1wkx9h8RQYHJwaUXihAoS/attl7pdgrU47FgX0XbVVJQRYoBCqV/fL1Yr5gUTN9mCKKgacK55d
	wkx31nlDS/slYTxQLFjBv8PYnM7KfmAGaUf4g8ex//IzKj3fAixqsgqJJg0TigUvbVLb6tpzmFy
	HFEdBj0FqG6G8x8fezumsRGdwa9Uvui9dbO/6Y54Y9QTWPaZM+ImqB+AvRZrXQzg54b3nGEByK4
	nV9gugsjXfrkQ3
X-Received: by 2002:a17:90a:c887:b0:34a:b4a2:f0b5 with SMTP id 98e67ed59e1d1-352b5a7f82cmr160248a91.5.1768840898210;
        Mon, 19 Jan 2026 08:41:38 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec7dasm12316253a91.8.2026.01.19.08.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:41:37 -0800 (PST)
Message-ID: <cc51e712-a337-46b0-91cb-6c3af76a84c3@shenghaoyang.info>
Date: Tue, 20 Jan 2026 00:41:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/gud: fix NULL crtc dereference on display disable
To: Thomas Zimmermann <tzimmermann@suse.de>, Ruben Wauters
 <rubenru09@aol.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260118125044.54467-1-me@shenghaoyang.info>
 <fa36159a-fa41-4066-abea-60a439e944b3@suse.de>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <fa36159a-fa41-4066-abea-60a439e944b3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19/1/26 16:17, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for the patch.

Thanks for taking a look. I did forget about this oops and the
smatch failure was a good reminder!

> 
> Am 18.01.26 um 13:50 schrieb Shenghao Yang:
>> Commit dc2d5ddb193e ("drm/gud: fix NULL fb and crtc dereferences
>> on USB disconnect") [1] only fixed the initial NULL crtc dereference
>> in gud_plane_atomic_update().
>>
>> However, planes can also be disabled in non-hotplug paths (e.g.
>> display disables via the DE). The drm_dev_enter() call would not
> 
> 'DE' ?

Ah - the desktop environment. I was scratching my head for why the
box kept oops-ing on boot even after the hotplug fix. It turned out
kscreen was applying the saved "disable display" setting.

> It seems to me that all these calls to GUD_REQ_SET_CONTROLLER_ENABLE(^1) and GUD_REQ_SET_DISPLAY_ENABLEshould rather go to the CRTC's atomic_enable/atomic_disable functions. Those currently seem missing from [1]. The atomic_update helper would then be reduced to damage handling. Best regards Thomas [1] https://elixir.bootlin.com/linux/v6.18.6/source/drivers/gpu/drm/gud/gud_drv.c#L341
> ^1: SET_CONTROLLER_ENABLE sounds like it could even be part of device probing and runtime PM management, but that is a more invasive change.

That feels like it'd be much cleaner. I'll respin with that in v2.

Shenghao



Return-Path: <stable+bounces-152717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BAADB326
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215DF188595A
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8E1DFD9A;
	Mon, 16 Jun 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaqRKSkm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D321B4231
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083000; cv=none; b=DKExQUs2b/rcWPp3pf0NFxFJy/eIx71T66PicgBJx28KsoEASWPKptMr+Hr7661ap3TSSTdgHefPRWQmWhUSg0yeMGRw0RYBxk8trMctdfhb0/obfhZI0C0vF/QXeJwjM4p6xlgNLQX7U5bkW0eoH2t9d2JxWULJmDbJ59aVSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083000; c=relaxed/simple;
	bh=bk/xyjGw0KBtVhvEHPMiHe27jiw8lhL8yD97jfdJW6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBlwvMht0yafSvfoJ6nIC/DJqF92wMQnM/5yHC2yR1/9G6qu240rBMJ2uXtbQhTu+3uOKMfpgOfAWUClawADmWFye4xfU+YGcoidPXuJh51NwX0ZAxszWkBeeDjxJrqkdGvdhjFXx+8coQvhsLAmIGtd1S2zLGcphOu/vkyt+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uaqRKSkm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so36571705e9.0
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750082995; x=1750687795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG1tRllaLzLQ7yTmOFiDAfPfVrd6z8cvaWD0QjpeVfQ=;
        b=uaqRKSkm5pC+uLtSjs7VzyAhjfPBRjKInlUnoF2T4cOd9xBzvOjx1/AHCgVtQz0GaV
         zkqhPdrTmwLNk6NcHC+b1isHsKgSfPBMuzBYK/dOLqusBvkTptwgTTEhkffbQgIhCsrY
         Y0xjgunoyHxOHp/Jx2JyByx1GYhl9sbLYvGhZ3pmHsS7p000Xpg2QgwWeJWg0qTvvg8a
         wlZ7+g3ZAU3XBPGgN1ndvT1sxo91ies33eZL1oiiPIP1cqxWOP3hBT7CLNIB6d/6VSUf
         Lu4II7gpipMbIYRC2DdTCEEAYgbZZ4/3UpQWy5d79cdRDt5UtqlZvwItsmiz9DwcVCe5
         4KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082995; x=1750687795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG1tRllaLzLQ7yTmOFiDAfPfVrd6z8cvaWD0QjpeVfQ=;
        b=CoRikCU+9CPSpgVSd6nfVD4+hMpjnECcUJzdfFnuH6j1/XCTrJM5HMs6UDNpkcQe9Q
         iY5M77F4ssv88Bn2nvCok2/h1JQU/kQLGJPYOuR2USU1SrzlaYEmQMNEdCfuAHxFssy6
         FD5eRVMYxzbsqGrv2/mhzXWTnkdkefaeUEXN+cAA6osG/RScWC3iqNFuUd7glFIfsjA6
         C0RJtNYBfg1sMvJg07MRFktQPgf6XKCcAWFMoA/zaAzZ0v6msTzr/axXvj1V/O+hd0sq
         Md53Ve+CKUweT7jb6SwDvQ600dZCgiZUwm7If8n46gA93p4xvTvk2Okglu0w2CPkGkAz
         LmQw==
X-Forwarded-Encrypted: i=1; AJvYcCXhC6jb1oc2L3lN1HUkNkrS12kOUxszbA0WjmlgdX3dBBKaEE8/KWPNhUWa+rgqvwg8OaOl/gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Qbw5VYxOHDsulD4Nii9U+xJ3WfyLBLaIdQVzntyoGxr9ULmn
	sGkx1MN78vO8NHdvF0W9FEDdzQurKJuTUzxLOziXxRDWy97ceLxzHfjo8c682SZ0V+o=
X-Gm-Gg: ASbGncvZ1xXc12+ZPcbXHG1uaaZLlcAJqFwGZ8H08T3OuQc8CJZTLImjoobBxveguuS
	rN4dUhvdErfyNAdiOV/YmkHL8D1oOYwWLAVtx4+YPNuawIex9c/kZGLUyMJrIVxraIvWKH1wX9t
	8wD/T5PMsvARcKSkX9tkv98/ppsLpvJjjHsJ4if8iYDiIPI1S8jGn6uw5yrdgvhUfPjBXWrRLs0
	G2CjQy6CHrwAy4nZNrEv2J0TMUr4hs6uuhyY0MjKQ/E3sXxOh79/hRIQSwEZonYpxnQENAH21LG
	7O3b9veABAGG9iV+PSBq9H3vFHNd3DDVjVqjvAFMhDIsATG2fXpfEf8UWdzS2KOg0/MudJxrczD
	s1zmlPNTxf9dkiCC7t6/29S+qGx8=
X-Google-Smtp-Source: AGHT+IGDznAxXwPZeCKDNC5f9lF2U35yVP5doTOeyIgRBtLp4L+itiFGFFEjMkvl5sT9mvcZduwjhw==
X-Received: by 2002:a05:600c:1e02:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-4533cac919bmr79593775e9.32.1750082993741;
        Mon, 16 Jun 2025 07:09:53 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4b67bsm11033125f8f.83.2025.06.16.07.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 07:09:53 -0700 (PDT)
Message-ID: <21bc46d0-7e11-48d3-a09d-5e55e96ca122@linaro.org>
Date: Mon, 16 Jun 2025 15:09:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: qcom: camss: vfe: Fix registration sequencing
 bug
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Depeng Shao <quic_depengs@quicinc.com>,
 Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20250612-linux-next-25-05-30-daily-reviews-v1-0-88ba033a9a03@linaro.org>
 <20250612-linux-next-25-05-30-daily-reviews-v1-2-88ba033a9a03@linaro.org>
 <c90a5fd3-f52e-4103-a979-7f155733bb59@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <c90a5fd3-f52e-4103-a979-7f155733bb59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 10:13, Vladimir Zapolskiy wrote:
> 
> Per se this concurrent execution shall not lead to the encountered bug,

What does that mean ? Please re-read the commit log, the analysis is all 
there.

> both an initialization of media entity pads by media_entity_pads_init()
> and a registration of a v4l2 devnode inside msm_video_register() are
> done under in a proper sequence, aren't they?

No, I clearly haven't explained this clearly enough in the commit log.

vfe0_rdi0 == /dev/video0 is complete. vfe0_rdi1 is not complete there is 
no /dev/video1 in user-space.

vfe_get() is called for an RDI in a VFE, camss_find_sensor_pad() assumes 
all RDIs are populated.

We can't use any VFE mutex to synchronise this because

lock(vfe->mutex);
lock(media->mutex);

and
lock(media->mutex);
lock(vfe->mutex);

happen.

So we can educate vfe_get() about the RDI it is operating on or we can 
flag that a VFE - all of it's subordinate RDIs are available.

I didn't much like teaching vfe_get() about which RDI index because the 
code looked ugly for 8916 you have to assume on one of the code paths 
that it always operates on RDI0, which is an invalid assumption.

The other way to fix this is:

+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2988,7 +2988,7 @@ struct media_pad *camss_find_sensor_pad(struct 
media_entity *entity)

         while (1) {
                 pad = &entity->pads[0];
-               if (!(pad->flags & MEDIA_PAD_FL_SINK))
+               if (!pad || !(pad->flags & MEDIA_PAD_FL_SINK))


But then you see that every other driver treats pad = &entity->pads[0] 
as always non-NULL.

---
bod


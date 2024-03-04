Return-Path: <stable+bounces-25814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CC86F9AC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F43B20C7A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38BBA33;
	Mon,  4 Mar 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vF8V8jHP"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6423BF
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531125; cv=none; b=Z0gHpPidvM4jxMJwZIOXzo06zWzvYuMN9+9359J+J5Rv3jrHeV8MjGrbIzLJrZkGXhYAK09SKYrA3bn4e3wfhN7tUJsoltQ4s2+fuJtemsd+VjbUEihanOrzn2+KeU3FgO0O78QF7X0p9/yb2qHJE2UKI7o0xH34M47J5TP93KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531125; c=relaxed/simple;
	bh=++rr3GGIRoaCERnG/cWu7OqJ4/FLWkd9s2osDrEnVgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI4bMGn2SgM3Rg2rhn+eBtS+yZ4Y/YwNLaAtAZcqZopGxGUZbHqk3J+Ou1h/QYPQ2rCV+hYMpIoOo4DafrVQiFlgM+aPhz6d+d7p8xK5+8dpP/ur8yBOBNb3k4oYwIxgYhERRdfwwUyKTMoJrQ4OV7M0+rGsQ7Eoo83al9dumuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vF8V8jHP; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47268589ec9so2010339137.0
        for <stable@vger.kernel.org>; Sun, 03 Mar 2024 21:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709531123; x=1710135923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iS66EljrgAI6W0osXJVskq7IlYu87j8C6OY/XQH31Zo=;
        b=vF8V8jHPR7CBdSwL53hMRpGPaIO5AYRMOd7BWo6/IxDU1LurYEQzHr6vwsANkyX8Nh
         wE9nY2S7irp9X5uvVfoUyoCr0QyfuUgU5Jg8luabewNVOqzz3wYSlj0AfDx/3qq20tNT
         6bgSmRHP22IkvUS9s5e74ttGsaVs4f/JSNN8GcIoq9EKbcwB+Z/icEt5jirI1Y8tZ2A0
         Z2rDHQ3denQYgdMbRoLCFqgYk+yeIs3XCbT/+seo8EUch0Q+ctafAQQIssZBkEitrOHR
         q4lcAnHG4tJwCqBwIPSHlYq3gCKZbgUBMQIa4TFPO88VISolKhgwsClOqxfvvjyDfdsD
         KRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709531123; x=1710135923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS66EljrgAI6W0osXJVskq7IlYu87j8C6OY/XQH31Zo=;
        b=O7hSluUiSsLKFQy05e+jFQfmVIqbkKW/DEsVYOM5sfHExpneq/2X1zv7ZRW5TzAKzD
         LFNKs9gU+2foCJTtACVnpOkDC/5aOVYZuk60kcMldRw/rMZZhjt2Ex34wo9kk8z76yCi
         0atO9JPwtzbjqCX9AgFC7t8sZkZz9o8X1p/d1CnoJjaTKow8XJj8Oxe7L350D+kFCXOL
         01ZV4VcGSUsFeR0k5MstpwoiEoGvWEBYmS6Z4dBInInnPuG+5nmuzmOtR6E2EWj2sfoo
         xgICKiXVRZPQs4Zr9P2n0GpiP0tQxxHyeUWDQoyqSRZJKaWXHGGuZBC9VJqJLlttPlr+
         bZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWEY1rMhtmJHMVRIPXRyjmBO+Zn6hDdkRH0yg7DwryzaXCcoCeksNL/dScRI6hySnepdhSSLRdznLZ5v1qD6oYGYvVfaZ+d
X-Gm-Message-State: AOJu0YyZQimaOOhPMZCR7E48m5/kEDZTwdOiM28duBnvIERx2VPQFh7e
	x1csysq27wM8dk6UMBD6l1a2BHaHXMFBnhONSiYpsJfFDzZGf75PXpzYsK1BTrtO5m7B16Fxf6C
	2S0FxlCjJUU1Z4kqY5XVsklwkZlUYzY70shkfgA==
X-Google-Smtp-Source: AGHT+IGJiKCOmmG+6e4PqjE1sfyU8YCCfMdFjZs0DvF1bN/K25rjAZqRY4ze3L0+lpCsgPEmXAeBpB3H3Xx+bx16hSQ=
X-Received: by 2002:a05:6102:3e07:b0:472:c993:a596 with SMTP id
 j7-20020a0561023e0700b00472c993a596mr1004393vsv.11.1709531122998; Sun, 03 Mar
 2024 21:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org>
In-Reply-To: <20240301143731.3494455-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 11:15:11 +0530
Message-ID: <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: jens.wiklander@linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc: op-tee@lists.trustedfirmware.org, ilias.apalodimas@linaro.org, 
	jerome.forissier@linaro.org, linux-kernel@vger.kernel.org, 
	mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Arnd

On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> The error path while failing to register devices on the TEE bus has a
> bug leading to kernel panic as follows:
>
> [   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
> [   15.406913] Mem abort info:
> [   15.409722]   ESR = 0x0000000096000005
> [   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.418814]   SET = 0, FnV = 0
> [   15.421878]   EA = 0, S1PTW = 0
> [   15.425031]   FSC = 0x05: level 1 translation fault
> [   15.429922] Data abort info:
> [   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
> [   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>
> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> lead to the introduction of this bug. So fix it appropriately.
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Jens, Arnd,

Is there any chance for this fix to make it into v6.8 release?

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 9d2afac96acc..d296c70ddfdc 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_uuid, u32 func)
>         if (rc) {
>                 pr_err("device registration failed, err: %d\n", rc);
>                 put_device(&optee_device->dev);
> +               return rc;
>         }
>
>         if (func == PTA_CMD_GET_DEVICES_SUPP)
>                 device_create_file(&optee_device->dev,
>                                    &dev_attr_need_supplicant);
>
> -       return rc;
> +       return 0;
>  }
>
>  static int __optee_enumerate_devices(u32 func)
> --
> 2.34.1
>


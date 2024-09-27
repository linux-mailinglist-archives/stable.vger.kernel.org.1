Return-Path: <stable+bounces-78129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983AC988889
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E5128230F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CB1C0DFB;
	Fri, 27 Sep 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3BHVSmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9013B78F;
	Fri, 27 Sep 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452283; cv=none; b=YsMuzgNELWJqEIkR3tjCAkVuWZWUrXHIynI78UfJ+Aa0BYOQgPw4T6vStF0HyEsobypbzqwI2PntAAtdCWtCW5kgLe35OruTljSmCWoA/XBq3an9MB5Wpteu/pmzXO3LvGGQ1W+EtDCvCZvQFDwzwfYpWbu78hsMXg7uzoQLN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452283; c=relaxed/simple;
	bh=4aXRDxXbwjNUV0PLxI23rShqr3O7FVVGkTMLLEsf8aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAYG7r3YpzCr9lIMPrKXsLgXbPwF0fZwsMeDLy/aRXnxFCxF9EgFTRzW0f8IWNG0tfuMH/NV1d/9HE12BNlZypgZdL/FnbkcSkyydeQS8pZ9zMPht/kclEuHE6YJyS909inm1kdfwHvWV/GMxhPmAspbg4c5BhQeC9O92avHaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3BHVSmL; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5011af33774so766046e0c.3;
        Fri, 27 Sep 2024 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727452280; x=1728057080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXxprvEH1bwArWzkjF+rjwkpLdCy+DXaOT6jNfrQ7yE=;
        b=R3BHVSmLp3DDtk6JSLYy90O8OlOraNNEcOn8OoVibogWsd/wcChPg2ISnjwJJIvv2o
         +OYz+TCuil1PWm/RoKNzo65WMwdGDaCdxWLlDdjGUZjqMczYkVzJ/kiPu7SLALPUIF8I
         qxUfFS5K/po195te/GK2RlHwc6TCyE0vnkedwWvy6LVMNqPIxLC8j0WfxBqDurNTnfve
         rFmpNh57219Q3RxzN2+qwHsgAUlRct3Fu7Km9DiThgYdS+hcuglvFeYrUfxSFcGh7XN+
         A0RFuyxRmc0g99t1R62FTpzRA3V84+QeLrIC98RLmypeYR6uydlFvKfVinSq8l9W+xMv
         bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452280; x=1728057080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXxprvEH1bwArWzkjF+rjwkpLdCy+DXaOT6jNfrQ7yE=;
        b=HXNHAGjtm/wdB9+8+3JGm/9zsAjFNvF+RX644nT9Oh8HvqSLA7cZtqN/NOTNOdeqLI
         9xYpTC6zX5uWkZvmA++nbFkXcQ8UN16Sgil4lQPtyhnOvZ5QWShr83FRpcsouxU+43ey
         tDbvm5rFpIrFSQC69rgXNc0RF9b3gBwVKKSslJ5GPEywX6IBbY8V7cmN8CQMt/5huZzV
         MdI18zUM3w8CEIaP82pWLUE6bZ1HUBn/vBQnNTIijCgpmhUHY0XKySQXShF5Rieed6PX
         kmvsHGhRgq1UDaPe5RlXMLcAOLLoWwwdgQoOWTX29NgwUn9/N+uQ1wHMgv1uB0/3W7Kl
         bOzg==
X-Forwarded-Encrypted: i=1; AJvYcCVQZgdvMkUoIKVkXmjeqRxJm1nOMyg/jFlKKY2EPbBQPppkUiAJ5uF29hqU+xqN9oBlcgCT3ZCqv5JU7qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKAV+HLGJVehvMr+HQAY8b1reiE7/Jsh2TvMK97p7SgOG1MZ2
	oMeZA+86HlIIxq5FC4jsZ0gBK9dQ4IJp2UKJhwj9oyPeg+QfCg6peYoogXUaOg7IsS3Yeq/vQFR
	k0JU6LrzwTTxYvkGiDM9VAJxnV0c=
X-Google-Smtp-Source: AGHT+IEdoXUnMlm+gDhGJAihsIQSq0mbBB8QgrMsHJiuvXwZZCgfLgwidGkQsY+DqAWVR3rAnw4s3XHBjs7SALSDicY=
X-Received: by 2002:a05:6122:1689:b0:4f6:a85d:38b3 with SMTP id
 71dfb90a1353d-507818c51bdmr3033612e0c.13.1727452280556; Fri, 27 Sep 2024
 08:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121718.789211866@linuxfoundation.org>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 27 Sep 2024 08:51:09 -0700
Message-ID: <CAOMdWS+W23H+fc_a0fz4cJcGdMF7gkLL4fo_BTewBX-+ey_9mg@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


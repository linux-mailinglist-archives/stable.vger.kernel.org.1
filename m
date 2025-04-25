Return-Path: <stable+bounces-136656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC16A9BE60
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF99465289
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E922CBC9;
	Fri, 25 Apr 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFtSTVxY"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E022B8B9
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561199; cv=none; b=QwpYgPfx0m2AARcdGejq8KddYEU2qyRkzTnEDIZqDvx8raX+o+0quZfKK3uXNprqKCeubMrYw/w5OX8negAFd6dijXjZhdVorjUMzaMgPs6uPDl39Nz6wpyRY7W6povmftOMNS5pKeZB91m7sfglt0GMnIOBesgdnM/pmGZTtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561199; c=relaxed/simple;
	bh=CpBT/GJTl/qOHB8XXefQW8z5QInEFr8XQOgxoGfmDlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmygkuiXSrFN9GkgncVFPV1BzJA3z+2Oiv59/2igI3L406HORNvOFgRM5Lb0HsPA3x8jMnitWo1ID8TGwSf16QVAmPqrUNv1Bkcgm56kUX9KAdWlgByZj8bXA8bJvjsN2AM2K6rDozzZpRUzbJlz5qCFIFmSDX4CwAs5kgzwZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFtSTVxY; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso2533781e0c.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745561195; x=1746165995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ajgJc89GPboKToxuB8Pj0D0uNjRPDnR6q+9b48EFZ2E=;
        b=RFtSTVxYzNOCGv2rnwTHN+3CiPKXQBATPCXeP6dr7gaQRpBhBoalnkY+LbUx0sk0K0
         uyWj5fDaidv+PnkUuO8tbvCDnuKmBCzQIZWOz1hEBc76bo18OqEBD5Oss8u10URqGgRQ
         BMs/R/kC1OEknsAsU25OZXJvGLGWnmeq+yhLXDIU5LhKz4jUdWSM0/q/rcBT1Vb5UIYp
         yibnkVOsVcZ4vQj/iAJ+eQ3TvnlV6RbQDIgst7u5CJ7Rlkd6Q4jQmnIFsYxEr9SWwjN/
         NmYo42eVBTKO60T5mAo/Q11+g3gVoJLKhg4TExj0Wq0SNGr03vP1PeV/Gv6UA8BHCwAk
         PWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745561195; x=1746165995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajgJc89GPboKToxuB8Pj0D0uNjRPDnR6q+9b48EFZ2E=;
        b=H+k0sWBV4E45zh2FfTohLIdAVI03ClM9VSGdml9mExh5aPbViof06ykRnYi+PpU3fM
         OuD5egQQZX17bDsetfxnSFXj6yyZTXtN1UXJJ5ck7NzUMmlOJ97r95+GaQHcEEWa/KcQ
         fTVesV9O+xJyju8nh8Y1qK4ac6WZ1gcVJWINqcH5oPnr+qwkhwKlrmWNwDjCrlWABa9i
         4S31b/5tE5tJ9EgeHg7oWb/vJ0SvrO408u5D9K08OaXf78HtMT0VTgT8+zEhZve7YehO
         UvbO951ocFJsxzJMkqwA6iCqKEMBfwkFKQgd5dksvqRUEkFJrh0ctNpj42T/PXSp91du
         YvyA==
X-Forwarded-Encrypted: i=1; AJvYcCXgyK4vLP5FBcfzM/lPIxryYhlqTNOfRE72XnjfkEKTB1l0QDkVHy3HhmtG/NGLicGHbnRlZ2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYV+xTGsEgvvfY2gJd0NMMXFp4LtNhUG/pzWg/mvzV+cXrg/B
	Iexnct4FrRfqoNqc64tICz1mzCdaPYseV4R2q6hEuTcvi4uH2wMxxCZMGgYoZQ1ipabEBtQHlT3
	DkmrM1yKVF/jAtc9wXVvBOWIjpm82Q/w0S+1hHg==
X-Gm-Gg: ASbGncu5EAI8b2IP+L296qY/HqsZZ6zCp/AMCO+fomd/eab0Yckj71scAz1VKAjk4ox
	RUDqaToIZTZss0uVOHVkbAzsH9WLRXE7Bpa5f1YwbvOdGSzNk61i3BhCjI+dR6zRjH0ViGrRyht
	wfs0pJxxobjvy5TK4655K36yv5qiZwq+cj+vUjuIf7VvB+LOVKiHA6kLjT
X-Google-Smtp-Source: AGHT+IHk3Sh1recRtL0I0FAiNETtYwurKFY0CJ0FDTy8w0bAg/KMEvL/1tmqPiwb61pQkrz7JWUirq46fq8oitTFWfU=
X-Received: by 2002:a05:6102:3e87:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4d543fb6341mr362655137.15.1745561195672; Thu, 24 Apr 2025
 23:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com>
 <aAkhvV0nSbrsef1P@stanley.mountain>
In-Reply-To: <aAkhvV0nSbrsef1P@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Apr 2025 11:36:24 +0530
X-Gm-Features: ATxdqUHyh1sPNfszHFCKsjMSGrXxYsTXLBiYXGTypFcI7J1MgDaUy852FfJYen0
Message-ID: <CA+G9fYu1GagoVWnhNFnknWf0_zk-O+5XQXDiL-XUdt8knhJYaQ@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 22:52, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The "ret" variable isn't initialized if we don't enter the loop.  For
> example,  if "channel->state" is not SMD_CHANNEL_OPENED.
>
> Fixes: 33e3820dda88 ("rpmsg: smd: Use spinlock in tx path")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Naresh, could you test this patch and see if it fixes the boot
> problems you saw?

Dan, This patch fixes the reported problem.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Links:
 - https://lkft.validation.linaro.org/scheduler/job/8244118#L2441

>
>  drivers/rpmsg/qcom_smd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 40d386809d6b..bb161def3175 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -746,7 +746,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
>         __le32 hdr[5] = { cpu_to_le32(len), };
>         int tlen = sizeof(hdr) + len;
>         unsigned long flags;
> -       int ret;
> +       int ret = 0;
>
>         /* Word aligned channels only accept word size aligned data */
>         if (channel->info_word && len % 4)
> --
> 2.47.2
>


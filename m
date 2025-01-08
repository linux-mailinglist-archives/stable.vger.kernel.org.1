Return-Path: <stable+bounces-108003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F54A05FE8
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E605216653B
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003421FCFDB;
	Wed,  8 Jan 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1nswO97"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F11FCFF0
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349585; cv=none; b=jLdnXBLJMz9TwU1OfhZ7ChFJUKAd0FncpZQPNNRIzyIjFN6hGrayalJmRPgKRib+CcoBKMv8UZZoTsvwZYp9Lrh/mLkeuO0LSp6ps9t8gJcv5sWy/Cr/UXQ0kTUbAbSOJw/H3d+2+CPqzwTOvR639IWpA/Y5hMU1ayTLhl4Yqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349585; c=relaxed/simple;
	bh=S8+xIJyK33ZHzGHOInxNuQ7XoyymzN8JimDgUHl2LMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv6uP658Ue5xI++g7BbOjEOqKQD3Oa2SGIO2cKjoeISoI02ghXE5Q1MrwzSZepbCRHE+FrWuo0TmPla1B3FRJLCaTeVWuzMOszEI7jM7eDKubqNsNLlQZzzR9dB4pdOlR8+SCnn50cRtqNmaoKyMDSkrpnB39zSV/hQDSDhkRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1nswO97; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29ff5c75c21so507829fac.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 07:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736349583; x=1736954383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zs0x6zXwLhMKy2YimFx22u5+ybSyZ3K5Ks5ZMiPS6U=;
        b=w1nswO97nSovzBwOLaHKx4SpsJYjHKGgtOmETPKgjB70I93z7aFcPmlzw4fZ7RVCB5
         RmiUcjIhdE07Z5Y85oQzjoD9mWGBzjKNpxwEbG8l5qh1fpUfoSHMmtIWK8G3TNRkL/X7
         T5Kghw2O9vIDWOyAiH3KqwoIxRiZ72bWCDRYrWGFBY683VdUiw6kwYPSnFfn6dZ8mb6x
         Zy7vLQd2djt6rpmm20/GHUAra8Pstu2CNO1AxMr1aaa4CKCeWKnxCLN8nebS9O48uf7l
         Or3lDESEI6Mn9rsJsNYXb2/YIG/QhkSXSVcUcjykJ05gqvLb7rx3v4jrZ61q2aEw9DYW
         UXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736349583; x=1736954383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zs0x6zXwLhMKy2YimFx22u5+ybSyZ3K5Ks5ZMiPS6U=;
        b=rkuVvpK48jCwplBl++30G1V3v9ouQzmQCQwFL7uDVyTQaJBhgWqq0QZsg/VV4CjMRk
         T1W6rxJLeol+x+QCh6xdNqOnkQzl4NbKrhbRjyaGRQu7+tRgEDuuVJEMe2BISFkB7U8Y
         jDK+DkofZfdmxcU1cP18FeNF/gxQ4Jp3xMnw+fil4XsxSWrLvHMQCAT9NJo8OTcwQ6YQ
         exzhVU29wG713dofsS9FvZXmACVU+eNO8WeRb1ZLhBUXXiJrdrznGnj2CD4KyTTI9gCg
         O48QKAg8nvN+ieF9klDkBRj3e/cjFEUoNt3XcM3IIrY44sjpLbFgFPhPOhSpSOpiUSPG
         2l1w==
X-Forwarded-Encrypted: i=1; AJvYcCWaY7zGrBaOjekUxFtGbrc+/iEFGtkh1WM1aJW+0AiTPgp0zEPbdiX7T0bAEh7c2RSGHjmLESc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkplsfrd/LILndEPSvktb6frMcJPIwZWZHwEKSHwrDrG6QUjeJ
	/z12kaylKPzY/dF+Y9Nl4oiE16fPQFHCmgtKnBNPtL4YdDlLKukEWIbaV6hZFWwautt1FtKiP/y
	7Zr97Wg7jy1ZTU9Nk21kY+z0PqnhkjU5O0UZ3AA==
X-Gm-Gg: ASbGncvDECVZuyfiie3LvnsiWq4Vjq9tq6UMOTcCS8lcvv392ew6lLTISyoyS9F914s
	54zTFGHrrkmUv6ZVlhrKWJtzn3nOXBx0EWEowMjg911iKp3FEAGpd/1JYX7+83CqencVy
X-Google-Smtp-Source: AGHT+IFdcASMuSPx7wnPTSOxzCIvnK5AZhtUpSDpvfTmQ7F1nQUlpr4kCBfb2r1WlGxp8XqNukwAN1+7QxEq5LVuoOg=
X-Received: by 2002:a05:6870:ff45:b0:29e:7629:1466 with SMTP id
 586e51a60fabf-2a9eaa986e7mr3988370fac.7.1736349583243; Wed, 08 Jan 2025
 07:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org> <20250108-mhi_recovery_fix-v1-2-a0a00a17da46@linaro.org>
In-Reply-To: <20250108-mhi_recovery_fix-v1-2-a0a00a17da46@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 8 Jan 2025 16:19:06 +0100
X-Gm-Features: AbW1kvZa6gRkeZ9H-nvbe12ihHDmXyCS470lzORAghiZyMgYmyhYw4TS9_LQmVE
Message-ID: <CAMZdPi9KiLczjETLwJG_9krn_z=Og0uZhYuajPeZYoBHanxMiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bus: mhi: host: pci_generic: Recover the device
 synchronously from mhi_pci_runtime_resume()
To: manivannan.sadhasivam@linaro.org
Cc: mhi@lists.linux.dev, Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 14:39, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Currently, in mhi_pci_runtime_resume(), if the resume fails, recovery_work
> is started asynchronously and success is returned. But this doesn't align
> with what PM core expects as documented in
> Documentation/power/runtime_pm.rst:
>
> "Once the subsystem-level resume callback (or the driver resume callback,
> if invoked directly) has completed successfully, the PM core regards the
> device as fully operational, which means that the device _must_ be able to
> complete I/O operations as needed.  The runtime PM status of the device is
> then 'active'."
>
> So the PM core ends up marking the runtime PM status of the device as
> 'active', even though the device is not able to handle the I/O operations.
> This same condition more or less applies to system resume as well.
>
> So to avoid this ambiguity, try to recover the device synchronously from
> mhi_pci_runtime_resume() and return the actual error code in the case of
> recovery failure.
>
> For doing so, move the recovery code to __mhi_pci_recovery_work() helper
> and call that from both mhi_pci_recovery_work() and
> mhi_pci_runtime_resume(). Former still ignores the return value, while the
> latter passes it to PM core.
>
> Cc: stable@vger.kernel.org # 5.13
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/mhi/Z2PbEPYpqFfrLSJi@hovoldconsulting.com
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Note that it will noticeably impact the user experience on system-wide
resume (mhi_pci_resume), because MHI devices usually take a while (a
few seconds) to cold boot and reach a ready state (or time out in the
worst case). So we may have people complaining about delayed resume
regression on their laptop even if they are not using the MHI
device/modem function. Are we ok with that?

Regards,
Loic


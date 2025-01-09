Return-Path: <stable+bounces-108155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BDA081CD
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 21:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3981888BA6
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF6A202F87;
	Thu,  9 Jan 2025 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOF4sgs2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA291FE475
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455898; cv=none; b=Fbby/NjVTWjsVDBCEFHlm1LEYm4beWZlllHtRuFsE54hBw19MLyDwrPkIuU/+f853+iHnXgxgG1jhwCeMmzQ4c8Jz6cbaaoAhctBwMzt5kjAJOH+lfn26OlKxa/k94yHwTfiKCuH7C2+WP+9YJOlY6yGdteB6hZR5xZ6LW6Da2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455898; c=relaxed/simple;
	bh=/TsRdN+g/t5WPSJQXnaL9WV9wg//3dakf9wDwajrJgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoBw5PDaCuXwOvJdhHBnx7k8mm36D5WW2Eznowa+XNEwVyXx4okkseXGU3FIg5a23eRnYXH5N5RciROBwpArGjjOFQE/iVPKPatf7EBVCr+hOBmNIhOcbpUNbcrMy0fGW4XQXaCwP3TXvuYAK1Syd4n+XMS2uI43e0lU9Dq8bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOF4sgs2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f6b65c89c4so300200eaf.2
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 12:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736455894; x=1737060694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mebvm12Efix/HOfbzCEke0YYM9SXOWLxp0bQs2kiNYc=;
        b=mOF4sgs2AuJfIlbM8hsfBJ5Yqkk1J0h4Ip1yjwXpqzTnEnL9lcz6i51+hBQlEUNjG5
         gzpfhkcuWZcOZGEGdEoJ8ZVXDEbbo+oJ5Q/086J7QkBaaE7QoDgy2OZN6A7JcsuRHa4j
         dq54djhCkfLRmoBHCkHfDfL2R3c6FD4TOjwqxucKyLhMd2RXnucCXbVVZHNOt2+3asnn
         sqIu1x90LhRTTUjkaWiMfmH3EBoyc7RVgmRJlA934gEMceKOBH49iO22kPlzTYzz0fFM
         bxy3hDC4xEukxzkEGO6vf8uF8p0AjxFVW4JQXI2sQ58bk33iFkEg2BMY3Il/VlG+17tp
         o/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736455894; x=1737060694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mebvm12Efix/HOfbzCEke0YYM9SXOWLxp0bQs2kiNYc=;
        b=YOnK3sj6Jqmbac/FBNj6apDMkk3yONnqG0Lsu9PY9LozPR6Voa47wzJUBWfHI1SE4p
         gqvUHHaYl88ngQbgySj3+A3KuWWvInAANcSs6/vWa+bW//1Wehm8d3DRR1/iVXg+BHv4
         Ta+vjKBnoYsSRufojZUxtIGW127lpaNQKlJU/pvWOyEMAFJlP9/OUNnKSbJfjHcpr/u1
         BiwkXI2xkvh9dcghIe52raAy1VwOFhCyTucRTP1QVHNLXgmtQmBy5OocJvpORqbKioMk
         b/pSUDk+z2uIUrF/okMvtUHY0IeDQEp0zvMI9nvIYR8UmCQ8790F2uQrrr1UPdGBX1qt
         Oipw==
X-Forwarded-Encrypted: i=1; AJvYcCVhG+Lvu7aOIyyTwATOzUc188nMBKQ+d3kGdS7i8p33o1nzLBvDOU3oHFkj4RkC569STyGB/bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbk0TlNwR6x93O350c2MIE+ix25idV5SGtmIruPw+0NbBhn9r0
	ULuxXLuRsZorQz82d9qfbq1UFZFPRMuL2r+7EogiU75OL4h9vpV7ZK/zuMsKIA8tlz7b6AKLH8a
	HiMsEpqyYp17jLyLwEJzu5A9QgBkAS6L6+aYeng==
X-Gm-Gg: ASbGncvdlP/oUvAwk4QRU3Dh3+wgpl5HCKcvRyNL4FPxUT1Y85JcI+xH343JPwpXfWg
	E7PD8zmdjkNQXr27IesRiicbFk32cLB7wNjxVNg==
X-Google-Smtp-Source: AGHT+IGw0KIVg/dvzz7d9PF80SBHOTL5uvW2Zpk7HWjQlYX/tsf3aX9InA3qQG3yCXLbshZwbBGvXAfuWrNEWOn1Gs0=
X-Received: by 2002:a05:6820:1798:b0:5f3:4175:1d7f with SMTP id
 006d021491bc7-5f73096717dmr4383494eaf.8.1736455893957; Thu, 09 Jan 2025
 12:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org>
 <20250108-mhi_recovery_fix-v1-2-a0a00a17da46@linaro.org> <CAMZdPi9KiLczjETLwJG_9krn_z=Og0uZhYuajPeZYoBHanxMiw@mail.gmail.com>
 <20250108160211.6dok3zcn2qaoj3lp@thinkpad>
In-Reply-To: <20250108160211.6dok3zcn2qaoj3lp@thinkpad>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 9 Jan 2025 21:50:55 +0100
X-Gm-Features: AbW1kvaYy2ijj3_SpahQvOJx-c_o9llvwrvJ3pguay-O4M-tUnMoDS8jvItsP7k
Message-ID: <CAMZdPi_OPXGkrT_4iyLF-698TPUgHu=Y5M-wVRq=kx6RWH4bVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bus: mhi: host: pci_generic: Recover the device
 synchronously from mhi_pci_runtime_resume()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: mhi@lists.linux.dev, Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 17:02, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jan 08, 2025 at 04:19:06PM +0100, Loic Poulain wrote:
> > On Wed, 8 Jan 2025 at 14:39, Manivannan Sadhasivam via B4 Relay
> > <devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
> > >
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Currently, in mhi_pci_runtime_resume(), if the resume fails, recovery_work
> > > is started asynchronously and success is returned. But this doesn't align
> > > with what PM core expects as documented in
> > > Documentation/power/runtime_pm.rst:
> > >
> > > "Once the subsystem-level resume callback (or the driver resume callback,
> > > if invoked directly) has completed successfully, the PM core regards the
> > > device as fully operational, which means that the device _must_ be able to
> > > complete I/O operations as needed.  The runtime PM status of the device is
> > > then 'active'."
> > >
> > > So the PM core ends up marking the runtime PM status of the device as
> > > 'active', even though the device is not able to handle the I/O operations.
> > > This same condition more or less applies to system resume as well.
> > >
> > > So to avoid this ambiguity, try to recover the device synchronously from
> > > mhi_pci_runtime_resume() and return the actual error code in the case of
> > > recovery failure.
> > >
> > > For doing so, move the recovery code to __mhi_pci_recovery_work() helper
> > > and call that from both mhi_pci_recovery_work() and
> > > mhi_pci_runtime_resume(). Former still ignores the return value, while the
> > > latter passes it to PM core.
> > >
> > > Cc: stable@vger.kernel.org # 5.13
> > > Reported-by: Johan Hovold <johan@kernel.org>
> > > Closes: https://lore.kernel.org/mhi/Z2PbEPYpqFfrLSJi@hovoldconsulting.com
> > > Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Note that it will noticeably impact the user experience on system-wide
> > resume (mhi_pci_resume), because MHI devices usually take a while (a
> > few seconds) to cold boot and reach a ready state (or time out in the
> > worst case). So we may have people complaining about delayed resume
> > regression on their laptop even if they are not using the MHI
> > device/modem function. Are we ok with that?
> >
>
> Are you saying that the modem will enter D3Cold all the time during system
> suspend? I think you are referring to x86 host machines here.

It depends on the host and its firmware implementation, but yes I
observed that x86_64 based laptops are powering off the mPCIe slot
while suspended.

> If that is the case, we should not be using mhi_pci_runtime_*() calls in
> mhi_pci_suspend/resume(). Rather the MHI stack should be powered down during
> suspend and powered ON during resume.

Yes, but what about the hosts keeping power in suspend state? we can
not really know that programmatically AFAIK.

Regards,
Loic


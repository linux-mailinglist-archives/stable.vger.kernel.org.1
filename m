Return-Path: <stable+bounces-107999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC94FA05F44
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E55B3A1383
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E11FCF44;
	Wed,  8 Jan 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Us/oQ6eH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BF15B99E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347626; cv=none; b=iN6x292VSE2XRnXdIvOVbZSkjEwceqTCbeGtM8ywilXgVV4tRXgh/er7F1rDEwl4/rToQ8y43Yn7VarKts+2rlU8SGxkel9g7Op26zwpbXSLqTgetv+HAlAdkBLi9ySLFtZpTLv5EkAice9mr0Azp8tt/CzmQ+xrNOTIu1a5NeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347626; c=relaxed/simple;
	bh=OdE6D5N8RrpzSeHpeycvSVWOB2W1RR8oVCgZ0kZqXjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQB/GUWBKq8kZbFqv6K2eVOHtcSc8f1PRMCfxQ3UAkvxh2CeS9f8oA//yGAR9bA8euLuaWyIzXR1JNs3oc2MWt2dcm+JNFiBUYxlsO9dlkXThTLL/Y8Wo/PdkFsJAkRGEwJrycBO+fRxoJfKZrPWuafa888j7y2tRwKIkTlai2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Us/oQ6eH; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f2ed0b70d6so6120820eaf.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736347623; x=1736952423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdE6D5N8RrpzSeHpeycvSVWOB2W1RR8oVCgZ0kZqXjo=;
        b=Us/oQ6eHevDPW6pWDxmKD+TFRLCOcQSB5OBa2wNVlxhB4HmRfCojBcGYLeosC9Ypm9
         WmABC0SYECnLy5vU3ksRwh28DknEAc6dJ/aQsJtAKS9E4BwJsI+8GGaCGO2KaVMuwcCk
         QtkIsMeuwoTGtn4aSXkV8vLmn3E4JlJPM07vmYGvAHkyHr1gndTTCsn2e02PxnEfhMb9
         8bfdTcEYeaQzIi+nSAKWMHcw7uEMZnCTan/1oQz7oHE/tze1gtvwO5sUqWr2YXRIcrnu
         5huD1w9j7B+Z5CGJKBriYO6mm/PxAVbIavKI0RLS3ktSQd/dyEUCAesUDm8OMxr+oG3B
         drpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736347623; x=1736952423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdE6D5N8RrpzSeHpeycvSVWOB2W1RR8oVCgZ0kZqXjo=;
        b=QoCTZhfDHL04XqLUd3lHf1h8ih1r+rHwmhqd718l1tPJWYsuO/hh4BkQqOEC/fO4M1
         Ec93sNSsTvXcfti5PXfEK60ggr5RhsocmvPDuOCftzZNUAjo/h4DR44DBrbVw6fif0tQ
         3XTR9Q/zcc8tWAyKK8Fv120YxR4fC/z+87ccKqECyjgJFSGomljqs2GYQyJLJ1pEdgeo
         +o2V/bwxAkcqUvL54Tv6p+bmxzY4czYrNPJ4Skl6/fRKTrfVMf9q0S8I2gBLDLzmIGbP
         aKKHrm9b9uzIuQsGuJ6C+4+CI2OCjfR0kTAdstdtHZd4U2UI375d0E5J/A1LHlxxV7hM
         1lNw==
X-Forwarded-Encrypted: i=1; AJvYcCX1pEQ2mLpBf9JW/2dm5yECJZKX6cGiNgJuHGz5dwtU3gJ659jXG88lZzMo0SJkUVSTAsYCHXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBltUxrTmSdhSNDoGO/AKCkgH4R4DLViINedEd6u4Hml48LS3C
	WSqX2Ndwnk6YMHvvUFm0dhqRrKheEjJ4ZBbNSxK3XNKhOyHDPwO8u5KEtjKqLqKidA62Ij6NzoF
	jaz51a7JgTceJNBv0D6LHoz2N/vCCHZol7z3MEw==
X-Gm-Gg: ASbGncuVz6671I4ImxtgkZa0nZ8YT52KeR6ACUjkoJv9cJJDu62yNS3OnVwZzw/JKWL
	4xH/TOHvC7Zb4ZeIPqJAmPTQ5Km3bhK08L+Vf+zH+oxqhSGpPd0rpbkqzhkVD3na/Yw5b
X-Google-Smtp-Source: AGHT+IGozL0b6866JXapQ+PEbHnvhj3a6/0QQ88A8IJ/+L+igHRG0D/Vq+aG6UHzobmpoTeJz0Mbo/TlMtGJUaQpZJU=
X-Received: by 2002:a05:6820:4b07:b0:5f6:d91b:ef36 with SMTP id
 006d021491bc7-5f730849a23mr1529084eaf.1.1736347623278; Wed, 08 Jan 2025
 06:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org> <20250108-mhi_recovery_fix-v1-1-a0a00a17da46@linaro.org>
In-Reply-To: <20250108-mhi_recovery_fix-v1-1-a0a00a17da46@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 8 Jan 2025 15:46:26 +0100
X-Gm-Features: AbW1kvZfPY4Kk4qbtmTD0fHBZZNdvUZzXO5U_uMo2FSCqxn2gzTvApC3VGAA_jo
Message-ID: <CAMZdPi-2O_aNWHnRKkMGUKsrTdfTTuNM70y_7X5xvADiyk-+VQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus: mhi: host: pci_generic: Use pci_try_reset_function()
 to avoid deadlock
To: manivannan.sadhasivam@linaro.org
Cc: mhi@lists.linux.dev, Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 14:39, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> There are multiple places from where the recovery work gets scheduled
> asynchronously. Also, there are multiple places where the caller waits
> synchronously for the recovery to be completed. One such place is during
> the PM shutdown() callback.
>
> If the device is not alive during recovery_work, it will try to reset the
> device using pci_reset_function(). This function internally will take the
> device_lock() first before resetting the device. By this time, if the lock
> has already been acquired, then recovery_work will get stalled while
> waiting for the lock. And if the lock was already acquired by the caller
> which waits for the recovery_work to be completed, it will lead to
> deadlock.
>
> This is what happened on the X1E80100 CRD device when the device died
> before shutdown() callback. Driver core calls the driver's shutdown()
> callback while holding the device_lock() leading to deadlock.
>
> And this deadlock scenario can occur on other paths as well, like during
> the PM suspend() callback, where the driver core would hold the
> device_lock() before calling driver's suspend() callback. And if the
> recovery_work was already started, it could lead to deadlock. This is also
> observed on the X1E80100 CRD.
>
> So to fix both issues, use pci_try_reset_function() in recovery_work. This
> function first checks for the availability of the device_lock() before
> trying to reset the device. If the lock is available, it will acquire it
> and reset the device. Otherwise, it will return -EAGAIN. If that happens,
> recovery_work will fail with the error message "Recovery failed" as not
> much could be done.
>
> Cc: stable@vger.kernel.org # 5.12
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/mhi/Z1me8iaK7cwgjL92@hovoldconsulting.com
> Fixes: 7389337f0a78 ("mhi: pci_generic: Add suspend/resume/recovery procedure")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>


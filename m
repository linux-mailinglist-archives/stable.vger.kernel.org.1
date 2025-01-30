Return-Path: <stable+bounces-111741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B75A234F5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E6516169E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FC1F0E5E;
	Thu, 30 Jan 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLlQb+c2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EB199939;
	Thu, 30 Jan 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738268062; cv=none; b=gLCpXBROqdq9d3yWbJphSECYRVTzAowqRBDoI9HJ8hmBtTNE8ip90ZaIR56MFvad/cVfQGmj4/0F61sxTFuFxPElZZ7HcQT4CrNRuogOYZIRgD3JFkE96hn/MZ49STY7vu7UpjZGtXaOUpE/Jng+oeatjol2OBmnvztpKBLCiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738268062; c=relaxed/simple;
	bh=moOYb6q877U5I7NnA82Nsf1lQuxDbCUGya80mzW9XzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBrQeU7a3ZIvI+xL3YbHO3HVj7j5vpsPQS2iY5tWZ/SfD2VmA1NnYtHGIWPyGiUnZeMd7+GW33xhw9zDZBMYuQOAKPgwtZB2yYsVKNBvag1vJereWStd6xKeUUyHrsjoqC6zXIZWp/+KaJBUHVUWDIUyBLWWq4e0RbUXqHWxcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLlQb+c2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1282488f8f.2;
        Thu, 30 Jan 2025 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738268059; x=1738872859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXg8UxAY9MsETmzcn/5hHuR64+FACNvOgpPBjgXkbss=;
        b=dLlQb+c2ozMp10mbKbdFz1MhQYFdHqo1ipm9mqzPPb6dftdXnF/xjmYVPXt6EvK9cV
         igjTH7Yz/ner/F05MuVllZ2qE8KKmME58kb6gnskIr802xbmoDX9e5qzpP0CVofMSluB
         7KzaqxSB9qcD5S01oe52pUntk2Mu2QufQXYQhg3RGDZkUnJk9Gg/IyzxBpzYI30RznNN
         H2yvf5y70xveOPioAHfVSnrym/qZLGpva+b/Bn/iI1u3PQEHyNkgVWbnh8VMsNetIYeY
         d7t1iA8AEq0xIVmt3kozh4jOn3Jw/dMW2LouO/2WXwt2FyyRmkVh3geI+71evC2+uOKt
         0Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738268059; x=1738872859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXg8UxAY9MsETmzcn/5hHuR64+FACNvOgpPBjgXkbss=;
        b=SjLV0C8HMoDwfiReIwTpKZwHAIvH11A9q8xYa4KjPii6nF/F87Qdj7vYHya76jeQzN
         4nToWWFAd1a0n/R3SL+gRKj8wkrq8DRxucp3cq44EKOt91uxDOZzwzQBndE36MgcEcPb
         NxERTMy01PeYEfBQyt3VevedyTFoKW6YQj1tZNfS/DpWMUr24HYJh8mYMcSOZ3V93YXv
         I+Er0yCS2tT1YedrFTmgZxLc0PFEOJ8rIquwBpCypJd7gAlvemUOCSgdhhqa2HeCv0Au
         cfzzbmqEfV8kXNjotz2ZgjNc8VbxcC3gzMotUKUn1I8iSfYQsUxtx+7ygGhjFYZY6EYK
         BXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7e+xhRqIZ8BxUIJbtTOJ2c6vbDTG72ytJhapXFYY8VBf1jI5edqcjWwXu4N9YM24RwlO/pAxu@vger.kernel.org, AJvYcCW5+1WrmFgLwJu98dAoAo9zyIg9Acd5IydwHaICkrV8rH6zlPCNp9iG/GkUPaBLzsEhtOL4k5Hs6EVuTZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFIqY7rnD0p+qnWuffCemm+RAldm0soKPUpIWHnwRhcZitHim
	qa1Yc/RlUD6/9jHIgQnrhwLOvIV5G8ltTuR2W6LPeyrcIZtsSOnH
X-Gm-Gg: ASbGnct6HV4lbguAN+VYDeQ1l0cEICRiAFIDISgg2tCpfsqCVMEiPvnVJpjl8m4r5MX
	wcbEwZhhanoIKmRsxBdgxFDsI3P0DTGnmsH8umbG2LYrn+yrHvM4NQYGb/UDestw4mSHE1bpGcC
	YJTdWmTydHTBzvtdtMHhcp7y1YQ1kneFYWW18EmHHyhuHrfis6NvJlTvBK1gNTL4b7rkNBLl6RN
	NtIX3v1kdBPXThNkCJsqApxi1krBBnUwvYqnZyG3dEcjKtpiKTqoIxF295J19SYGsO3+U1tLBz4
	vQbGbY2l12RrK6stHVFngj0HyUkkAb5bC7onx60Za8oL4QxQiFOFxA==
X-Google-Smtp-Source: AGHT+IF3rnXIybqyjHJwiSBQ1tP8SIXoluuYcvQsGkvFUsXMJoY6MvH237Ft6mYQ/0KzORimBw3oRQ==
X-Received: by 2002:a5d:6c65:0:b0:38c:5cd0:ecf3 with SMTP id ffacd0b85a97d-38c5cd0efe3mr2808478f8f.11.1738268058626;
        Thu, 30 Jan 2025 12:14:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcbc1510sm69784965e9.0.2025.01.30.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 12:14:18 -0800 (PST)
Date: Thu, 30 Jan 2025 20:14:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Luiz
 Augusto von Dentz <luiz.von.dentz@intel.com>, Miguel Ojeda
 <ojeda@kernel.org>, linux-kernel@vger.kernel.org (open list),
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH] jiffies: Cast to unsigned long for secs_to_jiffies()
 conversion
Message-ID: <20250130201417.32b0a86f@pumpkin>
In-Reply-To: <20250130184320.69553-1-eahariha@linux.microsoft.com>
References: <20250130184320.69553-1-eahariha@linux.microsoft.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 18:43:17 +0000
Easwar Hariharan <eahariha@linux.microsoft.com> wrote:

> While converting users of msecs_to_jiffies(), lkp reported that some
> range checks would always be true because of the mismatch between the
> implied int value of secs_to_jiffies() vs the unsigned long
> return value of the msecs_to_jiffies() calls it was replacing. Fix this
> by casting secs_to_jiffies() values as unsigned long.

Surely 'unsigned long' can't be the right type ?
It changes between 32bit and 64bit systems.
Either it is allowed to wrap - so should be 32bit on both,
or wrapping is unexpected and it needs to be 64bit on both.

As we all know (to our cost in many cases) a ms counter wraps 32bit in
about 48 days.

	David

> 
> Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
> CC: stable@vger.kernel.org # 6.12+
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-lkp@intel.com/
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  include/linux/jiffies.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index ed945f42e064..0ea8c9887429 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -537,7 +537,7 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>   *
>   * Return: jiffies value
>   */
> -#define secs_to_jiffies(_secs) ((_secs) * HZ)
> +#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>  
>  extern unsigned long __usecs_to_jiffies(const unsigned int u);
>  #if !(USEC_PER_SEC % HZ)



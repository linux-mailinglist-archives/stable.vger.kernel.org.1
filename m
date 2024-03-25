Return-Path: <stable+bounces-32228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5488AE91
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449D32C517E
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2D6EB4E;
	Mon, 25 Mar 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzdHFg32"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51B1C290
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390946; cv=none; b=qKnmypvTxaKGQuCCI0Y7XX/lC3zXhCJ1t4fnNrFKGsSxUz78z9PCl2yEKdb9TAWgF0aESiU3aRGmhzIyTb24N5KINWMCboCrXBDa+MMgtUaQSKFPA181OMoAh1fBeCI7ROCwLZ5Rwep8mOMXEBscnkUzdC+JDh6GtXv2BG8ut9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390946; c=relaxed/simple;
	bh=Sm1iIrE3ptMLoiPYWIx7AYIRSBbYXVJFhrXPHLow/OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEp9RSy5ikNsCBcB83VheIVuhERx1tg4xpzfnqOC7B9xpwBfQavTRtaBUUnEG5q3InFTL+KqHSatPaGV15TkwcnsKX0CyLKHwjOkJd+YOxqlYlDkLmKD9we07HxnxGZbyXthysIcBhQpYT9o+NFl6h+jYTK+IRgHtemsnDDIFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HzdHFg32; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d88360fd7bso1073309e0c.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711390943; x=1711995743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59RbJeT44SKnY/OmzZIX7K9bbID4Uwd0aO1o7f4SUzg=;
        b=HzdHFg32mQbYqASTOrH9WpFyOK8KNSznF+f7rI+oiWzmXf+HsoIG+UohicioFnp1L2
         EKMF37B+t0bGULEIKvna9jnzo1FhnzYSPLFQY6EDTpOAxZBERKGuqpqrgYXEp6NnoXc4
         SaUXZa6QayHTpUOlMyQa2HLjwx7nl654pHD47KiSSqUvgohrkbyiqQ1PNe3q305iHWJy
         5ILZlN7GwxKrSIFNJ7GV3FmzFU3r/7kXcESNYZkJAD6MZzXLbYdKtWaNeC89/sHF70dL
         BydxaP8nhUoPfB1ca2BWh+yxDOn5MRapczaV8/xrB5DA/kk+z5iU7/c3+Inz6Jec8hpW
         Nhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390943; x=1711995743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59RbJeT44SKnY/OmzZIX7K9bbID4Uwd0aO1o7f4SUzg=;
        b=cxBEpayJySfzRl4bBVh1Yya3+qn/WaqaXwG2mrW1araBZuE6fzRhlmjH2qUgdNdy6u
         u30tJddz/H09LduoAUj8WDYqHRC/gKdKhzSSKpbWu5bEAZ/tHxo8PcfFQOPVE8X5Ep5K
         UiVeKYmilTZcsMbUNrd96YQMjpTjedSUcbZ+x7PbUK2J/CdRGG7337SH4BPBn4kiLtRU
         JrJywTjkXbCH53XRMoBjIgeOccpcWdu34J/GxnXojI3+OC4JFHe4qrcaOJ9Hij7In4ka
         f+6olS/MiV2dMkraHELJqCtGxpXS2VDWXuBLOWATfP3KkwJZ7nvaeDSyRJ8gC4uK7j4G
         Xljg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ibmsCgXD4BXyZucW8OMV1yV5nQZo8APyeLsB4L5uVwV9u3as92BJY9tRJwsw450NtEZeT1DVNvJwWT1Hg/2uzxQlNlLw
X-Gm-Message-State: AOJu0YwxBBMry01HjHepfO/TVocizZkDJpz03JMC0lMUOeTPLU311lcu
	iZ0uf4vJkOwyxAvlpIQlawVMauO1WBabSFdRgGWwO92zwippDT2iw6wEbOoSp4awpOLa1cBvZ9w
	AQ4hnjekMzYqMcLNtsYZWhJSdmSvsvTg2Gbhs0w==
X-Google-Smtp-Source: AGHT+IH6xelstakxvT9pP0w8xKZz5NTAFsAotZ60pQaUO1lWc0bDEKkNu8QUnhirWPjBMwiPYlRz7FH/BebwtVIe1X8=
X-Received: by 2002:a05:6122:2194:b0:4d3:394b:d997 with SMTP id
 j20-20020a056122219400b004d3394bd997mr5085228vkd.4.1711390943180; Mon, 25 Mar
 2024 11:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120003.1767691-1-sashal@kernel.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 23:52:12 +0530
Message-ID: <CA+G9fYtJZAioPkbOVJSRY0k6sSKBLc8_ZeBxv3CNfw-gP7yGtw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Anders Roxell <anders.roxell@linaro.org>, Petr Mladek <pmladek@suse.com>, 
	ohn Ogness <john.ogness@linutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:30, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


From the previous 6.7.11-rc1 and 6.8.2-rc1 report,
the armv7 and i386 boot failed on v6.8 and v6.7 [1]

Following two patches needed for the boot to pass.
90ad525c2d9a ("printk: Use prb_first_seq() as base for 32bit seq macros")
418ec1961c07 ("printk: Adjust mapping for 32bit seq macros")

Please apply the above two patches on v6.8 and v6.7.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[1]
https://lore.kernel.org/stable/CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org


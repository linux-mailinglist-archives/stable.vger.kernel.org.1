Return-Path: <stable+bounces-150717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32973ACC878
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59CD1750F2
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72F7238C04;
	Tue,  3 Jun 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="Tam+iuDd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C4238C1E
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958705; cv=none; b=fiYyRu6aVItEwx5x/7PK3oAtWeSZ/7HktHBd394pPUQDq3/zlxJ5LtOTBTVQw9MffBQS/mLz3s9O5SPCB3fPkHk7VQxpUoE9oHwUSlrpa1UVF7NzcpPpVx28YtWRIOp5KhDyug/fwQXcQ88AnVDo+DqEqopwpjJlaeADaVFLy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958705; c=relaxed/simple;
	bh=rFcIgJL6pSIoKVcI/z9SFNckeWUMqMI1IGtxsU9Wq20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8pUms4uj9iydb91xos7oCg3zuo33VJTH9bZnvRxekGTcwRWg+y/qfrjvkgG1Y6RMXSwQ5yKPbUbOlVOdxHvylopF3GX7zUHq1WwIlZsZGeI76HH6fxGci6zjuxn4sP5D17wMSqiTahk85ghK6VvRvBDHhXd/4xZ9EQvhVCctlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=Tam+iuDd; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58f79d6e9so22757661cf.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1748958703; x=1749563503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u43wnlxB4xsEV+8bCEfmi8jE6ClnVJwePdx4GrJSMeY=;
        b=Tam+iuDd7mlzOdtC5wy5g6b/AI1/Ns58pbnICy1R4kCvH91vw0T58ESgqRnD7Jxb1v
         jDqzYlzuY6+vEwi1UCGU7AWlI6prOPyStSTJxORqtiJYlRiNkrLEKkEmE3uVuh94r8eH
         tY7AK5BA11WHAI55xAVyfX8celKhXQ+trMWPuXNxMrykG77rV4Ktkkw7+OwPHWzywNgC
         fM4iy+5uAwrOy3VGxHNqw2QZeU58F0U+N8ZKkBAcnn0csfASwqQZBLgpcR4tiRpfJmSK
         XGv7xkr/CUN010+Z0b8jJXPO2/4BPwjnLhHJgTJYmojrL1CcbfbInJzG0qdEi9H9FJsX
         YtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958703; x=1749563503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u43wnlxB4xsEV+8bCEfmi8jE6ClnVJwePdx4GrJSMeY=;
        b=KBw+/hvC3r69gvSRsXGTBN7CJ18NowbOKrkISbyQRDmbboWRB6vGbFKUa3sdq4lFIm
         2liUG1f/cELF/VlC56+jgrMyMBP9aLV8Y8dwUpuc+7Yk9ozUjdshhbW/E79yHn/Uib+P
         ZKwuQOublS7xJg5UTo9fH/TyuQ4drbo828zCmNVeWkyOrryX+WdzMXZdn0j5kl1ON3Rs
         ZXzrZNIuHpqJzLThpP96pOSOJj42w5LSaQMo5r9h+MVZsxo6jkD4oHm0jKg2GNvwElcR
         PJYPMzjTv+0i20QDxUu3kJh7Xux0jf4i9nts+Inxm8YudTxv35MN3VVKlsM7DB7dmyxb
         aywQ==
X-Gm-Message-State: AOJu0YxNVr5tyQqmyu7MxYAaVRxJGXsTNqN3XbOGhHvroO/NQaLXOsFt
	z6pHuk0Dgifupz5pHAZwxiMLP9ZZVipzA4YySe4ZO4Ds4kmvcR+tyL58SBXMZSYi1LlH+dc01BJ
	ifGnq1XaFRn5VL/T4Dk+Ssy3DeBpjyVuRfOAnDWZchg==
X-Gm-Gg: ASbGnctqIL8QBZtDOQGdi+usGiWlez7hT1/SSe1Fw3rIMcSR9tYBjcxXaEFQptvO/fR
	CsWNgHnJ/58ThQUie+/i5P1Jc1d4z6y8vckCV5PnR20w+Sb6KyWe+GJQOQiWdLi3z1T6xZItDWv
	stF4hABXGqajX8EmMKwCVKXHW/naFiqPZG
X-Google-Smtp-Source: AGHT+IFQVvOosag3wuPv5W+XIJzYaSdxGYD1UMd/R8W8Pxh76H5erVKE3YMDyz7J1K6JRiB3EIiz78IA4aDaPOiyz/k=
X-Received: by 2002:a05:622a:1e8e:b0:479:2509:528a with SMTP id
 d75a77b69052e-4a4400b3557mr277320501cf.42.1748958702536; Tue, 03 Jun 2025
 06:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134238.271281478@linuxfoundation.org>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 3 Jun 2025 09:51:31 -0400
X-Gm-Features: AX0GCFu5TBNRaAAJJpvK8wBD6H5lRVWrlVadCPrD1KQA20azEjh8PY5cFY_N-ps
Message-ID: <CAOBMUvhhS9RpZoOkgkdLaDv19VpGvSDab7oi7nNupJ-P4siD_A@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 10:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.32-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett


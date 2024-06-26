Return-Path: <stable+bounces-55840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330B9180E0
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D5928BF90
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C517F39D;
	Wed, 26 Jun 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzUgl2yX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF6149DF1;
	Wed, 26 Jun 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404507; cv=none; b=rKdkK+RQPGAKPn5lSvfPgurmkH09MEV4KhmuMxyuXfIgqUWjfw+HO1CmqbXm1JdVE27iiE87zKa5u7zCsVz4IbNcBVD+bpPHAJhdzKRqDUOT2i2hBQQ72sEKI+adxOCa9GdSeZznzYZt46Ud2vCdlgaGyc8aVVNIwR7oQoP6AW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404507; c=relaxed/simple;
	bh=QCLlRXgX1ZZCFVtyKp13Ok8pc5WyHMikqDpTarWERWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwxAfULe7nauNpDpcboLVIfnl03uMVbqAi1PmYWhkvvk9Bnek45KXO0eZ3S875MM7llB7xYMEPDp5aJnf4vTXr91Wt9mP8ARdT0012wrfJ13oaVt81w1UV/3hnykrcfFA4LNQCi4+/LbWJ7CLK7N7mvc9/Gp8gub4Vm+xPWcy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzUgl2yX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7241b2fe79so515036266b.1;
        Wed, 26 Jun 2024 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719404503; x=1720009303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=actSsM3hNGF2bGjnU5RcQ1zHPu+xDjUXaQjl/LzrCsM=;
        b=EzUgl2yX+a+JJ+9tnUc7U089zqT2TEMDMrK1WAqIR0E9XI3xEaBjWCmmXt8yCrGAYa
         mu3NvVWULqay/BFz6aek0IhYVPHqiLsg1542Yd3q4qjEkQ1MMPCZs2iasOXWkl24ZQa9
         28P5EnMZ8uCzNXR9JkJSmk/DVJ6nK1nGWO88VsvHf4RqtpbQw82GZRv1SvPQkeqw8KmL
         unFE0sZZrmSK1YUEU19k0o6Evy2i3VbSOlTVyCFCE0IwE5eRDcX3VzzLkVcxHmWLo/yC
         BMrogXudHGmBYw6zhzSIBCwmbvtblI3OwLcgYutb7CO6YfosHHb/ECIBxUeI+moA9WZs
         FqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404503; x=1720009303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=actSsM3hNGF2bGjnU5RcQ1zHPu+xDjUXaQjl/LzrCsM=;
        b=uBZsQ6IISpsxEZXmjel7otk/8oBpfuCdYvXyrNB36QmJ+pz2ffA1lvRSSWEiBUMHUI
         wiGoPYPAa0hZifRucgrYBjd0LY2a3SpUXoOVinx0ZnSKu0UyEYeEtc45dKD+oCtuNyKy
         Ki/oxlg74dRjh62PXVAwBwIwwu40DqCF3vLCiJ3FkvWbWu2wYtxyHSNLsSKj8JBRhXgh
         590FKeOGN2kpwdwfr+UB6+PUd+i0WsY9VJJiMiZWyAolTAeouC5eo/9t5IKlOMaORU4z
         15fX27r9wjEZL3FWoONgFWuzktpcfGZAASOTbrTaI3aQcd/ztgn6IG9/uMLRpv7YDIY/
         IS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMUcnHFTSs5S7VhQEPyVLrhpqWMMEPYWDBD+DoCnK70hq2EOWmRwZQp8o3zl6CpCTsdKPEElwxdkuf3O7VDEw8TMfjUbAjVKGFVpcr
X-Gm-Message-State: AOJu0Yxa80b0IVhVc5XefpgYZR+s8ki5pZlpDlDt7E0itSsa/g8jfZAn
	8rVODzL6GAJ8voogjMc73Se4GQsF5R9AxSGTiqkbJJGZZgdfdlQzjNbbAZu/M4rCcv1ERbC4nCA
	stAUunBlhYQeqRQD4iYSTAlV7BcU=
X-Google-Smtp-Source: AGHT+IESnBMgA6R+BjLPZ43rEzuwryURctWiotcablADk+plT6gf/pE0SJDAvl/7TzfCU2fShP8JiWzI/YbVZY5hVto=
X-Received: by 2002:a17:906:111b:b0:a6f:11f8:c21e with SMTP id
 a640c23a62f3a-a7242cdb66bmr811904066b.58.1719404502592; Wed, 26 Jun 2024
 05:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085525.931079317@linuxfoundation.org>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 26 Jun 2024 05:21:30 -0700
Message-ID: <CAOMdWS+TdRG7sQy43RdGL+j-OC+-SceH+asxFu6685ZdkKES+Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.96-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


Return-Path: <stable+bounces-179094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C8B4FF31
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCBF7A5EEC
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D55343D9E;
	Tue,  9 Sep 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaywNOKr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646D341AA1
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427671; cv=none; b=G9B63ISLnEfufCZ79bKYNLQy4J264Pn9H78AHlcUdtAIf0T2YJM4o+O0eVWybSdSshBdWj0H97nCBICCrgfSYcdSG5+i7704bE3F/IR3ZkYGvkGPEt0Xj7bM8chPjx0gwa+KfDoyuB5UwkWVqNFtXNur50WVqRNsvkMXgVksprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427671; c=relaxed/simple;
	bh=eFaz1FbjLOe0auzFVwB/pCvwCLOzZfD/UEis1KyqCNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGg635X2kMUz3HLi7z5HENsJWyUidXJJp4yHkhO8RKaf9joHQ1df0OpUyhLMmHrbL85f4FF3d7CGrsPzdicZVhYws2VfhLQc8rrFyQw0avZGpgn0KwG2Rjs6T98neBQA96Eb7d/6pBAqwuAqFhpZGWttqSffUCpVEuf6RJctWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaywNOKr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b522fd4d855so1966032a12.1
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757427670; x=1758032470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TeFkN7fcGow6PeEF+7elJ3SB1YToe/OnzJcgFoo4gE=;
        b=kaywNOKrPa+njj05Jt0B53qz1ZYhuhtB+JA+tQ8wTdps17G3HDp6sTuIoQzCpc4JGz
         R84AEsrpjn49dR+q47Yg6u/i3wCfJ5uHlh8bNQEI/eUqzdu+51Q4xpir5aj44KUysKKX
         XUET7XsELXWyK1xXXHn3s/PwfxYXL3/C1rfyvPIi5jQtSvB+n7/kS+ugCtkfCZUtcCZx
         mgI7vN5loo6rcg2Z4ppikoif7KLJr6ctpZM9ZzOlQvw0YcLd1JuziPVWVl9BjpV6rAsY
         Rv3HPXAurBJjc1+LWD6cDTr4VvlgbUidhCnEfN90gUR5TGSUnK+yOfPhBac/hizwFLtF
         /LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427670; x=1758032470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TeFkN7fcGow6PeEF+7elJ3SB1YToe/OnzJcgFoo4gE=;
        b=WvLGzK+Wl1lDKdGSjp1QKfn16k0mzBKltrp8SIBy99VgQYWD/JrNUDZJZf/AnBUmNQ
         RRXCvbj7OsSEodr2UCwBW+Q9nwX+fk7k8PCqfmgqQJiNFGIexOF9h4lVyIREMg3JMJFy
         XI+/dQaWWUBiblrXcOVZkwTga26EacbZ+Hw8nGPsljxuDqXQtOHWkhUERJrPt62qxC/g
         BPJfhEOc31QnRAQ8bEmM4NiZc34mCZ/ltmCoeTP3rElHorul6VujTsOkFkGci/uUCB3S
         kA5KrG6cuTenDV+J+YA0JKjqASVv3asr8BmrvynRGdXk/fZh3vQM3PHeJZ41JfLyYUUJ
         7RHQ==
X-Gm-Message-State: AOJu0Yw/D5xktE29IvkQv5caER/xwi7/Nos8iO58wj0ewhj3BhIwICeM
	rAXhZCyYUXwo3/zKJ1XvYfukKhgRSw8HRKi0P85JZiiloRyB43oHlZTQn/OHWRaABGkyGhFfPQS
	Zi2lEEN4nEL/oicU6mjNrXh/rOkwiEui+r9WXkz5qtQ==
X-Gm-Gg: ASbGncsDga9tVCrBxcHCw0luSs2XqZYRCBBCS7b+JXPy/FSm4auEcIojNOuKkqf9pxK
	E2ke1IVljq3xvC5cOX1g9mSE20FIjIrvKX1U63ZTeYWJkX5J/K5+Y9sppDEgEhjK1irnKjk8/Ga
	r2fJ0p/pZBKwquRXVWguz1MmBAiT+xkUnXop8R2Rcy8vez0wI5kvNpWkog4tIpaZfzl3MVE91Js
	U4V864OGO01lu5KVof0534G/2ErcjZ99rWPdl9vo/WOigZX7RINpKFc6bAbbF/WWIbP/ubv/xq8
	DjOiBk4=
X-Google-Smtp-Source: AGHT+IHcxqQ3MwYg1e6CBranmjT3hbA3KQEdh9KM+28JVgj+Ob7LBa6ks7tZBX8uSiN8HysQ5OLuhZIp+UzO70D3LVY=
X-Received: by 2002:a17:90b:5284:b0:327:ba78:e96e with SMTP id
 98e67ed59e1d1-32d43f09a68mr14437698a91.13.1757427669481; Tue, 09 Sep 2025
 07:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195601.957051083@linuxfoundation.org> <CA+G9fYsX_CrcywkDJDYBqHijE1d5gBNV=3RF=cUVdVj9BKuFzw@mail.gmail.com>
In-Reply-To: <CA+G9fYsX_CrcywkDJDYBqHijE1d5gBNV=3RF=cUVdVj9BKuFzw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 19:50:57 +0530
X-Gm-Features: AS18NWCu9Mz3BICbrj4i65CQRhAEXwjomJBkbcBzM4Smm39VCPlu0yA5D9Oglok
Message-ID: <CA+G9fYvhLSjZ0ir66wDK2FCbdToK9=+r_9d4dfrMA6vuxJErpg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/52] 5.10.243-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, Netdev <netdev@vger.kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 23:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 8 Sept 2025 at 01:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.10.243 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.243-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> While building Linux stable-rc 5.10.243-rc1 the arm64 allyesconfig
> builds failed.
>
> * arm64, build
>   - gcc-12-allyesconfig
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
>
> Build regression: stable-rc 5.10.243-rc1 arm64 allyesconfig
> qede_main.c:204:17: error: field name not in record or union
> initializer
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ### build log
> drivers/net/ethernet/qlogic/qede/qede_main.c:204:17: error: field name
> not in record or union initializer
>   204 |                 .arfs_filter_op = qede_arfs_filter_op,
>       |                 ^
>

Please ignore this allyesconfig build failure for now on 5.15 and 5.10.
Seems like it is my local builder issue.

- Naresh


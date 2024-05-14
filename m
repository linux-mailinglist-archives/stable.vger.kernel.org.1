Return-Path: <stable+bounces-45107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FEC8C5C15
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04792283462
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585D181324;
	Tue, 14 May 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+kf3OaN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277318131E;
	Tue, 14 May 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717689; cv=none; b=o/u6/hQysg/1ScjKyGby9Ew8Wr+TUnKBNEadOXmjeA7J2EA6RtB0BP/b5J4jjHYxeLLrlX/557iuVfrr+xr0eTL7JSGItCbGKwCcyZRcL2gUflOQKVw8D1w5f2+Fvzh58ZQjY8pqiytUz3dkDVQcdeUqPclnECut+LVmmN1FGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717689; c=relaxed/simple;
	bh=qoYnJ6lUUZzta4RRGTWdO73OSuJNHfyk4iZIX7hypxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvVueyZ1P/GzXPMwog7majiHT6xYvnqEbdhat75OuSZlr7WhuSfZgWChK1rlWoxTcQTVHr9evIKkiKWMDtGJz4G4eqlOEkZPOrv8HxMNOJ/rj6p8tYRHMgn/Y0j9KRltKuEfXoFvHxp7kQtqqCtgKKML55L1z+D5zYwVWmRIzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+kf3OaN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so61830366b.0;
        Tue, 14 May 2024 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715717686; x=1716322486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bc4sGc3qRAwdao+8DdkMbvvomRi+vAtNgNPeosj6N2I=;
        b=P+kf3OaNAMZUiZrVk5yF8IhIriCfzVUMD3kI+HyKtVtInVsj+RfXSOM4KK6TVEmlwy
         QmSQpIX4uO0j+aKNTk9JxTkrOevmjC+UIfkkVujtOBlxHRnWZFIpNK8KRrCrE+hrAmWs
         MzsoEKW82IYat9u+4g1yqQn6ztvitnhGkCQUnI+wc0iUtsf9tyzI7PcZJduT59FKj2Hu
         Sp3uK507CTRnmmLI5hfKWvpjivZ24DIA4TvkZa7n5+3PpTk+Fp/waVSaFK+ovGag0xzy
         mjQ8l5zmIhE5HPTab3nVpjkvKobRYn3xhLAFUs8m8hy1JcnudYStxNWGvfhJa6hDJb58
         QysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715717686; x=1716322486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc4sGc3qRAwdao+8DdkMbvvomRi+vAtNgNPeosj6N2I=;
        b=RzihMhbJPO0VtKnvRwRYGRA4Y0Eb4N1VGaE21iypS3QrIxVVo9Tfnw/MHukoNv/koq
         HOsQY2nq0UmbLzt0ut0EV/DHw1hWz02AhEgV+O+25SIT+NRdIAjrAB1mE6ZrMugj6mty
         QWj+e+H4SUPrM/adrvNgiDxPg6+hDLcshW+ygiuyCvT2netmJ0DlRxr2p8S/CorUlpwi
         FtL5VIryLhqiiw1cFzxtjMSM198dLix/Q1NpN7VYmD5mRHo/zDWe3XgbP4Vilkb2BftR
         Q5oguFh8Y4VYnmRiyCBbT0BKv6vDQZ+C1iLvkLIXVzrx/CqEvGSRg8RcGSEPjNdIHoRW
         vx3w==
X-Forwarded-Encrypted: i=1; AJvYcCVXqA3OorHw7dfMC2dWSBGVtYZcavpC876Lv+UsFk0M9i54a2GCcKO+0RweOZAeHh/hPhaZqNy+3RFWRnnP2aNejSpIdmE7PAkjfDBJ
X-Gm-Message-State: AOJu0YwPuTzEpz2xJ8pXoXcPPVsdxp+oqUYEDgxTPksltEZnUNXxj7JT
	XDeKFVTr2mAEXRMWqv7Q35C0wIa7KZYqeAlN+/rO/dyj8SJdmT2VguGgIFN19nwlzFlEXqREMW1
	XRXo5h84jkH+Vq4L+HtOibiPX0Tg=
X-Google-Smtp-Source: AGHT+IFZQpyq/hBgNv523DGpBPGSrC757nSkUJYg1HKA/tgjfNnA2n+ypdhVxgI1eO0Ho/p+Z1a2vMJOK3A4TPyx7TI=
X-Received: by 2002:a17:906:4f15:b0:a5a:89a3:323d with SMTP id
 a640c23a62f3a-a5a89a333a9mr182147066b.72.1715717686153; Tue, 14 May 2024
 13:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101032.219857983@linuxfoundation.org>
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 14 May 2024 13:14:33 -0700
Message-ID: <CAOMdWSLrThZj8SLZNBu-mnnyX_A19FswC5_P49bJ5Y9mMcOuXA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/301] 6.6.31-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 301 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


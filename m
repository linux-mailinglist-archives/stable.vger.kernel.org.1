Return-Path: <stable+bounces-3585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7887FFF29
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CE2281854
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EC61698;
	Thu, 30 Nov 2023 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="WAffCfHa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C187B194
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:01:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-285741e9a9aso1448656a91.3
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701385270; x=1701990070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1cVYcm/OeSo6BOhKq2FohPdg3opafKLsK7d+uEW++g=;
        b=WAffCfHa43AJ8WcUhhvn2rNO2KY6+broUV6nm2v/W+u7Rt5bDgD9AkOA5aHjZZndUx
         hwS4VJJX0MDP3vRLidy7CvPLLwr6NRih43ZpYgBxF5W4TO4Ho869fpT2Tfdxua2i6NAo
         FwT8FyjW11seaPSccJfkfCS9LgiFmiNmtEvUxpnmRGqZjW0pVkIyp3IuIuonraNUNrSW
         GA/j8ozz1iFjra8N7Z7BTd6BopAPZsNZEZs0OyEBW1X2/k1Q2alMyaHM6KiJ2Knp+JnS
         CI3KrXnP2yAgENAYNL0y3z+KWbfC2ddDQK5S1AF11TI4eTqHunXDvnKaXGWnJmBxtZjO
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385270; x=1701990070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1cVYcm/OeSo6BOhKq2FohPdg3opafKLsK7d+uEW++g=;
        b=BcyUxjnJwzYgslyK7REXaOOcDfHJ70brQcMdWjUeuLOZGk8r/BUr/jAkG7i1SBqGpV
         mq361pIvZsmUffB9m93femTAqSVMrHwc7crGOwivRz5d7VB3RMqxBvcBhZU4kb0+BVic
         SNYZtd3+qnu/woRqNiWqWvfx+CoG+OiKH2JNz9tH+USEJtEtpjfzwQPkG3+Uu8cbnhay
         wXZcnUMRo7HnHh4LhGRmGi5MdqQk26e9T1rJEzyQ/yQ1JBFRrvT3QnfxQ1VC075fqx0c
         cRcY/80RrdXRq2Vx8vtc8qiyxzaDD8T9c3Gmu5r3539y7aeaho5ug0XY7KJ42RNFXnhY
         N11Q==
X-Gm-Message-State: AOJu0Yyn2yvlDfG9K90CkCJbAMZBUWv4IMZBiH7eV1L9PMKvDro4XDWz
	OS4rsZLFeu3OGyfj4Ekfbj9R8mpln8H0oVXbGnuegA==
X-Google-Smtp-Source: AGHT+IEdrStr8HreR71H8RgH+eVepHBA/3COgP49K7ESslFvasx7ODg2jWp1x8fYZmT0haRhQ9m/vFdzQPvWb1TtQsQ=
X-Received: by 2002:a17:90a:1dd:b0:285:9940:1bac with SMTP id
 29-20020a17090a01dd00b0028599401bacmr22407438pjd.2.1701385270090; Thu, 30 Nov
 2023 15:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130162140.298098091@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 1 Dec 2023 08:00:59 +0900
Message-ID: <CAKL4bV5f+0Pbc5wLab96mqHfhHxv2rKDh+yiz196cSSvw9TU+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Dec 1, 2023 at 1:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


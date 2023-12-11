Return-Path: <stable+bounces-6376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313480DF43
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78BF2825E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D55256468;
	Mon, 11 Dec 2023 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="2v0U1YVa"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173DC3
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 15:12:30 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d67870032so32831075ab.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 15:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1702336350; x=1702941150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzlKTDy/RIEAdRnxop/v7aizphXAOoNjFGr5djxk17I=;
        b=2v0U1YVak/gh+PyyOxHQFg8+3jlQ3YUmaFGVjMHC/s3iBhfFCf6WmZpFMJy1CFKctT
         Jtiqig4a2vc2+D2c5r1Aa8ahd41JRZOzr8jzF2f+XpUujbB7qdRx8fc+8OYqgjGyqw1Y
         ssaQB+zpOH/C9K2BhTOTGnil+zcVDwjw7PUp8UfWHEMAAcMhIsmBbBF7Jf9QnG8DJaEL
         Klvutsrkvtfq/f0Pxy7ote/Q+l+RwSdWxX3v3RF/+MDHImv+qlWkmROwVpoLmn5F0Ri9
         a+cqt/qkMxhylsM3XoCydu/rbVf1A2gAxTOL46hsJsY1QbCRVdLL/0KXjrr7TSG3vvb5
         AUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336350; x=1702941150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzlKTDy/RIEAdRnxop/v7aizphXAOoNjFGr5djxk17I=;
        b=Bf0qgZIr9qTNK8Chc4gSek4ZNTTG5vOnMQ1/oCMpzjeOD7ZthdvEjOmyqNrIt2rHUg
         Kqb+m6QbzXdYL5gpseJTGDYtrstleew1yYPFYdXBggMahnKnywNipn+kG8j20kC3MHcm
         P7vbNWBWswkaV9IQDhUz+ZppVmGMLxDg7Zij2YgsKWfV42dVPiz4tTPExCwxLcR2uZWO
         6OCE8HUrlS7PVEWh9RE3Ceoujo4TkjIwhowBTXL7+ng03BDMw1sSyHneG34vhngl4yId
         sYcofT/cKABs8Ecj+2zY5Vpa+hyJtYbv7uw7Te5BlemYj05H6pYbZwrbJ4KLhIZn7OTl
         rv2Q==
X-Gm-Message-State: AOJu0YzoWuyLgj6hlndRqRbcOiOjQBfRYKHNHuh2IVfFA1czoLzyJAUj
	MrPkpZiXK/jBUvWu52Xlg04BMlbcfq4OL2D+L2K4Pg==
X-Google-Smtp-Source: AGHT+IHY1fYWDJPUV8SQB9YLhJzscvke6ZJL/pin8flSX56KTuPcOW+twpGkORoR+m65xh7PMYfnOBMu3UHmIQaQ0hc=
X-Received: by 2002:a05:6e02:1c09:b0:35d:59a2:2cb with SMTP id
 l9-20020a056e021c0900b0035d59a202cbmr8110442ilh.107.1702336349600; Mon, 11
 Dec 2023 15:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211182045.784881756@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 12 Dec 2023 08:12:18 +0900
Message-ID: <CAKL4bV7DjZiNLNcWrMx9A+pYSaObc5F04=4ia9YkYaso3_3b+Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
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

On Tue, Dec 12, 2023 at 3:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)
[    0.000000] Linux version 6.6.7-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Dec 12 07:24:53 JST 2023

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


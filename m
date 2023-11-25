Return-Path: <stable+bounces-2642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A997F8F74
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCACB20FD5
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64630D1F;
	Sat, 25 Nov 2023 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="B0chO/CM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA9EA
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:26:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfbda041f3so2564605ad.2
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1700947560; x=1701552360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZRuUkwAJQSc2B5TiukCCmiozHQbQ8NLMPMFjeYqUcY=;
        b=B0chO/CMMktE/R4qRpcm5Ybi+O2ryhoXTE/0MfvIR+Cu6kZ7aNiaZxejtoZ6hBEslC
         wo8cR61QbSThxOwSDPuwaCN7Ctzw7pYdbmMBs7TGET0woU3yl9OX5BAT3zOxj7gCEMTw
         rgX9e3WdWuq7KXR7Hzq/PFm5uUdTomYrLPLfPgEMZosxUevj+3874/QNhFhefGjZMZjV
         qo6Mv8I4ySVfM/gRFMb/ErXpTN+4Ev7al2OWVF8SozHcxogltG1eHDnMSYYt+DYayISt
         636YjjUh16gDps1kFYEjyu1xi80qscTb9I/KRcfyfp1UZCl++yJHRBJcXaZRvhHW9b5X
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700947560; x=1701552360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZRuUkwAJQSc2B5TiukCCmiozHQbQ8NLMPMFjeYqUcY=;
        b=tJkHSCLvZYmTNs06ny855qz9RrDLNdisYQU94lDxWPO7lUoVXh/rhqzub08l94oD3L
         NV2jr9xzKPzaswlLt6e9+YjtNceFrSNbjDOIwOc1+qudKv3SQZIydazCY05vbJVtz7IG
         nHbTpdIpc7mETQZvtxRojrUFVBlhJvWAIeY434O1veq9BezeFm35pnDQvzEVnCceANz8
         lKcYehgyH/CuV/i66FZhpUrrl2MLqWg4lyLRnUbEVGXjY5t0f2wIplyn1Y5mJvsr1IWx
         2cfqrbwCt+56b+trETnCVhyM8iQbGxAZaQU864IEMzivDcFibZkNnM7TTQufP7N5Nv4U
         UsFg==
X-Gm-Message-State: AOJu0YyhUxlo0C8MUaFF/gVWMbRrlMNRsZTfqHH7yDPX7jDr8USJo2Ri
	gkqL6/UqwRKa7sFPV7vshLtwZ99+WHdw+r0ligdmbA==
X-Google-Smtp-Source: AGHT+IGTUTKj+kSrY+r7f26g2zZ+p3i6caFNXxcPK1JnynJ+975K68HCL04h7m1UuQQ7vEmVaqfUL4Z+n9UO7j24ESQ=
X-Received: by 2002:a17:902:ea10:b0:1ca:29f:4b06 with SMTP id
 s16-20020a170902ea1000b001ca029f4b06mr10068270plg.2.1700947560518; Sat, 25
 Nov 2023 13:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125194417.090791215@linuxfoundation.org>
In-Reply-To: <20231125194417.090791215@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 26 Nov 2023 06:25:49 +0900
Message-ID: <CAKL4bV4DwJ49GLjiP2qE1dhiWtuLn2ybTWju+QFNwQfUckTr9w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
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

On Sun, Nov 26, 2023 at 4:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 527 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


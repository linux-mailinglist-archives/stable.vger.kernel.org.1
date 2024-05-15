Return-Path: <stable+bounces-45115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687238C5E57
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 02:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E781F22074
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4B63C;
	Wed, 15 May 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyyshJvY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78686184F
	for <stable@vger.kernel.org>; Wed, 15 May 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733425; cv=none; b=hAJ8ztVF8aFKMSWKRCXKJ5tR139/gdeTF5y8kcsUTX60Ur/ErIv3ZM3FnOy8RupstFXfyGMpWCNv0tFl/TIX56OHfJsG8Oaozn/BNRcq/nLcbn3f7xnvwBtz5ys/tNqae2uVkqsyAu9VRV/29kh7EGM2e2q0d4JneabaiSmvDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733425; c=relaxed/simple;
	bh=oBWUlEWluAHTiq7x5PmtdIOTVCfEATl1uVh/AdUEqHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNam5N7nHkK4lquR9OJvaavBtMfjtQt0n5Id9hOM578bzM5dGwAvkkEc1jEoGMlBPd19G1ZVaA9Y6HCRDiMI9Z5jQsno875Ri9gCekwdJEpavm/FP9GA+aS0wSlP5jmLgGCASrmqJE0kDG6r3Org59R25GAhCkzTjQGm9jc71Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyyshJvY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso5002800a91.0
        for <stable@vger.kernel.org>; Tue, 14 May 2024 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715733422; x=1716338222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk8qZUNPyTPW/A1KHzQN8z/XqvExIz1hHrnYNu4UtMQ=;
        b=vyyshJvYs8yAkZLGu0uP89N4TA5+hDmJIQacYBc+6tRafITwWoLnHAKhRUEnfJTB2X
         a3FyFsHxXbM0Cq2D4bb6XUizE47+fcEz9rGmakLRoiOCCI8KfR6+vOID1NW2q2UBLAN6
         vzxklkpoaA9DCHJruxhVDmQCz80CpdiKajtwL/fwZACECgl3v4xNzVVfM2uEndErhcHk
         IV8lFhxeoRCw+5ZBGONnJA0x+BwWHeP3VkErLhvWMzccugMWV4/BiPwCuPb6MAkEsf6f
         a130fqrlBHBVKTKKJNRdVkLTSEFw1i+d4ROA0rEDW3peA4GMfAIDs81kQrUVz4UKTxW7
         gu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715733422; x=1716338222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk8qZUNPyTPW/A1KHzQN8z/XqvExIz1hHrnYNu4UtMQ=;
        b=lT7COqYX8Up0cw+iGFoO0yuoGPqOanfFwSyO0aDiRe/D8dtx5oIZTdQtMm4LUockw/
         DPO01hevIvYhRwEWLkaJyevI0bU+Kgm9fWV3qjoWECmPfz11VDe7Jh9KXnquK6j6DB3V
         MsJ86dHp7bUCdoJSeONbwgFLalIY7pttxbaMVWHphu6gUYbIEgnA87tEkipi65oUMsmJ
         maoq5Ze2WQ8ywBzKN2h5uoR4KNHJHvIRuaIxTYl1Z7b0WxjoaKMzFO7ITIDb4eLqnx+2
         C9ZIOxxhrRqan2qkdB0JBJEeKK2Le9H2Dpoc04pVJm5GUsteYGtT22wOL+RCRUkZck/i
         BD7g==
X-Forwarded-Encrypted: i=1; AJvYcCV6GVxEKwIt5C+JR4Lw/XBV+Sf86JBOevRoVvZuAGukgGamdGB0duHoaEOeI9EZ7DK6ImMoZcfbT5mpQRW53S3L3YMhpzGI
X-Gm-Message-State: AOJu0YwkmAm5cBZCAioTBxVI4TxPK+t9bmmhI5/hZPvMqJwZJ4vBxTV+
	5xcYiiAmkgm9L0ci3vdSkrHkcdromY5MSCwFbA/QTGf2CCtki0hWIgsd2o7O3H+AGyNdb3g3uvU
	gU3Exv0oLkx8a/fbn2/Ik2f5exr80LqAJUQfI
X-Google-Smtp-Source: AGHT+IHeqrDxqHwSqE8LkP9zNnO4aoIPfWbbw91OWLX6RaFgTT+3fK4f+394LqJxYkdL3RuANgpc2LoWG62WKveVJjY=
X-Received: by 2002:a17:90b:438d:b0:2a2:f4f4:2c4a with SMTP id
 98e67ed59e1d1-2b66001a442mr24360414a91.21.1715733421460; Tue, 14 May 2024
 17:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101006.678521560@linuxfoundation.org> <5beea8ed-b92b-4bee-b77b-4a3d57a5c001@oracle.com>
In-Reply-To: <5beea8ed-b92b-4bee-b77b-4a3d57a5c001@oracle.com>
From: Martin Faltesek <mfaltesek@google.com>
Date: Tue, 14 May 2024 19:36:24 -0500
Message-ID: <CAOiWkA8SNRbCPZ_gHQRczZovokZbFSJXQc1vUmtD0quZV9tp0Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc1 review
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Vegard Nossum <vegard.nossum@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Build failure on arm:

In file included from drivers/iommu/mtk_iommu_v1.c:22:
drivers/iommu/mtk_iommu_v1.c:579:25: error: 'mtk_iommu_v1_of_ids'
undeclared here (not in a function); did you mean 'mtk_iommu_of_ids'?
  579 | MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
      |                         ^~~~~~~~~~~~~~~~~~~
./include/linux/module.h:244:15: note: in definition of macro
'MODULE_DEVICE_TABLE'
  244 | extern typeof(name) __mod_##type##__##name##_device_table
         \
      |               ^~~~
./include/linux/module.h:244:21: error:
'__mod_of__mtk_iommu_v1_of_ids_device_table' aliased to undefined
symbol 'mtk_iommu_v1_of_ids'
  244 | extern typeof(name) __mod_##type##__##name##_device_table
         \
      |                     ^~~~~~
drivers/iommu/mtk_iommu_v1.c:579:1: note: in expansion of macro
'MODULE_DEVICE_TABLE'
  579 | MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
      | ^~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:289: drivers/iommu/mtk_iommu_v1.o] Err=
or 1
make[1]: *** [scripts/Makefile.build:552: drivers/iommu] Error 2

This is from patch:

bce893a92324  krzk@kernel.org           2024-05-14  iommu: mtk: fix
module autoloading

+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);

should be, I think:

+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);


On Tue, May 14, 2024 at 11:29=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi Greg,
>
> On 14/05/24 15:48, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.159 release.
> > There are 168 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> > Anything received after that time might be too late.
> >
>
> No problems seen on x86_64 and aarch64 with our testing.
>
> Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>
> Note: selftests have a build problem in 5.15.y, 5.10.y, 5.4.y, 4.19.y
>
> 5.15.y revert:
> https://lore.kernel.org/all/20240506084635.2942238-1-harshit.m.mogalapall=
i@oracle.com/
>
> This is not a regression in this tag but from somewhere around 5.15.152 t=
ag.
>
> Reverts for other stable releases:
> 5.10.y:
> https://lore.kernel.org/all/20240506084926.2943076-1-harshit.m.mogalapall=
i@oracle.com/
> 5.4.y:
> https://lore.kernel.org/all/20240506085044.2943648-1-harshit.m.mogalapall=
i@oracle.com/
> 4.19.y:
> https://lore.kernel.org/all/20240506105724.3068232-1-harshit.m.mogalapall=
i@oracle.com/
>
> Could you please queue these up for future releases.
>
>
> Thanks,
> Harshit
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.159-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
>


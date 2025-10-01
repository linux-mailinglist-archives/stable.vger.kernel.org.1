Return-Path: <stable+bounces-182938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF110BB0822
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCA1883501
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7A2EDD6B;
	Wed,  1 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="XRWN3H2D"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5381AA8
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325433; cv=none; b=QVQmOys+9x9FW6+tatY98f/WCqqlKdU3axj+ru7YPs2JEF1szecrWCOTc24jwnN4YevzVlF++uyAaJtVZX0p83Bp5wCgZ4pL7nXykPz2kcms2sI5pIcGOvE+OK4l/eeBiZya8IUTJdUXEMqNDJ4v/64g9yxKT5ufEqofQkN/mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325433; c=relaxed/simple;
	bh=SktQ3kOlhBAC2x3vmzqqiWJIKayZPjyxZa2VPO2W95s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boRQalNEIRxJIgJlAC05yWXqM5KSgLRG2d2xA/dKUv6iLIe9QIIp0N732FuKycAl/MopWrPZAbgON/AuTLTJvzuUuHXWlzScGUeHlRsf3P25ZOKDHIYejzooiNlPy/zTSuqNNxCQp8vurklWEojWV2qU0SR04oW8WS8L0dPFQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=XRWN3H2D; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8572d7b2457so126022585a.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1759325430; x=1759930230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCwcUuDlR2HsB5Hk2ZIMgqVF/pdzyf7iXfwKEpkpRxM=;
        b=XRWN3H2DBctRwacMAgmIgy7S3DPK5sifTGOkdehLWCgX6Xh85EJM4HafWsaiqhmLYD
         Txh1P5B268DaqKix3HPqNO81gomC1KYvQOUFrMIj6nmzHIPYDkS6RGIsudW372UZ4/u7
         1siql3blj3BL9vSGyvZqh2cp65N1VPKtMnTbX5QuKthv5vws+qKRxDYWRVCxR+XOrKfh
         T6dIbnde1KL+9ZLSG5Fqgbo6VD6WTmS3duo2m2K7mptm5YNlUZhBn6/nzyLOmQ9Tl5Fz
         cQOInFASfxJf+2zOmbMpXWIEsUlHsBUGChLRtL6+wV5VSYxOoyVxqIDlpGjqVa80xV35
         4FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325430; x=1759930230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCwcUuDlR2HsB5Hk2ZIMgqVF/pdzyf7iXfwKEpkpRxM=;
        b=ZsQhQouMvIuYNolZVsBI38jwrXTKohFWyeIDmyB6U03TUveWpG63bt4J8VV9/MulQD
         i6lUq96gDamf+/8JKG6FJBNvkwLioGPGg2Hp0UF8jaBA3rrcl5BvCCtRI/IZifiFxVvv
         lbAeb+Ibd7KXWF/RFjjV+2atKpk1jZNi1s6tCMpCUCGtUyy5naZmR+FG1Dfd8zHFhKfF
         rMLsF5R+rTngcu2KSaD+nIYXWx+MAJPsn7ouWzbulRMmuybWDY4YhBiURw39sZi+tUP6
         kJBIXU5l/TaQuwieI3fF1FR97wPHO4RnJmIv/On4vuAYn0Gp3pNrZL2duauka3vskOrH
         SuUA==
X-Gm-Message-State: AOJu0Yw8QwJvW7h+moq8ibetnJcS+D7nxmq04PrD9E743eGDdyYiGo3L
	LcUEXe+ZLsr4KFhnHSvhPjca8floZR5CvkIPDCj7+ZRW7YzJVHzyGkHBHCM7a+t8k2zVgjjp+dC
	qcsJdAi1EYRMUMF3jujDiQPMkv2f8njg0kmHJoXFQLA==
X-Gm-Gg: ASbGncuMBTsd9BhD3YQF8S+pAMexRmGVS3W9h9RBaSUVErq89y7UGBpleFZ1/3qUsuC
	3WLetvJU4r6JWr4vVqcefb9l3wbOOm4y7wBfCSUrShpaHxkySlvGGF9QkpAnEiwQFaCSf150kzo
	ZS0/bblA467vZOQ7KVGRjRlZaHJwzTbUPUyAyb+F52HWgNb70zezHoWcEq75/n1+Ru1l+N02JzX
	I041yF7dYLuN+y6S4DCBTAIstZz3FLV
X-Google-Smtp-Source: AGHT+IFMFqctsC/gdxMYa79bTEHX3fAs8ipIL5VVoN11C3E29xDno2ZFwjrwO6xWIEz3lEpIgS6pt5gaKnnHsGAh2P4=
X-Received: by 2002:a05:620a:4508:b0:84f:8eb3:9648 with SMTP id
 af79cd13be357-86ee226f9b2mr1216961185a.36.1759325430066; Wed, 01 Oct 2025
 06:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143821.852512002@linuxfoundation.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 1 Oct 2025 09:30:18 -0400
X-Gm-Features: AS18NWDMzWRD62Q2toC84MiLOfA3LeeQx4tD34WUJj7d19lC0jxZJv7F6icp5OE
Message-ID: <CAOBMUviHCYvHce4qoy_WXNK1tragYg2k5DbgpAxy_1dk3YtD=w@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.50-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett


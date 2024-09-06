Return-Path: <stable+bounces-73787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835B96F588
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17886284652
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623C1CEAD2;
	Fri,  6 Sep 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="jRtVNlBZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A811CB330
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629943; cv=none; b=Uyz7e9W1yOi7t9o83e0+Eu8jipRx1nlVVTB/v/K+FMk3oQJeqkG1/LY6TxzxjBKc1vYbQdG+zlKyH3aQeSAfqOnGVFBz4+qOspX+e1s+2ePkbLePs8eWoi7J8mjPiERUaL8t8WE9H/27vshtsbtB67OD41TD3swTz9Jb9eROqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629943; c=relaxed/simple;
	bh=QVsf0P+mtHtWmnrlhDzcepBHBPQIrcMSAMHPNfjf9QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7enYfgxXjGTFKKd7i8FFtWb2IS6jrxyftDRT7tgR3nmya2LIkxU/ePmBY7FoH5QCX/7x3OMqSf22QOcLlg6fUy9KD/7iAg4t6ryG0tPtkVY12nh5//VQ7rHhrCvU2jF81RZBoNECkmKpmnVH07fLBefbospG2JFUhh9plkghAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=jRtVNlBZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bb8c6e250so16077075e9.1
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1725629940; x=1726234740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+AqCSr8HoChcAFGwGiSrmlNcV3RopcVFPKN/wyqjkU=;
        b=jRtVNlBZ7YUs+KA+YzHMAK684kWKTs5liS3psRTCm+7hcq0Yj3zmnozCbmfJfiL1x7
         trc63GAMoggQhKF5i2tjwWsPoaWojr1TGNKkgiyvn3e3CsbuPj5AlVkPI8WTfM7lIAe5
         Xz/hjZ/JssrgIecFuBAnDhv9/BaYbppJglB5Mdq5og1aRGIk7Zd5kmxMZW4I43POPNOj
         uk9LPJmdiGH5BefoqjMVEoiuwi/cxU+nJFndhL7bTyw4ae53n+JKeZKxoDU9KSQmxSyl
         twz0p6MhCbCIhAPvIk8uwXhfX3Lz+WEFR4l2/PyNyiFxWliCFDoTnNZDRyK1n/IqtM3K
         0OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629940; x=1726234740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+AqCSr8HoChcAFGwGiSrmlNcV3RopcVFPKN/wyqjkU=;
        b=uNAYPADh71tgFU1nQzVc3LJ96q/rh1N1TlNcgbaiCsBU1wTENN82G76PLdA/n6RJCC
         Ay1R1bkWzmz7nG9t7kG7mabwjj+/zcDkm+3Dhr8D3rEHRiOw1u9DufM5ErJrUHvLgXvq
         zyK3unlSpfBo+d9iT3TC4cf5A+TqY/VCFDDM/xOWR4vV5BnQp+n3u9MZPcdgZ1eSQ761
         8QJN3EDr/N0eZnVYPdnbP+6i+80Ga9qaIRRprbXTx8KF/Ke6btZoPPXHuVwzx/VN4mga
         h+YJnXjd2cbqrdteLpjlKeff2g6Wf+lJ/uikwgeKjTTO7qaDfJkpa5R7x1N+d6OtVSfv
         swtA==
X-Gm-Message-State: AOJu0Yw9UTyzd1dO3AgVTClKVNv029mmfu072NwY9/EfeXfvfCXm2c39
	o2wQfjEolojVar/706BGyOz82tO6bxk1ZWNolDTgqVfBv9vp4zDYOMYqK+wincBbIs0Ih7rZsd7
	vhiRsiwkvpwdIpkNEr4uVK5FVfb/Z4mQkZlWSUOTHkvy+nZzbuXQ=
X-Google-Smtp-Source: AGHT+IEs0TymDN0qb1H6KzoG9uLNWYfnTI5aRT0d/XNeG7DXuzTNxv/klqY7eBy6ztM2Bw2F4aZOLOo9bzWg7LFprN0=
X-Received: by 2002:a5d:69cf:0:b0:374:b71f:72c9 with SMTP id
 ffacd0b85a97d-378895ca1a2mr1946306f8f.16.1725629939583; Fri, 06 Sep 2024
 06:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905163540.863769972@linuxfoundation.org>
In-Reply-To: <20240905163540.863769972@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 6 Sep 2024 22:38:48 +0900
Message-ID: <CAKL4bV4GT2R5WZqzTXkAkY6d8eL5PLnnTKoDK-XXL9pCzj5nbQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/131] 6.6.50-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Sep 6, 2024 at 1:36=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.50-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.50-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.50-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Fri Sep  6 21:24:14 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


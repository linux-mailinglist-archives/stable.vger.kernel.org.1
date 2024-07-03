Return-Path: <stable+bounces-57919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67269260F8
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1DB1F233B6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AC178360;
	Wed,  3 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="qkKeVgqV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B9177981
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011295; cv=none; b=ubHYxJ2roWp9q3e5xxQnTZZjV4IiP21Pz1YIhxWV0gozEBz1YGO89tAaen9ihiQBlhkzMJBgutp0p7t0Rse7cLOnEP4MvmT0dSrIYwgPFav0VyRrJYfbdTQYGoSnjIMpYmwrRtpHOu+15VIuFIhgaCxjH4nvPhn9pYe3Hi/tAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011295; c=relaxed/simple;
	bh=rS/W1TqSZ7g/nTd/PX/LNoXQ3bRZucqWJPbOkYLIWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbnFlf7UGyAkp+OTN+SbgWXSecxvtCScjtRivvCN7lK9oT+wWrPzhPXuTEfpUULplBmHMKqe2OBMGlr7HzHYNkP6/nvNy0SI6FAs+12GFYhJnJm5EyegcBtdV4XUIUfYkXcjEYUJxVHnYY2bWcnMw0HkvrsX6veEY2PjWb9RfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=qkKeVgqV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c96f037145so899048a91.3
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1720011293; x=1720616093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=855SeBJK+kQf7yXIRTBaRAUIqwJW4HXVIPFfDWbcfMY=;
        b=qkKeVgqVy2uM/EjmzNmoPeHxE95g05fjqa5c6spheBbedtNopGlmxFHGeQmr+IZI7i
         d3k020UBbuwZl8cb8qravxUXirgmT7mOckRHlbCrcCqlIKdgpTFViYEor8k+wwnm116q
         /RAIt4efJ9fk7rtAe2vP4xvKb96Ia54DU4QejUlE2HqE0OxKefAUIvgPdeGonqNrQshx
         XbfPc5wo2A02qGC4csBGIQHU4OCDik0W9551omv66wjM2u4Zi6+vP7uvLoqoixRwsL+Y
         9qjonhJZvSoMntiYsJlV5cdNu0MWoDi0KdyunleKktds6BaoqTP0JXp/Lghd0510Bu92
         grEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011293; x=1720616093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=855SeBJK+kQf7yXIRTBaRAUIqwJW4HXVIPFfDWbcfMY=;
        b=V6Jre/jtVZ2MpV65DX2QZrxVKUzkWTSE69+p8qUbvs0JRfJd7JVMIOdOkzRnqyNTxV
         wmRwl5Qp+tvLqwIhXHjcawSAxF/PzQUtxxSqW7sqdbXl4axK/QqVwPsini0psrnGdREa
         zr7bg4dcdlpJlDC4wvc19MNzQk26Ya1Dy2HBnUyUmkSHlxGntfn7YrAgobYfKdz+ivJA
         E/2bKm1iOKJ93Wpdr2A7vWm2x253KNYn+ell9SAnPZgMYjpXMmsoclNQbbqgqZgax+7/
         jwb3NS254qcyTHW9hb1JnreFAc4RQWMKd3VlBlytaCVAM6ZRzMlw4L0yuF8Im+FV24Qf
         n9Yg==
X-Gm-Message-State: AOJu0Yy9U1ExwljQPB64O3wPxoR4u5yH+QKQ/Qzvkg8vzVda1Xkl7uIv
	9j0XvsEZDG0N5Li6YYzwxz2m56jvImsY2jCn3U8nkaqstrtOFwIG/VlrwUEX5XW0ie0JfvWLUIN
	VwCYJst+JzJJcaSedPCLKrVYLOAhT9MUFQttyiA==
X-Google-Smtp-Source: AGHT+IFeyxBhLt9MzjsdGvcxDI6Ss8W8+j+tZYOJYbNYqfjc+caqhGP3E6bzdV7g9BE3Tqajxbf9EkaaSQfkC7aoh3c=
X-Received: by 2002:a17:90a:8583:b0:2c8:df15:5ad7 with SMTP id
 98e67ed59e1d1-2c93d777302mr8133982a91.45.1720011292909; Wed, 03 Jul 2024
 05:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170233.048122282@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 3 Jul 2024 21:54:42 +0900
Message-ID: <CAKL4bV5_povtwC25oFZfBHHzjHN_=aKGb_0zE_ZJyUJ_WseeNA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
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

On Wed, Jul 3, 2024 at 2:19=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.37-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.37-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul  3 20:52:59 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


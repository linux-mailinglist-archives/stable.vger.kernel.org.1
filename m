Return-Path: <stable+bounces-87724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A39AA2C9
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B920AB2272F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7619DF77;
	Tue, 22 Oct 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="mpm9NsO/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779019DF4F
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602525; cv=none; b=sM06D3ojfF4B+ALAoNSUCryaGb98okO4oHrKrDlGxLp5s6jxfHj9UMqpn/NNjzHNU1yrFY97V0gB4BoZFWrAuUIcHcL88oJmwiYTD4vOJfo16+p95C4u/thW4DySbavLDfueZzVCJ47oStM/VzIZLHEFfTnSR/g/AKM2sCYR3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602525; c=relaxed/simple;
	bh=3cVOqkFRTnn4fFWxsQTNO55gu0wUXV9eMQLfnE+68dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzw3Xe6rSQF2Rgb4Cd/gJVTP4qKjgUC+ZsaRvnHkgCGxxFDsjkRszbxUZNan33ovkdobpDNoFkAQzptO5ohge7bkSCVz5sYOLLzXf9BWNd7tiZuUPxOa9xK+x7PIXLDqEyZXWvBW7citPVVTlltkZWp65l1yCqiS0S2XypWx778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=mpm9NsO/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so3814823a12.1
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1729602523; x=1730207323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSD76+9WkSJmJmUZ0lbLq6LmsKkpMwJOlweUzuTVP0o=;
        b=mpm9NsO/sfGnu3xOQHDwQLGxLRiYKVMDQBMTUd5qZwqd4/QawZkt1zzIgN/wn85krQ
         DWxgBUtz65t/i4Ayn7sMMKR+DlA+Kwqgo2agvysE6hEj2ZnAjOQXbt/LB921AFtaBa6i
         BhJ88/W/zaN6bosobRr6riPnGYY5KbPzzzXtYYxYftu1Z3hXw+xkTf4Zm9PgWlY2DD1d
         UfdHgJ/sgyeyabIkbQxWJaj0AA4SRR2xkqLS2m6c9j8kqDL7FHewB9C7joOMdAUD/8Pw
         rLfoZd7d6mrV621Y2rhgV8MiZhXYZFgVrcAoVV8pMVMlD3z97DZtuw8ioV5T3ziDQSGc
         i1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602523; x=1730207323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSD76+9WkSJmJmUZ0lbLq6LmsKkpMwJOlweUzuTVP0o=;
        b=O5mbPgnk0ahIRRy1+ci9+35Utw0nnIsD+cdf4sIlwy+tWyAKr1+MpDIxOvWhnOg9xL
         rzq/aJavyCSyuxol19GTz8rdvL38pV45NZ6RAu8339oiTKlY7uw5ZDtoXtFF3ozfIVhl
         JgKi0GnyGFDLemdE9KKXYTDYexizxW4ksXgHTJN8UpaDJ/+CP2d65EljiXLYz3kblMwW
         qaasjYl5hZ9hep7nFdEWU8wl29K2036z6lSIoP7s94ML32szUwF3fZFvkuPCAvBAziXN
         mNIU9iySD0VwDEAVHqFc7c4CPCq9MYPYQzT87nFUCfpmK5bU6HJ+VTIBKMzIaPKA1MVr
         Y9lg==
X-Gm-Message-State: AOJu0Yzki5IptYDMf5VnX4hHKGe0cgYRsMcyZZToLff+Z/XnuFDla0aQ
	xDoPK3r/bmKHnf7XiXr/u52UnM27QKeoJn8VfY7RXVbZNenRKvQqBzl6Z7vRxkw/zSBFUQtSimN
	gvyUgcdyr0coIWxep7X7pKGslGtR4e2FIQfK3Ow==
X-Google-Smtp-Source: AGHT+IHbGo2VQ8g5GmCprVUnwQHQ7CqOubSGDzGzyMmpKVAzodR2cXRT87GluNUR/opfbavjfYATFita6FYBPaa1n2s=
X-Received: by 2002:a05:6a20:e617:b0:1d4:e51a:932 with SMTP id
 adf61e73a8af0-1d92c4a0187mr20939890637.8.1729602523000; Tue, 22 Oct 2024
 06:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102256.706334758@linuxfoundation.org>
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 22 Oct 2024 22:08:32 +0900
Message-ID: <CAKL4bV6PwEy7ShiMBj18NofyQxtC3guaRwh_ZNUOOS2Ei4Hz3Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.58-rc1 review
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

On Mon, Oct 21, 2024 at 7:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.58 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.58-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.58-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.58-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 22 21:03:58 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


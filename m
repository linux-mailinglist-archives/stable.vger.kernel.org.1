Return-Path: <stable+bounces-26748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0C87199B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627792840E8
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640D53383;
	Tue,  5 Mar 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="zWtWdYoX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587552F6A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630983; cv=none; b=c9jmF3fKJ6zVkDS+6TS0+R8e8WxnWG/6n9B245NY8bkASZ6rotlRunWgS9ADWVHT821qed6lLB3U/syhtLDkm1DK4Sij3R+OzNyqkBhaqhtQYoXe8tOmvfoHE5x2EANGBwGT/id58WrZZFybDFqLzIIx4RxwkoB0jUN8p2lWu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630983; c=relaxed/simple;
	bh=fwwZcoGwaB5irpy1rxHWbnfBT46aa54lt77MG6kaomM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB7JTtJcKkODFExOkXXwe1lzITOLeyqC3pwE1ZyDVTOviOmz6DZF4XMqC2I2KUDI+DiYE/I6sX1c+dlQPTvegS/62M+jndurmtSQf01p+IsMwTbs1kaOw3EH+FJQJXdP2cfcX3vhV1xZmffZkszpXPii4K/CTDSF8M0nZyD0Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=zWtWdYoX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d2b354c72so4135539f8f.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1709630980; x=1710235780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kax6J8q+YyZ2/tOmW0rK7vE9BJFxUzpNAhhYIq1f1zs=;
        b=zWtWdYoXfRpwj0ke9hzl6/a2lvm2sVjYc8k9ugAizoc+iSOB4qKqm5TGL+S2Afk9HC
         LkA+mpoe8QkqvvFYVVP9Ti+KQ6NmFgl6eqhI0cX2f0gkfBsq3BDZKUMzclszqQZw5ftu
         yIvZ2DT2dx7LfRL4eJGNBvLmhBHhgavMEkMq+p0GOmOfXW5rLHf8FLp4jN8tVaJE7bh0
         A4H9057CVuHn6fl/vzGynX3NB9yslHbIANxz+0bphPc8EgN6zn7ko5a+Fti0lHssGeZl
         4CWt9RVLC0yBgHIV8BvhprUgoA60tVJH2+ub2b4it2MDdvFEYoVm19ivX6BHdI6MOz7B
         9Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630980; x=1710235780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kax6J8q+YyZ2/tOmW0rK7vE9BJFxUzpNAhhYIq1f1zs=;
        b=eYm95+oPbMGilEgB7Rp922zUU074cyasfIptpKFlZUdRQv1l+N/fNi+yP9R6fFsiMN
         ifCLD8I7n6eyaW/m1X838tO4QU5d1u1ZZCkN92cddLZqOIP98mpQUChgew7/fCFeduBC
         Syh0J9Hlm/vLGl8wCNQpfBneugle4L4ZP1/sdEGxnjYY41EfJ87JvujbYhW7DkihnbTE
         T6XosT2bMWPyvw0+k8MYnu6cVyP8FbLqZtkDHAid1ESAO8e7CZC7Isd4bzUkQmwtVNqm
         NSZyH23b66ptZi6fSTVQAPbFoCXYyyEF3gwE6WEcAMR5VUMSKbuOBiGvac6yaWgMPN60
         aEtg==
X-Gm-Message-State: AOJu0Yz9y7Xy40o+gmClPX9F6duNXIVqJnHtTqYn6jMtHoWa0yyOWbBz
	mF8vbYuoJmb28e0lDE6bI2xE1PU5h5Nh4278/9xME0vK5PrOj4PJ7A+tOGL1SD6AoOsvnin3l5t
	ym7S68yu89qapxwQbLnRzWL5sjW6O9LsceCqX/w==
X-Google-Smtp-Source: AGHT+IECVfZbaj8vE32BJFSRyojq5sxoYbaE05unjWleIgRKFNOLgHqoAT9uxruPOMGn+ALi7kAOewyVZuDWxdEwu+Q=
X-Received: by 2002:adf:a154:0:b0:33e:47e5:e70b with SMTP id
 r20-20020adfa154000000b0033e47e5e70bmr1011317wrr.3.1709630979563; Tue, 05 Mar
 2024 01:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 5 Mar 2024 18:29:28 +0900
Message-ID: <CAKL4bV5WJ_xZ76KBnOvf6WFAfVtj++4zE=hXRgGyOGD55xgwqg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
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

On Tue, Mar 5, 2024 at 6:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.21-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.21-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Mar  5 17:15:13 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


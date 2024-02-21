Return-Path: <stable+bounces-23182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05885DFB0
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E372860D7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B404CB5B;
	Wed, 21 Feb 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="acd0dMN6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFB7F47B
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525888; cv=none; b=PbIc8yscVrP/OTumKsa9pXSybtol3zU41luDj9r6I1djL81p1NQUB4Y6yXhFz7+K4GVNjEsMsOu4wXmp5ZHA4NI9MzvahtrmEM8Uq/qdpMwobuEhMtTm47tQNrjFJG1GonSHCnUJeLYw5+EtPSQ+7syqiC8Gd7IbDPD4CYQEw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525888; c=relaxed/simple;
	bh=ai0Y3ghr43o6eth14mZfN6FyOqZZgNeqaxFSD2r3C1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXtj20l+5hM0ELDOroOiwtnhtSK0osvj1jhdf6FnfBGZAfMk8jtYhqLyc9nZpXJsaQvk0cOEQu+5GnIeF6f5b6o9EyDkrx2DWm9jJv0KyiFLIwTymJJvCgEvQTciMPcHvRQ70O40Z6dQG4+0RAzsxuXUCRrjXg6d+Q6iP3TqQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=acd0dMN6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5101cd91017so8769468e87.2
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1708525885; x=1709130685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG0WBB4ciOPrXJmNteBsGP2QAaf4Oc9Vg6ruFampq5U=;
        b=acd0dMN6Rq9+83tfG3q4us8gqzw0xaywraGDhNlsHogblG2RxBXDqR7qm3ALFDDTZ8
         od/SWMd+AjtdZywAtVBE8T4gPbSSS0ODwT4Q5RlGz/pv+PASkC+2Ld1xx1b8iKVzqjZT
         6FLUZDmWTVfOXkGmmLBGsf/cW1YhUen2pRa38ixEgt8r3Jw70sDh+Hr1C5F2o0MvE3gr
         WG9CnOVsjCxhi0/6euFxCbi2fBCC8i9kZXTrFgq5L0fXws+zDR3SvM9ajEDHkGoNxIbo
         GGgHKUsIj7W9Pcfn3z+CbKslGqPRxtQMoMmWVzCibecJKAx8i6COQBmM3MfMyPgllMsl
         Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525885; x=1709130685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG0WBB4ciOPrXJmNteBsGP2QAaf4Oc9Vg6ruFampq5U=;
        b=nfSsOFoO8r7EgVf14a0gaKhgKxU8demUeivlb6bwROaseIGAi6rAiuCEYh3no4Gdex
         tcvDM5HC8ldNQzF4jyzVlzbR6PdNIt+uOYpp5rwt0+XTIgO7vwQeLc21hfFZINvZI5Bf
         o7XTXB9+kAxtQop+0S8AV4f2y4RBXlHgL/Vld8cxGA3BSQAIfiI25M9tFFvSrFmUto64
         t4U5GH5695/adT7YXiiwwI5WrgKtrpi6w3wH763F7HgOOz0uIICohLgIVYMZ/wz7B3uu
         tgNj1EfNJKCn78dBcfoYqBFuSlPy7+ovc00ErN06u0Xk3FMq7oLeDoGJc+l9AgTtHQOW
         nM3g==
X-Gm-Message-State: AOJu0Yx4AOCPC59rNqGAP23MfNzvrG1HvYVwgeoENZVJQQemoWrkGfHo
	4dD9RgfqJdN9bO0KSQ+dFcIXnwEVMNeuTEpdZNDlHmMTIwy/rLJ0KSZABf+xPkFMqk/GuhSbugK
	vJFCp/q8DJDx4oMpmfzX4R2S8+BnvaDhnzV6jKA==
X-Google-Smtp-Source: AGHT+IFgyTlvcYZuUnsc3Px/pDWdM8WzXwTcIeRlitvcBj8aH7M0N907h7RZJroGn8CWGEbJElLaPVXUsGJ8sQLr8yk=
X-Received: by 2002:ac2:456b:0:b0:512:a9aa:ab48 with SMTP id
 k11-20020ac2456b000000b00512a9aaab48mr5990070lfm.7.1708525884593; Wed, 21 Feb
 2024 06:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125953.770767246@linuxfoundation.org>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 21 Feb 2024 23:31:13 +0900
Message-ID: <CAKL4bV5Txf=FBfcKbCS5NrBtu9uN5ZLtLBfeMr2R8Uc1wRLEpg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
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

On Wed, Feb 21, 2024 at 10:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.18-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.18-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.18-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Feb 21 23:14:15 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


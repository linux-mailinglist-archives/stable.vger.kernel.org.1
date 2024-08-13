Return-Path: <stable+bounces-67469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164695035E
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D8F1F242EC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502C1990DE;
	Tue, 13 Aug 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="co4dXDH9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A61990D7
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547530; cv=none; b=qIPZVSB5BoxHxDB7PoYELMUIgWtiLkNNx0c7qS6ogap5SP0qXvwc+Tqk3ahM2cT8eYGlswaSTE6uvYU+CocN/Uv+cfQ+pfaYe0e/37IG89+C4IGcnG9tLJp+ZHDQCvmcqVzCSU02rBF0nsGUGFcoxdPOR/JPiq6QhiaozqNEi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547530; c=relaxed/simple;
	bh=sb+XtHUDQtmCMGrfwTt5ykYomI6fe6U6GobYI4zQheA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAj4Dh/fDhT9+rBjiviBKe2XDlkqYrcve0V6cDYTQZAOI5EIaDhX31OJkxzp9Ul9t9LOXqHOr70nk5/fTeqUTDeAbxJjreIMLScAJA9dUoMGJVrKdPKivF9KB05xDURNE3jw9HT6RF6f2HYymgxpAjIhyZMA8cvyVNr5dRvQaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=co4dXDH9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so3584242a12.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1723547527; x=1724152327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXWH3cj6qeEDUbAOW6N1y6hA61YbTTG0cc3E6ZuOHeQ=;
        b=co4dXDH9T5dwUz2ji9Rc0hE9ZkVkuuyb/eCVrcPgFz7NynGIfnbPxaPHzanPxoMjH0
         WTTjOHDytBYI0ZYVVbyaP3DFvrLbT1x/ldr+4Ia5ZujoQIsIfsEo4Ok5Z0tLaDYsARh+
         4/wLnRcnGAP454IvSleShVnDzOhYKsv7DBqArJ9DXppMwwU9xH6qHMzC10LAR6AckSHl
         YY6csT1T2QatrEcEi7agw8XV9BJDE1Se6t+GIE7xKOZICGpbRfuZPmRprnXrTSjYBDHU
         h1eyRZ0HwNcJXnsm6ZvbpPZ/B+56wd8ulQvKkSOOk2RqPJNc66BPf6NUt6SdMYKfyYYk
         5HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723547527; x=1724152327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXWH3cj6qeEDUbAOW6N1y6hA61YbTTG0cc3E6ZuOHeQ=;
        b=l4B6Af9apt1YJnBGGDeyzTJsFZF42wSJC4rhNDpATiJEjFJNCDfuOhKVawrgY7FljF
         DafhLuRVXkd2UJiN/Fa/CK7OeaXQpXklx3kodIoOMyhA5pYtQZc3BY6KBvrsN9GjWFS8
         JB+3F3Y+RNmCBgZQJh+rPvZ/94t0jv1aq66lreioBzDK65cBBvx6VJfWIg7SZmH8R/9e
         p36wACpDZ+xjgS3XB0Mwa/3z9A/dQpE3kyvpMt3sAwfg16LeG5lrT6KN3CvAvKNKu+0H
         J36guE35k4u6/dR5vvcrWcNBWiKmPS6RQKC5QCT0JjBzv7Zv0Qvr3esmhAYkQ1kJqEdB
         hnpg==
X-Gm-Message-State: AOJu0Yw/VS8FZC9Bn8B2tQnAmXwFrnUYHUG7hGjMJYnKmmDKTWsR5z4V
	RUWImk71zmD9DxLKwZykxfC/00/+YTsCxZqLglCM1NtvJovNja3M9HWT57jDViEwD2h7bTZf2oL
	W1PuVE94pttJ1LgpWhPlvjyFIxd4Yx2VUYGvMmQ==
X-Google-Smtp-Source: AGHT+IGuSeHG7m5K/jmSW20RDVS0llLgYzyxC9ou/X+cYTWu/3utdqzZoNS752omYejEHO3eijXxIXiNFbcWZM3Y5l8=
X-Received: by 2002:a17:90a:5c84:b0:2cf:eaec:d756 with SMTP id
 98e67ed59e1d1-2d3925048e2mr3647563a91.12.1723547526952; Tue, 13 Aug 2024
 04:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 13 Aug 2024 20:11:56 +0900
Message-ID: <CAKL4bV6-OVxsOQPQYHetJZ7C7=oxBK5eHnOG-+HhTgDu608zPg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
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

On Tue, Aug 13, 2024 at 1:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.46-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.46-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Aug 13 18:50:55 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


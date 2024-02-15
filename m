Return-Path: <stable+bounces-20266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5985620D
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893951F26460
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6112B151;
	Thu, 15 Feb 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="R3cxt7VX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D47127B73
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997668; cv=none; b=F7AqvQIWu+R2wepP2DlA4yCsWvO5+eVULLHxSDllOSSOsY5bYJHkAO4/pU9FsO/x7QWdzz7ICbbXfJKRC5tguv6QIeLvxtiTnUhN0cOd6AQ/W2cZf4sx/4yzbqfSgwhPavLgS6V9pvPuN5BlZDcDtGn+s+u1hN9qkACrUCf1piU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997668; c=relaxed/simple;
	bh=LN1fd7tD77fB42zqbauIV0Aa4K8khZa+u2KvtOVoSpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1QU6Hb9xC5KC8OnhcfGJVEaIWKQsTkNgcQYh1krRYgQsns/CwqQB2r4RJmr8Hwo3rH2lIxAR7K3WKfpbK61OhWzcmsM3G9rLpVqspuslO2AYhCzjIe33FhxRwj7TDaWWYvwwxyS2KqD5T7r/1N7rA+b2aUFFAXo7zdxBFnbiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=R3cxt7VX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b401fd72bso411629f8f.3
        for <stable@vger.kernel.org>; Thu, 15 Feb 2024 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707997664; x=1708602464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDZkTUXyfxckUhrTkjTJWxTxMlTrhxiy3HMA9uLoreY=;
        b=R3cxt7VXCBQuF4hl4JzL4rf35exxSu35UqPADRG3pSLGH/5NgUP81TpdFw+ABphBUj
         dXU4i3155dzdiCjLzA9wbcTVBB5VUc9FH95diRNnQD8eqKN9JPfb1dZAhxBqQrOKqWvR
         sJosQF+E+5OFzhgd+x0DA4cQUApqHphtfCVuu/gNnzwbPEghDbuo0p8und9Sk8zctlq5
         YhUZkzSbvAAlrcDCNssVbk0zD+ATffYIp9J9s5DRPV5lJ/Ijzw/O71toOD5D78AElUKn
         clHbwP1pq3CsOvWfapTLoid6N9++6d/3ZJG59q9RwO4x84+neSZcQr2Yp3uZuJfs8Y0p
         F/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997664; x=1708602464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDZkTUXyfxckUhrTkjTJWxTxMlTrhxiy3HMA9uLoreY=;
        b=MfgZANDKbQtVEKATRr8XcKqsAiCxSeX+LOWr2v8GQryyBhlcHvbXLSCLv52L6DFDBj
         8U94LSbFH2Q+OSUECs6ZzyQ1fq2qgFq5y+oc9s+tG9c+4yLjJN0erxqF1qolTIQWoE2s
         m2QIORaQFLLuSB4WOd961RN8OwMBClfgK3mISiWho/xMU0DFmxwjga0GUGqAUcBdbemC
         zFPcmyLKMnGMCTokBKYgz6KmqUVhEnceq/S1dVnL/YLrGvRtAWbR0QIJEIpiEmAkOtqf
         K4gNwlQc72p4PWa2oDpSPw5knKiG+zEmLMM0aMUPZ5JQe288in/AsCY0WQyKg3ngQrmf
         qlLw==
X-Gm-Message-State: AOJu0Yypf5FF8X2/WuUKcqHWBnXweCTv7r6uBEr+pBoUVrdTmVtM9FCo
	Jg7tvUFKSAl+bMDy8ZDKgNfU9gXyJZ6OhJqVj4grZPt/fy0II44t0fwewWZwD0IZ7EbC394rE69
	ED2DnSy2QsXl9XCNxZPOBLODYSudStmIxIHA+FA==
X-Google-Smtp-Source: AGHT+IEPa0xe746/mLrXSvxwPwOUcEJ2izyVagCxfrOZJvxe8P6kn5FD8DsuToN4BWhfhL8fRGnF9fn34vnFWVpVl0k=
X-Received: by 2002:a5d:66c2:0:b0:336:76de:c171 with SMTP id
 k2-20020a5d66c2000000b0033676dec171mr1213235wrw.62.1707997663921; Thu, 15 Feb
 2024 03:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142247.920076071@linuxfoundation.org>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 15 Feb 2024 20:47:32 +0900
Message-ID: <CAKL4bV6VJexFZwG4fHjZQ7eqSzUee3+VZH2baxvJqJqSneNj7w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
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

On Wed, Feb 14, 2024 at 11:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.17-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.17-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.17-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Feb 15 19:52:35 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


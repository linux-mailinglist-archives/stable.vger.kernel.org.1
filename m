Return-Path: <stable+bounces-37859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E289D7BB
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F811F25EF0
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E75126F2A;
	Tue,  9 Apr 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="1Jkrsrvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060C85C73
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661579; cv=none; b=fYwVr058aQOVTQ93O8wVf1tdqK1DKfN7fIvs8XI9qYGgCqAbRGzNg7Rvg8fOWJxsIBl8FWGzt7rMQnbokQ7EciuT+J2SynrJt/ouZpE6YfmDMa2gmUyI0we0DbriDGIv1Q/wIjpY7w4jn/+DO7zmHceEBNbW0vrVgmyRFhocV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661579; c=relaxed/simple;
	bh=T2ZN1fcFBKzVjK4bQW41mMKN3tCyZQojwExRN2pmPi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvW++MEwzL/CMWGaYRNg5+E1BbaaXIoiKzstJV79neh/eZJzOL4PURT79fkJjOf95O9h3o/dRuwgPXaTg2a7yi2eAVJqtBAlA5pYUWdKnE7C4BEFMHaAQKJg+4/QjU6fz7Q10sxIHQ7jp9VigZB48+U/gHGIrazDvTyms+wWXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=1Jkrsrvy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecec796323so5074881b3a.3
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712661578; x=1713266378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKGPr03TnWQbKb2+d6UQO6L19uRixEs4WkWvOdztkEU=;
        b=1JkrsrvyWzLEjR63ZG+manb0L/MuP19jWbXhG+MjR5jdSIgcENODtTOBx4WXsFmTtQ
         eJ7GoTgSJRui/mK6g/DR7M3QIvlOckXuCvxLGva/8fgqx2M7AAkbcNRFwZ3AZN/mHaML
         bokNcJXx4OQ61s37TOCKsG3Kk4oXgXR0DhmRCK1z1GmPT7Z0o5bwIGDsE5fr+4EuOo2m
         0G5uRIYqPI4mxHCDS03JQt11ZqLZ5ZcNVGnVHQ5XwflUKD6pujoI1t7DftLrBK6Yb5gh
         PI7Ej20WDKkwPFSdVL5665lI5+hKA/A77FOzGbsnf+LunPvfTFOBvwma5sZBtaskevmv
         Iovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712661578; x=1713266378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKGPr03TnWQbKb2+d6UQO6L19uRixEs4WkWvOdztkEU=;
        b=T5COku2wZuPQ/9fcLi4YOl2P/ninsQkb4FMMDFzEnRIMlp4QmRxsutDr8aHeC+iG4D
         GK05kpdVa9qM/4lvSRuTzz9/f7oee51/urGUMdYxby4drJMmfu9o5vYIXYFy8lMY5C7Z
         PZvOn4M84YyhFEO2icVSH/hdMmSSQwchfbFC/3tq1Rs0p9NncNMon8pTx7fRoa0wKLkQ
         azdjkiaf5syXLJXQk/H5SuLjBTN+EbR12F3n8bH2N35gw1LCZBPuE1et8yz1u7YYFMcr
         FR91/p4xFZsiHvJTu5S6iRgC71f6TOjW2RIo/6JWHNVezsivkuzxWcAytMZq4baSMONh
         Q0mg==
X-Gm-Message-State: AOJu0Yzql8s8BAETV5dgDrJoOK3N6rH2pfJ6D7oGwcTeyCSt7ESpqmwX
	H1y/Ce+rC6fwEmVd+DHHFibdGpwGh0zOLObd8IRKFswdjAJKym/Yjnx0A7/0vMOqApYEzrPWqFX
	EqsbdVpmBCzTTU2xEc36sX3jFlYed09qfO0tkcQaBKjx7aB9xXk8=
X-Google-Smtp-Source: AGHT+IFYVza6STxF9UXGu/0jGiQJfaimoc1s/2/nhDZ7qqm817g4DPhfwqBgbtR8wIeNhe4Qttdd+G+PzX658TMBJUo=
X-Received: by 2002:a05:6a20:da95:b0:1a7:a86a:113a with SMTP id
 iy21-20020a056a20da9500b001a7a86a113amr1813290pzb.6.1712661577550; Tue, 09
 Apr 2024 04:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 9 Apr 2024 20:19:26 +0900
Message-ID: <CAKL4bV6ANTv+DwtQAjQYFW+9d4Ur_yk_xdm_PQ2HQiZW+vbjdg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
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

On Mon, Apr 8, 2024 at 10:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.26-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.26-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr  9 18:54:11 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


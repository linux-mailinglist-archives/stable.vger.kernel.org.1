Return-Path: <stable+bounces-106584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B61A9FEBB8
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832361882F6D
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 23:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9E2746B;
	Mon, 30 Dec 2024 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="DpTxOgk4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456619D06B
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735603081; cv=none; b=AjZyx64pmI0gt8zVvkkGzQ0sTwAJ8/8JtDrwqz1hQ9jlpbQ1LElYCffbOSyO0mS+VJfnSAEko6DUwpUYv02nnRhFD5Ynkc+WSUFGiVne8Waxchgu6EBmg6DsOqmPl7NKP+EpL6owUsx2CUqAyzVsnx5VKY6iKxVelCsPCLS/nT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735603081; c=relaxed/simple;
	bh=mpotLnomCc5336iZTVOejgVk+D0osmwfN/w/GnFevgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtQe6bPBxU+1fnFxqAjXBTEIP7EW7QpUmyl4XopNROPftIa/KPK0WFIelcPwE4LcFhh2LWMKiiP1wHbMXLNmzQ3cHp9B+HoYF2Q7souExc/i4kN9dT+OxjTjiTBVv7uuwq7wveDaiQTPvupBlFOqezilpCblp2meV8lNHcnjxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=DpTxOgk4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so12842721a91.1
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 15:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1735603079; x=1736207879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdySRgIzeWbL4+mbJcrgAY7hTQmkXMfHN4DzlvZotS0=;
        b=DpTxOgk43iGT5gHWfHB7P4z9ZfH4cQdNpMpPxLS0Ka0IHP6UdZ8anhkzTTywEmGvvi
         YX5e5wGxRQe7QdFE+iUbtVNPX7HwCpyRsrjEv0jST+LKFog31AWOsd5gJ5nJqfuWr63g
         86rBNyCROT6N4X/frEwih2lXY3PdwATw1NinbbvkrBBU7MNPNiabqEFY2dQ8ADxXGqew
         X1pYywsSxZlb70qH/UkhpkT8d4NbsuLtvJr2u88OcYGyRGGWziWnJEi59fjXw3F/E/x5
         3dYMpPQPMOATrtGOW3Sp2fZhqIK2Az2stlfmYdJ0VS60cDWlnWITFxKrxEvLvibWXzvR
         LXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735603079; x=1736207879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdySRgIzeWbL4+mbJcrgAY7hTQmkXMfHN4DzlvZotS0=;
        b=QojqzqCMlj5NYSTBQC54m18jZNKgdtfTdUWgNnb4fk+Sm6H7UsmwDC2kVs4HzUSsM1
         Tien2/AJslu18Hj6sobfRhbf9HmvJTH2JwfXYHcxmQm51BtFnjuTAQYhTGkj2rEhtAzn
         UP86vEw52ze/swp75FkbmUXGV3QPCWWXyy4IdfE5iVp/u5OHz1jMqPTrqCfjYgctyPnb
         pu84KMUqkPQ9YEZFA/8f+ECrl9fwoh3yBH3/mNbJeb7p6AHXAzUk4JPeDLM/aGd+uaSH
         FP6Uh4FdWyHpfUEy+2w6heGU+EFlWmUTOQGNhhnn0W2rGBJEPnABGaYwi1xtlabKoBmJ
         Z7Pg==
X-Gm-Message-State: AOJu0YxjeAXyASqfcY9HHwr0+o41G7POAx97J7oAedwUTBCO0cw1vxVs
	F3cHDNcDtP9BAuXppN0swWpU2C1eQ9jQp/xvxoEVnGq19wP6xQcXN2aDz25biMV5m7JNEnod26Z
	t53/2mTgw7eQcuGbmGirH2MDjctMsohGMbjbidw==
X-Gm-Gg: ASbGncvUuusn9JXPlXmzZ7pwAPtOVX928T2OQGf5dpDH+Fwvq3o4Iu2xe2SEQ2CjYbm
	tkanLBrJ/2NGhSZFUtKSelfqUyUf17MV6IMw/
X-Google-Smtp-Source: AGHT+IFobOXNLY9qEKs5y+aGOdne6kS1ZMuYLhusmsD/lmEd2xaP49r5W7HpC0vdELRmimogbgDp5TkxMrlC/qI87t0=
X-Received: by 2002:a17:90a:f950:b0:2ea:5054:6c49 with SMTP id
 98e67ed59e1d1-2f452d258bfmr67525796a91.0.1735603078949; Mon, 30 Dec 2024
 15:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230154218.044787220@linuxfoundation.org>
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 31 Dec 2024 08:57:47 +0900
Message-ID: <CAKL4bV50-=Hf1PSTAHVuz89xnvb6D+WngfDFsNxa-mZBYiqVdA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Dec 31, 2024 at 12:54=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.12.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.8-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Dec 31 08:05:25 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


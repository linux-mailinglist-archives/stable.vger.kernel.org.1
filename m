Return-Path: <stable+bounces-4672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3C805435
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0116D1C20C86
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5C5C069;
	Tue,  5 Dec 2023 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="n/nzRJck"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949A124
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 04:33:18 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2004720a12.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701779598; x=1702384398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEIoNxF1mrTxn6HSnGvsWW6Lj8x4H49yQ7QLKLr4Log=;
        b=n/nzRJckdKzlKLz/Fw+PdIfoF06D1XCEHqNVlNawTXFb75xThQuXafG5lpRRLxMlUG
         TuWlgcqYm/sl52dTrkkVYu0002PF2po1hlmgKo+LC7aDQjXiJ1mq35GJk91ZgFqVJFN/
         zoo5HvPfhZsSzod5irg/qF7GNK343GibjTOFQvSArQ4bvhvghW79sVSl5hgJDLhy2FIx
         mLmJR/uLmaMIg0lENyeGTkulrGqBAJRUJzVgT7Tg4byfFjcWV5C41I0FvhJHqbNWEHn/
         zIHCrJmqZu/gigDy09ZiNFcSidr3iJvfZwrLlMSrr+ouIlHllRmNe9v5CLERO8yoojxU
         GJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779598; x=1702384398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEIoNxF1mrTxn6HSnGvsWW6Lj8x4H49yQ7QLKLr4Log=;
        b=pZb5ipO8YRL+yEXOAzCIE2qRVSrNoWhiudZJnwU+IHvnQ4V03ShwxAgVcR4DUHPEpG
         dcN55I7nGc5phuTMqaIW9lo48TCeN8TiJ9XVLUDzdrPksMzBqF/IrxNtPLNSIeLYcydm
         7A0qMYDRlf4/GAlUpTCfRvVnbsSzQlAKW00IC5rEKGNToALNmqwNOK/FjAs0nnlZz9EP
         AdaMYp/fMHzyeEupUo2kFQxn5SxG+JdPUTznRgXIYJsaB5lZL953cDQYmxVloE1DskTw
         fvUAXTX/ja+NkTUuLyaEJJUTGIDVTBuStKtvLKO2vBKKCaM6yWWkvqUYniKiiGOkaUbj
         0iTA==
X-Gm-Message-State: AOJu0YwtKUTDX59PAJE7TkNpntbZ5VZWpoci2ZuAjRhdmVmzSWm4gn1z
	cujWUI5+/EOS9PoMqnz+/Y80uGZfQeBsHNFkPGOfPA==
X-Google-Smtp-Source: AGHT+IFmxCGot2OM6nlx0JyueWaxvb9J9j2G+CNFzUEiV92bxkdPmAFtiCPtGPO2TgeTJq20Tc7gU4GzYbn/pv7Fc7o=
X-Received: by 2002:a17:90b:3ec5:b0:286:6cc0:62a2 with SMTP id
 rm5-20020a17090b3ec500b002866cc062a2mr1346799pjb.33.1701779598021; Tue, 05
 Dec 2023 04:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 5 Dec 2023 21:33:06 +0900
Message-ID: <CAKL4bV4WEwo8bnVJcvAQEOx4yF5kcDtm_apaX6gwtRHPgM6J1Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
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

On Tue, Dec 5, 2023 at 12:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


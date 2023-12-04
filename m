Return-Path: <stable+bounces-3889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5B8037AB
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8337E1C20AF7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9E28DB9;
	Mon,  4 Dec 2023 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2Sxz9bW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14920B3
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 06:55:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce416a74d5so697968b3a.2
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701701738; x=1702306538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECEVktnNpUXpGoY7MofBhZHrCIiW0FRv5VOwOFl73MQ=;
        b=b2Sxz9bWEEJY8zCgUxbEdvh6UDpN1bV1PqSADF2TRYkt6Mh0A14p3vMtYH2XgsTsKO
         pwYG2LarKkBWh82C1EUxL6cNS9yik6J0pEE66UCmK6rU3rG8B2VN+XZKZ4S3lr5eK6y4
         E8nqX4gch4GwDRmF3KCvl8XHR9/GTwtv0cN6N+9xcLIwDBeZ5lukt4AEHCdbLqDqiYml
         g+ZZTNbEqojb7K7bBKB6t+tyoK4e7miTsM3NOrkURQOs3T9Qg6MP/hRYSUhlKyKeNlk7
         p5wvzxqOIdmMTXli4SuZIpfdhkGKtxU0q2Fe1KIsObUbkbnhvllfNT410rtIzms/U70M
         jXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701738; x=1702306538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECEVktnNpUXpGoY7MofBhZHrCIiW0FRv5VOwOFl73MQ=;
        b=NFyLtUKhgy8lq6F9rhNGrzw3yApaHg7VBNIpqmlrqDvxGEDmn9lvkV4DJDofQJHU9D
         D2ZaB9XbgJf774TzghZdpbROiOCEwI2Bu+yCD2mrrbOrl1Fyze0WQHc+I/vz5LunUeLy
         OK8jAjnxi5qxVT73DXOqX1Lmm/FWneF4GSGs/UM95VPH2xOJ1Z5bGsM3+hvamA3umLIp
         l9LH4BKBHdpYuZ3MT8+LURN60jQn4YYlN7WY2GvjjJ92UwH3kpuwtfPKs4boX6R5KUMR
         K+oPLSWxjdloCEsp64/1BO4gtZv++CAQNTM7QlEawcimbf6bob1tLwBo9Nik0CA9Oq/A
         u1AA==
X-Gm-Message-State: AOJu0YwpelbzAgB60qO8Hh1T7RIljokeixHaZhGQGfs+0QIsNFJKXEph
	B1YD12g9qlm/CT2QkVCjEnAJueufkwJofhBzG0/Fjg==
X-Google-Smtp-Source: AGHT+IE61hyEtN0sXTa9zACdyfMXQB5XPSbT1eqxKDZKJptlwkTbAzQaMLBoHLqfOCG77V6pdVueQ5n8yk1VPt4SbZE=
X-Received: by 2002:a05:6a00:2e21:b0:6cb:d24b:878d with SMTP id
 fc33-20020a056a002e2100b006cbd24b878dmr2212551pfb.2.1701701738519; Mon, 04
 Dec 2023 06:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130162133.035359406@linuxfoundation.org> <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh> <4879383.31r3eYUQgx@pwmachine>
 <2023120155-mascot-scope-7bc6@gregkh> <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
 <2023120223-diagnosis-niece-3932@gregkh>
In-Reply-To: <2023120223-diagnosis-niece-3932@gregkh>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 4 Dec 2023 08:55:27 -0600
Message-ID: <CAEUSe78X7_bwDiHwxS1u0TNTyuqDifoa36yjh=BgcByPp1i86w@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francis Laniel <flaniel@linux.microsoft.com>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, 1 Dec 2023 at 17:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Dec 01, 2023 at 08:34:26AM -0600, Daniel D=C3=ADaz wrote:
[...]
> > It failed in more architectures than we initially reported. FWIW, this =
error can be easily reproduced this way:
> >
> >   tuxmake --runtime podman --target-arch arm     --toolchain gcc-8  --k=
config imx_v4_v5_defconfig
>
> Fails for me:
>
> $ ~/.local/bin/tuxmake  --runtime podman --target-arch arm     --toolchai=
n gcc-8  --kconfig imx_v4_v5_defconfig
> Traceback (most recent call last):
>   File "/home/gregkh/.local/bin/tuxmake", line 8, in <module>
>     sys.exit(main())
>              ^^^^^^
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/cli.py", line 170, in main
>     build.run()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/build.py", line 652, in run
>     self.prepare()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/build.py", line 318, in prepare
>     self.runtime.prepare()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 423, in prepare
>     self.prepare_image()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 443, in prepare_image
>     do_pull()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/utils.py", line 36, in retry_wrapper
>     ret =3D func(*args, **kwargs)
>           ^^^^^^^^^^^^^^^^^^^^^
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 441, in do_pull
>     subprocess.check_call(pull)
>   File "/usr/lib/python3.11/subprocess.py", line 408, in check_call
>     retcode =3D call(*popenargs, **kwargs)
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/subprocess.py", line 389, in call
>     with Popen(*popenargs, **kwargs) as p:
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/subprocess.py", line 1026, in __init__
>     self._execute_child(args, executable, preexec_fn, close_fds,
>   File "/usr/lib/python3.11/subprocess.py", line 1950, in _execute_child
>     raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'podman'
>
> Are you sure that's the right command line to use?  :)

Yes, it just needs `podman' to be installed. The Tuxmake team will
change that cryptic message into something easier to parse.

FWIW, `--runtime docker` also works (if Docker is installed), and
`--runtime null` simply makes Tuxmake rely on the cross-compilers you
have installed.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org


Return-Path: <stable+bounces-196571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA805C7BF3F
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 00:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE00436709E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997D21B9FD;
	Fri, 21 Nov 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="NNax7mZx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4E27CCF0
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768453; cv=none; b=QOrJcb+QtXFV3GD1ahNF2FHSZ2C/9vv8OxxHkwk+JsVPkdumGpR4fojDI0+qfI2qTVQKLjAMeyvXVWyJrdOUOJ1p+DlD5m+frVDR2hNNwy88FEkn4t7voiyyadpU6v3xvR+Do8BdC+OU+2Cglg7JVgBwtSS8/JsIgjxD7J20Fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768453; c=relaxed/simple;
	bh=3qKLYC0y3/7eM1Ro2EkyDit0kfLQH7qiYWQQLEn79jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaSmwUGbr6Wrl8sNy16VML/ZuqIi8v6EXnNKNfEm4YENciCuVzROmUDHVgAhqorkvj0f0/Y0kKmWlhP+5VrPkeEm1eJTUwj6Ppc+4TZZ+J9dCcX23m6noTmk0/PrybNRx3nPv8FFSXgcMe6R5bgWNRDx/EeuZdzfv4xGtCK0sSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=NNax7mZx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e982506fso34139485ad.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1763768451; x=1764373251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeX++7UhHM3U5MYi5MXg2Yp5C2j3UwwuMQxs7wJVylA=;
        b=NNax7mZxsLSPIkolJqrpXw9tdgbNO7o9aM++wGKhncWckIUXx8GonnGAMXq+e7KcqN
         kwv39XQSBpSAalSXXsoLUH7Z+4lky7tR9d0E9B1w+REXYGvkcJvL38ktwwqUpretjRld
         FWggHUOfGLZ3Zr4GmDOAz9DLXzh6JwIToDyeJZ1wvQMfWrm6UZVcWSRDTrgVNI7KIIM8
         uDGeKDta5CwwiqS7PTEOx0gDTFnAbkENbd2Sx9nyxPuZ3sxg5AL2s+dDLhYEOr7HTKD1
         keSQJdcPfGwWwpcFm8nRD4smVbkkDkiKQ6Dj8+Ud3Eq8Oa3sEfG4PnuAAloQA2tnk7b+
         UvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763768451; x=1764373251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aeX++7UhHM3U5MYi5MXg2Yp5C2j3UwwuMQxs7wJVylA=;
        b=sYH61iQUJl1HtaGjnOCpKm71tRgBh0FOjeD2/pp223CqNY0RXD0/aierRoE9EIbZbE
         lTY9j5CzOtJcAoDsOF8cundyoGuRujgjTZnbXwoHX8z6IxXcWcaF2qM+7+grx9fZLNt1
         Dw+fQIcrLcgO/PaGLFkU04n4AbrCoow8Bs7Hssfiu5Aqz6J1SV6/5AjToIM7iTUZeD8i
         2zZEPpRDsFoczamDEbEUMmU/TeAy8Jf344JtXYqChSPeNUqI8OZTWO9krQDgNVf3L5mO
         bAMNYjYaOJO3cU5vbGUd0LevXYF6LKIjQzlDKoka1K5awzzImQC6fvvIidKP7D69Xf18
         A+Cw==
X-Gm-Message-State: AOJu0YzCbl67YhFsUTUkhJlVeKkrid8cSzoSo+h8iZAhKujSCLbBNOgj
	JwBlcOWy6+py+6gh+iM51uNXXz3ljuqI6uRoalWQd4QvCORa1NJJ7zqHEkc5dKbEtHIFuSFzQwb
	kTKOWzxzeEdVpVFUmV/+1d2Fx0DSSs5W3NsHOiJUiug==
X-Gm-Gg: ASbGncv90/yFPDCloz7M6CihL4zwRW70Ctoyculskde76lHYvQ+uY1rB13N1EiJzHd/
	8DBgKwAArDEAlDpIihb38R1f0wzEWkQejz4vuJRUpSrl7ibZkFMAJJTp6xf6UlcKSy6u4izQqJD
	32B6RBPjrzVSShP5QyDqSK2ToohyuUAC6/sUx5VObyTpFUM+a7M1UhFfRTQPS9PL64pvGcj0ZsR
	my96aQn52lcimZZ4F0Dei6he0QI+CJYcWDph7wwIOVBb+oSgW3cX/739bHQItC42VgiV9yYNQ==
X-Google-Smtp-Source: AGHT+IEvjILi8jPgmj67eLHNTGh2Gf5jq2eQOxSNUsNue7zggTnn0E3XTOioFvOBB0AM1Qz9f6QfZ67h3rcAhVUSWmE=
X-Received: by 2002:a05:7022:504:b0:119:e56c:189c with SMTP id
 a92af1059eb24-11c9d60e728mr1789175c88.4.1763768451161; Fri, 21 Nov 2025
 15:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160640.254872094@linuxfoundation.org>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 22 Nov 2025 08:40:35 +0900
X-Gm-Features: AWmQ_bn36b82vaOzTxXjSggsbwhgXP5TiPk3YE4ScibLRlbPoKTv2WS9EFlfEL8
Message-ID: <CAKL4bV6qcgNCMMoAb8gWWQnUUUg8mH2OJVnh2+hNahnjQKeDCw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Nov 22, 2025 at 1:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.9-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.9-rc2rv-gddfe918dc24b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Sat Nov 22 07:50:12 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


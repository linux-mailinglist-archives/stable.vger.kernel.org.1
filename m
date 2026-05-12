Return-Path: <stable+bounces-246698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNurNOSvA2pG9AEAu9opvQ
	(envelope-from <stable+bounces-246698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:55:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6652B23F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6571D3037F4A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F939A04B;
	Tue, 12 May 2026 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="LtkGq4D0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143F3EDE76
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626530; cv=pass; b=QyyXGlU/FytuIAUAo5NTRJ4qZsYzUV/6wr98BhrZiU60zXB7cAgQ3x6TgCEHt+dS+z4gp+CrYpuhwFVX2V8etzJ4piq6UUyOL4pgjzzI0PANW+eRaHI0b0em5l4Qdc4xclE6awJe1UfpQz7DM1KUhjM9hWyN//9w8XR4Q3Hcz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626530; c=relaxed/simple;
	bh=S/8xYr2qBUJROI9hkbGruR/a0izB/rCJKi4uVl1GFdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFQFpq9MMAjrIQmHxxdkGzQBYWRGGjpo9n+DqIc3S5kfnBQVCMef+ygBmVK4dY85KmVwUohPVKHZPWqg1EiSMLssNGrP6jCzgDXfIFVUriYgozmo4GyGz+Gx1sMlrlfL3dvZzDURbSIAZjtkZStcsej7xLMJ7VruAE9bWL6k51o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=LtkGq4D0; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c8f9846c8so9041118c88.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 15:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778626528; cv=none;
        d=google.com; s=arc-20240605;
        b=Ar5cBCVUrKDXL/6HoEE/DZPK0Papo0rDGrxFA7GairtcJYzI0i7ATksDV0LbS1hC1H
         EVCeyrWd7pn+T44sASHbV70vjoCiDwUFUTQxmzNtvcfV4JEcn0oixFXRl38jcWUGFhpj
         ERNNVEqYhQxgL7NcChUAVphnYeot23FVH6GxNeA0iQ3C/RpbpcDJ1q9f8b4KlEfh4pRo
         WZmuXkrvPXLusOZbFGWiXbU45ADppYI2O2asJiHo1FHFoXlmXRWWuNQyIjEhza4eKuer
         CrlHwu0+rkiYXDMoEG/PKA2UVgVL5WUD+VCbtFDBdMkG8QeBPfvEknfXN0ht88vPqK0K
         svMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=osP2QW83srUvnh83MA3e0QzljFt7mZWU8/KmTxKofhA=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=DxojaIkHmtjpupFrmSZ96sI0oQAHxfqIev9ibi/73aCS9zZDvGAmwBFU02u3QJ93nJ
         1anugFZSpU1zXLmDXYRVTSlqDfH0tKKxX1PIsw7VJ4ETqBFbDQVjcPjpEQXE6khc3j8H
         wHpfH5IpqUDDT7Nz0nGxMFpwYSYkM5kWchptxPYnrVwutDytaqEO2xGQKU8JJj1yIFbI
         abBynfkX+l8yVAxoq7ZRAp4p/Yuy1kDwbzKmE1U5/AVk1iwsHjpsmCHXGQ/ptgDBNsc/
         a9qDrwfLYGkRCtpwYWUo6CS5bvlaUjRyJa91KeCSDeRyPeeZq6byKQbSdiAFtd8fb5ac
         eFbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1778626528; x=1779231328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osP2QW83srUvnh83MA3e0QzljFt7mZWU8/KmTxKofhA=;
        b=LtkGq4D0fpYy778r/h2UI25PEmUTjH8135uK52NczJyrk+far1zkoQz5J4KKr4nhGJ
         A/fIEVrc5e34Z8GKIp1gWqcYkYiptWSocwaUxgRksPkbKFGKOQydSlwCvV87tWqfS5rX
         gl0b1HomssgxEi8mE1aWUa0ssTfzM67jdWw/1+LNAmAbe5p20Dsm8SNijdqO7rQRqp6A
         YC/7ICNP5fQNLSnGWUzG7FCIIw3iMw2Bv3K4FaRF9AWhIKxNLtpkC1MP6kfwHXA5LUmU
         KkuoAdp5i7ajvrrSvtG8cXYZ2NWnheRQGnZ38l+FRX3/Aw4xyV/4/Gl4iGjdPGET+mDs
         1DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778626528; x=1779231328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osP2QW83srUvnh83MA3e0QzljFt7mZWU8/KmTxKofhA=;
        b=b38IqNMqCJwfs8j6rshffx8gkpDxWMOmeiXUQQN5UYYPl0QEOfHtEOQMbmvNFen9PX
         hy2X+iRaQ7uyrp+Dj+90Sr//Or9D/QXKISwxxFf5xc7JNXnLLCujO/B9oasOlILlmfwm
         SbidzyCB/4kjTBp9t56E2SFM40+LB6vmHGLFU+QpDCYY7DdBNvPfF2WIiFQXq6WAFR7h
         gxGq/pCFg6lQfpk8YXe63O8b0Vuve4OHKz9mkiCN90S8/cRVH/P1TPKb/PhgXe/TeTtl
         +G35xegt8Jpb+ml+ead0N17RFCIy7DWjSxulgSMwyqVMvwNCkWMPMWrmOaSaxyZWLBtg
         tx2A==
X-Gm-Message-State: AOJu0YwCx4rK1XMCfwV31nho2Zdpbw1IT8zdSKXyWWZhlY9zkjcvFxYY
	gmGfId2xALDK0QetHz9C7MKp5FnFcpN373oeIkvK0CCL5CVuc89rVgwyQq4Un+H+XnGFslSfMmj
	cQbcKEXVy30nK8SHHr5MHXGA60/x609QJVmzBbJmlpA==
X-Gm-Gg: Acq92OHyke6AVbcqdHaBC1V6PLUbV/W4mZvJwhv/7ZbagcSzxYGdvOomBowhaET9LdB
	uYbZNpnFyAs7lx84ogWP7KlxFYLr8QP3cnvl60NflHHCTmK5zNa4h+HUOBMAIIuWXXkUWgg4t+8
	F2DvclHsrqsk9cx5X1/dO2648CFV8HHIv7vGy0vSTbKSSJ67D5glz0UaHaHg9drn5HI2OPST9YK
	Cwh8OExi5CxHvkZ6AipLP7zmtRfYsZxRoYuO3qtfcazvO3Lq794qXuKPMek5ZFkXC1Lrfn/IQ5y
	DCaW8i2KK726yjp92F4=
X-Received: by 2002:a05:7022:23a3:b0:130:5c90:5a22 with SMTP id
 a92af1059eb24-13439c5c5c2mr479359c88.42.1778626528035; Tue, 12 May 2026
 15:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512173940.117428952@linuxfoundation.org>
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 13 May 2026 07:55:12 +0900
X-Gm-Features: AVHnY4K2KcmH6SMv5nbszxWAJHYCYUuAZUZ1H_5ZyjBhf2SFJveWBXhRVOgr0Es
Message-ID: <CAKL4bV74cBU8twT=QGDUStrYsgu1eDy-s1+D5RJZH2ka+VqGwQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/307] 7.0.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 68A6652B23F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246698-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

Hi Greg

On Wed, May 13, 2026 at 3:15=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 May 2026 17:38:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.7-rc1 tested.

Build error.

Error log (some output is in the native language (Japanese))

  CC      kernel/sched/build_policy.o
In file included from kernel/sched/build_policy.c:62:
kernel/sched/ext.c: =E9=96=A2=E6=95=B0 =E2=80=98bypass_lb_cpu=E2=80=99 =E5=
=86=85:
kernel/sched/ext.c:4019:35: error: =E2=80=98donor_rq=E2=80=99 undeclared (f=
irst use in
this function); did you mean =E2=80=98donee_rq=E2=80=99?
 4019 |                 if (task_rq(p) !=3D donor_rq)
      |                                   ^~~~~~~~
      |                                   donee_rq
kernel/sched/ext.c:4019:35: note: =E6=9C=AA=E5=AE=A3=E8=A8=80=E3=81=AE=E8=
=AD=98=E5=88=A5=E5=AD=90=E3=81=AF=E5=87=BA=E7=8F=BE=E3=81=97=E3=81=9F=E5=90=
=84=E9=96=A2=E6=95=B0=E5=86=85=E3=81=A7=E4=B8=80=E5=9B=9E=E3=81=AE=E3=81=BF=
=E5=A0=B1=E5=91=8A=E3=81=95=E3=82=8C=E3=81=BE=E3=81=99
make[4]: *** [scripts/Makefile.build:289: kernel/sched/build_policy.o] =E3=
=82=A8=E3=83=A9=E3=83=BC 1
make[3]: *** [scripts/Makefile.build:548: kernel/sched] =E3=82=A8=E3=83=A9=
=E3=83=BC 2
make[2]: *** [scripts/Makefile.build:548: kernel] =E3=82=A8=E3=83=A9=E3=83=
=BC 2
make[1]: *** [/home/takeshi/kernelbuild/linux-stable-rc/Makefile:2108: .] =
=E3=82=A8=E3=83=A9=E3=83=BC 2
make: *** [Makefile:248: __sub-make] =E3=82=A8=E3=83=A9=E3=83=BC 2

Following the error log, I corrected line 4019 and tried building
again, and this time the build was successful.
We successfully booted and tested the modified kernel.

Due to time constraints, I omitted the investigation using git bisect,
but the suspected commits are presumed to be the following.
eb5b997dadc51746b5db031be1e9e7c19646c317

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


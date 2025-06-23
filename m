Return-Path: <stable+bounces-156168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6FAE4E3F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA193B8994
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F62D5431;
	Mon, 23 Jun 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hr6g/a/6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E71AF0C8
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711341; cv=none; b=TUYNATW8DMXbDCOqtRzuDhOUQRAjAMapk9pnxeMOelsh7thi0Y//PHYbqmwzjR42qPXsd7VTZ0fkGm1OEDe/SQRP8W3U7BVm6VGr/nXHVEeHy8g04jU1UyRvApYv4w8GQotBNbsft6oH4KDu15TRIW8KOXyFbZ7Qp18BUGgXKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711341; c=relaxed/simple;
	bh=Wmo/ZDyQ4ImKtrJP3QIyntQ5jCXk1PtVU098o5eDPqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyhRWiTnjw+7Z3fvZuyoUHRfY3z/ZViDFcy/BUZUUGrasuiW4ZdMgzl+jMpZBGJK4CqcrfgEg/Bm/sx+vjsyhPpSNRS2OJPlvuWM0xSIZeBpFGXb5FYEtak4hunuQ57E+5ioPAwHHQXHepGe9xg+PGD+vq3vHWvk669wlIIqdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hr6g/a/6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234bfe37cccso60375735ad.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750711339; x=1751316139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1GMvmqx8uhrSae96cG9GRQgWxsC+nfXg2Ck3Wi+fO4=;
        b=hr6g/a/6Hz5cKvTnaYKuQvhItXW4utN6cIrjBV0s6IgKbXaxMfvRdPg9amqKsSuDnR
         E56gA8qO9Obvda04CZRtRVAAzkwFm83y08SsyjNPlkS9BGKeguDakYhs0r4+uXhRh/Fo
         63XUiCWBc7F3vrrvh59QMa2YJ5wYzqtgy375TelOD0An5kTv4T+Rl22JZWZnmnAnDwbX
         rsaIWVk5ZzvSJC9rYkxd1WaSBhJj1iUcF3OvdG9JcklKyst1Aq+fufSL6dyZoP43lqCK
         290h570Hkcj7RIBsEgwegyJRj8EC6OWAD401tlal4amSwKOe63JQ7UrHrwjMbUVnF21D
         3vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711339; x=1751316139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1GMvmqx8uhrSae96cG9GRQgWxsC+nfXg2Ck3Wi+fO4=;
        b=ZEyPVvuz2dIH6XLt0FnbXVOYjv6m/U3H8E6dtqsuTLCVRKgCKuXGPnktNNQQTMdvst
         EquTL4aOHfNbBjzfPQ83HGKrbQOtj9o1LuIss6V5kPDZznErBO94pRGOb4VpxqRnbYJJ
         E3vQkR2iV1q2cp31CJTFWXpIiKpigPzIWEnEO/KSxgwy7oT+NoMnVTJ1LQn9z7vI/yGZ
         FmSJvHSOyj4GWLlCbV6xc8zuni+PHZ6Ac7x6UwdPU7dWq8kEWTLhp9PRDvG2qnAa3wci
         05COmYOiUEeoFseJHEAL9TIs09hLyCp2xIhaxWZp9+O7USg7qn2M974LNkMY60t5rRwt
         2L2A==
X-Gm-Message-State: AOJu0Ywmo+QUMuPwogIHSuVq+FmMUDlT6rYNLllkTSToQ+q2NeVqIbiA
	p9RARyRDE6GJlO7jWzh0Bt8a3yT3lMa/V51mfLC7i9MR0TfUNEZF49vlU0HF7/PwyRzzmxWD91m
	YdUT++AkiQqmQb8DicvN0WjuLcJq1EXyIozFS1v2DXQ==
X-Gm-Gg: ASbGnct8cXRfIQyh9r4eNYVswMXJpkY/iWpuUYM6pcu7MQVmvMFQnAXQLLNytqVQFC2
	n663FPa1ufSvDZHnKbbaTFMJSgmtbYzqR803OUDljIBzUNaXMy/qcFeVEtoGA5J5XRrh+hpK7Vi
	u3WPjk5Th/gaA3wpCQVnT6NlsjCp3tQtFETt3Uv3OJI9eTTMrDUq5HeNffGap/wf+apNkrIHTh9
	i4W
X-Google-Smtp-Source: AGHT+IFldOr82kECNHRGpbqAwkSHs/i+CSLaKvpxnRfW9bQfBnUjG7vDZLwfLs8m8yr8Dg3Wptvso52CY6mHfjG5K6E=
X-Received: by 2002:a17:90b:3bc5:b0:312:25dd:1c86 with SMTP id
 98e67ed59e1d1-3159d8cf587mr24603693a91.18.1750711338873; Mon, 23 Jun 2025
 13:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130632.993849527@linuxfoundation.org>
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 02:12:05 +0530
X-Gm-Features: Ac12FXxCahOKxqInrOQt0BqXjl0ygzYTl3HNC4qxXj17qIpUny0WkUR4sQ_jwKU
Message-ID: <CA+G9fYuU5uSG1MKdYPoaC6O=-w5z6BtLtwd=+QBzrtZ1uQ8VXg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 18:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.186 release.
> There are 411 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.186-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 allyesconfig builds with gcc-12 and clang failed on
the Linux stable-rc 5.15.186-rc1.

Regressions found on arm64
* arm64, build
  - gcc-12-allyesconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 5.15.186-rc1 arm64
drivers/scsi/qedf/qedf_main.c:702:9: error: positional initialization
of field in 'struct' declared with 'designated_init' attribute

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
drivers/scsi/qedf/qedf_main.c:702:9: error: positional initialization
of field in 'struct' declared with 'designated_init' attribute
[-Werror=designated-init]
  702 |         {
      |         ^
drivers/scsi/qedf/qedf_main.c:702:9: note: (near initialization for
'qedf_cb_ops')
cc1: all warnings being treated as errors

## Source
* Kernel version: 5.15.186-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: cab9785699236a7505c3f740e006a05ae70f47b0
* Git describe: v5.15.185-412-gcab978569923
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.15.y/v5.15.185-412-gcab978569923/
* Architectures: arm64
* Toolchains: gcc-12
* Kconfigs: allyesconfig

## Build arm64
* Build log: https://qa-reports.linaro.org/api/testruns/28835767/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.15.y/v5.15.185-412-gcab978569923/build/gcc-12-allyesconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYENOCa5bRAG0bKRLJc7p69cI/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYENOCa5bRAG0bKRLJc7p69cI/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig allyesconfig


--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <stable+bounces-114355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8EA2D25D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6080016B684
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6CEBE;
	Sat,  8 Feb 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="tNFwbnFM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D187483
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975602; cv=none; b=fKQT0xuAVHs/KutjPAGD1qlNGb7HSY9nJvrlgG//QzZJiI0B7bF8XZaQUfJSGVnVHB8iaNt0tc3V8x0tkCvuHIRn+8n1wA1+LhwkW6jOTK22J3mpzbOdyrIWiiWL5YBwnF512V4NlJ957dFkn1suaR/+AnTTevrxI7VtezyLMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975602; c=relaxed/simple;
	bh=U/iM/vgIBzMXSjVgFVisrL8eEI/4m5uzt1ogA3r6Dv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd9w/1bMaDGH1VjphMNVxhmldPheuKCJFuPOSfPoQDNQK44vTn3W7nlDwW66RwSqZBpcxi+8snCybOVlFcItV6RZX3RbzWQF5j0ljX9jLucekRHMDS0oUQcxe1KZ93I3Pkh7qMKV7DjSgxURw8txLcGrWBslQ8MVAczrAYePIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=tNFwbnFM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa48404207so179867a91.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 16:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1738975600; x=1739580400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFPCDRWfiwY548OE9KMzZcnx5u4rg+rWVCQ/qhPvDMI=;
        b=tNFwbnFMzZ5SXTUUx111kpRtDMm8uL8xgbCB/AXrbNrlaYmYAAk+64Hd1xnxgGBYeq
         CK309McJHwXQUc7Q3LVXlHlyej9scEDIWxZgmJbu6KhJmBV9T97SCeloPNZvFQ5VxVGa
         LBueyJu7czD3My/RnabQ4zJIXeZ9WcDG1r/rJroiIawSnvpfC2IS99Wwed17FKfal+NT
         P56MmYdJzOTfa7l7d8mY9QaOqm6uugoQ8rWdqOQEqEkL1EbSxN9b57oBU7UnqE7fM6ij
         gBfnrWxDCf/jUmdex178rzXLBc5PcaLABKQMJzgL/+XTXo1pAsMwh/SyAVju2CXfRh0v
         4SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738975600; x=1739580400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFPCDRWfiwY548OE9KMzZcnx5u4rg+rWVCQ/qhPvDMI=;
        b=bWAxYUrlucVYP65KrDvusCUNX7hKod5TUtEDXW+v6rGGo1GabyKCXbI8g6NBafDIHH
         sqoZxTkNTVOokeuJLvWDvsCP43y2hA920wlLU+wg3rJIxS5vA70aNqGCEmsUo3fys6ly
         R6251X9k4qX11KmQMZNDy2btV9+Gc7WV6RAVUKz0GK7uWYwHdP593xaHls4tRsnjF8rp
         52zcALrBNw1QLHthr3bATcUhiqvm5AWF5C38/eZT4we34JagtwbM7PiiSnQDGDKNPBny
         qGXwI5gId+V0Jf+V/5qO3mWlhHt6EHNkm7GyMWogL7l4keJs62EHtBZJLAi0O0m/urgO
         ua5Q==
X-Gm-Message-State: AOJu0Yw+Q9Y8eiW0X+1XcFqVAqPGb6aPC3rNOlzD9ptTIwmh7pB212TS
	2z9mZ8jhvwvV4ulEc6GfhrAyshxJnI5gPDvt/FTP/EHCmdptPoGCnxXKIvmHAspXt3yyobZURwA
	DQogntWQCR0nUOdg18zWWp4Imi8XLFE3opBnpvA==
X-Gm-Gg: ASbGncsTc3pzUuDqUU8dYpO3/+BCxn1b4SFry0v9Zcsh53X3PpvnPz35TEOZkqstedG
	ylxnMkmmkwiVfsY6vWYC8o2WFD8iTypSG65Arl+OJfvMnyzXt+X2ozfNTL2OvZkdRLazyiQ==
X-Google-Smtp-Source: AGHT+IHyBjiDGf7wVgGsBkQDcCSh2TnPY3jPly9PKqaRjONHXxOEA+eane4+FYFN84Y/5Lfu3fPhuquGmIGMz0S+vWE=
X-Received: by 2002:a17:90b:3c81:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2fa240641ddmr7792502a91.11.1738975600350; Fri, 07 Feb 2025
 16:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206160718.019272260@linuxfoundation.org>
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 8 Feb 2025 09:46:29 +0900
X-Gm-Features: AWEUYZm2SmSRtoIkVsU74yZBb6bTd0d29OHynz4X7U95eHdh1KsMA5_M1BW02hM
Message-ID: <CAKL4bV7a5r0JL-RixXNyDmywvfyPWrsyL0QuNudxzfBcqOo7Tg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
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

On Fri, Feb 7, 2025 at 1:11=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 619 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Feb 2025 16:05:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.2-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.2-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250128, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Sat Feb  8 09:14:31 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


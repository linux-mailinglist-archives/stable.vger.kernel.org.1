Return-Path: <stable+bounces-199925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82BCA199D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D4913018F74
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5282C0F91;
	Wed,  3 Dec 2025 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="eUw4BE6d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC92C0283
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795404; cv=none; b=NF/wSHWqvLdILSDtpfpUolDAbOrgzqb+ai5PzCgynR6v2/ThrjuXJ9Zh9jJqJt/abjte362BRQS68D+0tXxlWtGFANXCVTvBZOsyi0teYgJDmkeqztfG7AodarwIiKjftNRL9bC7gpZYGP10AThNCp90Y/Ow8gdwZHq5T9+KDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795404; c=relaxed/simple;
	bh=0ONdcZVg8PdvJ/9rHYnr4KEKWh5qQSXQC7u5JITcI8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnNFmXrP30FvmGXi15TfZlzUVcOIi0OGPNXH8j0xAXhwXqitzDXpPkwERvxSvvYRSveXXpSOvIS0pcm11ctr7OVd6r4HeKAzkapcnk3RCWTSBg/XeTYnPFCDoPN0NeXas1iu2XJz/5IAGPnPst3XGazOnT3m42GHxIfTejIYtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=eUw4BE6d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-299d40b0845so3512895ad.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1764795402; x=1765400202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSm2OrFTk9JAzRimfII6T2rfsk8cHMG3JDmsWZ/gbRg=;
        b=eUw4BE6dwRXe/U3Bqd00hkte61SIgy7LrQQL4P3LOfk2L//CD7CVtt5OBRBcK7tTHC
         N9BsyxiF62sFE3RUeh3nQsOS7fNfwVXIk/zUzouD4bzMrF0SLPkaHdzr8/O0U/scS4nh
         o+rClxOLg2adPjxdFKwV1Ut9HTIPNLyGIh+JFir+z/vVACQmrorsEEbpOP0PFCf+NvsN
         EO5dZDNSEJbwBxxWfZYm+f6uiibWdIE131y3MmmbPjpLVYf+z35ISpm+VLNXF0Rc9BJe
         gUda1LmjIE6FVXw2Zpha1NiPr1lJQclw8s8bKzbBVQSEn3SKQcW4BFKaxYhmRHSQWdnX
         kaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764795402; x=1765400202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSm2OrFTk9JAzRimfII6T2rfsk8cHMG3JDmsWZ/gbRg=;
        b=ShM7PL7xxTplq1FSN+eQ2bD5lCZei+m7Ix3ZHmJ5GJRtg2p8VgmKEB4TiC4yCFMF9E
         uGTy5npe6OiSAcfvdYGTSOSzmCWvBllD6569hZKOmkl3fia4MYPT1OYqP5EzCSJrv7a2
         EKx5zGymMCgcbWcIUfvmwo+CzHL8xN704of7DtSHdTQVqrZhsEn7N2QEbiDKvKp3zSBC
         b2Uy1O7Xu0xVnxZnd31zFbOCAtAGBX0+BCYkxVk8uAji6r7uZGs1qEakIddY4honBdoN
         vC63nblzTySFClGFv0uICFeU86zaFIdS2207fRk2QzpRH4RF5ROnYyNulH5P0IJNjHRT
         ChFw==
X-Gm-Message-State: AOJu0Yz8wea5dEJTnsnFp6nQTKH2EnJJiuENkYT5/wxQox/j0ao8ETBi
	QjHkNxbjtIaYGLpnDR9jY/DL8yMH7niv5q4MbsLv03MIxO6Z1yhzGU9EXDEoF5DdHuFy5pv0ctN
	0S6rZs5wSn2U9/nrN5WvLvMo3F1iPiZBB+PJ4JpGzNg==
X-Gm-Gg: ASbGncufVvUzFP1baxHHMkR6CCmEAnU3lOBCjQeS+3teA8Kt7G8uaICwKgSbj5k1xIg
	xTGrS3ddYQ3SNmbWocTHz/xqXhHC7YGiRke5w28tfp+BxxNJ59iHSUUb7pB5XHmNiqBVTyfSk4Y
	x/4GcFSZAITCl3c+zS//Y18B+ZKFnhUPWjdSlna0MV4wHksr6Vv2Z7FBM3Mk7UeqhI2MCbCViGv
	NmTmgAe6H247Xw/Rmg4RZi1Mt6B9gyuK4ya4CLR/tsBUKMjEoW9IoAzJJSxB46IL+mGqaDzyQ==
X-Google-Smtp-Source: AGHT+IE5YvU9BXC4pEDCKyQ8pvGMRGvjOddkTOL8aNzisJC7QAW6R7gSA7nVMwOaBNdF+Qn3PNm5V0gjPnWDN1UbZ4I=
X-Received: by 2002:a05:7022:6625:b0:11d:c049:2fa3 with SMTP id
 a92af1059eb24-11df649f9a9mr418502c88.30.1764795401944; Wed, 03 Dec 2025
 12:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 4 Dec 2025 05:56:25 +0900
X-Gm-Features: AWmQ_bn11sXI1U7UXWaMI3_3cEiTsmxIqY6MUQmN6SkkQuffHABuBSk2RK61BOI
Message-ID: <CAKL4bV7NQgNstsGXj=uWrvXU8JV2kEA5DHEaySofYXSKYQDMEA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
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

On Thu, Dec 4, 2025 at 1:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.11-rc1rv-gc434a9350a1d
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Thu Dec  4 05:27:29 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


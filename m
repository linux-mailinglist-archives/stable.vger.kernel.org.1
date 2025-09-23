Return-Path: <stable+bounces-181436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDEAB94B54
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED06162A19
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F722D660E;
	Tue, 23 Sep 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="NYth7GLb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B02E1C69
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611370; cv=none; b=EidqyElt86MZfIwyCi1kmCifYRrECF13fy8vkA3nuPyOs0Mz+Yp0SywwUe1j5GS+NUvsGDv+cggN0rTo8q8vtBNVzijIrEqzm+GdPog166ZTGGRTBkDXwDiX4rvmXXwODzhJDgEgBzusTe12+a9sYqq4pdUoaOdofdUp7YHCT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611370; c=relaxed/simple;
	bh=ysHSnboJ1VSr6jkBIcIUCwgVamK+FIg8Tw8ZKEJoTYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl6Sz9qyK1zboKqeNlPIrp4KOjrtNFvOlrsIZVUjpsuwquH/9bqOMhIfNIau67aTKeSO8au45JCLG43lzPKWvUxrn0U0IhenzYaXMLZdIX6/w4XaT/yj9e+N2FGHfYJNNVSCdjjupKnvuy2C0vqscfH9rPjGngft4U1UjxMtZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=NYth7GLb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so4933766a91.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1758611367; x=1759216167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS/Hcgt6nxISZoclCG4XRiK7DJieVFaBpkh9uC8ETIk=;
        b=NYth7GLbmyTAA9EyuPmGZoW2Tw/aemcJPqVaMEmDvY8WDoTPXTp1EYRT4SeP9Zl2n0
         0n2KggAfwo7qXniqtm1PQQDeFWZgGY8NrVReiMKwiFeCs7tcTxcZtkbfUMF07NwsqJXb
         P+wIpilk6kDRQMbSVAdqy46dyPoLNIFGIkgwJytPe9od06mhERN1aiCBXLA9EZI05rHn
         7SyM+WXxTO6gOkvs7wKMiCjAgqGOFUl0TXqKJJT1lTKCWcg3Vqw0Kyo4JgyzpHmDx7kv
         IMN5JeVqYTFUq2sZbuk/hCN2sSyfFk4e6ADbj4DMmhZCq0ns9lgczN7nsvH1WeWSapBY
         9t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611367; x=1759216167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS/Hcgt6nxISZoclCG4XRiK7DJieVFaBpkh9uC8ETIk=;
        b=J+5myZZLDSmdgIuRSC5tK4ofSO+YANB15Qz+IrNA/gCO+DLn57qp18w+OQ0GR677BW
         J+Iir6sZEnUg77J9b9gfgmnXQvT+fNFROCInYFU5dGOmtzeJDpZ/r2H32y8MpezgM8Rx
         Wz61at9SDuT47xaCmTVdSUbI+iY0uz0BBUfj3J8wK8JDrS1Eecw1s9IMMcIwbDa/Muo5
         0fitIDldoXwCfOSpEJj1SGQW0H8ZvP/4UQF0glM1Sw+CufI0UA07kC6sRr081Fy9qYox
         znHFAsa5aM7iEm9Y6bGLHCm1w+v8Frft0Ln4NdXOLa7ShSfV+TASlf/Rqb1hmq0EovgB
         YVSA==
X-Gm-Message-State: AOJu0YxJp02P0+OqSqNiRChBbK35aOmjSY0dtr+FjwWHZ11ggYKRbjjw
	q7UYpr8KWokjaCIlMTa/HzH0pfoN4h4HUlb17ytz2X4XAeLqLakZ6cMkIv1BQm2SMn0PDuKl5/O
	oR0EfR7jsdsl6F2cwZCp/l09CQXqGfweG2xKLyUHp8Q==
X-Gm-Gg: ASbGncv4xwMMtL3Vj6L6FEoy43pauCotnHxHmhL7n2I+gfSWfk72HEr97U2LY7dHxPf
	lW5ft1vZ2yzp7bSrLayrV5tuSL3WC0tg6VqmLND0Lwuv2lGbG3mSjrtsJX7yenWu3oWbMybS4q9
	RMv5lFvz0PeX8jLUsZlVnioM68dwCNvLRoMMGsV99rfOplHZuQ9V6Whbwu4KdTzfJgzm1rcPXsT
	DAlXSRi
X-Google-Smtp-Source: AGHT+IEgoLb6RErKTnJ5NIZWIJLVpqUBP5g71PH2B1xh1MeH1Fl+3zcfHUqPKMdNb0NwcitDlAsWFhiPjv2M7Hdy56I=
X-Received: by 2002:a17:90b:4f45:b0:32e:64ed:c20a with SMTP id
 98e67ed59e1d1-332ab42e4c4mr2037223a91.0.1758611367438; Tue, 23 Sep 2025
 00:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192412.885919229@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 23 Sep 2025 16:09:10 +0900
X-Gm-Features: AS18NWAU1ht66y9EVnhyxXlwR9JHytYi8_B10g0jSKv9pePNQntsZc8-dhugOu0
Message-ID: <CAKL4bV7Z+Kf=gDvmxL27hV4P8aHqYhOm+n3gU-WoAxESY-dNQg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Sep 23, 2025 at 4:42=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.9-rc1rv-gfef8d1e3eca6
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Sep 23 15:36:05 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


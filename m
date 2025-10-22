Return-Path: <stable+bounces-188979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E53BFBC3A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 14:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B20C1A010A7
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3232D42B;
	Wed, 22 Oct 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="XJKCzpAB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5F32ED27
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134566; cv=none; b=MCmM6UBR2nxSYpjVxhAC5SlQxb4GvSXC/3kr+PCuqPH8i6MSjCp1WMVMS6+W9Qc7x5U4ntEJhZUnw+mPf//hHSKZBV3rf5KI6dXnSwgPJFNS+8KVb9/BhT+5uzPAp8/78SHLwV2YxmmyI/6+FGQpLtIz9Tx261AHOnxipbSaTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134566; c=relaxed/simple;
	bh=qc+TGmxJjDR8e93EuCMFZsvuB2trJNVKy1yWPZqivBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln5fN35/fYFHZ5MWR6pY/jvPhYvkyrAQRuj8dtZFUMd4N4MFFa458CQn1R+3zV+98OGJsZpMPalPdYY2gWCDpn9ZASJSAQAPcTVoRhwLFV6rxOcZHm5Q0jlvdMH1zjPDGt8Btsj3v02rnKhBkYBTRi10+v7bMXG+JbUSSMlFsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=XJKCzpAB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso359834a12.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1761134563; x=1761739363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5/wbf6GFhoGu3668TdoXMB0FT53GKQn1LtblB+CeVA=;
        b=XJKCzpABZvpOntw5f+NpGJ9RnShY54S2mztKg2R14SMf5F4WbZdKnyWpa1DaVI2CDD
         9D6V7q9q9LDgB6873yjqSXflbxCHeRpb0y7Kcn8cNNqZ8nKI3igqOAW4Z5I5QuT+d1X2
         +EEuGbTRWTMlyRtyJjLJbkQa/JcKP3+IB9jpTkZAgLbGK5plPyZp92wt8alWB9eO2fEJ
         KGvWAuwk3imBtGmofvHAtxFIIeIW0TO4RVTbk4GCf7FDZa9PzHaoVOK/zl9ViqJCjb3a
         L3KenxeaoPWI1UR22IFLMNVCxIyRcShtaj32S1n7epd6q9wQhIowW9CPgRz1h2JU7PK3
         s4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134563; x=1761739363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5/wbf6GFhoGu3668TdoXMB0FT53GKQn1LtblB+CeVA=;
        b=jdWLfTvvTWRaxeD6yli5b/8m5hX3dOpDx0UxlJL1p/EQ9O1UE+c3Hf8skx8jG2B08R
         1QGZq3DJg1w48Q+npTpKLPB3Eiu2kEbq2/3id/5PVF3YDhscuaT78rQ7Y6mdRattzdqU
         0j8aePgXdlJRIbe+Okgfqg99tlIlyc7ziNBB+Zn+I/v2gDaKwgIYoBZ6kkD45Z6YvgST
         gUajxjtzYQ+xlTr9UPSnowDPYNiApMh+5JLs3t8plUzz6UHSXblweMjZseIOHyes8Fkc
         GkTLd94BEKDePshlSqWFT0F1tv5d1aq1ysv9Jya7y+mtdn9AwTaMsxzZFf/6lJw/JiLN
         cM5g==
X-Gm-Message-State: AOJu0Yy7SgllpJvCiINHHz3QJWIDZWJDrgvDqezqR53nrkRdlkJVm9sS
	3oSZ/MTnFI1MXKjLNBvUfNgGNSHPLwBziG2c//dFKWz9L5e7tOkalkpVqhQBh28u+Wtxyxdc8uy
	CtKJafuAEbrl1W2KVMCq3nmlnF+u7fbzqO/LEasGqHQ==
X-Gm-Gg: ASbGncv7gO9GUD6Ji2ES4j8/SePFpGNDUFrU31EBHNkaPKdoXqFcH7bBBeACEKHDEuF
	HEHANRxaE3jTs0TjVNr5NDp3yD2L54c2sezZrLL3zWq4ItsWn/9WTLgH9j8sTqxZprZF8Ey1+1B
	bTLg+j43u6qf9y7fh+o0ZQdOaEoAGqm6G0SxVllCNQ5atD8opBVpmTBgZc4vr8cD4vklpF54yvN
	j1pKErysAJ+CTIes3S3Fy/Dsc5IEfVX2syPYJncUksC2AH4poN8Biyg1JB7MEmd45bMWdWEUO4F
	N1f/m8fcT+d/vfTYE1OsTxchxo2T
X-Google-Smtp-Source: AGHT+IFL5t8enG2Zw7oK7pknpiCUZ9vYUeXHaONtu4SrU5QNhCELXo3GPXNs5SlUx4N7/HvLFJQcnXzAdCHO9w8JdQ0=
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id
 d9443c01a7336-290c9c89dbbmr301590825ad.7.1761134562657; Wed, 22 Oct 2025
 05:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022053328.623411246@linuxfoundation.org>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 22 Oct 2025 21:02:26 +0900
X-Gm-Features: AS18NWDUgkoVTtfgD8dgXCgAaXo5KDUPhO3XXcd_9Q3gWO6keur8-RT4nYB1Nl0
Message-ID: <CAKL4bV747Ucee17YwB4y5L_We7Kk5aRe4REckptqgfH2+o2LxQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Oct 22, 2025 at 2:34=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.5-rc2rv-g3cc198d00990
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Oct 22 19:52:46 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


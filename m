Return-Path: <stable+bounces-204165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A173CE879C
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002B1300943E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 01:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2079E17B50A;
	Tue, 30 Dec 2025 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WCwUFht/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B619E97B
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767057900; cv=none; b=ZlmtiuNfN0vkdiQZGZ3Z8Yhg9punQZTcjyjaXWCcvEWZf9uRfkPTUhbLfeTr22uNHdqstPLsGSgjqJdtb4ZjzU3sf9K+oqOi1g7NyMEXjuwgKPAjUQnP8FIPcp7dwXCgPdXkHeoQZzVS1rTtDYYzTN0N+WOOYT8qGZd1SFjDlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767057900; c=relaxed/simple;
	bh=XnvqjMaiUc+Sy+LYGVlq/1ATh5F3Ya328kk/v9t6nwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpIT68i3wiCQBLWpjXG0HM6pXVLhsozKbmhZBGDp561b74E1g3nzmtkRWYq1+nYaZMvmlPlJ7FGIwkQUvMdP4NDU5F/DxXLpZV3wDBjagtAfHRtdkE3b4TLwtKnOs9HCC0iq7hMzVOHPJvRXDiomjK2eGCMlknSpBam/Nzi1v74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WCwUFht/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso117481915ad.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 17:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1767057898; x=1767662698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkDlLrOKzmeE1NzM8OjRSerJUrVzndot1jq+5lzrCxQ=;
        b=WCwUFht/TR5KDt3bKjHwZk3ezRTPwmdmo6xjhlDgKl5SyxaMgicPFazm6BA9ziiQvQ
         5d/YFqm9a7F2EVBVn0nUogyI4C4ZewWG7eIj/tkee2DEEARnKqaR4eHeHmbymK5a2fXv
         Rbla0qXrH7xQcaDuI1dm/LMI4vfbpsfOqTmwyuZJU8+lclIhD0aoZZOIvm99M7Hhlr12
         Fwbv3iQj3rO0cNXOGdKlUzWPOIkaOXwwUf7tXKcaseyWIEA7UQoan7Z3SbOArn0HVLMD
         4TJedanaJ0tZxcf0LjlvKhc2sPCY4ZL9Y1fIrkj7qjpc575kFojOoV9Ii0eDPDFPP0tS
         mbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767057898; x=1767662698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkDlLrOKzmeE1NzM8OjRSerJUrVzndot1jq+5lzrCxQ=;
        b=rUjC9oZapy2Iiwi0qfpS94LmaA1yZXHsNL06S+hZWlvowPf4QH1eNV+kMg0iPjVVBb
         sHRHd0qMET5RcjWf58f13E7am9gN4iLBmlfW6NJOtBIkbinrwLSJy7AuF9Y7xgiwCGij
         DXhO0cvF9o9wlaEakZHPPq91nLTzMDwP80NjBNT/ycueBbWWA0b6FeSIzdz3a6KWRy4m
         ReQQaqi2blUEVOCcELl/0JWeLExJOaOOGlg6DwwjfnNkoRszQ76KmdwWLx1I3HRGStC5
         VngRDcbWkcFEhxyJPpXGCtp1O//gM9Z0OugtiFyXamxvbMWJXUwPRoiUQNjRhgJGxT+c
         +tug==
X-Gm-Message-State: AOJu0Yx5VW32swMs8MzuE1l2rKr2ymWmmHlRO2eW5H0GHpK75uZ9vIuH
	MjAKNu2MK4m+QAvK+E8kSumsBqLDuEKPKLKPmSKJb+jXq2xjlquuqe98Q7QG907Fb7/hLRGjBhS
	mPB0JTVJtXWIt3XyAB+dFagAt2R9i/5G04bgxyU5l0w==
X-Gm-Gg: AY/fxX6i1OitfIm/UXk2nxzBpiIOWi35BXfWrFzzqIzXpobhuZXuMogW8Tt3u10NLVH
	HciQRXeQ4a3ISv8DerOPVQyLmOfAy/iDAxhaLzxk9oMjsfMXENOHvG02zCBM5p7jhpNJtuoxrNb
	26MV9+1PysRUPOIoI5pOKWfSMXapxvxV+SwA+g5xtEykjE7hA2iHJ/7D7O5rbTIfhEq7jICu78G
	2YJk3GqyYNtP8YKDR3Tbx3BD13jkGhALcTESQ0zmsyGTF7PHbHZXpwCGT46fW3MrcCpFjVF01Kv
	HEUPkwuXpIUTmVYp2PC2Yzo50GLi
X-Google-Smtp-Source: AGHT+IG8F/k6zKiBfEuwX6HywPSeruCDQhXoUfFg196y9Xj48+6yz/3hDo1v+exV5XkhVG9MewYODh4t751+soQHnK0=
X-Received: by 2002:a05:701a:ca01:b0:11e:353:57b0 with SMTP id
 a92af1059eb24-1217230d0a8mr28358184c88.50.1767057898459; Mon, 29 Dec 2025
 17:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229160724.139406961@linuxfoundation.org>
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 30 Dec 2025 10:24:42 +0900
X-Gm-Features: AQt7F2ruUxrbMit0zX9U7RreFobAepBpC0VPLVPoDW6OVs0XRTCJoXsy-2AZcvo
Message-ID: <CAKL4bV6Kai_2yBWY2HSECrm0MNQpE+XO1BcLXhKHrk14JhSPZg@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
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

On Tue, Dec 30, 2025 at 1:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Dec 2025 16:06:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.3-rc1rv-g685a8a2ad649
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Tue Dec 30 09:19:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


Return-Path: <stable+bounces-89069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85B9B30E6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D9C282C88
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7B1DA313;
	Mon, 28 Oct 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="uKzPpCki"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD71CCECE
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119728; cv=none; b=JnfdBYb2r46tKyv4V82aX5RGIAJ6VGKj1IdGYOae+EEmjwqIqcvCB3/8JqStr+WyXsfqCsRndRtrIm75bBT+asX21w70vWfbBfFpQ/ZZu22rUVXWfaDbIiD62KAPgTZUzjUKqZiFroblPFlZAkydr9w5iq7JNSNvbNuu/fsOu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119728; c=relaxed/simple;
	bh=JoPSXOQeJqMKZgY81YXFOztSG1vOJXM3CX4fstflfPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK5lC0FyKoJY6+0V8lurX5pBhCHo2LEgfr2EwZ5ZK5gOduzUWlg1B0r1N5FB5Kvd2Fi6mrPcennnvCtxTFv22MSG1TqD17FN4OE8DEFFENstK85LHQEYyEsre2YKCYuzTUohZwwIG1ymb1pWYA3eXnHrRz5yZvTqs2rvdZzhEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=uKzPpCki; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so2849983b3a.1
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1730119724; x=1730724524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReVN0cLvWmqthK71mUPz9Vh7INJT2/+SuZUXMARwOEU=;
        b=uKzPpCkiNHGgrfKjIwM37Xq1pe3YpqnWCc95TaBk7ZIWR4J57QBhpMvMVLk2TltuUn
         ghI+2bK4zAP1/gqx23U1Ccpiczz1NIFlzuWn2ugbcRwLxv8Aiyraeee91jCipnYUlOmL
         gW587I3BHRgIMPjgZQj76Xm3Wb4u/ZPlQAuPJpXJuQYAddVJ97Z8Ag17EzDKyaI5/9sn
         bud03Tlhx2HJkz9Lh0QEkpUpDgmN1CcAMCK+Z4OSW/CvUDla3/P3SXmHZtMqQPDwAShN
         lH3dAcNjp2krWynG9mOdbLe4EvLUmhnYSuXm12/tbyLFgJtJknHAZ+um5AX6Fzue00Fh
         jyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119724; x=1730724524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReVN0cLvWmqthK71mUPz9Vh7INJT2/+SuZUXMARwOEU=;
        b=l/j2+/OaSF/1xvkvHaZ9e3s7BUUtnqLZHT8Nb2bHX+5ZLNigNXduRzHQ3q89j/QDQe
         +vAHCYltVi1sOA3S8jDil8py3gLoDMzsHBH49PcKZPTZ6oSPPRAkwn5AAyJVokqV585m
         0v83FHVdTkfWuB6XbdVMEVt1+LwswJaCddBa5goN9SuwoPWlYQWfm/5Ltdeb9R0rX08L
         Tqq4jtUSDFYzQxqdX52fmTFVMsfRdZ8MDIZRoKORY1umKdNiRXj8dxvE0jXshhk9mxjF
         EoY/RZFHFm1oPQZgfVUMKlCEgGbO1fKBl+d3bXiX+K5tOjovx7L8nPDUX+gXTSqzduWx
         RBjw==
X-Gm-Message-State: AOJu0YxRwmGPKB1DlXQXfTA8hk8Pk2Mpe8vZqpF0koUuwabvKyPrgzJ3
	K23rLnWBPlkcqulxfBJqogpyf647DBWjEs6jS6mE5Gv8OzHNboqfE0ABNGuCf+0cRX0X45Afbps
	f4wlCBY+0hgLcvhQK1kqppytk5Ympq6W2JegWTg==
X-Google-Smtp-Source: AGHT+IGhLfmQkrVqP4HYAOjiKc7239c27pDkdxqrymPqmidDyewNr77EbQ//qBWctOJ8VAhkGWdsckBMrKZ6g9++IUQ=
X-Received: by 2002:a05:6a00:1954:b0:71e:44f6:690f with SMTP id
 d2e1a72fcca58-72062fb21e7mr11792989b3a.8.1730119724055; Mon, 28 Oct 2024
 05:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062306.649733554@linuxfoundation.org>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 28 Oct 2024 21:48:33 +0900
Message-ID: <CAKL4bV5XW+xCFSSie3tBE1GiB4pFZ1vSpHS9qkyzZg6ibxDVbg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Oct 28, 2024 at 3:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.59-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.59-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Mon Oct 28 20:41:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


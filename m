Return-Path: <stable+bounces-50049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC290163C
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828991C20B6D
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49243158;
	Sun,  9 Jun 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="YMpbYDsK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110417E9
	for <stable@vger.kernel.org>; Sun,  9 Jun 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939560; cv=none; b=kWIEi0rCVFUumjYRZy4vhApR3jIO44ulwVfjMjslh3nO/p2fWsoFgy11CPnIC8L/CDORs6MADTtA7GOaaMWKa4zxsFrEebHzqzBn6Cu73YyWbHcDvqQyPVDsqXqR089cD4g1oJlfFwkRkFt61U0pig4e88HkTXA+aPGARm7ElDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939560; c=relaxed/simple;
	bh=u+u9QLYNu4HrAWgyPgFZCbJEI/NnuOHhXl5OP6+ZmdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TL5D6EVYhL60o322u1n8CmNoLpZ/Z92t84H6c7d4rCB/Z1rbR/nwz7UlUjQBNxOPHZt9ifOeNcnA1Kw6js/u0NJHh0zBvb1Pa+6vUF6u70ooCezZuTHY1B6UZLn/6kmghALSjGxXq1r5xq/WCxfabcUT3anDFqYminKmoImyOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=YMpbYDsK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso1390398a91.0
        for <stable@vger.kernel.org>; Sun, 09 Jun 2024 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1717939557; x=1718544357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fXq7SaL6D194sQwZh+H3HooqCMUEWewEfZ6pmv61pw=;
        b=YMpbYDsK3qlD6k9XSWAC8sYjl4/OSBdkyruZWgQ3cKsuUDo5q20x9DnbrVhpswPoAI
         Nq3D1Rsv+s1TQqSy0/r+ehL7MPRZ/RvoRagti2mRCUfmSj2MnT57KqszzvbVfjihDkBE
         w73yi0DdnUBrfATzYq31QPPaXV3MQjwocSD15qp4d/eTJ5+r4deirIrnVfhCV3zgyRSv
         HiJtMLbmjarAcVb13AbiuGGOWwKW2FKHhNJgmM2FuFy81EJ79quV4Zlta4JN5A0OVg1G
         lwwuAHN19C7C2VXJaHt/SC7Kd66qv2Smekyrpa6hvGM+hJqlvUVLHwoEsQ3Xhgm4pCrK
         yU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939557; x=1718544357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fXq7SaL6D194sQwZh+H3HooqCMUEWewEfZ6pmv61pw=;
        b=XtXEirs4jTaLbiaX7IQYvh1UF2Z0qgs3JbNvS3cdH+7D0Oo2TKuYYmUuqfOitEpSgj
         IqV3KnXQcKxCNAxdhuBHpdm5Nj0pgHDCXq1rgu4d19azEC176StnfRyBvfq53Gc8KzOM
         D41iuO9lrN6Ekvqc2JP7rSjNA5V72KDhZ+ftgN7WbhZ41WanOUq7WVJFrV+rbTQsCGUJ
         1DT8pTw/GvwnrTvr3qCtJ/iNmekDji/8UCVNEc1tC3pZH5LoPB1zbjhklOPO7Am/6XBB
         LLmUXhOynWbZ//FBEQQASnp8wYgdyLrEswGwBkCb+jDWvyvvpS9PtlxbrXNoxwRXM0x3
         nBow==
X-Gm-Message-State: AOJu0Yz1Z9bzgo38JH7srqvOHctE7zt/t1eSNW6NOWQjhTu8LgLScNYU
	cpUZz0emHPsjMajLn88cEm9cesz7MMoqqkRFmatg6veoSCvi6GFEu9weIsWRWO39uYDMSho+8DU
	ZWIWb8f+h541Yxb+TW0h7he5K/kN2UtDzXvQHbA==
X-Google-Smtp-Source: AGHT+IE1odL3BBZ9hhvpRx8NNX+yPBmqQqY4qii/zdBs8e8gtpn0Fcfehkq7fp6P+LBk9yP6x1KrUy0lPGjR7Qg/WhM=
X-Received: by 2002:a17:90b:19d1:b0:2c2:dfc3:eb7c with SMTP id
 98e67ed59e1d1-2c2dfc3ed08mr2450309a91.18.1717939557527; Sun, 09 Jun 2024
 06:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113903.732882729@linuxfoundation.org>
In-Reply-To: <20240609113903.732882729@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 9 Jun 2024 22:25:46 +0900
Message-ID: <CAKL4bV5zSAu0iEvfHuiJjUZqi=zgr2e7xiEOaiYsWN70Ur9j8Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/741] 6.6.33-rc2 review
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

On Sun, Jun 9, 2024 at 8:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 741 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.33-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.33-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun Jun  9 22:02:19 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


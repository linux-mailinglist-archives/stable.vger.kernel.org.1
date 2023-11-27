Return-Path: <stable+bounces-2742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D327F9E11
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6DE281392
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EAB18C1D;
	Mon, 27 Nov 2023 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="NR9+Ky7q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C37113
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 03:00:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso1013069a91.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701082838; x=1701687638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmt2hlpJeJU9hnh5GTsTezQO+y0eDA0IJjENIi6FxVw=;
        b=NR9+Ky7qGj/ZUHbaiblM2wYGtYrKVSpf0XFX+hPQayV3/QC2er3CW0/zK4Br1u0Dzb
         WU+e2n5WOJBG+NbWHtZI0gMecgcyep6fR91RqSN4KMZlnYLgNaTrug1c/q8eCQDmybmW
         S55BPtIPfB3leRilQ6ZPjex85M0qxkFVQ1g8SYYE2n56XmUufNbsuWakWOWRJD9HVoRx
         1vG/yrJl6AnHafbWk/2aHsevTF4kSZtMKyflWExFK4slNe+9VV8orUmVZO9H132p12FQ
         jeu6au/l3tnnkmhQUgdKN2l93LOOL5HUtA5hXABfYsHnGvL2Aiy5V1csipnddm3BM6On
         nW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701082838; x=1701687638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmt2hlpJeJU9hnh5GTsTezQO+y0eDA0IJjENIi6FxVw=;
        b=RntPuEa0ZNKLbxg60uJa3tHgw5fwcytApoqySOYI7R9JXxuyXpjEiMRswk3ZAp3TC8
         YOjW/+Psw4P/Zh0PxYlj6/9w/SMTgZOMsan4EULoYQ9pDyNYpXX8y83uc3J6t8EXacuM
         AXpCwmweOLGKG561I5b5OPO5Ning0xUo1QwaAC+K8DC3xmMsG+88VkSBpg1gBGtcA4kY
         iqAoU44Cbt3drMVmUq53P6IwTiuIdJ/S1KOYyXgJDzrOLbFSJL8Egva0HE7uJuP0sqQ9
         r40pPe7/cg5Uu3pJmR53vFa4L3GkXW0wx3oMVvFvia3QMEdp3SDhhRvQ2NjQPEz/0AqE
         QF+w==
X-Gm-Message-State: AOJu0YzSuh2Zu+gLyBgO7ViA7RQYzXewtkFQ8IyVKrUBDwloho80saC8
	uKrfOCkyJJ10MUeLaiO35RyNUFXRf+zdEDQ53uDXeg==
X-Google-Smtp-Source: AGHT+IHsdtBGvlYv4OiZ3uPa02d1XAJd97bFDgH/OzG+X8+tTIgs9DaNMw/VYEXl8nRn0KWY/ueQrTyUkogFrTpuTbI=
X-Received: by 2002:a17:90a:e7cf:b0:280:cc2b:d5be with SMTP id
 kb15-20020a17090ae7cf00b00280cc2bd5bemr9756711pjb.15.1701082837063; Mon, 27
 Nov 2023 03:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154418.032283745@linuxfoundation.org>
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 27 Nov 2023 20:00:26 +0900
Message-ID: <CAKL4bV71Bc_2zfi=WSrgse-S_M7qvb0M9pV=U7CofNu4-WjiZg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Nov 27, 2023 at 12:46=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc4 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


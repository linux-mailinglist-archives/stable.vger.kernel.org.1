Return-Path: <stable+bounces-110189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712EA19421
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC466164101
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F721420F;
	Wed, 22 Jan 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="cFaxq8aR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEB145A18
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556845; cv=none; b=GYiDfDCY/PCRQHqcZyoCAOfWnXL9XpVI3ez+YJsHvWAWLrxYS5EWM6jfntSLyrBe3p/ZJFUvIsSTLJfzAVX7IhBDAapgZq/oa50WTNacw9QZW4NUlnYfYi8le3AbXrpCpHbU2WLDy8uoGOEL4P0WSZtfn9VhJwSMOUnvBegbmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556845; c=relaxed/simple;
	bh=LsfukF/yBfh1ci0CeM4YPAlN1I2R2qkAxmEyopkVvGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7aeFs5us190mDZ53H8EziOnne3CEyAow6MuetxUwwTdNdc5qfbgdT8rOrAlVJELV53S9Y8uE/knk32p002FbB/2ZagW3s/hsM0iZKY6hHBNawXnJwvm5/N1E2XLoN+532I7Yak7X/44mMzybvk9WH1uRadWQylcH3bUth+to78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=cFaxq8aR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso9503425a91.1
        for <stable@vger.kernel.org>; Wed, 22 Jan 2025 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1737556843; x=1738161643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6McvFRaJ5osHAYhUEUYsvwZIqCtrxvJxDD2sjjhlt4=;
        b=cFaxq8aRkpQh8jWyqzJ2PuZmKGvS+P+O4KB1So/qyc8/Y+gTb4MzLPO4IqD+tGyyiI
         0bUbIpTFb3XXjmVua+a1xsKEhrVAQ9qFwXmw060dipEUdztXhV1dC0b+QzIPe6q628Rz
         NYbX1G0rXAdI2HpFA+2YVm3VuAY6ta85OsLSx4w8a9Xuo0IZO3STKddfpOrs7nvl3O/k
         ++a5ARAyLMJzY2y5QL8zIn8fxIED7Pb/o4RMitoE4r19YmKM1DzNgC8WFofNbR6WUgWq
         AVsvRWEDaMW0MuLtsRGNN6ZCNXHDvo4V6zA2i0Aq/OhlvIjGRXo/p3OAwDkfZo03Uizy
         PIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556843; x=1738161643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6McvFRaJ5osHAYhUEUYsvwZIqCtrxvJxDD2sjjhlt4=;
        b=GLGYVi/MB6Y6k+tsURvidY6pLBRmrLn4MfAgmJS4SlOCPY1wk6laZZixWJet7r6C7U
         YTzOwBjote71aidc6P7AbgThu10pJkH8Wxze8AescE8Z4/7xXPsYP8Hr1Cr8XMItPxHc
         4EmOcqvFa71yZOTirtlHanPXugfghp8AwNOZQZ7XafIXVfzK5Oxjg184vAn1N4nXnHte
         kaPnbrr2TWqcyRcvolGrsSLmSKFX7ZJxy8E6YZMALZi/vYWdtxXMiHKMKI8KHBZMcJLN
         59z8ENv+adH0BwGr3xmEKlGCo+0l8TzHK27zIwnOyqmXmHn2arDGrZMjBvPMamkEt7I8
         krRA==
X-Gm-Message-State: AOJu0YyCLpfoTxG5Hek9M2p2HBcdqcrWJp8RPDTRS/Zt1es89k20ByC5
	Iaiu5Q9MqF0anJtcbSLf/muDLJCLZ91JQf0UBzLTldA5gxZLMeCoZ/qRto8JRYVT7u3VnN6Lkq6
	IJxaEEg+vL+vIyvr9wDawneiSOZjuCwLuedidTw==
X-Gm-Gg: ASbGncuMt58zhzcD7LiTwOd+0SlQt+g3dxFZDofr2eko2ZfqY5hCnTGzjsa7W5h0GYB
	ageqWQ6N7c/yAiZSya1k0zYkPqh5I+KKJQRzN/VcFdqDuE5zFP0E=
X-Google-Smtp-Source: AGHT+IGv+GlnSom+dKcknTxqk+ZtvCUMMUd9EnJqMxMxHc4PjBjG5A40osvTg2dwXP9e/EwXwhDwjK1mVEA5Iz+pJ9U=
X-Received: by 2002:a17:90b:2c84:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-2f782d8c84fmr31882295a91.35.1737556842998; Wed, 22 Jan 2025
 06:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122093007.141759421@linuxfoundation.org>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 22 Jan 2025 23:40:32 +0900
X-Gm-Features: AbW1kvaxMa-1XgosJuFYYbAaAUZODb3Ltxzlan0oN98CplTBoHkdtELScykbKVA
Message-ID: <CAKL4bV72AK1qSnPFE2JK18D-Q4mBvNPef3u5sqHKoOP4UvB0Vw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
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

On Wed, Jan 22, 2025 at 6:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.11-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.11-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.11-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Wed Jan 22 23:19:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


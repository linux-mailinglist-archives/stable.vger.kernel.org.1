Return-Path: <stable+bounces-194622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E339C533FB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 17:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B130566A1D
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9C34A78C;
	Wed, 12 Nov 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="K6nKZ2ft"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54E33E37B
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959626; cv=none; b=b6tg4yZuWbW0JGUdeNBL/yHBb99HAqxW7rugoBYFmKO50jqomncC0C5l0I2F7UkOKtitJR6pSX7uaEpS6ILJt1pSB2Jdom/bTuvP4nBWZEsiyK/dyRpf3Iwsw0leHKuuk0XFakSHO3Q83rKc+N1VH92K8ebZGLi9cJ+VQwDv+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959626; c=relaxed/simple;
	bh=PJk3WBrYdf7Tyo77E02znNUc50rN6CzDR9RBvtG6MM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZ+/sbyMzFsAqVKnSqnnaRe3cZv1EwXjwxfwq9LIJ4m7VXJyQ9v7Z8VuHONvIWg06dhKvUdZUL56s1J3+5RSHldNg+aR+34A7pl/CJOHUQRYdB/6dnf6DWyyV/rjp18dWULYogZv9LkgQGiDLeu99CvA3uKGrgcn9arVzQAf2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=K6nKZ2ft; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b1b8264c86so93176685a.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1762959623; x=1763564423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zXj8Vw0xd/qX3+ihzUkZ+DSqDm45u5a8I3Mp92b6iE=;
        b=K6nKZ2ftkRdTIioFG3eh4QKzrph2K1jQN+jYNjbcRjueN0kzIgrVh34qU5IJScmKsy
         L0XrRaWIAoIaRE2XTVOdrvPQWGh0d/wYpX11QtPSAcrKnZQmkTDhUmp0RuKCGqad9hiu
         rmR8igP8wzG1OSEAPoMAoVHo8GdjYZ6FhKYCf1RGRLcPsHN7O2N9x3JL2IgmYA4mQhuH
         JDxNgCYhSZT6TC7TIkgGeNFaHM0g+2gCdho6MJhjWIbtMbfBsNn01dnd8zTyYz6HsWB+
         RM1Jo/Gk3SkrQ1GKyfCFhVh84IRH48ArtXXCxNkgnF9Uar4JGYauwUMznavUwiGeXWzK
         60AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959623; x=1763564423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zXj8Vw0xd/qX3+ihzUkZ+DSqDm45u5a8I3Mp92b6iE=;
        b=TFPKLgQxbN+Vzg4P+2lCOZGNAgG80vHO320y2iR0gmngQXCXB+1wk3u12nZveIC4c+
         r8XVYJ04GO1Uk+v+icFJoxPe5zH5zVvT4QLePeVEefbduL7NV1BlFyVN02p99fjny52i
         sPSdvpzZQ/nZbnYselJ88w6Wp4LPMynDyfBuAiPcjwN9uldzAc2BWlsIeLNzDd3PZcSU
         LLqZ1mZok4PVXh/hiYpNyvBmYLG+uBFmxLwBDvLdQe5GptW7Cz9WjqtoMQW17fYTKt4Q
         r5hvcgeoke6gtK1R7CQSaNVkd9TKFlY5q55/g28SqbbtJCwRHv04IIV1G0GHmQ1GmNKy
         l99w==
X-Gm-Message-State: AOJu0YxYmxx1z8mkTT06XKk4pMH4GHAvHmT1WidThgdif4u6E9s1L05i
	T5+4EM7uvikw6PRp1v1e8BuXFUevKloJjywbhy0OIe4hvNAaA5cDgdySBtJoQvj7bNmKLiwZcET
	RoFuMDvFS44c2iBxVtl1A1nqHP9FXkBAlh2/l/QF6tA==
X-Gm-Gg: ASbGncssADZJLsjgYc1JTwLXQtbTt4GLbKntJVH9NS32Bye1d9gNNMmQQjNCcqNSfWM
	JLhuT8ahYnZbMfQ1J10qNxE0JRlNWf5TCb2woCizjyCMaRSbUcGrTzn8jG9AdyS8WfATvPxyH4d
	7DY3sLsxjJYrXDP2kpaNv4V4Quq2KeTPwejiccuLOerpOBDB/c15cbJ7uUu5TntUWxJqLwvvNTO
	tIIHTbP8HEC49ilYlQZARD3eRid1GJ8wiE6wDpALQ5MlHGFFEkGPVnoJX9I90kXs4f6ZKbg
X-Google-Smtp-Source: AGHT+IGGxwpT70xdgCvNPIbAid5Yr2yjLeHLPdRKOlMlldVAPeBVEplLhReQ6HO49sUo8UA+RLI8nmybAhzhOWfAiQg=
X-Received: by 2002:a05:620a:4452:b0:8b2:295a:bcec with SMTP id
 af79cd13be357-8b29b96dacemr411166485a.88.1762959622363; Wed, 12 Nov 2025
 07:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111012348.571643096@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 12 Nov 2025 10:00:11 -0500
X-Gm-Features: AWmQ_bm34fQ2h4Ko5Ao74lfhzAP12s6Mwur0ANO5wwfSG1IMc_s2OBnSCBibTtU
Message-ID: <CAOBMUvgGc=a9BQzoEjZVR76=RjYVBA5QSFh7bGHCGZi4VEddVA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
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

On Mon, Nov 10, 2025 at 8:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.58-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett


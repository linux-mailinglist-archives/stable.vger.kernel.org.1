Return-Path: <stable+bounces-158522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DBAE7DD2
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F735163C4A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110EE221DB6;
	Wed, 25 Jun 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="GUHGt9bX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFD2868BF
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844443; cv=none; b=n5mGMGnStgL4IrjWBOeoQBul+o7N8Z7ZE0FhmaKaJoVdGTf0+nuBMBPD7ewOfuE0TlP1craRHOJeWALv9IRUk7nfAXjQlIQSZSxNczbMk1oiuci1hIoNn0Jdn6kKDrTMWpX7EqkOf1F54ZONIynkoM06F6N6yKiqObAEbjJNjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844443; c=relaxed/simple;
	bh=tke04Hr1GWdS7lu0c+9LoPBNgUtdJPK/syvMJuc6KGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCJyPXB3fq+RGwG9RnpojUE6KpyRWc9/OYbYCcISpHNWBoT3CMdEhph1qzSSxdg8AvWKjRwnAOPC6/IE7u57/NAzNzufSTTGrKqNXkSPuWmMaCgvMCcF8nGj9yk3MF49KWxRvp7tsTG4aSPVCmxpNdM3csQs1U2MP6htpYtrR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=GUHGt9bX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1337319a12.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1750844441; x=1751449241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M0yLkQsKR0YiyFUjwpWUZCh7qwBerDpMZfoZtVAIXs=;
        b=GUHGt9bXHaypfNmgOe/iJdQe22HewhbxGtO7V65BBbzbhxywqDpCaCFgHxwr8Ul7mk
         5cdTxZjFcOyS3jCpOd0pixgubLze1Em3BE9nRDJs3L15HTr1NY5ivo8JjgK2RXy2mhlk
         eIDQl9+HjgA/qca2DvVPQmsJQI7eGYOnyWwi16MeOD3fLupzx96G8CJeYKNL0zDCAfSk
         sKj0IDV/Ik0y+3jNFHtAOOgQLz3vLEElQkwuh/nklrW8/o4nyy0yMUSbwGhrbkxTPmqi
         xi3yB6hDisKgz2n72eIRpe/a9gnBdn79QSOeCx2u4dX207oJ4PxkE/6PgGmt9CsnGlcI
         pXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750844441; x=1751449241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M0yLkQsKR0YiyFUjwpWUZCh7qwBerDpMZfoZtVAIXs=;
        b=d0dJjsHJNdFXOHZLZboBFcU6jXx5GiXRGYdc4UwR36K4vgGO5c5YCnhfk1GPLgnHqq
         WwrRjUyNFuJZF95Qj5rO/7MiYkrBPxCVoUzc0YgoGNiLOtiM9BgrHwoa0bTibUbZel1i
         mapESI+AazjxV0dHKataBHboNZpbntSDAFowU1VADcWn6M8H+fyh+RNXp0wOVWyxlK1O
         TCBrNx9YVK+aQYNmNZbL6ybrFAP9Ed7IFOw0rRo7iG/LoxcjX5IlWGvjbg85xraf4yFD
         2qOwODXk6TlLzuYDXqej8cYH7GRGQdt8LTJNL5pjUCiODb4hQjk9ENzxHXVuKJjO043z
         cgdg==
X-Gm-Message-State: AOJu0Yw7k9I9F2OSJ/qCdXuL/5dQndDs3Bv47AkbLoJtn0FGNNicAEWw
	AtX7QkhaTUtAEhALN8myA3XphgbndHCAZUjD8lSYXKzhGu20n9xwe7yVZN7GN3QIcest49S9d61
	rBc+YschinOMBZ26G97LgfyQGWGABF3bkI0gxOORkZw==
X-Gm-Gg: ASbGncs2W1Lk7Ug9aIlCOwRwCLZzwHsFAodAPOE73PRWrYwKWpirJ3qMum/arY7SqAO
	tlRsiRan3l3H11QQ5VioVP5nM7fVmOEUYEFzOzIsAocWyDEzMVa12pDhhuIHCPFV3zfr/bDr8oa
	9sI5xLfjJ0wB+CsxpGbDd6DH5ROIibkKa4J8u1pmY+PSFm8LM5DKQHag==
X-Google-Smtp-Source: AGHT+IG00K/kpm2hTa2fP8BKaxOCVSF0UfugUyd93dHVunRMl1Fz8O1C+j++doQt83NSid/RhkIlZIGfTM7Si0uMsa0=
X-Received: by 2002:a17:90b:1c81:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-315f268a404mr3102280a91.20.1750844441510; Wed, 25 Jun 2025
 02:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624121449.136416081@linuxfoundation.org>
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 25 Jun 2025 18:40:25 +0900
X-Gm-Features: AX0GCFs0Ue24bpACExUeXXuPVoyD4JIFjJgBbT28iyUyE73zbAYOm3Ich6oFbxI
Message-ID: <CAKL4bV7CD4udvk+-k9ia6GSKoWJB31Su3LbZG6k=9o7joTC4Pg@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
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

On Tue, Jun 24, 2025 at 9:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.4-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.4-rc2rv-g0e4c88a0cd37
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jun 25 15:02:33 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


Return-Path: <stable+bounces-207865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8326D0A8C0
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6051A3029C48
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834954763;
	Fri,  9 Jan 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="lqcS1iOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93E35CB91
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967525; cv=none; b=TdKeKG5dGB0kqBs/hGtpZN3HCGnGLzhrQL7ju94D3HOnCs8I1G5OmmGWCipcmEvjhVK1pbOo1T0ImvzMfQ+ko4W+lWxQmsrZr9k6/0sZvfYan6WU6w7XIV0HcXnxpnUE3u2ea5FVkw7fIzXMkFt2bcsG0Vtndh4ObGo23kLm2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967525; c=relaxed/simple;
	bh=wx4vAWq4HWRPnv+paI/7ZmkP7FxxJlu+civ+LVmv6WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVBvUB9NvqSB8rLnrGloptMazea9CI3b6/vhiVMcMiVg+tRb4qK/x6WOdUcR9p3xt4eBHa4ZZLqe3S/8EUvA1CH76+dlFai5KbZyoMsDrKJ2AiBkz3S5QDW8CtopLjuISUR39/Rr+sj1HMtEUB1NHvBvwnjOrYSom6XUMr1Zm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=lqcS1iOo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so5052087a12.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1767967522; x=1768572322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHeZsUsxb8pqM5+6KSuIQpRYBszdo4M9nQezvPEaXNg=;
        b=lqcS1iOooRBYpaEcLoJm/u1znB4Vt+PbKFQ/FUeHGLzD3On7HhkRGI0yjbn3rkwSJP
         JcwWnwF0h/ZxzrlKeENmjfnZEa9OGNI/QAVeoL8nSH89cGnNKfU2ttQm0O67sfUyXNIk
         CRBYvzb159zpFf1Hvw6VK7QdfEOChLt6vt2CyEtWNSgv5ujMgy61U++prFKlBe166Vk5
         RK5uF4iQ/vcJz8E0S6fO/hHAylcmIw+7KyQ8GCYUZ2IBpF+FGuugs0a8OsSNZomN3GyO
         QgOrM37nRW8c7kSMzssKb40c/1w9A8+xkRkFuBO9zf/DyJEWRswtC76HNabFPHdLA7DU
         +sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967522; x=1768572322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zHeZsUsxb8pqM5+6KSuIQpRYBszdo4M9nQezvPEaXNg=;
        b=lDCxJqfIl3EqWZDjDkn1b6ZC6p9nfhw3wSXHjblTn0lPAx6uFuiZYXX0UqS1vCpnq4
         4dJGT5sRdYXF9toC+pC5wtXN84cZAiNYqJnPcnpQjVrG4zgUKKHyAcMXqnLcqBYp/juh
         PlyFmJChJ33T3oa+B94ZfbRx9gXyqy7gM7H3z9mIc6bx+Rma1Ccf3Idm9hJ9nMnwWGP4
         yY6mCH4wUw4YEGHqyqqS8uF2bY6a6moRMpCkx4MwGhNeh587W1obq50TiyOVs4AWQ8PO
         D9zmVDvtmyir5TMAsqoNl+XBCEYyr+BXVU1AbAGN5OngdwwLzRCqBZVtHSKHKYoQI1HD
         +IpQ==
X-Gm-Message-State: AOJu0Yw9MQkmuA7koGC0Am29NwnoJIEIXbsd6qfY9I8WGgPmONh0/DkF
	tSfclzOShMy8iQ5hiONJN5cHrXgMTmmB3akh2sDB8KhWC7NoxFnnE1haA3sa6TmVOXqTWsCCB1Z
	dZf9mFItiDhiczzkX+jPEd3AnbWKPQ3Q53UC2Yqr8vo/3p/5UXm4fnebp1zKXrjepQmHl5vIDG2
	WyDeg+p+bACSR9DyL1liDUxln+tjQ=
X-Gm-Gg: AY/fxX59naBkA+ikyzSE9Nev2veeoKyQfSwojIQ71T1JHT5HrSez8GH+pLnoeGjvCi+
	TMoWr0siWbAheKdA9qpqXhje1dphh4k59NYhJkbMkrQRUpkPievtfjwTxS5ZReml852Hgk9wtDk
	nMkc2QDeOR/J/s3HzOzMHDdY516EcrqHP0CBozdgZeaghJLhSKjIl6rz3d3i5BRn/KctMfVlM8D
	Df8JnOuxHqV2Xa66ouqEFEkojRaUBab7zO8Q8wQ8EJTTj+UPJexuzY7DXCUVlKFk9Uiue7Wo8PH
	sWS6TrTaE3wpMvsV25dvQG+5F8UjscfJbzYh8dg=
X-Google-Smtp-Source: AGHT+IEI/djWWBT7/VsY+1PsEGYxbDvWFPBavsKV+H+zDI4yBu1Iz0hEh9i74ky3XJTniZbaXUHwa96Js+M6bQXbP+4=
X-Received: by 2002:aa7:c705:0:b0:64c:69e6:ad64 with SMTP id
 4fb4d7f45d1cf-65097e5a118mr6730160a12.24.1767967522257; Fri, 09 Jan 2026
 06:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111951.415522519@linuxfoundation.org>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Fri, 9 Jan 2026 09:05:09 -0500
X-Gm-Features: AQt7F2pf1Gj_cPAF-AJJHCZlCWO36ykXfYS6WUbDLNq5yrZvTtLi49NZBVKYFk8
Message-ID: <CAMC4fzJhT4Mwao3=9TbAm=rWP=zfGJcFTsmAFCK=p3UoqGQTcQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
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
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.1-sladew)

On Fri, Jan 9, 2026 at 6:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.

6.12.65-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade


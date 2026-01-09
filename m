Return-Path: <stable+bounces-207915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F287D0C2F3
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 21:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54688301E59C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069935CB89;
	Fri,  9 Jan 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="lDkKNCoD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6D2DCF55
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990590; cv=none; b=s1UtC/oXy4z9AWinXHaxrL3/fLdpgX8gxDBLAJ25zHCq8uy2wYil8bbjXU6xT7kdMpLBkly/C8IVosmGygfi9hkF/i0IjfYwdcLk1kB201pE4xo4y+f4KHTWiLG1z2eyPZMjENGtsT80EDBumRHqQwJ76cMNXFR1Sif1TwO3MkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990590; c=relaxed/simple;
	bh=kPty2XSJ1GOnPe0hUHJ2MczujYNDgIh37AvEBYYQhiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIxEY8MB2Fm4qIyACWkIxO+apzZNcxQHddQzorQoqm2mOVTbptc/P4x18MXrj/MMGIY3+pE42FvJSlx6slVL4/Y0eHp3qp/aexs4TPabjOlkDv/h8DckzRYVPhgdDk5U4ReHdzqg76x+IJQOwjWWL89xVinR4ZVpv3Gm+aUuIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=lDkKNCoD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so6723973a12.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 12:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1767990587; x=1768595387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hxSKJhPzUKMHAOXusRtv4t4eZa8UPsCro2dFMgnySo=;
        b=lDkKNCoDmXtbsioEW5A+EFDjuxdSo1vyxVWBx2GEX9hJW8c0WQq1jvEJ4qCBq9b4wt
         JYasWniNU1En/7/k5dAw1Xx0B4j+Utu7F+0ioPZ9wMrYGJjP5uv9STnrYTliVHGf/PNl
         mtfrhVt35pmnNEqugXpC6Wx+k5y//hhEcprZpt9Pxyn+IK4mkyNyZpwaz1alllYoHAXG
         Lfanp7EpJFPujkIX7ZJLim7Te01zYPjLwbCQdUCpkhJK2vBkEhAkDKHkW6+j1QqU3UPy
         xgBHC4aqH2Hg7lRWM9lUUlJp71D8BmZxVlEyG/c1lX8rCz7TbOtdAMWIYNzWz/fjcrnu
         rW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767990587; x=1768595387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hxSKJhPzUKMHAOXusRtv4t4eZa8UPsCro2dFMgnySo=;
        b=gM4RlUPIP1R0m+0U5snR/BiCFgI3aBjk1gJBDCbUtFIugtrwWs7GURTXI0RFJ+i6sK
         0sTJfndsMtFw197rfuBsQ09FNFswUteQirpQvPildQ2DseY+ukLe6MqQ6RJS3iE17rKh
         mW1fgd0HkFWBhWSb3T5qZvxKkuxBK1dybTWTz9D31D7YjPqra5+J+HfrKl7wo+UH2dRL
         5DSEbt1inDJTB1yMxhZ1/+V4azEXda1O4gIWRBv9kMsYn0akHEAxzgPAVPXDGl/iLDD0
         Z/TM462ZRVSmp6tyhOvA6S9JnF48+tx3KpsYfdSR7dOr6qquSXx0fUMWarJ/F83JVBgf
         ps4Q==
X-Gm-Message-State: AOJu0Yy6+pg4U4RPty9KyIES/evtfgg2hFSyaLzw9dyqew7h67r7epNl
	b9LioKYHBE1Eq+HmGV1rQV7RGy7OQMcV5tgTgejUywCCIeSetPNfTn70An9AJK+JQnda77skpnm
	nONXymeUfsLZ7iCQ0xNXL3buThTTOwWlK9M3xKcug3C8+/N27nj1uyj5PqbrtlPLkvQ904wnYyB
	0guy39yVBPviidxNhH07uues9B1zvwPCeiSY2OyLmETLY=
X-Gm-Gg: AY/fxX7lbmxj+jPMWcXjAIPtVhlUJpjuuiIsDGohlQUi4M7+7zDkoDd4pK5C0bKhQnx
	rb0wde/axF0Aqcq0JDxEW9dQ3z8B/f+xyP8y5HLtGPFla630KaLIn30Csno73+hpKA/9Zf+oOs+
	7jKH6pMjKhmZgKBkCuhqFqcy+BfPsFTWNciyQfJuZ9OPAGZ+7c3VZl63dvbu2Up61aacufIL3FW
	dQYqmm1SUQKvD7Z13YfFK6R9VHyprYF5Tx1DGDFq8lptXHIePkZ4dZpwa77XTtr3uedKbdePx5F
	+180Hh0ZALYp4J6eUCGud0pBZxbB
X-Google-Smtp-Source: AGHT+IFsQuep1RCIF48EoSLJlBaeHDB3GWCfWQfuNP9JrLNqa9W+D/xzeMk6jabguRmykg5uQ7ExPeaLegU+YdqbIEU=
X-Received: by 2002:a17:907:268b:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8445283562mr1120993866b.27.1767990586444; Fri, 09 Jan 2026
 12:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109112133.973195406@linuxfoundation.org>
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Fri, 9 Jan 2026 15:29:33 -0500
X-Gm-Features: AZwV_QjZnM_RGVRmuEx51d4peqbKJ1XlzEdSpXr8uwc9vKqSRmCtI1k_wNRdIQg
Message-ID: <CAMC4fzLxeOHNKoRZiw1kjrf7L54-4kDPzQFx8NiyYEZOtrC97A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/737] 6.6.120-rc1 review
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

On Fri, Jan 9, 2026 at 6:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.120 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.

6.6.120-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade


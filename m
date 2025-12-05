Return-Path: <stable+bounces-200155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9980CA775E
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21CBB302501D
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A983B27FD62;
	Fri,  5 Dec 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="MCO/41Ym"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E432E14D
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935542; cv=none; b=YOUCAJ5AHKVPjiqzlMGiqjiHe3QJ0mvV6BNK2Ah5oBnrwnx/pZbLACtG0AQeiNJnhhGkTFxgJCccnbmVKMNWK5WGZZXNH6unzPBVIYEUjqTrqR1GVk8dlDuH4BVYw4pzDU6kdhYpkSmCqX4P7xQf9amP1ec+QMnp68NJroBrFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935542; c=relaxed/simple;
	bh=AMyHnTnXyIiCuxrw44BiBoykn2XzflaqAFpUREjKdbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR7gvsvDYoQLbzDLdhnXW1OVD7lWlWMSEUuZhDPrV/RG1UOS7blB+1YQ4/HyqaQ7ew66Y22wHcrplbtKRcFYC5Cpze38R/HeoNdXdtAqfRQhFVcLkCocO738WRJCjOrTX7A2q7XDZsJFEv4G5TWvfQY6YERYJY96eOEh5RqPCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=MCO/41Ym; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736d883ac4so344961966b.2
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1764935535; x=1765540335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqSIEKbo/CixPo289Ao3k/usAnKyS/YtdMQMTBUZnho=;
        b=MCO/41YmeyXregXUO4Gi+LUhb8nvppLwJx1kE7kjUKiyzWGHsXa2XVpfxSD+srzLND
         XXD1LmcCz4AHz67wAv9UF727kpDGsAaNF6cSSkb1EBWiTKubqAwB24IXe960wyqDeyki
         7iSAYEWPTpvuS8mBBhKBcTda5k4VTCQ6d+AEL61S/C7gZ/gMkFKWsdTrRRSw67c23sFE
         oolZP1fXWATVADkoHBqty+BPoso2hb74ydJyBBUqmpBsFc7/8RfSNRBDyhgqSsZ0hgtD
         9KEX7ZL9Ah7Oj6qUULsUbXsrBwX4mRu0Hc3LYxqh6bic8hv0y+T/nUfqrZ5EqjW2Y8Bb
         bxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764935535; x=1765540335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqSIEKbo/CixPo289Ao3k/usAnKyS/YtdMQMTBUZnho=;
        b=Kc3MyWByr0vcYA1OSGmLO06b9Nkk/ASSzeoAIFYT2QtMVyox4hCb+cnkMBqhmvM5ef
         423IcuCALdXSg5ZaecBUs7ApPa3eBKn1HkqXjQLkE/DNNB2C62fxRBR42YT3Qts2eQuK
         aas1xasLCJpI3jTSFDgm08VwpkZnyJxiKGrkwfVLX5RItwHBwlw4E9+Lx4UN3tWhMJDH
         Zl1tX6Ry0e/O+bGLL8nAlbdnZ+1Wciy0YSYye7LTAdep7XVXiyGjzXk1gHlnh+BSfudA
         bD8FSnrN425JH5qgcfR49II0t/ugrIZKUqwt/5SIns2KDHvMKZCPJlw80NMHkVdQkq94
         ao/A==
X-Gm-Message-State: AOJu0YzYul0UsNQ0laaCstxHctnWpX7WAd6o2SPFnFRqMmzm/LzKkDhC
	Q3p1dteN/vAtxMklx1cHnZk5cg5LqInMDKO4VIpzXUMqZbvruFtBnm54PNzXIJERBWv7ztwKNgX
	+b20xWzr8vshDunJ5YjBU+flx98jAgQCjacsDO6OqsQ==
X-Gm-Gg: ASbGncv2r6OakQSMpVPU3p3ubWLFNvPwxuKUG7NKs0ZckBwsN/AUvhxJgxieGW3ay2Y
	OWcXcL7egullVCQToZAi7VGuks2aQDUmuEPAUyPAnyArcneUbTXJrRJE1QvIqE7lMLSeLLEJlRC
	0htUyQoDH58CmosWyj7OaxfwtngOCJxvnRAhgv1ya/oxBXQcl5Tv2XPhkx4R2DqaOUdA+k77EYy
	tAuqkHRUpbJbzHEUkq8JIl0jC87DHOhSbjw2x31EkThfvUZ+iu9CCXOwlzIkCcTtHfBVTk=
X-Google-Smtp-Source: AGHT+IGTiLj/ITAy1xlqaCMY3nft1UZ09b9A4g7axG+Y9Ggs8A1/6Tc74DDdxYafG6Fbxu5JDhye1GJl1WkmzzZEgjI=
X-Received: by 2002:a17:907:6d09:b0:b72:5983:db07 with SMTP id
 a640c23a62f3a-b79dbe4967amr1068299066b.7.1764935534874; Fri, 05 Dec 2025
 03:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org> <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>
 <2025120413-impotence-cornfield-16aa@gregkh>
In-Reply-To: <2025120413-impotence-cornfield-16aa@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 5 Dec 2025 17:21:36 +0530
X-Gm-Features: AWmQ_bmcQaXxzg-mejUZu_ahVJ8U_GoVzPlxQ29FRCaXN9PRLpqCK4-8yMohzTc
Message-ID: <CAG=yYwkbpW8KG8ks9QGfOroV44sishtjFwvhnxBpD9O2en+7Ng@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
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

On Thu, Dec 4, 2025 at 9:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 04, 2025 at 02:38:10PM +0530, Jeffrin Thalakkottoor wrote:
> >  hello
> >
> > Compiled and booted  6.17.11-rc1+
> >
> > dmesg shows err and warn
>
> Are these new from 6.17.10?  if so, can you bisect to find the offending
> commit?
>
> thanks,
>
> greg k-h

hello

6.17.10 has the same dmesg err  and  warn .

--=20
software engineer
rajagiri school of engineering and technology


Return-Path: <stable+bounces-267006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SgJGMJmKM2rtDAYAu9opvQ
	(envelope-from <stable+bounces-267006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48369DC88
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:05:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eehzqdAn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267006-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267006-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4A4D3014259
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 06:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4B330D22;
	Thu, 18 Jun 2026 06:05:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91175270545
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 06:05:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762708; cv=pass; b=rX4M+KgChnuK1dgd7YlFlnnRiP3i5BGISW/UdibhEfZVndGtSLAE+43jzVHpB1uEbVjZqVDTpy5ULv1JETKXrc5AFEr9fo3ZpB28ZawPR5Ko+WmTcwR4hsy/D4X5nRjPV6cpNgh8e737TfrjNMVObFYKtR8ChhvyTMj4/N2qqw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762708; c=relaxed/simple;
	bh=+kpJnXO4/8wwNzoHtaVQtv8o7oAoB303aXi/DiQlGLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyOFo/nhwZlG+x8daWrlS+GTwu3P2G0/GXoA7xnuDIrfzrw8UnBtsKXmf9vgkN/9NXqxJ2xeaaw95jAXqVRrjh4d1LP8ke9j+EyTf5SAVosMgnK4hXya0fiJPuBkaKjpB9g0oWHlMZKQDHlsP0YsPDfxVzqUjQvE1qA/kjY2f7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eehzqdAn; arc=pass smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bd47b9f0fso604155eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 23:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781762707; cv=none;
        d=google.com; s=arc-20240605;
        b=SNu/sxtOKH+zwSDImDZh6rmMdi6b3J+XTmRUzxJHrGfNqya3OHwx4Hs3lXe7TWLM3M
         PRmTnIhTsSvMojqWVQhaVtaKvogdaPx8iS2qv+zT91ntxnUUWf6npNb9LtIGx6nnJ3B2
         sEglBIkSl8Lk5s6LR77loDVsRWo50GZ6Zc5sVkY/uT/zo7HlQ+NpyInYXGkbYynB4cDt
         sAjFN3zBQ1r9NpBvF/Toekq45rdSUgQviDD3nl45oexOYqNnitBWT1y1e36A7Oox+bfA
         AyHMKJshPqdkbDEpxIzfm+vTUP5xigtEkR81RlHrpWwlHdHxosgmSIBWoolsUruzLeCO
         iLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WkgBk3go1aRtnxlhVuzDR+Jr3GsyjXkZW1XpX+0nkCE=;
        fh=QqrdBPX3xQ/y2WH2Ll1bT1wuXKeknVZfErRpcUcNKjI=;
        b=DbdvICucmefGsuvsII/9W8x5oWXBCZixYSsrtCYFx+NltQPyeEOO+6r96BQnakF/8B
         cBV3soiv8PjG7gVA35QA4PMxUVqzAmTFZx6foIJ4wCfq+O112C/H/nXiZGUodcc/ekbO
         d5lyrQdsXO5weEnZ5wwSbKFLz8I8KyehE5X6TNQWmKyoiexxN0OCGnu6HROvxjBEiB6y
         SPt581VZAuhWxOOJ4/wh6qwMwHfIdj7ZFaN94pD9EpSmf0fMA5oeG2zc4UAHMY7u0zts
         LCQr0ttGiQPubaT9mMqEUh+Oe0MI/zO9wcOpzsO1G7X0kODMItAG+aZzOEnlhuGtynE7
         mBeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781762707; x=1782367507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkgBk3go1aRtnxlhVuzDR+Jr3GsyjXkZW1XpX+0nkCE=;
        b=eehzqdAnyb2bKiM89tJ0PM5VB90fPgRZ1sldXDqqTGU/3dn1d4gjbG39W+5L2x1buV
         CouYvYcsDi5GSBF58m2f2VLWTGEz6n3zPJJ1eIQX38rekX0wesyXwCSMTl2sSIAXXGfz
         RyldL7fBEwtaUM9ZQR0tDojk1lC1rfcQK9Od9kLPqqWwmeyWx6RuY/j5nLJnhemOVuxD
         96E5vBCUqCOnPd45JHVo8HQZEbdqwlEaUyRWHc6wroHrSy60xes18WTCP+3ho2wXo/k7
         PGSGI8bgOm8Cx5oHPlFCTjX2VFUYx4U/v72s0SfW7VZbU/2Xu31c2l1gen2fdced4Dye
         BcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781762707; x=1782367507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkgBk3go1aRtnxlhVuzDR+Jr3GsyjXkZW1XpX+0nkCE=;
        b=XKA4FNvk4+yrOs2Bp30S77awXBj64EN5OCwPaNjQwyHJPv26VTAV8Nkb512n/vs1zX
         xjvrEwvs3Rx9Frl1enyUo4gem8F1U4FtXtMLBE/wXweA1cogr3gujStdE1whnkFlr/Uo
         JOoCc014Nw8Ri9cLR9YZeku1DN64R6lr2j6Wnk4Njvtz3Eo480Xayc2yG8Min6jbEsJa
         GRevjz9bs1XU/bKGj1gZpp/f1NKJTTzzNLWd8np2SJq2nKGGA0ioZaYnFvsFDbXe/kTL
         MB5HVBqMlFihJvyPSYw5wyMfXbkhHpTWAuz2ozKhFnvwHH+E42HPQ6bvMgcvzXzDv1/6
         8Urw==
X-Forwarded-Encrypted: i=1; AFNElJ9Jk1eO3fbvrf5bqeuithrgIEDaJAd7Vpk6AvFF/RxiwUPjredPIUEl930AwpmIJAjpW9RzTvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+T8bDvFhVDIZT/ym3NKgZJqneQDNUeRggZfbtKhs1d1CuDRfo
	4lVVSFFvEYFAuL8GM2dXtu7RsX7CUOi+Ra4aLiRETd3e1QP0dkmwG6lw9iM3HJrJPlTjpaM3Cq5
	W7+ShinbYyPRHqc0O16o607Ronc+Qs0c=
X-Gm-Gg: AfdE7clAjgCS7PACIrDsEm8lOiHVED/ES9xZZH0NmM01d/YViwzqoIsjg7yQw18TusA
	UwVvetAlhSKL8dSTZMzVIgQaveEjHeEivDxkWmh458YQHaB6f/cMQLrgfwmP8y2xsBR1XPaVjdL
	otQSyOyCg8heVTwd9qIF93J4Fjq4x7DvTMOXaeHR+9Hyy8eSrc/MaFdeT80YWpU+xl2hr/tEteL
	WF1EdTK09r+MJknH9PH9TNnpi63ifBvSyI6xC1rPhyFp5OUO88+YPMvnJNoJW4YZH/NILaHb1T0
	Z8DEo7zo8qoofErfw6Mh+5zCAZGUSk7bjConT2JtxdneGe2Y3GrlpBIRTcb6w743UqAEptHjBc6
	7UPjiw+IISIaoVKev4LQrSizkyiknUV8Oh2RJpBCFokar0ksdh67Pae0Em8wEqcn7tCtuHT1IjM
	qXXCCAZGFR
X-Received: by 2002:a05:693c:3105:b0:30b:a257:3a2d with SMTP id
 5a478bee46e88-30bca0a18c7mr3986622eec.26.1781762706420; Wed, 17 Jun 2026
 23:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616145109.744539446@linuxfoundation.org> <f33dcd2f-787d-4705-9272-394e1d560ae0@googlemail.com>
In-Reply-To: <f33dcd2f-787d-4705-9272-394e1d560ae0@googlemail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 18 Jun 2026 08:04:54 +0200
X-Gm-Features: AVVi8CdXBPQXTNC1zq_Qb8ITwFfGHIZRxK_GPHJGWi-dkCBBji6Nl3TN03zhaWo
Message-ID: <CADo9pHhAQHGsEB5i4R1GDeAqRubRb-oaUgMjTrk0y-Oc_8U5EA@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_RECIPIENTS(0.00)[m:pschneider1968@googlemail.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:pschneider1968@gmail.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267006-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,mailvelope.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A48369DC88

Work a Dell Micro 3050 with Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
and Arch Linux

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 17 juni 2026 kl 21:13 skrev Peter Schneider
<pschneider1968@googlemail.com>:
>
> Am 16.06.2026 um 16:53 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 7.0.13 release.
> > There are 378 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server.=
 No dmesg oddities or regressions found.
>
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
>
>
> Beste Gr=C3=BC=C3=9Fe,
> Peter Schneider
>
> --
> Climb the mountain not to plant your flag, but to embrace the challenge,
> enjoy the air and behold the view. Climb it so you can see the world,
> not so the world can see you.                    -- David McCullough Jr.
>
> OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
> Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
> https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968@g=
ooglemail.com
> https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968@g=
mail.com
>


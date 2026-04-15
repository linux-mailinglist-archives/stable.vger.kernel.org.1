Return-Path: <stable+bounces-238042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEXNfQm32nmPQAAu9opvQ
	(envelope-from <stable+bounces-238042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46040094B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD29B30565A7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1E361DD2;
	Wed, 15 Apr 2026 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuhvW9lz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079433372A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232159; cv=pass; b=qKFYwUEPVlfyVn16euIu4EttnfqmlAFlm3bfPyrJg7vC/9mQ6Zjh6Xa8VRotDnXHV9NZ3tCeHpLWdzaW/T5y5Q6FeMbFEfnyku0flndrQ9TmIZYYjDwF/ZtggSlDpB5dAdnYRIZcjYElQtmYxoj9Qe8Yhv4Vwnzh9oT0/SjjNc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232159; c=relaxed/simple;
	bh=0Ko4VIiZxkI/O2taJ+3DwN8b1cZwadpXOzMv+Q9JyHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1v7nrtC788zEldY015VRKW88wztu+GvOLh3rnGPz8hqIGrs5j47Ca1x3UOqqOumeO7cxJGAS7PJHRuhz5pPWOv7pMxXDgLz3iQy626457/rvc8L+xoRFKG2+oneQ8m90Jcrrlb/wX+1exD2Dtf+loyp+If0sEuzCSBgjdNfGx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuhvW9lz; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a08fa355a1so89983966d6.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 22:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776232156; cv=none;
        d=google.com; s=arc-20240605;
        b=ZEX1j8oPI5bpjmyScC5WNtz/jKM4jR5q6U2Z+s82me7eBesclgprcl878NM70j5D5W
         mC9z2+6q3/cEoT6HFb/ypm7rRG+L0I2Un4KPK5wuMEuyBUtPaJEnlBQeH7lnnvO+TS9o
         y5KBsl1JSNEfHEErZO8twCuWg4rvnybS/WOB+oclFEqb/L0Ce9zI+QXEdxAja5Lil7et
         IDQdhwfqkZicnhp+BYujMAye2Mzpgci/8RukHRWlo7N45YAVSlEVYCJqwJ7tEVgmWHdc
         JQhvZrOkJZD/RMpye2zP2zihoJQolmTZ5+IWA2kCP2wKYoO7Zf0sEF9fbh0gbc6QFRii
         FW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g7jC+e6yTEY26VnAI6j6zPGlJNJqrM6o2NkoHZehI4k=;
        fh=7PKVmLKk5+mLulDtIfoe3G6K4k3i5PMwDhhAOwZsBWY=;
        b=Hi6WnPmr/NW/dNINHBzbphBkQTomscQ4Jmcn4k15WbXPheGYNJIJawVYURSJZ9ufMZ
         8SrODyzX8dNz0MwPqUJYZusbKoIQ1qqtyI3eaua52e8mBYe98svy+TohT+t3Q9yp4lYT
         2PB2ZxPJg8/o9vgJ420rPt4v9ok8RLXI1uT15a62UW58pqreSylol8Le+nKn/npq8hfH
         2ooaxn/IqSLhH7OiAVZ9DsKo937fQcRGcqf5tjoqtw3WvnUUefXiiFGwmz0SXozCe/6W
         AhjH0XzoQkjDvmbwxZYLN4BwGRKXwMYue/9L9t8zZUBBSF8Q4P1P41WcJnWYL7hVbElI
         4FDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776232156; x=1776836956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7jC+e6yTEY26VnAI6j6zPGlJNJqrM6o2NkoHZehI4k=;
        b=RuhvW9lzGi8NVZMQeDUAv0UwK0MZ2CHqskH8gB1dDso8n+Qza5GJSBt2aYbTCjP1LR
         rYyOYVAAjiWF6Vqfe81TYEkvNyuFajW7LkviqvSQyuWF1Hkb/1664pVjx3nLXu55egkY
         /cAlqlRhhozmBnRhHiHKUcJol+1mgIjgk7rWzTN50MYw9NT+J1xzbERTThuhJyVn24Nm
         mc+ZW0cK8i7UtRdcPNVx7U07ncVsdkIIoBuwHjhgOXPnBsllocrG4XellS11hrxjDFBx
         5gIPvU7RoaAKFIufsyxXZ1p+fNwKAY3dkkzZB9sKHiF56tiOdctEPL46WBR/Z9x265+b
         AaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232156; x=1776836956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7jC+e6yTEY26VnAI6j6zPGlJNJqrM6o2NkoHZehI4k=;
        b=a2tJmD/NFq2NFT/oXoz9r5OEazb4uwMpF29svS7DxogkXTIxQ2+Tt/WIF0mQLzoUki
         0oYg31d6txhh8BGRoJRLSWEKKQVVKUnbl+f2kCeJbFia/QABYgToFFCuOlfVjjH4JFWD
         RoxInGVewrgRdS78YUlJcFuYYF71fZ9FvY4BHUMXZXbfl7db+iIKJQClhA+5AvG5N2Z0
         yevMX9/S92HX839k6kDkvVxHiaoUNBUMI+lWwA3U/VwMLs/+xIsXiVujsSGmxToeTat2
         KDvOBgcbS1UgB/wPg14MXm7iqxD1ee4J//ixVvdibHs/Ln9tBJJtdoNMs+0pfOIjiniS
         ZeGA==
X-Forwarded-Encrypted: i=1; AFNElJ8sDJaYUrWFiguTRqW//dOmME4tJ7PAn5CrBt+DGP41WUv9P/0h6J7MmQ9tN/yvTle1qv6IZZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbAmBJhyyFMJFPio3vt6U1hynZcQc+COnbCAn08L+GO7Wm38g
	PNc/mIB4hspKkMHi1JGB2fZ8yYMVDaFWokHxZCO7aHf+asyKUL/1XeJiDQBnwZdct0Q7qO4x2et
	v2jSBtCW2W8CRCAILv8eR8D9EnF00h5NZw+oydZge
X-Gm-Gg: AeBDiet66054cuaPABnbKpy5jPfD9P4rafIzJDE+ySsmth23JIUnupWxmkkzca5ZlEl
	trNa6a4iQpQqdgSnTDkb8skRpyf0hukhgY5teGEIPnboe3r7oJk9j+yb/BztQhPr2xd/YoroA95
	p5VdJHxr/h+nfocf670VxgcN23D65PQOAOKZfMhrGJ4llPm1GYKDhtzmO+uVT7os3So28FPDq4O
	AcbYGQw66sIQa2IOH44l++qn2EedMiniOoN+yONca2QPM0KsomwBQIjwXuUxpo0bjFLxQmSXnwM
	gSN2ihXNfmZj+8rrgZR7YnI8LbBAoXHz6mJVW7kNfYI8sj5ctqjTmhWqJ1UZBg8NZfQh9vg=
X-Received: by 2002:ad4:5bc7:0:b0:8ac:ae56:b493 with SMTP id
 6a1803df08f44-8acae56b656mr198973546d6.40.1776232155593; Tue, 14 Apr 2026
 22:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155819.042779211@linuxfoundation.org> <39e878af-7418-4538-9e1f-8b62de3d1e3f@nvidia.com>
 <ad30ns8QQDzk0h72@duo.ucw.cz>
In-Reply-To: <ad30ns8QQDzk0h72@duo.ucw.cz>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Wed, 15 Apr 2026 06:49:04 +0100
X-Gm-Features: AQROBzBEqY4mG6hUOd2h2ReML6KwVLMY91sTJvZDNC4GxKeXzWsyi3AnMxmOomg
Message-ID: <CAL0q8a65x5mK2K+X8bY3sPrG8JMhbN7uDMje7JJNvvmzaR_SiQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/491] 5.10.253-rc1 review
To: Pavel Machek <pavel@nabladev.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238042-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.copeland@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,linaro.org:dkim,gitlab.com:url,kernelci.org:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 4D46040094B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 at 09:03, Pavel Machek <pavel@nabladev.com> wrote:
>
> On Mon 2026-04-13 19:52:08, Jon Hunter wrote:
> > Hi Greg,
> >
> > On 13/04/2026 16:54, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.10.253 release=
.
> > > There are 491 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.253-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > > -------------
> > > Pseudo-Shortlog of commits:
> >
> > ...
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >      bus: omap-ocp2scp: Convert to platform remove callback returning=
 void
> >
> >
> > I am seeing the following build error due to the above change on ARM pl=
atforms ...
> >
> > drivers/bus/omap-ocp2scp.c:95:10: error: 'struct platform_driver' has n=
o member named 'remove_new'; did you mean 'remove'?
> >    95 |         .remove_new     =3D omap_ocp2scp_remove,
> >       |          ^~~~~~~~~~
> >       |          remove
> > drivers/bus/omap-ocp2scp.c:95:27: error: initialization of 'int (*)(str=
uct platform_device *)' from incompatible pointer type 'void (*)(struct pla=
tform_device *)' [-Werror=3Dincompatible-pointer-types]
> >    95 |         .remove_new     =3D omap_ocp2scp_remove,
> >       |                           ^~~~~~~~~~~~~~~~~~~
> >
>
> We see that one, too:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/1390=
1155305
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/2450043152
>
> Best regards,

This was also observed on KernelCI:

https://dashboard.kernelci.org/tree/stable-rc/linux-5.10.y/0abb5988a311f0e6=
17615aa4b08c90b3ade85c25?df%7Ca%7Carm=3Dtrue

The two issues:

https://dashboard.kernelci.org/issue/maestro%3A67d434ff5d6b71886d45efe758ca=
00ff45cb969a?iv=3D1
https://dashboard.kernelci.org/issue/maestro%3Ac970827f049cfd67124148e3c19a=
be1d4aa8347a?iv=3D1

Regards

Ben

>                                                                          =
       Pavel


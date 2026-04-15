Return-Path: <stable+bounces-238087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAgUAa1k32mKSQAAu9opvQ
	(envelope-from <stable+bounces-238087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:13:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 965534032A4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92897302571C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740833F8D9;
	Wed, 15 Apr 2026 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxV/WDaG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E831F99E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247976; cv=pass; b=dycl2uKD+umtAcsBDX3QF3NQ1OdRfqRvQQ0H4qRYiWzgI9hvZ0/kN5aZB2M0vLm8+G7670vj9GUGXfT0ZdLv/QfhIe4vxxV85ZTshopyRf1tBkMjq+Vo9NV6MWalYsPKoPQIEsKjBZ84J+6zh3wn7iR3SuREaybTV6rilnjMaRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247976; c=relaxed/simple;
	bh=DdahS6NFA8addLQ15dt8IgNDZQRJvhem7ozkgtNq6no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7in6EVi/gf4MjThQtH+bSBcxj5kb9Vd2D/Ft1NEbJ74D/9gaMVfKvPQ94YX1nk2DBKIFkmkdImMXw1rG5mEgRMAY97E2DoVDrCkjkJg/lmfxL0IjLoP5Go7cbtfr3HeaYHCAkPozY403YXt5LxKQBs/gsyNxqbp7s/jVeT/cWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxV/WDaG; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d8e11b948so65572081cf.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776247974; cv=none;
        d=google.com; s=arc-20240605;
        b=Kb/Ih3zHeeDjeAzYgqBRDb/U0YjNqdBY7MFMH7Li6kDM6388WTaL5W6BQewR6BrrwW
         IHoh+q/VWEQW5HfvKkTYrl7SkoSd3zvklANq048KX49bY/Rn+5SBU/AvGidzhU7aWE8q
         oCFGQgvuLgSym6w5P1NUgUE99haLaiyvQfRNUQKqqxzaT14wLIuopjKbTJ0a3T20xjyE
         ly6Je4EsnD4AG6PuV2whJtO7hgp9TM+881Wqwtb3LdSyKDRkKr+mwPHy9Lmf/+ziNniB
         cCIy9CCPMw+CSQaBr5ke9QzcZmehdIvi/irUGbRdCLSSzpNy+7tPTx6vQgLiecYfJE0l
         V5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DuO9FvSZkadUAwRXym27+2dxsKsK31QJ4IEQ9nlRlwE=;
        fh=+/PwuPKNTrERlGKFOgdE1y64THUp1AvsMFqtzz9f7y0=;
        b=Ab9m2SGYFndE0pJPkg/Yy5NQZ3fF4jrjyL1f31uvcoZq4GgSq7OcLA/opMGC0NX1OE
         hzvPHcBmf5G3kEQOjas6MNaGS6yG0N5pD7AM3ACBbZ1J5xC83xT3i7EMbu2SfvyiHXeQ
         Ns5+ZKLNsb2CN6/RqgSldDr7rM/36g+l77NeKg05ClhCX62qmz8b5qJ7ylPvxWzP2r63
         Zme1HU3KsEJ1eUfpqm4fXGW3yuMsuZUbBtM3grMu1N99GsnMZDXW44O2xrHxex0J6/Vz
         w8x1+dcMQkvrg81pG5CnoQUyZl9cU5yOf0iH1jEaK5OSI+Eq4Tk3EnqJlVnyl8zZDje5
         dM5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776247974; x=1776852774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuO9FvSZkadUAwRXym27+2dxsKsK31QJ4IEQ9nlRlwE=;
        b=jxV/WDaGT9W7w4tASdkye7MRWYdIRCBjoKDcreRxyw6Uik3LdTMn1Zug2Ta695kZg/
         FyI26GGS+4+JRD3e694qgTMXQFfuTkfOaIDZ/4swjm2500GGLiSgKUr8RAvlyxQf4OUQ
         NmwYCMjmZ43ljd/9UsYS6q/Qw2ft6eplAtW8le4ftIAPv1v/O49XmM42WGOe3SKRzsgH
         DCsmXO2taEmDC6SZIY1sbteBmNZLg3DEk/H5INE3i1Yejr6SiCAX5mhn/6WIlx6ij4Wy
         JcBtwXlE2KuK65sov4/wfBrAWwi3pifBK2EbUvA5bMqB3jMtelQ798WUCKVikvwKNNzQ
         kJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776247974; x=1776852774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuO9FvSZkadUAwRXym27+2dxsKsK31QJ4IEQ9nlRlwE=;
        b=Eu7/UuNwJiQrBDKl+P/7GW+lw+dPx/hTJr4SBzFk9Ir3kmfdhWD2vKiVUK4SiRQGoj
         cdxU/42JppZ5Ah7OkpIb63HT3iQ+mrvWcX1p4rTxhEwbi1R39uc3FsBFBNQ+gAW1qaem
         OdTZ1Am29dCvidxHIsh1fPqjfph/pXgI9SF6ROv83cUTmszm1NgZitGtw+tAOSdNSCR8
         XZVewf4MTuNWCR+KBrR0io/lEd1MrJ/edML1+4p2nyIW3PBvh19/QQ1rdHa3e1s8fLD3
         huBQlseDlRWYmu7gmSQ5yPDp6qwsN04RMyTMQiQzP62y2H3U26UQqaqk/j5mP08XYFJG
         i15A==
X-Forwarded-Encrypted: i=1; AFNElJ8LaUrxLoLJV0WsOmAhALsVo/aNLNO90keJrkrYxZUyifDNWQyvnzPHXr151e0dpVff1/G6L9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Pt2Eg+jthmv7CmgWYQSg6gKemXs8uYF6+0omoZqVxiuayH0t
	ByRFDSqsIwEX0n4tOCK7Vhxs5DgiorJMhPYmEkJMc7paSEirgF1eEBBT01oAfNuMXYEZQi4oph4
	9QQL70Q6yMsC7yrpi54vvRp1yAEBa7SeI9PvHswLH
X-Gm-Gg: AeBDiethMyl8xCLLuzj5lUIhZQYm5ZUBdspamUaIJC1BFKV/VwiI0ywIU2JVr4KcFS4
	CnsLWp1wjCwaw+LzZBxeny2Xm/ku7SPziuEBXV0racxYHOlOgjAFVkj/A0CuvU47GbtpFfbTLiO
	ugk4VVBonTO36PCDOPsj0gxP845iDJkdJ++m0uu/Q28u7txcv4udxxGADZ00kkHn5Sp1W2HTIQg
	K4PZvsT4JcoZID1xvJ/z4CRUy8KL3tB8NHrEUYJuCbwGhIF/c08MPAk79lzEULuRgFYBok0273Z
	4IGA2L+3v5NJvIPEruQ56YSFtj22mg31ksLYLkJD+Mrpv8u1sgYtVZf/e+XTd4KJqF3jCx0fpzl
	cYlfcZg==
X-Received: by 2002:a05:622a:8f0f:b0:50b:829e:44fe with SMTP id
 d75a77b69052e-50dd5b78300mr203234711cf.37.1776247973752; Wed, 15 Apr 2026
 03:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155819.042779211@linuxfoundation.org> <39e878af-7418-4538-9e1f-8b62de3d1e3f@nvidia.com>
 <ad30ns8QQDzk0h72@duo.ucw.cz> <CAL0q8a65x5mK2K+X8bY3sPrG8JMhbN7uDMje7JJNvvmzaR_SiQ@mail.gmail.com>
In-Reply-To: <CAL0q8a65x5mK2K+X8bY3sPrG8JMhbN7uDMje7JJNvvmzaR_SiQ@mail.gmail.com>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Wed, 15 Apr 2026 11:12:41 +0100
X-Gm-Features: AQROBzBmv8xSDQo_D9z12jerqYxBHpNQPkITfqnvrSa7GbRNuXRIzFi-Jji2tDU
Message-ID: <CAL0q8a5GS3EijNNBLJmAy_gQKfjGTdbLWQqGcvzYNuATj+rT8Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238087-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,mail.gmail.com:mid,linaro.org:dkim,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernelci.org:url]
X-Rspamd-Queue-Id: 965534032A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 at 06:49, Ben Copeland <ben.copeland@linaro.org> wrote:
>
> On Tue, 14 Apr 2026 at 09:03, Pavel Machek <pavel@nabladev.com> wrote:
> >
> > On Mon 2026-04-13 19:52:08, Jon Hunter wrote:
> > > Hi Greg,
> > >
> > > On 13/04/2026 16:54, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.10.253 relea=
se.
> > > > There are 491 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patc=
h-5.10.253-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.10.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > > -------------
> > > > Pseudo-Shortlog of commits:
> > >
> > > ...
> > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > >      bus: omap-ocp2scp: Convert to platform remove callback returni=
ng void
> > >
> > >
> > > I am seeing the following build error due to the above change on ARM =
platforms ...
> > >
> > > drivers/bus/omap-ocp2scp.c:95:10: error: 'struct platform_driver' has=
 no member named 'remove_new'; did you mean 'remove'?
> > >    95 |         .remove_new     =3D omap_ocp2scp_remove,
> > >       |          ^~~~~~~~~~
> > >       |          remove
> > > drivers/bus/omap-ocp2scp.c:95:27: error: initialization of 'int (*)(s=
truct platform_device *)' from incompatible pointer type 'void (*)(struct p=
latform_device *)' [-Werror=3Dincompatible-pointer-types]
> > >    95 |         .remove_new     =3D omap_ocp2scp_remove,
> > >       |                           ^~~~~~~~~~~~~~~~~~~
> > >
> >
> > We see that one, too:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/13=
901155305
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/2450043152
> >
> > Best regards,
>
> This was also observed on KernelCI:
>
> https://dashboard.kernelci.org/tree/stable-rc/linux-5.10.y/0abb5988a311f0=
e617615aa4b08c90b3ade85c25?df%7Ca%7Carm=3Dtrue
>
> The two issues:
>
> https://dashboard.kernelci.org/issue/maestro%3A67d434ff5d6b71886d45efe758=
ca00ff45cb969a?iv=3D1
> https://dashboard.kernelci.org/issue/maestro%3Ac970827f049cfd67124148e3c1=
9abe1d4aa8347a?iv=3D1

I bisected it to # first bad commit:
[708f670c8e0849525742cc3a1ce319739fe74c26] bus: omap-ocp2scp: Convert
to platform remove callback returning void

Here is the log:

# bad: [0abb5988a311f0e617615aa4b08c90b3ade85c25] Linux 5.10.253-rc1
# good: [fbb1715e3efa70ec20c5b1f755f3301fd3d042eb] Linux 5.10.252
git bisect start '0abb5988a311' 'v5.10.252'
# bad: [0cbe44da7c41f095b72fb599410d0530ca80a9aa] ASoC: soc-core: move
snd_soc_runtime_set_dai_fmt() to upside
git bisect bad 0cbe44da7c41f095b72fb599410d0530ca80a9aa
# bad: [9b7ae0b9077850af955e1c8c976808feb269cc44] net: Handle
napi_schedule() calls from non-interrupt
git bisect bad 9b7ae0b9077850af955e1c8c976808feb269cc44
# bad: [eb39b81e0f85135e1e5a39b6c7bfbec77e03467b] sh: platform_early:
remove pdev->driver_override check
git bisect bad eb39b81e0f85135e1e5a39b6c7bfbec77e03467b
# bad: [a1ea84bad7500d1e346bf3714850c5a32c4d5c51] net: qrtr: Add GFP
flags parameter to qrtr_alloc_ctrl_packet
git bisect bad a1ea84bad7500d1e346bf3714850c5a32c4d5c51
# bad: [e6613448c424bc28ca19cad1e56295ae101cd9c4] usb: gadget:
dummy_hcd: fix premature URB completion when ZLP follows partial
transfer
git bisect bad e6613448c424bc28ca19cad1e56295ae101cd9c4
# good: [0f8c01ecc1771e45d065f17df934c2bdc4d6a825] drm/tegra: dsi: fix
device leak on probe
git bisect good 0f8c01ecc1771e45d065f17df934c2bdc4d6a825
# bad: [5a490afd6710b438b7fab854128d34e05e60c4bf] can: ucan: Fix
infinite loop from zero-length messages
git bisect bad 5a490afd6710b438b7fab854128d34e05e60c4bf
# bad: [5ec032ae50ff9959dccf12ccf0438c4b03032e2b] can: mcp251x: fix
deadlock in error path of mcp251x_open
git bisect bad 5ec032ae50ff9959dccf12ccf0438c4b03032e2b
# bad: [e2f4d521f05adb048145737f4f87125ab0452f25] scsi: storvsc: Fix
scheduling while atomic on PREEMPT_RT
git bisect bad e2f4d521f05adb048145737f4f87125ab0452f25
# bad: [708f670c8e0849525742cc3a1ce319739fe74c26] bus: omap-ocp2scp:
Convert to platform remove callback returning void
git bisect bad 708f670c8e0849525742cc3a1ce319739fe74c26
# bad: [fd70655e816486140fd3b8d190e98bc0390d756b] clk: tegra:
tegra124-emc: fix device leak on set_rate()
git bisect bad fd70655e816486140fd3b8d190e98bc0390d756b
# bad: [7cea67d4c59e7351b459cef6aa062127a4501923] hwmon: (max16065)
Use READ/WRITE_ONCE to avoid compiler optimization induced race
git bisect bad 7cea67d4c59e7351b459cef6aa062127a4501923
# bad: [efed6d887792cb026aef5fe3b711583b56b8037f] net: arcnet:
com20020-pci: fix support for 2.5Mbit cards
git bisect bad efed6d887792cb026aef5fe3b711583b56b8037f
# bad: [dad08fee3e0e4c9c2103fe7538af96398f7a7567] net: usb: kaweth:
validate USB endpoints
git bisect bad dad08fee3e0e4c9c2103fe7538af96398f7a7567
# bad: [2529a8fc2f31887320b59699da52508055fba791] net: usb: pegasus:
validate USB endpoints
git bisect bad 2529a8fc2f31887320b59699da52508055fba791
# first bad commit: [708f670c8e0849525742cc3a1ce319739fe74c26] bus:
omap-ocp2scp: Convert to platform remove callback returning void


Regards,

Ben


>
> Regards
>
> Ben
>
> >                                                                        =
         Pavel


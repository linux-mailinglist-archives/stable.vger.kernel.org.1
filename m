Return-Path: <stable+bounces-262017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oK99BhOmJmonagIAu9opvQ
	(envelope-from <stable+bounces-262017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:22:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4D655A32
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:22:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MKYZl3+5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262017-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262017-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2FB8305660E
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8204071FE;
	Mon,  8 Jun 2026 11:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C133537C7
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 11:16:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917374; cv=pass; b=FUiGEP/0ojO8gh7vNK8kOcDxcFIifCORjbV7nLG7vfj+0hMB7rbzZHWfYPYR+J5OadfOA7b94tJrBm3kw3uUGc/jJU9XtDosg3MrGPKEV9OsI/cNfKTHYF65P0lORIorW6wCkZwyibuj0SX7ZXpfJptJ9LTH2wMygyVC8DSul4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917374; c=relaxed/simple;
	bh=IIvuds8TvmyZhmHFQSb7b+CTObPtSQ97rmFd0ivEXPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewQ75y0j62aL8/TzlrruU2MH6PxEXt1IwYNqFMAYj+zbeaxOYc7Psq16QKpPkFK+ExP8oUYgbf1IyBUSnUpLHqTn/mDNTagixSuaqmpniCd7sucmieO00Bx51YrRuVc9cxqghAd1ncjZPwj1Lx+Kz3I3tHxws3MFyfz2v7S9MnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKYZl3+5; arc=pass smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304cf9a02f9so222858eec.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 04:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780917372; cv=none;
        d=google.com; s=arc-20240605;
        b=BXl2RuryoazQ5SLAkMKsgbXe6uKP1LXQJI+KQef63diUti9o0vEYBjF15vc6pxQFUN
         9Y1FPOSpHu6goYe4tWKCQ5Gm/Nn7qzLmB9bzyEEzIFh4ifW9o8MBTPCEl3iUFAbcBLjc
         YZvrtZCmDxybIeT7eborP/NwDQVBmVK4RQBguttUM+lN5GFCDf9izRMng0+xdF8lhb/q
         A0wFT51NRuDfpBZsN6peObd8prCyUrEi1UKLXmkZ7E6WVnbgQDcQ3/tAtOhFhc/20zUR
         n+NkFW04nXTJiCgiu33LpQFryuh9sa4pI38ErFejTJ/glZPxiKC5qfnpJrxSSCntU/4z
         iWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lpXOMtv18jGR6tMgBi7Hb/icQLkWTrdf0TFaa3c8mys=;
        fh=k3vYs7eQwi6cVF63mtzm/cXqdBbxeUqD2fvNFbYePDk=;
        b=asTEPjsDir5ymgoDLlDQni19vBJ1nLjAGWu5lR42iXiGOMsc5BCMgG+iWVclcl0+L3
         F5I/3HOiTDcnLnSWeqJCbcbbSW0B9E+NZg22DgFoVZrznRI+pEKb26QdlwFnHc6S2nl9
         TiA4IcQmxtWPpCRa57rN5WlfKFBqIwFfGHeR1AM9kuE+LGlEQGRkE8Qiu+qwSU7kJyhr
         Sg+vXac1pusOznZgjHUfBvGn+zZUKKuKK5Q60EO46TgCpgRw0T/QlCtFMtjPXKcEjNgQ
         SWKsxwxX8x87enP1nVk787U7WWlptSV35WOSSDhmvpsOXnWbv5LjSglfk2LjnPTSQ0c+
         lAJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780917372; x=1781522172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpXOMtv18jGR6tMgBi7Hb/icQLkWTrdf0TFaa3c8mys=;
        b=MKYZl3+5CiOoGYBpsR1hxWaPOLWyCsTouWdj7QYIchM5Ag2DROa9huOOOQx5l0B4pR
         YhMkFb5+9dbCSyLwOw4UCsClRsN67ppm2TNaH/c/HXlKQ+4oUIWmpI4u4t8xOZgeepEj
         ZHBarcUm2wU0fhO7WeEhx9kyP3Kgg0siQWyP0Pi1UKDujVfPuLRviL+eQvzDr6ymM5Pf
         kCEN54HFCtcYDUt6CF3GtxXxyGzdPoYxiE/mCMNzf12kiTyp/R1uUyVhdOtaOOyfO9Mf
         q3iCiRZkNof+PpV1QRtlJ3ISl8LoMKZOQayoQFDZzb2gtWGmlpc7zkwQ859hVvQhVEyU
         0ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917372; x=1781522172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpXOMtv18jGR6tMgBi7Hb/icQLkWTrdf0TFaa3c8mys=;
        b=Aatyf2QYButFctY46aYJ4xhpNYfHxTiUFy9kM6YtVUuNsTFyoLinT4ROFmZQTws3MV
         axyhDTuDNWuchR65ySOWePbhZEwNnvizhjA6CRqVCU/zvCC1YXY2nq8V47ZYr2onEkTP
         OkghOpHpXLtu20cH7bQOeNsnB2k+PQrwGpViS7wuVqfFanzCTwfNccWqlImdmz3DrBCc
         HNF/RzmuDexD7fBHm0Eq/USDD3Nb5vMclscwIksFAosMNw53Q0rE57LntulBGG1yfK7J
         sS4DoiLSdBO+RVjKUlFOk+4PzUr1Ezsnz2mqPFFSid+BVRoOi99GQwoAiVr8Bfa1QHlZ
         Ou6g==
X-Forwarded-Encrypted: i=1; AFNElJ8+d+6i67QOD37WaQSEXvJqjZZcTCC5y4GgkJNEH8hwdWdjUxqtV11wprApmFf7mk0Flsr6IbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP2G73xrCeFaTC6AGINgk5dzBk1vYhf0BGSv2xd2bgT+sKGUO
	YABZXWwp07EFeu7M6Asd9L5lHKzKgE5Tu2iXpi7h3ZFqhmJ37Fusl11pRvfLROoFMRhT5RAasXU
	jTyINyAaAAaK6uxhQ8zrRnVSameO00DU=
X-Gm-Gg: Acq92OF1gz8NFUAT50qWDbE4gsZTm2r80yS7YnDOwZG5GyE8xnnccZv6ypWvjJA+Xb1
	RawCGkL05CktxL2b9Rpi4H0hVXOgomMP1hB+48yMQBSPAxrGGO+2jRHxH5SMEBVmFa6w7ciwFKy
	T+PszKxe1UrYzIrEKAks0RXwvmzba8IrNNfAUMhklVr1cOi8JKfryZdw0BJKuiFLZcQtFQAauXM
	PutvRLFNq/GX31cUB8PeWd98+l8U1fn1HPQPydg3nTKbU5NVKcrequFDgUP7gitTQxII2mIkLLU
	LmMgdtw6itE134eIA3PlYmpViPinz+fhz2zejHdPdbsy/Esgyyg2KQtgyVX5dkqHTQkx8MwJutc
	5pq80HCG9KHALv9mgDaxPMejwuHNYeLNj8A==
X-Received: by 2002:a05:7300:72cc:b0:304:9b4b:3b9 with SMTP id
 5a478bee46e88-3077b2d94b2mr3980569eec.6.1780917371863; Mon, 08 Jun 2026
 04:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
 <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com> <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
In-Reply-To: <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jun 2026 13:15:58 +0200
X-Gm-Features: AVVi8CeG7lrWEuAGzb5zU-XBUP8cHQXmo8nVywRiXByIqS5bhxDHiQX-RA7AR3M
Message-ID: <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:ojeda@kernel.org,m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262017-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64B4D655A32

On Mon, Jun 8, 2026 at 12:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> I believe this bug slipped in during a small window but was fixed very
> quickly. Probably some fix never trickled to stable.

Yeah, as I mentioned above, I think commit a005fa5d7502 ("net/sched:
act_mirred: Fix blockcast recursion bypass leading to stack overflow")
is missing (at least).

I would suggest reviewing the entire chain to see what needs to be backport=
ed.

> If you can point me to the exact tree where this happens i can take a loo=
k.

This is the 6.12.y -rc tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
linux-6.12.y

The stable kernel team puts the link to the repository at the top of
the thread too:

  https://lore.kernel.org/stable/20260607095727.647295505@linuxfoundation.o=
rg/

> Still curious: So only the arm compiler catches this?

It likely gets caught by other arches too, i.e. I just happened to
catch it in my arm64 build.

This is Clang, not GCC, by the way.

I hope this helps!

Cheers,
Miguel


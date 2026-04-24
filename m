Return-Path: <stable+bounces-240579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMTGDOsq62k8JgAAu9opvQ
	(envelope-from <stable+bounces-240579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:33:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B178A45B89C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C251A3013866
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15731F9A0;
	Fri, 24 Apr 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey3CCYek"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B229ACF6
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019620; cv=pass; b=hN+C1PCUOM/VS/zS/42xzgnfpOpGJ2rPufhfEFM3f4RFfpOE+kfnohtZelvUN7itvfMG8i7m3FQ6pAKjmmUkn7rsAoMwCvPIGzMZIr0T/moy+HzOqGEHtiLvUdPFMl8uhNqMtY175b/gxX5BttB0EFU4CYpzE2PcBkKDygPDdzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019620; c=relaxed/simple;
	bh=o9Tc+LE2N3K3qGHeG1DTzY+Vz60zfABeiP7uGBhtwqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpmBMNYVz3g4IuY8bDYSAf/JkschnhCEFCKwNdeDvsEjezItWa7MLUzhyL8t9d1QYaJcosMEofEguViVL63DQaxKp1W57Czo9+CAS9wqGwLByzhTrgOzUPdpHejWupcr4rNqajZRHPzP4tzdUtBtvBmifuRiHnQniZaLEvKe6C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey3CCYek; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501c9903edso7780643d50.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019618; cv=none;
        d=google.com; s=arc-20240605;
        b=Lyq+SumBMdQyOpHffe2S1soTr98Kps7wsfXj6Yp9fMBJWGQRodDGDpHokAwVrvYKkm
         D/eDeokvQlH6vuAnD7eCA7waZiPM/SI5SrFtgSknvwh89HEb9855UWVsvPA7XJ1Dflnb
         dW0byvfzKqxNo7NO1RqsTGxvSXo/ptoztV1cIoU2jQ/jxDh8HJMMWnLG4O6kPeBz8VoM
         sprzJmYIZOhfHFmTNy0YUSf4jzbtOutC4OUY+KLJ5dvubP28mFsItiX2ohaNcI2H7sjZ
         54ojdJqBTZIDfKR56c4BExxKY13zDOykGNCNZXoLnlwlsCXtZPzN9TpWaKhU6D0Dbxxm
         tndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o9Tc+LE2N3K3qGHeG1DTzY+Vz60zfABeiP7uGBhtwqU=;
        fh=ks0HhFyUAK/U1QqvFbcWPbTDC7C/9uNX52Sj7hgD9Cw=;
        b=B9qrHzGoUEGoxKEKcepthfiTY87ytuqu5oeb8IbRQ3+/D8nvU3CjVBgmCKaLlaHtyg
         YJQjD2fxkXNXw3XGELJfVTxqbz3+4SdcJ3z9gAc1TRDMR2uYG1sgxPt8JUXRyJgXSfNR
         PwmbfB4+NWAloTbgF6AW+AfmCi2BrwdgQ1cuFcIzDpD9oneVkSAsUHnqxzZnOyH3tp8r
         f0m9+IzDLCxl38gYfJQrM8gYi0ysAV3YEOZHRh5tTN5HUsmU3UVbedt+41kFa3d5Ya3e
         eNXzeFPKqJaEqV3ewkU/S3rYrvbgg5XthcVqcHHM5s+Lcer2apHKG0EqxBLhqUlzIbXF
         D88A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019618; x=1777624418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9Tc+LE2N3K3qGHeG1DTzY+Vz60zfABeiP7uGBhtwqU=;
        b=ey3CCYekRpH5bjjgRGX8YooCu34ctgdZAgUSabkdNcSL+46TDBU6zVHsmX+6tqZR7p
         OaPYDJI6pD1XGctcqRScgyJWARzg1AsiOPgIph40yuxeGHI51Qm1iByKBHVmmvhVO/lU
         iAcu5yZhTqdCQEx2G5wAp2Kq1sj1iCRlgHdzOEN+tQwPLbknk9daksH36Ox+whP9wbgF
         y3j8vjPR2uvi6TOvtwuonCeo+tLMka7A90zEdQXUSzl0Ir2KTo045EXJh97W9dJx8/BZ
         T0A8HOr2OayS64eKMiIjTs8JCq59L1USFQKg6IAvA1LxOOJcC4X7cKLU5fBoJQBuHdJ3
         AgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019618; x=1777624418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9Tc+LE2N3K3qGHeG1DTzY+Vz60zfABeiP7uGBhtwqU=;
        b=o6mtWdzD9/zPQ5AmC2A3NdNoYTInM5Pt4uwBmR6lQClqhU1j4R2tuD4pRdOUO3CWAb
         ilyboYs7xhvw2v8P9iJdfyUmQW61MRXPfrCrZFUvvKUZAJrNmr0jAa2NhwvsTyOb/Bva
         1990D2MOUGzDNiSjKE16dyec2Q5j7yMWw3/dHFPx+P4icCaZOgi0KRtb+WeDJxEeTSeB
         jUR+Kpmsxy1TP4AtsuxXbIfM+SyN+DOAKb3omwXxrZ7K7+HwfGNq0laP79+L1hVqbje/
         jlSELJN7cv9QG77UMnA8W3YF04dgh2++CQcQL3hDZOxaMFF4Tcd1tePT+eptxlgBcr0N
         0mmg==
X-Forwarded-Encrypted: i=1; AFNElJ9aq+vK1ie5B4iAK5BSRQHK2bmgDEfIUse8xbpeBD8y3+xqUGuuD/n+uFk4cY+mwobcpUNxtg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS245HsPdNxUA1Zi0vzVfkXi/3A/lRrFyx1kt+PrBThpPbmvc7
	TDP+XUoL5sWjMERTDd5AM19ulB/bY89wWxjoz2+0Ut+WEUyW/KB2YYzhIqakTemiRhN73esTZ+5
	kq4y1Gq6ncp8YEWRhRzeh2GI2cuqa2jw=
X-Gm-Gg: AeBDiev/Y8jbdqL1E+rgs2j1q9PdyMaCE7+3Rhxs6BYyzVLUCLN1/vNF8s5Op55S3Gn
	h5USt/Gy75jf6P9p+Tob8r7AHvOejzP4gO4/ILY7eRYaF6f4uj7tq+6k1RocG5Xc6tHMW+A884d
	QW541bAwtWBE1WJ2LE/u0v77juvHPE+PcYEN0DxqLpGK2qaifpvG8EWjmwOmgucIzy9/O615wqr
	MuBa/PuTL82+y7lKldu+0cRZzslfRzifmAKe1Vt6kTCwMB4ngMsrX1FEY/jeowefknvL2pgjcHj
	+IOlRed/4MP0FKanZ8xv
X-Received: by 2002:a53:bf0b:0:b0:653:9e2:105b with SMTP id
 956f58d0204a3-65310863b78mr21753136d50.25.1777019617832; Fri, 24 Apr 2026
 01:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415175038.3633384-1-lgs201920130244@gmail.com>
 <CAOesGMghHi5bEcec9L6d1YUec0Cn5uEs8MrjdoT-zHSr-FJ8pQ@mail.gmail.com>
 <CANUHTR-XcTO4jy_TNe7tHcPPpVh_o_+-hgJtLBxN5MWupcvQ3A@mail.gmail.com> <CANUHTR-U+DDaWCKNUcNE2yScPkk6vVfnZ=GXpGtRt6SFYph_Ew@mail.gmail.com>
In-Reply-To: <CANUHTR-U+DDaWCKNUcNE2yScPkk6vVfnZ=GXpGtRt6SFYph_Ew@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:33:23 +0800
X-Gm-Features: AQROBzAGvtdaL5hCS8cZfjfvqw_W2IJgQzt_3ZfVldCokq1dpuv5P3O6ftcEQ-M
Message-ID: <CANUHTR-agWsWdZbjYUesvyp5OMqRrjbhg0zEbEgU67q8Br7b2w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device registration
To: Olof Johansson <olof@lixom.net>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B178A45B89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240579-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchew.org:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lixom.net:email]

Hi Olof, all,

Just to follow up: please disregard this patch.

On Thu, 16 Apr 2026 at 18:21, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> Hi Olof,
>
> Thanks.
>
> On Thu, 16 Apr 2026 at 17:26, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >
> > Hi Olof,
> >
> > Thanks for the review.
> >
> > On Thu, 16 Apr 2026 at 05:47, Olof Johansson <olof@lixom.net> wrote:
> > >
> > >
> > > This looks like slop to me. It doesn't even compile (there's no local
> > > 'ret' variable in the function already).
> >
> > You're right, I missed declaring the local ret variable in this
> > version, so it does not compile. Sorry for that mistake.
> >
> > > This is also a no-value fix, the chromeos_ramoops structure is static
> > > data and not dynamically allocated. Please don't burden maintainers
> > > with these kinds of "fixes".
> > >
> > >
> > > -Olof
> >
> > My reasoning was based on the implementation of
> > platform_device_register(): it calls device_initialize(), but if
> > platform_device_add() fails, platform_device_register() returns the
> > error directly without dropping the device reference initialized there.
> > Based on that, I thought the caller might need to release that
> > reference.
> >
> > That said, I understand your point that for this statically defined
> > chromeos_ramoops device this is not a useful fix.
> >
> > Thanks,
> > Guangshuo
>
> We are also discussing in another similar patch whether the
> better fix, if any, should be in the API/core code rather than in
> individual callers:
>
> https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/
>
> Thanks,
> Guangshuo

After re-checking it, chromeos_ramoops is a static platform_device and it
does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews. Also, as Olof noted, this version does not compile due
to the missing ret declaration.

I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li


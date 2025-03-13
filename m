Return-Path: <stable+bounces-124201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008FA5E90B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 01:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19933AAD42
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479263B9;
	Thu, 13 Mar 2025 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1PpxLhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8813AF2
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826553; cv=none; b=NCEHwzbrFQLiTkPezvPACpZ1Q0GSTBmj3AO92sVNY3tJVY4G+0X31fnHhZZjM6OQRmcs7Jl1Ru37rOmU3+1iQcqjNdPiu2/nlLAdJTahy0uweHwwr3yxCIZHpbwH/YNrQApCTiI3JAoUI9VMuMw/svjhIJnNpwQeVIPLBOMIO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826553; c=relaxed/simple;
	bh=ig288ShW6uf9Gfh2KEd67PQ2IpnjkJQ1Avi5bcKW4BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op3AMUhk4z8Ll6j8JLOrIuEsz/aDxOgLUUUmekZMMu1KPye7f2j9NRL4U1x/nIHRjh8AK1eHwXlwO1GNEr1tpMIDkv7pu44wlxbUkXqVpXlVbHIlNRsOCNQgr70hrywk2mDScsh2Gs/fFJwhnkVbu6h5zOJ5F/sr7ByFUYhxgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1PpxLhZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so464920e87.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741826548; x=1742431348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aokOw4JpMhMtQebNFKUI7JxGsy/Gt1nWUW1Lw1QEB/8=;
        b=L1PpxLhZK72q/Lttxw/Hh+onJcCWeljChhsm7E3P1MxiA6rnTiyH8AbLphoax9m67k
         2anuJaB6Tl6YiWe/q63ePsD+vpbcoLH6woEe0/YhBnpzfCW6vBGcG+f1u0jYpMyLRWfX
         nyxbV0HDSpISOFyL8bKbxMNz2c8bjh+8eOfgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741826548; x=1742431348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aokOw4JpMhMtQebNFKUI7JxGsy/Gt1nWUW1Lw1QEB/8=;
        b=lveqKNsq5+6KaTjj7E4BaRko+iOjK91GvViC8KCJWV2I2+2pKWftP6/zPxgeMxE2k2
         VlTsaYROZbF2q2o6y+1b7ONJ++FzukahCekHAL5F0Yhll8Jz5qpAPL/ZmHWFFB7chCTX
         LjCGRZSE/zisrFIoirGGTqIULOcI85cld7Bs/MBZERrX9hvvGnyuLRtW1MMu6O6zMXOi
         OZ2kQal22wgScMUjJHxCDMjSCteOqN7F+a57EFQUrFknPM/eTkO17bj/LwQywYawQTBu
         nvpfR0YrpO4sCSwRj/d9VCf+EFpdZ5xa2Rht8AtDmrVLZKSFGYz6j2nnlZQ4u/HMRKAM
         XPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDyVHnb/6GnZDD84fEZJ2SmimiyO99Q/jpMO7gFvA88Rj1tfrvZJzoy/oiMJ0e83tJC1QsKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYeme1DAE2fW/fMZN9mlVJHAToK0tSdCjhoDWJ3bBT+oimRpW
	ZEXiGlkCoAD9KMM6/F6xb/VXCpWhKYYjEXXpyXa1MEo2HeVNxSLdbrKIAEXZabuOIoRGTnxTD/b
	p6I/h
X-Gm-Gg: ASbGncs+cADWlOJAgrg+wnHusd1DNjPasxRRWJZ8/v3PtUKGhl5zszRa+mFNzxDbNSb
	cpAUzNCIkmaAXRe2uCNR7Dw3dg1hzH5J1eVg3L9g/TsvohAuNS3gqDhBGLXLueMhx7N/f035xdV
	46TnAVAe9hm6uWHNBH0FnlMgRmuydDC3SXf15J+s+jA2o1QIvAC2y5smy//6c7J2mAeEOcSmMyt
	EEUIBo8zWqez/cW01Ow9E1cXvUN9AcellCjRtVUzKZA7C2wCE+mLjSG2zHZU3IpD/wltWzNsoMn
	/gdRC4Tra2cOaJ14oF1zUFeoQF2oVQVHStpZ7cbIRPLyG4KkQL/MdyPKmoslaIw+InFDfhlzQ57
	G2JpsHB8T
X-Google-Smtp-Source: AGHT+IGHVYGbBaGP2BKeI3+br41kS88V9wlS9U1zhlPHVKW6+r9yXjUAPLUY8K1xsiLOKQtjDOKHaQ==
X-Received: by 2002:a05:6512:1112:b0:549:4f0e:8e28 with SMTP id 2adb3069b0e04-54990e5d374mr9440262e87.15.1741826548171;
        Wed, 12 Mar 2025 17:42:28 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c2b0asm35430e87.100.2025.03.12.17.42.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 17:42:26 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5497590ffbbso422883e87.1
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 17:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/Ep5Mka37FW0+Uz8k3u7LFmb400QpeDdSAuLrg4sQNcfBIfqxtkZF2n2XjnXNtQn10U8sQgk=@vger.kernel.org
X-Received: by 2002:a05:6512:1255:b0:545:f0a:bf50 with SMTP id
 2adb3069b0e04-549910b5d89mr8085069e87.35.1741826546215; Wed, 12 Mar 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311091803.31026-1-ceggers@arri.de>
In-Reply-To: <20250311091803.31026-1-ceggers@arri.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 17:42:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
X-Gm-Features: AQ5f1JqK--WuCFQMRsSDI8hPU1ACy47TUHjlGUN2x6HSPjgBp2xFsOB9wkyF5O8
Message-ID: <CAD=FV=UBUN+DERvSdZn67FUvyT+U_CNJs0HUdHooSZSK2F6Nsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: dummy: force synchronous probing
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Sometimes I get a NULL pointer dereference at boot time in kobject_get()
> with the following call stack:
>
> anatop_regulator_probe()
>  devm_regulator_register()
>   regulator_register()
>    regulator_resolve_supply()
>     kobject_get()
>
> By placing some extra BUG_ON() statements I could verify that this is
> raised because probing of the 'dummy' regulator driver is not completed
> ('dummy_regulator_rdev' is still NULL).
>
> In the JTAG debugger I can see that dummy_regulator_probe() and
> anatop_regulator_probe() can be run by different kernel threads
> (kworker/u4:*).  I haven't further investigated whether this can be
> changed or if there are other possibilities to force synchronization
> between these two probe routines.  On the other hand I don't expect much
> boot time penalty by probing the 'dummy' regulator synchronously.
>
> Cc: stable@vger.kernel.org
> Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for driver=
s that existed in 4.14")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> v2:
> - no changes
>
>  drivers/regulator/dummy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Not that it should really hurt, but do we need both commit
cfaf53cb472e ("regulator: check that dummy regulator has been probed
before using it") and this one? It seems like commit cfaf53cb472e
("regulator: check that dummy regulator has been probed before using
it") would be sufficient and we don't really need to force the
regulator to synchronous probing.

...not that I expect the dummy probing synchronously to be a big deal,
I just want to make sure I understand.

-Doug


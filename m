Return-Path: <stable+bounces-35695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF743896E6D
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA6CB268D7
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762401419A2;
	Wed,  3 Apr 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WyOvL+V0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E74134CCA
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144708; cv=none; b=Ggt4I2vH5s4lv1tXBITkqxd3yqrZnfZ36ZXQ5P8cJ3FoFDkOgwoUPmgRgFv2E1NTnGaaisaKoBcpPkTKGs7fmHfA+y9cdxkuMKfEqBDTudjWQYZRN+fAq+p7/Jq3rBr0j0NxDshytAGbFy69M+R4dYKjfBrihCA6F9CNUtfTBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144708; c=relaxed/simple;
	bh=Gc1iKz6G5cX2cf009vdjyCAbLt3LCgshtTEEHhXkJXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9vefRGwmBHwvX0RCYzCPSRU6/lZ2rs18ibMY/8I+aFESP8KAwGgOr7D2+SATXfqvsXWl6mt/II9FNSNdolEmVHl8YZpJv26V8bB4D8JnjrbdMXS8ovuEzRxsnYcPOH9e6O38VD8Ol4Y8u1OTqEXaW9z+QRfHtSL0Chl5MqZ5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WyOvL+V0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6154a1812ffso10796607b3.1
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712144705; x=1712749505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6ji7ukJRPmQhB2qcavC1ueRDs+bCKiR3kOICzSoFek=;
        b=WyOvL+V05YZng3aj8dUUYr205hxCyMXSL9WChycPaW/OezyVCQPqta2PTK64AqYm/F
         +Mza8cEFFQw2xc72cvnV1GvDfhu1dQQa53+5m2g9RxUeQGzTVpnDJ3MhbfF9nydD0iTp
         FvNAytibh6DFl0xXBznttEAPiYNUAZEELTroY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144705; x=1712749505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6ji7ukJRPmQhB2qcavC1ueRDs+bCKiR3kOICzSoFek=;
        b=hsrY4X/xYLlGgudcAdHf/LrjShAdCG9i/+s4GkRmB58VAWMuHeHaRPrK9VaHOnApKB
         0HTh6fOxy3bUMnq2PGT/TgbgLRyavwmABEvznCzqjTfXD7K4IafGxLoYWZwYcKh6AAHB
         PkjrZevpA2+jAtkbwD4TnrHahyPmPDHMzdnv07XVjggRK88LDLcrRjH1WpS+h/pfsGWM
         lv2gqJoVDyPVIBd5gCdGTW5EuXQBcVq2fHTUCQjprfw2zmTLOYAOvjcils68EYZQbc74
         F4FMzjo97dho34ZJSzATTzJXuEo0syqoTOT+yCEU0EAlB5WtEo/xkTPAOIisl11J6LdY
         20Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXx4Qr3BD7+xOvqp2vO6w7HPjLO6i4D8OvjLLvSN7kLGLWgrhJ5zsrig61JCzNsflV00H7iiKeY7aDnaqjTtxSllVW6l6GB
X-Gm-Message-State: AOJu0Yzl2BJS+55CDzbGJPePaC1u/KkcvNH5wCe+5gSpb3U9L6p751BP
	23s1XWWy1LzEFjx6OR5BsA4Lh7dm3A47xJ0AoPyGwdlogWyr9WegxQIiowY7aonJu/jbgI8HWyU
	1Poe3fCp9+xtS+ArhSyQEVevEdIXeSNAoxh4+AQkvZxbtMYFe/w==
X-Google-Smtp-Source: AGHT+IFKuYjWza+zXPjWPA5Q0rMCrbgx3HRhz5yHT+6Ft++wJj/e+mXelEtAPaLvU/P/29AJlfH7r0I4bvMQuFJPxtI=
X-Received: by 2002:a25:b84a:0:b0:dcd:65fa:ea06 with SMTP id
 b10-20020a25b84a000000b00dcd65faea06mr14285654ybm.24.1712144705293; Wed, 03
 Apr 2024 04:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402232813.2670131-1-zack.rusin@broadcom.com>
 <20240402232813.2670131-6-zack.rusin@broadcom.com> <20240403104246.6c94eea0.pekka.paalanen@collabora.com>
In-Reply-To: <20240403104246.6c94eea0.pekka.paalanen@collabora.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 3 Apr 2024 07:44:54 -0400
Message-ID: <CABQX2QPW83H5T9Gc5yT8a277tNgjEvC-xK6wDGewq+vQEYZ=2A@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/vmwgfx: Sort primary plane formats by order of preference
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	martin.krastev@broadcom.com, maaz.mombasawala@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:43=E2=80=AFAM Pekka Paalanen
<pekka.paalanen@collabora.com> wrote:
>
> On Tue,  2 Apr 2024 19:28:13 -0400
> Zack Rusin <zack.rusin@broadcom.com> wrote:
>
> > The table of primary plane formats wasn't sorted at all, leading to
> > applications picking our least desirable formats by defaults.
> >
> > Sort the primary plane formats according to our order of preference.
>
> This is good.
>
> > Fixes IGT's kms_atomic plane-invalid-params which assumes that the
> > preferred format is a 32bpp format.
>
> That sounds strange, why would IGT depend on preferred format being
> 32bpp?
>
> That must be an oversight. IGT cannot dictate the format that hardware
> must prefer. XRGB8888 is strongly suggested to be supported in general,
> but why also preferred?

I think it's just a side-effect of the pixman's assert that's failing:
https://cgit.freedesktop.org/drm/igt-gpu-tools/tree/lib/igt_fb.c#n4190
i.e. pixman assumes everything is 4 byte aligned.
I should have rephrased the message as "IGT assumes that the preferred
fb format is 4 byte aligned because our 16bpp formats are packed and
pixman can't convert them".

z


Return-Path: <stable+bounces-83492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613AA99AD20
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032301F22AB9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12721D0E2F;
	Fri, 11 Oct 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awnF2X1u"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1801D0DE2
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676550; cv=none; b=ea2gpE+a+/jOTqManjCgrxycUFZEgLztIq9VnNXKdzhdY+Wb+YLqnVal+omOpkY1oSbOXto9tzf2YRIJQjn5wYUpYf/zPt227cEuRGASyqt5fysCBkROi6oOV+tMH2IHvAgdepuN5dHizwYpv0FlBhiTKa/Ta+6aF/IsE4nd/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676550; c=relaxed/simple;
	bh=a5D6CRKK6FRSWd/adGyc0iCMDGRKCSw2V0dQAJdi94Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjwE8tLl8HnNPyopD5Goif0/bxr4aVQT8sHlETc2M1lUNMuGR7a0QpXDkZJo21X/YpK0KuVw/b5tlr/kCpkvo2FDTZTaUzMcWQJn5MmTQXgQVkOsb1jcMVvQefaJKqP6rEIu2xzOLnWB9FOZZ8LBI9kD5ejPibAoDHfxpxdckRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awnF2X1u; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2346f164cso21246737b3.3
        for <stable@vger.kernel.org>; Fri, 11 Oct 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676548; x=1729281348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkBoPVksNssq3kk3PRQvLrV5w199+kZDVbn+dDVtSPE=;
        b=awnF2X1u+JGwPCfYeQaZfeTDKaUYR3fh61rrprJM9QiweC9+dsMVCOFoVDjvs0DGX9
         Evai97b86I+IM+lRYGckAzIgyH1aWiHIiJ54snKQ8kNU5yDOjzcWyWeC0GqL7jVHbBgs
         tC7SHh2OqiAnSo/WWfXJUHKCanJmkJW/eQrXightxqbWm6ZCvFGPcYUGSN9yUl0BGA7p
         T3d5Vb0mkEIiGscz2YLm92RhuEaGzs7EHsdNu5DKrTMHl6CcB2+Fi75tzBD0TTwxHv0S
         GH+RIwd6KCMa7BEulMKO4I16X19sqKRZb/Ax5yXiFIoN+McS0+jaAMj+Y+ZlKNLsGR98
         gQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676548; x=1729281348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkBoPVksNssq3kk3PRQvLrV5w199+kZDVbn+dDVtSPE=;
        b=V+Y/xlS6oBcU/PQ61KF7B4e+PnRuDOtGJpc+ZorjdJJbXxYeFWpEks6uDN3aoI9ViV
         KK0+BT9xDtyCHOW+6SY+UfqVCZQh6wQRgrPY0wXmJahiNYjymjY9aZlPi2VwKM1VcMA4
         s2GN/XG55CgXQX9DaLD12Uun+skYerdOtMtru8oZ81HUSQn+7eGm9GQ3oFVix+4ksM5x
         KYlgC4CpVE39UNwW9z7Vwy9GdtKi8bJjLj9bOnR+3eSe+zlJoGilASt1O7TrbXpieQqj
         Zbql1GKCVSt1iG52zLz7sHcPX08Bg7Oa12k3t/2kMotiEtoD9+hQ5tt3bJDNNfpn0y2f
         UE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm2rnFwNM/vd1deZhC1iLZ1Vv8Z+LR2MgojkVKYaLTWjk6PJD+xQt7VE27k/0PTF6CrpaGdKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7hYmKv4K+g41RDExWXJokM6ppFl8aLpYPde5xPq9O1S83VU7
	V7GjFliHjwpp2/hFAoqC1nS0Jtca8FB3oteCiIijY7b37SrdaDlOtGwhy9MRgC4KTX9jBsRVl56
	fWQP5J0vqEHsaMkDoUPzyyxNhJTZuS2LMljq41A==
X-Google-Smtp-Source: AGHT+IEm/NZLoO0B4BF4b0vFgq+5uRsH3TsYvJLQRrk7Qkb93mKDfqxwigJ4J2wXtENbFFnnkwnUAWOGHOtZzCq2V6I=
X-Received: by 2002:a05:690c:ecb:b0:6e2:ad08:490e with SMTP id
 00721157ae682-6e3477c014bmr38960987b3.5.1728676547975; Fri, 11 Oct 2024
 12:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205237.1245318-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241010205237.1245318-1-harshit.m.mogalapalli@oracle.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:55:36 +0200
Message-ID: <CACRpkdYy9JL_tE=N1=4aK7JG82usxGN6eteTxsopTbFsU0Vh_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: christophe.jaillet@wanadoo.fr, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, error27@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:52=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:

> 'new_map' is allocated using devm_* which takes care of freeing the
> allocated data on device removal, call to
>
>         .dt_free_map =3D pinconf_generic_dt_free_map
>
> double frees the map as pinconf_generic_dt_free_map() calls
> pinctrl_utils_free_map().
>
> Fix this by using kcalloc() instead of auto-managed devm_kcalloc().
>
> Cc: stable@vger.kernel.org
> Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO drive=
r")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Patch applied for fixes.

Yours,
Linus Walleij


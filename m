Return-Path: <stable+bounces-50089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C436490237F
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6248828A1E2
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5612FF91;
	Mon, 10 Jun 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgnpbD3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794A148841;
	Mon, 10 Jun 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028189; cv=none; b=rXjdBETP1gt9whex9DIwdrfcv3sr3jBxoY08jMhObDayzx3cDpxj8xdMpLOiP6uGAsyUtF41JkIt3ZCfYBYZb78M0HAtyekMkJNXFYhPytnWW6Q3SuMZXwmWLukOY9EIyK3mQuoIYfO/W/LDDoAPTdujVlf2E6wZvle6s3qRZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028189; c=relaxed/simple;
	bh=vs+RdkwtIQLASJx6uSQRNm6oe/+uQlNUtvN9mBaJLRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpjflRJRRjzjl/bvwjDO+Hf97Pm3SJHvrXtxhmgiodmOzCCffQ/9iVnqIyvEX07BQcMP7ZV6da33GoiCRqNLXsrqLSQegsZD5DkDfrrfoCCTTXQy6rlcC1rOXfYNnKe34r5SpiESRp2sZhzvGKPjoGv7VmhFg/8xw3j8UDmkRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgnpbD3S; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eae5b2ddd8so24598631fa.0;
        Mon, 10 Jun 2024 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718028186; x=1718632986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs+RdkwtIQLASJx6uSQRNm6oe/+uQlNUtvN9mBaJLRA=;
        b=LgnpbD3S+rukRUGHzlRA52YkqFy15BJ/f10G0nyXPfx+dm1azR81epSHlXrH3wKp1P
         LZgQ5dcsRohcuH28uKPAPd81FI+2eSbgykHfSqOHOCebwFbPyUI8wdIUu4utHe1l1XNU
         gRPuPmcXZcbeLmLWlVaG1iyXUVlsyb2D6thdKpsbsKnVRCX7Ll/2Dd5qo+xh7zO9Jhg9
         W6qJ1B2TdKYs+KDlt2golX2Y9wE0oN+v699JCsapl1S37lEvxjW4TZkmsH5+VA62C41g
         oSXmSO2A41Z/E6J8DizS21w/gA65/Dtqm6Xu0bvZE5R9qA3yVh2iNVCD7TSMGgKSkAho
         8QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028186; x=1718632986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs+RdkwtIQLASJx6uSQRNm6oe/+uQlNUtvN9mBaJLRA=;
        b=BktqSeAiXegJDixvxMcnssvFvJwmkcGm9L1ai4faYlq2vtIDu8NgpmoH53PTmp+ToC
         JPY0XLYSCVpZk1/USCcoAhXqvitAcR8p4x8OALp/wnHKlzGPpLWKeC0XzgvtCTEDzruW
         1Y/rLeQ7m9N+coqDxyjEVpCRuUwRGiWDJkTMS5tDnjVL+jjDahbRxkEZqaFJCAReUBi1
         RiTF0hNDMqCt2cx7C31TKpdJ1c4m1TBXSaMNenk68yigqHbZzfw8PFvAK7rqHTU/CKWS
         35cDjeLJNWYxBtvXSaD3xb4SkMebw6nrHYz5VH24KpsV3YLPWP0Ds+kp3gNIzCG8aWQP
         L/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWuuHgGP1R/FIrI0mkFBcoxBLvnkeMwMwbY76eDH5RFRvvJlBqgeTJctsfCeazLAbqb3/0TQakwwy348mRwrc4+ddcBvGJk2VWSd6ozvT+ZKJC8gDfv3TQvUb30hVokjAlNyJsCqnWx
X-Gm-Message-State: AOJu0Yw0wg+yQMVioa79kWL+PIQ41XPtXeg5gKSducBfdYtbgUQt7m00
	JOhzy0YfhOxBVlk7ZmJLODP8P3GMKg9uc7Ig24iGhdfg7gbH7orissMTyenmwp/MEVHEK+Sa3ki
	CMmtCqeItYmMW2uTPe/KP+Kjynqg=
X-Google-Smtp-Source: AGHT+IEyVtLS1ZtDhsBER19IZggAVJyeuIf55Qo2irey9UJcbDThkM+mxsYGcrRvwbFhbmMl7Pp4GQE8WMd0fybY3xA=
X-Received: by 2002:a05:651c:1546:b0:2eb:ec23:fe6 with SMTP id
 38308e7fff4ca-2ebec23103emr6495311fa.11.1718028185344; Mon, 10 Jun 2024
 07:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org> <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
 <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org> <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
 <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org> <fc035bd7-c9e3-458f-b419-f4ac50322d02@163.com>
 <caa701f8-0d2d-4052-9e55-2b755b172c56@163.com> <eca0655a-260e-45d3-bb4d-7de6519ac148@linaro.org>
In-Reply-To: <eca0655a-260e-45d3-bb4d-7de6519ac148@linaro.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Jun 2024 10:02:52 -0400
Message-ID: <CABBYNZKx15mrTgvE6bSvxn6YVv=jJKj7jHu1UXVFrtvffHQa9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lk Sii <lk_sii@163.com>, Zijun Hu <quic_zijuhu@quicinc.com>, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	regressions@lists.linux.dev, pmenzel@molgen.mpg.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Jun 10, 2024 at 9:24=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/06/2024 15:17, Lk Sii wrote:
> >>>>> Why Zijun cannot provide answer on which kernel was it tested? Why =
the
> >>>>> hardware cannot be mentioned?
> >>>>>
> >>>> i believe zijun never perform any tests for these two issues as
> >>>> explained above.
> >>>
> >>> yeah, and that was worrying me.
> >>>
> >> Only RB5 has QCA6390 *embedded* among DTS of mainline kernel, but we
> >> can't have a RB5 to test.
> >>
> >> Don't worry about due to below points:
> >> 1) Reporter have tested it with her machine
> >> 2) issue B and relevant fix is obvious after discussion.
> >>
> > I believe we have had too much discussion for this simple change.
> > @Krzysztof
> > do you have any other concerns?
>
> No, nothing from me.

Ok, but I guess since you didn't sign off that means you are still
unconvinced that this should be applied? I could try pushing it to
bluetooth-next to check if it blows up on the next merge window, but
it is not that nice to have things completely untested, as far
upstream goes, being pushed that way.

--=20
Luiz Augusto von Dentz


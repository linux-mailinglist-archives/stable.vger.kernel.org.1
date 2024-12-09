Return-Path: <stable+bounces-100118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADB9E8F89
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FFC161CC7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4F21570B;
	Mon,  9 Dec 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIZWq4iM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82B215066
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738418; cv=none; b=FoZAygV1I9lZO48Z0+JhqjHIVHTT1Q7+U7UrXR4UUI5Jr3mp9CfQNTeLUUJvp3S4RhygtnaGk5N7nggWgYlya3NVEodbl+AL3AxUCU6s/ZwYGaLwYnoyPFMZPYbnMhlHELizrqfouZNSR/xLJxr7g08JMCvOoYL1jdpORQQJino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738418; c=relaxed/simple;
	bh=9S1OgwK5FtDALXZaBtPeWSCifcuG4huzgVs3mX6EYro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuC9hdEOFjwPT/LqgU0kV+e4tMpFsPcWKXkNB6UzWeyfIIA5HIIkUt7ndK2zRV83INnC2q1ihhHHbgSBZAIB8njPpZajht0770+WeHTLdTJ8UaSw4o/wHmbQP6aOHrd5vzr+Ehir/5N7SDaEQD6p/wjd0+heCT+A7LYKnLyUP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sIZWq4iM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e397269c68fso3935991276.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738416; x=1734343216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaKxBgaq02X8de3kQjZpaBJzI71CtFoxfGULZINgpO0=;
        b=sIZWq4iMuY3qqVnov5zv/W/cXZRPYwbthhusAw3rmTPgtWCduZ8fTFGmcY/MGU4EqS
         0uqm6VsQLlKOP2OYZHK9NJK/uuLjPUWsxnAdwk0siOU966DDZDc9RPXsycQ+/k2uwe9g
         YURWfDjmI5ReeoEhHT/q0hwQ4Ps0q/aZ7A5brCsvj9yO0UUybxjH9U9357hqrM7HYPRX
         +YY1ITRxxs1qxxIXSU2hd7Ryde1lh1EBhMy361V/hZzmlmN7Tc5wf6p2sN6y1zfXpf6Y
         DNvv1vqMMU2oj8l35wg5c0h6aBRB6JIIxED55TU9h84dLd6TgmG2+LYL56H9wXjvWHR3
         sCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738416; x=1734343216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaKxBgaq02X8de3kQjZpaBJzI71CtFoxfGULZINgpO0=;
        b=LMK6ZxaHmQFXUYNPxTTeQYyFGdSb7kNLYk9FrOoqylMLNJOM/TSplb8gzZFXpO8160
         kwZ/0HbL91/ZdMZSRmaDX/JTcOEb7UuQES2V10/X/KQXkUbS/8EiGB83I/FLOTk+vJ8o
         WaoL/DhQBbPwR/tl/B3k0w0POinw+ZsJDrCOImNpJXpaxTKU+iduTzl8O7hAUIcj3KZw
         An/JvtD6t/k6DrL2b+Rpv0jsHyTJ55WVhtZd2yg2MlHjtRlhUs+wsHoAGJA45eQ80aps
         brQkJvLRqMMcqIxrC0f+WH2Lpr0dWZ3LD49AU08OIY2cIhwTErvUhk7TCMUukf2u1wdt
         fgwA==
X-Forwarded-Encrypted: i=1; AJvYcCXV5C92jWLDT/Z5SyGBlfuUWhWgq5ynuthxObxBFhXgdUNd1Exfuo9ekZ+/SuijNW1mr6UHG4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUBgguOcOICHNQGgg2dVL5EnAXId8ZhV02Zvtip7nCI84XP4i
	J9kgvqmDwKzJn005qR5Zhh8TrI5RQIwyx39AVoWyto0d79HJO1M2gY6YI7vzKcgVFiT8D1kSGKu
	A6cQrtUCvDDPpIr12kpd/9yegVB3uuL8LHe3gLw==
X-Gm-Gg: ASbGncv4Aar0OXbc07quJFaeSPwc+7myqmiuUbLW4setXrNPN1gAgoocPCgxcxs0nO/
	g59ph2ZbFX/6RNsnZCmzTpLR83BTHYWI=
X-Google-Smtp-Source: AGHT+IH+mgmmr4qqUrNvXi89RebxgrqqEnj6NinYEcPLT9jjbWocaOUTk5gkEpMuQlwCgNRcU7QqZkyyvUYXic93/so=
X-Received: by 2002:a05:6902:250e:b0:e39:b0de:fed8 with SMTP id
 3f1490d57ef6-e3a0b0ca18amr10550531276.17.1733738415719; Mon, 09 Dec 2024
 02:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208-dpu-fix-wb-v3-1-a1de69ce4a1b@linaro.org> <Z1a3jOB8CutzRZud@hovoldconsulting.com>
In-Reply-To: <Z1a3jOB8CutzRZud@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Dec 2024 12:00:07 +0200
Message-ID: <CAA8EJprxosWNWojXWAzkM5eeNXewpT1hpBxCq3irmkuGf==b+w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dpu1: don't choke on disabling the writeback connector
To: Johan Hovold <johan@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Leonard Lausen <leonard@lausen.nl>, =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 at 11:25, Johan Hovold <johan@kernel.org> wrote:
>
> Dmitry,
>
> Looks like you just silently ignored my reviewed feedback, yet included
> my conditional reviewed-by tag. Repeating below.

Excuse me. I'll expand the commit message.

>
> On Sun, Dec 08, 2024 at 07:29:11PM +0200, Dmitry Baryshkov wrote:
> > During suspend/resume process all connectors are explicitly disabled an=
d
> > then reenabled. However resume fails because of the connector_status ch=
eck:
> >
> > [ 1185.831970] [dpu error]connector not connected 3
>
> Please also include the follow-on resume error. I'm seeing:
>
>         [dpu error]connector not connected 3
>         [drm:drm_mode_config_helper_resume [drm_kms_helper]] *ERROR* Fail=
ed to resume (-22)
>
> and say something about that this can prevent *displays* from being
> enabled on resume in *some* setups (preferably with an explanation why
> if you have one).
>
> > It doesn't make sense to check for the Writeback connected status (and
> > other drivers don't perform such check), so drop the check.
> >
> > Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu=
_writeback.c")
>
> I noticed that the implementation had this status check also before
> 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to
> dpu_writeback.c").
>
> Why did this not cause any trouble back then? Or is this not the right
> Fixes tag?

If I remember correctly, the encoder's atomic_check() is called only
if the corresponding connector is a part of the new state, if there is
a connected CRTC, etc, while the connector's atomic_check() is called
both for old and new connectors.

>
> > Cc: stable@vger.kernel.org
> > Reported-by: Leonard Lausen <leonard@lausen.nl>
> > Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
>
> Please include mine an Gy=C3=B6rgy's reports here too.
>
> Since this has dragged on for many months now, more people have run into
> this issue and have reported this to you. Giving them credit for this is
> the least you can do especially since you failed to include the
> corresponding details about how this manifests itself to users in the
> commit message:
>
> Reported-by: Gy=C3=B6rgy Kurucz <me@kuruczgy.com>
> Link: https://lore.kernel.org/all/b70a4d1d-f98f-4169-942c-cb9006a42b40@ku=
ruczgy.com/
>
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Link: https://lore.kernel.org/all/ZzyYI8KkWK36FfXf@hovoldconsulting.com/
>
> > Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
> > Tested-by: Gy=C3=B6rgy Kurucz <me@kuruczgy.com>
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Leonard Lausen reported an issue with suspend/resume of the sc7180
> > devices. Fix the WB atomic check, which caused the issue.
> > ---
> > Changes in v3:
> > - Rebased on top of msm-fixes
> > - Link to v2: https://lore.kernel.org/r/20240802-dpu-fix-wb-v2-0-7eac9e=
b8e895@linaro.org
>
> Johan



--=20
With best wishes
Dmitry


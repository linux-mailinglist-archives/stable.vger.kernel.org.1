Return-Path: <stable+bounces-184131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E488BD1D7D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2913189891A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE82E92CF;
	Mon, 13 Oct 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ANlcgSHq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE82E8DFE
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341134; cv=none; b=S+em4PS74tzbYCs/z+3TJWvnO0ieu2+tQy/h5/6DGGn2TPKpjymyvA2Y1Dew4JpB885T06J8WSjgzRSVYLOS0b3WWHmHRIMuyQL9ToYpLOkcA1zMSy6IAyl9RsW2KBfkJkW8vTMhrHFlY/wXtv2rUnmCO1oz6mu6ThTy65nzmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341134; c=relaxed/simple;
	bh=0V8PfmZdZyMxHtBlNj7oxiC8OqLCKtw9cHPtF6pTnjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUvwtYxMmiiwYrQtkJZxxgQ5jID7taxgKche+iKDYZuagoNbpky9jFKjp8lbRAYmuzldZWe+RAtND3A8Us16IgRMBAg4x21LJPX51LCv8XeYnadaAwoeZyt9rRZ7src3wJCea7behTiS3bosAVbtjE9QgtvQSOLcUQCuqX8+pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ANlcgSHq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57f1b88354eso4367410e87.1
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760341130; x=1760945930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh0aPuvGeNTzxXzRDY7y9lNqdQtLzxXRDZneOoTKZK0=;
        b=ANlcgSHqMXJvKAAYOtyxYfh+bG5TGGqa4Ll5G1j3q6MGbPbnu3NHz24WSPdSpj01Ov
         fxTh/f99KstXb5M8h6Uu8qtIW6ZPTGaRouf6xLjYHK2zbpkhkudKNpgEVApB1SevMbnj
         zfE5eFdBrOjJgbhd5EIN+v/GqxJu1iA1SZ/2WOFPBE111YfEqHsKwFWTQH3tyXIJbzZZ
         cPsHtjJuWeAeMvndnraQ01zAAEIyPsyc8dOAOq/UN/VXGATFF8a6NTW3buVkLZ0OVKLW
         M+nUvkO29Re0mrHvpgQsQ/Aqv1J/j1KGm8XyaajfwyJxHxpvveEHVWDgkD1/yooEDHxB
         Y1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341130; x=1760945930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh0aPuvGeNTzxXzRDY7y9lNqdQtLzxXRDZneOoTKZK0=;
        b=bCltxQfYIy/WuArsFXiI6ylUcfngKotw++5DfChDHBbb4UTlag2Xn0+MGcIi4JLBIb
         9BzqPo2x3ynXCw8h2as2nlwD0FgjSFc7X1oll60mIOYPBPQVuhZ2mNqrh0oA28BiN8U0
         C0rU+PKt9aS80Y8qg+2rqiIWpteJRLZNTI4R/Oh6Pp3DVuUTFXSuD2lW23CMKgBqTeI8
         vDPQMun+lUF69LsGV693b7ea8fyEosG0RXSRhkNnCfb9QE3Dno4osx7br/VxgJtBIAtw
         +ZD82JRMtrQ0XVZILGE5+L9bHZ1bajq0efu6SNFrwXesG6R2IoYUV596CvpFLREnbQJS
         rCVg==
X-Gm-Message-State: AOJu0YzBp/VOK33SnNcShbIYy9sJuLixybcwhDIO028Kg85/zzct0PUX
	6eFn+o+73f2ghWKHVrpmLeW+vS6lOlaUXeH0WqHO/sOzPqlYo9Dlk+ex4VEanMJUghGWbTdFxVw
	h+YqIYKjF0k/mj29QK5/uK6SdgGQq/tdSMYA1oSzYsnlsyUZea9GNsKo=
X-Gm-Gg: ASbGncssCcGSA/J9rlAfgwpV/Gm9ond/ultDFp7g6yxfMIcBfTT8US2sJsUM+IErAuZ
	rvJ0b3PmpLkKAkQ88HAOGGQAVvuc3HEtpkHsPnL9q6R7uBaQoGatmJbMlsrjnJtpEzOHjtL7Hlt
	9baGvTnjPwZAkeTTP4qn3I5IHMPHJ6NPan6teFJvmajm5duDcgu6rbuenkd84t2Doeycq7crqc3
	10afiwlf3KKAQPaxyHHZrg9+DMWQZn/VyBMP81DEKcVk+LSyuUszKxy8Q==
X-Google-Smtp-Source: AGHT+IGHo/XFL0Gxq8DbhgEib8BfOl7YFHi+224FmOnzS6czbWaTNb5zwqB0TnJlZCxQjrvqb//iLKxJ0pQzWkRIyiw=
X-Received: by 2002:a05:6512:e8d:b0:57a:310:66a8 with SMTP id
 2adb3069b0e04-5906dc0be18mr5417639e87.55.1760341129484; Mon, 13 Oct 2025
 00:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012135727.2876348-1-sashal@kernel.org>
In-Reply-To: <20251012135727.2876348-1-sashal@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 13 Oct 2025 09:38:37 +0200
X-Gm-Features: AS18NWBDLCxM9o-5WhOZN9bCwAOSMOJTKCNTKyjjs_s0-B-PANrSDRcAmHBMiCI
Message-ID: <CAMRc=MeD1FgCxEwSUgOJythtKU2R=6OZ0vJg0_rjhdJOneW+5w@mail.gmail.com>
Subject: Re: Patch "gpio: TODO: remove the task for converting to the new line
 setters" has been added to the 6.17-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, geert+renesas@glider.be, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 3:57=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     gpio: TODO: remove the task for converting to the new line setters
>
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      gpio-todo-remove-the-task-for-converting-to-the-new-.patch
> and it can be found in the queue-6.17 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

As per commit message: this is neither a fix nor even a new feature,
this is just a change in the TODO file. Please drop it, this has no
place in stable branches.

Bart


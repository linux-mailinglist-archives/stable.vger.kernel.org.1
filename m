Return-Path: <stable+bounces-87675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E09A9B08
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB011F23491
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5C14D2BD;
	Tue, 22 Oct 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tbehmfhi"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8313B79F
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582231; cv=none; b=jStIF8gRwR45PrcyZoTB1O5edGUqAKVD0ajnPsVwkNmydfPdcgVOrifEGTrwfanusKxEXnXKj8xOwAxjgPNCMApROKLtdc2V0cxn41nOp+zewNIAn+dMgbYASsAiU+7iJn8psvAjXNJBEhrAe8Gks4EdbehdfW9y0yZC+cNy8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582231; c=relaxed/simple;
	bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5soGW1pmQ0rZMB/NMmsYwABMxRLJdFcIxoyfBHtuNWch/ukpkCOV94qGhcodpS7eQvA9GnwnL9KlbAgdvy+AFZWCsjAMkCw12KUXWd3HyV+orEojgIu9bOmvgXVsTUTereWSJ2sxziOIKGUAvNLAols7hRB5G3C3dr21oSaFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tbehmfhi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539983beb19so5860624e87.3
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729582228; x=1730187028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=tbehmfhiq8xGkwApxzC2ZCqTdI5cdhsh4MgyS0QGSJcVffr2ou6Y+NuEbEuw0NLQBz
         P+BkmVP/kdMoHjAbavcOWCcitX22Gsq5rYTBlYCq5ArR2LHHgbOX9HdUaYiuPbWgYwyY
         HX5zCs5/W1j8IWjI3Fu2eyMhK1couCOcGp3hAvFzSHCvjH+wUkbp3QbPCNz4gcIDeg+M
         JtrkmzpQZizHmzIHn59VycoeskpI+lCQSrFNW5giWOHF4DyjnP436wecb6IWEtiDR1bY
         09yjq9F0sgl54dWsQlXHqMUpObD6sN0S7rtkwdGhl3Bcwa8VF9S9QPeeCdkSEFOksou4
         DGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582228; x=1730187028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=tB68KU0zADsxVGmGAI/OEz/0OeF/NaOfJAcwCa7l5jERXTDvtzYRp056Op1t84/o4f
         2IhNI2iMr/s/igDX5liC3Ul8uJpfmfN89822y11Mi8KxRt9p+QEPPDWUzg1A4qY5iFEd
         8yC8Rxx7C1hFV/vHLwcQvmxnloLMoe1PJ3EH+wxDOAbkD3LGmqyes2LYDNtk5DP9bldY
         3x+naFaUIc57TvAC0DNe7TUcTYT2qOPwcpeU2v4FvHdESgxQuJ6/Xrk9t8owXpLaDn3x
         b1ORtvfRJXclO1Lfc9t8skVJ973PVJTwcfOEFImfYihz+sNdusNQIji0CM2GT/vKcWPq
         ngXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdZbHeVt9hXrUq6bUQqWHdYFRmW1/eSyrWs/fQRg+1nlRynuG9r1eKI/FHAP+NABJXoFcInIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGpq0jcBYlg6Klggt4aFpw/gXAp83qY7kRnmbkTSh1mxTzw6s
	U6j8NkP0TGOxmV9s3hUNw4uMYGE+jiIOJjdcVaev2HDTzV6xBzQXYvUMbVhleTb+XjO2d4woJKh
	wrXSlGUHjDBp5kE7hGlmYMtOK8Opim6+hM0NbIw==
X-Google-Smtp-Source: AGHT+IF49dZCMKViDbxpV2eKhiIHV1RDGA68wUouph+dlIMJN4RYm70o7grRVK5xXCDp2yY2Ikg40KfZMweGVngtB7k=
X-Received: by 2002:a05:6512:682:b0:539:89f7:3187 with SMTP id
 2adb3069b0e04-53b13a23dbcmr717950e87.47.1729582227670; Tue, 22 Oct 2024
 00:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl> <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
In-Reply-To: <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Oct 2024 09:30:16 +0200
Message-ID: <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
>
> Perhaps, if you elaborate on how 'remainder' can become > 999?
>

Yeah, I guess it can't. Not sure what we do about such false
positives, do we have some common way to suppress them?

Bart


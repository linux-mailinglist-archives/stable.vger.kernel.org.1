Return-Path: <stable+bounces-28644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC419887686
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 03:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622051F22DA2
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FCA1113;
	Sat, 23 Mar 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrO3NjeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB4A55
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159246; cv=none; b=XKljLqHT+eF3JPF9blNqB3RY8+OWhXWU7H6WiqThBj7DPxQEGzs2a1D4P9TwUcOu+lHe1ZneGqZM60gdyVeHnQjbD1Uxoz0kxsN5HB1x0WxZAYaSYaYkOnzXGuJPJNM+8Ubbu8V0OreKVreoiihcWc35sj1G2bdYfkuUbplnUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159246; c=relaxed/simple;
	bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZVu1nd/3biECcIRn6iYDZDYaxT2bKISEBb+glMSDNsbiJaSdB7wtOuFHnq0cVh/hq/ZdmP+Mh6+l8ogqr+q8KI85jBswLL8ME6ipL6PEtmHRiG+YBUznrmSTTbK6N3obFEe+/z3LYe2LTImMN2Q/EX6nd8kYZ3d1c1LeYabceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrO3NjeB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ee0c326e8so67811cf.0
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711159243; x=1711764043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
        b=FrO3NjeB1p3HNQ7n3aAwsjvbCZYdBqLycBLD1KhKgeBahgxAdugvWqpKS0O16MFlBE
         m5TA6QyHm7dzZ9+abrCQjRWy+wDOOUCUpxoujnCkxhDbo/rMecG6bNLYihZWErrah9t4
         frSTx2wt6393IX/JZWngN78P0cCGJmY+GRXUuADHYqZKIUPiabLUyk+lwG4Rmy1xPF8h
         y/YFeV9zsJo9eAI4DjlGmYYY7x16urD2Q5HtvStYAPI8egl4FFScYRdE+A6q7m2+0FTf
         +3CKkwU7dl2Wqx9jghR0vMLkmIJxf8cZNRLzlCWMsRTfYkoeEZSpLg9+jzABoTtbQaLJ
         jEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159243; x=1711764043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
        b=tkBxpZTvehXnuwTqNQFfrtgJLS5hC7wSuLyqL4eUjGWGGkEDgNiIdZcdzJssHORrNS
         855qCiMB3+8euPuXfMj17UaOOKD+PP/l8jXZq7UP06A/huFbOIqMusVrsCqG/RafxtQK
         0H3Gfg8Ln1Oda3UJX5pdbDob6cBztQIi+ZWkD5e/Q9/fuQEqHBNr83KXbgBOnj/lZT5k
         8LuGJkBHNzRaWkxvOCVTnjNxfPCP47Mh2Ebg/4ICpUBsUEM0NcdGY5PqNDTvlzs/Dhoz
         XVPdUBEvmNgnGF5fPrfIZPGHDZrws3rGz7D3CmaXoI3APEzB6xINP8G0MMjdz6gczT9n
         iqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUSg8/WFGcPmeveOGICBOFCo4UKxSJYQExkkLsE7vjx+ytVGqiPhRy0fBuutnsNrq0n2hanqnme23d8ofYeKKVFx/mZ1urD
X-Gm-Message-State: AOJu0YzhmtneM8GEE3PPvfGEjC+d68Rz2uYlB7IOKflCFLH2rdhSgOcW
	XJ1A4HDP0ldprJnh/K2j2HCH9H/5CwZBB2sEPoOmfH6EoTjigfXXmBDundcNKr3yD+ZCjcQ0xLz
	HOwHwrYRxGhFh+824MATlyFnzri+bOCWDhmBp
X-Google-Smtp-Source: AGHT+IHEu5RsydW1nGrf112JXAAobeSfXYgjaT18QBQKEPz/AjPpVseTu9jTurdFvMxJjea4j9qTo3T86+aT+MmmskM=
X-Received: by 2002:a05:622a:5cb:b0:430:ed37:bad0 with SMTP id
 d11-20020a05622a05cb00b00430ed37bad0mr663579qtb.13.1711159243461; Fri, 22 Mar
 2024 19:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111044.133776-1-herve.codina@bootlin.com>
 <20240220111044.133776-3-herve.codina@bootlin.com> <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
 <20240221095137.616d2aaa@bootlin.com> <CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
 <20240321125904.3ed99eb5@bootlin.com>
In-Reply-To: <20240321125904.3ed99eb5@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 22 Mar 2024 19:00:03 -0700
Message-ID: <CAGETcx-oMbjtgW-sqzP6GPuM9BwgQrYJawpui3QMf1A-ETHpvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when
 created from phandles
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:59=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Saravana,
>
> On Mon, 4 Mar 2024 23:14:13 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> ...
> >
> > Thanks for the example. Let me think about this a bit on how we could
> > fix this and get back to you.
> >
> > Please do ping me if I don't get back in a week or two.
> >
>
> This is my ping.
> Do you move forward ?

Thanks for the ping. I thought about it a bit. I think the right fix
it to undo the overlay fix I had suggested to Geert and then make the
overlay code call __fw_devlink_pickup_dangling_consumers() on the
parent device of the top level overlay nodes that get added that don't
have a device created for them.

I'll try to wrap up a patch for this on Monday. But if you want to
take a shot at this, that's ok too.

-Saravana


-Saravana


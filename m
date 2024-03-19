Return-Path: <stable+bounces-28440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF6880386
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16F31C229D8
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337D71BF2A;
	Tue, 19 Mar 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PojRk8DN"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B21B812
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869658; cv=none; b=b7JoL1OTcIkmY57pdmoYsEr8ad2iXL25NYCluYgspaQDG3wJrfemD3Rv55ukWhZRxaHT7pSgRXrcFNsGtMbZQQRO5fXUiRi6zX0XoPHjZHFD/Qdcb4JDfx4++2jpSs5L3/w4EXiMufZjGMOT3Q5yVkhMbAvW4eUfod4L6RQzGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869658; c=relaxed/simple;
	bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEIxC4pzzDCHFJZlHFW8zajeVtsxDfIQkjdfgZQJqFQeeEbzkQYHqqYK0dv/yb6ldTDwJ2jccGvGtl0NY0JhA3BxbPGMjdt4mhNp0Z8RX+spUKBvvPeu9t/5XHZxqfmaTB6VGi0zLsfJBW9TBdNSfXUZ0n3GY9g05ct1oSWHN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PojRk8DN; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc05ce3c70so3676539f.0
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710869655; x=1711474455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=PojRk8DN3SC71AWZKydd7MEYdTNXzCL41DUTUOav7kS37TeDwj8VzQa6jq3b3eC7B3
         16xQ8R+ChV5VPx1iGycmCbZHvj26DdE3FEfBgn4mfJJzE+gQE6D+kvPHpQUq69uFoMjx
         FAY+GVBNQPZ/QxV1wQPd2QXUkHaDY9RE0mAkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869655; x=1711474455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cv+uOgViz5td2LtyB9BpL841aRXxlirwrFqlMFbk68=;
        b=Z18oZCWB7ldk42tAQKZWWNcoPnDBWzX/Xkl+0P8KCnNefhTUQdO9Wb3BAEm8jgMhcl
         nVl9mhrTKPCa1DXXcki8UwWJh6qspFLqV9VmEN/v/y+DodkRKXFqgF2jqK/u7lcdu9ob
         cDtLsejzgl0O6TSk6AVT1l0BBb2QrbjOdBs5cTkGdTPzr8qq98cw+Hn4nvTVUJy4jD6Q
         ORT7p+ZNPDUIpSjj4bazV+tI+GZ6o3j+xW77K6tvt6Sacp+zLdljaZtNhLuXNmeh8T0R
         TxDOqVWkKNNZgUcWstEhedsRAY5+FtuOSFY5KF7z8NSa8i+megdZGY0CGgyRdwV8c9MH
         0QvA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZ9H293fL4jAt6LEDiYWtYLIYMlQkm/NtFRy1CXNCmxuvtgluxatL0g5JBUJpZ1P0qqZWEKpg0p/+v8oKq0dXsCwjAsCd
X-Gm-Message-State: AOJu0Yzg5oikLIJizYabCpcgdrWRyCR09s2aKZdlBEPT9C7lcLVS4bv7
	t7INC6x+VYKWlwa6y0NYuSNwcWEOb7EIW1BQv042fODUGbwYuuf2ZXdyMT8R+zKc8MU8YGJikrQ
	=
X-Google-Smtp-Source: AGHT+IGMv8oDyhBZzwDr9Qa9HKMA1si0Vzn/3WwPnYX3YZDttOjasgzEiXMNgL/+hECdvISPEmIvRw==
X-Received: by 2002:a5d:8356:0:b0:7cc:89c2:6fd4 with SMTP id q22-20020a5d8356000000b007cc89c26fd4mr4159177ior.2.1710869655357;
        Tue, 19 Mar 2024 10:34:15 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id s4-20020a02ad04000000b00476df803a46sm2986915jan.21.2024.03.19.10.34.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:34:15 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-366abfd7b09so9865ab.0
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 10:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTSlDCxyAL6gG85lkz5CTvHrGZw/U4Uh8wAjoazmSdLGS5Y9EyKNS9EKlW5gXgDx5MpRt3+16KntYcbkCiotSIcu2uJjWk
X-Received: by 2002:a05:622a:2293:b0:430:d723:aa66 with SMTP id
 ay19-20020a05622a229300b00430d723aa66mr20279qtb.16.1710869633686; Tue, 19 Mar
 2024 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com> <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
 <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
In-Reply-To: <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:33:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
Message-ID: <CAD=FV=Ujx+f3SxTiuhBGUypwfvHqTO70jy-8EgLUGA93SON5Kw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 10:28=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > I guess I have a different opinion on the matter. I often end up
> > cherry-picking stuff to older branches and I generally assume that
> > it's relatively safe to pick the beginning of a series without picking
> > later patches because I assume everyone has a goal of bisectability.
> > This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
> > patch into two patches doesn't help enough with clarity to justify.
>
> I did that in v2 because then the two patches had to be split to
> facilitate backporting as wcn3991 support was added later.
>
> But the big issue here is taking the patches through different trees. If
> Bjorn could ack the DT patch so that everything goes through the
> Bluetooth tree, then I guess I can reorder the DT patch and squash the
> two driver patches.
>
> But waiting several weeks just to make sure that the DT patch hits
> mainline (and the binding patch before that?) before the driver fixes
> can go in just does not seem worth it to me.

Personally, I don't care quite as much about them going through the
same tree. It'd be nice, but I agree with you that it's probably not
worth the hassle (though I wouldn't object if Bjorn wanted to Ack the
dts) and it's fine with me if the patches "meet up" in mainline. In my
case, though, I could imagine following the "Link" tag in the patches
and arriving at the mailing list post. That's where I'd go back and
look to see the order which I should apply the patches safely. ...and
I'd prefer that it shows an order that lets things apply safely.

-Doug


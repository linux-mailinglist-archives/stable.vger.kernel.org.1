Return-Path: <stable+bounces-41447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E18B2634
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8BDB2749E
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78814D2B5;
	Thu, 25 Apr 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iR18/QXa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07314D281
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061975; cv=none; b=E23vDHPw/543tiYCVJBrSja2wPzs3wG6mqQUaWfIbhniSY9npOayc6kErmK7/eBeVRpfzA0IDK9d9jF6xCCRwS20oJykoo4Brq8buSW7pJMJmcTtBxM5wIqeXJqsNm3u4jeM8OXskwOjREllflqrc7AdzxwHsD7GaINtVtTOfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061975; c=relaxed/simple;
	bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdaWieTHqFggoBEYXBUm7D7LIUCtlnw3bh7rI/wXilXZwdsbnbxpl2Y7MWzoIGRIFPSIOHHiFv4QJ/Q2rt0nnyClMxWimCTLImvQYaIWZtm01h8DfcIMTHvi7SC/DAAoOMSn+N/KG/S8IxgH7OYbPGGcJtakDUXmKLmc5mxX16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iR18/QXa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ecd752a7cso76901685a.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714061971; x=1714666771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=iR18/QXatk7X9rQRIAZIzNYR0/bbLm5lRfWjD7zv6VIb3zigTChIpTafga4cwPp9Eh
         cBAkMD4/z0s6kgU77wMSQ2HizFsURrNNHUE5PBsEMfhP36QY0/WjfVHElamfPGaInbjS
         eB7DNYVvQABmHU5cK7+kLyIHEBREzXXb4sbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061971; x=1714666771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=Fd+4Y5PlZqVeyVmTuRC2JJVVDtsCM59uov1vSX9PMTJ6wZYJTOol0+zOetedPF5w+L
         G8MuDqA06K6iorwFB0efR+LrX+ZYc3qn750cWcdLsO/hQsXe0GESOvmwykDr5YZ3hhzJ
         KP1cFK/SqtNns8Yu0KrQmdgs1VjBZw19g+UiHw+OZoc8GLtL0SIv29sRTT7QvKqz8DVF
         5yIUZTJszrNRgVT10lgJgTLOCF4W2VPm1nEILqpG5cJ4xk/6aYctOCO8RKic3ZSso+7J
         RrqBHXe3l5vRLDRKNKvTAH0Vw3MQvas4VfnoKuTV3XhlmeyfZQc1Uy+8h0bGuA+ox9bu
         o4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXjBOSGkvCNif1D21KH78OWNy6kiI71VktIdy+BDhKoPFG20IlW7wkaGD+E7AghNMM11pCiDjpm5fOCSAlbA71flTr/JCMz
X-Gm-Message-State: AOJu0Yx28bKBKY15CUlSgJ2IC5GSmUeFHuTFLio8M3H/mJHtHzYxF5+T
	wIfhnqbsVqlfFy45NW9Lt2zb7CYJku8Pm4xZ/l/1qSzGA2tI0ROsG2OgGhD0qwsIlk7F3XwtWmI
	=
X-Google-Smtp-Source: AGHT+IFHbByOZ7m4/mGgaEFgTjjfAaK1BBmiI0fLEk8wD9z/chyQb5icSViD4wW5vlQglZtk8FNLig==
X-Received: by 2002:a05:620a:12cd:b0:78a:34a0:6354 with SMTP id e13-20020a05620a12cd00b0078a34a06354mr56315qkl.42.1714061971402;
        Thu, 25 Apr 2024 09:19:31 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id x24-20020a05620a0ed800b0078d54363075sm7129317qkm.40.2024.04.25.09.19.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43989e6ca42so401361cf.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQw6WQivjRjPyv3ESZ4TmY0KcjSRoHQoXlIqef/1Fa36/22yb0yrThemOjXuZzANbGRZW6MMbAc+aIEwYg6ohV/U41rDXv
X-Received: by 2002:a05:622a:1825:b0:43a:5f02:bbe2 with SMTP id
 t37-20020a05622a182500b0043a5f02bbe2mr125019qtc.24.1714061968946; Thu, 25 Apr
 2024 09:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com> <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
 <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
In-Reply-To: <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 09:19:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 9:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Apr 25, 2024 at 11:22:50PM +0800, Doug Anderson wrote:
>
> > Quick question. I haven't spent lots of time digging into the
> > Bluetooth subsystem, but it seems like if the device tree property is
> > there it should take precedence anyway, shouldn't it? In other words:
> > if we think there is built-in storage for the MAC address but we also
> > see a device tree property then we need to decide which of the two we
> > are going to use. Are there any instances where there's a bogus DT
> > property and we want the built-in storage to override it?
>
> I guess we could decide to implement something like that, but note that
> a devicetree may have an all-zero address defined by default which the
> boot firmware may or may not fill in.
>
> So we can't just use the presence of the address property as an
> indication that the device has an address, but we could of course parse
> it and see if it's non-zero first. (Actually, I think this bit about
> checking for a non-zero address is already implemented.)

This would make me feel safer. Given that you've now found that the
MAC address is in the firmware, I worry that someone will update the
firmware and change the default and we'll forget to update here.
_Hopefully_ someone would notice before pushing the firmware out to
the world, but it still seems like a more fragile solution than just
seeing that there's a perfectly valid BT address in the device tree
and using that.


> Note however that we still need to determine when the controller address
> is invalid for the common case where there is no devicetree property and
> user space needs to provide an address before the controller can be used.

Fair enough.

-Doug


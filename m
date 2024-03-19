Return-Path: <stable+bounces-28438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31CE88032D
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389531F26AE5
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3018AE4;
	Tue, 19 Mar 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2L6LiDS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA463171A1
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868384; cv=none; b=edtu4DDy58moKMbQ8RmKFPE08RM2N+FNcrlQxhkF4OQ5oQQsVU3YaC9tvL1mhfDGl5O5dnv48GJ4Vm3H7aJvW/bDQkjihoxYLOJCfREgnrHFP6XXH6PimDBcZtjLl37gsfO3TjNhjBRXD8x17WpCIIbuEdaACjT/M5M1aJqtOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868384; c=relaxed/simple;
	bh=jL9kHyMM7c3nVEZ31ALav/nIxEz+OLnT9X61bJOp+Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcD6W3LRmk+8iiWZMpegQXKFODQXAjATw/vd9fb60zZgcK5nDL26sph25niAJ9WumO9qR3T0XFVPmgTahmbhodaj4bjwshC0HwSuppXl1N/u/E7n39wGaSI/asYGenv+iSIC3Y0fH6OKBbpHrqMDQovmRsqCsGHBS4zjJAcbnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B2L6LiDS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8bd9837fdso117924039f.1
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710868381; x=1711473181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=B2L6LiDSI0nwaPK6Vd0jBAx5AwnmHvQh4PmMMMwABgntlkwnb5tLFFGYFSOwJfM+Ok
         24CkjqpYc9v0DBw0zElToWV7QoAS4+Zpt0VUrDz+7OmJVbx80BGEBNkX8B4g6Pw3iskG
         FR7NsLXA1+1dGzAJwbHMF7WkJGej+gExfoeHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868381; x=1711473181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=M4/bWmnaLPEr6U/hbPOuwntuwo+fXZcJeGcFgzDV5BJibe6kCJaaX7HaZRM1ps5DYw
         yS9QFa9c/1BEtifGgOTaPPvITP44b+jrEQaVGv2SblYKo847USNi0ADXWcMxYDSwgXlz
         awEFK3lGfR4pPPjPXpQ09PA8WhZHtiWW4i4tQsjZBg9nwB41CtP6Hd1maavrA9OEq51k
         lJg4SSStIMLlGTszFvcARue4H9tjsSB7mfuNyOhQTdXkiaAgPPvTn0+2jzSwnIIOWdlX
         bTyP0ilveYTXQ/chItY/BiZidn2e3Kzs34PcPWJtrFlHcWGqz0U6Qqa/rzcqrdkbYjeL
         U9DA==
X-Forwarded-Encrypted: i=1; AJvYcCUGPmsiQYhzqpPHCsU8BPtm1PWLJhWvCjx1XFo9stIdN/Eq5jEPrf29bCLE3TrsZKYYAofg/r8eMz+LkWLqSobEa38BRmFH
X-Gm-Message-State: AOJu0Yy4eEqCZJ4tYbRlOJth/IDNreyDNQG/T/wPh9u0Fruesxgi8HUs
	+gLiiLJJfve/95li0LHTAv8G3GpdtMZ/mLEnM7pu5gTABfOUHHFljHaicG/KIKBa9pj94QkCu1Y
	=
X-Google-Smtp-Source: AGHT+IGsZ1UPMT5gfXJt4AW9YcExrGlO6H/vjl0vyCD66xffr6qEbQ4YnYYr9a4GvTEMBSLV5yArrA==
X-Received: by 2002:a05:6602:891:b0:7cb:fcde:9464 with SMTP id f17-20020a056602089100b007cbfcde9464mr13819540ioz.5.1710868381417;
        Tue, 19 Mar 2024 10:13:01 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id w14-20020a056638030e00b004772d106d3esm2934656jap.163.2024.03.19.10.13.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:13:01 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so4405ab.1
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 10:13:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOOfvATUmc5KrkGz/EIKDWSgJ1PNKBqqqa+li+4LhJFUuxjQripqui9ywjvaGyXFaUEfHBx9FrrWnDhJzK/77NHFOhw4Mw
X-Received: by 2002:ac8:590c:0:b0:430:b7d0:59d4 with SMTP id
 12-20020ac8590c000000b00430b7d059d4mr1682qty.19.1710868359392; Tue, 19 Mar
 2024 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
In-Reply-To: <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:12:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 9:38=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
> > >
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetoot=
h
> > > device address in big-endian order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.
> > >
> > > Presumably, this is the case for all non-ROME devices which all use t=
he
> > > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices wh=
ich
> > > use a different command and expect the address in little-endian order=
).
> > >
> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > >
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passin=
g
> > > the address via devicetree in big-endian order.
> > >
> > > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device ad=
dress")
> > > Cc: stable@vger.kernel.org      # 5.1
> > > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/bluetooth/btqca.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Personally, I'd prefer it if you didn't break bisectability with your
> > series. As it is, if someone applies just the first 3 patches they'll
> > end up with broken Bluetooth.
>
> It doesn't break the build, but yes, the device address would be
> reversed for Trogdor machines for two commits and possible break any
> previous pairings. That's hardly something to worry about.
>
> So I consider this to be acceptable for sake of clarity, and especially
> since these patches will be coming in from separate trees anyway.

I guess I have a different opinion on the matter. I often end up
cherry-picking stuff to older branches and I generally assume that
it's relatively safe to pick the beginning of a series without picking
later patches because I assume everyone has a goal of bisectability.
This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
patch into two patches doesn't help enough with clarity to justify.


> > IMO the order should be:
> > 1. Binding (currently patch #1)
> > 2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
> > 3. Bluetooth subsystem patch handling the quirk (currently patch #2)
> > 4. Qualcomm change to fix the endianness and handle the quirk squashed
> > into 1 patch (currently patch #3 + #4)
> >
> > ..and the patch that changes the Qualcomm driver should make it
> > obvious that it depends on the trogdor DT patch in the change
> > description.
> >
> > With patches #3 and #4 combined, feel free to add my Reviewed-by tag
> > as both patches look fine to me.
>
> I don't think it's worth spending more time and effort on this issue
> (which should have been caught and fixed years ago) for this.

Sure, that's your opinion and if the BT folks agree with you then they
are free to land the patches without my Reviewed-by on them. ;-) Mine
is not a strong Nak but I feel strongly enough that I'd prefer not to
have my Reviewed-by added without the re-organization.

-Doug


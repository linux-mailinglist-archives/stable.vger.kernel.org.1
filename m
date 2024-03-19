Return-Path: <stable+bounces-28427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831A880189
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31291F245E2
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199381755;
	Tue, 19 Mar 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asU+2MIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CF81AA7
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864657; cv=none; b=JQ66bV/yeB7eryQzuuGncCI1BuSzrdYQdDPS3py3LI1M9RpvIR7zLrzjteHUaPFQ4z71xPRBX8munyEtIMQSsIuKkZ3CDvtzqwCxMNjGQDPA0n2ClLnew7AX/0YyRE7jDlKq2oZIPk/n0DOuE8rnFCxgQafwO5rOFJggci+YaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864657; c=relaxed/simple;
	bh=fKSF8pzEMf4QAy0lGBTclAV9vz3vznJXW70/aPT4oU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaoQy2blmVOhGDPhtxZl5wMXvQwOI5WAzyG25eZUylDfIcEifDwufD+kurTNIJ64iaMmwjdgxNtO21KMM9jy1KFUjqEKZ0POuFlnW66I5VlZXAKUO6tzPLZ0MeecEmeCnAVuGsppglwKPWUG981y0BqEhM5QpgO9Lta9ARHesyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=asU+2MIz; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690ae5ce241so25785836d6.2
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864654; x=1711469454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=asU+2MIzy8Xp18m3UusmpJeFf5SnsHkQVk6V5/H23Z4PBpv4SJA+14gaCR//LrtKky
         t4hATfX+ba0bP6LJqb91lZzpTtdomG06A5h/nUC0VFZQIOxwubg34THiqSg5i87CyGEX
         DkCh99F9wn6qOZ9Kq3/krOOXF2b+j6+hGqQwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864654; x=1711469454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=Myw2dxwItwr0tWS1z4fASlQgIbMBkmunpRurtO56xQHDQZsLw8WZ7YDkWAAYolVcn3
         JtwmLn4QphixI3ZFS6gWZq97UM0oZUUYgGA/6qytTndacSUHFT4jVm+YaFHldshRpn8A
         8mNFOCoqZfYGUOF2YaYKB7QOoc4HGOcYJ4PoW92Xln4wnXrK1/o05djpDYiz+OPJXXlq
         4bDV0Cz9jeO8x77Xt5tO4BRGoFah1GJSec8WI/3W3BAT9jGK+83nKyYxcZaMGXA7H95b
         BsF164p9TME+WBsAhEjl8oe7ThBsuralHseR0TaSjnACLMvLhdEbUwT7VACCzjZA0lsK
         eR+g==
X-Forwarded-Encrypted: i=1; AJvYcCXGy6frRSdch5ZaaH+ff+1Zq4f9S3YgEhgjCaEFiJvgTTD7X9DOM4mqHuJIYn5vY4PCvj7OSJ5elM4ShdHWJ/qcTomXL9HU
X-Gm-Message-State: AOJu0YxPOWDk/TT5I04r5jJKLqah/bK2MTs4hXIQ1Yh6d//ivAmuuUio
	TrPXi2c4mXdMeaTuDQTbv7FrGyEZrJmcvxcYI3G0F9QCFp1eV6TahPw02eaXRBwdxRNsNreHshU
	=
X-Google-Smtp-Source: AGHT+IEpDqwlf1Cu0oIEjU/vSlBEpDQMcTdMdu2i7mwIuhxgF0tO8F3Lo+uMl9CJbSkNyiFzrqvM5g==
X-Received: by 2002:a0c:e092:0:b0:690:b45c:19ca with SMTP id l18-20020a0ce092000000b00690b45c19camr16619536qvk.55.1710864654529;
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id ke21-20020a056214301500b0068f35e9e9a2sm6558642qvb.8.2024.03.19.09.10.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430e1e06e75so435121cf.0
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9oAYtAJUxiTcGc1WjCWoOxyXLh57eIOVw2aEIz1mcqbkPi1OSBCuOLWJNnu6/wReRTUIz/bifOaJw3rUeESRcg8iHExmV
X-Received: by 2002:a05:622a:1648:b0:430:e26f:4bfb with SMTP id
 y8-20020a05622a164800b00430e26f4bfbmr262803qtj.19.1710864653792; Tue, 19 Mar
 2024 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-4-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
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

On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in big-endian order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
>
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in little-endian order).
>
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
>
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in big-endian order.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Personally, I'd prefer it if you didn't break bisectability with your
series. As it is, if someone applies just the first 3 patches they'll
end up with broken Bluetooth.

IMO the order should be:
1. Binding (currently patch #1)
2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
3. Bluetooth subsystem patch handling the quirk (currently patch #2)
4. Qualcomm change to fix the endianness and handle the quirk squashed
into 1 patch (currently patch #3 + #4)

...and the patch that changes the Qualcomm driver should make it
obvious that it depends on the trogdor DT patch in the change
description.

With patches #3 and #4 combined, feel free to add my Reviewed-by tag
as both patches look fine to me.

-Doug


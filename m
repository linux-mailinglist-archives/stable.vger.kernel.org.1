Return-Path: <stable+bounces-40398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485B8AD37E
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0BB237D1
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0599153BF5;
	Mon, 22 Apr 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="To7dC6M/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD114153BF7
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808255; cv=none; b=gKhjxJqidJtKCJgznEiK3rWUGw6M1QMtWRvyzeBNC8lzRlGO324jusKzjsc+vrJayMQr4BjzMydCVEmnq3qCtmhLYy6qxdWAc+O5/mGdw+/F7ZwaiVlYLRfP9E+fYOnYVpIDHfK/jveEME1kZI05IbzpRbxNcRU4P/k9InkJmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808255; c=relaxed/simple;
	bh=PedKjQ4IchNk0puiU4eLptdz+f6auezzylZJfV3vp0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNfx0qTf4EV8D3zDSQ8yyDdeZkplyQzrEkTHIrarnPpQ6uzCxG+dcI3bmp5LbaTozTUbbFtjUQxYqzJNaUlX3wodiSPD8UITlU13rLfsP/QAA4qb7gp8GP3swTUxEv9gsRbCYEgiUWzRm4ns8UT1kMuKIIDDRjXVI1z8PwoUBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=To7dC6M/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f05afc8d6so325754585a.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713808252; x=1714413052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=To7dC6M/PmdEevzayY5EkU9GpBjHKe8PW4TALzgY1zmNd89YbjoWzBzVhC+6xt8W5b
         d/C/UOS98N5eqLGk/0ui4dVS11rkxB+ZvJXi1aGj5fc2BeSkBaUC2yCYxlMTTL/zneCX
         0tcecKOXd1keoqHi7NHn8Frkm41nw7meIe6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808252; x=1714413052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=nxP0qRe0emyXpuGrKa10Gou8BYqTkiZtDjk2yAk/lJeX3oEHeNK1SAG+224oQnHOAS
         7AslClPIaCcOX2rzWaJm36Ynqd+th7eRm9AwEJW1e3R42myyMv939gkB7GP0/QHtuNan
         gY1h+3ih7nGbceJZD0OelLhQGCVU0TAloK/1OJymqUDY7kqgBlDXPHHla0PICOoXBS+I
         5QGh3RLWoRtiCJXhFJgelOVe7IvoflSMQL8xZhQjTaSMD45mWPGznHSTCqYZZxWSxO5V
         2UTc6Zc1GGvHYFqlkbKdKHceTfttIHJXibZpyuEB0cL66GE5GX8rq29UOEcKp+gP9pj8
         pWHg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpgUc39k3adMogiLJzS1lya/onB3Xgy1Sntd2ThLRdqEMx8zYhQGO7FbTf/bTExiqIl9v4FtwHQNV06rM1Rhj27b2L4wI
X-Gm-Message-State: AOJu0YwxvQsr8YsiA5n5ti6zMAC4o6aOm1+iYMfht8d0rSYw2859Lo7b
	WN0fUQHKlyTZoPDD2ZXzHJhRaqgr5Ntwq2hLBHSer2MJmD2QDGfulZIpWUtRjvot4IJ1WcG9N7k
	=
X-Google-Smtp-Source: AGHT+IEIxXP1hahlW4V2qM1qgblbtbCNHOaLgSb5+/l5MQTy65a4+q5g/T0NCL3J5WXQK00UV1rO+w==
X-Received: by 2002:a05:620a:4fa:b0:78a:f3:34eb with SMTP id b26-20020a05620a04fa00b0078a00f334ebmr12482172qkh.23.1713808251792;
        Mon, 22 Apr 2024 10:50:51 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05620a31a700b0078d66ed5e41sm4454497qkb.131.2024.04.22.10.50.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:50:51 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434ffc2b520so18291cf.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 10:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1pGD999nCeEbkG5SIFFJGzMPtV/SZvqkxhXl8MhPOARqFuUtnsSATjHfrzRWMo20TN2Yj0npH2VcRsxn9a/OZaAngHLB6
X-Received: by 2002:a05:622a:a097:b0:437:75be:9111 with SMTP id
 jv23-20020a05622aa09700b0043775be9111mr9752qtb.1.1713808250395; Mon, 22 Apr
 2024 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
In-Reply-To: <20240416091509.19995-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 10:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 2:17=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
>
> This was previously believed to be due to lack of persistent storage for
> the address but it may also be due to integrators opting to not use the
> on-chip OTP memory and instead store the address elsewhere (e.g. in
> storage managed by secure world firmware).
>
> According to Qualcomm, at least WCN6750, WCN6855 and WCN7850 have
> on-chip OTP storage for the address.
>
> As the device type alone cannot be used to determine when the address is
> valid, instead read back the address during setup() and only set the
> HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.
>
> This specifically makes sure that controllers that have been provisioned
> with an address do not start as unconfigured.
>
> Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quic=
inc.com/
> Fixes: 5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPER=
TY for wcn3990")
> Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD addres=
s missing in dts")
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c   | 38 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_qca.c |  2 --
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
>
> Matthias and Doug,
>
> As Chromium is the only known user of the 'local-bd-address' property,
> could you please confirm that your controllers use the 00:00:00:00:5a:ad
> address by default so that the quirk continues to be set as intended?

I was at EOSS last week so didn't get a chance to test this, but I
just tested it now and I can confirm that it breaks trogdor. It
appears that trogdor devices seem to have a variant of your "default"
address. Instead of:

00:00:00:00:5a:ad

We seem to have a default of this:

39:98:00:00:5a:ad

...so almost the same, but not enough the same to make it work with
your code. I checked 3 different trogdor boards and they were all the
same, though I can't 100% commit to saying that every trogdor device
out there has that same default address...

Given that this breaks devices and also that it's already landed and
tagged for stable, what's the plan here? Do we revert? Do we add the
second address in and hope that there aren't trogdor devices out in
the wild that somehow have a different default?


-Doug


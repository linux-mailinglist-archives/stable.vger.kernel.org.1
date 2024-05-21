Return-Path: <stable+bounces-45534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27A8CB441
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9165C1F21555
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EF148859;
	Tue, 21 May 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="kavSZDTc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F94219ED
	for <stable@vger.kernel.org>; Tue, 21 May 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319846; cv=none; b=pZHfGQHofXPwEpsxxVJMBkGOeE6+oDbuhgndzAwhmkF6yW8vs1grut7JNBAAmqplGXpQ2B1TChNJtfA3QllOiq/3BjcydpasBprUOWzeZYQvW9AHNKQoi0pWOK7GFT/W5siAKrypOSqFjCXZ+P0TL/CzOm3L4LQVJrCD6vaDEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319846; c=relaxed/simple;
	bh=uN497LMSSrTG2otGHW/OSlKS89nLU98TjsFNGvgc7BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn5vkUOLZcYTUm1cPx5no9gs+Unc9eiRpZ539bnUZbBJJFqI902OHqpjdv8772jJLjMxxn43MI7pyvnoUKqn6qo+OUIeiFVIKJeT8Z4sJxq3pnmHVXXrnS0nzBqpseUB1DTpYcbp+QCcEsMTWbLMgrkN+XD+Wz8sdX2UJMrqGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=kavSZDTc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e52181c228so55720361fa.0
        for <stable@vger.kernel.org>; Tue, 21 May 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1716319843; x=1716924643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mScw330//XjyClrpxvPSs6MjpV33vzEHLROrLRihprk=;
        b=kavSZDTcn7rkZP0vQJurkWAiSxIvcuo6LFF+9CDER3XgvhYFXv5Z4j/NnoyVaNohm0
         bS+jcz+jKe0DC89YD1U+LaQrQyfDA9YN2AQ4xpz1TlSjqENrTDYbcfIXEsKnmyrsC7d1
         ZMAVkvnxp3SYfNwplbnJ9PBMoJ2boNCK41F6VIDMU3rgl9wdFQ0P6SbAnhDHTYVthnvp
         Uik/tjE9JQC85s1uwQ4RHCamJsztnREWg1XGQySxFyj92zLrc2YmRSi9nvF94bnbc8dh
         gqB1PZeed2XMRx+q37Z4GCnLxl2FsgMutg3afp3E8XRp8dl5dPS3T2tR0NunrULGmkfh
         ZeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716319843; x=1716924643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mScw330//XjyClrpxvPSs6MjpV33vzEHLROrLRihprk=;
        b=dgPNkniUY3KhWrAUPB6SoVp8cLcdJSfX/0CtwvqqA3ThS77L7vyD8zYfSi2eFlMnaW
         77UotxCJUbz8m9hhyUcy1ZOTDk/3DRQCAtwZpeADXmIrUCvVUYaifu+d3JM6DUF4TBpv
         OlXJR78TkpTfs1MaAfbn4LIcZHOm7WmQWBkL+VOcyBneYRk1s6uB/lWsEvHlnwm1PceQ
         LeN0RmaojqL9xx3fKsYqBey+CtnHBA+89uM8HD/9YSrNr220D5Dqc60M8WEOahf56WGe
         hqk6WiMSppioOLXUGkRx7FBBpe1IyqDf1KUy23eurI2vLqNH9ggEaq0bsi8T3toAWjRe
         TMiA==
X-Forwarded-Encrypted: i=1; AJvYcCUeEYzEN/5SVxp+LIjM2GZbIoL9XVLruCMNkHrEt+HVnMwGF4RBpO9XEwxqEbejwUiGMUeWiHu/r/Kmrlad+FOtJaj+ec6T
X-Gm-Message-State: AOJu0YxD7EkZRgMchxLI+1iw7ixbWjj6/xKHUyiZhrflVt2DybfZ2rAr
	DiX0LadiWNk6+777QHhhVtoJSUaN1vdzodqBcIO8ScNeutmhKNCNuPMSL3Flr1KOk0MGzikVEi1
	J7ZBomP4lLWs8VQtOFHysiqTbwl8Y9/paGrKk
X-Google-Smtp-Source: AGHT+IFN7IRJY5kiBiKBEGefkggLY3iU8MsJap6OuX1crsyCiwkXjeBbDTmfMBuiSArK98CecXCUx/Cf3hDAe9Yiprk=
X-Received: by 2002:a2e:3206:0:b0:2e0:c81c:25da with SMTP id
 38308e7fff4ca-2e51ff5fb1bmr232817751fa.30.1716319843220; Tue, 21 May 2024
 12:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>
 <Zkz1Au7njclh1r3g@shell.armlinux.org.uk>
In-Reply-To: <Zkz1Au7njclh1r3g@shell.armlinux.org.uk>
From: Da Xue <da@libre.computer>
Date: Tue, 21 May 2024 15:30:31 -0400
Message-ID: <CACqvRUYo+KJJjq+AtpLpZhS9WrTUoGuCJ0ZV-7=fy0zvD=xF7A@mail.gmail.com>
Subject: Re: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Da Xue <da@libre.computer>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:24=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 21, 2024 at 02:56:45PM -0400, Da Xue wrote:
> > @@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct
> > gxl_mdio_mux *priv)
> >   * The only constraint is that it must match the one in
> >   * drivers/net/phy/meson-gxl.c to properly match the PHY.
> >   */
> > - writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
> > + writel(REG2_RESERVED_28 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
> >          priv->regs + ETH_REG2);
> >
> >   /* Enable the internal phy */
>
> In addition to what Andrew said, you need to look at how you're sending
> patches - this patch looks like it has been whitespace damaged, which
> means it can't be applied.

Thanks for the feedback. There's 2 reserved ranges in that register
with no further descriptions available.
If naming the bit offset after the field range is OK, I will make edit
and submit a V2 though send-email.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


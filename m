Return-Path: <stable+bounces-94496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF59D4764
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 07:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC91F22203
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B703155335;
	Thu, 21 Nov 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="CpJU8sRz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE491CA84
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168895; cv=none; b=YBRntHT6mqjwxsMFI9axC/InKLKY6O0MaM6m6C+rE9e2WU/Oee/mh/GixS//1PDPDjrE/2Ks7Yc8awcz6L1U6POEQ6ckFOgTkJKmo8Ye5zeJphBMSuPhUlwB4HCtnHpcrGKpxym/Z/FGlxFfDtzjRpZ7rWUPlfQ3CCz0WInN9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168895; c=relaxed/simple;
	bh=ayAF/Veqgd3KzXVypEg2pEzxccluRkLQTpGNhJAtHko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYUmSE4KFzPC3yDLiMH/vaJCPdlmwRdQtrVN8t8/YViR2muUwRQKYp/qpLrP1IlZuhhiTTyaMyx5sxfGkq4OaFsx+fCVztvS+3mga4whATwQv3PqpU0G6xRG3pbW+e3Tr8PTaNK4BxwhsungxqrVUwJ+qA9tjvwYwI7fnQo3nRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=CpJU8sRz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so3108718a12.1
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 22:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1732168892; x=1732773692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXBYO7IREaqcFC1AY+U6gH0DW+PukJ6oZRwSeQifutI=;
        b=CpJU8sRzY2EEa+z5YeRkrhaF3FQjLdDh7emQQT/LnPbqFAf8CPIiYAHlrripuJUR3B
         Gdcz/najSPZKLBTkEqYZFVTIP5RRXLA/4//XfEk/divhYiRVba0sPXLyHWW+slEYFStl
         0h4LI9au/JIv3UBWVzapthJrquo3+7jZQjC09QUPi7Tj5hR5OhzZv2tiCUzUIuwtHEpw
         0bzyOQmMPmYW++s0IgjIxzgJMwos/6Y2ba/i9FwWjj4dqzvOzYNmL+V/ZmqO9TJxB53I
         oRhc7HV7iXo26jWR1QeVR1qpQXTX4yb7Dm7otAsF4r8jyjPwaAq4+aX2K4miuLTlJFM1
         kuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168892; x=1732773692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXBYO7IREaqcFC1AY+U6gH0DW+PukJ6oZRwSeQifutI=;
        b=dcwn2Ytj4BnTwPdZr/w/xTJV29gDAn2BBOtDG/7rzZ/OCqLwSjBB0t9YEkAe+itfZn
         rMkPqbmi86di8rGTzEQhQ73C2qGsID77D61wYr+x5eviG6cuEBDByz/sxUr4pQUkUHvx
         vL7a8sKD/OcMjjLBvGijbossk6f3HJY+7ukhPFEa/J2Drm9XYRSoYp+JJMxBmInffqLI
         eUz1UzPIRILrtoX2I8ld96rBdGcGdtDn/9AP+FCWJCNM50VeGN0UnLTludzFiy8hHONS
         EpyJHzv8GS1SQ1Hwpt43DU8eSScp4u9sKGXOGZbAIazu0nmojUfKQyTbh3Sn8SOK6Znd
         bm6g==
X-Forwarded-Encrypted: i=1; AJvYcCVjJC+U1dRIrAnzrd+K/f8pWG/wjjNB088hn6bFhdYvmywFVJOp4mlJ5ba3/xmN9esIzNjmshg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT6sXkTfIq3CNASAkOO2dxsj6yTrymmzmpOPtm3tgbeSX0+w7
	dnnwrnhlaLRCu7Na91x4pyaUbnrJDIxoYeBfu8aAddnR6V5mkTtMlFc4ZAfgRkJbb3fYzVQ8dCQ
	bN13wspgxoV8UqDfhIyhCWDjeyYXzKpIG1CI=
X-Google-Smtp-Source: AGHT+IErmyO6Auj29nMzsQsciAeQieUSQ40mWvouilmqn2J8jN6CWiJnyXtOkmFurSkWnL1C/48LjVI6yqaWSkbNQBg=
X-Received: by 2002:a17:907:3d92:b0:a9e:85f8:2a6d with SMTP id
 a640c23a62f3a-aa4ef969eedmr214855766b.11.1732168892228; Wed, 20 Nov 2024
 22:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004061541.1666280-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CABMQnVK_RUC84QQ5zb+ZpuMOZcFMNV6HzEYAfmX4bOrRm+rvTw@mail.gmail.com> <90978892-2086-4c70-9698-0957cc71abb8@lunn.ch>
In-Reply-To: <90978892-2086-4c70-9698-0957cc71abb8@lunn.ch>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 21 Nov 2024 15:01:06 +0900
Message-ID: <CABMQnVJES+VoqNYNgo3zxFkTJVYkR=ZCwWsEFEe=QhKyaYie9w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your review.

2024=E5=B9=B411=E6=9C=8818=E6=97=A5(=E6=9C=88) 5:06 Andrew Lunn <andrew@lun=
n.ch>:
>
> On Sun, Nov 17, 2024 at 05:53:51PM +0900, Nobuhiro Iwamatsu wrote:
> > Hi Dinh,
> >
> > Please check and apply this patch?
> >
> > Thanks,
> >   Nobuhiro
> >
> > 2024=E5=B9=B410=E6=9C=884=E6=97=A5(=E9=87=91) 15:16 Nobuhiro Iwamatsu <=
iwamatsu@nigauri.org>:
> > >
> > > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > >
> > > On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot =
be
> > > found and the network device does not work.
> > >
> > > ```
> > > stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY=
 (error: -19)
> > > ```
> > >
> > > To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of =
the
> > > mdio bus. Also the PHY ID connected to this board is 4. Therefore, ch=
ange
> > > to 4.
>
> It is the address which is 4, not the ID.

Thanks, I will fix it.

>
>         Andrew

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6


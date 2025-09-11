Return-Path: <stable+bounces-179222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21033B524FD
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 02:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CB41B24F81
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295835949;
	Thu, 11 Sep 2025 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxv8q+2j"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772717D2;
	Thu, 11 Sep 2025 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757550716; cv=none; b=msN8WlsZm9b7IFS3PFh31w9RfKLCSIqXohDohLHAHHJT2VDFFZloUbDBabDoozUIj2kjWwtldNNKlRqud/a96rjyQilXerDI2YOM8bCthaVijzWh3zb8THfqpCGGx/wxqiunv+XmbkeUKVXi7piysTVaR7Td2Iq1Cpsg0Zz+fJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757550716; c=relaxed/simple;
	bh=yXmCe0eO/MGZamsjfTzYUhWk0GYiWGiszqdYPvI3hSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdoSmT6xOe1HyJT6+hWcSLO8AOMkaY8kY/HFKhMJZVPbKjs+qRz9ttmLvSzO/ewMvzXYY6XYQUaN7v3VnvtHneCAeWRUCseX6ldDJzVG/IGfzJLEH2ssn5iLVR25grHQEtoUMqzOGBLihl9hfPgjJ9UT8tYbHB1nEt3Y9A4GF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxv8q+2j; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6228de28242so284354a12.0;
        Wed, 10 Sep 2025 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757550712; x=1758155512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSwpihcUfwJPnP2twrhHg4lAoNTw6Z1GE9b1kjNX6d8=;
        b=kxv8q+2j1gpz0Gb6u+MAp0OBRI9jiXqBPC06ujnK7Ac9aEH33ObYJ+3E6KVflCFn3O
         i6bF+85hxcbSiOjVT7z59ruzj8gCSD5Js8xP6y7zURdxhMOBOVP6/AiSGQhNlMbqydgD
         5tmxtu/AdEg7pjIg0jKA6Y9vyeiwzSJoQDAxQOoLThz7tjEhEiwTY1WKj4q/55nVEU+S
         tLh4hjEhI9dn1NXgEmzMsAHCe4vFrcXkXolNKG5AbxLRSppBD2qctuGEXFUHt+tUIPfl
         NFWKd/buy0i6KfupSqluZOxSqSAXnCNQaSCO84vqzVDgpHSint0XdRi1BCbZNWBUlLAY
         oP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757550712; x=1758155512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSwpihcUfwJPnP2twrhHg4lAoNTw6Z1GE9b1kjNX6d8=;
        b=toU7NMPKD7E8zklwhMxe9l8xcZjHCyCtVg1aOn/NIGem7CSwop8eDAZcKnmG5pzMQo
         Q58y5X9wQC2xEP/mAT1Mjc6BorblHmgmDE2L5t6bj/0Yh/8KBuiJ5+UUz3c6fyrmND59
         5Tnzle37xjhkqjGAG8ezPP6Ms/SBRlFDWwM3uEe1o4cBjmSzNJy70zDYXdVwXS6OltJ7
         NpYnzhILRapeyXuUym5RCZWtAmfxD5ke/NOdxYMF0Ij1/qgVeXUVkcqFP1yDlbEzQBPR
         76GAwxq9nu5aLZEMAECm55OvMkdCkej4O+GYOjbHeDPWLMvOQCxtwZKwYaEqsRAsOIHn
         IKzw==
X-Forwarded-Encrypted: i=1; AJvYcCWY/T+1bUsXmpk9C8fp12EHZ0TH3Z6tqXIF5l8+XUu+gPGhMJUapjAo/n2Ch42PQwiIT+Fdjlrj@vger.kernel.org, AJvYcCWiR2OnOu8LVsAnA2isfa9xIll/odSVc/DDcp2fO2l/LdXaNrQ4XWiGEum0JeAsLx1wcQ6gIML2Si4T@vger.kernel.org, AJvYcCX8ppb2sJdlFx7VYj0O9rm2at6lQOmnteEA7Wdwsoxs7+Mzw44WIiOqWi3nQSeiMyhpXdmA9sjVwrq0Y7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLAeR0M9jnaGS1qgvMt53cEPC6Ecys7I7B09w3jX+wFO/jxP2
	HY90ONygZZmeAM4aOC07yqatTG+S5GkmKLjUuLMhJa6UH07XUgW20j61JQp8p+6uaC10nol+ie1
	SYbkb1a1LSpchrbBsRYbv3fdDmXaIlek=
X-Gm-Gg: ASbGnct0Sgd1BiZ0OCLbx5K1O6GFP+ifFWdhW1whccwq1CeJIt45xn7a22Obwrtw6eo
	oBfVUI461ONFQ1TV8/hJvMjh5EmMvWCnJi8wLo0hCfsDoxyphATwywO0sHV5MrC6z0IoD5rF/C+
	vtNo3bD3DY0hm5UYGD3B+PU7vGXhRx2bSGQ4V9F0hqpJL9rZgCWDnJ4hAhL3sm4vlacEZwW76Vd
	sMHmFM=
X-Google-Smtp-Source: AGHT+IG1XqFJ1otj8Vpfd6NEZMsXGp0V8er0kO9gouhW/ATeLKIBH9kMlg3YcwtitzuwaBb1+rjZShFy2l8ww5xn6D8=
X-Received: by 2002:a05:6402:2b9b:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-62e7b009d54mr1414666a12.18.1757550712216; Wed, 10 Sep 2025
 17:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
 <a9fdc8f66a2d928cf83a3a050e5bdb7aff4d40db.1757056421.git.benchuanggli@gmail.com>
 <76616ed2-ae07-4e1a-a275-e43e43fd65f6@intel.com>
In-Reply-To: <76616ed2-ae07-4e1a-a275-e43e43fd65f6@intel.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Thu, 11 Sep 2025 08:31:40 +0800
X-Gm-Features: AS18NWCdC9PaSKUpY8PZUq71NICxFNvKt1aGrR9LrRkoFvCuJe6WWUG--PQgK-s
Message-ID: <CACT4zj-WAayp_egCOWHf8yyNa72UReJxTpL6+YosAOQvwqqjpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:55=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 05/09/2025 11:00, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when =
the
> > vendor defines its own sdhci_set_clock().
> >
> > Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > ---
> > v2:
> >  * remove the "if (host->ops->set_clock)" statement
> >  * add "host->clock =3D ios->clock;"
> >
> > v1:
> >  * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail=
.com/
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 0efeb9d0c376..c459a08d01da 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
> >       else
> >               sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> >
> > -     sdhci_set_clock(host, host->clock);
> > +     host->ops->set_clock(host, ios->clock);
> > +     host->clock =3D ios->clock;
>
> The change that host->clock has not yet been
> set to ios->clock needs to be part of patch 1.
> i.e. put the following in patch 1
>
> -       sdhci_set_clock(host, host->clock);
> +       sdhci_set_clock(host, ios->clock);
> +       host->clock =3D ios->clock;
>

I will update it in the next series. Thanks.


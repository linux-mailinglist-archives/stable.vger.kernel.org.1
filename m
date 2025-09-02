Return-Path: <stable+bounces-176933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D29B3F588
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BBB204DF1
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498882E542C;
	Tue,  2 Sep 2025 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhyS0zT0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31F2E5429;
	Tue,  2 Sep 2025 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794750; cv=none; b=B2HCrLtpZvUBqGspOiZh3JgpO65tqr4DObiMgsXqnh6tbBSxVSEi74oYABlWwY/SD3EmJCL8hMi5ox0hBT8y/mFslDJ1CRthWnwe4M7yjZO9acdhpbg8vV5IxXkrLKZcsOVbFV81jX05MXcKipsfXZpWe/fbm25lHX3BVT/Lkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794750; c=relaxed/simple;
	bh=GQwsxAkMmJQU/Q6zAYqhVCnKeNHCsat9/3f6HMX+Af8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g42VraHLj0tbLRitjeDZoxh83L4AZ49gb+pWAUtkP+NmIGvAmZZJ64AbCk93NPRf4uZpJwLwvIkc3Y4l43Zrwn8uv1R7rI6CPRYiO+gBD/CouKsg8o9c+KnS+jGsNwIglomoN9NgRn5mIx31Wk3qqp8fCDMzUucTfW1L2BTTVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhyS0zT0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61ded2712f4so3287968a12.1;
        Mon, 01 Sep 2025 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756794746; x=1757399546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Fm/ZTV5cDIvnNPVn28C7GkPBRe7VvE7rOeJnJpH5g=;
        b=IhyS0zT0HoDfelmytQXu5mjDDWsCyRm4pB7pKxPszX/ZU5XO8MV2ZkmfANV1vczI0i
         DH+ijA5IVgSF6XohYHuzDV0CwKiQtbwX35POm7dSDgF+07ybpItn99pn+xK3z59DPp4i
         Y5pPFrpNc8um+/hh/57HiUHGmnsVo22kBAno0bYTYoFcXryg9fpKS85ODoUKxj6UmZPk
         J8WGCXD6AI8vW7Ba3ynB3+RCDdX0EypnaWCFObuoFbcA0/wT9K4tsKKrosmPPjqA8T/V
         Ahxuwhx4lq5GN6F7ZRA5dxyCjJQbh2MZbR70rxTW1Aj+v9cij5OJcSeVi+krjfdKLuof
         2czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794746; x=1757399546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6Fm/ZTV5cDIvnNPVn28C7GkPBRe7VvE7rOeJnJpH5g=;
        b=GH7CI9Xg0SLx0Pa3eR1UpJEuhHigwsg/a5y/hN1TplbKw+ADocXUTuLsBA7sDT78+a
         PR+gvR2g/0xHTqWcVD3Etlaio540UWzUVwcUEC6/iZOc3shEDuhWzyZdRazlxTVdAZ+q
         J27ZQZF6hSI8pu11rXTnJZu4qvQIPgc9vMGDQq2OYblLOnfMEnDSB4RNTsnStmiJNJio
         gD0NW2nrr0aHdFgOg9ihpBVhNk1rnlkL2ambLKAyFprYQXtMbBmCj7D8NX3nMEI5QdXw
         7pY0PkrR/7dxa3ocF9eAJCCaPh4FOSIle241/xZ6FVLMuK34AE0XYfQWM3ZSoUypvZZO
         puTg==
X-Forwarded-Encrypted: i=1; AJvYcCUSfie7lZ6Hx5zA/6eJq1JWyJ8inAhC7hMgZlc+DsxNSPX1K1EstGnZVTw5feCDxJEzqxIHyfwUD1tl@vger.kernel.org, AJvYcCWrDJul8v+34s9s6/fbKJejNBCW6UML/flh8+gCqKejYwMblZWapCQ1BgLHqfedTwvRu/SnCYbmfdYPTV4=@vger.kernel.org, AJvYcCXtPufjEoRezoWKquUDGvUyUq3QJq9SJosPE2l1/KJMYhYvaBlrt+M3UBuzfusKAEBX5aPXjaAP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rBuLnTJiuNwpoIV+SstjA6X2bV9BpmQQCJtDfQhl5wNXFFz1
	ux8Ez7jJKy0UlRwGUCrVExYssKh+W99bTsuDzkerzb9/RHLjIWIP0nURqkIiSAW9C1vONPl1i8r
	YIP2f4zBSBn3bJxcBFYJAG3+rzvvNgGgGKNUc
X-Gm-Gg: ASbGnctci166XnwrKZYqMUXze92drm3cT9R0CfI30ZGc7EYf4NOrsrvSf3Wbt0SCaCu
	isurDBJ646mV5Mi8nhkCX46iuNIPk3E8/74Ac5B2Y3ifgXnFdRkGzAuHrpb4C7gTcImS6IMqvQj
	n388ukc5oFuDlDyqbfiU1CBYEZwFi4AoKIkDNGxa8vcqpXjX+4OAf0541YWSNVfqjB0CaFgX7XV
	npZ3A==
X-Google-Smtp-Source: AGHT+IEpk+pXEb2JuCEtryN/GQpgOPPzlaZ3OWKaEK8m7edJ4BC60Jrub9V8z17RhIhLwn4o37hiV090uzzDBGcTBOs=
X-Received: by 2002:a05:6402:5c8:b0:618:534:550a with SMTP id
 4fb4d7f45d1cf-61d26c53c4amr10042516a12.24.1756794746110; Mon, 01 Sep 2025
 23:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901094046.3903-1-benchuanggli@gmail.com> <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
 <1aaeb332-255e-4689-ad82-db6b05a6e32c@intel.com>
In-Reply-To: <1aaeb332-255e-4689-ad82-db6b05a6e32c@intel.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Tue, 2 Sep 2025 14:32:13 +0800
X-Gm-Features: Ac12FXx4lmx1bn4d88gVlxaGJJ_VnIYUe-GbPi_ETnQXF4QqF_8qgI40txKoPxE
Message-ID: <CACT4zj8LxG_UeL22ERaP4XVwopdSjXz7mH95TyxXJ==WKZWHLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:50=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 01/09/2025 15:07, Adrian Hunter wrote:
> > On 01/09/2025 12:40, Ben Chuang wrote:
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when=
 the
> >> vendor defines its own sdhci_set_clock().
> >>
> >> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> >> Cc: stable@vger.kernel.org # v6.13+
> >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >> ---
> >>  drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uh=
s2.c
> >> index 0efeb9d0c376..704fdc946ac3 100644
> >> --- a/drivers/mmc/host/sdhci-uhs2.c
> >> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >> @@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
> >>      else
> >>              sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> >>
> >> -    sdhci_set_clock(host, host->clock);
> >> +    if (host->ops->set_clock)
> >> +            host->ops->set_clock(host, host->clock);
> >> +    else
> >> +            sdhci_set_clock(host, host->clock);
> >
> > host->ops->set_clock is not optional.  So this should just be:
> >
> >       host->ops->set_clock(host, host->clock);
> >

I will update it. Thank you.

>
> Although it seems we are setting the clock in 2 places:
>
>         sdhci_uhs2_set_ios()
>                 sdhci_set_ios_common()
>                         host->ops->set_clock(host, ios->clock)
>               __sdhci_uhs2_set_ios
>                         sdhci_set_clock(host, host->clock)
>
> Do we really need both?
>

We only need one sdhci_set_clock() in __sdhci_uhs2_set_ios() for the
UHS-II card interface detection sequence.
Refer to Section 3.13.2, "Card Interface Detection Sequence" of the SD
Host Controller Standard Spec. Ver. 7.00,
First set the VDD1 power on and VDD2 power on, then enable the SD clock sup=
ply.

Do I need to add a separate patch or add it in the same patch like this?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a17821efa5c..bd498b1bebce 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2369,7 +2369,8 @@ void sdhci_set_ios_common(struct mmc_host *mmc,
struct mmc_ios *ios)
                sdhci_enable_preset_value(host, false);

        if (!ios->clock || ios->clock !=3D host->clock) {
-               host->ops->set_clock(host, ios->clock);
+               if (!mmc_card_uhs2(host->mmc))
+                       host->ops->set_clock(host, ios->clock);
                host->clock =3D ios->clock;

                if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&



Best regards,
Ben Chuang


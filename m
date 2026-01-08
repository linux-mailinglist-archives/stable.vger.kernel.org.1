Return-Path: <stable+bounces-206288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C26D039A0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC6A43087445
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9D3921D6;
	Thu,  8 Jan 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KQrPQpOL"
X-Original-To: stable@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7937F746
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865419; cv=none; b=J984W+p4aQz4V8PTEk8SwSHl4LDla0YbdjYUe/t89QuEwzY7uJzuU+pZgQQ5TTRbFrlsw/Ix/+DmgMar50Uort2mFuuzv1FI44pLKk4JocUUXbKr31Jq4ngEV6qVuqVLaCC1Ojd+gX1d863ObniU0xWnOnp+K36t1vBduFPGhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865419; c=relaxed/simple;
	bh=T/YyaTdcu9Q2dPEDTBWA257lGsUEkmz/nCEEUKJjjpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNASkORf2GlTeFBT9WK5KgWKkxGll3Y2ZQK3F5rczDjG9H279VyOWDOw/IUqILqGLh3YPEwegfc1dYSSF+PSLaIOC9389g4nA430I4Z6CTruUxIVQzpYwXIZ+wwxmZ1DnMclAeo0UPW8Pr+VahZgFtY5UbMLPIxZ9c736sgkMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KQrPQpOL; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 489DB3FAD9
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:43:26 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 34F9B3FB6E
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:43:25 +0200 (EET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4C821202426
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 11:43:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1767865404;
	bh=mXo0irbNY2IXfVrun0XMX+jYxeQRfUkfceORyt5hAfY=;
	h=Received:From:Subject:To;
	b=KQrPQpOL4bycRI5qXjif3OaG78E3X2RxLxCkc30Zz5bijlOk7xVlmlveViRZ/aP+D
	 pv6SOim798TX0pfETWM52jIKP26rDCbQ8OW940RnYtfjzHwTzS8r96QYo7B67QjP3x
	 z8Nee2REE2H0ToO+G5JFZqxAhDn8kRztNw/3WcVHLa99QO1lc95OU8UR6dv5VIkkSH
	 6P+6ZInr5CKP4ncK1OmPWPo7nzD113bcAZ6FDxbbMLEZ1vsRawf/jyHvR3kXh3Px9G
	 w/RLfKCP4wLhmZbfNDDaTeX3ktTK+8/CaJ1m+hnZw4NAFOA0IItM8rd0nY5kM0t8ot
	 +I7/VTmDBaLAg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-382fceabddfso16668021fa.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xHfQlLjgT6ah1xK9CKS7bFpbyptxo/hVxWWInyu7SEFOo6D6hVG3TFqzEwSXbk+7upSZPfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabhmdJM7HoCkhxydx9L+2Ze1TTAvrP7ha1LztUrJdf9KG4OqN
	X5rOr4ltUSe3Mhyam/J7ShPswRFjWCuZ85QGO4qJH6zlPff9GnTv0V3Idxk71zS+pV76Q4srB5B
	FxA6tpo9zmEaAkbU14DYPNrk77OVDdRA=
X-Google-Smtp-Source: 
 AGHT+IF4HOWqyM6OYSnApZIwhGS8Tpvn/fv//n5t8s0zNL6cCKPTjt5V0lEQOYi4Dskh8u++YjG2TinHQMVgsik1tfg=
X-Received: by 2002:a2e:a581:0:b0:37b:b849:31c3 with SMTP id
 38308e7fff4ca-382ff86a815mr16959911fa.44.1767865403830; Thu, 08 Jan 2026
 01:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108093650.1142176-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260108093650.1142176-1-matthew.schwartz@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 8 Jan 2026 11:43:12 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGvibcndLz-Qd1awQ_E3SybbZ5--aROWZYJJrHTw1iOAA@mail.gmail.com>
X-Gm-Features: AQt7F2pFolTlntfZHnsAnr0DeAUdzyoG9JqA6J9pZFuOHHITqqRddXu39Nry8WY
Message-ID: 
 <CAGwozwGvibcndLz-Qd1awQ_E3SybbZ5--aROWZYJJrHTw1iOAA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG
 Xbox Ally X
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>,
 tiwai@suse.de,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176786540455.2367385.10094722800950613413@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 8 Jan 2026 at 11:38, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> There is currently an issue with UEFI calibration data parsing for some
> TAS devices, like the ASUS ROG Xbox Ally X (RC73XA), that causes audio
> quality issues such as gaps in playback. Until the issue is root caused
> and fixed, add a quirk to skip using the UEFI calibration data and fall
> back to using the calibration data provided by the DSP firmware, which
> restores full speaker functionality on affected devices.
>
> Cc: stable@vger.kernel.org # 6.18
> Link: https://lore.kernel.org/all/160aef32646c4d5498cbfd624fd683cc@ti.com/
> Closes: https://lore.kernel.org/all/0ba100d0-9b6f-4a3b-bffa-61abe1b46cd5@linux.dev/
> Suggested-by: Baojun Xu <baojun.xu@ti.com>

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>


> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> v1->v2: drop wrong Fixes tag, amend commit to clarify suspected root cause
> and workaround being used.
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> index c8619995b1d7..ec3761050cab 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -60,6 +60,7 @@ struct tas2781_hda_i2c_priv {
>         int (*save_calibration)(struct tas2781_hda *h);
>
>         int hda_chip_id;
> +       bool skip_calibration;
>  };
>
>  static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
> @@ -489,7 +490,8 @@ static void tasdevice_dspfw_init(void *context)
>         /* If calibrated data occurs error, dsp will still works with default
>          * calibrated data inside algo.
>          */
> -       hda_priv->save_calibration(tas_hda);
> +       if (!hda_priv->skip_calibration)
> +               hda_priv->save_calibration(tas_hda);
>  }
>
>  static void tasdev_fw_ready(const struct firmware *fmw, void *context)
> @@ -546,6 +548,7 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
>         void *master_data)
>  {
>         struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
> +       struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
>         struct hda_component_parent *parent = master_data;
>         struct hda_component *comp;
>         struct hda_codec *codec;
> @@ -571,6 +574,14 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
>                 break;
>         }
>
> +       /*
> +        * Using ASUS ROG Xbox Ally X (RC73XA) UEFI calibration data
> +        * causes audio dropouts during playback, use fallback data
> +        * from DSP firmware as a workaround.
> +        */
> +       if (codec->core.subsystem_id == 0x10431384)
> +               hda_priv->skip_calibration = true;
> +
>         pm_runtime_get_sync(dev);
>
>         comp->dev = dev;
> --
> 2.52.0
>
>



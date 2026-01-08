Return-Path: <stable+bounces-206267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5422D019FC
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BAF30065B1
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E237F8C6;
	Thu,  8 Jan 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="UfFU5Ouw"
X-Original-To: stable@vger.kernel.org
Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58737FF6B
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860072; cv=none; b=CwZUjBPg4i2OrIvAajjFQARtef9HczTlGZtASuBaCN9ofa/QQ6mxM0FQLKcBM9tSStB/C3QtS+MeuK7Q6gQuu2j1y+dgOGEcsC+It+w6z/2XrpV2vfM2qmcIUHYuo0W5R393dQVg2rJZSWz1yfbgvDrWA6kWw4x+fFCf0ozpZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860072; c=relaxed/simple;
	bh=QTR0ffz+hBBqJxPMlUWy5QOJF0qP2peWN4dEx+vBepA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plFQmd9EzcRBOYudUN3K1PTedLX5mSXBKp6GSqlTu8+fonS8v+U1xHgAKsij1CXP25+n5qbkUFAeErelZA/FkT5bpiejZWXTeqD4cM+IBLVRE+T2wjBtxemyrNlM7HV8FTgM5O9KKKfE1GYv5qw7OI867Pb4vRFMsZxUF9uvAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=UfFU5Ouw; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 7FE3D40F44
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 08:14:08 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id A161440F41
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 08:14:07 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E5FAB202446
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:14:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1767860047;
	bh=2uF14edgWCVXzukV9wBGag66deIDBqx3+Vnf6aEFLw0=;
	h=Received:From:Subject:To;
	b=UfFU5OuwFrFDFa/XA0nhG9u9qdzsgRw7JuGv1Q+N5qQLqBZebz9gPS8OWqLbmUDKw
	 Hl564diz1s/YEdf2+CAkd5JNZAPxUwH6Y9/Hct8qUQ/L13YrqwoCAY9t8Ix7DfM2lo
	 711MoUXG1sB5oRzKu9KlKSLbAlh1kJy/FVavuyrt6nC6vqXNWzhEuM8imM0s1fvlUn
	 NhXzHmSyaXRWO6Cq3yfcMCiUAhCbXiXJMg368Jrd5OzAS7bj80hhEX0sy62PuzQENH
	 e7Wws+2eOAVWJywyROsC1ysq2DZsfRW52UH5NM5JMRu1RUwKYmyqsCXeIhTkIlcpvF
	 eU5/gULk+Mq3A==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.51) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f51.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-59b7882e605so402462e87.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 00:14:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRR7LJ/I0icUXZDajBgOQXyU3YtpMcTlHHEaC2P9HYXD7x6YjjYPLSnMbAkPR+4PkQ0AjVMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP+iUVm69SJIxuUdVpqsPLSEmAfFBrKuiMxC2mcF4WLHwNwyq
	ggx9Z2kcdrTZ4/Zg5/GYFrbj+a59A3Y9j0mtONDooYVjre3gXDL7OS/04RuX5ynW1cvmpDlUPdO
	npQkTVPJdUpgo+o3cp+etFAiSxlzOIAc=
X-Google-Smtp-Source: 
 AGHT+IF8+OILyRILylFaC7okcdpvwPDMDVq/yamOXleVg6o4qTB69P4B/uOVkqvKuJpk406klKgd039QBbTtrQA6JuQ=
X-Received: by 2002:a05:6512:2341:b0:594:2934:8b83 with SMTP id
 2adb3069b0e04-59b6f02fda7mr1852379e87.30.1767860046288; Thu, 08 Jan 2026
 00:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108054036.11229-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260108054036.11229-1-matthew.schwartz@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 8 Jan 2026 10:13:54 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwH=aB76uq1OSJmBijMT1WY4XK6m3Av5qyecVLkjqzTrXA@mail.gmail.com>
X-Gm-Features: AQt7F2rOaXRZeggkN-TO6XV5tabYFVxwUVcwYO2PCg8jFCX54dMapWIAnjbqK-4
Message-ID: 
 <CAGwozwH=aB76uq1OSJmBijMT1WY4XK6m3Av5qyecVLkjqzTrXA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/tas2781: Skip UEFI calibration on ASUS ROG Xbox
 Ally X
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>,
 tiwai@suse.de,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176786004721.1999606.2870107802602181693@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 8 Jan 2026 at 07:44, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> According to TI, there is an issue with the UEFI calibration result on
> some devices where the calibration can cause audio dropouts and other
> quality issues. The ASUS ROG Xbox Ally X (RC73XA) is one such device.
>
> Skipping the UEFI calibration result and using the fallback in the DSP
> firmware fixes the audio issues.
>
> Fixes: 945865a0ddf3 ("ALSA: hda/tas2781: fix speaker id retrieval for multiple probes")
> Cc: stable@vger.kernel.org # 6.18
> Link: https://lore.kernel.org/all/160aef32646c4d5498cbfd624fd683cc@ti.com/
> Closes: https://lore.kernel.org/all/0ba100d0-9b6f-4a3b-bffa-61abe1b46cd5@linux.dev/
> Suggested-by: Baojun Xu <baojun.xu@ti.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Hi,

can you remove the Fixes? Commit 945865a0ddf3 is not related or caused
this issue.

My interpretation of Jim's email was that he wanted to do a root cause
analysis and e.g. find out that it is the UEFI parser. Which it is.

The device does not have this issue in Windows, so it is not clear
that there is an issue with the calibration data such that the proper
fix is to ignore it. And I do not think this was suggested by TI. In
addition, your patch introduces a quirk for TAS, even if temporary.

Therefore, you should update the commit text to state that there is
currently a regression in UEFI calibration data parsing for TAS
devices, and until the parser is properly fixed, adding a quirk allows
for restoring full functionality in affected devices, such as the ROG
Xbox Ally X.

With those and as a temporary fix, this is fine to be merged by me

Best,
Antheas

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
> +        * ASUS ROG Xbox Ally X (RC73XA) UEFI calibration data
> +        * causes audio dropouts during playback, use fallback data
> +        * from DSP firmware instead.
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



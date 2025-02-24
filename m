Return-Path: <stable+bounces-119391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F17A42836
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C31818984A7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3E262D0E;
	Mon, 24 Feb 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNlGfNwp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFC1BEF81;
	Mon, 24 Feb 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415638; cv=none; b=KoOEVN20743w/QU71nCHXZTDJjx6CaIDXHGXa68Y3nkWsEQ+mpGKjK6QCaTze5hgtbQA53wS81rZdlbCLCXJXpRoDDWa63cJ5GKtysg1tSqQu975u2IoXHP1lD0PHJxbldWL6Ja++fhpE3VMof69yw0z0CSi13l2LhlDYIaIUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415638; c=relaxed/simple;
	bh=29fnPRIRVKNbzFOfOcOCwaSBpnAzwfE91BPmHThL2KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p063gZEYL64fnXd7OpCwZx7wj0UovvXYLNjYnHSNmhAzAHPPg7wzZ/S7uf2EQjVxkgzlFaTYuUyU5rg4L+zqXpGYXC4KW8JuU85FQPZ8BD5Eo+5J2Hfc59m177MBjKuwJF4AeuCs75TJLaPBpWzzSPqgqYC4rMrk39kOwaBCxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNlGfNwp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471ebfbad4dso38930811cf.3;
        Mon, 24 Feb 2025 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740415635; x=1741020435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IoPWThekvIvWOFk55jBvYQeODBj1rh5DumZCLt0nA4=;
        b=cNlGfNwpT4psw5p6tgN0xlq7qn9D1xzc3NBKfet/dWeNAtxzEksSHJDMAYsjvEvf8I
         35qI4YxFoz+EOaMa5NZoeHCc6GI9aBKLGSYDdVeVTNmVOI1Vp6ECBaDDynPGzs8Vtyx/
         E2tmXtEz2V/cuK4kRGaO1yS0eOQKgAzhNIc06anD8mzRaglavCTzLToLfrUq4X4QomPP
         G6+xHzqAQtg/7+u6D6FEh1jLMIXOlwUjEC3poJEEVRGptOf1RjuNnQwphQdn+Lass95n
         V4yJmTGtlc+h+AXUsgjog7cSkPHdJ2hwlndXp4xK0GKlxi+5oOv2Ld8tzkVDioIm+qW5
         9CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415635; x=1741020435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IoPWThekvIvWOFk55jBvYQeODBj1rh5DumZCLt0nA4=;
        b=arinLqM04AjXladakFVcHZWSWO1wVDGMmI5gFyBny8EhQH8ZTJpnq/0F55LFCNkSHI
         lCeovODSrIItLEp2fzacsNjY0E4iDx3yOZs3CiYhVcL/XhvZB0ZpY+y9DAbDV2jsjl3r
         zpixNRWrdrsSMO1S7sQdKw9G/WCSpk78criBAGeFC/PH3hR5rU1Mels9B9isr8LwTozO
         u8vHbsBDtcXUVMTsY4Zg92IAYQeTi5opdi3HbqqDaAgFTLXVInUWxKkBrG8wPKANNgDM
         X7uop6OIg+/ZxY0dwQua0hZa4ttewV/m5+tDr12N2Jdn9aNoF4sXv5sT9iI/AROnJ0NB
         IY5w==
X-Forwarded-Encrypted: i=1; AJvYcCVSoVaove3tz/FGn9XZ5Hz8/X5e6cj70/oguR5lPv/lfgn2NdbvyXH1M7qveH1ZHcm+5PEv6NC6vSQs9g4=@vger.kernel.org, AJvYcCWn4ENN9660GOpGFxabnbwd5nkzn+Dbw/V4HvjgTYpbWTUeQHG6kYS6eoCXuuj5s7YBQQtfrF5o@vger.kernel.org, AJvYcCXOBHm6Q9Kqhdycjs5xcn/NmCERgLNuB9/ySfoelVW2dD8hyCAOseTB0BeukHYF64Rm3foxeSMd@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTnymoV80H+OOmMrceLUj2arIav8kNVWP/WKcpq6rVhHZ2mdX
	WDY7xbnuaktmHo5JsLzm+yPIPVm3nUnHv6AAaVNAdTnT804z+/hahw3b97Y9RXF8UhWgKTnROn4
	dxisLsAp0ZB0i+2VRYTZE5buo+qA=
X-Gm-Gg: ASbGncvg6enj7W/dnzSBmHXNIiTiLU9h1Q9zRRFkkYHlLgOj/WE1NyUJjR51z1FYbds
	wfoem9RhPjL5gWR9fwcXuUP91ISfAgAMo8CRP8VqSTP6345bIGNgV7E4Qqbjrz3jr8nDfNlVZec
	26aw1/2s8=
X-Google-Smtp-Source: AGHT+IHSbDH7pSnwO6GsEjQFrFeVasSC5QVFjUMuBThuoRh2jbZm2bPWuiNqEyGeBE8fWU4Cj06UlNcw5p81IptyAT4=
X-Received: by 2002:a05:622a:15c4:b0:472:636:f5ff with SMTP id
 d75a77b69052e-472249079efmr162548371cf.48.1740415635488; Mon, 24 Feb 2025
 08:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
 <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
In-Reply-To: <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Mon, 24 Feb 2025 11:47:04 -0500
X-Gm-Features: AWEUYZkWw2mtNNOH6DjH1Wa6vuop4ep7V0bBgC7O-mOtZVbUhOuiYHUe7GYAUac
Message-ID: <CANeGvZVoy20axVTOd4L=d0rwgMWvH_TJqV6ip=_TaDNPJVEqkQ@mail.gmail.com>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, Feb 24, 2025 at 7:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wro=
te:
> >Hi Jiasheng, many thanks for the patch!
> >
> >>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> >>Sent: Sunday, February 23, 2025 9:17 PM
> >>
> >>When src->freq_supported is not NULL but src->freq_supported_num is 0,
> >>dst->freq_supported is equal to src->freq_supported.
> >>In this case, if the subsequent kstrdup() fails, src->freq_supported ma=
y
> >
> >The src->freq_supported is not being freed in this function,
> >you ment dst->freq_supported?
> >But also it is not true.
> >dst->freq_supported is being freed already, this patch adds only additio=
nal
> >condition over it..
> >From kfree doc: "If @object is NULL, no operation is performed.".
> >
> >>be freed without being set to NULL, potentially leading to a
> >>use-after-free or double-free error.
> >>
> >
> >kfree does not set to NULL from what I know. How would it lead to
> >use-after-free/double-free?
> >Why the one would use the memory after the function returns -ENOMEM?
> >
> >I don't think this patch is needed or resolves anything.
>
> I'm sure it's not needed.
>

After "memcpy(dst, src, sizeof(*dst))", dst->freq_supported will point
to the same memory as src->freq_supported.
When src->freq_supported is not NULL but src->freq_supported_num is 0,
dst->freq_supported still points to the same memory as src->freq_supported.
Then, if the subsequent kstrdup() fails, dst->freq_supported is freed,
and src->freq_supported becomes a Dangling Pointer,
potentially leading to a use-after-free or double-free error.

-Jiasheng

> >
> >Thank you!
> >Arkadiusz
> >
> >>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
> >>Cc: <stable@vger.kernel.org> # v6.8+
> >>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> >>---
> >> drivers/dpll/dpll_core.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> >>index 32019dc33cca..7d147adf8455 100644
> >>--- a/drivers/dpll/dpll_core.c
> >>+++ b/drivers/dpll/dpll_core.c
> >>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
> >>dpll_pin_properties *src,
> >> err_panel_label:
> >>      kfree(dst->board_label);
> >> err_board_label:
> >>-     kfree(dst->freq_supported);
> >>+     if (src->freq_supported_num)
> >>+             kfree(dst->freq_supported);
> >>      return -ENOMEM;
> >> }
> >>
> >>--
> >>2.25.1
> >


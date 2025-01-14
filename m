Return-Path: <stable+bounces-108577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C4A10187
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 08:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90933A46D5
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DAB1C3C1D;
	Tue, 14 Jan 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaJCx6h0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAE1C5D4B;
	Tue, 14 Jan 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736840966; cv=none; b=aoIfKWOi8/WMDL0OX26+JGGzMpy+XNMbQ4SvZdKhOTRyG/fXEkKML2eMWxiqFwHcOxUkPhs+P7fCiTYROV2X/RxXcNy/+u4FEEyvlM60L39d2dKMxGY4iZln3A4PfnjBJxQjraKMgd/8YC11LCkL2wiuogsbJfX7/tPwT1JY4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736840966; c=relaxed/simple;
	bh=mt/jtz+EAQtFXEfP5wBu6e4GCpLLB4qfjsGY2LHZyuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WULCWfD0qHRWjnlkrDa/NkacaI893E+oZSgloaS+CeIh6FTNVIuoS9G0Kfy3L3gTTgFCuvp/NcdcIqm4V46Lb+9glo07QPIVQ9h5pcy9W4GsoxL5P733OU37HBg1wWEd0JJThFr9xEnHjXBaG39lE8XmDMInBeu2oKOHi6KHdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaJCx6h0; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso36493535ab.1;
        Mon, 13 Jan 2025 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736840964; x=1737445764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwcueBSt0v4igogFveia71oHZaRrr/fkeR5Mu41YZ2U=;
        b=eaJCx6h0T/VztYmpHGNCq4QSvRhmXJZ0l+PsTAwF+93orAsO8CcYZznr6L513lt7Nn
         wAQjMS21u4GFQ//aEDMnFyRASV/5gLg7n17U4iHdT/1bCKd0ZpkgrLzq3tyYD8v62sbN
         2FmzSRKRPD8wjqu9wxYRUb00d0HhjZFK0QkWpYoOXKSwDJXjnEID/wYLWNRpwAnxwzE0
         6FtvWtXeQGPBuAigBAJlu7ez+Bjdi4yvRaq/2wPte+1xOkMuHiGwfshB3Jv1YPqAnlCX
         Z99PmVZJSf4P38Ivr9tzLeSQYqHkYDU4QUMtEvta0A6cNrrVrZgLQfotWGY4wcbY4Tzq
         mKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736840964; x=1737445764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwcueBSt0v4igogFveia71oHZaRrr/fkeR5Mu41YZ2U=;
        b=g3eRQ7toYHk3iUwkVWdBc3uBwZxySMh92tD65f8eNNkNWG4uyH0mMqvwTfXYkljsSW
         e8ikqvQh0zxmm4DuMUsLpm+AbT7AT07GRsiiQvklZEijDjR3yiUHnGG34uBvN0hxZ6OL
         9F1mxI5dB1Mgcmp1o9U/3kBfy+VxNoeGXNlAlbnJlQOtMi4QmmjbeMxNRCpjBIRIyJBC
         e1Zyyvv5KbLG0EQJrzuvLd9bnsSQZ4WdYpKb3ei6zFAlKUSzCkkLqqRJ9xr7TBldhEK9
         zW69lNpciyOJ5LyHRKNBOBFpnqORSMrM02MKichhQrclZU/rfPWF7/SlxYdLRptgcoCQ
         z0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUHn3YJbsW1vBPuxW7Fr0SNnH50LFTx3oa9HI211wsRNXVfuCMH9PP9sJ4TvS1G0vM78BrjE7syqYDY1fBz@vger.kernel.org, AJvYcCUNKglVCSbnkfI8gz9uZoQtuiGT54uI8GHANKrePTyczkC/oSD52na/AvyTKqWYbgBF30Oz42rt@vger.kernel.org, AJvYcCUbFB95lu2C1aQHtu8viScZYwnAQkUsfrbGRKsosP7o+tFwKxOGT18Hx4BBRZNghC0HuzJcoWKynFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcj3rS035RBvDEgi3WrovR8JVcJRk7rhGggcfKfh4HY2iTSZdm
	q8z4JSNhOAx/nxT6N2u8tO8iOPCK+Bi1r3bO/7dRpUs48mPEmqh57yjJ7I/SfUIBOTTw3e/90B4
	X8/ESPsYlVCIORYdrnxMEa3AbpPs=
X-Gm-Gg: ASbGncuUeoanSegE9gt4zCSxLdQ/Dm+Ts+YeDIG7+srpCOTDAVvl1rAgWZ65irLyKiO
	8WfRlGQOXTCEWtA6lGfm5wPq3KeIBiejR1Ci44w==
X-Google-Smtp-Source: AGHT+IF7DFFzOVv5hJRx2rOQ0X2GpsPhVUS6ku7AHMnjUUetYSaLVkkreyXpeUdIHpQEeAiftxB1brVoyB+IZRWgj4Q=
X-Received: by 2002:a05:6e02:164c:b0:3ce:64a4:4c52 with SMTP id
 e9e14a558f8ab-3ce64a44d8amr82366785ab.13.1736840964392; Mon, 13 Jan 2025
 23:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113094654.12998-1-eichest@gmail.com>
In-Reply-To: <20250113094654.12998-1-eichest@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 14 Jan 2025 15:49:10 +0800
X-Gm-Features: AbW1kvYSJoaJJYol0I1awhg4ecKmbyih-ivaEi2L6vs_lQ3XjVURqIPvv4zkPdQ
Message-ID: <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
Subject: Re: [PATCH v1] clk: imx: imx8-acm: fix flags for acm clocks
To: Stefan Eichenberger <eichest@gmail.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@nxp.com, 
	francesco.dolcini@toradex.com, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:54=E2=80=AFPM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> Currently, the flags for the ACM clocks are set to 0. This configuration
> causes the fsl-sai audio driver to fail when attempting to set the
> sysclk, returning an EINVAL error. The following error messages
> highlight the issue:
> fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.s=
ai: -22
> imx-hdmi sound-hdmi: failed to set cpu sysclk: -22

The reason for this error is that the current clock parent can't
support the rate
you require (I think you want 11289600).

We can configure the dts to provide such source, for example:

 &sai5 {
+       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+                       <&sai5_lpcg 0>;
+       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg =
0>;
+       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000>, <122880=
00>,
+                                <722534400>, <45158400>, <11289600>,
+                               <49152000>;
        status =3D "okay";
 };

Then your case should work.

>
> By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM

I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
the driver don't get an error from clk_set_rate().

Best regards
Shengjiu Wang

> driver does not support reparenting and instead relies on the clock tree
> as defined in the device tree. This change resolves the issue with the
> fsl-sai audio driver.
>
> CC: stable@vger.kernel.org
> Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/clk/imx/clk-imx8-acm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-ac=
m.c
> index c169fe53a35f..f20832a17ea3 100644
> --- a/drivers/clk/imx/clk-imx8-acm.c
> +++ b/drivers/clk/imx/clk-imx8-acm.c
> @@ -371,7 +371,8 @@ static int imx8_acm_clk_probe(struct platform_device =
*pdev)
>         for (i =3D 0; i < priv->soc_data->num_sels; i++) {
>                 hws[sels[i].clkid] =3D devm_clk_hw_register_mux_parent_da=
ta_table(dev,
>                                                                          =
       sels[i].name, sels[i].parents,
> -                                                                        =
       sels[i].num_parents, 0,
> +                                                                        =
       sels[i].num_parents,
> +                                                                        =
       CLK_SET_RATE_NO_REPARENT,
>                                                                          =
       base + sels[i].reg,
>                                                                          =
       sels[i].shift, sels[i].width,
>                                                                          =
       0, NULL, NULL);
> --
> 2.45.2
>
>


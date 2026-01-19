Return-Path: <stable+bounces-210275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A6D3A0E1
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 544503002B8E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835133ADA7;
	Mon, 19 Jan 2026 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2KWSMLJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BC27A10F
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809766; cv=pass; b=gkC/4gvgnMyLzanv1CLWsM4v7QbNPeCSsYg0VsAiXhWznRmSpOkalPTGjkjTIVXBULSI2oF9Ra9ICQsUu2pOq6y/IlXKJ4fdQGS2EHRMapVgVOXq4L1qhPyRUBC9wUpze5CuvtHe7AoyVM6ctuck5ir57o60TE4lYy06IARPAD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809766; c=relaxed/simple;
	bh=DAnMrLITq3eDfG7S7q6PfDGnnlrV1nfnART1Gfn3Eg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKkc8aRIV+EnGEVpyDNRcqOoCJ0yACZagNM9O7tNcdfc0PygJu2pO+YY7vjitFkEGO3lhL2+rWxysVJfQVngJR1Y3VT97gEzzLQgu0ujcsDNBzGgjNTJJhSxEs+Wo/u0SP2XGLs5jr7eUA26XQ5c4rR5TG2yOdqsd0+tTGqXNC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2KWSMLJ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so6043702a12.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:02:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768809761; cv=none;
        d=google.com; s=arc-20240605;
        b=QEy2MCe4QUmzdjIzWJRZCcD3l7sjbVuBbwZTK/dicKaCF4GyKu18Lul02kCpa6UhAm
         2hN8N0bPbsLQ+sTf21ddntziaEPnfuKRwMO4Fl6g3jiBDjxWjuoZi92aEWpTEIGyeW90
         Ta6zBDoerDbPWXTDZsGuR8QoMbvRjdBQuwTEUsaNfE3aV7LZ8wA6AC09avOA7CVP8Q3U
         5aprxTMNv5xoadZ7w2YNN16qOm4MeD6LmwAAOtW+6M/z0HBcbpnV+QRQAlFTLvQTotlc
         1FAt3w0tCqinnIaUUHPB0kSQnOPcG8Nwd5NKnecXtCggWSOiyVW5fh2cOAnIatt2kse1
         Pvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E5gMLbV/jw9kkirryyuOIwhlWMMVSVE/lAczumiLD0w=;
        fh=9GRW6o9PjFaFXN79pO1B69cTGoXXqlZX5edYSlNra2w=;
        b=a2wQyB73UTiBorM0r86e5aLMX3Ww8fDw4U0Jmx4V9fCl0UO/PJWD+8fBtgMc2A4CXA
         SMFGBWXfYiWe1cLGNYwCh+bJIvS0G/nzNo4u+/7LEWF+2wAaX/jgQHpccyPmsR8VP2lp
         ABi3n4GZ9mOAAHdRMEDUhTuih58lY2gynfBerWWfhT1JcMxeVCE/ky4P0pUPvLJTn/bL
         idWV/Sj//elyx8hl0X7uwidlBe3zy2eN7/sKEbFRQdfA5B5wRlOGNfnQWtR76vIJURW1
         DCBOy8jowGQzhk2GybIxhMgR3jiNUqkdXQVRniuTumbUpqT5CnCykFUQ9GoaQIF21T4T
         Fagg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768809761; x=1769414561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5gMLbV/jw9kkirryyuOIwhlWMMVSVE/lAczumiLD0w=;
        b=Y2KWSMLJiSr8UwtxLEg/2E3g6xGvjH8GeAo2fLq+zhGmI3BFvgKfSzv+Ev1+wypMbA
         NXJCv2+hzDhuQ7UYABmvIOt1yuV+k0DUjlz0KIWEwNE7HS1+HG8H8qAKfl3yS9V1GxVY
         lldr0wlTVTku2omz2NbvY7vUxjveC+nOxlIfpfapLnaKROtFhsvA7Wen3PLqVH6tmxDD
         GzNnJ4LmCMyWKF8r+xcyuzw6hpZvFyOqwv3wqNLSOZd0I1Fi5zgTYNG6ttOgvuXE/4k6
         eRkxqi44/0jQoAplKxcAMqZVKpoid3mdHXlsIb0A0Bx684ij6r/TtE3ugmizKnRJdUbx
         Zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768809761; x=1769414561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5gMLbV/jw9kkirryyuOIwhlWMMVSVE/lAczumiLD0w=;
        b=UWMdJnQGO0gCjkKOUJEvUULTYJ/QIKLxm69j1VUEoqgCv1p/txFNVbpJSi8o+0kr9c
         1wCKCTV6n4HCEO823uo1yNaeIDggcrF9FfKWJI1zIPv7iM3XYw9+0VwJMxCksw2oinbw
         FIC/qeml5+SwUuPi/K89XXydH3jwVgFr+BXAhHN4TeOOhrDmc6WzdeJaoenU6p27rgY7
         Y1MTtu5eEP2xrUt1qoNfrqAJAqvKJ9HzM8dCYZ7S5sTE7d/flNTS1/DhNaR49LUBqtrm
         I5qYkIqaNA7UARM8RfxHvQW1EoskhV7vEZrrbSljcJR6+Jtrut3snzbG4aNb6mczC3RI
         hacQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuid22j0FgjmsvIAPE1+J/FTmmYKV66ZjRPIk3dFVe1EIxbIuBgeCnFhlEOx9lhWa/rBDwSrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O6iAaxMRLNHB/1gplESHvE4ryZ1ntkX10yDU0PMEzqGgC7lw
	SM4MQTVFQscdi6NyqfYODJOn3wzvJsEXGQB9kLeHzu9xeO5Z3yd8rnX9V/6/ESrrfos42eLf2l5
	WhcdTn1LPekoIhxGymO3bbTRmK2JG6l0=
X-Gm-Gg: AY/fxX68w4+sWJ9jzHugPiLpVFv5cTVC9fLbXNQuFiLCB/jjaRF8RlUqIStoACDOj6v
	+uHj6vUFq8d9lpN0Kd5fRDhkviayAxYgGvB0kY6om/JW5YhbH9EaExUfyZV5pPdd8sE5O8ReCMc
	5AmfNaLu0afsMHtztklIVEF/fMdAs9gd3KcMl39U8Rh2GPCTK9l/V0cK1cTebj4RIjgFwcnQIgX
	OtnVWGcSOfsiL4LDbiQQaxpniUr7NcOlOsiC3fEa/w5hP+9sayzSicc5KVLa5Rw5sfzcZYt8ktH
	uJIbUm1QOGu0Xu4N0Rwf1x5lb0jA7NWUU3oK57u/mU8p4mGlmMSAI1X/opXCjgKd3r9X/QHQA6K
	pw8LtVp1o3A8ug+qavufcjkA3EkPBE5vS43LKhA==
X-Received: by 2002:a05:6402:2549:b0:64b:993f:ce05 with SMTP id
 4fb4d7f45d1cf-65452bd116fmr7271933a12.24.1768809761107; Mon, 19 Jan 2026
 00:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116151253.9223-1-jerrysteve1101@gmail.com>
In-Reply-To: <20260116151253.9223-1-jerrysteve1101@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 19 Jan 2026 08:02:29 +0000
X-Gm-Features: AZwV_QjD9hcUQzta7ih2I8JDpblRClcNe5NlO_infM0IaHOPiePu7HjjLZlFx5U
Message-ID: <CALeDE9OC7p6XMMwPk8_vsBe09RJHBK8KED=YAcykYqpQXzVfyQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Do not enable hdmi_sound node on
 Pinebook Pro
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, heiko@sntech.de, dsimic@manjaro.org, 
	didi.debian@cknow.org, conor+dt@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 15:13, Jun Yan <jerrysteve1101@gmail.com> wrote:
>
> Remove the redundant enabling of the hdmi_sound node in the Pinebook Pro
> board dts file, because the HDMI output is unused on this device. [1][2]
>
> This change also eliminates the following kernel log warning, which is
> caused by the unenabled dependent node of hdmi_sound that ultimately
> results in the node's probe failure:
>
>   platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error
>
> [1] https://files.pine64.org/doc/PinebookPro/pinebookpro_v2.1_mainboard_schematic.pdf
> [2] https://files.pine64.org/doc/PinebookPro/pinebookpro_schematic_v21a_20220419.pdf
>
> Cc: stable@vger.kernel.org
> Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks good to me.

>
> ---
>
> Changes in v2:
> - Rewrite the description of change
> - Link to v1: https://lore.kernel.org/linux-rockchip/20260112141300.332996-1-jerrysteve1101@gmail.com/
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 810ab6ff4e67..753d51344954 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -421,10 +421,6 @@ &gpu {
>         status = "okay";
>  };
>
> -&hdmi_sound {
> -       status = "okay";
> -};
> -
>  &i2c0 {
>         clock-frequency = <400000>;
>         i2c-scl-falling-time-ns = <4>;
> --
> 2.52.0
>


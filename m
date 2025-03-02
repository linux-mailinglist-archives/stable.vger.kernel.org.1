Return-Path: <stable+bounces-120029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B4A4B521
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 23:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9C16C75B
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CF1EF082;
	Sun,  2 Mar 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiLKLSTG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400B1EEA5F;
	Sun,  2 Mar 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740953058; cv=none; b=h4nxuc9iXEweKJKJUQSxzAkDXq3FpUvW1WMu8a3SyHenAspP0KA7FSsmR1vuLtngcY96yYifCHd/sZf+z375V+SJv9+X6X4EepmQm7CMshKJ2wx58aUiCNX6sH+VZaD9XZf81RAahaFeva8aqlUoQ4l2VrFpgGulIJ3F38eIiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740953058; c=relaxed/simple;
	bh=G0vMHYKIc2Ay/+1HRnlZ2jVe2PJ28hKX7lpNtJythFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EefZr0yGxu5rOJMpfiDY5GH8BVyug4YKtPusRpE3spKkTUpkXMGPPyA52cNjIejCRkdPfgkCfnrtbgnVH3rRwqAX1Q4zhHptM+BeT4OJxoCkgZQTClt637dCXUSSWCsXkG8Ucf9STJlw3fxdipSN6e5f1pecm0DWVGC8eNB/Ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiLKLSTG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so34160005e9.1;
        Sun, 02 Mar 2025 14:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740953054; x=1741557854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZsDVF7No2VH4zL0xV0L3RIQPevYbpgbeUgOON9v888=;
        b=aiLKLSTGC/KWit4QDzAJsiSA1HEcNSvm7e8YdJsl4e5PEozjSAPAOqaLTH1ALtyuBR
         p1cy4SqiOSbgt3gFQOpRB04dCA4TkfZvBrJHfewTIvc7f55p8B7D5rAqx/QiG35kXxB/
         OEBRtAPqU+2CQpJgENqUCoqyytfnsx3xjJ3+urPYzgwLLq9dr3aFAsfijMVAqxe/aPtk
         deeJzLzClpzorHr11V6ttne0g0xpMlVrgn9THCcH2/hrw69ghVi9Ltgn4WzD3pVTJs8+
         QoT3w+T/FEauPDkZcdRwJIR31pe1F7A623LCk1cYKp/CTj7H65t3djd4g0XyuW/pCCKW
         bcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740953054; x=1741557854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZsDVF7No2VH4zL0xV0L3RIQPevYbpgbeUgOON9v888=;
        b=mCCjP95B00lDsc8F2kuIjUUFtGyucDHu/M6NfsRCbLbZSXeZ+TWe2Vh+etNpSdjYc2
         LAwLsB4GFx6/KkvsQnFXXSMtXct70n3cFai2QYo66CK4IFigxNFT/C8yt41+/lMB64aY
         8T6Q7k5KAtXJbtHnRk2MkE5DBBLEf/PnGN3SVOapm4mM4DbkwEzi43yv4U4J79ZCnNCO
         Zwey9B9xsDG7PaiORA3CXhqpqfyyoAb2pnBJevof235twhMIQ3d8c43/VdHN4O/hk+15
         GJtGr67+zLiJKxVlebLvme/dP57vbXwlrmtAYPIIOjxottOtp9GHSy2rVMt7Y8jzqT+u
         W69w==
X-Forwarded-Encrypted: i=1; AJvYcCUShRwHU2EZ6f6hzFqRfQ6hgJRVmXKzFtDRIpVW5fr/MW++bQ6vJ4EMcs4+gD5NLGiHsNAAxE1eW8B4@vger.kernel.org, AJvYcCVvY+hlGfrthHcWFaOXOL3fLMZyj7m4+FTDMSf5FwXHrmlqZ8PsgfWX0CB8vK34AyRiqWj6dcCR@vger.kernel.org, AJvYcCWRzfQ2iA3IQYaA5TU7V32Lyr4JOSDsUgqPxyOmvmyM21A6yXDBIOLijDkZNjM9rjetNQtO+GvT5Iy+3LNk@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOQz+sLSlIS61wXg4/1B/JeXcc40ON7A0fngSRxA1Bb1uSZQj
	nSKSdh1eMQQO7ZYce/QqtJdC/aoQYztY0WgDoJYKOGw9mFsfp2zChDRwTXfNNFZOwnV81F8qIuj
	UrpGUfwLWK1DDGp+u4TgmCDqpw4Q9Xjk=
X-Gm-Gg: ASbGncuaQFnc01gTujg5Co/tLIbXalVOuBjwtNzPZ7KuSWRCfW3+tZ4bDMtIB/xoIFV
	tE42I+SLeTkIud+EW4qGECh+quEKqsqgc/YGqlzHp+LpLLWawMDPusln9DBgH/tvFbbxUmEg9P6
	mlUoA1+fCbrA0xbQy/JYPPW0bg
X-Google-Smtp-Source: AGHT+IHbf2F3wgrK745iu/slJiop7/BiO5rszzCiQCR0Q9CFsjReqMAjl4alyqu3WyHZsqI9eW+pqAIq45IKjh7/6jk=
X-Received: by 2002:a05:600c:5494:b0:439:4700:9eb3 with SMTP id
 5b1f17b1804b1-43ba66cfe3cmr88337165e9.3.1740953053930; Sun, 02 Mar 2025
 14:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227081357.25971-1-johan+linaro@kernel.org> <20250227081357.25971-5-johan+linaro@kernel.org>
In-Reply-To: <20250227081357.25971-5-johan+linaro@kernel.org>
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Date: Sun, 2 Mar 2025 23:04:03 +0100
X-Gm-Features: AQ5f1Jqzczj1wRss2EFO1WmYdsU6tQlXhWuUjnd4EuAkHlAIiGwHaq3WMgLV_O0
Message-ID: <CAMcHhXp2im-55KxwSUj0pV_hmrg-HaV5RYB4jvPOoqOYjJuCYw@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b
 and l15b always-on
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 09:15, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The l12b and l15b supplies are used by components that are not (fully)
> described (and some never will be) and must never be disabled.

Out of curiosity, what are these components?

>
> Mark the regulators as always-on to prevent them from being disabled,
> for example, when consumers probe defer or suspend.
>
> Note that these supplies currently have no consumers described in
> mainline.
>
> Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
> Cc: stable@vger.kernel.org      # 6.13
> Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> index 86e87f03b0ec..90f588ed7d63 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> @@ -359,6 +359,7 @@ vreg_l12b_1p2: ldo12 {
>                         regulator-min-microvolt = <1200000>;
>                         regulator-max-microvolt = <1200000>;
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-always-on;
>                 };
>
>                 vreg_l13b_3p0: ldo13 {
> @@ -380,6 +381,7 @@ vreg_l15b_1p8: ldo15 {
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <1800000>;
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-always-on;
>                 };
>
>                 vreg_l17b_2p5: ldo17 {
> --
> 2.45.3
>


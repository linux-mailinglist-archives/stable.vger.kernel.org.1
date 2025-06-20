Return-Path: <stable+bounces-155008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C2AE1682
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77857AF896
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536D24DFE4;
	Fri, 20 Jun 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVwdrFY/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E9253951;
	Fri, 20 Jun 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408861; cv=none; b=FIsjsBBTWNaMqwekx6p3dW8oI4GhU/zZwbRKsDYT5ujpEMOVgBaIbhaIRsEX+gRbgNUiQGoylEOgP+/bfNO2CfMrPbWMs0M4nFZAHnrzu/19hT0CF6jjzQGs0HGgGdNPRwiU1/bzHYxQ3qmb5OvaaZEasdY2zs5SXeDPi2YiYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408861; c=relaxed/simple;
	bh=l0WJerzI2FKlTiZkjLsDHwtinoN8RrzlFcZl7zeIW84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3R2/HhYfUGUHRllQS7Cdi42Y2qG2F4a1wloOuSo5zm9fCIdUBYPKcHkiHdoyNVkRI2bnckAp/goPPIm0KG+ae/B32Rhb19VGMulK/pnA0GDJ5va9jKBDxz/T7dkzffT+UgSMOpvL0WB2ToOU1AFssB/3Y+jIg0pulZROluZXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVwdrFY/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a6f6d07bb5so17689151cf.2;
        Fri, 20 Jun 2025 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750408858; x=1751013658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhJ28lUu4tutQ9PFgn6HlLDINbOKz5/YrrzszsyspMw=;
        b=NVwdrFY/ksaN9wyDGiKyyB+bOdeZl8+T35+scnSYn7ldgy3bCMrpSRdo3kaVT7GpTT
         a6W0Gv8T2cSu8G5A1GpY2wCJKkjIbpa0SdJow8c0hv9Icay70HldDBUwXrcAMEgof3u7
         3sr/PXpc1JkcMrGd01bHU7aLE5cyc9gFH3/EPezTjQFaP8JYYekPGE2ruJ4cWT3gWXBQ
         ofJLLCE3V7d2OH4n9y3h7bETiN88t76J3gvxPXYgTIdho2E1Ws5x2arwkq80LLVg/MOn
         I1HSm5m0CP/6j3pO9jCAChpzrxh6ievFLLhYHL1g8KpDHmww68Tm5o/ZSdAx/VLznrif
         Q4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408858; x=1751013658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhJ28lUu4tutQ9PFgn6HlLDINbOKz5/YrrzszsyspMw=;
        b=JwdtbHOFKNu86cFRW+wT/rjtoO8u4hIDRDkEB5/oMIi+BlWkY9jrk9k7am6kFmH7uJ
         H5GR0Sp0r/3QPzsRAPjVpHTw5KyDE/nRGfm1xIJRH/MxgNGF/ewaK7vs6Ac0XWXU4Sl5
         /xsxlSETYUtOvGBY88yryeIfi6kJi8mLHAXK2Dtd6QJnfoW7JnGAZcpNnyxO5Zw6G/CU
         DlFV7LzvWhlT6Q+7HG0sftXKpMCglqAjjLeyfxaNHDGsuO8c5cYEgfiaOF6Kze3qTUiu
         XtC6Y6URMCIcDzLQ879wEIfgKH5Vuy1QuU2zuJLtfu8pkDXhah5/F4m012YOkMAuaaHO
         pzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/yvq/ZlrHDnD80XmMGrLDA27Fb/pqT7dylRXkkh25gKVUijYwZqrau5vbHsE/WL1MV/WBPv2@vger.kernel.org, AJvYcCVmhpbp/f2N8ZUn0QeDm7fxynF8Y+tOtZoW2bF9GKn1I3dkQTI+2Zo8spOwQJvZUHWv0aYA4U+nySufdUbR@vger.kernel.org, AJvYcCX5N8VFd0L6uoouOSOxZcsFE5Ty6WhOofNfgPHj/J/CBwHQ46su3hWNu/iO36QEJH5ldQNM5nYnCS/p@vger.kernel.org
X-Gm-Message-State: AOJu0YyUypkyITBCwF/30M7GpC+V0QVJIgIiNlx6UXGVKpkWqlkE7I5S
	MHAnrKImp2pzAlf7d946QUKN3ViEJ9oTVxX4v3JuRpRTDb7xc+nWZp+CmgsUzrBwD5bAp2iI2S7
	GQzvDNxdhILqpCjyBY/BuFTTd92VHB9s=
X-Gm-Gg: ASbGncs44QO4HMltWUaOuYEARhoHdom0zOvSboxFcazvcpWk9U8epVVI3qoJSsw3Rqj
	0Ua93g4uj7B96gPjKcrgrSAal3sHbCd8llyaz7Uth3wkFyO/DGX4/LHc8DgX/lwEk3G22qtzEtp
	tZiz9tE5oC9nL1kGE1+N7oNwXpLco3Ot2yVa/dXeFOst7S
X-Google-Smtp-Source: AGHT+IEk9QAe1bgLQ65TsS0eFYzhtXpG1Dw6rWlKdy3d7hwrH5nqqmF5IjgTeOnwx7f0dHroCwGo1uFKO/+rc8rs2tU=
X-Received: by 2002:ac8:57ce:0:b0:4a7:74ed:cd49 with SMTP id
 d75a77b69052e-4a77a1c4b80mr30180401cf.19.1750408858127; Fri, 20 Jun 2025
 01:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com> <175036770856.1520003.17823147228060153634.b4-ty@sntech.de>
In-Reply-To: <175036770856.1520003.17823147228060153634.b4-ty@sntech.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 20 Jun 2025 12:40:49 +0400
X-Gm-Features: AX0GCFvyM96QmV7htM0KHUFL5y6LOg8SAG7kA6gR9Sm54nshs6x8Ht0AaNoM6u4
Message-ID: <CABjd4Yzz9mh0G5BhpPOGAoadD-A5eX4kdsF8rGrWk82hAE-MYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further peripherals
 on ArmSoM Sige5
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Detlev Casanova <detlev.casanova@collabora.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 1:17=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
>
> On Sat, 14 Jun 2025 22:14:32 +0400, Alexey Charkov wrote:
> > Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.
> >
> > Different board versions use different incompatible WiFi/Bluetooth modu=
les
> > so split the version-specific bits out into an overlay. Basic WiFi
> > functionality works even without an overlay, but OOB interrupts and
> > all Bluetooth stuff requires one.
> >
> > [...]
>
> Applied, thanks!
>
> [1/4] arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
>       commit: c76bcc7d1f24e90a2d7b98d1e523d7524269fc56
> [2/4] arm64: dts: rockchip: add SDIO controller on RK3576
>       commit: e490f854b46369b096f3d09c0c6a00f340425136
> [3/4] arm64: dts: rockchip: add version-independent WiFi/BT nodes on Sige=
5
>       commit: 358ccc1d8b242b8c659e5e177caef174624e8cb6
> [4/4] arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5 v=
1.2
>       commit: a8cdcbe6a9f64f56ee24c9e8325fb89cf41a5d63
>
> Patch 1 as fix for v6.16
>
> I've also fixed the wifi@1 node in the overlay - which was using
> spaces instead of tabs.

Thanks Heiko! It's annoying that YAML doesn't like tabs, so copying
from binding examples is not a universally good idea :)

By the way, is there any tool that helps catch those?

Best regards,
Alexey


Return-Path: <stable+bounces-161540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D36AFFB9F
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8CB540462
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6228BA96;
	Thu, 10 Jul 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QM/f/nhT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F728B7FC
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134553; cv=none; b=MMF6xcEreKsmVlDQWjiQ1fYX/cSCVgQd5GNRjE2iKVzeWPLWe7CGxu+MAvo6ciBBueMOXlioCK4/1vNaBhYqORuZvDtdYvSqHSH2uJgq1TYkZrZuX0P3U8Jm8ftMbLS8KYttMxUHZ7g+0KUejnC5aK0eiRnwUVMCdkyf3ddcrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134553; c=relaxed/simple;
	bh=GI1VtsjhXtrT2WJCXUGzz8y+u1YIjjmIvhsqRtpRE5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqMr4pD+4/5pxuzeVDr9Veoqbq7D6+X4hs+N3cD+xK9UZxm3YaEwqSVN6PkiP3i5H3kvujg4nELl+NwT7z2sups4xMrwVoy5f3NpPYKEt0iCoDp3oWJdfKJ6RWieRLYCb9Ta1m3Iq9PHVapxaaere2g5flMLAWUq0NpAKjXSN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QM/f/nhT; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-613a21f23cbso390790eaf.1
        for <stable@vger.kernel.org>; Thu, 10 Jul 2025 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752134551; x=1752739351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK8V0E4Xdcf1fTBLfVQvRq2RbYuBxS2NIoLWeiVRMmk=;
        b=QM/f/nhTGoNX/dujdKiWSA0gopxfVH8y6AByu3UsNULK7DFGM5kNRwRsmKlBeCv+OZ
         LqTwcT60JIlQ0MLUXDQx/UYVhjnqGnmoUHg0cxtrT1uBdL0GUSrZgIJ2/o+N6vk2EeUU
         aki55btiFyabMavvGlF9ocVR7BNNdV89uws+rPpZhmROdx/Id6Att3kBZuZZ7VXdJex2
         E6JeresC3g4MN4CbUHEb6HxqinQl89V9SDM1ecbJjfNgGs5dKi0ldhgHOTOEaocy8ZhZ
         n7IpeqA+OA57n1SlD0MBuVRCLUXqdFbZZzhi37AO2P1owI69TFguVoUPmKtAh1o0RXnh
         zXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752134551; x=1752739351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK8V0E4Xdcf1fTBLfVQvRq2RbYuBxS2NIoLWeiVRMmk=;
        b=E6+vjZe81UiCyDv20N35IaC9vSJ+Mtj8qgnfiBonsz53VbbozunkoyzV9F7AlA+Ihl
         P7UBWiYhQUngl96tX0iHfAVvWU6vcVCm47NdXDtD9UmPVDg3Z3/VgXsh+f0Mr7UBkzct
         b61Dyd5Sg/Y+4zxFinC1yAccvbY+FV0qwbStg6TmeAWerHkN7/rWbcSAK5xRaGM7lVKk
         rhDFCeSP/Hcynk5utdoIMmxO5059Xk+gF/k/mvMJEI48KIhxbiO0NrSi698WgQtEZz1f
         5PFEzC8clUL8B9WQ3v3BFoXVIcHRa1ApTC5kksIZwXAPN13ujRjC09XojPNwOQlTi3Yg
         HyGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOrhKIvzGAz/eyZBSLg1oB3aBkTDvjCelg8TNKr+6I8n8WaW5RX83su106f7k2jbc1tevWjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyU/ppCgjQsKBHi6Fbr81OOGaLKLWK27/QfPz3XoU6on77EHUd
	vwYiRN0F5p5qA5s/ShWzA2LXtnSL5joljVyEnQ6h7JIrxX0HK664EBsviqmFT/7WaUCswcmdzm8
	3mMUTJAQyXkkvhdelppNNt/3bviLbkILSa0WNiaacvw==
X-Gm-Gg: ASbGncvVQxCi1aUP/rKFZF+NeW8SmvU+UsBzWI/5UdIZ3R5rWmcEJZ6avrL2S/RB2no
	H6jGWsii2RfBmsBtF/5y9sWlY87g6lz0XT7irq/t/3p92/Qk3OwZVq3xNTUYRhPZLfGo8JHiAG8
	UDKNMlK2oG+ffiMQuPOQRwj/eLa8Cc/eOM6l4sRUcwFt3OtLRit24vQg==
X-Google-Smtp-Source: AGHT+IHrFLYymR6F7UKamK/gjTFOEV/FWv98kovyNcG7HeAzZOtkYSEipfwxdZEaT2lEQ5TAU9vcD7JJ0ogSkLcbVfA=
X-Received: by 2002:a05:6820:260e:b0:613:8176:8a00 with SMTP id
 006d021491bc7-613d9db2e43mr1002071eaf.2.1752134546426; Thu, 10 Jul 2025
 01:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
In-Reply-To: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 10 Jul 2025 09:02:15 +0100
X-Gm-Features: Ac12FXw14Fnv-NHIV6I5KCDE4Qv3eilf3MCfG465JBU1_Jo35wVeJqk-I6YsdjU
Message-ID: <CADrjBPr_7NL4jFY=0B=VN7+WtxHrFxGvvqg0AnnPY_P45dtngQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: exynos: fix programming of HCI_UTRL_NEXUS_TYPE
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Seungwon Jeon <essuuj@gmail.com>, Avri Altman <avri.altman@wdc.com>, 
	Kiwoong Kim <kwmad.kim@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Jul 2025 at 18:05, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Google gs101, the number of UTP transfer request slots (nutrs) is
> 32, and in this case the driver ends up programming the UTRL_NEXUS_TYPE
> incorrectly as 0.
>
> This is because the left hand side of the shift is 1, which is of type
> int, i.e. 31 bits wide. Shifting by more than that width results in
> undefined behaviour.
>
> Fix this by switching to the BIT() macro, which applies correct type
> casting as required. This ensures the correct value is written to
> UTRL_NEXUS_TYPE (0xffffffff on gs101), and it also fixes a UBSAN shift
> warning:
>     UBSAN: shift-out-of-bounds in drivers/ufs/host/ufs-exynos.c:1113:21
>     shift exponent 32 is too large for 32-bit type 'int'
>
> For consistency, apply the same change to the nutmrs / UTMRL_NEXUS_TYPE
> write.
>
> Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exy=
nos SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>


Return-Path: <stable+bounces-124612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684FA6446E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB2170E98
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44221B9E4;
	Mon, 17 Mar 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq7GFlPE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C021B918
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198264; cv=none; b=pes0at4NB7kFblSDBlNEX6ad4DEBc233q6i/UaOCWoqVLoiyaJcHKyjN70aWntG9rJKCZQBbedF8ZwMIGdhrV0JcftHoDBEJmY9Gu5XMb26o3eYfrurrpnrtJQ0F/RTFGZWIH+FI7Zll92HPtNzVlHPG6jv9SqaGE+NhBgXpaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198264; c=relaxed/simple;
	bh=PP5ZjBbMb4rni+tuZHNcnT/n1v2QA3RZnXHRssAeFG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoXSWDz4PtlR4xl5BHPJ6+/CWCWDoatW+9XwkDSFJV0yEsfbEBLTHRkV6snSUOVNl7nAbJs8aAMYxf2xcbFBblHeZ0DlDCk7LkOSVTnGCeGTwzxW+PD2yS1QTfpZ5Lqie1l6Kjm1lRgNCLDurq3X5ziVwDzQqo7ltiCxiD1z2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lq7GFlPE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72a145521d6so2968577a34.3
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742198260; x=1742803060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PP5ZjBbMb4rni+tuZHNcnT/n1v2QA3RZnXHRssAeFG0=;
        b=Lq7GFlPE4OX23sxWifNP1Qiol6895OF7ONRrAE1CAJpzuXwG/HPlPoSScQQb3B8L6F
         Gt7PGsZXbJ/oUYRzNfBCx+6GvszxlxDad7gNBRVvoH0+XJ4RD6rkJJ/Nx/VF9RkSmKfQ
         c/PWIqsk/e1Sh7iqT93Z4Edfr2RV506rMPtu8Q990iuqdQFuE0t2PnJZEp8eBw2umcof
         nlODuquZOCbnWd2LIm0JrnEK1cXIyGml0oDPeTqO5ZN6OMCpizksot7lvAclrE9XORVf
         2bWB4qPr0DyrZHczVcmhYKrFXCzJIl6KSKYzq8PgWOBGWW9MicfPvlERaLtXxSVfB/dr
         Jt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742198260; x=1742803060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP5ZjBbMb4rni+tuZHNcnT/n1v2QA3RZnXHRssAeFG0=;
        b=Im/KTyAyGHbvWTD6XkMv+Uuav0gPYjwMR+N4xhvFinZZAIe1H68yRwMIIrdMGN0Ztp
         i4TEr8mlNBBZS32CkzFpPSnkxoc3WzExdLY10WhJFAymLQmW8r09ChAH/mE/etAH182c
         B8azvP0kXICGdSCf7MysaWkXFdau5zeq6rt3JTtrEueu84XiY//ukZuVvdg6rikmRz7b
         Y1pEc8PvB+UaFnNtQMtvVkb4zpMGfEOTG6FmnZ2gBcshpO/+NTLTReicLeVxWBpDDva6
         BNfgr/954K4LGsYMP5BdE6uEekDmdoyZXMK4+Ck5/vokkLqqIVz5fYq03JZNa1PeoNLR
         Bnvw==
X-Forwarded-Encrypted: i=1; AJvYcCX+6fUbfhkJeQ2E+sPS0cSvfh3tsNB+6xiHj6Zd0nvAGPMJWqqiSMiwqFL/sxPU9P3ZQRvBKX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXaoRfBvg+qS/Jcqami2UlqOzoF+8WTCPDGHKVFHQh+6qlsiL
	CqY1216NK692SIMU28mKBbVgekMc5oxRSFJlLbib65a8Z5NKlnRH9nMZm5PjQJ/N91RGWPXKj8g
	/aThYu7RmdJchkaTAiOkg73mBl/eg0i4Td3TDDw==
X-Gm-Gg: ASbGncvviOx1SUEyngjnAwMeAxcRv1/f0rRgktRZo7BKX5SIv0k0jVrxsmDGkKJ4Jv4
	NUONNQFXE4LiXq7o/8O4ibepXis+bvheggWRmwyPXuIFbKTIDYelEjDlfjN8Ug56B9GgaAywScp
	P7WkvASsiTvcU1ewYRRCtwEfJrs76Q
X-Google-Smtp-Source: AGHT+IFXhiV5/jjRM3lIL1BjJLxFk/oc1h/PBdMxRCXg6fQlEslHNKm2pE2ASn+LBLRiqcHrD7Lf49zKnfDqLjjJWKY=
X-Received: by 2002:a05:6830:441f:b0:72b:782a:56d7 with SMTP id
 46e09a7af769-72bbc5222a2mr5673623a34.23.1742198260554; Mon, 17 Mar 2025
 00:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org> <0d7a8cad-adfc-4cac-bcc6-65d1f9c86b43@acm.org>
In-Reply-To: <0d7a8cad-adfc-4cac-bcc6-65d1f9c86b43@acm.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 17 Mar 2025 07:57:30 +0000
X-Gm-Features: AQ5f1JrHrLaWNOaDw_CRYMU3X3v2oxo4LzPuW31oNjLmnPoqXZ9Expwo9ns7s28
Message-ID: <CADrjBPrU1Prw9NmWrVQff+X6VTY4PXEr_BH2Z0DuAr=uiaOsGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add dma-coherent for gs101 UFS dt node
To: Bart Van Assche <bvanassche@acm.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	kernel-team@android.com, willmcvicker@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bart,

Thanks for the review.

On Fri, 14 Mar 2025 at 16:01, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/14/25 8:38 AM, Peter Griffin wrote:
> > ufs-exynos driver enables the shareability option for gs101 which
> > means the descriptors need to be allocated as cacheable.
>
> Shouldn't that code be modified such that the shareability option is
> only set if the dma-coherent property is present in the device tree?

Yes, I plan to add an extra patch that does what you describe into the
v2 of the UFS fixes series [1] likely later today.

I sent this out separately for Krzysztof's Exynos DT tree in the hope
he will pick it up in the next -rc as this patch fixes how the driver
is configured today, and is also still the configuration we want once
the driver changes land. I should have made that a bit clearer in the
cover letter :)

Thanks,

Peter

[1] https://lore.kernel.org/linux-scsi/20250226220414.343659-1-peter.griffin@linaro.org/


Return-Path: <stable+bounces-165022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D32B145E8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 03:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B65432E4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8581F419A;
	Tue, 29 Jul 2025 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh6UJOYi"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940001DE4CA;
	Tue, 29 Jul 2025 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753279; cv=none; b=rUDykNzrHzoAFVAbidYsJ1V1Ki+nEjgF+mFvHi9TiVOWOEZAzSh8Hqh2kP76MtvGMLnUm4JARk/Vy4DJy+OXTYWrv6j1taxp4Abn1NdRNRbKaBQbqL7iAeGIJqrvvTnB2B5OT7NGHduSVW0GjHYEgAWG+YXuFRQSoFGpm3eDKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753279; c=relaxed/simple;
	bh=ChRHoBucNmtnYuMLvWLunxMPAZIA7tWr59Od276cfto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOIOEmHd69yCh7Pt8ClUD6ApwEodbF0clgGd9om07bchXp3zyGabsKfk8hiN8mhhSmA14+Ap8wcEQGI0kMcoZOiV7VZCdx+NjsuAmI0+0p5km/FqNPuGDoCJpWiiorKTHr1gMsh4ZRt1rSufp24lLHeA0rHxREabwN1RHEEKwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh6UJOYi; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e7efae1bfdso1575648137.3;
        Mon, 28 Jul 2025 18:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753753276; x=1754358076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTE78ChE+vquBrI5YrDGqyKJDHj33kW+vj6Lk06X/sU=;
        b=Gh6UJOYiyeMuiAlbDmXPcwegvprxkYM/mpyDlMltm6WS9JoxhWrnAwhwrqglReIShY
         sJZTem4S7ei0QWJukJMFwkpGjBv0dX3UCxUZkPfWLeG/D4UcAuORvnYaX45ji/W3sU2T
         Cfadkv4PilbF3rVJl0tHEMpKQPwmjhp7eBGKvdvIwN6ik0+7nO2Ueke9lBLHQsflYnNU
         4YeNI77+8d25uJtvbypM8DlzoKj+8TKDbvDJ/wy3SsZFqeNJuvHI6TkRyhSwK5opob+X
         JFIi9swsAXNpCar/A+d+tMvkhz6W/z5zjEeSPBK3MQhvdGVEhAkqEAqGL5DW5HG9Mqxi
         OBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753753276; x=1754358076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTE78ChE+vquBrI5YrDGqyKJDHj33kW+vj6Lk06X/sU=;
        b=tRsqRqhUP/G++AWYa1EVfhjlqF34R10/GgAKSIThNfbkO7ifUq0ruzW/yC0TG5ndNX
         ruVHcRLamDpAYT9M2DA1GWzNF2robbAFsyQ+ODk68cWGWsYixyYBwZuszmRock+XQ6AX
         kDksi34p6o94k1K7dnawEbSXQLDUUJGyzsaT8jXElmgp42xhcXlxWYJ/czdvyNK30Rmu
         mel4JAPH0dTAULowy1+veq+aLbVdbLgqwQjMS+bQPyQQR3FIGfr2dHlUiHzVx6V+MOGu
         /rd0jVcmXZ5FJb97hJW6I7272tcNrPhFmStb1BAqHv3qyGM07Qgp7lm6m1o84Q5pwtPK
         kJPA==
X-Forwarded-Encrypted: i=1; AJvYcCV86rPOD8GKnadevEPh/G4jw8ooNvuJ4tGUJrEW8VDDwXrsVxhrOdfJ/SVf0wHViAivZl8g0lVsrabXgin4RBnYjoE=@vger.kernel.org, AJvYcCVdITpbjxf5XgI1dK8atzS5CkztRamBLtd9qW4OpH7cvAZ2lSpKTNge+Ue9m6ZqKq+o5GA0SccBe3Yx@vger.kernel.org, AJvYcCX2oMMv02qRLpIej3KfSWmunjEsNye8Crc5Cr6KvfOT4MRFF4Boz1ej//qTI2pzVUkyfOTMSEUs@vger.kernel.org, AJvYcCXGBqMpoaj4Hh9/rTf7IMz4ASBLYWh9y3BNxZtoq/s4DLQGOH44zodtMBp2YdceBtz1akzttX8AtvE1Vj3E@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmcE6XPwgefJRc973l9QoYVeokTmcPtj6HGQ5sV+1bSXn4LF7
	HgNeKRbmeR6jQeM3IH4VumHgqcJQlP4nDBJb24BN0mdgfxnd3pAzKF7qE155RdHqpoQz9u0Ixih
	O9JtfOB+/0Svfpes7y1C/Pjk+9BYKeiY=
X-Gm-Gg: ASbGncsGO/g0YuPj2Td6+hHkZms5pgMdM4PLv5Hf+YLAM5hDNbruApbtJ/1zWe3CPD+
	gjRw+JbQ42VeLCicT2j/RsTJ0UbtzotPVZBYzcRSeV/AodnlExXBpH+s0MwuRq1qQTfXWUJeZYm
	5Fb2bCnrT7kP0dVv7u5uJfUsyESHsbSotCBOSokVXPJcMy90IAsiXADLYKT3i44CVnvEgww4ym1
	QwByw==
X-Google-Smtp-Source: AGHT+IH5sSaz4kLWBjYQ8xg5A6GoRN5L+Q3qFpxAbI0in2TfAspkDTFwyyOI/F2e9j59D50tjfOZG4mczSkStSE5wG4=
X-Received: by 2002:a05:6102:8024:b0:4fa:d2c:4fe with SMTP id
 ada2fe7eead31-4fa3fef74c9mr6797567137.26.1753753276427; Mon, 28 Jul 2025
 18:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706-exynosdrm-decon-v4-0-735fd215f4b3@disroot.org>
In-Reply-To: <20250706-exynosdrm-decon-v4-0-735fd215f4b3@disroot.org>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 29 Jul 2025 10:40:34 +0900
X-Gm-Features: Ac12FXy-Uc3aIGD_z-2Hmjo9PpVFm9Hawvq4wg2d1-g_c1M1SQ84nY0S7pRIJwA
Message-ID: <CAAQKjZOLZw7e1G56i29b28L0NwOM=P4eZtcNAp2vFpe3ck958A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Samsung Exynos 7870 DECON driver support
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi  Kaustabh Chakraborty,

This patch series has been merged into the exynos-drm-next branch.

Thanks,
Inki Dae

2025=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 2:30, Ka=
ustabh Chakraborty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> This patch series aims at adding support for Exynos7870's DECON in the
> Exynos7 DECON driver. It introduces a driver data struct so that support
> for DECON on other SoCs can be added to it in the future.
>
> It also fixes a few bugs in the driver, such as functions receiving bad
> pointers.
>
> Tested on Samsung Galaxy J7 Prime (samsung-on7xelte), Samsung Galaxy A2
> Core (samsung-a2corelte), and Samsung Galaxy J6 (samsung-j6lte).
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v4:
> - Drop applied patch [v2 3/3].
> - Correct documentation of port dt property.
> - Add documentation of memory-region.
> - Remove redundant ctx->suspended completely.
> - Link to v3: https://lore.kernel.org/r/20250627-exynosdrm-decon-v3-0-5b4=
56f88cfea@disroot.org
>
> Changes in v3:
> - Add a new commit documenting iommus and ports dt properties.
> - Link to v2: https://lore.kernel.org/r/20250612-exynosdrm-decon-v2-0-d6c=
1d21c8057@disroot.org
>
> Changes in v2:
> - Add a new commit to prevent an occasional panic under circumstances.
> - Rewrite and redo [v1 2/6] to be a more sensible commit.
> - Link to v1: https://lore.kernel.org/r/20240919-exynosdrm-decon-v1-0-6c5=
861c1cb04@disroot.org
>
> ---
> Kaustabh Chakraborty (2):
>       dt-bindings: display: samsung,exynos7-decon: document iommus, memor=
y-region, and ports
>       drm/exynos: exynos7_drm_decon: remove ctx->suspended
>
>  .../display/samsung/samsung,exynos7-decon.yaml     | 21 +++++++++++++
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c         | 36 ----------------=
------
>  2 files changed, 21 insertions(+), 36 deletions(-)
> ---
> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
> change-id: 20240917-exynosdrm-decon-4c228dd1d2bf
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>
>


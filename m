Return-Path: <stable+bounces-178892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBFEB48C25
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71F91B2453B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83352253F2;
	Mon,  8 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giC/O0HM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181C3209;
	Mon,  8 Sep 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330899; cv=none; b=ZYr/qsnDTaooLB3yBOdCYAfIuJlsn7K5MXcHDghiioR6mq6nT1GUfdl5huWJ8++bHmlTfTqGDpkoURHkJGcuVfpjfMROSCPPVkKYSja7K1uZUqaVly4w0BMov6ynRuXvgs1BGODsgGb8VNXyC0NMwYhgdXOWO83+TWPXJ3s504o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330899; c=relaxed/simple;
	bh=yn3DFY54dpfRYE23YFj22qSGMrD08cs5ROb/kz6rhzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uckPpIl8+bJ+2y58xze3vt6BeizXUKHDxEBedfOtK5JLfV8mw1g3dAipxm6kubTC59AyGaLLNpe/Nx8JTykcEqHTl7fhldRylaS1CBbXlBsCHdvgG1PcDwpDwF+dP9sFb2FqwNgweEs+Nqx1zLIlHr0NWAaqGoYx5HPpkCIUpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giC/O0HM; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8a756436f44so1278164241.3;
        Mon, 08 Sep 2025 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757330897; x=1757935697; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn3DFY54dpfRYE23YFj22qSGMrD08cs5ROb/kz6rhzY=;
        b=giC/O0HMysKBvufK5CSc1LJ+6NmNapZE8EoVLAltBcaXhUiNpCaomxwNpvJCJUrwx5
         2bCDPMXTsZ9TRd9vswGQ+M5u/N/EwULuBlKawJwMtZQL1+pOYtK+Fxwu16hT8dWTINHp
         NA4/tPpQgI0hJQ0T9zJ9mMyWS3qGnQWrvQbSBSuJiwcG/ymqbIK+W0YZ3ONXkWhuaFxo
         +ff6AApafwAb4I33AKvYVFsAoSgh3w/d/FpwnZ7LbTKAVhFnzrb3Agels5ZVH3wjfdoa
         nk5M8iAlkZWlb16j3k5odEHtfeoUq8BJVQj1wRbXCDi62j7jQa9aV5FDBlvTJOnngwN2
         1RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330897; x=1757935697;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yn3DFY54dpfRYE23YFj22qSGMrD08cs5ROb/kz6rhzY=;
        b=MM1NdahdGGAOlc+Ah965OqvnLnWcfoK3npQCJJLRfvS4cPTlmvCJfK3cq1i/jWTGO6
         n6QSxBn+K0QduB0YjYvTQGWadEWOdeQDLkGuKJQSCUVsN+nJgBH2PxL4B6pKdnsJl/0I
         mlQlUpZD7n4PPUQ1adQiGmxtiinUqoG8iwxEFPuioPRETuq46bLqJ5tt6Nc5DWHxy16K
         r4JQpIvz4+qR1E04e1iwWDoFft5EaEgx5zbpq030TjMsFTt1nEIOMnKu4hBZogqHsOOs
         iPXJ2wQgzVHt+BJMSRy4i3+p3iODDxRU4h+8OqwhCRdn+iPfEFclc9/nQUp6FDco1tiu
         SqEw==
X-Forwarded-Encrypted: i=1; AJvYcCWZDq5hzT2yEEUKq1HuAvQgi5GToScuzAyWMqsQNlAPfgGs7lpotrHrDPBx/5PkLhu3lEwphbp1qrgh@vger.kernel.org, AJvYcCX27mxCt45E3l3RvA6q4czqQhBt59qtuk6xEG2VJSvg4zycXodfGqucd/lk+gNe8J+Poy4TCY77Klbb@vger.kernel.org, AJvYcCXAc1NfJ4gWlXJk29rXDp5IPwjJm5uOkupPnprkl+yXCyEn5YMwKVrsOqIIO3fYuWD9MXp3TNr0zvLN3179@vger.kernel.org, AJvYcCXqbiOywWEoWfs+jWlQBA1A2Ss7bC/vbN+Ys7f5vyC5I6VgIEiG2vp/clRqfDe0ZnpqjqMiBYpB@vger.kernel.org
X-Gm-Message-State: AOJu0Yywn4pWBDPj/v+bQESPZGAzWBZJxt+rkjaV5vjPuKUKqR8FqBMa
	VrhxdEcKOi+9sqOeb6GmqP9s616a5o8VWXQJzOaU4yU8cFEWDfYSRIbA
X-Gm-Gg: ASbGncuW2VknR10/J2mogSXh9Tpw6RC8UhBTM2TSDZrqw/mBzPX4fZG6KfyeQGwX75g
	vw626XJdAFvQkso2IHzkDR0utz9n7TGvLCR70oYhvHRz2PoeDihOBTdBj66YaAh3DrKuUa8Ai//
	dsFvSyGOoMgZqJtj1gUbewnbGfXo3jp0FIU3ySxgpaGhJa+4QDYCqXcaRqgQRchpy8AzFGwngHP
	vubfLEEmpd2ctaUHeumi7aMlElfVfdrG0yuqbRG4cujuPqneuwB+DVu79GFv84DiM+fx7wiv8Ic
	i4KplbmBSN7vmzHNmY2/4qP1wd77teloTsMWx6etyJFN5VWRtrsqHvsOY3hlsdjeXWCPrkaqN0P
	VK/Ms8CIK/8ePdrA=
X-Google-Smtp-Source: AGHT+IEmxj5SRucLxgsqc+XZK/hD/wEdSRDYn5/LVNzSGWmoBPOWSOPPWS7ZDyNcF+IG54oWcnCxTQ==
X-Received: by 2002:a05:6102:c8f:b0:521:f809:9969 with SMTP id ada2fe7eead31-53d1c3d62c5mr2376675137.8.1757330896892;
        Mon, 08 Sep 2025 04:28:16 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af1915741sm10417808137.10.2025.09.08.04.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 06:28:14 -0500
Message-Id: <DCNDT81S98GW.2SJOV5C94E43H@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Jean Delvare"
 <jdelvare@suse.com>, "Guenter Roeck" <linux@roeck-us.net>, "Jonathan
 Corbet" <corbet@lwn.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: trivial-devices: Add sht2x sensors
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
 <20250907-sht2x-v3-4-bf846bd1534b@gmail.com>
 <edc840e1-44ed-4397-8e5f-2f5e468ec030@kernel.org>
In-Reply-To: <edc840e1-44ed-4397-8e5f-2f5e468ec030@kernel.org>

Hi Krzysztof,

On Mon Sep 8, 2025 at 2:02 AM -05, Krzysztof Kozlowski wrote:
> On 08/09/2025 03:33, Kurt Borja wrote:
>> Add sensirion,sht2x trivial sensors.
>>=20
>> Cc: stable@vger.kernel.org
>
> No, drop. No bug to fix here.

I included it because stable is fine with device IDs [1]. Is this
avoided with dt-bindings related stuff?

>
> Please organize the patch documenting compatible (DT bindings) before
> their user.
> See also:
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L46

I will reorder.

Thanks for the review!

>>=20
>
>
> Best regards,
> Krzysztof

[1] https://elixir.bootlin.com/linux/v6.17-rc4/source/Documentation/process=
/stable-kernel-rules.rst#L15

--=20
 ~ Kurt



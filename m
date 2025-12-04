Return-Path: <stable+bounces-199953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD4CA214B
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 02:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9059301EC5F
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA91E2834;
	Thu,  4 Dec 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kS9QJFvb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB11A945
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764810217; cv=none; b=lVRnaa8AZTAu4pfEOFaV4Ns53115Q8BBgfYkI3DtRWJzncjgtLUEpCyuMy14ZosYeRAeUKOnk28Cu1sMaM8DjkNRgS5G45BKc9w6JMu9UUaBdZjzK1GZX1tbuv+k6EOKPmowE/8FQ+gmszTn2Ejk1Vk08iRErVPHwsAUec/SzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764810217; c=relaxed/simple;
	bh=z+U/HS+zSWUPiivxVp1v6hSxQRcXNBb6C3x99QEvAmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCHL6SU+bS5HXQ64Y6OaY9Z8yvX27/Bflitp1oddSv/NP2hHD56+ruizkI6kgWsyYL1Se2Qgmmsej+GP7vn/7JjzNBE8n+y+mATWnLyaoK4MdrdVp01w9OKqsCZG31TOiasiAA08OEfvKhj0n/I63OIJR3jM8HsATjVG+ryhdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kS9QJFvb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980343d9d1so46865ad.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 17:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764810215; x=1765415015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+U/HS+zSWUPiivxVp1v6hSxQRcXNBb6C3x99QEvAmQ=;
        b=kS9QJFvbdPHGnsXRYZWtaIgzirJyncjL7f3d5H1wbc1Y9vUHT9wTJ3dbgJpXarvpjQ
         SpxStaZUqZ+1vX6uSpCPIkKFX/5b0E32wil4NUVEDuLh3vcRC1wOhYpbY1Gs8PeC2bAW
         qcWDSXUG7Y6FJOBpSfdek+KBG7DbZiGGObn7d8ERTFm7rS8NPAuYO1ewM++OXCNDHOxP
         r7/wlkVeZODep6tsIEaHa5grACOkkE171HA3tTcBbVxPbBmcM0hGSaAGvAK6q+OApKlh
         6h4vNNEFMfL9JxMscgWtx97gtIElXcj2N9mxVIbZDopKi1ce10q5I7VWswYgTt2WOb9Y
         962w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764810215; x=1765415015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+U/HS+zSWUPiivxVp1v6hSxQRcXNBb6C3x99QEvAmQ=;
        b=TYDk5PTMnk0jiauVMfxl04hDC1MjG5Ob90VAabmT1iwxp703HAAwOCV1SRYELZek54
         2CC13Zl/sx81Y8tifTvFEGBFX3+aeYx489guyh6jkZLj19fLy09+x1yXuWc/65i7rgOb
         4ls5VQRy36bhxR3+bKtxJjWqgyIPcvqH0/hpgq0ZzfZrGrYtWP163dIlw8ONIx/R1b9k
         iGhbEnmIAPSbn0qMikF9uZul3hUD6wpTd9f9cgC52KShwcn1NY8WA/5b2hfJhwtaGVvH
         kXu5owb/3eWot7klAQM1WEmsqMZRYr49bwZKJQPSOj2k5vFL3zxvQ9ko2TA/trkZH6At
         b5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tVOV77FyLCfY8/bSAQHvGH5bt2TftKuEZ+sg6dfDpd+VlAvBfvb5bNTR+faT7onIHYud0e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qlN7gTiXqy9hNHQNdFBzFEXA5CCk1PITS1iYzws1pTFjaEEA
	LiiAeJucv0yGgxWQKh4MTRug4oV3bwXWAKwQLN/2t7s6Q5L05HAqSbH69oE3FFdUD7Ms+9yCnRf
	5/wyAVPUWoi4RLECtafCLfMYVUTcSw54rrySYUKb5
X-Gm-Gg: ASbGnctMQbSy4L6E79WPjRQyfR1VSziXqP2UIaov7LaG3ApucDNKdNdTRXTFsxN871r
	b5nd8KlydalRD9NiTex9J4usHooqus/lx1VasHYHUx72dbk6zrT3eS8RJ+ls3ZfRgPgN/YBq+d9
	agafiQuHN9qODGMhAQFSaWGkkr99tSVs5wG8ghN2rjqor1G/vaCqRMVKy1B44q/8SZKrFVrXb1u
	OKmp5MnJ6Z/kHq3WxXy9a5ztJiHIkWFSSuPvi3mwkN7YVCLL4IVP+xqV3dEmadWVwx3gRtldlYk
	KiPyzzbHHDLsCnhOFpyA+3n9H5uKJdCNVgHVXDA=
X-Google-Smtp-Source: AGHT+IHGsIaOr+2sjAnAtvhVFv1oIb09ZRNvaPHqrxfiq6Zap9xUYraSx5C5I2d+2U31Gask0ZdLduLT64mxUmpNqh0=
X-Received: by 2002:a17:902:db04:b0:295:30bc:458e with SMTP id
 d9443c01a7336-29dacb15b9cmr766165ad.3.1764810215044; Wed, 03 Dec 2025
 17:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176398914850.89.13888454130518102455@f771fd7c9232>
 <20251124220404.GA2853001@ax162> <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
 <20251124224046.GA3142687@ax162> <2025112730-sterilize-roaming-5c71@gregkh> <20251204004314.GA1390678@ax162>
In-Reply-To: <20251204004314.GA1390678@ax162>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 3 Dec 2025 17:03:24 -0800
X-Gm-Features: AWmQ_bnv9xZyMTw06XPgCBCiPbHMBUnv_pUdGqpUXwgy1KdHSLO1d8rRz8SAq3Y
Message-ID: <CABXOdTfd9C06i8Q8fGMDyMMoTtZ=fwDTvWnM=Yx7g5-ABaAvcg@mail.gmail.com>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernelci@lists.linux.dev, 
	kernelci-results@groups.io, gus@collabora.com, stable@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:43=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Thu, Nov 27, 2025 at 02:22:46PM +0100, Greg Kroah-Hartman wrote:
> > No objection from me to delete the driver from all of the stable trees =
:)
>
> Sounds rather nuclear for the issue at hand :) but I can send the
> backports for that change and we can see who complains before trying a
> more localized (even if wrong) fix.
>

Already done (and queued for the next stable releases). Sorry, I
wanted to copy you but ended up copying myself.

Guenter


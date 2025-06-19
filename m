Return-Path: <stable+bounces-154795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A5AE0437
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930583A2443
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A242253A5;
	Thu, 19 Jun 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLY+NEKs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F02222C0
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333613; cv=none; b=GWqw9mugWIf+hDIz2OuSLRXhFJodleNB6uGP3wRhKyDp1OnRMrHjJt4DhUyGVspCtmiG79vpuFnSRv5fwhG6PIST6+yTEg6QsZOSaL4hVAFY4BdjUi2Ynx9s7vhXeWF150Y0WOwMIZN/ql8g/HPigTCTmIPSfl9JmISOcDgN27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333613; c=relaxed/simple;
	bh=L2OesdfaHmG7/6RtK81V0inMteb5tsx5zz8nwVwJpaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB/0IFfygVE2lUehXFsclmXQKrdHwlq/nSYMfCnGmiB8aqmQwMgWg03Q4SFViUdjPB/Nt3yrySHcTQrBfYkvN9c3vECaHVgt1nr/XoMeynoZvor8tLFrw9+C5uHIYtV+mAvVPcjmrm6IP5TKFapRmSqKm84oLYIaH3ZjcNe+myQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLY+NEKs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312f53d0609so115725a91.1
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750333611; x=1750938411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2OesdfaHmG7/6RtK81V0inMteb5tsx5zz8nwVwJpaQ=;
        b=eLY+NEKsFTmWj2fByKEmLt9gOymBcB24kKnbzdxC3CoQbcdewGUFmGU6K0Tix6MF7O
         Idn7vgSnspaJAdflw1yBMP0uRO9hLiN/XUTeAKSd2HulskQC/OnNxdP6oE3vvvHTeG4j
         oQrsl7nXtmt2RYUs1qdZZz/ScV1qq7OApHbDzR811vTdRcZQYAsDPi71rItUPfSQgyhI
         H8skwm7kr2uZcZI1nMicrbJvTMeCc3Mw5ZeC3nxXHgrlZUmTblbklxxmLtLs0QDPSUOz
         D4xcrWL1qN1ShB6pAQTRg3W4U4RxDuE2hJOHuMgK3x7E80iFxDUa4rUIr0a9pg1Ce6Na
         uz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333611; x=1750938411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2OesdfaHmG7/6RtK81V0inMteb5tsx5zz8nwVwJpaQ=;
        b=BMHrtLyDHTZ0F+GjlJdp7NmPUQL7+tO9hbFI9g75xNb9pohcfiz07WX8DtB4zb8dHR
         noEmuHLY63Lg2iANP5d9YxSMuI2qxj3nMfUfaIzWHXeU4b95QaHq2Vc7pIhOSauDWF/D
         uBjZMikcLp/t4/AuFg9pUM3IJ0duemHTOx3yAybfVc9h4IpFrrsMUEO6taIS3tsjD5OF
         XqEE2rpPL1i4U5oOdTVALu8wYCL/n5vUDNbb5Cr2cPBn9m6eDtLIApwV6FK0Fp1nb+MN
         QcMRqnXJ1E51mPvGBPQf94mYMK22cBlGUifsZ3n3Y5btN8Vp8LV3gz1+MWNzeWPgKpBb
         XLIQ==
X-Gm-Message-State: AOJu0YyTXDC8dsEu+Y1X+XehrnGp6etwZxk9nLSgrSmnVKHl6/h7MByN
	XP9+Dxv8G8daNGQRPJU8Za9u5tfyj0rRTcJR1kxrFqfeSLvZa2X064lyw1qDFn/ANntO+OB6wbf
	jYVGwI8s/D7zZiPdSuFpRYDmuTIXs4Ww=
X-Gm-Gg: ASbGnctS5x2hYp/a0ns9c4IPhiBVzoBkrwyG4ERr7Wv2k/1vyyi9tH3KDoN8o30KJcv
	wRl9+SjU+0kLh9DuaFz+fs83BOFw5h5owfoP9CjOR95z7l41r8JD11f0Szr1Iz6pQl5BY1kHMX3
	52LZgl9aU44Hx9UVebM2PbwaZhsqVLQnSxMq5zVzpwFxg=
X-Google-Smtp-Source: AGHT+IFqYIShzWtJo3IhjKcbr7D5RYuh0GeO3FuHlKNjOeyJOPWjWnXf+uKfmiwfkOZNQTz9o3vqP4kvYNZpYgkoCTs=
X-Received: by 2002:a17:90b:3bcd:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3158b6eecf8mr1667839a91.0.1750333611200; Thu, 19 Jun 2025
 04:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA76j91szQKmyNgjvtRVeKOMUvmTH9qdDFoY-QRJWSOTnKap5Q@mail.gmail.com>
 <CANiq72mRB7cbEpKdWm_k2EPf5zdHL8K=JT2Y+4XGwywN5AX9-Q@mail.gmail.com> <CAA76j906WD6UYN_Q_94q0RQt3-9GfX9U=49KWqaPDCQQzcQA6Q@mail.gmail.com>
In-Reply-To: <CAA76j906WD6UYN_Q_94q0RQt3-9GfX9U=49KWqaPDCQQzcQA6Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jun 2025 13:46:38 +0200
X-Gm-Features: Ac12FXz0GGmXhZS-2Y1GfUCJN3LBNkoY9rBYJvwPt1xsp-i37EabsgmGrRtQfnI
Message-ID: <CANiq72ke0di6m1qS9-QzR175i8HG8dhzVCkW1w4zPzMiTDxEdA@mail.gmail.com>
Subject: Re: [PATCH v2 6.12.y] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:41=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> You are correct. My bad, I guess I copy-pasted it incorrectly
>
> Thanks for pointing it out.
>
> I will send the correction in a new patch

Thanks for the quick reply!

Ah, by the way, before you do that: please don't mark it as a patch in
the title, since it is not one (this is "Option 2"). Instead, I
recommend saying e.g. "Consider applying ... for 6.12" or "Backport of
... for 6.12" or similar titles.

Cheers,
Miguel


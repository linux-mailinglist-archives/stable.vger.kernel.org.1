Return-Path: <stable+bounces-105351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF09F83D8
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A840D165F87
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C81A9B38;
	Thu, 19 Dec 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uwbs8/6P"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A36194C96
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635587; cv=none; b=ET9mXMQnd3xFePypiehfyG7uVLCFDtUrk/Y9Qy26c0qPLQvRyMvoMfSMdgx7xC3gasO2JKD/EJoFKPpi6bTjBEa2XgJoHourSRBTkEeabJ69YgZZqPJ4f0mFd6870qxVE9dAAfH8YsglA0rMXjA7jCp1Ya7Xphm8Krs7CK7qxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635587; c=relaxed/simple;
	bh=2m+neTvn1J6jwPLArnz6aBhDUV+liWIisQpaER4E2BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ9JKy4AQQTgkwPT7zEbobHKJ/N8cS9si0kZ0NOqb/V06efRQFC/n/N7s+4IfOnIJFIkUG07HkuIFjhT4LdOO+J05JXg+yhT/riljP/ignHSBFr1VQgF3ZB9zH/cdOZJK2F2/RQkW0FEn60BlUZF8eosQyadIeywp4mIGVtV/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uwbs8/6P; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so1169471e87.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734635582; x=1735240382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m+neTvn1J6jwPLArnz6aBhDUV+liWIisQpaER4E2BQ=;
        b=Uwbs8/6P64z+3FcpzR15n+7MzbCfouPu2kWWV9uPxgogCqV5nkLszU79CU5mfxiX/j
         6EGFwqe3znyp9U4iu0kj+iAegNR1uSDrV3o6V4H5n9pbZWozoniH+AeiwfYzSQj+xtot
         RyViE+Z/IEJnap8I6Wlp0/ZSKAqYgq1f8wlu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635582; x=1735240382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m+neTvn1J6jwPLArnz6aBhDUV+liWIisQpaER4E2BQ=;
        b=ElCCVl2IZQfpddABhTaSOWFivpty+U2EPYDqx4jLpv3S+KAMOeI06dGnESB87Xxg4R
         e1nkvOEpunZIjhufDy/Ayq8FukbLDT7VpKN0wurZEfwwK18l6+I/isI3T7uJyxXsl6/R
         DDZ6uBm8Eo07FLU91puKT5AKWcLyg+McpkI1tLV4DHC4koARdcPMAHJEPUrTwuBkyyAX
         nAKFjvGLvCHUZyspOPZX6dw+tegGyo8Bg94vk7aebe9msx+fy3pAjJ1E4fIuYB8NhJIm
         l1X42AwEG/XniHCnBWlJSDNdX5d/h7sDyyF8SgAc0h8gU0HR6jchS9ls8D165NUNuDEo
         /jnw==
X-Forwarded-Encrypted: i=1; AJvYcCW1UFmW1YoEZ7ZaL935mCB9Bu5XkI8mDo8vbadPbknkkwKP4laY17GoeQfxJ5LbyScqNnTMJzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEtm9x14WxbVrm6D0j7/msDFNBwTbA4Tw9YjaQW47+MjEDNxn
	7H9eeRFfxVLAGI8cEB1esj/7i30uFwVHHRAidAEZdM6wiMEn4/rHQ8CsnXCTHeFfXJxdRncoaAe
	+SQmp
X-Gm-Gg: ASbGncu36N/7DIs6KEMDCfvTI9gp864D+gBz88YRkEQzAMxj3J4g0BHENuW+AmHCkJ0
	kylFJa+t3YbnyA9pZT49L7XovTGob8tSMPF9cfdnWLVHQEGpYZZGtjX/wp0cIrXlekjIEhLY4z4
	DzLXwR90t8q4SFhN2nIncbcoDXWhY8Nyn1miV9SDcCM7vn8mx5jGxzWcr8i7A60LYYiQnIVUCd6
	398O5a2WEgC5Bv5VmvBJgfJKOSACBx/sQzntvgZ9yK59/bZ53jZvdtqfgTzSApmE3x+7SDnr4HY
	ReZZ3soD9ydFfQx9yGgR
X-Google-Smtp-Source: AGHT+IGHKKy7/xx0v6fc4/DrqyQavu2MbpU+2PJnF259/SilTA8iOqFkBtlmDUnNunBoNoI7RYi3SQ==
X-Received: by 2002:a05:6512:3d02:b0:540:1fb3:e061 with SMTP id 2adb3069b0e04-542213593demr1520981e87.28.1734635582363;
        Thu, 19 Dec 2024 11:13:02 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6cae6sm3003331fa.23.2024.12.19.11.13.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 11:13:01 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401c68b89eso1271157e87.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 11:13:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFE0p18G6EuSKqkGcIoULlcCWomMCwqN3eXiNzL7PjQ6dQz0TndNU/CWTlJG3rONkaLD9w4D4=@vger.kernel.org
X-Received: by 2002:a05:6512:2384:b0:542:2192:44dc with SMTP id
 2adb3069b0e04-542219244f6mr1395323e87.28.1734635580713; Thu, 19 Dec 2024
 11:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid> <20241219175128.GA25477@willie-the-truck>
In-Reply-To: <20241219175128.GA25477@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Dec 2024 11:12:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WhzZ_v1+WPpG9839JwN=fKyiY_T1M37RAU_e9cHy4XGw@mail.gmail.com>
X-Gm-Features: AbW1kvZhv1mh_PrrK_8tPeTV4O5T1QFdsJAfISMEvI9OCn5vId8bs6RT8MrmOxU
Message-ID: <CAD=FV=WhzZ_v1+WPpG9839JwN=fKyiY_T1M37RAU_e9cHy4XGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-msm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	Roxana Bradescu <roxabee@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	bjorn.andersson@oss.qualcomm.com, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 19, 2024 at 9:51=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> > As of right now, the only CPU IDs added to the "unaffected" list are
> > ARM Cortex A35, A53, and A55. This list was created by looking at
> > older cores listed in cputype.h that weren't listed in the "affected"
> > list previously.
>
> There's a list of affected CPUs from Arm here:
>
> https://developer.arm.com/Arm%20Security%20Center/Spectre-BHB
>
> (obviously only covers their own designs).
>
> So it looks like A510 and A520 should be unaffected too, although I
> didn't check exhaustively.

I was hoping that newer cores would hit the supports_csv2p3() check
and be considered safe, but I guess the white paper explicitly says
that A510 doesn't implement it and is still considered safe. I looked
up the TRM of A520 and it looks like it also doesn't set CSV2P3, so I
guess I'll add that one too.


> It also looks like A715 is affected but the
> whitepaper doesn't tell you what version of 'k' to use...

It doesn't? I see a "k" of 38 there. Wow, and Neoverse N2 needs 132!!!

...though I guess on newer steppings of those chips they'll just use
"clear BHB", which seems available and is the preferred mitigation?


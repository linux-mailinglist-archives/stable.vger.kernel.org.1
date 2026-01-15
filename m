Return-Path: <stable+bounces-209948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D07D281FA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69926300EE6E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259231960B;
	Thu, 15 Jan 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="AtlQrESE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05254318EE3
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505638; cv=none; b=G7ATvcyyiUVeFKMPTTowT+PaD9XBOxrUQd+WM6EvAfP5z1nrvzBOyyTMRF+97NkkZFNqSOhAfpEqfPnDhJgKHRDLNNR1uuLRHiKHWNt/NxVP5um8DBfAmF9OY96EYXJOmrrHNZOaoPXnLDb6K3AmKxEBBcY+L7ingwcDGiKJuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505638; c=relaxed/simple;
	bh=TfAIki2k3fkfeWZQkIksj+3Uz8mlvUNdUj5K0Ie8HBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E10uVLQJNCM1vSSIdWoQd98LkCUty0Jw+fO4L4nUfdkRqeYdBZa7EVvhBJSaKFy6z4aZBdgMsprN1fAZEmszHW2yGFSV3VcUq8hG/EmGYvK1gUz3XfdnpH6G5TfwkSptx/flrzUC2KjQZ7BxdspDAKzdgerqjDIPe7Zjn3kcUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=AtlQrESE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so2102660a12.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768505635; x=1769110435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX2VqowVk2rXc5DYzGPI3ZG/fdC9NOPvbdRsZKJoVN4=;
        b=AtlQrESEKTTCvjpRW/LqAWECw8Wyvrr1wC3FucSadbdq9kqafCOiU2/LS6tzxBgoUe
         bAqk5p3wRuzIWbfwua2hpdFDkXITVAacxmTTgnQYbu+WVuIAMmIh9hM6knIaywb4cRLC
         FthqoNxgLVHo5jVN7bYsGtHeyRlBlMl/nSWvOf6/zYnrO1C+/ITGOsz3Ay+DjI4uM5K3
         WkHJWnHTNVZK7zXYORlwQF9FhMAw+xQFjdphQVEpfMbstqImE1QOAIg4iUrQIyDhmjVc
         4RyoGMqq2TGjubWWUtnshVC1kFvLewmhKz/Iwm4dXUuMXFSHrga8Lf4RWx626J0VbGa2
         YW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505635; x=1769110435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vX2VqowVk2rXc5DYzGPI3ZG/fdC9NOPvbdRsZKJoVN4=;
        b=pRN7Bnn4wfRHpG+qMeEYZpniW0MW6B9lkcFBDzVsaniV398j94l3RD0uvymhfjSFzp
         BhSY58jqYtmtcbTqrL7o2sX0jfeVFasXsZSdgDy3rcAULo072PdgLvJEFMq1uaOvZmFh
         Tl4rhYlaoeE3fkac5OEBgy304ow6VYLNRx84mBlR13U1UBi23KIOGJrY9sURRpFpQPuU
         wlY3fhhuZaQfINiz64VWnSaBncBd1gTPEyztlesGZptcdrLOLSMiLSMMuiX7ndRpFCuE
         m2/wKoPRmjpY99uWVyfGsZmOMS2ZoxcGzSDc721erF1hK/IFjpU7jP8ONvelOmRalWPi
         fu4A==
X-Gm-Message-State: AOJu0YxxioHnFrD+gie74NlCRTwOJDqWueg0zUvgiAn7PcKrSg+vrzP7
	20UFYNg3TqMz3202jdb6kFS+PQsH6mWYjPyOEP2z2G/3miIHWWc8MJha6Kh6feQZW3VEJWm/ksb
	khTl07phBqTy+t/zhbFi66PsobN/4tJJ+cnyv25wus8ZIxDw88UGTkHv0ERdAq62YTRMaElIZgO
	0qPA+BoB80GKEAcyJTdLtULPmw1fw=
X-Gm-Gg: AY/fxX5zhkyppUzN1Wt1aio0RZ6SyTK1+PdjC/2lD8HkrLQLrP3uJZStx8aObSbl5KF
	ZNnFiuCzZpwNlqVDpDZOnwKRhVeW2kVSde8qohKYscYNblpPf39Vfzx+zaVit29N2MPkruuRTD2
	ScB7mOzn40CZ0YgrtnCWueevAIATnIUQfoht/DXVnKbDjW8jIRyl+osRiQsvSffmTEBNoZXprX2
	VzBHjyxDXZmZoNpLlQIvE+5OC/9Pmkiuzv5B+iuEfe2G5/18/fyevf0W7/TBI9ij9EgaXCHG4GZ
	ih4ODcokI7jC05MpT65RBrx3gIzY
X-Received: by 2002:a05:6402:3547:b0:64c:9e19:9831 with SMTP id
 4fb4d7f45d1cf-654ba1c92e9mr163966a12.12.1768505635288; Thu, 15 Jan 2026
 11:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164246.225995385@linuxfoundation.org>
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 14:33:44 -0500
X-Gm-Features: AZwV_Qinxb9tW8FAaAE_f5qam0Gp_E60BDJeWgMkZi0WL4oFCCYn6aUoPDRuXdc
Message-ID: <CAMC4fzJPjrv9L7B+PptArKpw4omUgMKw6-0JEXLd0_-Oe83AEg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/554] 5.15.198-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 12:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.198 release.
> There are 554 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

5.15.198-rc1 built and run on my x86_64 test system (AMD Ryzen 9
9900X, System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade


Return-Path: <stable+bounces-43347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BD8BF1EF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CFB1F220AE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6B14A624;
	Tue,  7 May 2024 23:11:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEF14A612
	for <stable@vger.kernel.org>; Tue,  7 May 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123463; cv=none; b=LZ5pM+1jIbKtaIho18Ril2vivuVcBhqCh2+yho3hax2KPwlrIaDM3ARhOLLhsSA2m5iUNy15UUDAxIQ+Cvu+1h2/Q2DUKf1wXV636fh5WSZE7heq2F/nZdMaETh59YlgyMrRq4+YUi7wRnr7r/GYDfGVV2/D0Lca5JuYwDYelHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123463; c=relaxed/simple;
	bh=Ix5RUDdVzg0D8TD3Izd1hf056IHKHF36irpkqWOSE04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oszm4/LZe0/88KDav6WNqQGUxCxioaqmu8SnhfchCAAq50Ymrfsz7M7QDH5eVLfEDxezP8lfZx/en2HiFXeYmN4Xl6RiiMxMI7GOo+bYeKl+4tDsK6j50HThdTgmbratz1j44DQYmHdohDFt8WpN8e41LOxh61Oks0F31R4FHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso206794a91.0
        for <stable@vger.kernel.org>; Tue, 07 May 2024 16:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715123462; x=1715728262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bcxuu2iR2geqpxEwYn/Rrs+7MknSdtPWXgTbZ0p1GYg=;
        b=ditphuVsy+CgprrxWpjhzu2u1UoHMGUR8TJ1pbldGD0aIHaD7qs1i0cS4xAMwqS1qa
         uBF/vyZpob4AAu7wENkN5C8tMHHI4stGdZTDe+Gn/K/6pxTTVFiKQ+O87Pkfd42q1QcY
         JAaeqeZXDEgaUXZMZohmgfTgbZl2wvJvPukLOHJVhDE06p7wbtWEXOUzNF8W2+PIZ5Tt
         TlwBiChwMc2q124Mcodh4rM91ThVQYC5qFwwjfQqgLq4Z4BPKzeVOo++bHjMgdS/sxtc
         eDFvUi0NN9In7u2A8kR79KGt1r6TA8XZIhqLr9F1Qi4jXtR6txG84BAs1EE9A8kmRsoJ
         14Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXR8dpDnfv3DAe+nwPUDg7C0tt7CcbpKOb/bZikPNxMfj32NdfewgnTYgBn7bZf5bfcpIZwfXnUReYX+X2AD9w/kiCrdqPl
X-Gm-Message-State: AOJu0YwovGGDfFQ34VX/vCzaUcsKFtGbpCDu15CYA61w73jVpjeWOHql
	T/TS81U9WUFWH8K5f5hneTH7SBc2mnufjquvAGBIcjKFvzTl21r8lTgSMxQX/Njgv5wmKIdH36A
	02BmmgtEro0+Argr7jCp3AybrTCjAEix+
X-Google-Smtp-Source: AGHT+IF8sKlbPm+bS2DwjS1ROqN/7XvW2ufEqvS3s2mkR4zhOiaqWIIoCye4K6LXTiNH9avgRI9TqmYs37X1G0s7Eko=
X-Received: by 2002:a17:90a:bd05:b0:2b4:32c0:d7d7 with SMTP id
 98e67ed59e1d1-2b5bc2ad5b0mr5717174a91.16.1715123461590; Tue, 07 May 2024
 16:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7cgVCqYVirivv3ApCq18eSCUuJjUoq7hbhw7X9AaTwNf+w@mail.gmail.com>
In-Reply-To: <CAM9d7cgVCqYVirivv3ApCq18eSCUuJjUoq7hbhw7X9AaTwNf+w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 7 May 2024 16:10:50 -0700
Message-ID: <CAM9d7cjkv9VvV=NAxdsnFKcjq1ti-cAdxFn5KkisAi-yE6Sb0Q@mail.gmail.com>
Subject: Re: 6.1-stable backport request
To: stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashal@kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Pablo Galindo Salgado <pablogsal@gmail.com>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 2, 2024 at 3:29=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> wr=
ote:
>
> Hello,
>
> Please queue up these commits for 6.1-stable:
>
> * commit: 4fb54994b2360ab5029ee3a959161f6fe6bbb349
>   ("perf unwind-libunwind: Fix base address for .eh_frame")
>
> * commit: c966d23a351a33f8a977fd7efbb6f467132f7383
>   ("perf unwind-libdw: Handle JIT-generated DSOs properly")
>
> They are needed to support JIT code in the perf tools.
> I think there will be some conflicts, I will send backports soon.

Have you received my backport patches?  I'm wondering if
they're missing or have other problems.

Thanks,
Namhyung


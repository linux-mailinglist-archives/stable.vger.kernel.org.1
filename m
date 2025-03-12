Return-Path: <stable+bounces-124135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F7A5D998
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9363B629C
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459523AE8D;
	Wed, 12 Mar 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSc9SUM/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8A23AE82;
	Wed, 12 Mar 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772116; cv=none; b=iuvboZsK87lgvKfn4dhEmHlY1b3IZ3B5evMcQ6pZdmgF7RioEcW79/eD4/+xJ16ug5kIIjRaTmhkT9m4edRTo0mz8UyCTOToc6w48gJAwoJqkvHzVI0FMIRQ902eiOqI+vpkA9dpCbp0yLtjiBeJ9MoFPHyuX735s1bSX3sya38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772116; c=relaxed/simple;
	bh=PmzjR4Cpz/cGaEj6B7a8P4PKsIGJbrlzZH11KwxHt3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c25k6iotn1jhwcV+j14oLaSWFTPFK4aHRU9sFz/g9jS7oeBlZ9FnyDpEURGNUSlKrlBwWQ8MxZ66RqhSkyIHuN/JWBIckSF/37ZMpHiH3pxTjh+BdanyvxyUGts3/ehagYgIPfH7zVdEPDyeAYlPMvrxSbj6ZCSamGJqtWiXQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSc9SUM/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fee05829edso12677318a91.3;
        Wed, 12 Mar 2025 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741772114; x=1742376914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttwRvArVp1ym17d1zB0rA2V5k7MFc9PYa4gsOt24iR8=;
        b=SSc9SUM/q8X/v3ndeTm47BNQ8b/CbxvXYKW67xyh6mieAf1mCgHY/Lu3nGSmZkfJP3
         ikd44dUv40tH1/mAI5ioIDp6nO1LGyPquzkbv9oaeD+BoCC/b/f7UuHYYq/vcOYHI21e
         ygH8ZiuOvIY5IwXI5lIGlYz38pbH4j8K5nxMC/+cq5Imyy3NRaHXvaYzwUFOKpCqxjV0
         uoapGc2oNta5WvugFsY3L+l6o38+HspoEwegdO4rf4tavxPxiFFj5HGXcZv7jND1sj02
         +7w8B5XVSL6TRslmjBOUrV/teFQtJ0ws4h1hJLjwEcka/JYZQhWWUi7R3oK73OwcK4TX
         jpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772114; x=1742376914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttwRvArVp1ym17d1zB0rA2V5k7MFc9PYa4gsOt24iR8=;
        b=bA1GIbLRUBP8ASFBP3Nnnv5r9/JOJfO/Ju3nhGbBYtyG0tICB1nTdevDF+qrFfVMdu
         fp70+wozoivlqa4moCowanYddpfTwSGifoCOj3J3rzOQUPaEzJfjjvmGGoOEwuC+Avng
         8uk9UcRnEUrFj0c6M6ZmzENum8mWK5RFZRNMaCEBtBjR9c0Rz3+4fjvbTX4Vv8KROWVp
         9I5iodiJqvsyqOwTGVrfhhIzdm7xGJf7t+Kb0hQdA5sKGMMNsrrKaF8MjQHhVuAcaqEF
         ISRRzaLVHxT9UvRKbSxlIck1zJp17ot5j08jlynGwwvmi0EygixnWeNzT18XPTzTFckw
         ggUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95rATDed3uGbB/vy106VDNqfiDGMQS07cmZP7QNuIhEkVMQaJeLtouIME2JOuSpEvk3AndYg5@vger.kernel.org, AJvYcCVgbMPwMfVevOp/5N1fzcMtpzA1nUyx6VlTKlihRzjjeiLx9dtzH3EXoU4EwZEMLXkwPvfwMJuLZd8wp20=@vger.kernel.org, AJvYcCX3yUQL4N5KCWru7AquVPkH7615KaDQi5qHbMDMMtIMWgLG6yW+8HJ0L/dqLng0zeIjdTDwJmepbCLU+E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTt93OU7V3ThC3GZ1NoCt0Fz523SLA202TfDnYAeRLFeq7gGeY
	3n625qGb1aHVdI/zie/UlfrYEKRHaitGYnffxWGU1aeUsWvtZ4zcTR/tUcTosGK/issyrE27nnS
	sfeYtA/DWGTRjyJOOf01zmiG3uAo=
X-Gm-Gg: ASbGnctV5rMCI8KETa10Gn4mFEB75OrlOUYRXluPPRKp4xHlYfClrgnU9VcLkJPR6xP
	qbC8rar5dTiNKR1xQi30hH/KUzE62PDRQO1pTLXCIYCP+SwpZFPzIbaB+xUsePTowpY7VXPWUcL
	r2HWty/fnGy1Af6Qc8rtq2Pa5AeKQ=
X-Google-Smtp-Source: AGHT+IEYSRe0gRR5yo1g7wU440dBsuRnZCe/vswTvp6uZ5rlXqRYBZ9uB2Uyw4ni/IgE8JGFvBGWEL/ibOE2TyQi0Es=
X-Received: by 2002:a17:90a:bb8d:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-2ff7cf5f7aemr32864523a91.15.1741772114286; Wed, 12 Mar 2025
 02:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144241.070217339@linuxfoundation.org> <2b269f01-e508-4940-81ea-31c5cd961bb1@drhqmail201.nvidia.com>
In-Reply-To: <2b269f01-e508-4940-81ea-31c5cd961bb1@drhqmail201.nvidia.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 12 Mar 2025 09:35:00 +0000
X-Gm-Features: AQ5f1Jq0KNR5demOD7iOfh9YAuVYOUcWURsYUGw0TJtcXQdVfw8evk7uh_JbE1w
Message-ID: <CADo9pHgbPPFZW=TMBw9mF15f9hsro4E3bw8FnQUsABZEqROBCg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
To: Jon Hunter <jonathanh@nvidia.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Works fine on my Dell Latitude 7390 laptop with model name    :
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
and Arch Linux with testing repos enabled

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 11 mars 2025 kl 20:42 skrev Jon Hunter <jonathanh@nvidia.com>:
>
> On Tue, 11 Mar 2025 15:48:06 +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.13.7 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc2.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> All tests passing for Tegra ...
>
> Test results for stable-v6.13:
>     10 builds:  10 pass, 0 fail
>     28 boots:   28 pass, 0 fail
>     116 tests:  116 pass, 0 fail
>
> Linux version:  6.13.7-rc2-gfca1356f3f51
> Boards tested:  tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
>                 tegra194-p3509-0000+p3668-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra30-cardhu-a04
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>
> Jon
>


Return-Path: <stable+bounces-45105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F88C5C0A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76BF283D1E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD7181321;
	Tue, 14 May 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVp72pCU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFD2AF09;
	Tue, 14 May 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717310; cv=none; b=i9LEsF8qqTM0x68k0FgWYKJvogkaQxZTr6UHt7IApZsoGFUKrweIjymkQaPdzphpHhB9CHu2xiezTWVB8vA02KClS7anG9+FjFmQMNdlp36UEz1909Yi/PFuU9KjFKed0QlItTN940176QZJR6Ghd5bMXJnxt9J8neqEPvJMz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717310; c=relaxed/simple;
	bh=cKYDeecydpzGb/O5fET85WmiV/33NCb/HD7oeJKbfRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXjILZLtEkArPCNrxbeT/M8jSXVQQGc7qZsT/qcqofqkDq/TDy+RQPt33cJ5xXjkLsZ0ScmE8FkWwaDL1lbYsihZtL3t5PqLK+AKripwmQWNwYHip6vnV6bNjdPcVfl4u2d+5xS1bkMvBM8K26p1o2Cpxd0J37bFprjtfvh/feA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVp72pCU; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1551876e0c.3;
        Tue, 14 May 2024 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715717307; x=1716322107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjoJ3H6892IQ+WG+yDZXENruQLJb/czhTtD/pn2XzY=;
        b=IVp72pCU6HsIJnWjgWMNhtb1CdtunhrR7WljLIV5HIKFSXCU/YhFZJMaTtFGLe+xTx
         bF+1RD6BsgJwBsjYbC/LRVVG8eJ1piSvVukTmuyvfHLKFWGdU22g7qFZK+Nu43c6Oj1U
         clhmqbKZUS8aZhtb9Dj/4twHekCVy8f9KHWGEhX6Sc694Rfv60h1a8o0SiPVdRI0ZGXA
         6bw+0TgcNLIj/Uf6ZZPih1DJUD2eAKbqhdcNJB3qyD5HEIKDyY0oxxJuSXEe32XKgnfG
         1CisJ4lcA/88uPRZa6p3wiLZrf88GZncg+I/namttPObmf5/U24wQCjSkzNTqifWKEDQ
         NkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715717307; x=1716322107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvjoJ3H6892IQ+WG+yDZXENruQLJb/czhTtD/pn2XzY=;
        b=OQuJCcABfBUNkSSQLyiVr3rERMwHmxbicB7/98cL4bn78SCOslP0bOCFar62SrV+Wl
         pfiqGguu46IGtfyUqPkTUNztOcf4w2dpg6dJc7VgGHJyGLDP04Byrd5qVWY8az7kgBBR
         xZIrKul/18oFlTZ0KtuqJXDl0qErRDmQGTZtb+cpQDj1+HsvddW/2dvURMTXcH6ua3gp
         avGwkQ9qwpeJ9emLQa22i3fP/GnGgE6BdUvxr4zTW6nA64zbGCdccf9pIURBDLwxHd0U
         JoZDdPyAZo+OJpDIsChfrqtvT435ynj1YswOiBpw0y3FoT5du8tQcOaNARJVuOw8ABjQ
         omaw==
X-Forwarded-Encrypted: i=1; AJvYcCWb/KF5bdB+Bep6WqgpDTz1BIFwDivJNX2qfbR6RcH8EuU5u2PzjFAd7yC2oG64wMgjvSxu+MFrUeNE2pBsHXRdEDtcEYNF15ezG5G+
X-Gm-Message-State: AOJu0YwArctf0eMNh87KxQPhC2HJZFAvZfS2Z9nYu+5IHG5z6GzmA4zp
	nQmNZFCNn2scf2WQ2kiDgbv4AsQNpNDyjyLc8io6m12DfyMQf+f6cG76xTSMrDeDLS7wyQRrVeH
	GDTn4TcGODRoyWICA8jJCWzlgVqk=
X-Google-Smtp-Source: AGHT+IEPLqc+S8mwOzSlD9qkOiMIP3L1kSLyeSw+t3/KMw5TNbtUgeOPShHGNCog8hcDpyKJCP2QHrDpVrC0Qsd0ug4=
X-Received: by 2002:a05:6122:d0e:b0:4d4:126b:2c8 with SMTP id
 71dfb90a1353d-4df882ea840mr12437198e0c.9.1715717307146; Tue, 14 May 2024
 13:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101038.595152603@linuxfoundation.org>
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 14 May 2024 13:08:16 -0700
Message-ID: <CAOMdWS+Fow2jJm9j66Pb2hQH_uyvUtHxM9+HdFwmT_eHL-Qo-g@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/336] 6.8.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.8.10 release.
> There are 336 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


Return-Path: <stable+bounces-66043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1A94BE9A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DCBB25A25
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5C18B482;
	Thu,  8 Aug 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wo2+Seh2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FC18DF70
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124147; cv=none; b=WbD3LSWBcGiScOnKVia7gfqLOt2oqeP4U0i/DLME3iRVA+HKecCZw8PNSvJwJWes95dBij/XNuOs8MZNOUhhs14IGPQxkEk0wDIw4BybZ1Y9eSxdSfzX7O47JwBY6Y/+LkPG+GEv0RaFmYXOLqhRJJmdIKFmZVE97QL1X+iC2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124147; c=relaxed/simple;
	bh=2VxjvSo5CWeUGj2UqWljBijX05JHiU2D382WZGpQshk=;
	h=MIME-Version:In-Reply-To:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type; b=lEJUhdmc5PgFjJ+XzB2TevlOg19VuK8j/O+w4W5CvBLDMtAMX3jZxPQ0YDs3tklFf3ptbYXV6A9zg7Kli4a8BjT+vn12CUXKRKomBxFoiEiw3J2V6yrNNQj7ycMRri2Z48hcixaFwjOsivDAchNvOtf3HyDnl2yvSgBQSxbsRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wo2+Seh2; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fca868b53cso9289785ad.1
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723124146; x=1723728946; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2VxjvSo5CWeUGj2UqWljBijX05JHiU2D382WZGpQshk=;
        b=wo2+Seh2mRLMvV40aVlXkbwNvtOx5qxHYPfYeXhYKuvSzQpc2X1/KKJ4nVab6dxoBp
         9ZVocnM/mvFRBOC/5qRJNQHf/ECHGF5v2c6QVEypytq+S6AcQ77uZ9/EhYPablwq+XZO
         4vrqyFzTFVIaym/3ixpE/Skj6x5LeCGK6eqM4bexpoYTYPqnF3KjAvCqdDoDhaDHkIJ9
         XqWaS5IQ5P9oWP084j7/8bwsNo696xnr1R5QM1Wij4OsfEpvZMmY6jQPmbJB7tqH2NJR
         OKeV0QbNisJ9Dh/nH+dIAfmaHZKhHNPwTeuzAqCOl+jPQhLCa2OZNsXcqk/3AJAN11Rt
         ic/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124146; x=1723728946;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VxjvSo5CWeUGj2UqWljBijX05JHiU2D382WZGpQshk=;
        b=QFSN20G9ZV4vmJ8DGIsgdorgIxCM+htsjTQg6i5xA4ILGmgIekFEBP8o312VwA5iLJ
         BjstYlRdfls1ubhzKcHmc5FWXkpnWPbq9qcT32089gU7oIK0n/Ze+cBWbO9BfWF1QXoi
         rAmai7MmYRVv4wjglKCTP3gNymf0HQ0o3XwcDwhX6tTyaVbWSUCEtNlV9Gwekb+iCVtd
         L9A+6R/5dvAVdeUKxgMnGEqLaGFc/D7WkEcO5hvwIbsBZ4gUtcrkcSIR9IaXzKS2scEK
         PPbJQNJPqEpi6KljbsINezgS5rpcYGqhWETBRUsEj1GbjKJVNFk/A5/8AybmTcZcNF09
         posQ==
X-Gm-Message-State: AOJu0Yx1UVJmlBuL+2uLRYSXnVfJG4/fLvdV+axz97Fop4eIXa5wub9u
	VRGBaxvZFsQvuVtvKUwC9fT4hu1qWiPwvcGcivsf6abdETHzmacfC8KLcXxyALfYw5IIss1sgd7
	KVvE+KhmImiyLISeqLr2d0wmh85TtZK/9ca+gemIMV9uhnUPKiSwrBMIo/V7rqSYMXMf1fr68uT
	LzMZt4NuV7z6VuRTgThPAL0DId9laI
X-Google-Smtp-Source: AGHT+IFYnhRclT0lkgMKhJlVtiYmJB3iQVlz9EWjWvJ/qMbE/TeWDH1hqjCLcKM9l13PdPH/Nagy7Dj2L2nYNmFFgOkNKgx5jYwIYVlvgUPBnlRRlw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:c40b:b0:1fa:2b89:f550 with SMTP id
 d9443c01a7336-2009522b657mr1711305ad.1.1723124145897; Thu, 08 Aug 2024
 06:35:45 -0700 (PDT)
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
Message-ID: <0000000000009f2a72061f2c1aff@google.com>
Date: Thu, 08 Aug 2024 13:35:45 +0000
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
From: ChromeOS Kernel Stable Merge <mdb.chromeos-kernel-auto-merge+noreply@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, chromeos-kernel-stable-merge@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hello,

This rc kernel passed ChromeOS CQ tests:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5766148/2?tab=checks

Thanks,

Tested-by: ChromeOS CQ Test <chromeos-kernel-stable-merge@google.com>


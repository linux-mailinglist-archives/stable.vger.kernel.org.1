Return-Path: <stable+bounces-169492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD7B25A36
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 06:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB517C265
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FE76026;
	Thu, 14 Aug 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im/15yg7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0179FE;
	Thu, 14 Aug 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144067; cv=none; b=kz9Soi6x7N1v7//CbqvhiibvsLQeRISMHXJ0IESRUs1xF6P8o7REMbko/4L3T0m2WQaRLfZFYjJofBMXvyoQhCPHmsT9rudI/6ezY+Loy78Ly3D39rEoKqWxKpArRg8n2i14iMmtFrbkb/gZASrlyNdf98LcI3TfDmE6yXF9EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144067; c=relaxed/simple;
	bh=dLhANDlKfdf2rgsSdEAU+O140IGsNgM4aJ7VfsYJPP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRzO21ScrcIkGEUBvgNs0jtHxIFWsxLwi+VRWULL77/aq8y7PFRzVxHdsFu3SjIYsRw9MfhBiGu88fqL611+LcOumZrp9q0B6MvDO1NoG3Ba5KBO95fihUltmRbxfTCSkZ7h9ZIYQaca5lkA35AukyaBgZDRtryk+3l39cFaJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im/15yg7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f918d71eso3491081fa.3;
        Wed, 13 Aug 2025 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755144064; x=1755748864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzUrh0e42gNwjwu5M+ISAP5VqZYMKnR3h64thSNiX34=;
        b=Im/15yg7hzt0LKFGTiFxN0myCURoVnR6LCW9y7he4NUWqC/TrumQ1OYY+oCcbGdxQv
         f4os1kFr1ksNuSM0Q/GYCBBFMHKv8oyGSZN8FPyfrkFbJEBe6MrKRWx5U7QoPzL1vC1R
         V4D9nnrTMRn4fwJzN0r34onkyZKX4hVYQR1V0MIYb9Cm5A25b1NVYu4AbfCswybclkxi
         K6yfNfcI56fyUAFHhw3nu4l7j3PJXhxBSInpmpg84KuwHTzCPq3LRRI29qt3tMvag785
         aY/vJ5Q4C+cV/bqkemfEI+EaPOSnzSEoRrscVahZe46YbgsLRwZ+0xxoOY5mpDlPi4gU
         UWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144064; x=1755748864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzUrh0e42gNwjwu5M+ISAP5VqZYMKnR3h64thSNiX34=;
        b=fjSxGIl7phJTlgF3KifzG4fiZ2aOI0yhEj/oV3/Imbt1IjozAcgrGvOBDMZwNEac8A
         s9wl56Rh3Y/ENsbUrIFnMzw0LmNpZGr2PTpKWJFFvu7k36n0zWFeDoLFSm3v++ZeOiSO
         A7RtiJ9Q5swK6GG+LY4JyqoxZ4EFXQsDv9o0KT/qqzs62ldwPDNlfcpTXO+SXKQKlXNw
         /8cAgDyW/M2PkCwN81EXs558D0W7/KtwQFVkMlZckrLQydGn7uu2kmVvbxYZEtju6uM3
         vSacMh/D5HHUKY4jL5SsiPQmf7u6cYNfpXNivkENDgOJwFj7tDuzr7fSoVP2GgBBvX25
         12uw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUPIKkXdWYwj4OAnmPRn8hAdMcPyNO9swIl7VvlViZpp4Z2zKFEwkVXiYqrTBkpo914RKhs+faIslb/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAZYmyuWxMxz3mAnh1bH24+6aBSBv+gVwPy4o8Fzz32Qnj088
	ozIvbLNRELJSkPP12fRRwsCL5AxKGXCQF3BEuVgQAJLJ/drg3Bc5xCYH
X-Gm-Gg: ASbGncvEpdar+lcy35oC3v9rZluSYjy/oDljsov2LMs0wboOg33c6itqCjQYRYtKB2g
	I25bCbu8KMkhYOcNn08QUdHfEUewjk5zXJvplkYyTS11CHhl3+2z/HLYLhjJOQkbHZk/8uPxteq
	pHjJGylc3uBkzs9SY/NQa1UHtxN+UMffcR5R2nDi+KXu78tNjpb+gaoSHgxrtKFcvvPX57C0Ea/
	KdeL3GuWT1PdLDYty2ywGWvxV5h4ylTlX7P9yjR0fqC+0OckC3URI7owHyr1KXMX4q3vfh+UlCU
	EfqMMXtlS4D6a/vOqGudcR64Bcqm9qmBPhe3ZHNWM6hAooQDtIhqddNWEKxbSBMAH/cWiAAgEHu
	AJh1Pi4UR
X-Google-Smtp-Source: AGHT+IGB2hSnPfcKf0UCB/sWlPfcCkaffU+0E2DyA4PHaaSkmVONyTfaqDNvLwDl6BmNKeNDSIOfTA==
X-Received: by 2002:a2e:b5a1:0:b0:333:f952:e400 with SMTP id 38308e7fff4ca-333fa7d8f22mr2479451fa.19.1755144063525;
        Wed, 13 Aug 2025 21:01:03 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cbcb08sm1366551fa.5.2025.08.13.21.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:01:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date: Thu, 14 Aug 2025 06:01:02 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJ1ffsxetEzx9HKC@lorien.valinor.li>
References: <20250812173419.303046420@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>

Hi,

On Tue, Aug 12, 2025 at 07:24:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.

While testing I noticed two new warnings compared to previous tests
with stable series:

[    0.000000] x86 CPU feature dependency check failure: CPU0 has '18*32+31' enabled but '18*32+26' disabled. Kernel might be fine, but no guarantees.
[...]
[   60.281912] sched: DL replenish lagged too much

Need to investigate more.

Regards,
Salvatore


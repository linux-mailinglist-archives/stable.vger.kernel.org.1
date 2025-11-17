Return-Path: <stable+bounces-194975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95024C65022
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 80362240D2
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7612BE7AB;
	Mon, 17 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsrEcFBO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7B23BF9B
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395254; cv=none; b=jzbjMCAX5ZGt16txiGdrWegpSfIh/H4y6apLmhlyogiVGfLXC6MVPqFSaSIgYR6BWphdyorEfA3KP/lPOniHVE5aUQb3uKSAOeg8b8l09NUuUw4MeNj/icMyhp5OQQPRAJ6MkZcy88k07h2OXS9B5dyya3LdZ5PfFdvFD/xxIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395254; c=relaxed/simple;
	bh=gPI0C6syoehgpLs27hBA8AFGKtCtG8+sA7VEVWD6eDQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wrc15rp4j4Rh+Q344EnDQiTn/JyjcrNPX/2BuZTe/WDjo7mUU/fyokHdU9HBV0yv0K9JkuC8VzM+gzAgWv+73xjh0/B0KBpZTZ/Hqj6fD/5TcAAIPU/nx819Sfp3bu16lwNzeR4T6gKftmjNpTW/uQiFW8Q5l7aJff55NtU8qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsrEcFBO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so30452955e9.3
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395251; x=1764000051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8MfJOCnIiNYi8BMGn+NPB99ABQIsMxcFHnwgdzV97ds=;
        b=UsrEcFBOn1i4/HFjvXXIh4O63xfb4llt6q0j18FWKE2Jj3fKkxlHM9QPEHxP2Djc/k
         Yg3/sgv1UlzDsR4HATlEIVyepmzemy1ElB0pMkLRE4wKzUsXBY0FvNjqSy49Co0hiJh/
         CaxEtADrgZBkA70eAfxj44Ehzs0hXhZCBZUqvOpeS5t5vK6V47nUiejcZU0vte30GGj6
         lK5ngTT/VhzoArg50BBqJlJLONQHR4hsBQ+4fnEo7dFu7fwfNliv9bnUlZD3Qzv8U9Fv
         xvwvKiGxxLcfOxytKDIAzH4EyuSjXkVyZ4blk4zvULH2r/5CJFOr2YwTxdpfzt0hwxcz
         AonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395251; x=1764000051;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MfJOCnIiNYi8BMGn+NPB99ABQIsMxcFHnwgdzV97ds=;
        b=DzoxtQIrWWv/aatDIqnw5XjrP2P+ivuo0WkfCEhFS5a6bfkcmLwFUwvIJ9iNzCOS5V
         SJF9dtZLs7P394pKsW6hjnQA7S6vPti57dk4knWFaEstdnMlgzgwWQWz+nTBiuYhOlYe
         3kIz3TSJW64QmgDDatx/9V+DfI8XqBKd9+GNYLq0vE1PXKQbUEJIVKEqx5b3Q9doSb4x
         xy2ZDK4WIRgeacbm2W+nBmVs9xtgkwKzxPMftxtOZRHi1q/9UJnk+zlqMpZ56p4+S1bM
         UoIDPJLYMXWtCdSS1i4ulWFriafJ/a3IGOKx3d2Blq63evuXLsngf108skleOa6fvpJA
         mgkw==
X-Forwarded-Encrypted: i=1; AJvYcCV2yNxwABj2oUZjaOXCsozHBn5tgZVvWLE77G2V2nAUwd/Y87VBq9jzhqsjsVRpcM4wooFcYI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJgRUVEI5FSanIaVWFkYeXMWhXYFmo6b1zWIqD6jusrr36AE5
	RnQZwO/gfY882LR7dE6PyGPDRpxfj0f9qYZud35I54O1NsXNUyDd7s7/rZkJEKtwFdt1E41SwCr
	o173VZRPzcR0trgHxhJ+yt58Q90M31dQ=
X-Gm-Gg: ASbGncujgMRcLeqIy5h4SP3C/aBpM662gS5GD9t7Hj/2rMxyAkNtnXRYPtxieUx4yUV
	SwsH7qj4YUJ9Fyod9eBO2Ee9coK13kT4sH+v395e422xqp6TYrxFHbYuf8IVPpaq7b3NwphNmcz
	/TUFuvBSEv9NN5lfaPqokvgXW3Y+/a6o7v7nkIhvWhUeCnp0R1dBrzjrmEluBZmTNaG+24m/DYG
	/TpapQSvgkEfcz7RHBHL9AsSBhQ5509dxjClrH0z8Ah1CXxszZb3fYIqso09wKmufwZDI14
X-Google-Smtp-Source: AGHT+IHW+g/BPRYaCa4/onCsB+Xol9C9Wfq5DHTB6kJC5BaFMll2GRNcADVlDtl6mOEQPT60rlcj4VLhQLLKjImcMvE=
X-Received: by 2002:a05:600c:8b21:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-4778feb566dmr136106965e9.30.1763395250721; Mon, 17 Nov 2025
 08:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Krummenacher <max.oss.09@gmail.com>
Date: Mon, 17 Nov 2025 17:00:39 +0100
X-Gm-Features: AWmQ_bnpKPbAGbvsTguUPABUOHsZFSWl8Eduski5J_5udQ4gFFyYAvf2tUhFav8
Message-ID: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
Subject: 6.1.159-rc1 regression on building perf
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Ian Rogers <irogers@google.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

Our CI found a regression when cross-compiling perf from the 6.1.159-rc1
sources in a yocto setup for a arm64 based machine.

In file included from .../tools/include/linux/bitmap.h:6,
                 from util/pmu.h:5,
                 from builtin-list.c:14:
.../tools/include/asm-generic/bitsperlong.h:14:2: error: #error
Inconsistent word size. Check asm/bitsperlong.h
   14 | #error Inconsistent word size. Check asm/bitsperlong.h
      |  ^~~~~


I could reproduce this as follows in a simpler setup:

git clone -b linux-6.1.y
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
cd linux-stable-rc/
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
make defconfig
make -j$(nproc)
cd tools/perf
make

Reverting commit 4d99bf5f8f74 ("tools bitmap: Add missing
asm-generic/bitsperlong.h include") fixed the build in my setup however
I think that the issue the commit addresses would then reappear, so I
don't know what would be a good way forward.

Regards
Max

P.S.
Checking out Linux 6.6.117-rc1 builds perf.
make NO_LIBELF=1 NO_JEVENTS=1 NO_LIBTRACEEVENT=1


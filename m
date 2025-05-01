Return-Path: <stable+bounces-139420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3EAA677D
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED021BA6F0E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AFB26A1C1;
	Thu,  1 May 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WmygRGhI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBA21B90B
	for <stable@vger.kernel.org>; Thu,  1 May 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142697; cv=none; b=FWLpdM88w1EnWTyLM88r9G2wFQofbYsre/rj9/+ZwiyQF8hgPZT29KrJGhlvesbKm4dYUgOzgw0Nvb6gq3ImHgwdpqHUHxEZcXa9zg5rBwPd03JNNn/r7Cphho6GdJrBY6Zkeowuocco5aM1uHeUpIjoIiHjstWtsM9fnPIklDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142697; c=relaxed/simple;
	bh=0bE9+sg8qqZlZPymEWPsuaZnLc6tICoEgjFXMIsxwYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hee+x0B0x4w+ZZtRT2sC1ntXEdOzZBhTRaNhnRdd03YhOtWE0iDam0z4MfcsmVRjsGHEVV3cdKKcjSWwBBBINvP2V95Hh+QhaC1o6C2SEMhXjLEd0WVMy5Wv+jLSysDnrtxslltb9hzAq85NQ1nGhPZODi5a9xdNTjuSREm04m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WmygRGhI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso2614599a12.3
        for <stable@vger.kernel.org>; Thu, 01 May 2025 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746142692; x=1746747492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOH+RLxLUbard4BV8J+6a/3tBBv1bO45LVfQDoB6LRw=;
        b=WmygRGhIIgTYpDdNViXss4G5+8k8T8MUEx1VoVVEci6RElhco2gn8MEK7c1FniCaxB
         g8CEeXAaNGnFO6CaZnqqcCXcDDgCfALUyfs2pafj8/IkBDbIKKJTwkf1R28ggy6FtZTO
         un4BVHHA04tct9M/sDIQANkmwd2ZdUnleUqsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142692; x=1746747492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOH+RLxLUbard4BV8J+6a/3tBBv1bO45LVfQDoB6LRw=;
        b=SiKNxz37JeSAFQfC42n+m4wh1J3bKePXJCENkq3GnSMk8QCd8cGtsALjOzwkhIxxOF
         /TjoATgoxK9B95fEp/eRWu2twoDKxQy+SNmTDZ7qSboWliKfCIpF/jfSLL52HQIh5qND
         uEgZHbyVTa18srxvkvppR6Qb3y/x6Wd5WAgm+1lNENO0Lftw0ItPi9q5q21zpwkS5Asg
         mjRyXZmopSrcuI7HjR5jS+YsXTRGJj7JR1nIVv7ue6E4Gx6wQSTwqiRCGotCt7se93fT
         zcgyWOjYsKzNZ0C3lO0X/NFVMq2eidAQSPglnWrnbiQoYzt/xd1gjI1i9KHbaC+FvKhU
         E5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUHCaRo82ljlIw0CWSVoGUaxYvAMzFXF6j9ekGjpazdom1OmEJ27JgwcH7GnMr/cXtEDqb8M8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMyeD0N0P4Ld56zjBzrmmB4m4ulfNhpEVCbHtAEaO7McFZ51c
	mT31xvZyicu0l4HTHB8VHS4/4RnKR1Y/b3znwc0ndi/O0U7+RXyq3vDxQvM0F9zNsFIGauGz9D3
	IqkU=
X-Gm-Gg: ASbGncvImyMjS9E9cfZU93DUw1pHViUxfuVv5NOjJPmCp9S7YhoDNlJHSLLfyqB4tJP
	EgTkNNy+0wiXP7cEwqbv0MQvz9PucXdJg8nvw7UtnVyG/iY+HoCvF9GmmguIvXKzhoomu7nTCso
	p2Ofj6Re42KSrI73ikDb/0xQ9oloKta49Vd5iwut8a1c47em/3fOaPmqa9ISsx8AW6XOMEksF9S
	+4WGSr8IOJ9bMVXWZ6mmwFhu1vAlZAgPymU822aremWVjdneCHr9At5AgcfiPRLm5qW0yoOXvXv
	fzsePEZJhH8GuAESv1e9zkJJ7Ia3Af+Pa6tDdToivFEu5+OaD/OflfwsRRSsjhEOS82f6SD3i7W
	u2IZy9I6T8wAiptuwPfy6IjWHgA==
X-Google-Smtp-Source: AGHT+IG93zlAXTYkW/Kb2/+ybz45UojzdHTbKQVZASEfhpUXn7jQSa9XsMhou1Yq36PVzvSVUSIlig==
X-Received: by 2002:a17:906:794f:b0:aca:e220:8ebc with SMTP id a640c23a62f3a-ad17ada73b1mr102300566b.25.1746142692560;
        Thu, 01 May 2025 16:38:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad0c70d38c7sm110660566b.31.2025.05.01.16.38.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 16:38:11 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac34257295dso233843066b.2
        for <stable@vger.kernel.org>; Thu, 01 May 2025 16:38:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIUpji8U4TsyowPNjlKL3slT9cvqsECXAgS1YuRR+h+yuTmwPENZNgIDnUTddLTfhCTV5sh4o=@vger.kernel.org
X-Received: by 2002:a17:907:3c92:b0:ace:c225:c723 with SMTP id
 a640c23a62f3a-ad17ad1a245mr90568166b.12.1746142690891; Thu, 01 May 2025
 16:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-default-const-init-clang-v1-0-3d2c6c185dbb@kernel.org>
 <20250501-default-const-init-clang-v1-2-3d2c6c185dbb@kernel.org> <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com>
In-Reply-To: <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 May 2025 16:37:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikfj_JLqDQCc+AsymUije3Sm8h30zQeT4yieqRicFOzg@mail.gmail.com>
X-Gm-Features: ATxdqUFyafpfCSgNRMdjOdlgLHXvb-kQiDBd8FWFkiq24cJvTKf1aNAAYT-juyY
Message-ID: <CAHk-=wikfj_JLqDQCc+AsymUije3Sm8h30zQeT4yieqRicFOzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] include/linux/typecheck.h: Zero initialize dummy variables
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 16:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How long has that been valid? Because this is certainly new to the
> kernel, and sparse does complain about this initializer.

Sparse is clearly wrong.

I went back to my old K&R book, and the "perhaps in braces" languager
is there in that original (ok, so I only have the "newer" ANSI version
of K&R, so I'm not checking the _original_ original).

I guess we might as well ignore the sparse problem, since sparse ends
up having issues with so many other newer things we're doing, and we
don't have anybody maintaining it.

             Linus


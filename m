Return-Path: <stable+bounces-152286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3EAD3560
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4585417577B
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423622AE7B;
	Tue, 10 Jun 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPY7y55n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39622ACDA
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556648; cv=none; b=T46tox2QmPY1EgojpUFP9M/ddE9wCPY4z1CoBWhoWtto09iB2ezqXt8/Sm3L03Fk5U8O+b39rJ4DFuJB4Ji5ooUW9RTqX44FOgZxmXNDr8rjql6uM2UoILhF+jyYMvO0kM18j0vLvtBDwI9TjKI1L8nR6oydSpzU4+Q9I5trn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556648; c=relaxed/simple;
	bh=MPeqqbg76lu+Wb+e45oYflxMl5SJ7ctjBNdciDd/NSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTeCw650f9MsxKwNfhgTLk+xkaCJ1Wlr5VrxNmlAn13Py7Jv68atV0aa/ANBvhE6Z3q066e0wspsFQHgIzBvLRhLdyBQ+iAsUvrZiDR6epLLGjPE4SvQeqapm62yhfmBenPChhDgUDKcYPg8YE6yk1Q4gNMFaL3MhNzI5hbPztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPY7y55n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so3073941f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749556645; x=1750161445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1tPKB3aQq3zXEcMGGtGtVzly+alYokN147Mvu6MtPk=;
        b=GPY7y55nvuYiuO3cq6kAHyGZec+N56/imIeFxFvHqUZarkdUPLM9KO7DqKqUE/N1A8
         im35S8tF0EKhDQ3teKyKIYfEoxse/k3zkRVzrLH7Aoii5aDrp+AqE6bHf5XgVGSqUZLO
         WcHFuKIjklzQ91GDhvBWW0Qyzy0pwgrqEF3gQLkEPR5v/1yG6kwBpxF8+kUxXPj4XJSg
         3Z2wjhCImWBmMd+FHpBRvttYmFI841pjQKCzhHBR3pJfKEq42gXZhv4LJhSrVhevxMVK
         Pntduof3QydJn3dBH3WL6IErqxrE2saQ22UoqEQTgL+4YmP1qBff5l2p6az9leYfay6F
         aAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749556645; x=1750161445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1tPKB3aQq3zXEcMGGtGtVzly+alYokN147Mvu6MtPk=;
        b=ATijwJDNsBGfHfGnn5NDbAsjwD4681IZcg5Lbjz1BA2KkgGXVsprpUSIO0H0HBRoEd
         dEEewDeAe1h/C7JbJwc1nWWRrJWqKk78Bppsey8wRlJzPTORRh2yiY6R1daji9FxxZmw
         4VMmuyCKSsKid/xOslrXzM5bWvEJB/7Dx7WyS/TJzOvlH4ZTqKsmftG8My5UAKq+Kuf5
         ezSex5g/p8OcJKqaM/UnT85PDdLCMgMpui6uSBGvYB55qwytXSrozrLKu5avWc7fbv3E
         whN9PIlEOU74RlJ30NayLMf1G7JJD5LMyskQ4FFwrKIPV2nocKhJ+2ERN1jKh890OpiI
         HMKA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmO6Pk9lCtgnTJNH+wGIcMBj1lUgx9qccrLew7I6WHabo8AeunhQE1/dOUhak12K35jAvfPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyV7cUjJJ2w/1KuWohKdWesiod8tEMOy7SIh2s1JuuY/MXoKYC
	dWxmn26g87cnYOYnAQTBnm8cm2naX9MPf5jj3umin4wrKtc/82rej7E0m3mI2jE4v7LmJEhLOgt
	Zev/K
X-Gm-Gg: ASbGnctS+wyVX3ZqtEh1/j0TQzQqwwAViXnudkCdUgvnF0AXQWkNCb/ZdMVkrs9pr4N
	w3zIRXeCKBP4emo2wzdRyk8SBMQ3i3/EEzoF0CktCmIXjdxRdIh/uTAvo+PIRqfl2ilSIINE+Fa
	BAnFi4UU1O3lWfsYLqh24CbDmUBTfJSumdj7irfll6h70lRaS1joz2+wJGcwPXqbryMJXcXMdhN
	RtDeC1WD/ii9L9WDOS7DtuwPm/4qKfDdWPHFTQoC0bBUZGzErga9THeZ6dHBfrQ/uRpU8aFIME9
	XAef0uuTeh68gF2eFTK2VpAYgsAsEVICfh+XixbVn4GMPtxH1yEU2dZ7MaS4fSNILB8=
X-Google-Smtp-Source: AGHT+IFRutpWq3mI++c2ze5et8BoMgRFXoiM8t3JTvOFFmUsflzqRA3Ic1DXBWG2cyZjgDJOcU/CWg==
X-Received: by 2002:a5d:584c:0:b0:3a3:648e:1b74 with SMTP id ffacd0b85a97d-3a53188a8admr13108602f8f.6.1749556645169;
        Tue, 10 Jun 2025 04:57:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45307c78489sm89779445e9.4.2025.06.10.04.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:57:24 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:57:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Avoid memset() in aes_cipher() and
 aes_decipher()
Message-ID: <aEgdn1U9j1ubbfWT@stanley.mountain>
References: <20250609-rtl8723bs-fix-clang-arm64-wflt-v1-1-e2accba43def@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-rtl8723bs-fix-clang-arm64-wflt-v1-1-e2accba43def@kernel.org>

On Mon, Jun 09, 2025 at 02:13:14PM -0700, Nathan Chancellor wrote:
> After commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing"), which
> causes CONFIG_KASAN to be enabled in allmodconfig again, arm64
> allmodconfig builds with older versions of clang (15 through 17) show an
> instance of -Wframe-larger-than (which breaks the build with
> CONFIG_WERROR=y):
> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:1287:5: error: stack frame size (2208) exceeds limit (2048) in 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
>    1287 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>         |     ^
> 
> This comes from aes_decipher() being inlined in rtw_aes_decrypt().
> Running the same build with CONFIG_FRAME_WARN=128 shows aes_cipher()
> also uses a decent amount of stack, just under the limit of 2048:
> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1952) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
>     864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
>         |                   ^
> 
> -Rpass-analysis=stack-frame-layout only shows one large structure on the
> stack, which is the ctx variable inlined from aes128k128d(). A good
> number of the other variables come from the additional checks of
> fortified string routines, which are present in memset(), which both
> aes_cipher() and aes_decipher() use to initialize some temporary
> buffers. In this case, since the size is known at compile time, these
> additional checks should not result in any code generation changes but
> allmodconfig has several sanitizers enabled, which may make it harder
> for the compiler to eliminate the compile time checks and the variables
> that come about from them.
> 
> The memset() calls are just initializing these buffers to zero, so use
> '= {}' instead, which is used all over the kernel and does the exact
> same thing as memset() without the fortify checks, which drops the stack
> usage of these functions by a few hundred kilobytes.
> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1584) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
>     864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
>         |                   ^
>   drivers/staging/rtl8723bs/core/rtw_security.c:1271:5: warning: stack frame size (1456) exceeds limit (128) in 'rtw_aes_decrypt' [-Wframe-larger-than]
>    1271 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>         |     ^
> 
> Cc: stable@vger.kernel.org
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Yep.  I recently re-reviewed this because someone wrote a blog which said
that compilers were implementing it incorrectly and we need to use
memset().  However they misunderstood the rules and their tests were
flawed.  Using "= {}" is safe.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



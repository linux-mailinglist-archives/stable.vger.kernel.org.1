Return-Path: <stable+bounces-163090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96261B072B8
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD10189A9B8
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961B2F3635;
	Wed, 16 Jul 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sN1u+dUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F232F2C72
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660549; cv=none; b=TqreltIERIv9Q1Wh6hOBvbONcvCd75wuoFwqCSISS/Eelty74Si3skMc18u/0qHTs1nZiN9dJSPAYXhxj3IO12t/lK5qQlKqvxBKeM5ymVzYuph1gtM6WrFFlCgHktSLXedr1U2mr2FY0qpalaNt1ukIDzSi+jZWfxzjFn/x/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660549; c=relaxed/simple;
	bh=bFBhJZawVLHR8IcJ2Vcrd4R81/LwC9KrzFTtxMVX5cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M66ibd4gyN9TjMGXdlNoMzCq2nz/x0UJ8srb6g3rjRReWUecAhqEW31vOYwangvnHBYHa+svw6+S+MkLo4ekGM0mY+oUfAkJdZyGIJZVXBkAROTF1+HP30QoFnwyD2FMUinBrh+JrwzPqA7/pFW6AR8f584oY/p7ZlbjLeq9fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sN1u+dUz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8187601f85so5685519276.2
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660546; x=1753265346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gV45BWglfzhUxE59Qv4ombDQhK6ciqBH4GljP84GFs=;
        b=sN1u+dUzft03wayk/ercLDN00LqfpmYkT5JASpWQV9cKGOzp4Fj/BfP4suoPLQGtlE
         w/v4eWRukRI75cLmQD7SjCkvSN43rhA7nHRd1OKo5lUdlC9ubwecYGqMQUcMdkOm11Qh
         wTOt+4KzkFNcmomKhA7vtXvttgUO/pfBq0Xy2E+c+63jLGu32KV86GJw2wKUVL7ROnhI
         66KDJtFphj9yKl+KiE0ahGEEwb0JCXIyk1TD077C1jXnZQ9/DSIV0bz1Q/bGXYpmKLdv
         SwkJRWOizAmsoL7t2mMJu8ZS2nVeKI12VSxurVU93WaNGBID5K326LyFn3M9dvxMIBKC
         SsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660546; x=1753265346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gV45BWglfzhUxE59Qv4ombDQhK6ciqBH4GljP84GFs=;
        b=Y3PubIDSHarOGo90yIjwJ9/ldHS4Yid9rega9WHXFZHJ8TaREEUcC2qCnTh5+gYdHO
         2oFYCPlicMpV2hpyuNymm7SY6GxhQA60FVptfa+9SGYyQhdElmmQhAcYCix3i4gaD9/2
         NOYdYEDWzR09IGrvivPE/aFKB5+d4rvUNd4e5IfQ2ME8vIDbt0PGWc8ejAb9//fEQHCQ
         B+xtYGbaHTt6uyN1J9T+HaJOtKTW2uryX5SHCja5fKKvX9nMGqsE/sF1Q3aZPayqnuve
         2oaUxzgQ1AyrWfI1LD8PQHQtdjbp4ObS3wxBNj2wKz3ZfJoP4l8uWcBJKBLHVag9k4+M
         qusQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14JHkKs7U56RFuPi0I3iB2tsSHeQQ6WMupBAJ8Evhc+ACRMB5XkQTf6bRpnpmtwvHKEk3nfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02e1pEHl25VI9adcFpeQNEuaU5MwDf2v6uggVUPyx0pL6Zxpp
	iXKQYUpYGf5ilgxaY95DcqyNoylL9OjZjy+ibba8K82HYZU6MHkYT4VvqM1MIAxoUoqpx5eeIN1
	ws3r5Mn8Gur5BZDr2DMXT/S81eGTjePvDUXE66bgBvA==
X-Gm-Gg: ASbGncvIeuCRkCHU0FQNjaPHD++KkXZlMSEmLpShypRWfUZtcnsTAkTgGLWV1Ptp9ll
	SJ2DQ3yiZyY+uZnD7EQwQQwrKKFsWUJzolwWTrFcQn2QUxefwUOu7j6UC4wsSjazG/pvyOFPvUk
	IKYrY9G3Vr7d4asTZmK8bUky8/Vn4cxJkMW2LedOjkLZL2vhOl29IBaTo2QCJKHX7MWzqctHGNy
	8uuYP/7
X-Google-Smtp-Source: AGHT+IHbf9uC6mvlDjLNF6dIc9S4dSQ+VNOZ0NRDgEmrKLk0gdoDzLQwF9jjwQJK77A/D6L0h1BM5w/vF4E9CMZ6E90=
X-Received: by 2002:a05:690c:730a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-7183517dc19mr38773327b3.35.1752660545599; Wed, 16 Jul 2025
 03:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-memstick-fix-uninit-const-pointer-v1-1-f6753829c27a@kernel.org>
In-Reply-To: <20250715-memstick-fix-uninit-const-pointer-v1-1-f6753829c27a@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:08:29 +0200
X-Gm-Features: Ac12FXyidmVqEt8vJA-TGBN58fq86rVrqsDtWU_9Q1n-pkGowaYzgUWF1QhgIVw
Message-ID: <CAPDyKFpb+_N_XbZrZ02QDFfgk0MNMWb=oJC4V10+s+CrDXdUQw@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 00:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang [1] points out that id_reg is uninitialized then
> passed to memstick_init_req() as a const pointer:
>
>   drivers/memstick/core/memstick.c:330:59: error: variable 'id_reg' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>     330 |                 memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
>         |                                                                         ^~~~~~
>
> Commit de182cc8e882 ("drivers/memstick/core/memstick.c: avoid -Wnonnull
> warning") intentionally passed this variable uninitialized to avoid an
> -Wnonnull warning from a NULL value that was previously there because
> id_reg is never read from the call to memstick_init_req() in
> h_memstick_read_dev_id(). Just zero initialize id_reg to avoid the
> warning, which is likely happening in the majority of builds using
> modern compilers that support '-ftrivial-auto-var-init=zero'.
>
> Cc: stable@vger.kernel.org
> Fixes: de182cc8e882 ("drivers/memstick/core/memstick.c: avoid -Wnonnull warning")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2105
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 043b9ec756ff..7f3f47db4c98 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -324,7 +324,7 @@ EXPORT_SYMBOL(memstick_init_req);
>  static int h_memstick_read_dev_id(struct memstick_dev *card,
>                                   struct memstick_request **mrq)
>  {
> -       struct ms_id_register id_reg;
> +       struct ms_id_register id_reg = {};
>
>         if (!(*mrq)) {
>                 memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
>
> ---
> base-commit: ff09b71bf9daeca4f21d6e5e449641c9fad75b53
> change-id: 20250715-memstick-fix-uninit-const-pointer-ed6f138bf40d
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


Return-Path: <stable+bounces-43036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F528BB412
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285B91F20F45
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484D158D82;
	Fri,  3 May 2024 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMmYTq8F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E715887D
	for <stable@vger.kernel.org>; Fri,  3 May 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764670; cv=none; b=B3QLS0GPwVw3KfW/o7pxRHYW6gfvF3f9R07RlItGxmfPTmGzgLqecdcyXJLK5H3pM3zMjxjzWO7aaIaqurD8jkoSkjadiXuXiDLXzir7KbOsUm/xReG8AgsNUbHPTzLGmsy5OaEHT1VOxXehzI1RC0TbTC7Uya5iH3XOivz38SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764670; c=relaxed/simple;
	bh=x28zhPQYDxN9o4XVDCDp8X1jPK2/Y8lfsDGM/Wyqw1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBX3HvhEasDb+qkCPOgVYzRuNUJYdwhLmaMx2ev2J6PglerW/u8eG4HAcuZ5vLwS9+uuEOOJjYJJn0xlHYYzfe1V08tw4IojcGAcF9Z+ncIvScKIfBWjQZnQTNJJ6yHrCMZCIu2H/pe9HFQAV5rembUsFqIXLPh0aTTtIC14MiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMmYTq8F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so67296b3a.2
        for <stable@vger.kernel.org>; Fri, 03 May 2024 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764665; x=1715369465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=EMmYTq8FcnWNpEfEnDuUuEn35bSpggBuRRS9ej+n4B4UDZYnU/bXDuGJpfgiU+9js0
         2rHL0PBoe5CRRli68Rhx4oAxQUmmd/KdhslbhXK8wscdoY5pLDi7XBIW6F5koifZzc2Z
         j8pL5pE/Kz4XlUiE2VqzRK2Z26ujvbhHOmU2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764665; x=1715369465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=VPIM1usu0HXewt24Ef8thxbqtbRdBdoU3RonuT/Y1fvcKXvkqslnthbqQ+LeyUbO60
         QXvEOeq0YEjRShyV6vVzaYH586WlFps6uP+hU9C/ktOenoVP7oYRHZdZ49UOSGuNBZ9j
         wdjFp/XWKZ5uAjAybsiUWvkMI6QHZfH0YwabNXxKZnSfzl27VsLS9kg+BdAUOKNwugis
         vpaF+jROyT2oD+eo+mo4tIRoBIg9zkGuMo02UkKtuUcfzZLGQqQc6r5J/begWexekoCf
         rLipAYbFDBEHKrydBjmfzNReFcK/lIN4PofcRuUy903zRGZZVR1pG4fZ1OqEY5Cppn/r
         j/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSLh2wBTTXzomoNKV+Khb8suiuscRe9I+HFRf3R8oPKSZkJl1pwfLQtRTq0sNIMAS+gzYAEStmPQ0UvR/pyR5005MdOtKg
X-Gm-Message-State: AOJu0Yzjc/+EyoXKpQW5DNmTZHhOLp0iikFyPlbG5GI5hGB2bHP0yZwl
	RiGl+9zhhfiqJ3Kjn8CpNreX0Y38Dv7quW/JNf5jULGW9FbYfNqp/uLag7ZuQQ==
X-Google-Smtp-Source: AGHT+IEbb/3D0nXc0Je0N+ipwjcG+uekqZpepX1LOoATHx5do+IW7TcvLbcHgkaK0O1cKziTuDQRyw==
X-Received: by 2002:a05:6a21:31c7:b0:1af:55e7:633d with SMTP id zb7-20020a056a2131c700b001af55e7633dmr4672289pzb.0.1714764665382;
        Fri, 03 May 2024 12:31:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp9-20020a056a003b8900b006ea8cc9250bsm3420413pfb.44.2024.05.03.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:31:04 -0700 (PDT)
Date: Fri, 3 May 2024 12:31:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <202405031229.9856D89B7A@keescook>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>

On Fri, May 03, 2024 at 03:44:09PM +0200, Thomas Weiﬂschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
                        ^^^^^^^

Was this supposed to be "prototype"? I couldn't quite figure out what
was meant there; the sentence reads fine to me without the word there at
all. :)

> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Cc: stable@vger.kernel.org
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> This was split out of my sysctl-const-handler series [0].
> 
> As that series will take some more time, submit the patch on its own,
> as it is a generic bugfix that is valuable on its own.
> And I can get it out of my books.
> 
> Changelog in contrast to the patch in the series:
> * Reword commit message to remove strong relation to the constification
> * Cc stable
> 
> [0] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/
> 
> Cc: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/stackleak.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 34c9d81eea94..b292e5ca0b7d 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *table, int write,
>  	int ret = 0;
>  	int state = !static_branch_unlikely(&stack_erasing_bypass);
>  	int prev_state = state;
> +	struct ctl_table tmp = *table;
>  
> -	table->data = &state;
> -	table->maxlen = sizeof(int);
> -	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	tmp.data = &state;
> +	tmp.maxlen = sizeof(int);
> +	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);

In looking at this yet again, I can't figure out why maxlen is being
set. It starts its life as sizeof(int):

static struct ctl_table stackleak_sysctls[] = {
        {
                .procname       = "stack_erasing",
                .data           = NULL,
                .maxlen         = sizeof(int),

-Kees

>  	state = !!state;
>  	if (ret || !write || state == prev_state)
>  		return ret;
> 
> ---
> base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
> change-id: 20240503-sysctl-const-stackleak-af3e67bc65b0
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 
Kees Cook


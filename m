Return-Path: <stable+bounces-40406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C098AD6B6
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F3B1F22768
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABCD1CD2C;
	Mon, 22 Apr 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqz6wLAS"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA161CD0C
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821982; cv=none; b=rBLN/Ls2oXenYkI7OHZM/csTImiIu0b9cPy8FLNxs6FqEJ1ZpxdcOrVwAO4fHGtOQ0TJMsha96XkpEFkt9TGK+sIkjWgS26PZLLLU87jyKbXxB46Pxc/OaFiuyiuCjTpkstIAjLqShHopZS3XtT8uYOkpDlutKf5PeVARTa5GUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821982; c=relaxed/simple;
	bh=66aXJAodZhmTK5ING/dIffFtFy1STros7jqfpnfisqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UokEjcOVoHRWrB3+mg7vPTfkvDBV6KDKXVLkTqXEyLIcw5Nlk4Vxbbvhy0fRhTkIkVBttRpbYUdIDTmVjw6uuexF97X2Be6VwRsW6KOh6XXEmrZvnfxsYKUKnOvysolc6RCEomg2GMmLfuRQsyEpHz206kRezamjDPqBBDzLBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqz6wLAS; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b2fcff072so18185115ab.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713821980; x=1714426780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEYoYZ4ojQsxz1tZuFjfEBTZaCuwMjE7Y0TzNKxEghA=;
        b=jqz6wLASQ2wvafirmszCPYiWL+NAG77FOGk8YAydJHokOotHMwLo9dAocUoWcykl/p
         /6FcdpKow5YuxZ+o7JPsw9Q+qh7XU7o9GGZ2gzoyTjSNeOBFU8iI673YXnIdmg5GSU5K
         at9yU5IUwPhPTK2ApI/Z/Cmsm3upkXXDWdEggxGWpU6NmlW2NUneXKqcaSgSU9apIO4f
         iwB0wsz7qm1FnIMQGW11aaGluuAMoLoxKzz8AaYqZykHs/n84ItKe0VFWAznZea6yF4X
         g47HRHhc+B7i3decS0d6xb7ZPBwSh6XQXc9E+rvHV0AZ3GJsYMrHeL/lf32rkZWkSyW9
         jFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821980; x=1714426780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEYoYZ4ojQsxz1tZuFjfEBTZaCuwMjE7Y0TzNKxEghA=;
        b=uQHlV3gVIM/te4yNcaFro39ET86kfF1qXGKrjspa3lIApKI0G6TgbF72BsfmNLe+cI
         oFa2ErXQg02iXYes/90K7Rpk5Y6q2H8BfxIfR/O2geKDZCRxFnEi4MTO/rtVEsdjY83+
         JAbH+IkkYmKw2ZLDjAGO9TK0QkVzdJ9nY2C5A2uf8XEy0z2VOzM9kFEgs4opGRDW1aV9
         t3wgp0BSmImpVgdDkx+9Qx86HxnDEUS3PdwC+gvBdotROj5tTV5SR3fjCKpWkLEP/jjB
         /yuhwI0XDXRyWWneGzK4wmxSfO25V47b5fPMpHUrRH7eo3tDrBVfBBdEFfKn4YvKSo3s
         yXsw==
X-Forwarded-Encrypted: i=1; AJvYcCWVW+1oPaB1lzyESYhKb39WyG47isJx5SQtwHhLGGsBTt9M7E01t1w02y2r2THsFwAiDxtUbGmgB2kiVp1FOKKqu2OWJyQU
X-Gm-Message-State: AOJu0YxW7+CgSGSFj1mCqmLzeZZciwd5D6OM1uQ5uxNDrgQAqePqMe45
	KfBjfKYz+d0sJDaLfuLRjoSBw7yNlLNWsb3K5htsOJqS7VzN9QSCXAYo21jyJx1gbOQX7Nr0nrm
	cHA==
X-Google-Smtp-Source: AGHT+IH4fX/ZDpdX4q2CepXFgoagZzam0TlmHHrE8pLQ1KlDc3g+s75zHppnlpujcosjpbFrowmbCQ==
X-Received: by 2002:a05:6e02:20c8:b0:36a:3f20:8cb with SMTP id 8-20020a056e0220c800b0036a3f2008cbmr16186840ilq.18.1713821979828;
        Mon, 22 Apr 2024 14:39:39 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id e99-20020a02866c000000b004830fd34ce6sm3135897jai.74.2024.04.22.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:39:39 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:39:34 +0000
From: Justin Stitt <justinstitt@google.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Douglas Anderson <dianders@chromium.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
Message-ID: <kyvcojgj2hgkxrv6a56dyfpxarc4cdcsb3kscchytlfx52ggfu@nx64h62xmqv7>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>

Hi,

On Mon, Apr 22, 2024 at 05:35:54PM +0100, Daniel Thompson wrote:
> Currently, when the user attempts symbol completion with the Tab key, kdb
> will use strncpy() to insert the completed symbol into the command buffer.
> Unfortunately it passes the size of the source buffer rather than the
> destination to strncpy() with predictably horrible results. Most obviously
> if the command buffer is already full but cp, the cursor position, is in
> the middle of the buffer, then we will write past the end of the supplied
> buffer.
> 
> Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
> calls plus explicit boundary checks to make sure we have enough space
> before we start moving characters around.
> 
> Reported-by: Justin Stitt <justinstitt@google.com>
> Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Nice! This is better than the conversions I tried to make earlier.

Your patch helps with https://github.com/KSPP/linux/issues/90

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9443bc63c5a24..06dfbccb10336 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -367,14 +367,19 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  			kdb_printf(kdb_prompt_str);
>  			kdb_printf("%s", buffer);
>  		} else if (tab != 2 && count > 0) {
> -			len_tmp = strlen(p_tmp);
> -			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
> -			len_tmp = strlen(p_tmp);
> -			strncpy(cp, p_tmp+len, len_tmp-len + 1);
> -			len = len_tmp - len;
> -			kdb_printf("%s", cp);
> -			cp += len;
> -			lastchar += len;
> +			/* How many new characters do we want from tmpbuffer? */
> +			len_tmp = strlen(p_tmp) - len;
> +			if (lastchar + len_tmp >= bufend)
> +				len_tmp = bufend - lastchar;
> +
> +			if (len_tmp) {
> +				/* + 1 ensures the '\0' is memmove'd */
> +				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
> +				memcpy(cp, p_tmp+len, len_tmp);
> +				kdb_printf("%s", cp);
> +				cp += len_tmp;
> +				lastchar += len_tmp;
> +			}
>  		}
>  		kdb_nextline = 1; /* reset output line number */
>  		break;
> 
> -- 
> 2.43.0
> 
>

Thanks
Justin


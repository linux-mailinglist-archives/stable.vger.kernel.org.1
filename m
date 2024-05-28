Return-Path: <stable+bounces-47582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718408D238B
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135371F243D9
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64616F916;
	Tue, 28 May 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz6SQeQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571739FFB;
	Tue, 28 May 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922592; cv=none; b=LECSZsX8iKJ9hK6zCkqPy6K4geaVBiZl87txitEOl+XuKFw2mKLjVmsQrkohWlc6IFLm9igqWN1cKjeY6rOSljzzHUp/wOeF4pOvGQBKPSx7417Sr48t4lSNw9shwlcRfGEgRg2JbFpoI+gPvXTySX9qGJj72GJbuKHuqu1/J5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922592; c=relaxed/simple;
	bh=ztsJYW0YANpO2rdc8sbJ0K+4goWiO1i3wXZ1mB0Ap2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmjJ0iHM5Zq3gx1WVPdmhNOVqEGSppB7jtzCCMYfZd9ZWKVXCn4an4iyOvFXA2if1Iyt1lWDS4YsUtvqaG0pdJkvjcfuUb2mF2+jFQpMmhiPBq6YoBc5ktNr4Dxv5dBRGFAwhN/WCSzevPikfI87qh4j7hgjkgt7n9Fs4NEuDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz6SQeQW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d0dso10275775ad.1;
        Tue, 28 May 2024 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716922590; x=1717527390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUgLDFbi2c7FUxokPLXP9/62M0uPAEAEC9MusVwz8b0=;
        b=Tz6SQeQWI85YRNTKI0Qk3Hwr5f7NfVEgPZfm3zbvTgGTDEYxET2MwFKcU22HaCOMuv
         XDGZLlh/98X3ho+4lYFLz8PUw0qZaio7K79AChq6EE5BMCEh3D4c4tioGTcAxAjHb2tW
         jTnB+lCVpZ4LUt+QpRDJmO9tg65XuES1n5IbDSPqnZoJi/xKVaisvlAIb2EdWZDMTLkc
         cbWOnnnl4/Pnhwj4Oen401FXD0xa+YIXyhDoXdRnCsgZXcSw7JIBnmVXQuGB/QEIUn2j
         uXVyl8XPXsROrG05fAQpeKI3cgES+DzD9XLqxDKXD/X8PAz2Tvb40Y19AD+JK8UkWxvx
         pC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922590; x=1717527390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUgLDFbi2c7FUxokPLXP9/62M0uPAEAEC9MusVwz8b0=;
        b=E/Eo4S1Xandwxfph2jbYNs2LKSF3p+WWwB2Gywe80k6yimCqdR+Z1GOB/4dL4qBbSz
         YvWXdOG3rdRBVxLmW3yPp1a1UYo2xqkXh45S9X882eaPxFbE3tljxqB/4W9QflHH8nkK
         XqnBbp0/zZuuAFVX6XB6wYJYYq8xWH0NI3Exr6gGke6tp/DNSCzokz71lPhbMf0PgvTj
         4wLav/rmHf9XH4Klz+348Muh2mDnj3S9FumtXKTAZXcm+YgCmBI59c7RYcEwkQzoqIuA
         2POMtNmPydnQD9S4wmharygrOBnPrG6RPLtNJ/x4P65jLgKX9YCbKJ2a5QgXWeQtdqd1
         TRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhnR0dV7QDcqfxwPzpoqW3l5eMuG6PxIuNELp0xm8yY+SuZRXjfRjke+hfOAmmnwXVDoJ+Jfk4yiRly6BXJO52axy4yYm8CqbSFf6JLEwQFfzI/hhhca8/3pBq18DWp9s9xNgu
X-Gm-Message-State: AOJu0Yy282CcpA+dpH5fLlPt9lmmnIKGmIEdCoYzHxuzsLNwcy2YZz2R
	x5WHQmzthsbApEU4HiXfvLkyTyvUny41rpq6uesD4OZQ/Hb6E/Jt
X-Google-Smtp-Source: AGHT+IEGKMC+GSGE9A5CoOBmwz7+P3FCmjILiQSV42ML2DmZSVRFq0YniZtWUgz4cIjIBsy/BkySQg==
X-Received: by 2002:a17:902:e5ca:b0:1f4:95cd:6757 with SMTP id d9443c01a7336-1f495cd6cd5mr78359915ad.54.1716922590026;
        Tue, 28 May 2024 11:56:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1181:b338:a9d5:263e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca6d1sm44742135ad.139.2024.05.28.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:56:29 -0700 (PDT)
Date: Tue, 28 May 2024 11:56:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kobject_uevent: Fix OOB access within
 zap_modalias_env()
Message-ID: <ZlYo20ztfLWPyy5d@google.com>
References: <1716866347-11229-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716866347-11229-1-git-send-email-quic_zijuhu@quicinc.com>

On Tue, May 28, 2024 at 11:19:07AM +0800, Zijun Hu wrote:
> zap_modalias_env() wrongly calculates size of memory block to move, so
> will cause OOB memory access issue if variable MODALIAS is not the last
> one within its @env parameter, fixed by correcting size to memmove.
> 
> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> V1 -> V2: Correct commit messages and add inline comments
> 
> V1 discussion link:
> https://lore.kernel.org/lkml/0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com/T/#m8d80165294640dbac72f5c48d14b7ca4f097b5c7
> 
>  lib/kobject_uevent.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 03b427e2707e..f22366be020c 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -433,8 +433,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>  		len = strlen(env->envp[i]) + 1;
>  
>  		if (i != env->envp_idx - 1) {
> +			/* @env->envp[] contains pointers to @env->buf[]
> +			 * with @env->buflen elements, and we want to
> +			 * remove variable MODALIAS pointed by
> +			 * @env->envp[i] with length @len as shown below:
> +			 *
> +			 * 0          @env->buf[]      @env->buflen
> +			 * ----------------------------------------
> +			 *      ^              ^                  ^
> +			 *      |->   @len   <-|   target block   |
> +			 * @env->envp[i]  @env->envp[i+1]
> +			 *
> +			 * so the "target block" indicated above is moved
> +			 * backward by @len, and its right size is
> +			 * (@env->buf + @env->buflen - @env->envp[i + 1]).
> +			 */
>  			memmove(env->envp[i], env->envp[i + 1],
> -				env->buflen - len);
> +				env->buf + env->buflen - env->envp[i + 1]);

Thank you for noticing this, it is indeed a bug.

I wonder if this would not be expressed better as:

			tail_len = env->buflen - (env->envp[i + 1] - env->envp[0]);
			memmove(env->envp[i], env->envp[i + 1], tail_len);

and we would not need the large comment.

Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>  
>  			for (j = i; j < env->envp_idx - 1; j++)
>  				env->envp[j] = env->envp[j + 1] - len;
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry


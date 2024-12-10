Return-Path: <stable+bounces-100492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EC9EBE09
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E0188793E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7881F1923;
	Tue, 10 Dec 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jNh7joti"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F72451F1
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870857; cv=none; b=eNQVyL34r4zhW63Moodr2UBIC/XAna+iBZcmLpT9DQFpULHtt2b6DS/EcxhA0+epnzMatddjlcZ0RGO7CWExLmat08pN9Bqq/76MDeJYda1tdA/vnYcUE46ZTtN8zRB6pDhA8Y5HXasYbHANYoHe0MIxJ4vX3fT402gx9Wuw09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870857; c=relaxed/simple;
	bh=4J09Nw/NprO0mzMLrBQrv1UzfclOZD/Gt04pVU1Y7CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLLUAwAf+S2OJLCGCmhj/2mdWq/t0vbmCEX4F+GhsixTFWdKJORErC2/eEc99vqKoGDspljb0B+Sg+d2UuqJSsH+DxgQiFGvImPmwAbqfCq9Quny7Hk9jfXUWUfjuHUQpNL8yS/lf4NlsBHZWxgsApHP6Yy2+KCUKkn9RE4NqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=jNh7joti; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef81222be7so56898347b3.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 14:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733870854; x=1734475654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWBkyRYQGMDGc5eLQDuZCpsdffQM6naQ0vYyr7n61vs=;
        b=jNh7joti2mNXbonLdEDqzPGMd7U6/LzNQTPj90bamPyKjfB16hnNax1kMLGyuvmkjy
         /g8PwnTGt1V3g1vCwSsAfqJJIRGseiE7upazEHZUphde6jBRYJ3wGfEZuYSQNmUQqrUB
         clsr9xXmy7PVE8mkpRlu3IY8znxDmJNwVSdOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870854; x=1734475654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWBkyRYQGMDGc5eLQDuZCpsdffQM6naQ0vYyr7n61vs=;
        b=dTDfAP/HfCJ9lrrM4FdsFNjSjdem4PK2EQyR+mGERY0k+GmZzZhu3tk3JJDzwl35IK
         NS4y8/cJq3+stO09+mQUHa5P15rSXDfPBl419v9uAQ/ev562ZmXXG0EFPm6+AHzKx+nJ
         aPd2r726zrrzZe6/6eLuzrrdaIUVRiWDRdD0/kvbDxLYxL/9EDZKmrNxvnquWkdfQY9L
         0u/NS6hK561m3y9V5WfFdQifov+pu50tXQmcDLy4caYCupv3OEdKJTg6WwSH+RHwYMka
         qtj34XpFdDAQ8g7fKlGJltrfwvi71Q7+aaKEobjjzo9kEh56YxceowoRFt/oCngBHb91
         RgKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnUkvHpLaoLpC+jrcuOhQ0fLiMUmBaoSiF7olZJmksSD+rc1wvGvU7Z9BtsBpqy6KrxQ0fOmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTUqxkaKkMt+m793nnpKZ1UshIQM58A7MRbnUiiQvLqvXFJHB
	A1giKMCPBfrPy7BpLhxL4V1jN+qXyHuFs5hiyt3NuMcvtUXk9GXdV/9f9Y+1Vr+pbG1FgeA15V9
	YllRzzLjN0M2tpNN3ER6fEIhaRV/OpMbzpZZLbA==
X-Gm-Gg: ASbGncvUaSQN9OXQ28pP5XN3TrCCIKTTjifXoBvGpYjyhDnevZ0QZDMu7gQchZWk7dX
	kkxCiBMb/mevv5U/Qj/6eawBA6umJD5+Q5y6R
X-Google-Smtp-Source: AGHT+IELsZuOhax2WDfAjwRl4rtBxQdB85wP9bCDDJ4eUK3hc/wYzDqJhKW371nUrhtu9bZHAkwmulfL19gZbIScI2s=
X-Received: by 2002:a05:6902:2b85:b0:e39:83ce:6fb3 with SMTP id
 3f1490d57ef6-e3c8e4252ffmr1233132276.9.1733870854603; Tue, 10 Dec 2024
 14:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com> <20241204-udmabuf-fixes-v2-2-23887289de1c@google.com>
In-Reply-To: <20241204-udmabuf-fixes-v2-2-23887289de1c@google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Dec 2024 17:47:23 -0500
Message-ID: <CAEXW_YSd5yv4n4UMDfzKNgVZ_TWikuS_6HHOs0suYwUiVqNnJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] udmabuf: also check for F_SEAL_FUTURE_WRITE
To: Jann Horn <jannh@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> When F_SEAL_FUTURE_WRITE was introduced, it was overlooked that udmabuf
> must reject memfds with this flag, just like ones with F_SEAL_WRITE.
> Fix it by adding F_SEAL_FUTURE_WRITE to SEALS_DENIED.
>
> Fixes: ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd"=
)
> Cc: stable@vger.kernel.org
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Thanks!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel



> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/dma-buf/udmabuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index c1d8c2766d6d36fc5fe1b3d73057f6e01ec6678f..b330b99fcc7619a05bb7dc2ae=
eb9c82faf9a387b 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -297,7 +297,7 @@ static const struct dma_buf_ops udmabuf_ops =3D {
>  };
>
>  #define SEALS_WANTED (F_SEAL_SHRINK)
> -#define SEALS_DENIED (F_SEAL_WRITE)
> +#define SEALS_DENIED (F_SEAL_WRITE|F_SEAL_FUTURE_WRITE)
>
>  static int check_memfd_seals(struct file *memfd)
>  {
>
> --
> 2.47.0.338.g60cca15819-goog
>


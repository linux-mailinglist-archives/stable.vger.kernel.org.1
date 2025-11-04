Return-Path: <stable+bounces-192337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC8C2F734
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 07:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789EB3AB024
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03E35962;
	Tue,  4 Nov 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UJ/02os6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C12AE70
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238103; cv=none; b=F+EsrI5o5e7XEKMwY27Pb1AF55IirsUzyy5vwjzsYOLzy/YxbPWXxlELTFIPBrft/5wodI5X0hWTGPBt+A5kI6YJjM7srBcgrXOKvP5pHo09+yqa7Tz56+qDPfBTg4YA5R+AWOuKfQREGs8HptrQ7s8UwyUXboVz0o12DLYH+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238103; c=relaxed/simple;
	bh=s7tSXwvHJ4PEs4y4Dec7uGqloATEs+Wo8gpI0FbMsVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPLhMCgy529Dt9WX9tBrH5R5N8mDCd95t5CWHv3wPbM0sqDb8o0BQD7wJ/RQBy4oNsXjZ0F2Pun4Yhscd4xoVmfrjusrsyS18Jeg9T+KyZX+yTyy4VlFgnJp8y5nZ30wJKUuFh6WrnCJ+bB+gLhSnSDzzaPOHTyHUk77x4zD/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UJ/02os6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64075080480so903993a12.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1762238100; x=1762842900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=UJ/02os6zo6tb9bDRTkqMwIS61zY1zWPRNHYWyZ4XtROs4qz91MoYxWQbv1F5e/2Ok
         gcpesx6W+xbR109qRf2mcHQMBpsCfDiL7EQygq7QMT5LtgrvDBrlvYApNOs7jOEI45WI
         TncHRFiMX42iv4wAWs2YCLslQXwyDMJXDK+88PPiVmpmiyjGu0tSd8YNVvwVZ9/GbEqp
         SZ2c1TcRVA64P+5gj6M0dKRk/iEXVkQQsqpaNgCSeGtyqWbKbnYj/z/3VsBptc3UK7jN
         rrHxyqUJzDNhK16dWbby2NtTZQ3H1QoB3glxxyobzlAxDsm2xFi53X3dIitP3gN3v96u
         2LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238100; x=1762842900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=Bx/pRrWc6Seohpfdzx77xroGR+7RNpV40XDK7LmPrwbBnrE/FbPeR+etPaK6yNecXH
         MFUNsWoygnHcJxosSoVCxj4i8qtD6EHqEed8pGaAI0Cmh1+2wHAXCht1kLQyS+rjnQQ0
         KvKMHFQHiiO4ZtJ25CPslssC/oQZhj1zOmrTRF0X/YUuHqw0aoSBGBwQ/bNkORZIJo6u
         rZGV5QlTvFvuzCYD6zJPh5sDL8+xBKiKeKp2ATH+6qiCPHWpINcnCgY65y7MzVSBDRLb
         m+DUHlsRCeIgIdlhHCuRVRP78tcmAWYorY5RGrK99YYRnlaMgBfLC79vVVyd5Xpe0ipz
         cXdA==
X-Forwarded-Encrypted: i=1; AJvYcCWx48LhJvf1+EBn2v8vGe5n4/+M7z1DkLdtIHttGUnBVeEm/+vOJsUb0BQ2/TLuFItmovY+lzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxi+SbXgnoetUmf5Ze2S58tlYJ7zkNRlZHAxOWJwkEPhHDQ14
	desz74ygt0iG7E8ZdiTeJoDAybiTvkoDuQn+vehIaJRBu2Dezjuf0nj5dURZE2nJJ214LyNFrQJ
	1fVLjD0y9urQQHnkyGe2o6143z0KcAtMqapSMsgkkrw==
X-Gm-Gg: ASbGncvPqXdPOH63Jf054XGaaWm44O2laGPflEfFiWPojczycKBwXqEQ1lf+pDyUJfq
	SVX75NWe7K0jfTNLlyL4yKjy6wXfqLRlAe1pdCtkMRsay0A8uX58jKZc1GexncHh2NtkWOloTAZ
	bLJiGYfvmwHN8be9OAmSHmiIBpWWgnKeMcm6/iVNKLEMmadl+QgrOWFUxBNG/qc3mbV5uY8030D
	rn/SH6sAtfma77GG3IU4oeEWRRUSRF8CcjKW/ekHgPrsxRwc5POouipi7+xepix4TT2QTZtvTWP
	Tpuwe0/EOe9O9neXrg==
X-Google-Smtp-Source: AGHT+IFhN63cUrkNgr3auzZxHZID+sIcCpWhSj3aZ/0+3dxL73E0sC1Ila0n0+af/sQcBRu6sYvHwe1uf0SeulBLdKk=
X-Received: by 2002:a05:6402:26c2:b0:640:acc8:eff6 with SMTP id
 4fb4d7f45d1cf-640acc8f300mr4453850a12.0.1762238099728; Mon, 03 Nov 2025
 22:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104021900.11896-1-make24@iscas.ac.cn>
In-Reply-To: <20251104021900.11896-1-make24@iscas.ac.cn>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 4 Nov 2025 07:34:49 +0100
X-Gm-Features: AWmQ_bn1fsvxkVFYJEeS6HPOZ4jil9W2MtbfRXCQLvctJqd1ASYUjnERunBcB1Q
Message-ID: <CAMGffE=0LXyzcg7tew15tV1zgVAaHA2XMHcf5=14k3k0KuzNXQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in get_or_create_srv
To: Ma Ke <make24@iscas.ac.cn>
Cc: haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org, 
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:19=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> get_or_create_srv() fails to call put_device() after
> device_initialize() when memory allocation fails. This could cause
> reference count leaks during error handling, preventing proper device
> cleanup and resulting in memory leaks.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index ef4abdea3c2d..9ecc6343455d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(stru=
ct rtrs_srv_ctx *ctx,
>         kfree(srv->chunks);
>
>  err_free_srv:
> -       kfree(srv);
> +       put_device(&srv->dev);
>         return ERR_PTR(-ENOMEM);
>  }
>
> --
> 2.17.1
>


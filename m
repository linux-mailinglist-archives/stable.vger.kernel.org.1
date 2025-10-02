Return-Path: <stable+bounces-183034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72146BB3CBE
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB41176B80
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276D3093BF;
	Thu,  2 Oct 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCD3fmpj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD32ED866
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405352; cv=none; b=Xq/mR+yfxMjElBh5L56LeygGXuj7X2hxXJcuXPe4x4ErBqSD0rsaxO9GBD4Qa2wXSn+75GRwfZPhddE4vYGTYXxBZN+8q9Oeqh953L93wESER/YPdad6hVWGp5vuOjT27sQxhd1bjHCw1RXSvxoTgFLBRqeW3REcJFpI52d73Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405352; c=relaxed/simple;
	bh=NtUnw3Bb8cfSR6LaDxYQmeLo6xSsSvXSGXLWjxRdkzc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qy8yZ+QqhcaDX5V79bI4utsEmuL0NuTh4evYb6HwA45lcTCz36OrVZpdJ/89ufMkTayNidiSy7LYuZyHbo+ZlJqGhAY16XhdKQ2hq96eMsCm6lBdnLBrdZyV4h4KDWi42sGqy/crATwT8DiToaQqeSC396Q+0XZuHdiF4byRANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCD3fmpj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Ej62FVOQq6zEj2u9bPFI8FOph7VYHFWyQUQShm6AY8=;
	b=PCD3fmpjt7Mg7TwiiEb6jvCVcD+wNQV4GVaiPzvaD3C+iDDpYNhjYmQA/PB8fZTkxPTLZI
	Kizf6OZgW+3EddnrBb9wXbqARHxGpoFnO7qQtOVEWwJxLRpbaix6ZdWWG+tlsVrIVt6UFG
	qQUnZ0KG7EqFiU7luG4DaUgDNnioDNA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-fQib4dNCOeaIEkFPsBFXXg-1; Thu, 02 Oct 2025 07:42:28 -0400
X-MC-Unique: fQib4dNCOeaIEkFPsBFXXg-1
X-Mimecast-MFC-AGG-ID: fQib4dNCOeaIEkFPsBFXXg_1759405347
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so907802f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 04:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405347; x=1760010147;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ej62FVOQq6zEj2u9bPFI8FOph7VYHFWyQUQShm6AY8=;
        b=uFk4Y6GtgySllwv149zoaTRcc7H33nG76TBAiIMwPjUBM16wBDJSlGgurWcE1Od5n0
         umPI8G2d+ZxVUP7PWL8h51+vFvUTUSB1wPyZIzFM6OhWSAh2aedGC6WIAPvxdSmxBNKD
         U/y1XWwYt3emc233uEAnFVBOhjmDMKXwqzjclI3oVFoQ+R83K8cC+LP2TrWrKZ3H7bsM
         6zM8AYYvUyQhMk6FGs0dTWR+jQz1jJ5x4NttE2pV/42e71HlgDqVVeHEouss0hWp0vgB
         YA5gSvcYFvLuWjongtZqRRCJXt9XCYank8CTADARAhB4WNg7xY/uNtBSPbiAT2Cjqckm
         Nwhg==
X-Forwarded-Encrypted: i=1; AJvYcCX2qp1HK2Lt5miLpclU2lEktB4EHDAnZkf2uQt1te4MG3pCK5YmBNORieJshkxAOj7LIJ93xwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoWNatzt3ynu6zR6S+vmvwWhU5aHtfJyf2tnW//qgk+s03biN
	Bc+Gdxq1S3KgsL0X3rwhEFMkH+31cf7DJngpMjYKSauKt0Y+WT6FIlgUXKKtD5vTSVLhtGIyya1
	vdU+BN3YEKQXnIJs2wzJng64c+GSsdQlupU5xqe4uqQJfbiVzi/xmOvrgFw==
X-Gm-Gg: ASbGncvgx8NNLfVbamNzQU/9DIs7rnIQWq9ZPbVDqhCZ7psxuM5Qy8epMJ+KyUZb2rG
	8I2HtCaqJv+YMunJPNk14VL2nZuTH9Vmo+ASz3P+cBLRWQskyB8w9480vSrE7lN3o/Sy/sJ28pU
	wvKD7a5q6QNhtQA07OiaWQcFcp60jlLFBIXrrYgxtSiqDZop5uyYALUWW+0IHRffP/5bfwpyPUw
	DUCfWuZLK+4oP56oVfwBSDXFCm7xLwsBg2Si7ztGqCZMnu0Sb5aVEIJw7F2xCsWCJwfbPVm5Azd
	CkqeyInQne1sDN0tdpg+PUmtRXhE6rcx4NbuTGEvRUAIM5rUPHJ97EnNxHqi6QbvV3iVNKQ=
X-Received: by 2002:a05:6000:1887:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4255d2b3268mr1947646f8f.19.1759405347090;
        Thu, 02 Oct 2025 04:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQBsRd3QbWjCawGUT/34IGA9DqiAFCCG8hAG/sJP5Zufv3lc6VVpYan82fkDtRhahnnjowCw==
X-Received: by 2002:a05:6000:1887:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4255d2b3268mr1947631f8f.19.1759405346651;
        Thu, 02 Oct 2025 04:42:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm3335434f8f.51.2025.10.02.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:42:26 -0700 (PDT)
Message-ID: <77c1e6213e1c250ad8bf57849d8c90dfd2f105d1.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fully convert enabled_monitors to use list_head
 as iterator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	stable@vger.kernel.org
Date: Thu, 02 Oct 2025 13:42:24 +0200
In-Reply-To: <20251002082235.973099-1-namcao@linutronix.de>
References: <20251002082235.973099-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Thu, 2025-10-02 at 08:22 +0000, Nam Cao wrote:
> The callbacks in enabled_monitors_seq_ops are inconsistent. Some treat th=
e
> iterator as struct rv_monitor *, while others treat the iterator as struc=
t
> list_head *.
>=20
> This causes a wrong type cast and crashes the system as reported by Natha=
n.
>=20
> Convert everything to use struct list_head * as iterator. This also makes
> enabled_monitors consistent with available_monitors.
>=20

Looks good to me and passes my tests.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> Fixes: de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()"=
)
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes:
> https://lore.kernel.org/linux-trace-kernel/20250923002004.GA2836051@ax162=
/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org>
> ---
> =C2=A0kernel/trace/rv/rv.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 48338520376f..43e9ea473cda 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> =C2=A0		if (mon->enabled)
> -			return mon;
> +			return &mon->list;
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> @@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -	struct rv_monitor *mon;
> +	struct list_head *head;
> =C2=A0	loff_t l;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> @@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file=
 *m,
> loff_t *pos)
> =C2=A0	if (list_empty(&rv_monitors_list))
> =C2=A0		return NULL;
> =C2=A0
> -	mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
> +	head =3D &rv_monitors_list;
> =C2=A0
> =C2=A0	for (l =3D 0; l <=3D *pos; ) {
> -		mon =3D enabled_monitors_next(m, mon, &l);
> -		if (!mon)
> +		head =3D enabled_monitors_next(m, head, &l);
> +		if (!head)
> =C2=A0			break;
> =C2=A0	}
> =C2=A0
> -	return mon;
> +	return head;
> =C2=A0}
> =C2=A0
> =C2=A0/*



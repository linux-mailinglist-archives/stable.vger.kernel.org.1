Return-Path: <stable+bounces-200851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC04CB7DEC
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F3323026AED
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 04:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82352FB61C;
	Fri, 12 Dec 2025 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVDQ2cDX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17680274B40
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514201; cv=none; b=ZtB54Mo/ImttZXjFWEEPT0Aw2nUxvOUZpdHMhg2zl1B9geuM5ysvFjniYmR8SSJBLPEBajb+uuek761PjslxkgTBZL8kZMELmO1wTK/OLtx/E5T/TaR0OIWN3bhsYI+ftA8ZDetGAM8b5lO7aAkiRBGIdYBN2fuzPfJ+aX1BTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514201; c=relaxed/simple;
	bh=izvC/VTG5SdRufO3rbQ2eu6UnJHz/zUHVfUxXCNHN20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH16IIKNT7wsMQhfPNvVv4bcP4gbYk74Jtp3TClCFpu8uTT8446BhOFTnWdvYFVSMvqqqYG9UPsPUXxyJ6bEyuhIultq409gaE1PEm3uVKzWBtVDt2oXWt1Q+hyMwItSVXO6Y7UY68QA61JeG0QHTBH1dIgMkJgNJ7EU5ID5fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVDQ2cDX; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1035158c88.1
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 20:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765514199; x=1766118999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s50kvV7cRV3FVuazE9IrYPdEtv6Y/mgFFfoCIbS5VTQ=;
        b=OVDQ2cDXuLx7VPGYqKo2s/cbqDSqpYTMSwJ8s/SpkukRIrUBI/s8IDzrau0vknFA+G
         iGbb82aiUYzdHf/HOW+1ZN4j9GfafVxTBcumow/oepWtfxmHeiX9Mi7MOOHd5qvL1YTK
         7lz6s/UTJ/rwAXpFHXb5ICvAQa+JjXmUTdHh/fxyKDD1j4vXB34zjzJyZkcudPPeDhg3
         eWW39fvs5SQqtvQdVa/0cdjVJQnwxG9XbwtL2UPv+iHphxXjApfwxqCvVZVJfiOqZoJD
         emK2KP9p/dZ9FAKhAVtGl+tziKcK4I5ZOkv127lo8rAofw8taZD7AejIdi9lPKTiJfBJ
         BIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765514199; x=1766118999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s50kvV7cRV3FVuazE9IrYPdEtv6Y/mgFFfoCIbS5VTQ=;
        b=iLG87QKiqUc3pfQPZ4wtIISLxEAYA6ougYkiWGhpwbZ2Dy6O5MGFwDGyqoc4ARHKok
         57bvNEEklCZr/lSYpwTZQ/5E3XqYPiuI7y5jZJS4haa8H0unrf5WlGunZHRuwcFUr6Tr
         lpBQnNi90R77g6jwduHLnldq0PQvr70HogjdVyRD2GFpjWG4Kshc1YVrbxIeo9f9z8nn
         cNnd1tu40GSM35RcgYbtFbyFLBCGLPe0B0sUQEywcfdRmyeFDNoCpcJuCEG7+QTirsbU
         r9XirCl1d5f9gb+4eJu5fc/Fmk7Et30xaH7f4FEt2JSCRfgmKrteUQkn7Qyb9g3HhARk
         k32g==
X-Forwarded-Encrypted: i=1; AJvYcCVIo3tSCfd5Z5Ya5XAYTfBmZC/cCb2uqQArtK8uximjKxN4GTq+KrD5z/3z9RAJg7jBJ2TTLf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOiZC3mmE4oChXNzNPh0LuNtmf73Q01R6rLKQEP9kf25cPsMm
	X++YbwMvT5qwJWzxiI9bgpVzozK/HIYUSuue3Tsi/tO45Vl4qwhwuHTSqw1TU3X+
X-Gm-Gg: AY/fxX6lnkoe0/mL7nfga2v5Z9te3+Y0EZQhztu1y/PubZSeKH11KIUqZjt7Hm5834U
	UrK4m3EgSEoSA+LXwv/MQ26EwUomlEJj8gDaoSc+rk9JlfwytT2WkSgaX7KbSoCqXGB0UcYIKJI
	fJ/VA3Gt1bJ88nsQdbj1hRWcnHiICZBCFHC7uto0nRD0pG0Xrgohk4b38ODSO+q4kwAXzJE8j7h
	42zsa++GsV61ozSbC6D9q5TqXbm+Y7NkMW6QtNS0e4ZQcy+x323ryJUdMvyGUwhmLG/xEOwKVot
	CTNT+Ju7QruV/VD1JcrvyAGTXr7/BTURc+F3jkXVg7/kDmaD0O7MChKIxwcsyaC3sXZqmuGgSnK
	rFJTFYRcPvEhPkZHIAF0864d08vDojX7hvV3EkHlNj/h6OAQtTWHY5dyjqUsbb/OuugzkbjdDRh
	BhS2YqR0U8G1mPS5cwgjF/it1KEayF31kAVG/chyI6TdSJDfMUP2Y=
X-Google-Smtp-Source: AGHT+IF2xrXTlmdxAYv++ETrOonH3/AQfDDcb9WmTvM1rKqUqIo4CwgeJp/PTyBASgfy/LaNMOPfPQ==
X-Received: by 2002:a05:7022:201:b0:119:e569:f85b with SMTP id a92af1059eb24-11f2ededce9mr3774417c88.18.1765514198735;
        Thu, 11 Dec 2025 20:36:38 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:fafd:f9bf:2a4:2a0b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30491dsm14246263c88.16.2025.12.11.20.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:36:38 -0800 (PST)
Date: Thu, 11 Dec 2025 20:36:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] input: lkkbd: cancel pending work before freeing device
Message-ID: <bycvmdyibmuw6dzmjmdonof4fqli6xv2igqnwpw7pxq5uqfvis@oon4iri3wjro>
References: <20251211031131.27141-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211031131.27141-1-ii4gsp@gmail.com>

Hi Minseong,

On Thu, Dec 11, 2025 at 12:11:31PM +0900, Minseong Kim wrote:
> lkkbd_interrupt() schedules lk->tq with schedule_work(), and the work
> handler lkkbd_reinit() dereferences the lkkbd structure and its
> serio/input_dev fields.
> 
> lkkbd_disconnect() frees the lkkbd structure without cancelling this
> work, so the work can run after the structure has been freed, leading
> to a potential use-after-free.
> 
> Cancel the pending work in lkkbd_disconnect() before unregistering and
> freeing the device, following the same pattern as sunkbd.

Thank you for spotting this.

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Minseong Kim <ii4gsp@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---
>  drivers/input/keyboard/lkkbd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
> index c035216dd27c..72c477aab1fc 100644
> --- a/drivers/input/keyboard/lkkbd.c
> +++ b/drivers/input/keyboard/lkkbd.c
> @@ -684,6 +684,8 @@ static void lkkbd_disconnect(struct serio *serio)
>  {
>  	struct lkkbd *lk = serio_get_drvdata(serio);
>  
> +	cancel_work_sync(&lk->tq);


We should use disable_work_sync() here because even if we cancel the
work there is a chance it will be queued again (up until the moment
serio_close() returns).

We also need to call disable_work_sync() in lkkbd_connect() in error
paths once serio_open() has been called.

Thanks.

-- 
Dmitry


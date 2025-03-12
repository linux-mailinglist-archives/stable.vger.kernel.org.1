Return-Path: <stable+bounces-124149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA669A5DC2E
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF1166E78
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3087241666;
	Wed, 12 Mar 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcMBCRlo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90314F117
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781074; cv=none; b=KmAek/dJKnitT5ZNO0RqWdPNprEJOVOxJUS2qG8FRzsFfrIP2hHFad416+YYekwiyUHq51PvT64XMCMCV4L9TB3ew3wC/GBmOpkiB44D06dVK5sUeHFIe2OeYp3/Eki2KRbzyqaxf7uRWTrF1J4Ixiy7VqW35ks5DdxZxkwVb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781074; c=relaxed/simple;
	bh=Z4VWSFYXqkfFvedGTggt9WB/i9yUJ9W2UOObqTVmX18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyqBPmy3+62faP27FfuBOVA+YJf+5NL44U+0aBk4vhr7XsDXYqUk5+RhdLxdZZuP/GNgwoBy0/3rKciPmLJjS5xoHdP9ciRqKl3so7MeawnHIEZICQHPTrOnV4cz4feOABFNOZ0xYW4yB4/aCmd8q3HzPLY5hMGihifsJC7Dxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcMBCRlo; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bc66e26179so2764570fac.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781072; x=1742385872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1NsLoWL4c/6afSlKeAF4VzN3dvO9GP2QodQUbiJAV4=;
        b=TcMBCRlolf681G+0GtLCsgfDGTWjl8+5+jYzHe3UA1aGHEoWq4zEM6oP0jE2Wcdddq
         3cn5MS0Iz/fCUqKwSeacPqD/AC1yQoUPkTBWdN8vhDcIpwbbTUEqPhDXnBt3NemdAhDR
         Ep3DZoQZFPeEpajrN6zndVROuRUrdsk6kTrH+58zrbYxHYRtSHQvMfnULfX/PNF1XXsh
         98jdjcR52DNTDMfwGiZtJ4uknOILsot+KjXIIW1+hCGND2O4zI/kRs4UzZg3At+QWqMV
         4hGv4ZCay7pRdjwppw4W0zYXiWJI6k9PCdlHk2qSY/OhjhKSSwgVdlzHC4nfLNPX7+d8
         vjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781072; x=1742385872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1NsLoWL4c/6afSlKeAF4VzN3dvO9GP2QodQUbiJAV4=;
        b=YRv87FQMXW4oQZL1pQTbmxTy1Oq8Vg9kx6ezSpcNc8OJnmJ/8EnYAtDx4U7XB7Svl/
         dbfOdRkM5vZoT1Vi0oZm/ipDL450t7jlkWxNDrAVIns5Ww8pw/+53pvY9mtwbbGj5B/9
         dC9r2zmQ/mwoqab85HIJz24dGCciGEdeVQVhzjjMdQUgUnqwyz02E6i1caqTp6AO5NH2
         HSLcYVqbEeGEaKDCkPQ281mlcUpYsM6SW8MO0Icn8d0flsnfHISXmx9Lb1/F54h3tUFD
         XJrl9DzUYQt8N3eMEBDHVHQtpQ0r9ZvZ16Smd8AGGt7sBgHfUDIDSN3AixEKoYLdfn+N
         dOhg==
X-Forwarded-Encrypted: i=1; AJvYcCUFJHn0LryXYJ/5XqYZUBOwVKc02EGf4Z+rlgo0riT8XCdIJyyy31fQWI+QuL0ULDeKhCWog2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0jkD4SlGEd3e4if7g0VAZZMArBtJxcGp+GmO1zIZK65vNgGR
	CfjQmG92lSkFwik9uIGRi4fBnmJyfRjmF7ZapBATPXuIhEJv+LE9/69G0CIoXeThXnbdAa/hCkK
	epymb82isLinqvXZ5SWHkSCu4kZM=
X-Gm-Gg: ASbGncuQJYrjElkNUs7QZT3Agoi1aLjUPQ3oajah7/l1WgHqSkwiLyJE9Rbq9cZY2M/
	xd5OAdDilI9SXFr+TDdaZG/FAQ12qOn5uVfZ/bTG73Zuw85+03EQAfQ14P2NMopMNDCKK0OYCr2
	0APNJhZ5TpoQF4Y1oaHwf+fQmW
X-Google-Smtp-Source: AGHT+IEkDOwCBhDPp+6gJ95iYeluJh5LwTnSUDRFvyA0v1nSDf4hd+j0OiX36tXrXRtCEbk8IRVfO0jXXpzfOEt34eM=
X-Received: by 2002:a05:6808:318d:b0:3fb:33d4:49ed with SMTP id
 5614622812f47-3fb33d44c58mr2209329b6e.5.1741781071872; Wed, 12 Mar 2025
 05:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303145604.62962-1-tzimmermann@suse.de> <20250303145604.62962-2-tzimmermann@suse.de>
In-Reply-To: <20250303145604.62962-2-tzimmermann@suse.de>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 12 Mar 2025 13:04:21 +0100
X-Gm-Features: AQ5f1Jpkvimp2Qj2ZfVOgzFZyHt2fpIyZljbGE8li0CoNJCI_dwqBlocIsYQp3s
Message-ID: <CAMeQTsZnhdwLQRrNEeJiMXEZ+LZFUoSu_Kph13FeUG49aoWbBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/udl: Unregister device before cleaning up on disconnect
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, simona@ffwll.ch, jfalempe@redhat.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	sean@poorly.run, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:09=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Disconnecting a DisplayLink device results in the following kernel
> error messages
>
> [   93.041748] [drm:udl_urb_completion [udl]] *ERROR* udl_urb_completion =
- nonzero write bulk status received: -115
> [   93.055299] [drm:udl_submit_urb [udl]] *ERROR* usb_submit_urb error ff=
fffffe
> [   93.065363] [drm:udl_urb_completion [udl]] *ERROR* udl_urb_completion =
- nonzero write bulk status received: -115
> [   93.078207] [drm:udl_submit_urb [udl]] *ERROR* usb_submit_urb error ff=
fffffe
>
> coming from KMS poll helpers. Shutting down poll helpers runs them
> one final time when the USB device is already gone.
>
> Run drm_dev_unplug() first in udl's USB disconnect handler. Udl's
> polling code already handles disconnects gracefully if the device has
> been marked as unplugged.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b1a981bd5576 ("drm/udl: drop drm_driver.release hook")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.8+

Hi Thomas,
Looks good.

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/udl/udl_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.=
c
> index 05b3a152cc33..7e7d704be0c0 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c
> @@ -127,9 +127,9 @@ static void udl_usb_disconnect(struct usb_interface *=
interface)
>  {
>         struct drm_device *dev =3D usb_get_intfdata(interface);
>
> +       drm_dev_unplug(dev);
>         drm_kms_helper_poll_fini(dev);
>         udl_drop_usb(dev);
> -       drm_dev_unplug(dev);
>  }
>
>  /*
> --
> 2.48.1
>


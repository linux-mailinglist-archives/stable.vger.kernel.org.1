Return-Path: <stable+bounces-208180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA1D14336
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91593045DDC
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301C36E471;
	Mon, 12 Jan 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LeXYNV7b"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F934FF70
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236764; cv=none; b=jBaV4aw3lXUPD6cRQNmNY17Wyy62gCvOkDeS39OANFxsa6wKCqNwpAHJbYiij7TZD5KoIAGRoSlMCu2Or4xy4z1wDxKGRtkVjGo1r14ThoW/BJuD4amEpLzBvCUSSA7e0QDBhN+W5dMtSeCR0otGFHokmni5/8WNN+dgQeKtI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236764; c=relaxed/simple;
	bh=8YnbExP3SLrmfqGuPpH3MYlZAXEo3Z3IMJJFHj03LKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXRv3JmzkH3Uo90gmZnNrZ6NwELWkdIP6DoKuHoyT79OpfuW6ZHko3DrK5CahUDTM09oTFMKqyUr5mtYB3bIA8ao2o13MBqie/9TR634shgFYbFw7P9mLwvq5DJNEcJZF1xaAUTSJ3dShfT+wQzfbE5mfa3WDu/k/jicbdBeAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LeXYNV7b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b175c4bb64so382035eec.2
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768236763; x=1768841563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d8RGVoLZF16RMD2YJSY2roZJEszVFUP22HFSw0KR30=;
        b=LeXYNV7b1s+6xy0QR9upKA6NP3Gx82RNcg4sKQ7M+3OcmqYwMBqXN43M/NYF9du0Mv
         e+2xxXX/I+r/H0fbdqvp/MvWmNkHrXj7AT3YVBtZmc2cvkmKsQUb3SW8k9tQXHPy40x/
         aA2Rhwgib87KXsepXYl+YHp9f0MD+bxIbV1YWy/+gqG5gaX4zHfvdqbl5sG878670Wl9
         w7ecqy4tRTC/pHrS5nl1nn1xpRejG6FYTu1/p+fUgYIr6OkGAIbKS+GXCKgsZqNhCOxV
         hiaCz+WLZzL7QQKhw/NluubCME5o/ddIAr+oXSWu0xqnIzsnKTFvb8OT+QptHcvajpOC
         Q3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236763; x=1768841563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7d8RGVoLZF16RMD2YJSY2roZJEszVFUP22HFSw0KR30=;
        b=Mi7v57/fRqIcPd+ecUuximpi+shNxdh9rPdrdwrFGQraBIdA31Vt1iFZoXXnDhQ7AB
         aH1Gh4cEOGIGJGmM2TyXJTsg0S/HzEe1F9HbbmzUawYIx1CbmQcwoD9UxlAgTpfPqV4k
         sdMlT619i5I73qSTFquNyfQp6yPQZd6lYiMH/F0Wz1TN+DtQPO3W748ktoEUhqa/e5RB
         HiyreSDeZ+sZ8FKar2tibpsKvdOvU5xZkMQSSzqkcaPDmHl1cpIzm1woDWff3tE55lBu
         sX1JLyXxj2/s4heCBCyZKV1hDBuXsPeZc1rm50bXRCkoayHKrlX/QROIDG35DWThdgNM
         Pqfw==
X-Forwarded-Encrypted: i=1; AJvYcCUclpX5PhTRILNUGhwTRFYpqVp+nj2oKkxjCw3hO9/wWCr+Cjn25DLR16YzQJyfklwRvKEAafM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpOEGoBZZzYkqiAjVFmOJtzFA3v5XWHRdwfrN0vQBjigjz7p9
	blBi5+aymenJoc01fNNWs071johZ4m9qTGsIdTU0wHSuedKdq5TmWAa26px6okVyrA/2ExEX1cF
	HMJLVutnrw3NFM373s1qoG4FSDXTuMru2gKBpU9LHRg==
X-Gm-Gg: AY/fxX4oR4dn947+0WEdJXCE2XvMLcScO8KQ4eKFpZVoRcUfGu4Vo/MGUVK7MpmqIPt
	XV9e6yTMVw7FO7wGz22tbx6yLRw2LfUMiy91zQrHMw6zN48S3SVBkw3rsyax0sKjgSLl3lPmiin
	ajx5lgTnbZssJXIq0qR4PV6jebo2J2mPKeB88ghI/u5b3HEERBx5E9/7t5z3vKb9UQ1fSUrKOHB
	pnOsJ88yas8laq3ohc0KkeFwzaLX/GjFCZgq4K8PfD5FzVhWMSnqeYI03oS8ySYCzGGTTT5
X-Google-Smtp-Source: AGHT+IFcqY9wm+FrDAvGu8UBn0lXhR0EABOn/a64TPj7RpIMEBmOWydS17e3P6DagQnAC6bk4DYoY9tl4eaJSZAUxto=
X-Received: by 2002:a05:7300:2d15:b0:2ab:ca55:89c9 with SMTP id
 5a478bee46e88-2b17d310ca4mr9130094eec.4.1768236762423; Mon, 12 Jan 2026
 08:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112041209.79445-1-ming.lei@redhat.com> <20260112041209.79445-2-ming.lei@redhat.com>
In-Reply-To: <20260112041209.79445-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 08:52:31 -0800
X-Gm-Features: AZwV_QiWuHDfTGO_FTDMI-l8fAkP9zpVb53e4l9TUQfP1jFFeC2a6Mubfo7mhJ8
Message-ID: <CADUfDZp_4pOSAuPE52OWGU1q46bQHZL_9LLp8ANP3umZ1upmYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: cancel device on START_DEV failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Seamus Connor <sconnor@purestorage.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:12=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> When ublk_ctrl_start_dev() fails after waiting for completion, the
> device needs to be properly cancelled to prevent leaving it in an
> inconsistent state. Without this, pending I/O commands may remain
> uncompleted and the device cannot be cleanly removed.
>
> Add ublk_cancel_dev() call in the error path to ensure proper cleanup
> when START_DEV fails.

It's not clear to me why the UBLK_IO_FETCH_REQ commands must be
cancelled if UBLK_CMD_START_DEV fails. Wouldn't they get cancelled
whenever the ublk device is deleted or the ublk server exits?
And this seems like a UAPI change. Previously, the ublk server could
issue UBLK_CMD_START_DEV again if it failed, but now it must also
resubmit all the UBLK_IO_FETCH_REQ commands. This also means that
issuing UBLK_CMD_START_DEV after the ublk device has already been
started behaves like UBLK_CMD_STOP_DEV, which seems highly
unintuitive.

Best,
Caleb

>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f6e5a0766721..2d6250d61a7b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2953,8 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>         if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
>                 return -EINTR;
>
> -       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> -               return -EINVAL;
> +       if (ub->ublksrv_tgid !=3D ublksrv_pid) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
>
>         mutex_lock(&ub->mutex);
>         if (ub->dev_info.state =3D=3D UBLK_S_DEV_LIVE ||
> @@ -3017,6 +3019,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *=
ub,
>                 put_disk(disk);
>  out_unlock:
>         mutex_unlock(&ub->mutex);
> +out:
> +       if (ret)
> +               ublk_cancel_dev(ub);
>         return ret;
>  }
>
> --
> 2.47.0
>


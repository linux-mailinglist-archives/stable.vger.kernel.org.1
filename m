Return-Path: <stable+bounces-203232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF8CD6C6D
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CDA301BE8A
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B79262A6;
	Mon, 22 Dec 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gXAhgWJq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2B322B73
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423479; cv=pass; b=SXtOVcuVfG/j09Au0Kn7X6IP0RW6R8l6XH660SUzVt+Y+tKBg/iFgZK92RObwZ2/EpUmMxz9bA+rFUPJ2OzRwq2UsudqQgr1sJlmU2KBlproSMiEwKZP60eGw0ALAa+7/WgzP59U2btn1aGX47BruzXLgOST+ThWgT6K7OCWGDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423479; c=relaxed/simple;
	bh=JqacWfAt0ZXZ69hE4OkTIVIFQV9cJx9Hva6On2owtTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcmDe7uUvEi4WOb6wVkFswmQtRBCz1mEoRUrKMyCjASGB4HL6fQY2PJEUnqKOQW1EhFMaG7RuBMqwuxFoP/+dRThIxkpTsTplr/xzsgmb04YMQxmtrolJ8rJ+iAcJrKPRu6rCfU4a0IuWg4WpHM4oQLLbJY2z7EW53qbTA3fLL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gXAhgWJq; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7c9011d6039so148018b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 09:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766423476; cv=none;
        d=google.com; s=arc-20240605;
        b=dg+UhGVAY9CFcz+QGAqkanezutwiRaDC00pyqL8eVR3GuaJtK4w0+86Y3N3J177oEL
         DWpxD6jCRnkhiyuAUgAPPN+NOSadMis1XIPx7G0iBkqty3Re7fNbL+kiE945J6/cD74N
         6buQRu2anduz7tUdzElQ14Szk46NOhL9yp7nIrmdcohKp0MFNaiKLXemvvtHqHJ3cMUQ
         NZlOu3Hk6WWHnJBYGRG6oGRTsCG5M9P1BAvY583UIbqHHPs5NoGj3n7Q05lBPLZfgtdi
         SJdVvb9vBk+EH5m795UVXvxNzNwNLEhlYxfJi1FJzL+taQOzLoxp2ndHtLWPNl9yizRM
         3HGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        fh=ot7XfEiwh6T3kPKOvYBi2KWZMKVLttI/mumtOlptddM=;
        b=P3mTTukzHFhRxWCFOsp3rAGHfiJVCw6iTQh0C3UbBD9eqVBWaoh5ctz0oXiGibRweV
         x/ZlzvYzt2cGRuijsFc7zkXLJbsc/N3wlk8txKU6UpC5YBXpXTYWY1CpiRi8JLi7d9w1
         uYDUKHT2ADRfG865Zq9mwQ94kakZU6yAUYEgw4kr31svSMJWmULyJvzsDaUWarORWc9h
         VOsa7tqT/Zj98caXJzhXTc9ZAsR0wmciMVHQxA/3mhRWQ4txBwAUD37BgbA7lcnbfytD
         PtxPtJ70vmklrWmotxI2enWiOl5oZSUTgISO1tDi/TFSQPgMAMucxSFAdKbhbaCqdXwm
         k2FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766423476; x=1767028276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        b=gXAhgWJqu+hgR4ekHjrujxpRlBeI68PVwRESwXvkBuPyt+HOOuqT7a7CtdXOilzXUX
         KN0MBm/+inJwU6ZfdL1bJ9FcUhncH/S9T8tMQGnBk9jyWKV8prWRcyQH6yrPqI04oTZb
         dJer1lttS5AsUdCQhMEh5rspzuRxXz65Bay9xhlNYMzzGwtxx6FthDdlgr5+YjNq8FCd
         sVjQkRL7FXX/CgKlP596NWFA8+mb7PtwxbWrpq33J1a/gWfmkQoHNQ01TtKZF+pcwZeo
         YBjozgz4pgReegBfyciip4zHA1oB0Nfcrm1bI0m3GiVE2kqpBaYqjVm+ZLHlBTQUoh8F
         LE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766423476; x=1767028276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        b=VgUItFT/9UIBsTHb8V8R26CeIfytI3jGmh8f5hhuXsAR/CVlyIyAV6woJccKcGdPXh
         boLg3xn0SCE+oCo4QjiT46Iv+yqPBxeEjcdepQkEUbbPuupYKMSN1Kv1yY9bCapeQHez
         leW3N5E0sLs5e3i8HFGFSHt/CztJgixbLDV/C7Gg65gz7yMKONYD/CmZ47OjqhXbX/1y
         uadrU0VjxASkTSqByQKyOG9n1V/V7XF0CHCKakGAi3ksHvQ2dhxKvmy78GFgUs13bOG6
         bMlqS1IKscr2j8d9VXGfRcBKeZF56pkRI0oV7B95B0b/JHHdRuNjkqVDTTIQzIkrnP4b
         I82w==
X-Forwarded-Encrypted: i=1; AJvYcCWM5r2xMSR3FlD4/boHnj/qiH/5FEaU409sFLJB+lMKqRiQVUaLw5rF2G9T4DAcEAzvdf2ck4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMQpWB0sl64MoBCTwQhXoZ4nepZ8K1bPd16DJ8c2UHyxmGdMi
	h5PiOu+NIswcDM0pmyGQ6fY0/cTYTMRzBsuodOzgZyRcpjm9zX/bcmvCvffv+m58Wwu8y23zzI2
	q62ZxjhORg2zHlqGtWmIM9RHH/gxfBEhZxZ89Zg5xWQ==
X-Gm-Gg: AY/fxX4LWKcHAvUfgemePfkCWdup2mWRYzbnjHI1W80EXd//kT93bi3NCCHW0hL7uQP
	a1VOBEwDH6fd2K0b0aGcYzzuHN3QxC3rxZeDTlThEDm+eSx4+tTwtoK6Qn0LzlYrQv4T3tubX0l
	d0bxWEjq35RS/4GqZkGLU2Ug6EjWqJbdoK55J2DhaFUETgVCb/e8slPR/y4RcRoE4npx4zjLL5q
	91EqqcNkMhdYqkuJgVOyApLD+T78qgjer7hFhtg+F0mXUNMD2YFKtPt9/acj2tTygJPVcY=
X-Google-Smtp-Source: AGHT+IEgoFt5onRyuFBvCdWzpye1MCSgMGvEELbkTWdAfyq9Bby3/aulgO/3PI5bxZIcAsJz2e+7U/96+CK/y5Z9WUo=
X-Received: by 2002:a05:7022:e1b:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-1217215cb5bmr7000590c88.0.1766423475371; Mon, 22 Dec 2025
 09:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220095322.1527664-1-ming.lei@redhat.com> <20251220095322.1527664-2-ming.lei@redhat.com>
In-Reply-To: <20251220095322.1527664-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 12:11:03 -0500
X-Gm-Features: AQt7F2rdEb1Bo1fkp8d0Z7EFB8KTv6YCIzuB9VKDVyEzrXaw4etsbK_h7EA5mAU
Message-ID: <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 4:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppres=
s
> automatic partition scanning when starting a ublk device.

Is this approach superseded by your patch series "ublk: scan partition
in async way", or are you expecting both to coexist?

>
> This is useful for network-backed devices where partition scanning
> can cause issues:
> - Partition scan triggers synchronous I/O during device startup
> - If userspace server crashes during scan, recovery is problematic
> - For remotely-managed devices, partition probing may not be needed
>
> Users can manually trigger partition scanning later when appropriate
> using standard tools (e.g., partprobe, blockdev --rereadpt).
>
> Reported-by: Yoav Cohen <yoav@nvidia.com>
> Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D=
65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>
> - suggest to backport to stable, which is useful for avoiding problematic
>   recovery, also the change is simple enough

Not sure backporting to stable makes sense. It's a new feature that
requires the ublk server to opt in, so any existing ublk server being
used on a stable kernel won't be able to make use of it.

>
>  drivers/block/ublk_drv.c      | 16 +++++++++++++---
>  include/uapi/linux/ublk_cmd.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 78f3e22151b9..ca6ec8ed443f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -73,7 +73,8 @@
>                 | UBLK_F_AUTO_BUF_REG \
>                 | UBLK_F_QUIESCE \
>                 | UBLK_F_PER_IO_DAEMON \
> -               | UBLK_F_BUF_REG_OFF_DAEMON)
> +               | UBLK_F_BUF_REG_OFF_DAEMON \
> +               | UBLK_F_NO_AUTO_PART_SCAN)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2930,8 +2931,13 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>
>         ublk_apply_params(ub);
>
> -       /* don't probe partitions if any daemon task is un-trusted */
> -       if (ub->unprivileged_daemons)
> +       /*
> +        * Don't probe partitions if:
> +        * - any daemon task is un-trusted, or
> +        * - user explicitly requested to suppress partition scan
> +        */
> +       if (ub->unprivileged_daemons ||
> +           (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>                 set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>
>         ublk_get_device(ub);
> @@ -2947,6 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>         if (ret)
>                 goto out_put_cdev;
>
> +       /* allow user to probe partitions from userspace */
> +       if (!ub->unprivileged_daemons &&
> +           (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
> +               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>         set_bit(UB_STATE_USED, &ub->state);
>
>  out_put_cdev:
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index ec77dabba45b..0827db14a215 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -311,6 +311,14 @@
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>
> +/*
> + * If this feature is set, the kernel will not automatically scan for pa=
rtitions
> + * when the device is started. This is useful for network-backed devices=
 where
> + * partition scanning can cause deadlocks if the userspace server crashe=
s during
> + * the scan. Users can manually trigger partition scanning later when ap=
propriate.
> + */
> +#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 15)

This is the same bit you've used for UBLK_F_BATCH_IO in your other
patch series. Are you planning to change that one?

Best,
Caleb

> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>


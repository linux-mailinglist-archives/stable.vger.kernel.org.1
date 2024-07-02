Return-Path: <stable+bounces-56320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3891F0ED
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC1B23568
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6E144D0B;
	Tue,  2 Jul 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LjuCx+x5"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87E7829C
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908453; cv=none; b=djXe0fItOPKeHwTZFn18MIxy2zixPfczV+KlA0IZODaKbOs5AJANpYoXeatdW0DKoJnvUjgB7ViPYg+eJ5e6+li/0LWYtJcEi6mactdtOsGNIRyxr5jbutyRAoSIIfdmWkVWI2ijp+1u8DhPOsFUbOtrd0GKActJznonr51SzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908453; c=relaxed/simple;
	bh=6OfNLsEcuwgQPbhcCUlgVHhhJgMvu5X5FAPBqs+/CLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7AfxmCBIX5j99IUnHtP2VZLo4gHOysZ1uyMFELp7d5z6fGgyZm3Z9OCGQIN3sox8qQwZtO8QpZH4N+5Izb5y/9QrYr+fBQsS8aiXWqoFeAOBZeoq68mWbqGrDodZE1XeLIIItuL/rGdyZKoCOEND1OUR0Wdqp3tHd9n9yIZg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LjuCx+x5; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb895539e3so158779039f.2
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719908451; x=1720513251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjW1AaPPleDTehNvhUI4Uy1cfpQXZFORbmNIpyEf1Vs=;
        b=LjuCx+x52ukip3o2XVtv14shpNrqPMmSGYszR4wI6fOUZQ3wldmKBTn7VyMauzVSjW
         nUiWY0LGl021UhGFMnJqLFUqIHBFoNOUB4LHQkcJ+NOEQz3Sq545mKAPXtmcDEpQJFWE
         LXDmLX9Mb+/yqZfsdbnDZVPxYzQMDhXyRCvpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719908451; x=1720513251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjW1AaPPleDTehNvhUI4Uy1cfpQXZFORbmNIpyEf1Vs=;
        b=oXmIL0b+tXqOCx4JQ2F8GA0FKIh6rKan/eDinU5wK0IsPiyn/EfM36HrWGfQX+8VoD
         Lv/Q6WYMw2B8qzX1VoHwHIovGCii3DMefNet6/vdsn9mhlPeQ7ZraSJUyyE7bvv+dhgk
         M+0DkNgMt5Maxn/SnxIe8nvg2EsukpJab1+bQgU0LbLwZv9y439Hn/B1UWajYkGl1p95
         bjupYhRxFg3fVVRFcbBYaFOMuxKXmxM1WAVQjwzhRuepHFkvodE3lcmEHxQDscfIOQZK
         drmGWAzgl2q9xi40QbGEV2kYGnhsFecF3JQS4G8QIJAXsF/zNlLkkgyd4IWxTnNy6nAW
         luZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9xL1nz9lAT0cCKPjbkFUHuCtpya7l7NTSVXRMaaOwZQTPC70i3/RirNBu/IPhRKT4MZ8KQqbfZbIR7MrulW7T5wPk3vwc
X-Gm-Message-State: AOJu0Yxt4uzMq4WnsD49JJczXsZKWEtGNC52l1xut0LQgY0Q9rdxNMda
	Rr+VhBuu9Jq23lSiW219YPLoo4q6DvTwmIiGK4XAvd+08inHIUkQz7zB7PpJgOrMGMJZ6/3Q8Gp
	oVwagjqARwFtRyIhQowwiO7G1TRzGL96yg7oAnaYV5TAzLhR8rQ==
X-Google-Smtp-Source: AGHT+IH9o61cvuN+VnixhLr4W4vbDhnrsa3JHsyiS0SWCmokqqVTuxhftscbNsFyCGR3neeNzJdUmOMXH3MqV0MEt9Y=
X-Received: by 2002:a05:6602:2bfa:b0:7f3:d731:c6df with SMTP id
 ca18e2360f4ac-7f62ee501eamr919293739f.10.1719908450692; Tue, 02 Jul 2024
 01:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702021254.1610188-1-zack.rusin@broadcom.com> <20240702021254.1610188-2-zack.rusin@broadcom.com>
In-Reply-To: <20240702021254.1610188-2-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Tue, 2 Jul 2024 11:20:39 +0300
Message-ID: <CAKLwHdW=KMS2wWueFvWexSLiFo50hENmwju7pLPNLraCqZyvJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:12=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> Introduce a version of the fence ops that on release doesn't remove
> the fence from the pending list, and thus doesn't require a lock to
> fix poll->fence wait->fence unref deadlocks.
>
> vmwgfx overwrites the wait callback to iterate over the list of all
> fences and update their status, to do that it holds a lock to prevent
> the list modifcations from other threads. The fence destroy callback
> both deletes the fence and removes it from the list of pending
> fences, for which it holds a lock.
>
> dma buf polling cb unrefs a fence after it's been signaled: so the poll
> calls the wait, which signals the fences, which are being destroyed.
> The destruction tries to acquire the lock on the pending fences list
> which it can never get because it's held by the wait from which it
> was called.
>
> Old bug, but not a lot of userspace apps were using dma-buf polling
> interfaces. Fix those, in particular this fixes KDE stalls/deadlock.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 2298e804e96e ("drm/vmwgfx: rework to new fence interface, v2")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index 5efc6a766f64..588d50ababf6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -32,7 +32,6 @@
>  #define VMW_FENCE_WRAP (1 << 31)
>
>  struct vmw_fence_manager {
> -       int num_fence_objects;
>         struct vmw_private *dev_priv;
>         spinlock_t lock;
>         struct list_head fence_list;
> @@ -124,13 +123,13 @@ static void vmw_fence_obj_destroy(struct dma_fence =
*f)
>  {
>         struct vmw_fence_obj *fence =3D
>                 container_of(f, struct vmw_fence_obj, base);
> -
>         struct vmw_fence_manager *fman =3D fman_from_fence(fence);
>
> -       spin_lock(&fman->lock);
> -       list_del_init(&fence->head);
> -       --fman->num_fence_objects;
> -       spin_unlock(&fman->lock);
> +       if (!list_empty(&fence->head)) {
> +               spin_lock(&fman->lock);
> +               list_del_init(&fence->head);
> +               spin_unlock(&fman->lock);
> +       }
>         fence->destroy(fence);
>  }
>
> @@ -257,7 +256,6 @@ static const struct dma_fence_ops vmw_fence_ops =3D {
>         .release =3D vmw_fence_obj_destroy,
>  };
>
> -
>  /*
>   * Execute signal actions on fences recently signaled.
>   * This is done from a workqueue so we don't have to execute
> @@ -355,7 +353,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manage=
r *fman,
>                 goto out_unlock;
>         }
>         list_add_tail(&fence->head, &fman->fence_list);
> -       ++fman->num_fence_objects;
>
>  out_unlock:
>         spin_unlock(&fman->lock);
> @@ -403,7 +400,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fenc=
e_manager *fman,
>                                       u32 passed_seqno)
>  {
>         u32 goal_seqno;
> -       struct vmw_fence_obj *fence;
> +       struct vmw_fence_obj *fence, *next_fence;
>
>         if (likely(!fman->seqno_valid))
>                 return false;
> @@ -413,7 +410,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fenc=
e_manager *fman,
>                 return false;
>
>         fman->seqno_valid =3D false;
> -       list_for_each_entry(fence, &fman->fence_list, head) {
> +       list_for_each_entry_safe(fence, next_fence, &fman->fence_list, he=
ad) {
>                 if (!list_empty(&fence->seq_passed_actions)) {
>                         fman->seqno_valid =3D true;
>                         vmw_fence_goal_write(fman->dev_priv,
> --
> 2.43.0
>

LGTM

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin


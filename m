Return-Path: <stable+bounces-55961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2991A63E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9021C2170D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA814F9DB;
	Thu, 27 Jun 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ek8Z8Af8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30A14F136
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490108; cv=none; b=KE3YimfJldNJbKzII/Lm9cOYfNaSzXA6/fvQ/x6yxWFYAL7vd9Xk2CIDkAgF2vZXOu0YaftHzVqM4ifYFv1HAv2GHoMCG+JWXHRFcqax7mk7pA8u3rZmHwRaOxT/YHWsTiRwDltgxEhMqtU0RaMtldiZrgZF0Lmzv/QP0WNWm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490108; c=relaxed/simple;
	bh=NNYgvkQGOi85u6xSD3TmzRogo9W+Re6TwnaN7Whg7W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZB9f1jmsmHBImIQf+fSX6681zrHDZZrknASmBzoxj3zd/EcksFkaq2G/QdWDgmATh549LCLG4KZoLt7NcOIQMQbOpC8Q1EEZQw5mFgL9DGTA/XtGJdJvn4R/dgJ3PWgkNi2bx0qTFTKnQPWXVQO9LsVJU7DDR35ad33fWo8iWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ek8Z8Af8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3760121ad45so33362695ab.0
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719490106; x=1720094906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2r1ESSwZbjCYuyVquXZ4JcpRU+zaQsqDZJxmGkF+CA=;
        b=ek8Z8Af8WNzE9dueeeP1NrN3caV9rGDNyuB+OkEuKKqnVs55paOa20YgJr30qAeB7o
         0KrlxNLRUfWwk46RjZSF48E0g9PqLE0tfnGeMCjJ4e9hfap4fwJ5QuseR7llxz5/wKkZ
         3zklowi3KJXsuuYbz6iUFeoipjT39tuzVx76A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490106; x=1720094906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2r1ESSwZbjCYuyVquXZ4JcpRU+zaQsqDZJxmGkF+CA=;
        b=bJW/PFoAniE3fHNqwuj0Ofx1XofBlef9F4o7z5Z29SVeTkngRFbHqVxK0tCYcurcu7
         iISGjqwB0166LqrCWjfx4JOXrVoMCDlxlfQZxIAQh9i7XDkIq1I2vnzux1eNB8OC+W69
         JDCPuWDcY9DRTnM2iv3RyJhneMTRxj8gPN+ETR5FKnYqh9UgY5Quk6vGm/UUvkPPFwu7
         I8GMt5RtIvSa1yZQGuKj+g0MSIDvpX1neIJUg82tiBhZ/viPxaVVWcBgAGwXoF03tqHG
         MWSZBIYgui/jGAS/WVX4mXwrUwHOzlZTuXpbFVmahodiY2aQBSxf5J3ZARPTkSXIwWPP
         Oz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjDe/5/fapn4etAej0Pv5vUcXNp2fHcrZsfV/esIpKfZJ1uPW1WwwBoBGbDs31BBE24K1atKkhvvMfl0VvXpZy/hHbPj4J
X-Gm-Message-State: AOJu0YxOAIzZbQzLdQhfBjwjXKtlEAgofJannfSlQL1yX+nF43GSoUYA
	opcQln1T78pVVnn2iKWdfU74XQgL3s1KInQgV1HKg1hjpnTJw90+RYGXTh57ZzmZxV25W1Hi3Ln
	XlpEwvsLMhhGpV2SWkwrxN94Iyne8ptq+/R7DSvCYVr9bfaHP6g==
X-Google-Smtp-Source: AGHT+IGugJIkLcqzl3qOGvg/HikFdmSdOsLhMoybnqZZC2VraMmaowc074qNNMvCK7PWMffiPVYf5ZAKDYCtWmoBtlw=
X-Received: by 2002:a05:6602:2b93:b0:7eb:b93d:4101 with SMTP id
 ca18e2360f4ac-7f3a4dcbc1fmr1753925839f.9.1719490105954; Thu, 27 Jun 2024
 05:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627053452.2908605-1-zack.rusin@broadcom.com> <20240627053452.2908605-2-zack.rusin@broadcom.com>
In-Reply-To: <20240627053452.2908605-2-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Thu, 27 Jun 2024 15:08:14 +0300
Message-ID: <CAKLwHdX9f1dgNnQY64WEJAERrUiQgzEvVb=8rQXf3y9uUMoyqw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:34=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
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
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index 5efc6a766f64..76971ef7801a 100644
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
> @@ -120,16 +119,23 @@ static void vmw_fence_goal_write(struct vmw_private=
 *vmw, u32 value)
>   * objects with actions attached to them.
>   */
>
> -static void vmw_fence_obj_destroy(struct dma_fence *f)
> +static void vmw_fence_obj_destroy_removed(struct dma_fence *f)
>  {
>         struct vmw_fence_obj *fence =3D
>                 container_of(f, struct vmw_fence_obj, base);
>
> +       WARN_ON(!list_empty(&fence->head));
> +       fence->destroy(fence);
> +}
> +
> +static void vmw_fence_obj_destroy(struct dma_fence *f)
> +{
> +       struct vmw_fence_obj *fence =3D
> +               container_of(f, struct vmw_fence_obj, base);
>         struct vmw_fence_manager *fman =3D fman_from_fence(fence);
>
>         spin_lock(&fman->lock);
>         list_del_init(&fence->head);
> -       --fman->num_fence_objects;
>         spin_unlock(&fman->lock);
>         fence->destroy(fence);
>  }
> @@ -257,6 +263,13 @@ static const struct dma_fence_ops vmw_fence_ops =3D =
{
>         .release =3D vmw_fence_obj_destroy,
>  };
>
> +static const struct dma_fence_ops vmw_fence_ops_removed =3D {
> +       .get_driver_name =3D vmw_fence_get_driver_name,
> +       .get_timeline_name =3D vmw_fence_get_timeline_name,
> +       .enable_signaling =3D vmw_fence_enable_signaling,
> +       .wait =3D vmw_fence_wait,
> +       .release =3D vmw_fence_obj_destroy_removed,
> +};
>
>  /*
>   * Execute signal actions on fences recently signaled.
> @@ -355,7 +368,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manage=
r *fman,
>                 goto out_unlock;
>         }
>         list_add_tail(&fence->head, &fman->fence_list);
> -       ++fman->num_fence_objects;
>
>  out_unlock:
>         spin_unlock(&fman->lock);
> @@ -403,7 +415,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fenc=
e_manager *fman,
>                                       u32 passed_seqno)
>  {
>         u32 goal_seqno;
> -       struct vmw_fence_obj *fence;
> +       struct vmw_fence_obj *fence, *next_fence;
>
>         if (likely(!fman->seqno_valid))
>                 return false;
> @@ -413,7 +425,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fenc=
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
> @@ -471,6 +483,7 @@ static void __vmw_fences_update(struct vmw_fence_mana=
ger *fman)
>  rerun:
>         list_for_each_entry_safe(fence, next_fence, &fman->fence_list, he=
ad) {
>                 if (seqno - fence->base.seqno < VMW_FENCE_WRAP) {
> +                       fence->base.ops =3D &vmw_fence_ops_removed;
>                         list_del_init(&fence->head);
>                         dma_fence_signal_locked(&fence->base);
>                         INIT_LIST_HEAD(&action_list);
> @@ -662,6 +675,7 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fm=
an)
>                                          VMW_FENCE_WAIT_TIMEOUT);
>
>                 if (unlikely(ret !=3D 0)) {
> +                       fence->base.ops =3D &vmw_fence_ops_removed;
>                         list_del_init(&fence->head);
>                         dma_fence_signal(&fence->base);
>                         INIT_LIST_HEAD(&action_list);
> --
> 2.40.1
>

Neat fix!
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin


Return-Path: <stable+bounces-227236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJjbNqu5u2mtmwIAu9opvQ
	(envelope-from <stable+bounces-227236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:54:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BFF2C81DA
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99BF63017013
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F08253932;
	Thu, 19 Mar 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4vcxztp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984B3612D2
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910416; cv=pass; b=g5YMzLENixjb9D6hHsBVPkN8OE3bnUhSwQyCbj2tPQmgYwVpEK6dyeryugVdMc+35Ga3U0sSGS6L/YX/r5F4LryHZYbq1Q/oXaJPtGpXyGkXGjmXQ/yWwC1/byO7glz2saxPWULQ4bwV9mmtHmWZ3ZbyLiRtNmpmPwAZVME4uHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910416; c=relaxed/simple;
	bh=A3GBdp8xZKN3zylTYlNKhy8WjZfjfLdi1INz222AtyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKil6w8nDml/EDdg0S3pxerlLV5uUGnv6MOffxw+YoAGbRTWSXakxB6TpGobSEi+T8O5qNkg2gFqPZa07oCIyPrnwhUAUEvpbQUu37JSaaj8aIqtRKa6M4byh5ak5qMZfUUCfF3B2I6ZAeUuXXgrt1cbwjjUH1z8TcBxidhhoec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4vcxztp; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b30d61be6so62561cf.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773910414; cv=none;
        d=google.com; s=arc-20240605;
        b=gY6C7X9FEzmJvwg4/Cv4RqcKbPVHYUQo/Ku4BDY8nhs9mZgcCHpwp1Lz4aTA0QRJEy
         ebMOWR/ygg/o69KbIpQo8qdfOCOK1zKPzNMug2jdE9ieS9+QyGjXsdlA51Mw+rmF/fCk
         dOJ4U3ACngFKvzzPHpQ5FJDZ4mHbjhsJ0HTsCYs8TE624K6jeXjcPkaOnFetbiDLINs0
         83/NNRp5kAu1vvdBwcBT7vdx33paoxJ6s2PTyxXRLJMKigkMS4eGmhY2jduDYmxUiLOy
         CwMn5x9EvCdf1gD1m0fO9mqwkzKhmAW3qQmongI/eUDihne6CT8RFEnsEFI4ANxWx3xQ
         /LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=dWep1QNuet0V2N4usMiH3Uv7Rfbxt7VvCQQncjGfhNI=;
        fh=Tx8xGVoJEQNhASzJVpy/7gtAjdwpngT0cvelp9crOng=;
        b=fNpzGysgWmk+FYIYk5blXl52SKfV4kgJObd7QQhmkXiXcrza1jxcpjuKRtkbKbfOJ3
         Lbou9ezxMZ/1D7/Zymw0dWSc9oHhSS0Z4KxK6Os4o11HyovOuGJ2eSkj9772QPSKgUxu
         A96UTnpB3r1YpnrF/r6aMIebEc+d4e4X/Kjq8eqXJAy7a/lf592bfELnuB4PyOJw5MaN
         rrIQZOsaYo9E1YSHSB4no1t3LzZOtiKOawpLGfX5rAxarBrLWzhxMfRbQdIhCmUtbwZe
         1836sRQk1ROOW0t/Pd9yaXv5t6sZBfwxsMkHwIjE5iEq96WR4wuzo0aDcOYi6B4iGFnE
         VYKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773910414; x=1774515214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWep1QNuet0V2N4usMiH3Uv7Rfbxt7VvCQQncjGfhNI=;
        b=p4vcxztpN9johP1YJAyUdW2ehL7XZdWW9w7wogWyAm0dAg2oPxiKTGEmjwgccKJRcb
         s3WGpAgDddrrDRkziX5ShFwAA9vvPY5dQBK5NIuR7cbCQMEBq0B9B5p5RwvzsKic1G3q
         4z3LfXDAst51O/KOnB8b2JlzIfTIkHAUGiQMc94SnvwJtLfAwW1jGDZy4/s0huzQdOeP
         cvYb6zQh1kJymyW0NjsdQ3dhhLYlfVwv7XhIuMUMnE+3O0zPFDocjGL/ZcFFl+85YaIf
         NFc9TooeMEJVSpWqMK1fyv+hlUIpi7Fzk7OP4eBAf/CHgBM+ydHUjwL5363ImMgur3xP
         VEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910414; x=1774515214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWep1QNuet0V2N4usMiH3Uv7Rfbxt7VvCQQncjGfhNI=;
        b=ej84eW3SL27oDFojJH//Az8tmdMGiYQuvbELTutZT6SqPMYOHCk7N/TeUlMJe4zoIW
         8DPJ4/SePoe8cvMThG41bcri60eBNhyEW7RYzYcRvfmHFBahIfMYQUaTscgIUAmIyyHF
         H66oK/93S07mmSEDRi3qC7xIz09NoNbGy8keeLmic20B36koN3S132KgI0OsDxIb0Iry
         bznNpdd5+slI6eKdYrUQpQP5zQPb2Ij06wdquR8IewC3XwEmU5MqpAO96TmX7V38gvBz
         Kfr993uavEwnVo0RhHdZMcXUULMugeWrng4pTNyqjKmhtu2hb7ZQQj7L7bkhVGxWuSRr
         Buvw==
X-Forwarded-Encrypted: i=1; AJvYcCVq4Z75Fl+nKoSRuj21Y9xsg7u+h3ct+khoVFgLMWjY62nk8g0UtLSWl4f4C7awbYpW+3YiI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ib74w3wgx0ldrPvFi9BO4zwwEieC+M5MnSYMvPDSzIk8z8V8
	qkhQ1JBX3rchHmlnsmzwdbdsemTUHfgf7xUAy4s6yrWM7v3BHfLjtY9kJPWd3hFok16f9pF0wrh
	3iYDIzT68WY/3CtEW2pVfxEhNuozjUAYp3Ce/xcld
X-Gm-Gg: ATEYQzy29MWQsHHVi9YtykQu6W+wmHt6RZ23K7MiE+LZtbBsGI0ixtwVabTQWkxvDlt
	Ys/qKkQVPagz8e3eY1qbMNAKz3B2ZOIu2pdJJMENer4Rzn0pTpmvMIMHI7PrbKJe+xjldSzXgGw
	hC7uojZC7T1/j40xyVN32UwAF/+5RaZtaAvF4EATDYcy117g9dUiq04QbELdE71AA8UpbDjAakh
	6K/FuiIqZHIQXhviZVUyKMztZp9sxWLCMwBSUryJzxdCG1Hy27LgvHVJMFXyBotysmdVOmBbmtV
	dTPEQBPPhg==
X-Received: by 2002:a05:622a:1a9d:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-50b2559907amr12465781cf.14.1773910413395; Thu, 19 Mar 2026
 01:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224083955.1375032-1-hhhuuu@google.com> <20260309053107.2591494-1-hhhuuu@google.com>
 <2026031109-supermom-treat-09b5@gregkh>
In-Reply-To: <2026031109-supermom-treat-09b5@gregkh>
Reply-To: hhhuuu@xwf.google.com
From: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Date: Thu, 19 Mar 2026 16:53:21 +0800
X-Gm-Features: AaiRm51xx_Y1YrVBXUUT0-t2So9vbcDof2bTnU5Ao7X4ETu83rkQhQZMq4lB4pw
Message-ID: <CAJh=zjLbH0T=K3U2=zwJc9O1kqtic1f29iPJzsZFqrvBjCEDmw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix NULL pointer dereference
 during unbind race
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Dan Vacura <w36195@motorola.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, badhri@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227236-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[hhhuuu@xwf.google.com];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@xwf.google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xwf.google.com:replyto,harvard.edu:email]
X-Rspamd-Queue-Id: E5BFF2C81DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 8:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 09, 2026 at 01:31:07PM +0800, Jimmy Hu wrote:
> > Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanl=
y
> > shutdown") introduced two stages of synchronization waits totaling 1500=
ms
> > in uvc_function_unbind() to prevent several types of kernel panics.
> > However, this timing-based approach is insufficient during power
> > management (PM) transitions.
> >
> > When the PM subsystem starts freezing user space processes, the
> > wait_event_interruptible_timeout() is aborted early, which allows the
> > unbind thread to proceed and nullify the gadget pointer
> > (cdev->gadget =3D NULL):
> >
> > [  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_u=
nbind()
> > [  814.178583][ T3173] PM: suspend entry (deep)
> > [  814.192487][ T3173] Freezing user space processes
> > [  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_u=
nbind no clean disconnect, wait for release
> >
> > When the PM subsystem resumes or aborts the suspend and tasks are
> > restarted, the V4L2 release path is executed and attempts to access the
> > already nullified gadget pointer, triggering a kernel panic:
> >
> > [  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_=
host_wake
> > [  814.386727][ T3173] Restarting tasks ...
> > [  814.403522][ T4558] Unable to handle kernel NULL pointer dereference=
 at virtual address 0000000000000030
> > [  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
> > [  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
> > [  814.404078][ T4558] Call trace:
> > [  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
> > [  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
> > [  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
> > [  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
> > [  814.404095][ T4558]  v4l2_release+0xcc/0x130
> >
> > This patch introduces the following safeguards:
> >
> > 1. State Synchronization (flag + mutex)
> > Introduced a 'func_unbound' flag in struct uvc_device. This allows
> > uvc_function_disconnect() to safely skip accessing the nullified
> > cdev->gadget pointer. As suggested by Alan Stern, this flag is protecte=
d
> > by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
> > instruction reordering or speculative loads.
> >
> > 2. Lifecycle Management (kref)
> > Introduced kref to manage the struct uvc_device lifecycle. This prevent=
s
> > Use-After-Free (UAF) by ensuring the structure is only freed after the
> > final reference, including the V4L2 release path, is dropped.
> >
> > Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanl=
y shutdown")
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> > ---
> > v1 -> v2:
> > - Renamed 'func_unbinding' to 'func_unbound' for clearer state semantic=
s.
> > - Added a mutex (uvc->lock) to protect the 'func_unbound' flag and ensu=
re
> >   proper memory ordering, as suggested by Alan Stern.
> > - Integrated kref to manage the struct uvc_device lifecycle, allowing t=
he
> >   removal of redundant buffer cleanup skip logic in uvc_v4l2_disable().
> >
> > v1: https://patchwork.kernel.org/project/linux-usb/patch/20260224083955=
.1375032-1-hhhuuu@google.com/
> >
> >  drivers/usb/gadget/function/f_uvc.c    | 27 +++++++++++++++++++++++++-
> >  drivers/usb/gadget/function/uvc.h      |  4 ++++
> >  drivers/usb/gadget/function/uvc_v4l2.c |  2 ++
> >  3 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/f=
unction/f_uvc.c
> > index 494fdbc4e85b..485cd91770d5 100644
> > --- a/drivers/usb/gadget/function/f_uvc.c
> > +++ b/drivers/usb/gadget/function/f_uvc.c
> > @@ -413,8 +413,17 @@ uvc_function_disconnect(struct uvc_device *uvc)
> >  {
> >       int ret;
> >
> > +     mutex_lock(&uvc->lock);
> > +     if (uvc->func_unbound) {
> > +             pr_info("uvc: unbound, skipping function deactivate\n");
>
> When drivers work properly, they are quiet.  Also, why are you not using
> uvcg_info() here, this pr_info() gives no device specific information so
> you know what device this is happening to.
>
>
>
> > +             goto unlock;
> > +     }
> > +
> >       if ((ret =3D usb_function_deactivate(&uvc->func)) < 0)
> >               uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", =
ret);
> > +
> > +unlock:
> > +     mutex_unlock(&uvc->lock);
> >  }
> >
> >  /* -------------------------------------------------------------------=
-------
> > @@ -659,6 +668,9 @@ uvc_function_bind(struct usb_configuration *c, stru=
ct usb_function *f)
> >       int ret =3D -EINVAL;
> >
> >       uvcg_info(f, "%s()\n", __func__);
> > +     mutex_lock(&uvc->lock);
> > +     uvc->func_unbound =3D false;
> > +     mutex_unlock(&uvc->lock);
> >
> >       opts =3D fi_to_f_uvc_opts(f->fi);
> >       /* Sanity check the streaming endpoint module parameters. */
> > @@ -974,6 +986,13 @@ static struct usb_function_instance *uvc_alloc_ins=
t(void)
> >       return &opts->func_inst;
> >  }
> >
> > +void uvc_device_release(struct kref *kref)
> > +{
> > +     struct uvc_device *uvc =3D container_of(kref, struct uvc_device, =
kref);
> > +
> > +     kfree(uvc);
> > +}
> > +
> >  static void uvc_free(struct usb_function *f)
> >  {
> >       struct uvc_device *uvc =3D to_uvc(f);
> > @@ -982,7 +1001,7 @@ static void uvc_free(struct usb_function *f)
> >       if (!opts->header)
> >               config_item_put(&uvc->header->item);
> >       --opts->refcnt;
> > -     kfree(uvc);
> > +     kref_put(&uvc->kref, uvc_device_release);
> >  }
> >
> >  static void uvc_function_unbind(struct usb_configuration *c,
> > @@ -994,6 +1013,9 @@ static void uvc_function_unbind(struct usb_configu=
ration *c,
> >       long wait_ret =3D 1;
> >
> >       uvcg_info(f, "%s()\n", __func__);
> > +     mutex_lock(&uvc->lock);
> > +     uvc->func_unbound =3D true;
> > +     mutex_unlock(&uvc->lock);
> >
> >       kthread_cancel_work_sync(&video->hw_submit);
> >
> > @@ -1046,8 +1068,11 @@ static struct usb_function *uvc_alloc(struct usb=
_function_instance *fi)
> >       if (uvc =3D=3D NULL)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     kref_init(&uvc->kref);
> > +     mutex_init(&uvc->lock);
> >       mutex_init(&uvc->video.mutex);
> >       uvc->state =3D UVC_STATE_DISCONNECTED;
> > +     uvc->func_unbound =3D true;
> >       init_waitqueue_head(&uvc->func_connected_queue);
> >       opts =3D fi_to_f_uvc_opts(fi);
> >
> > diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/fun=
ction/uvc.h
> > index 676419a04976..22b70f25607d 100644
> > --- a/drivers/usb/gadget/function/uvc.h
> > +++ b/drivers/usb/gadget/function/uvc.h
> > @@ -155,6 +155,9 @@ struct uvc_device {
> >       enum uvc_state state;
> >       struct usb_function func;
> >       struct uvc_video video;
> > +     struct kref kref;
>
> But there is already a device reference count in the vdev structure,
> right?  Are you now having 2 reference counts for the same device?
> That's going to cause a lot of problems.
>
> > +     struct mutex lock;
>
> Please document what this lock is locking.
>
> thanks,
>
> greg k-h

Hi Greg, Alan,

I have just sent out v3 of this patch, which addresses the feedback regardi=
ng
redundant reference counting and log noise. Specifically, I've replaced
kref with a completion, switched to pr_debug() with device-specific context
to avoid NULL dereferences, and added the requested mutex documentation.

Link to v3: https://lore.kernel.org/all/20260319084640.478695-1-hhhuuu@goog=
le.com/

Thanks!
Jimmy


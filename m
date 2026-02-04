Return-Path: <stable+bounces-213339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDIQDEm4gmkzZAMAu9opvQ
	(envelope-from <stable+bounces-213339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:08:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D2E12DE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA8F30BF8F6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 03:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8062DE702;
	Wed,  4 Feb 2026 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a5Vcka4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746D2D4813
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174528; cv=pass; b=jtK0KQ+wRKpxvE3qZ9NoHG9yYyQIp4d2SEh9HmtdVLr61Bo/I4GKZetUYHnhc0ESNoDPIKWhcHdKtbjVqstaJoi+eKNuvlTg4AXjxNJ4v227sPf9Ix4/m4MuonRZNjLU5dakhpGcZkYb+9Rtmhem0vIdwBbc2veij57SrZbyzwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174528; c=relaxed/simple;
	bh=dZCFNfk3IzAyplxpfcKXPrgRKeaYdNIkIAcDZDpti60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHeewrLmlnXVKuOny5uIJaehSKXZwPtrcPuWfiABQmVp/x99xARRc3v7CE/RjLWHx4S9fK9JinGi75fxLZLaGxKtgaOzsPwR/SACW0y2M3f2Gi5q25lUburd22iiX6krVjRhWDRbjQK1OlHCWH7+nLvdxNqu3mUYKBUTQDmTft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a5Vcka4E; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so6062150a91.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 19:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174527; cv=none;
        d=google.com; s=arc-20240605;
        b=fhHZhfaf5dN2aSRt3xtaUwCnWhjI0rete5NxYRq01KISFoH3ui3WBoQZDdjG6HYaOv
         X/o/LgKWzQ+P3z9G7W6CvYNufoL0zu14Be17IomFXyC6e0jyaU+ArvPeQ1dS4ra608QD
         xZuY7+ZyosSzzbhOhFcqo88HPAPJSJoZ2LwT4pBJEpG44ha7/cWl5JiU6wXTpBFOd65n
         70kKhZeYg6mO178K122OTnzjb4sEieQaKG1bUUOmaF4PvxethRi/SLqjn2QryTNTAZ38
         r9388vK9Iz+KUaJJpv0jkumddQ+05BGVgQaTExVKeK0gil/UoMQOTtkQdrS6LQXjYdwk
         sI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        fh=zO2kT+mg1jkkxwrQ00Sr3jInSeMEqQX6EjR6fSnhOSY=;
        b=PrRdou+MytNS6+EYGY8Q7rvjI4lrJbPwXzbMqvZboZ2mJmIFQ2RC+qd0UiM1aWvCeQ
         Q/hDncobN4GVum8ZmdftjC2aXHWT+o+SDmrfzISsrkWiH7FvS05Pp0vSm0PN4v/CN5+J
         axaLvW0s9nUsYQpvjGfeesGWcKjDi2uvKgzhDE3xNy6sKf9TQ17M9Z5H/Em0xhZ8PZR0
         qdIXMJQ1ey8tfPl2DA3cuXwR1la9lzHxMWQXybpR4ivtcprmze4vUf27yEZ87q92nIEM
         ITSVpGTcODyEl1pOOeLcGpHTDOR5DMXaYFl/aoSdbV2NZe5AXJtL6nGlgpN3C4uJSd3R
         YnMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770174527; x=1770779327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        b=a5Vcka4EM6HINwXBSkVm7+hYLKgee1WlFxER64MV3wyi3NSMvPpS6j4eHbEgFcOrHQ
         6L6cT1Hb/IKel7AXH7QEPNcT2VMjXAcmN/3FqIx8Ugi0Msp1blFZN7XXD2ySyPVSJu0H
         tBBbG87iUPGrdz/U2VsWzxbQ1E2bLLV/gwULvvcxcd55RatLOIOxqndA9hU1MU7X3FQu
         vFP8LVX6xtrjdM0NTZPpEldqYreO+KtZ0sy4E5YEt+WdjDoXgD2bIAQh/lPwT6FSwK+f
         nzgQ0595E87EAWzFFBkG7A1TumatySi3epY7Xyjc0gzYZ6lUWVydExlbv5Esmoovx9ID
         CmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174527; x=1770779327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        b=qZzhMRWqdzolUlOORu976ZQnHOTGDbQs2vnPe0Ahl9BT7VtnTgNeJ+nGJzqWWHEd8o
         7CxtPcAGjYAfbBAksRUTHBqXT/wD3PcnZgYC+88aIfevrBzKOJn16kNhT/XnYBIqu7J+
         1FhgW3SoLE0RiLxbDDLcs8LptRANIc1aY5sCmlIwpW94aDvkPJ5enp54/xIgYbzW0wz4
         oB9ypnnEfcvcYcuqyr5teyD9SUAWZ4Ampo+vlNrEczvajq0OLCnSKxZClJAGT+nH/Xjq
         erjJ6Nmkd+nlGmcsValUXyP/MZ+AcPPGgBJd2biFu59NaWo1/u8Ra263QMffUcSI6r/s
         debg==
X-Forwarded-Encrypted: i=1; AJvYcCWHnScDKnNWUYU1zqmajhADaGJsz3w3q9yaF2aQpWi4mryvTqZNaIzVlnducNa1oL1aWucps4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwDnAMEfUyk7gqqk3bD2UAeS0FN4Wy1NZ7FS2+LNk/KNQiZRS
	QlzIWWQLWL1rAPpJxOJDHvxX0MMaDwotvUrlyHbs3u85oqBWdZ9MXjwNLXe1CG/JBy4ktN8rIBd
	28AM5B06QiN+PsI9VmkP020G0zsgQ1E69rT7bovDMhg==
X-Gm-Gg: AZuq6aLNQ6Ijqp/e6m9F+w3vjnOJXfpSPdFMp0wfEG+74Mz+qt03PZyL+J2Yj66a8CC
	yrhnSGxnh3AzZX50f6BqeoeoUB/CbInvh18pfNOggIql4gqRgMZDUW1jz/KTGT9iisbUG8ABrKN
	QACnxH5YAp+71bQGJOBiWAl3FAnSK5UKLPEkzGxlKjLRdF39lQMvexlBt8QJoPsHoFmrFInKUCM
	8yujwLICUHsoVlaMtIabXC6a2eHuwukJ15TNvXTpTSJ/IGnYGuZlr+bot9EKTAl07AyEaovtMLa
	aNbQKwTeAz3+
X-Received: by 2002:a17:90b:5808:b0:34f:62e7:4cf3 with SMTP id
 98e67ed59e1d1-354870d71d3mr1486296a91.10.1770174526682; Tue, 03 Feb 2026
 19:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com> <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
In-Reply-To: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 4 Feb 2026 11:08:34 +0800
X-Gm-Features: AZwV_Qi0FxYMJ_vV6dV-hna-OHMVyZCTHi0eEfriw2hdpyZ_gHoLVx_8pj8RZU8
Message-ID: <CAP4dvsd1mZyMwARtN+P+chLsT1-F4FVZpiMb4QMKeo+2CWX05g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync
 and vduse_dev_read_iter
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213339-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bytedance.com:email,bytedance.com:dkim,lkml.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E5D2E12DE
X-Rspamd-Action: no action

Hi Jason,

On Tue, Feb 3, 2026 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
> >
> > vduse_dev_read_iter():
> >     lock(msg_lock);
> >     dequeue_msg(send_list);
> >     unlock(msg_lock);
> > vduse_dev_msg_sync():
> >     wait_timeout() finish
> >     lock(msg_lock);
> >     check msg->complete is false
> >         list_del(msg);   <- double list_del() crash!
> >
> > To fix this case, we shall ensure vduse_msg is on send_list or recv_lis=
t
> > outside the msg_lock critical section.
> >
> > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> > v2:
> >  - Rewrite commit message.                        [Michael]
> >  - Add Fixes tag and cc stable email list.        [Eugenio]
> >  - Rewrite one comment.                           [Michael]
> >
> > v1: https://lkml.org/lkml/2026/1/30/323
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ae357d014564c..a70d0580d54e8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >         struct file *file =3D iocb->ki_filp;
> >         struct vduse_dev *dev =3D file->private_data;
> >         struct vduse_dev_msg *msg;
> > +       struct vduse_dev_request req;
> >         int size =3D sizeof(struct vduse_dev_request);
> >         ssize_t ret;
> >
> > @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >
> >                 ret =3D -EAGAIN;
> >                 if (file->f_flags & O_NONBLOCK)
> > -                       goto unlock;
> > +                       break;
> >
> >                 spin_unlock(&dev->msg_lock);
> >                 ret =3D wait_event_interruptible_exclusive(dev->waitq,
> > @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> >
> >                 spin_lock(&dev->msg_lock);
> >         }
> > +       if (!msg) {
> > +               spin_unlock(&dev->msg_lock);
> > +               return ret;
> > +       }
>
> Nit: this check seems to be redundant, I'd suggest to
>
> 1) move the spin_unlock() before the check of file->f_flags & O_NONBLOCK
> 2) then we can simply do "return ret" when it's a nonblocking read.

Makes sense. I'll make the change.

>
> > +
> > +       memcpy(&req, &msg->req, sizeof(req));
> > +       /*
> > +        * We must ensure vduse_msg is on send_list or recv_list before=
 unlock
> > +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout w=
hen we
> > +        * copy data to userspace, and will call list_del() for this ms=
g.
> > +        */
> > +       vduse_enqueue_msg(&dev->recv_list, msg);
> >         spin_unlock(&dev->msg_lock);
> > -       ret =3D copy_to_iter(&msg->req, size, to);
> > -       spin_lock(&dev->msg_lock);
> > +
> > +       ret =3D copy_to_iter(&req, size, to);
> >         if (ret !=3D size) {
> > +               spin_lock(&dev->msg_lock);
> > +               /* Roll back: move msg back to send_list if still pendi=
ng. */
> > +               msg =3D vduse_find_msg(&dev->recv_list, req.request_id)=
;
> > +               if (msg)
> > +                       vduse_enqueue_msg(&dev->send_list, msg);
> > +               spin_unlock(&dev->msg_lock);
> >                 ret =3D -EFAULT;
> > -               vduse_enqueue_msg(&dev->send_list, msg);
> > -               goto unlock;
> >         }
> > -       vduse_enqueue_msg(&dev->recv_list, msg);
> > -unlock:
> > -       spin_unlock(&dev->msg_lock);
> >
> >         return ret;
> >  }
> > --
> > 2.39.5
> >
>
> Thanks
>

Thanks,
Tianci


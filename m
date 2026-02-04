Return-Path: <stable+bounces-213342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE/FBT+5gmkaZQMAu9opvQ
	(envelope-from <stable+bounces-213342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:13:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA2E1316
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40F19305785E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20C2DF137;
	Wed,  4 Feb 2026 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZHj0PcQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3719285CA9
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174775; cv=pass; b=awBmJAQHzYWtSmi5Mh+bkfUealmWnixhSTZIWG2LAcvNnWWrpxsV1JFXcCOzoxr3g2sDGbav8eUfzCLekaqH8vrebQhCkwNYf4Rvc6ahbZ2y1B9SYSRy9gb4QICe23fPEEVtfGbBsgNCXnc+uGGV/cFD/S1nCp3bXmTkTd1bxCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174775; c=relaxed/simple;
	bh=tShlbJCcBqCuciT7fA7ChfjLfuZeg5HSJRumys940Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4eGJ4PPpH8e8x6tB8eZ+Yku/IwDZoowzv8FSt0GliL+cXadHy8weJcxENeEw1XZwMoVsq5QZTLHcAfZsbQOGRTMEViC5vRBffPvA32VR64TaK2qpqSib0mHI64o1fMlFFkOOvQz/fWR1aoRhR3HToVmZSRMOEhC9UgGoTvrmDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZHj0PcQD; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35305538592so5317011a91.0
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 19:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174771; cv=none;
        d=google.com; s=arc-20240605;
        b=dritKRzFO5QQyNSl8TBCAZMs5Z9WI/aaUQ9djDCHGrhU+2OKMV625BzCy894sWzt9Z
         W3/q0PDHOjRcy1son9w05TalxtEqI3sHVePZEDR+6hIQ1REV7lV+Sb+IOb725V2GXtYP
         Ff5nraFRsJbEhqzl/O0B+W69ahbsMv3xACtRMABcP/UwD3Zmf/OrggxvY2Y69HmpEpiH
         4EqnoN5YnIGnS48wpOgSeL1HYT+QSUzN2VfF3qSlvB2E4Qqr4HqehMi9fqyCsoQ+tJ1L
         MbsWMhLswU7XIlVE5vc/eyaolaNO9INbTErQPFKgmS4etSWj/ZOEPMD5dhUBpbKZkzF+
         4Q4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        fh=CfNDXxCr1MxcwKr2/uv0h4/TjKwFibpuMjHLfrlZJE8=;
        b=VEz2BouCCINDC5Ed2+OPySPYlj9IGY6IY6BQs4prUDG/GMtIJ7olnCvDJn/LhjTpQ9
         /qWXTlW5JVnB63O5mOH9QjXhPMNyxymbwrRjXe5S6u2zaIcYYUv2NDUDg27J8oUTd8Ac
         DTt2XEBmDcFJsH3mZVfPWMZgXYPe/G7fgpDiFHxvu6rJj4LnXzurvHYZpG3cII0XbRHI
         wdcEo2dd2FwINz1w+/20ej0KSZge/7L7Og3vz4SnZ1q4xSf99t8vRljuNP/Yv2LW62me
         9OjAkJ5CBtSKZNMXbePqn1usTcdFvdS3GFbvihxnZZ3ndXOAQdjOeAoUXijntOfKaXCP
         1q7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770174771; x=1770779571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        b=ZHj0PcQD+yq77rudKk32nblB7MzA6NLGo8NZQTaHlC5byF8WVpVpGVqMG4dPFEu7nO
         uWAW4sc2wtsb/GvkU7ZlzlloH3YTXCPE5ANOtiZDdjyoEmmkA/8MLQK+5pYpQUkvKfJP
         407DST3mBQWLmlNcajf75mRoUmJ5WNrjtj/T2lPWEQzfgs/tTHx4qY90vWZnbkg3xSFi
         BQUNH/eMXctWs+f5JX/LeUlf+WAsg7Sm6FlbbNcssEhEhUSnfkR5UK1JAV0WRaKhFmwO
         9aSRUzWctt3DWv6iGRSvwkGbVT0FY1BMBwpCUGGtV5Yrq+/aiJExh6OMQ/qGB/FhWd/0
         bBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174771; x=1770779571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        b=jhQlLjdN3o5p6yg1AxjRMno3xPkfFtQjrGTNRCuclQkExl9Ts1CX/Fxh+AI7qJuX9j
         xAhwpdp7xcXM1IuRn8mOUsbDXHNOYTelH4nAUpttzIHKIglRk8dIv0lCPPWBXYL1wksS
         CrtBDgGz+2YBB5goDUnwsowFcrpXqNQplc20rS1ZbX2o+69B6NPvLlOoQ3hKTWGaisy+
         wHwk83O1FgNdh4y0mArQg2nG2rQhtVVSFzINHrwyqwMyKZDocBHbHeL0HhWWkI4OLoIH
         8G7xzBRAU3/rZo59AfmA49eOaDJs4hpJ+MMnuA7uYeuiaV3riLtwFvV2BVwNX9LpjytH
         PdWw==
X-Forwarded-Encrypted: i=1; AJvYcCVanBo/7PobvsjP0FXrEM432bsSQqaFt7NvMH28k4xSpnTn/rHb+/xIHsHsp4jyEoPD6Fxhbqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+F3l/U3hlMayh8bR3TY7ILlWvbeogNb7BSpZ/GoBAwE4tDtBP
	52m4VFn73TmdUt9DcmquCw1lCxOjPLohbyaMEucr5oYk42sOfHTEKyGKu0IBSWGT9wD9gteksUu
	l+ausnfSRpvS0LJWX/+4McNw4ygsZeSOxr1dAg+4tBg==
X-Gm-Gg: AZuq6aJT4cG3RD1XEqVs+u/5LJMEYvxuRBtDO0dnK+mZ5dB62zuk6kcP5s96uJvxPQd
	Zu30G4Ol1pnPURuwugS2h7FTvJ+4u9t/58V90ps11QOh7ms8dALY4m1yBbrYuGw4MYCCjEB+mPe
	djI7FzdbKB3dxs96pXIVPOrKZBtBIK9FmNjcvmz+U+I9qP5if8rWh99759N8nUe8A5xJh0pCHul
	3eN9nYKcGMZ6+P3jrn+27XBTAiWtN8hYk2A384PtIuz+v+OrturFF6HpQ7qQXpDsYyAv5qv/nP7
	YG+nrvyyd/ts
X-Received: by 2002:a17:90b:264a:b0:352:cd8e:3ead with SMTP id
 98e67ed59e1d1-354870e626bmr1435325a91.10.1770174771203; Tue, 03 Feb 2026
 19:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
 <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com> <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
In-Reply-To: <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 4 Feb 2026 11:12:39 +0800
X-Gm-Features: AZwV_QjZ8_6OHPU9CpcTCSE3bVbgC-pg74TGqZJzN-isa3OOL6yW2dgzSXw-6S8
Message-ID: <CAP4dvsfz2PO+8J+DsXcOPGAoEiDciww=9Fp5=XeYtuauowMHbA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213342-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,lkml.org:url,bytedance.com:email,bytedance.com:dkim]
X-Rspamd-Queue-Id: AFAA2E1316
X-Rspamd-Action: no action

Hi, Jason,

On Tue, Feb 3, 2026 at 11:27=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Feb 3, 2026 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
> > >
> > > vduse_dev_read_iter():
> > >     lock(msg_lock);
> > >     dequeue_msg(send_list);
> > >     unlock(msg_lock);
> > > vduse_dev_msg_sync():
> > >     wait_timeout() finish
> > >     lock(msg_lock);
> > >     check msg->complete is false
> > >         list_del(msg);   <- double list_del() crash!
> > >
> > > To fix this case, we shall ensure vduse_msg is on send_list or recv_l=
ist
> > > outside the msg_lock critical section.
> > >
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspa=
ce")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > > v2:
> > >  - Rewrite commit message.                        [Michael]
> > >  - Add Fixes tag and cc stable email list.        [Eugenio]
> > >  - Rewrite one comment.                           [Michael]
> > >
> > > v1: https://lkml.org/lkml/2026/1/30/323
> > >
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++------=
--
> > >  1 file changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index ae357d014564c..a70d0580d54e8 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> > >         struct file *file =3D iocb->ki_filp;
> > >         struct vduse_dev *dev =3D file->private_data;
> > >         struct vduse_dev_msg *msg;
> > > +       struct vduse_dev_request req;
> > >         int size =3D sizeof(struct vduse_dev_request);
> > >         ssize_t ret;
> > >
> > > @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> > >
> > >                 ret =3D -EAGAIN;
> > >                 if (file->f_flags & O_NONBLOCK)
> > > -                       goto unlock;
> > > +                       break;
> > >
> > >                 spin_unlock(&dev->msg_lock);
> > >                 ret =3D wait_event_interruptible_exclusive(dev->waitq=
,
> > > @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb=
 *iocb, struct iov_iter *to)
> > >
> > >                 spin_lock(&dev->msg_lock);
> > >         }
> > > +       if (!msg) {
> > > +               spin_unlock(&dev->msg_lock);
> > > +               return ret;
> > > +       }
> >
> > Nit: this check seems to be redundant, I'd suggest to
> >
> > 1) move the spin_unlock() before the check of file->f_flags & O_NONBLOC=
K
> > 2) then we can simply do "return ret" when it's a nonblocking read.
> >
> > > +
> > > +       memcpy(&req, &msg->req, sizeof(req));
> > > +       /*
> > > +        * We must ensure vduse_msg is on send_list or recv_list befo=
re unlock
> > > +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout=
 when we
> > > +        * copy data to userspace, and will call list_del() for this =
msg.
> > > +        */
> > > +       vduse_enqueue_msg(&dev->recv_list, msg);
> > >         spin_unlock(&dev->msg_lock);
> > > -       ret =3D copy_to_iter(&msg->req, size, to);
> > > -       spin_lock(&dev->msg_lock);
> > > +
> > > +       ret =3D copy_to_iter(&req, size, to);
> > >         if (ret !=3D size) {
>
> Btw, I would like to explain why it's still safe if a (malicious)
> userspace writes in this window in either commit log or here.

Do you mean we should document in a comment here why the potential read/wri=
te
race is safe?

Thanks,
Tianci


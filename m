Return-Path: <stable+bounces-213163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBvOLF1rgWmwGAMAu9opvQ
	(envelope-from <stable+bounces-213163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:28:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46CD41F2
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550143051C8B
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 03:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B290321F54;
	Tue,  3 Feb 2026 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5jhRDzu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="owg/QCAJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C622F290E
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089255; cv=pass; b=Rz1PuVGu89iv4T1N0B08+x37mAh0CcPCyIz95teYb7YN5HiA9I8Qr5/g1i6RvZbiTQtzZkEpTDk/dZncbgIVCyUZFhvAUhaB8xTAWK5mQ1meMjt0mcJ20vVhf6hI39pzcscrccpg1CeMFMUGgRGTb6p7IHHgDYsas6DvKk9oPRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089255; c=relaxed/simple;
	bh=bqV1HCkMw7DPpKkuYjfIWhuCizBWLcm2EGFb73XZkxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ6jEst333o+CWouA41fs//CZ5XvMOk6KS68z0VbBztK+sUnID+etksFfhdE2uHHJafTPdR/E/2573jRRQDpFUqG473enV1CJUdQlEteES/wIGGm8TnnUnhW2dU0tvwdZQS6snoBFvrkJBFzah6GvquZ3fGd+ly2wVsP0jxFC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5jhRDzu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=owg/QCAJ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770089252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
	b=i5jhRDzu2UQBBVF2OJtlZr6ORftM3r3BtcYn9p+8kXY6NOVlBP19508q5TCEETFbEh8vZu
	+JeXaJrdcX1jV4D/9n+NyrFCovt7tPNrWQ0InPt+/NHThFQXHB9zUs6lLPXq1zFWmnljAc
	VZdsR+S7AGwhDI6u8OGtvWKaNWA3K+Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-ef1K4oT0MaGSCYVcnahC8g-1; Mon, 02 Feb 2026 22:27:29 -0500
X-MC-Unique: ef1K4oT0MaGSCYVcnahC8g-1
X-Mimecast-MFC-AGG-ID: ef1K4oT0MaGSCYVcnahC8g_1770089248
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so3937438a91.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 19:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770089248; cv=none;
        d=google.com; s=arc-20240605;
        b=QnJ9oAb8LGp281NJ+TXUcsmjcIoCVMeh9vgiGHMABNm4Un3nA5euZwq9aGtisK6vEa
         CwU6UUznj1OEswxFFtdjObvhj9vJBCWoxPb12+us24T2tetz5uBTWPcdGhE7L2V8SZ25
         PZHzGHhkki4en907FcGVGaXw401kRWAKzxhw3OAccJ3rtSD+tTOZ0VhYFlEQ+jhj99Sq
         C2aAsc88bTPwYqa5aXGeXYAb0OBpAw6eMbFtY0gl/X2j3WYOsuee3GZEEA6XS2FeBDTj
         QDtCcHJraiMZ+WexcVCd6k5i2f8jSq5ZgzXEgoDjmHAfLxzU+JvxOBlogqYpnHroJn4O
         nEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
        fh=EfiW4rsLHQZ05GJUP+3fZDZYTjDuwd4ToH3cDughbKY=;
        b=IMf41at6Bz428r9orPiEr2Rv94uNTs+G5q/yz8siFX3Rc0BJAdx0QrBWlAfrjSYUHV
         COFplF0hLEJBZmlA7c+IiZT3Psx5vkTdZ0pmPcvIZIN3JIdshp21fehNOUX5t+k0hYVK
         rfGnNZ3Tyxp1QEj2Y7R7yeDDqKc00uVfp6EyMvJhGEaLxO4HU9sZVLm6Fc1DuqKYrtn2
         xGLouhMXOKHWQZvEWAFDj2dFkEk4GPNAkP7GIyMSA9gDUUprgtA43dRWfSdHsPoJczn4
         +eqJAUE+fRIMVmHJU+H6mpCA+j1IfoS0R6GDs+jH7297Xo0twpbKvGRIaRvsxN6utpvR
         uFew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770089248; x=1770694048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
        b=owg/QCAJT56f9La4qbj3B7Jq7gPP2lA7eQrNoNtbnUPaasV9lwjJu/nwiQ6cd9eMrY
         xXxxFNm3wyzV3AC33/wLMTh3uZxThgx2yNuCRbep8EowiC9T/yyF79DRLlTOwnGbCUUK
         sV0ScjrR67KjW3XZxi/LOwP9tJ/mmv/9a8V/2xSnc8Zw6bJfGj/t2HNBNZiv2aozrqu8
         Gafv+zIlg8ZXUBetRGbbRNXXCS7g97JbbDznwbDV6LcBocVUHgjDUbbRrCDxIk9ScNie
         a/HTYO63JrQbtd8fqFGHpIlL5hF4DhLLJOtZSWBxcKJIafMBfWQVFH2tOLje0aQ7u55H
         56Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089248; x=1770694048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
        b=aSP0/57vuinKPJFUtgI60oQfBv/SH6ZqtseIAVFoAG6W+jFg4a5HiEZ6FAKVWLgm7j
         rWqrALyVUsJT2lNepyw9xFBqRMv+SDLLkT7xcVvxGA00DRJuvsiuR6PK392tfqgpU8/W
         FoyxD7WBtFGi3637JkfPVPHvcbQHfDXVhIZeAilhBkpyCPsYyjpPF5ErhA8XYAzhG+d6
         Lo3L9cWv2bcKh+Rr7yesIteT1+BdtC40AmGy4hwYkelHb4PkR0W+LQM3f5NL+l7dOcqg
         VsovdCa9OcuQf27v5yNySDNY2Yn/2PJ6b+Pont3+CJmtI6zW2DWxsKAQIXHaEWTYC4W3
         hdVg==
X-Forwarded-Encrypted: i=1; AJvYcCVG/MFlQYs5tpml70wgrp4xV7phCNnpSxH4JwFlgoASPzhA01uHww3QbA+UMt32wZGp4zd1R9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXIsoPBLCic/+sM+42fCYDkagm9RMM7Eknyyh/C2oYbDgT41O
	BMgUMpjVW4xBfxaKRHYANbCmJcMGWdMc3oAYa0IH7rFrsNG9rXNtKVwnXZNIhMxeMTk4ZZlOjSI
	2yS9aD+YljtCqLoiOCBH/uxo5xin4DWj5x6wiXxbhmBEtWwV0e4OjpqkUjDtvNtN17EnxP3Ggbi
	3y75AgjsjEfXKGHeOKdwg3NMHZ3IuD9jf6
X-Gm-Gg: AZuq6aITLdmGtQm3aiLt17mcfv3aJgPnu1CbaT5Sqf6b5i4ndoe7C8zSoKwb03oW9/r
	zjeen3z1mQIP315Pm2TwiOsMBFpxRW6iDKS2fvd6uewUBRF0b+lxBu5CvJ0werv8eao1zL0a6Lz
	gSHAlTeDlSfbz93BiLR8BsOOcuum8nKa3g6AA54HblO2g8EOZSVuafGLgtKlz4n/O64xk=
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-3543b2ebe3fmr15675336a91.6.1770089248481;
        Mon, 02 Feb 2026 19:27:28 -0800 (PST)
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3543b2ebe3fmr15675320a91.6.1770089248079; Mon, 02 Feb 2026
 19:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com> <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
In-Reply-To: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:27:17 +0800
X-Gm-Features: AZwV_QiKKY-5UkTSgbJkQAvhtHyGWUXcQKc1MXlJ_r2iGovgZKzRic-YeJ64iDg
Message-ID: <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213163-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,lkml.org:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F46CD41F2
X-Rspamd-Action: no action

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

Btw, I would like to explain why it's still safe if a (malicious)
userspace writes in this window in either commit log or here.

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

Thanks



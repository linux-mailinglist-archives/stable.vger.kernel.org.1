Return-Path: <stable+bounces-213161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP4iH1VqgWmwGAMAu9opvQ
	(envelope-from <stable+bounces-213161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:24:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BBD416B
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A929305022B
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BF31CA6A;
	Tue,  3 Feb 2026 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwZJwF/8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+XPtfnF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746481F0995
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088998; cv=pass; b=XpZ9C1Y8UoI92BUrBbew40Jk3jLPO2jnuCRhryFnmrxnD+2/S6ycNHtP0ktksm69jv0NgEf+kmjn9+DGvdHYKclW5e8OU/GXLSxGR4asU1fU2iS21kREgN57DaXi7mvue7rLqFlgp8xbMWR1YS7CO6xE9L3Yw/Q0+/9vcjHjN7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088998; c=relaxed/simple;
	bh=KrtGgk294GRjBEs6iQyOp5BKbLlkhgJGu4IdQFjdyrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEVceKOt1PY5rZcPxndty1w6HKj556ROiM0xDFmruTUv57ScZZ/pUOrtJOpeJJOJ0j6vMR7xZFGBE0jOWpiVlm0/EOl2I9CnivjcaAD+gaBvbUP5uWfqj7zQOxl9sOEZhsQChPt4h76j+l4QdId7FkFJ72r5sqUzyC/Py6FU0Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwZJwF/8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+XPtfnF; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770088995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
	b=IwZJwF/8qWtw7yKB0UdLXpeeX57KCcsb6JeTR0Qh/HE8lxwA4rg8L4rce+3jMiZz8gnN8A
	AHIAWL5Si+ECSS1hlc18Sw7g5y8PUi8DsSkKY15I6xTTqYUvu8DaNQDStqvN2q84xp6MFf
	HJQ2D165enoRJFokPCiD0b9gEI9fKqQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Wye-BWMuNpeIR2Ob9wxuww-1; Mon, 02 Feb 2026 22:23:14 -0500
X-MC-Unique: Wye-BWMuNpeIR2Ob9wxuww-1
X-Mimecast-MFC-AGG-ID: Wye-BWMuNpeIR2Ob9wxuww_1770088993
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f47c0e60so9274165ad.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 19:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770088993; cv=none;
        d=google.com; s=arc-20240605;
        b=XsBMb8nVwZ4NogNpyV2+0N22+n1E/fhVpjWCQXNrseqLwcT70Au6pW28hlo/gkidWV
         m0l+baTyaJsQyTAbEP+VL/UhV73jekdPsV/XMHUesjkzyvds4E7bUjCWrRqDEf0TiuWO
         awQNjDql89zmkblni4/j9rc+hjRMk/BN91pM4BT7oVTIxsNhwLYMMchbqC6cDwAk2gI4
         +j0gkFr3b6QJGSqS8NAOFnqOxeF5AiiLSIRBmuXegwhYfV657n8OszrIyXVA3vfDXgV6
         DEODiYUWtqWcZxh821OxygiFDTEDZIlEKerHkzduIeviKGmDNtYbKs2AeXV4yO8FU5Aj
         7jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
        fh=dDVk8YJg1r99SrnclgINI0D3V+lIGlZ8Y3a5cTP+F2I=;
        b=kjhROLRfV1zR3mbfDbRmN5EEVPlqdpATy/7EyG+EBZ2YVRjaiKCxWP7XMu1wc/HtCf
         JEU/13PgYwe103LGntBqn4m5sHNxlAq9CWoKtZ13ym0GsUWYxg5BzkaVwWdw+d13CDrw
         atauwE16LCGz5psOP583dxKhlAraM05bXMY7Zhlce/yz00Jji3Q71mv3SVh4IAiaU3Gw
         TvmAC31kg3bwuM9lx5yvre63JINtaJBxM7OE+s6nRUvauciZYvVB1YppXme8y8uI5CKY
         x7JYetEVZNavQ8JgqHYkaC1aVT4XidrQQ1Nl1/7qO8uhbrPmPjRmvYDJZKcxpLtBV42E
         hCFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770088993; x=1770693793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
        b=F+XPtfnFEPiAtLUOeFjcJm5aOGyEN3ETvJNsoqO5IxkuylYFtMEE3kba96qVoaQfak
         1/fnmMu/qtFjp3V5coYCpELXNauKraB85tU4krN1rharJ5pZ2WERkboTbi5BjD8BuRZ5
         i8QukhcL14jlgKxy5pylbULlKjpG+skhllxfm6Sw3gWyN1vTUvKghFO/Rk+OzcraKg0M
         wTjlXR+1gpI9eYNM1zkYT0dp+xHrtdej3/vgHyW67j8sZI4vZhoLafJY5DxdKRQcNmzP
         FGccmImA51USSnFZtVh5i7aW2OzrZWtKZIDecR8dmK/DuCq0aE9MmBkQCvrukeWF7fkh
         2asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770088993; x=1770693793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
        b=SDEgDenO2T9qknrSLWDzt5FVYdcBiHEgOPjZrtn6GeQz1y3HTYQwjMsyB5ISDLsp7P
         HYl0UW0HcE6bQWETXyBtGQxM01ScUGYoK8umecA6GjgcrfGYvIqOyRsVrea02Qmm/Kne
         e7bFtFvGVJEytvJyGpJ32w9eKQKJhwZ9yTpBN2nxciVp6tDmBxuZEwx7ABcxqeeRpgzJ
         ZIcehnKZihlFrnoLX7L0EzWGHwzRsiEqqPYU19SK/ZuKCiBpyYLVdmhVID7UNn82s3hB
         CLfqc92NaqZAyn28RtDw0LJ9CJjTC8BiUoQJGaaTjH53hIPjt0ZnAMw7w6lgWzlFgIw8
         Lo9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9mNX7b8FJDe5TXkmrHxpRPUPpxVrlgGdHmMS1mYT7itiMpx+UcIO2FXiJM5WbSi7xZjUo8hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/631wbamHlmP2s5XJSXTuV0ZmtbnDMj2tcIE8wKEkRMirNRMT
	B0NaCp/vLxXAnyBqYE+vTuD1S0FjfdjITUf+uFQjDcfzFM5z/i97+9tPudDg+EzmqJ89TRQqxZP
	+b/op+ewhNyLmdy4mw2g+8RFneEsZxI/rzYUUB6fH+c37p//QBjLM4oB4ugNxkDBrblD9kn9O2H
	qmZeapqT4SNR/jmfese71s6cmsWJbhCQe2
X-Gm-Gg: AZuq6aK36WqTGbTufAiDramzi8UWTHHylQdqYrfnQ+JNYnZ9MelGimKhFLk29DQGkJh
	AgkTYdUY7p5EjrBfsDd5Z1kzFcuAZ+Afw7DrRsuZd/Uj54c+vGh1hOOfTMEPSOX0p3Cl8/Tc7kW
	TuZffPPidaogJux91+qlPZR6E74k++KMFPKhaqm8e6VXzKAt3dsuMJOITyRD9AonLHXnI=
X-Received: by 2002:a17:903:2b0c:b0:295:8c51:64ff with SMTP id d9443c01a7336-2a8d9919237mr141235205ad.29.1770088993352;
        Mon, 02 Feb 2026 19:23:13 -0800 (PST)
X-Received: by 2002:a17:903:2b0c:b0:295:8c51:64ff with SMTP id
 d9443c01a7336-2a8d9919237mr141234955ad.29.1770088992952; Mon, 02 Feb 2026
 19:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:23:01 +0800
X-Gm-Features: AZwV_QiXK5cVba8qXcynunVqAEqDCvgPd9117zHmBgehD1PDOxYKFN17tYOeGKo
Message-ID: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213161-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1D8BBD416B
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
>
> vduse_dev_read_iter():
>     lock(msg_lock);
>     dequeue_msg(send_list);
>     unlock(msg_lock);
> vduse_dev_msg_sync():
>     wait_timeout() finish
>     lock(msg_lock);
>     check msg->complete is false
>         list_del(msg);   <- double list_del() crash!
>
> To fix this case, we shall ensure vduse_msg is on send_list or recv_list
> outside the msg_lock critical section.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---
> v2:
>  - Rewrite commit message.                        [Michael]
>  - Add Fixes tag and cc stable email list.        [Eugenio]
>  - Rewrite one comment.                           [Michael]
>
> v1: https://lkml.org/lkml/2026/1/30/323
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index ae357d014564c..a70d0580d54e8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
>         struct file *file =3D iocb->ki_filp;
>         struct vduse_dev *dev =3D file->private_data;
>         struct vduse_dev_msg *msg;
> +       struct vduse_dev_request req;
>         int size =3D sizeof(struct vduse_dev_request);
>         ssize_t ret;
>
> @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
>
>                 ret =3D -EAGAIN;
>                 if (file->f_flags & O_NONBLOCK)
> -                       goto unlock;
> +                       break;
>
>                 spin_unlock(&dev->msg_lock);
>                 ret =3D wait_event_interruptible_exclusive(dev->waitq,
> @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
>
>                 spin_lock(&dev->msg_lock);
>         }
> +       if (!msg) {
> +               spin_unlock(&dev->msg_lock);
> +               return ret;
> +       }

Nit: this check seems to be redundant, I'd suggest to

1) move the spin_unlock() before the check of file->f_flags & O_NONBLOCK
2) then we can simply do "return ret" when it's a nonblocking read.

> +
> +       memcpy(&req, &msg->req, sizeof(req));
> +       /*
> +        * We must ensure vduse_msg is on send_list or recv_list before u=
nlock
> +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout whe=
n we
> +        * copy data to userspace, and will call list_del() for this msg.
> +        */
> +       vduse_enqueue_msg(&dev->recv_list, msg);
>         spin_unlock(&dev->msg_lock);
> -       ret =3D copy_to_iter(&msg->req, size, to);
> -       spin_lock(&dev->msg_lock);
> +
> +       ret =3D copy_to_iter(&req, size, to);
>         if (ret !=3D size) {
> +               spin_lock(&dev->msg_lock);
> +               /* Roll back: move msg back to send_list if still pending=
. */
> +               msg =3D vduse_find_msg(&dev->recv_list, req.request_id);
> +               if (msg)
> +                       vduse_enqueue_msg(&dev->send_list, msg);
> +               spin_unlock(&dev->msg_lock);
>                 ret =3D -EFAULT;
> -               vduse_enqueue_msg(&dev->send_list, msg);
> -               goto unlock;
>         }
> -       vduse_enqueue_msg(&dev->recv_list, msg);
> -unlock:
> -       spin_unlock(&dev->msg_lock);
>
>         return ret;
>  }
> --
> 2.39.5
>

Thanks



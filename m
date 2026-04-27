Return-Path: <stable+bounces-241209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IebIUvj7mkdzQAAu9opvQ
	(envelope-from <stable+bounces-241209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:17:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DD46CFE1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7056300E612
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 04:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFE28030E;
	Mon, 27 Apr 2026 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr2R/mF1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzArD5lU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B259226CF6
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263426; cv=pass; b=KdzFVhEnF50FXUvTMSZer3KCsLMjLA1/p00tjHJiN5zdebAnKJ1CB2c8k+UxJ5/Wb4mDSQsmI0Ht+YWjMygSI+GBq7nTI52ygOvPtI74kKBe8FJ6omGSJJmBYxm30UMkXiYHMM1vRTbGv+zkPYSf0asdvkZXVtK+O8FCxuHrxu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263426; c=relaxed/simple;
	bh=KRQmkVM65Q1840oxn8DuHujVjwJvPzfBblnZbPxTSFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgcg5BP/ZHbh0iZsrRe3xL8QReSUx1lJf4UH+HYp9KU1ZEht9B+41hES9Ok+M+74Rq6altfAqWB7iADH9TPThK8oam/pVuZlY669sCNWt2Uz0iIE2PU0NeUEI1/+it8Ha4ojsdxegnTSX9hjXir81ZbDAC2r6GjNSB3jCgKJsD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cr2R/mF1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzArD5lU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777263423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
	b=cr2R/mF1/h866dvZY5ooW76LIy+9JKw/EoTtxiX7dPv2dDb5ei+6g8zBt5LWlFnzIjrqW1
	Z1YTjuGRsxzs0BrB4gTgwhpPtl2zekWSVbBqrkHHedNH8FcKJ13MiaPxfzrr/uzVWG+xwC
	gVLLf3cEfLnLAo9wjqGncIA+0jt7Y3o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-1M22KCO_PqWcjUugfnVuaA-1; Mon, 27 Apr 2026 00:17:01 -0400
X-MC-Unique: 1M22KCO_PqWcjUugfnVuaA-1
X-Mimecast-MFC-AGG-ID: 1M22KCO_PqWcjUugfnVuaA_1777263420
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so88607795ad.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 21:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777263420; cv=none;
        d=google.com; s=arc-20240605;
        b=BhPVdebzlgDN+Nmwa88PlXaxUnZDZng1aQ08YZ7vY76vGdve6xjNU/kvzKQVhMPVF4
         3GLBlYOrBx0rO67NXhJU7ipXLlYAT01ovy1keFNsJM1gNnNxt8FsY+pO2BHOdRyaZxqU
         rObd0KWpajTclOrzS/jr1St4nJfXOyejvXX5SXyyJ2QJl93RU4yeHccL+L0WTfHUIfL8
         t0p+xooWvLBy1Hm5zyIsIUj7isiH/73n6gdW4hoLORS4fGADXFY/pc9uN0UYi1yvTL4S
         +RFH2i6KdEpxqAYzLQvIN4bE9PRN+KggB3rN+QqwykRH+Dh56IIaEdpt2nc8ZsLCbKKU
         DdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
        fh=nH1NEpM7qhdqAe3+qPNSn8Syc6Rg7T/eJruiHDk3s0c=;
        b=ihQbjfIi5Sp+zgAaqcupa2DEUb6pwuaaMnjZAS5dn+HooOk3JhRaUJDwgtnsssR+aO
         mp+msVQCyULRioFyCZSxybn639UTEZA26JPaX59SoCyFqjz2w7b2hjYxxEYcH6SSEI7Z
         xmhd7nz5lppL9AVjKvMbrJXEFJ3tkiRpp1f38km98DzFh1/vhg1WrMTuQUP7i1pOJTVi
         6mREr2QdmXF8W4Q796o6ASvzenCwxtyxV/tHVaWtLN3pBFI/iecuo0dy3g1/bg18t4cn
         MBkx39Z6eV3cE5PSqk0JUi8+gX6Efytr5GYM65ubL4qz6slskz3DPKSwauBFszVRzirb
         nKUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777263420; x=1777868220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
        b=FzArD5lUEOBjepWXwdAJ37PKKA51EwiXYuNTPf8Zd3DLVAdA2euI/nnZcGYpuNaHnw
         5eOiQr9zrUMZEn+elHkkSg02OnlZXozpzEPP9sYiUDFVih4EAfoW5mAz/H3aIy87n2Qw
         WoNvsJ1xWNVKgwRhtNwr11MWiKBsLep0ykehPIj0EGdeTA4vbQq1LFjyUEXggtF3noc2
         7MwEKT+QllnAuc+JA76b/sl4pGI/4qhrcW2/cuIlSlpa8Nwi7K8hFdHEwodnvkyRnrl4
         tJXxfgClznkPFWzhN2DjP/ljBGqeaCoDZLhcDSBJX2hM/gDR8ure5FDmVM/L09ZmFBef
         L5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777263420; x=1777868220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
        b=iFZ6TsY2xm4mYscDFWQK+q7MWmrnHYQePrqkrjgeWbpFlGgXvx8wgMnDr8yMSTkadQ
         opl27+Zu2jEI/DCXkSjDNb2o1C67BJbdbL7O98mrXYPtiJeJQMzgXHyKIYkL4w3ykS3D
         cwb3a/maDtZQvlQrlom/S7AHdBpEVezJ2Jxx5YfBHCkVjnWTLjM4eaUA1JKzfCGATh2s
         DMADymh2vLO9JgpMSzZbXOynZnW/GYiTMijCejPbnOuQ9hTk0xz95qcOfssiX0r8RS9H
         VPkkGagIcGUvWn5Uh5jYjuI/mQ8F8y8R7i2jya+DY+cpbv4WcIHAZRknM/mao6Vv0ZCZ
         UvTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OVYFCCoK/nqscAar3xFSGAMYA5zauMVbleendB39tfMUeqNIBlMHW+OGQFrtMpu+JZdXUy+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hJ6LEc+NKmY/c8BDUFu+4ESvdeN2AuPcDud+p+YW99CN4Phy
	beyFUovTbtL75WRkjBHZXn1fJ3cL4TmX5L4+DUrmaAXRa7ethTp4h2rTw+tXxBl/nOxSzPAFlhI
	YOv386PwJAGPq9bN09wazUEaqTOQaZa0sdB++vZStyft4nBNfIe13xfoP8uyCGZL6KPtgTyPHOA
	6VdntLxA6N2E1UsPP8UVZ7c31cApZaTBkW
X-Gm-Gg: AeBDieujYsNxsaSxzAtDJcMmiZuG/izXewl6CfbFlyWeHeX9cRR7OcMQNFTHQaGU1ZG
	wXlFt84/DkNcvSUEt/AWRMsatrQ3MBFfx6nWZc65S3o8bWSx+2joDEEWR3uzt6doOYxmAk3Rt1u
	SLXvPyPA3Zd+I+ec7/cSq9yTBwaVU/ADx7xND/gw272S0eGiNbrN6pmi2ECbdNi67vtKTxqxJOW
	sxbO4BzDMG5SyRMrg==
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b5f9ea4989mr414325795ad.10.1777263420247;
        Sun, 26 Apr 2026 21:17:00 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id
 d9443c01a7336-2b5f9ea4989mr414325525ad.10.1777263419737; Sun, 26 Apr 2026
 21:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424104820.2619227-1-johan@kernel.org>
In-Reply-To: <20260424104820.2619227-1-johan@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Apr 2026 12:16:47 +0800
X-Gm-Features: AQROBzDo3K7FC_rCt0vVXYTIfOgarpjIs4uJ_FH9j5Yq_1TWlvoxBmscBnVoKng
Message-ID: <CACGkMEvJ4CZt9mVhn5TRCz5yCYzY_yHNFh8pbT4hOmJoWDiKOA@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: fix device release warning on module unload
To: Johan Hovold <johan@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Pawel Moll <pawel.moll@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 499DD46CFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241209-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 6:48=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Driver core expects devices to be allocated dynamically and complains
> loudly when a device that lacks a release function is freed.
>
> Use __root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Note that root_device_register(), which also creates a link to the
> module, cannot be used as the device is registered when parsing the
> module parameters which happens before the module kobject has been set
> up.
>
> Fixes: 81a054ce0b46 ("virtio-mmio: Devices parameter parsing")
> Cc: stable@vger.kernel.org      # 3.5
> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/virtio/virtio_mmio.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 595c2274fbb5..1b580de81e82 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -662,9 +662,7 @@ static void virtio_mmio_remove(struct platform_device=
 *pdev)
>
>  #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
>
> -static struct device vm_cmdline_parent =3D {
> -       .init_name =3D "virtio-mmio-cmdline",
> -};
> +static struct device *vm_cmdline_parent;

vm_cmdline_get() is the .get callback for the device module parameter.
It is invoked when userspace reads
/sys/module/virtio_mmio/parameters/device. This function uses
vm_cmdline_parent unconditionally, without checking whether the device
has been registered. This would cause NULL pointer dereference.

Thanks



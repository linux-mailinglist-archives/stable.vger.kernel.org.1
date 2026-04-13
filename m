Return-Path: <stable+bounces-235974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJiiJuW03GlVVgkAu9opvQ
	(envelope-from <stable+bounces-235974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:18:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600B3E9B9F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 731843006036
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715553B27D7;
	Mon, 13 Apr 2026 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxf+DiRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B03A16BD
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071900; cv=none; b=aaFlVheHLLV5fskQJzvFjlrju4aVF4i/9yuuEF5+EUhcbc/oGU0F83T0RheUC41S26TCqKuG0FsE8AAdc0asj1TfT7WN6ejhDdO4uqTBN7CLe1ePcXIJ2UjY7QDv+0/vC0lnbaMbfuWQwHtUspDE3wM5lwp4/Oo2FhTcfiwvkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071900; c=relaxed/simple;
	bh=uDVsXuAgOukhJvoFEJaLM04wN34waooFTfCn+0aeSUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuaIYjTUo0SAtMjO1b6ycJGqfb+Im7FIyg3Scl1scN2Nmgi6Ixli7QM6Kj3q64n43YmYyYTO+DxnSsuTFvaoCvRi5sWryEdCjvHPbz4VllF+oT8r4HSGxQi7055/KdgKRRMTbYtehx8WIDuqHYexb0jJcbRacwqXuKqZOBu9BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxf+DiRd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73422431so813102f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071895; x=1776676695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIAN/FrHU6F27zvsbKpZ8LqpxugufEWgzIK9oqXBU9c=;
        b=bxf+DiRdsBnE8lrcOETDBA0d9PpTSOeH5cCnZTcPhbNxvewqVwmLy/NkMfWkfl3pxC
         Pj2eTYiKoiaZsD9nI1gM6oB/+n/r0FhM+GiBPplTXbtP+R3iZSZ3FtZ+buw47FYlNKri
         R1hF0nLW6ee/GLog4llrfU2VJ91P3We8dZj8jU4TaDGa6Ecwv3omfOv70Sr9SCzHIsPU
         uojPtFOdLs9s+pRzbkKUhtSIuXXJyogdeMmbrCQUXykDWB9O4dBkLv/LyXW717tVNJC2
         A7r5n4mEwmreV4FPzvGoFHoWrKwfjFwe8dQRRZPpqfEzNMD3f599u/kLNNSMIWYQiGEH
         ThEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071895; x=1776676695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIAN/FrHU6F27zvsbKpZ8LqpxugufEWgzIK9oqXBU9c=;
        b=mQ2E2CGP8M+WMOA475G6thh/Ity8BBI26DA6cdDpjpNfyDPbkU+Gn43hUBg5eTe6QJ
         OIhF6FpJeZHTWe3O0sSSH/EIonZEri8xh4QAhJ51GFs6sQ665LZrohMCLv+3HVisM2yb
         AadTCjPdbCfkmGwy1UJvRSsvJvCRZDxU7zQ0hxaCtPvETYInURTZAgLS6elnMpN9LXHv
         LrQwuJ0Xc3tVKfOKPM1M+3weDqyNOB1tI9i9hYPAmiCH4WCJ9xzL3rIecs7SToQ0yf2r
         BODxuGTekjH6DjV7K9FCWtEa9zMrus327iGPck4svKFPpJqDhLeOVdPuHII0rBAcbrWK
         zuPg==
X-Forwarded-Encrypted: i=1; AFNElJ9wcY/0XRk2aJAW5hwEZstUsYse2ux3lKvb5uefQlAetc9RYXWYqbubcBF/OcUfCDLwIA6Rp9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxOyXZ39QrmUKal1792uTzps8pVhZfrzrRsAkCpVD6Nmb8gl3
	GZjXoQ8CO+YbKuuWtfbRv5DPZgEXfMlgYUgsRHGkBICSR7TkIgOSGtg6Ua8VV7dX
X-Gm-Gg: AeBDies1fpKbLNQzvjmE6rdS/UNMtznTMlGDu1OT8hxztVWAe9VCI2KcZnoX9lWt3ii
	gd9qM35NYAr4i2dunPHqvT8YcaEkTNDytcp5n0vW00HRBbJtRVHJewukPs30rh0DFnntlprGCGs
	SvexoW6sIFYrGTl3HKWRpNd2ylwBrjkJ78ubq41suGVdjCTcpGuZi6RmLXGDVCqzs336WsFsQj4
	pwlJYhq5U4Ix0lg+9YT4jl/BuPJlO1h9zr/ulZ7/2faSOatvrh5iuE9+dZeNh5H206UfXt3FJJy
	VurxZIOsFdEdS0fuyic8ETbkbI3aTEXkvphvaOWUwMwyFbP4bwmqW0aoBecC8d6yTrIMMSiXZYV
	I4F+0WV/+YlbgXUx/5BGGWxdACpTM7dn2yULCuk42zvkJzxkkx5dF21GA0g9Q9M6rHJ47T0ErJ3
	tzc6TJuPmLs0zS0oLDHZLtWtvEh2ocYyRzsZwWxwF0Q3IoAEZJaF2H8w9WPm4YCaMx
X-Received: by 2002:a5d:64c3:0:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-43d642da7aamr17575085f8f.24.1776071895213;
        Mon, 13 Apr 2026 02:18:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7b219576sm4172172f8f.19.2026.04.13.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:18:11 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:17:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with
 spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Message-ID: <20260413101759.6323fb68@pumpkin>
In-Reply-To: <20260413034046-mutt-send-email-mst@kernel.org>
References: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
	<20260413034046-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235974-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9600B3E9B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 03:45:20 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 13, 2026 at 03:22:49PM +0800, Jinhui Guo wrote:
> > virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
> > which disables interrupts.  Using GFP_KERNEL inside this critical section
> > is unsafe because kmalloc() may sleep, leading to potential deadlocks or
> > scheduling violations.
> > 
> > Switch to GFP_ATOMIC to ensure the allocation is non-blocking.
> > 
> > Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 6d8ae2a6a8ca..db8e4f88b749 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> >  		return -EIO;
> >  
> >  	spin_lock_irqsave(&admin_vq->lock, flags);
> > -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> > +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
> >  	if (ret < 0) {
> >  		if (ret == -ENOSPC) {
> >  			spin_unlock_irqrestore(&admin_vq->lock, flags);  
> 
> 
> GFP_ATOMIC allocations can and will fail. If using them, one must
> retry, not just propagate failures.
> Or just switch admin_vq->lock to a mutex?

Or do the allocate before acquiring the lock (and free it not used
in the error path).

	David

> 
> 
> > -- 
> > 2.20.1  
> 
> 



Return-Path: <stable+bounces-203163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1BCD40B6
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 14:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0D793004F13
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5A283FD6;
	Sun, 21 Dec 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7pM1cfj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu0gqx/v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868842376FD
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766324581; cv=none; b=Bg1uckjb88r91ORJdwa+ecGDcMEPBD/+EnynVTXAZz5Se73SempHlK25VI9EBwjfw3btrbS64ZM3RGnr8jCHWZvImgnr+aHSC9+mjq4yb7aA1PO+rYhMPg5zyvT2rDLW4Z0o+r+DhWJfPWht3cfNSsua+zg7fLNnND3eZLlTFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766324581; c=relaxed/simple;
	bh=g1OpVRc/favQfUiIRE8TO5sJVwwB3PHfeg+/jvw5UK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbp21hdB6r94q95YaiauIvRMNR5ZPREdRGmzk/0D2M/+auKDDShoNdpPZZPK+5+whSgFxNqzWW9bdUhQbTPbWj20P2UNZxZOnY2/wguPMotlKgcR67crmhBlncDFxl0bdj1nH+GlaopgPrQSL4sf1LUreTGybfoEqrR0/dFB9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7pM1cfj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lu0gqx/v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766324578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL1YiW+qcmDAfO6Y9bCrMUIb9gMq0TIVlGP94jNrCWo=;
	b=H7pM1cfj2qPLFDQxs2U3GSn+w7NTQBVSpWRK7L8dDRDMXmAmh3AvQzK+MPP9zMqms0qzTJ
	R3LcnWv7oPVi8lnuMXOw1gTR8CitBYLcJcMaXcr2x0aDG3RX9GdOecMXyjnUGe+ATuspvp
	zJNTpMDslqxtMyG4J00By/ZmdXKnoTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-4hS07DDJNYmQnkm5aYKSSA-1; Sun, 21 Dec 2025 08:42:57 -0500
X-MC-Unique: 4hS07DDJNYmQnkm5aYKSSA-1
X-Mimecast-MFC-AGG-ID: 4hS07DDJNYmQnkm5aYKSSA_1766324576
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so30454005e9.1
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766324576; x=1766929376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LL1YiW+qcmDAfO6Y9bCrMUIb9gMq0TIVlGP94jNrCWo=;
        b=Lu0gqx/vokHoclYo+wIaOJhtatLZBz4FWnYOZXn6wqtHZHCHl+3KYHgxAdWn9HUoRZ
         Yd/67e4rDcvbrnCloiASf3fM0N3/tm+tOy5C+6LNySvsymJx9IeT19SlytNsBbx8pKVE
         N09WOnNUE4xEK3cnjRhBXj0OwdtBrWgWmZTNZQRShyyV7JRkA/EB1/l61mtkAbj7B8zn
         d1Ley931mbm7GIewZNYr7qSLfeyBOdKDNKmheEySxBgvy7yXtE30Gvmjieyv9fgRTPK/
         QQzqZHqhdRGm65r2wPMwSSvaZ7GypPXVqNcorNhEPtKvGlscd2zjC8LEr4hrEQgRJuIL
         gUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766324576; x=1766929376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL1YiW+qcmDAfO6Y9bCrMUIb9gMq0TIVlGP94jNrCWo=;
        b=r4VpjpbvHacUkQ8QMaSw3DJQWqArvJbQfGtjFG+BLF0j6djhyvAOvdK8KnQ7Lu/BaV
         CHWbEQs4jQ7A5BPWVAm6o+fRLDY8vqxilZymC1Fc4CdUtxDpdze4s0NiblwP7BDyB1Gf
         H2KRTMM8tthi+raOvfDDgHK2kxwqMtz5Bi2Dr0o01lgl/HITAIKF1KyBSE+ZqKWDhWdH
         5GDIfR3qz+T8iE5X9FFdMQpSQnc0WQENU20lcYntGzhoxTH2y7l05CqsaBIw3VaWJ+eu
         R/hcezhyxs2WHNMfObHYRZz6tWSH9kfx5n0jyQ71dkLv1lP7g/BV1DzfcO8yNH8tD6hQ
         2jIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEr8Xut7XH/5za6eoGVNP6v90nYBl2ZT+oMPMeoAmjTcknQefypuT6W/Z1sHNUjUNFkJYzIlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9mB4Gybq7490Y9iY8AzRijjpOF+zoClUOtIUkUkiM53pUJcV
	arjeKObfbTobUrYct6IpoZb83Ny8xen+FxoQ6YAc5m85yjdixtrl86mg79bOwi0DJOMAPpl2K5G
	hHwV6cYD63OtbZVwGSDMJZ5xIX52sx3T/505JF5kU5Mku1rs2NwaCszeQSQ==
X-Gm-Gg: AY/fxX7bwMpvFNZLv7nF4Lp0F9X03l2kM81s41IeGRs/xTKbQi8IwbKX3Rne2c2H3qE
	27RfwVNdwP38DOpDpwMsVfQ5ZzcOo8AVGAdTBxyozZbV8rqE12HZ1LjOhruZ5z6oHWv0p1PtIvC
	IRkBC+WASkZ65Ppq7CKadmMe8QNPV1yPtB/1mzumlGY6oK/kBxKWia4QAuBwLYafgHC7Ae+Q+7D
	RWdw4h/EkK59Bcm8+/Vq4JCNQ7UXrRN+2F916s4hFO1A7/uImPdRgR8Qlsh1hZlM9+DBR/BjOs1
	mZgIASTc9cjHHInyB9p87RvxvhV3d7kwmjExHL2xjXnCiwr/mu0BE1csERrkeZqW2b9QdtEhnnH
	BhialNar27FDClS6o7AwCKmrMtQPCAL6uTg==
X-Received: by 2002:a05:600c:198d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-47d195a06a0mr78888955e9.27.1766324575733;
        Sun, 21 Dec 2025 05:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGndUGZlLP7dF9QsIdTkQlYcFSwsza8K4tRMm6Y1+UEUb2YQun2bVAVDpswkOGEHQO9izRXxw==
X-Received: by 2002:a05:600c:198d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-47d195a06a0mr78888685e9.27.1766324575102;
        Sun, 21 Dec 2025 05:42:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm139563755e9.7.2025.12.21.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:42:54 -0800 (PST)
Date: Sun, 21 Dec 2025 08:42:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
Message-ID: <20251221084218-mutt-send-email-mst@kernel.org>
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>

On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
> On 12/17/25 09:58, Jason Wang wrote:
> > On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> > > On 12/16/25 11:16, Jason Wang wrote:
> > > > On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
> > > > <minhquangbui99@gmail.com> wrote:
> > > > > Calling napi_disable() on an already disabled napi can cause the
> > > > > deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> > > > > when pausing rx"), to avoid the deadlock, when pausing the RX in
> > > > > virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> > > > > However, in the virtnet_rx_resume_all(), we enable the delayed refill
> > > > > work too early before enabling all the receive queue napis.
> > > > > 
> > > > > The deadlock can be reproduced by running
> > > > > selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> > > > > device and inserting a cond_resched() inside the for loop in
> > > > > virtnet_rx_resume_all() to increase the success rate. Because the worker
> > > > > processing the delayed refilled work runs on the same CPU as
> > > > > virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> > > > > In real scenario, the contention on netdev_lock can cause the
> > > > > reschedule.
> > > > > 
> > > > > This fixes the deadlock by ensuring all receive queue's napis are
> > > > > enabled before we enable the delayed refill work in
> > > > > virtnet_rx_resume_all() and virtnet_open().
> > > > > 
> > > > > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > > > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > > > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Move try_fill_recv() before rx napi_enable()
> > > > > - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
> > > > > ---
> > > > >    drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
> > > > >    1 file changed, 45 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8e04adb57f52..4e08880a9467 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
> > > > >    static int virtnet_open(struct net_device *dev)
> > > > >    {
> > > > >           struct virtnet_info *vi = netdev_priv(dev);
> > > > > +       bool schedule_refill = false;
> > > > >           int i, err;
> > > > > 
> > > > > -       enable_delayed_refill(vi);
> > > > > -
> > > > > +       /* - We must call try_fill_recv before enabling napi of the same receive
> > > > > +        * queue so that it doesn't race with the call in virtnet_receive.
> > > > > +        * - We must enable and schedule delayed refill work only when we have
> > > > > +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
> > > > > +        * have a deadlock when calling napi_disable on an already disabled
> > > > > +        * napi.
> > > > > +        */
> > > > >           for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > >                   if (i < vi->curr_queue_pairs)
> > > > >                           /* Make sure we have some buffers: if oom use wq. */
> > > > >                           if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > > > -                               schedule_delayed_work(&vi->refill, 0);
> > > > > +                               schedule_refill = true;
> > > > > 
> > > > >                   err = virtnet_enable_queue_pair(vi, i);
> > > > >                   if (err < 0)
> > > > >                           goto err_enable_qp;
> > > > >           }
> > > > So NAPI could be scheduled and it may want to refill but since refill
> > > > is not enabled, there would be no refill work.
> > > > 
> > > > Is this a problem?
> > > You are right. It is indeed a problem.
> > > 
> > > I think we can unconditionally schedule the delayed refill after
> > > enabling all the RX NAPIs (don't check the boolean schedule_refill
> > > anymore) to ensure that we will have refill work. We can still keep the
> > > try_fill_recv here to fill the receive buffer earlier in normal case.
> > > What do you think?
> > Or we can have a reill_pending
> 
> Okay, let me implement this in the next version.
> 
> > but basically I think we need something
> > that is much more simple. That is, using a per rq work instead of a
> > global one?
> 
> I think we can leave this in a net-next patch later.
> 
> Thanks,
> Quang Minh

i am not sure per rq is not simpler than this pile of tricks.


> > 
> > Thanks
> > 
> > > > 
> > > > > +       enable_delayed_refill(vi);
> > > > > +       if (schedule_refill)
> > > > > +               schedule_delayed_work(&vi->refill, 0);
> > > > > +
> > > > >           if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > >                   if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > >                           netif_carrier_on(vi->dev);
> > > > > @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > > > >           __virtnet_rx_pause(vi, rq);
> > > > >    }
> > > > > 
> > > > Thanks
> > > > 
> > > Thanks,
> > > Quang Minh.
> > > 



Return-Path: <stable+bounces-179384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECCB553CD
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF25C175E
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92931352B;
	Fri, 12 Sep 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgZQoEIv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBA3128AF
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691523; cv=none; b=eeBypPHbyCvVXrPzq4cXGIzGTTBMB3hAsCu1sjpgqJB7VQVZGf3/FOpkZ9/40B1q7X15gQCchIOGfWQy1N8KX9yLCYNFE1qjnDZpWtjxoTNq+it3KA2zcZZUcZd3CkqdP0qb5HDFRc1ZPd3e+kuvAhFpQHk2A83HtS4rjs1PdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691523; c=relaxed/simple;
	bh=yA5W0gyjqiFInACMAabQjnKR5iVoASdT39QfR/SdyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clHs24MWWvJe8R1BaateVV740PTSzJjskwwxgN8DOJ0bscqhL/eGn6tqDR1qbRhIXfZTnuvxiLk5XLRci8Uzot3W6Iv7a8otW79JKoZUlr7DNsxPooKwOMJlJ56PZXZ2kurnxiu91SQofDgwK6rJqJ+JySnPqnrcIiTNmNesEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgZQoEIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757691520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSPNoqFe2CICtx8x9/0bzyvcMYgkBZkWJVegup2Y/D0=;
	b=YgZQoEIvSZO7wGIGNd1Fo9m5vhhNhew8dwgA/CquoooaqPxthloRUvQZ45KEUN4XiD2dM3
	iKARncpSQNBz3qRjkXGICOIyDto73Qv+QgNq2zlyNJAl6xIBmad7KtX1FNf/Y49sgTCXIW
	qYRSYfCX/MZ88dFH2vLKNoJaKKzZ2u8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-8z1zmv6uPH-LrVkdveV5Sw-1; Fri, 12 Sep 2025 11:38:39 -0400
X-MC-Unique: 8z1zmv6uPH-LrVkdveV5Sw-1
X-Mimecast-MFC-AGG-ID: 8z1zmv6uPH-LrVkdveV5Sw_1757691518
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so1059335f8f.3
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 08:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691518; x=1758296318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSPNoqFe2CICtx8x9/0bzyvcMYgkBZkWJVegup2Y/D0=;
        b=dQaITJN1z++opzj/G91d1dZJJO1UEr1Sk+AAol+PQ8RuAuB7iHvDqo9kne/HwlaNul
         2Fy68noGBprMbBUmUgmlNc0tu08Pu+SJMfuiwO7vMXwrMeydT6Dgz+B6wwziL3A/0Err
         U2VU8NiTkDM7sgLF8PBEPAZu5NyPTnLwt4DlU2kvXSX+1MRJFflFiO8WjmSufP06SU4X
         VMtnugn24XgkU6zl/n5I4tv6ZQZS+CHTr893sKZY3EwW9u0m9GZ8WvQQust4BSFNv5Kx
         Uc2B7+IqZWgdsZaXxmKp2/DbjpWPEMJMb+UT6CCQBG6cPCIFp1Vxr8os8Z8caRIibeBQ
         peIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1sHSQQYQ1aXTpUorXnxGpljLycNFvTzcTJXCpvqhEdT/4lVe1CIcJy3ElR6ohL83dRp8Fo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtR1oMusKPJMXjYROY5/LPtzKAyuTa/bRWRjsgOzHibAbAIlg
	KQwV9tp7KxZwrjpYuqZ3hAR92ivXZiMpGXuHpHvms0C4hDKDLJRFmWmximySw63n0eL/i4jqkNb
	u0UbICgURcY/UuJ2bEHOPsmDlx/oNQAun1hWxUJxsH+mX74qIaIcSPLiMtA==
X-Gm-Gg: ASbGncveRgpnd4YaMZw9Ynta+/L4ZhoT2/q8pf4/NVIIp0xxKo9PE5XhJXcdfB9Cs4B
	8hZUEFICZOPAqptKWae7l/J4gJuAQpfeOM7M/G28hCBDQIUARxzMDkZX0AbT4qKi9vYczKmZPN4
	oGuURFWShKH68Ewh1Hf0SEjCWWrNse+VXiekkGXmt6ft11K7Q5hXsDx+wRIQ2zHvQaVIs+RbTOC
	xAKQKQIn0rAnq87HcNuBfWtMk578s1eZfQwqa3YxOJZjB3StGwilw6VcYk76+aVxIEPg8QZ8/tB
	Yg9fzgvTA05jNjgYSYOQPMhaxUosSnQ0gnk=
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-3e7657c4d40mr2960036f8f.23.1757691518269;
        Fri, 12 Sep 2025 08:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU2k5VNrAMxJMJsslonyveuVI1XMMPRzh7WCfgvwmksVI/+i/xxPC3tMUE4P/r7651cJtw3w==
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-3e7657c4d40mr2959997f8f.23.1757691517807;
        Fri, 12 Sep 2025 08:38:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01512379sm69044125e9.0.2025.09.12.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:38:37 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:38:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"jonah.palmer@oracle.com" <jonah.palmer@oracle.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912113432-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250912044523-mutt-send-email-mst@kernel.org>
 <63426904-881F-4725-96F5-3343389ED170@nutanix.com>
 <20250912112726-mutt-send-email-mst@kernel.org>
 <4418BA21-716E-468B-85EB-DB88CCD64F38@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4418BA21-716E-468B-85EB-DB88CCD64F38@nutanix.com>

On Fri, Sep 12, 2025 at 03:33:32PM +0000, Jon Kohler wrote:
> 
> 
> > On Sep 12, 2025, at 11:30 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Fri, Sep 12, 2025 at 03:24:42PM +0000, Jon Kohler wrote:
> >> 
> >> 
> >>> On Sep 12, 2025, at 4:50 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>> 
> >>> |-------------------------------------------------------------------!
> >>> 
> >>> On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> >>>> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> >>>> sendmsg") tries to defer the notification enabling by moving the logic
> >>>> out of the loop after the vhost_tx_batch() when nothing new is
> >>>> spotted. This will bring side effects as the new logic would be reused
> >>>> for several other error conditions.
> >>>> 
> >>>> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> >>>> might return -EAGAIN and exit the loop and see there's still available
> >>>> buffers, so it will queue the tx work again until userspace feed the
> >>>> IOTLB entry correctly. This will slowdown the tx processing and may
> >>>> trigger the TX watchdog in the guest.
> >>> 
> >>> It's not that it might.
> >>> Pls clarify that it *has been reported* to do exactly that,
> >>> and add a link to the report.
> >>> 
> >>> 
> >>>> Fixing this by stick the notificaiton enabling logic inside the loop
> >>>> when nothing new is spotted and flush the batched before.
> >>>> 
> >>>> Reported-by: Jon Kohler <jon@nutanix.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> >>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> 
> >>> So this is mostly a revert, but with
> >>>                    vhost_tx_batch(net, nvq, sock, &msg);
> >>> added in to avoid regressing performance.
> >>> 
> >>> If you do not want to structure it like this (revert+optimization),
> >>> then pls make that clear in the message.
> >>> 
> >>> 
> >>>> ---
> >>>> drivers/vhost/net.c | 33 +++++++++++++--------------------
> >>>> 1 file changed, 13 insertions(+), 20 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index 16e39f3ab956..3611b7537932 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> int err;
> >>>> int sent_pkts = 0;
> >>>> bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> >>>> - bool busyloop_intr;
> >>>> bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> >>>> 
> >>>> do {
> >>>> - busyloop_intr = false;
> >>>> + bool busyloop_intr = false;
> >>>> +
> >>>> if (nvq->done_idx == VHOST_NET_BATCH)
> >>>> vhost_tx_batch(net, nvq, sock, &msg);
> >>>> 
> >>>> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> break;
> >>>> /* Nothing new?  Wait for eventfd to tell us they refilled. */
> >>>> if (head == vq->num) {
> >>>> - /* Kicks are disabled at this point, break loop and
> >>>> - * process any remaining batched packets. Queue will
> >>>> - * be re-enabled afterwards.
> >>>> + /* Flush batched packets before enabling
> >>>> + * virqtueue notification to reduce
> >>>> + * unnecssary virtqueue kicks.
> >>> 
> >>> typos: virtqueue, unnecessary
> >>> 
> >>>> */
> >>>> + vhost_tx_batch(net, nvq, sock, &msg);
> >>>> + if (unlikely(busyloop_intr)) {
> >>>> + vhost_poll_queue(&vq->poll);
> >>>> + } else if (unlikely(vhost_enable_notify(&net->dev,
> >>>> + vq))) {
> >>>> + vhost_disable_notify(&net->dev, vq);
> >>>> + continue;
> >>>> + }
> >>>> break;
> >>>> }
> >> 
> >> See my comment below, but how about something like this?
> >> if (head == vq->num) {
> >> /* Flush batched packets before enabling
> >> * virtqueue notification to reduce
> >> * unnecessary virtqueue kicks.
> >> */
> >> vhost_tx_batch(net, nvq, sock, &msg);
> >> if (unlikely(busyloop_intr))
> >> /* If interrupted while doing busy polling,
> >> * requeue the handler to be fair handle_rx
> >> * as well as other tasks waiting on cpu.
> >> */
> >> vhost_poll_queue(&vq->poll);
> >> else
> >> /* All of our work has been completed;
> >> * however, before leaving the TX handler,
> >> * do one last check for work, and requeue
> >> * handler if necessary. If there is no work,
> >> * queue will be reenabled.
> >> */
> >> vhost_net_busy_poll_try_queue(net, vq);
> > 
> > 
> > I mean it's functionally equivalent, but vhost_net_busy_poll_try_queue 
> > checks the avail ring again and we just checked it.
> > Why is this a good idea?
> > This happens on good path so I dislike unnecessary work like this.
> 
> For the sake of discussion, let’s say vhost_tx_batch and the
> sendmsg within took 1 full second to complete. A lot could potentially
> happen in that amount of time. So sure, control path wise it looks like
> we just checked it, but time wise, that could have been ages ago.


Oh I forgot we had the tx batch in there.
OK then, I don't have a problem with this.


However, what I like about Jason's patch is that
it is actually simply revert of your patch +
a single call to 
vhost_tx_batch(net, nvq, sock, &msg);

So it is a more obviosly correct approach.


I'll be fine with doing what you propose on top,
with testing that they are benefitial for performance.






> > 
> > 
> >> break;
> >> }
> >> 
> >> 
> >>>> 
> >>>> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> ++nvq->done_idx;
> >>>> } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >>>> 
> >>>> - /* Kicks are still disabled, dispatch any remaining batched msgs. */
> >>>> vhost_tx_batch(net, nvq, sock, &msg);
> >>>> -
> >>>> - if (unlikely(busyloop_intr))
> >>>> - /* If interrupted while doing busy polling, requeue the
> >>>> - * handler to be fair handle_rx as well as other tasks
> >>>> - * waiting on cpu.
> >>>> - */
> >>>> - vhost_poll_queue(&vq->poll);
> >>>> - else
> >>>> - /* All of our work has been completed; however, before
> >>>> - * leaving the TX handler, do one last check for work,
> >>>> - * and requeue handler if necessary. If there is no work,
> >>>> - * queue will be reenabled.
> >>>> - */
> >>>> - vhost_net_busy_poll_try_queue(net, vq);
> >> 
> >> Note: the use of vhost_net_busy_poll_try_queue was intentional in my
> >> patch as it was checking to see both conditionals.
> >> 
> >> Can we simply hoist my logic up instead?
> >> 
> >>>> }
> >>>> 
> >>>> static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> >>>> -- 
> >>>> 2.34.1
> >>> 
> >> 
> >> Tested-by: Jon Kohler <jon@nutanix.com <mailto:jon@nutanix.com>>
> >> 
> >> Tried this out on a 6.16 host / guest that locked up with iotlb miss loop,
> >> applied this patch and all was well.
> > 
> 



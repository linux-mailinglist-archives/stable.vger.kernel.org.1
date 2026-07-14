Return-Path: <stable+bounces-274504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9VbBl5+VmqI7QAAu9opvQ
	(envelope-from <stable+bounces-274504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:22:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F52757CE8
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:22:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=o0Y9bBjA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274504-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274504-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7BD30D0BB9
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EA412C02;
	Tue, 14 Jul 2026 18:21:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911F30B50A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053297; cv=none; b=OBOo7raqkKgOezseb2suW5DUc4FXSy52mIl79ASxBND/jlHQa/NjeoA9fHLxwWqUtXas21aSoaFcnn6d6vJHWvqOGNcQMK2Yy/QFpp/vkBq2cOIRFxQPlJDo1Raz+f2Q/NNQcAWr2aaFrVQXRTkexVuPii9zlj4aRjVsoROwGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053297; c=relaxed/simple;
	bh=A38XAf/qyrY/pxvb8R0wLZ2ECalCATFuHuqBr7PPTyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mKZlqsz2ou6ACddoEPoTmmyVSIL6VKxAnGoWFD5iWvJzc/BsTp76mYUo45Uynx1KMLXFCYYKEYTm38u1rdnZeC50ajd4fpPG3Z+7Iv07Zih+iXHbSUZ/4HReVdUj1ZTGIfkDlK2DswHmoO56gIKRoA9mTQi/MbrZ/PFmJno2O5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0Y9bBjA; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cede6375caso171125ad.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784053295; x=1784658095; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gQRzGlj1G5cVe9CASOoXX9GLstMyJGv9XUVp1m4BJc=;
        b=o0Y9bBjA1irEA1R+qCmHg6L6NkE+kAzrZa6mpuZr22P2QQmSgpLEvx7urMD9HrogTf
         kRclH7khQYfIwbSzN03RNzN7mCVsZLs6XO692BxzMMTFFJMn93WC7CHCMJUXC6vNE1bG
         H5TkhZwpugYDGrCXZjjv+mMQvDJ5ZP5IGFAF0xb+g8EoPfNZ0wwV0FHl8mDa+MKkOIIC
         C9Qd3LSGKVlL+REX5ObtMYHs5FZgWYzQclvpA+8KusFHlVfSSIbE2WDiYDwYigKTNnwX
         o5LTqAsXPm88Tv16XPjdC3vrfWRxXTtMe2iPrD/fo2Z3WcDMoqbSBxUxQHRaZTRveh0+
         FRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053295; x=1784658095;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8gQRzGlj1G5cVe9CASOoXX9GLstMyJGv9XUVp1m4BJc=;
        b=ahTeazhJzaniIzs73bB5NT7PAwUSE4PKiEnIPfcnHvyvBE4GkMD3veY6tJr+/4Md3v
         cDw5EEh7hhdzj7o5TADIJaMDUjUO7Az2pURW11EMaRBsu00JlaqS3QI2TeWubWHghlRa
         iotydhgGMLKsW5KH1cKfu+y1Be0aPfxJivZC/2nYQj3KhuraAVB70vy3BVdSVikyufom
         ev5znf5Zqdgb/VxxnDgz2nW7lGihHLxI8JhzJ8RdoD/04V2/ncLQ8AJOcc/y82By35aF
         hiJDHeSqfJb3X6NsDqSpfBMSB0zVIFEqPMcxZsmu83QwSNA5g2UZVtbNbhD46r6TQ5aD
         hZIQ==
X-Forwarded-Encrypted: i=1; AHgh+RogBUfAyQRWVZkl+mA8TLWDJQ0cfOF2tDe6dOP5w0HWNYlkxN5ES7XRNgN4ly/dv/FitxLmVBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOE06Ad8cImf0MgZ7MVGIKBZ0u4mGCdd/BbuvZRo17CaU8tCc
	J1Ej3SCLCkLl1lixVvu8+9ULOk4mj0lx07cUK6UFR/uvnJuotKxAr6kadejRAzQQ4w==
X-Gm-Gg: AfdE7cl5mra/9RUZo04OdiBH7fSIku1SSfNOw1rULIU9vsyTwEklZs8/722FMyD58l1
	9EJ1ZaZpdFKvcU8N1Ag0ZG0nakd6hY2to2n99FTb1XqpNrKOzmXs9bSZ8qHRd+ulqv9DNc0jlqs
	wQ4lXoUw3tcq6zPAfXdiXw/k7d2G6CPlDO83Lh6TDNLg4t9JGx3xsDhY74r+HJuYVzPa4kUjv8t
	NlVIy2po525e4K8AOdDm03w2gX3v8uAk6hzPzL6nZIcFUgbRD1rzK7LitME4ROoEDgowRiSn60N
	vObq35vPaUq5Hysb2blxsWQg/VT5bRatjs1JNbilVfZip8+fawWBdto9+ATgEfFKZvkj9gRtay9
	+7D6p1OmtDnS0B6qP42N9BRI8ygZqgnXvdpxe4D/rL1KCIJms2c3w8+1yfWsppsYe8x0R+v8+v1
	gUXx4lGTsdKCdn+/wdrBIl+vKcWH7zKWBJEDHAKUFUs8DikdyBtxdFIo+zQfIZoAElF7Ovz2qQp
	sGvWvq9Nbgp3p9Tnm9mQ9E7rOB2UIMs+HYO+5U6ikI=
X-Received: by 2002:a17:902:f70b:b0:2cc:6df5:62a1 with SMTP id d9443c01a7336-2cee1ca3115mr7223455ad.20.1784053294748;
        Tue, 14 Jul 2026 11:21:34 -0700 (PDT)
Received: from [2a00:79e0:2eb4:9:c2bd:d216:2ddc:2568] ([2a00:79e0:2eb4:9:c2bd:d216:2ddc:2568])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cc7f1sm1933730a91.5.2026.07.14.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:21:33 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:21:33 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: "David Hildenbrand (Arm)" <david@kernel.org>, Link Lin <linkl@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com, 
    duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
    Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, 
    ahwilkins@google.com, Greg Thelen <gthelen@google.com>, 
    Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
In-Reply-To: <20260714092146-mutt-send-email-mst@kernel.org>
Message-ID: <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org> <20260714092146-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,linux-foundation.org,lists.linux.dev,kvack.org,vger.kernel.org,redhat.com,linux.alibaba.com,openresty.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-274504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:david@kernel.org,m:linkl@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:virtualization@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:prasin@google.com,m:duenwen@google.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:ammarfaizi2@openresty.com,m:jiaqiyan@google.com,m:ahwilkins@google.com,m:gthelen@google.com,m:alexander.duyck@gmail.com,m:stable@vger.kernel.org,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[rientjes@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rientjes@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69F52757CE8

On Tue, 14 Jul 2026, Michael S. Tsirkin wrote:

> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> > >  	 * The workqueue is already frozen by the PM core before this
> > >  	 * function is called.
> > >  	 */
> > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > > +		page_reporting_unregister(&vb->pr_dev_info);
> > > +
> > >  	remove_common(vb);
> > >  	return 0;
> > >  }
> > >  
> > >  static int virtballoon_restore(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_balloon *vb = vdev->priv;
> > >  	int ret;
> > >  
> > >  	ret = init_vqs(vdev->priv);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > >  	virtio_device_ready(vdev);
> > >  
> > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > > +		ret = page_reporting_register(&vb->pr_dev_info);
> > > +		if (ret)
> > > +			goto out_remove_vqs;
> > > +	}
> > 
> > Hm, that failure handling is rather nasty.
> > 
> > 
> > In virtballoon_freeze() we document:
> > 
> > "The workqueue is already frozen by the PM core before this function is called"
> > 
> > Your report states:
> > 
> > "Workqueue: events page_reporting_process"
> > 
> > 
> > I assume that workqueue is not frozen yet because ... it's not freezable :)
> > 
> > So could we queue to system_freezable_wq instead, or define our own freezable
> > workqueue there? Then a driver doesn't have to worry about that.
> > 
> > -- 
> > Cheers,
> > 
> > David
> 
> +1.  Just system_freezable_wq will do the trick.
> 

This makes sense.

I'm curious why this bug hasn't popped up earlier, presumably any VM that 
has gone through suspend while reporting free pages through FPR is 
vulnerable to it and could have panicked as a result.  Which would suggest 
maybe >99% of FPR is done by guests that never suspend?  While under 
pressure this issue seems reproducible.


Return-Path: <stable+bounces-233929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7giKO+lq1mnlFAgAu9opvQ
	(envelope-from <stable+bounces-233929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:49:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF693BDD99
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FE16300E1A4
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EA39F169;
	Wed,  8 Apr 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nue8w/FA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8KbAo6y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C702FF17A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659746; cv=none; b=F8yM10HpQPQapgzy4H20itEO1Exm4EnUJeO/KQctspwH2dj/pAU4ZCJ+GqI259vujSqj2lkNqOjpUks72/26siRm4mFUZDEyA6yeqeuBh80TVyJs5XGiNpneFI0GnNcJEYmPmC0/8vytzsqElmGwToqhzzAxKNqSX0mImtOWWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659746; c=relaxed/simple;
	bh=/kC9ML9lt49S+EL48uyk3OO+7Avvh6NtEYfLVQo7YbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oolx3Ef+TNZrfJ2CadpF+M6iMTkXTm9FuCPCy4cpCzmsZk1Xwz/xTcUF1TxthuQ3ZxiFt2cYZGr7sgqD1qMPT1mEUWZEWwLpjGZokVnkbyEmKnrzVeqRt9NK+fZGUJ7xpcNvL+7l2dSFRxGRyG8TU2xmPxEGU4gEoGgdjC5YgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nue8w/FA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8KbAo6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775659744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ8auDO3S7o6AakY7fJm8XHjf2a2nhy+U/65Q7pQXUc=;
	b=Nue8w/FAtsx9Oh2gxWvVzHOLVOFAS4iPG3o1eJQcID5dMYX5oeqedDbd3Jv822Yk/hk6uS
	Bn0yyBYEFHjy4LxI9U6J+hWex0SWrV/+S8aHuYQYpAvgy/UAiaegSEW0nDJxXIVDY8BBcN
	UkmgCjlTQzVM8Ng8FfrroNwfH9P8f4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Et2LYCmXM9qctSvNNogGaw-1; Wed, 08 Apr 2026 10:49:02 -0400
X-MC-Unique: Et2LYCmXM9qctSvNNogGaw-1
X-Mimecast-MFC-AGG-ID: Et2LYCmXM9qctSvNNogGaw_1775659741
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so1595235e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775659741; x=1776264541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ8auDO3S7o6AakY7fJm8XHjf2a2nhy+U/65Q7pQXUc=;
        b=N8KbAo6yP5f1JFRj8A4vCQVRoBqW0QHEx2KdeRfK2N/mBen7xekZgMzWrs+zRseu0V
         Jkb9bWC+l6dQ8y4pNNRvrB0ZeZx8c7SCM1/dq59yjWltdoYnE/VT0scAsGWP2I2E+N8k
         wgfnygi/3VZbvEJiCjEuUc6Hk4wrCx6aKaq5KmClNlyRub/ial/L+lekrYUaechyVHyj
         HPk8mv9YSwiDUEzZWUTXNZ1NiLV5DaRQAilcjS5tKRkpfZulAIaISRt/96yTh/866znz
         EY2L0bdFTetnXvHwHHIPpsAER5DPFWSHedLmTWD1lgV6SDgu635irh5M58GEJ9HWp865
         Z86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659741; x=1776264541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ8auDO3S7o6AakY7fJm8XHjf2a2nhy+U/65Q7pQXUc=;
        b=E0SWXSACzqpeFunNkDwARTcw/SwKmQYsjRtNDQI0k+MLIr022LmGwomK9qK2QdGmKc
         6PkxfBJVwW3emPbB2Pkdvd+DBpYcHqivylYrwkzH38U/CvhsWYjy+WkQRH9HEZZY3KHl
         6HpIbTjkQKyk5XIVMmZfiP2Ws41WlcD+jkG+tW7zw0eQp7wf8YlNgdFQLIx/ZOq0eOqO
         mqTZJulCCpReW2ORjWaq6qZpJy6yP4VTAPKTbmgG6yK5vIXg/fzSY1Hqx3bng+pUrUA/
         Q2XEf2DOzlIJ/v5pvOh5flKtPMi1Z8lA0PzyQ3YYSm8JGFhx+AvJA/bLXmtnrmchjpnw
         viWw==
X-Forwarded-Encrypted: i=1; AJvYcCUdYBYmFSjJ+2YcOjwlnsM7Ey3Fm5ZncAU+F+bZ9jMQCRbdbDuWF+ixfA4gQpCkSB9PuJfTE3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGnGwbqWCEXv2a7KrDaDRVNSi5aUdakOePVKHeq/xjZC68x8a
	5mMU+IBAZYEu4fZC2Iyg8bqE9CxInBTMuYvNUHfaXEQpJTpqa1HTKNMKojWKnu84pA8RV5P+kT1
	DFMwP82pDvpSc1Fx89GmRWM9nH+jg/Ej+0FtN4vIhSeTZa8buvX0gm/wwcA==
X-Gm-Gg: AeBDievsuPW/jI5TfpBptwcQlQq3EKTrLaDHG79cpnupfAPbbtctDKKFN8jQ7OyosUM
	ic3TbIJ06FQvEdfAEYr9hhHCOrDDdUd45pQltzqVh1oyqnLQFoHi809U9rX67w8lgpK1Fn1/qo+
	BS795tM9DO1GhiSoB29Xuv66hlRscupF5j+IFK+L2QP36evt9LVKZnR/iZOVk5+kwBu2Sb9xCnU
	Ydu7moWE7uYaBg+PEXJiHVEA0Y2HDbBJ11EV5u/x4FwaF9gg4HretaVLRMC8nMuKksoJTe9hu1G
	CRbQtURhKfCic5l3EjAimK16X9ozQ/dw11brxXmErZ5xDNeuZTCrjNw4tPxzb00PLSeQZmMYt+y
	UcMNV21Cv+LPpvcb0UL5SJsIBIDuIrlrSDYA6wE2WX/k=
X-Received: by 2002:a05:600c:c165:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488ccfc056dmr103135e9.13.1775659741269;
        Wed, 08 Apr 2026 07:49:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c165:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488ccfc056dmr102665e9.13.1775659740710;
        Wed, 08 Apr 2026 07:49:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1199968945e9.2.2026.04.08.07.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:49:00 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:48:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260408104825-mutt-send-email-mst@kernel.org>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233929-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,proofpoint.com:url]
X-Rspamd-Queue-Id: EAF693BDD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:49:48PM +0000, Srujana Challa wrote:
> > From: Srujana Challa <schalla@marvell.com>
> > 
> > [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
> > 
> > rss_max_key_size in the virtio spec is the maximum key size supported by the
> > device, not a mandatory size the driver must use. Also the value 40 is a spec
> > minimum, not a spec maximum.
> > 
> > The current code rejects RSS and can fail probe when the device reports a
> > larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> > effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> > and keep RSS enabled.
> > 
> > This keeps probe working on devices that advertise larger maximum key sizes
> > while respecting the netdev RSS key buffer size limit.
> > 
> > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Link: https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__patch.msgid.link_20260326142344.1171317-2D1-2Dschalla-
> > 40marvell.com&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFp
> > ANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=0XuKVXgk9_1LUIZHeqL0znGhAh
> > x5KvAOLvrCl-orVeQSt__4o6Djr-79rwCl6KNp&s=cfQpAcZTTE7nTYku-
> > MVkfip0xUJoBBw4ikqm9iEdgcc&e=
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> [ changed clamp target from
> > NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/net/virtio_net.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > 5c83983f0eb3f..5a31ccdae2e22 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6502,6 +6502,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	struct virtnet_info *vi;
> >  	u16 max_queue_pairs;
> >  	int mtu = 0;
> > +	u16 key_sz;
> > 
> >  	/* Find if host supports multiqueue/rss virtio_net device */
> >  	max_queue_pairs = 1;
> > @@ -6624,14 +6625,13 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> >  		goto free;
> > 
> >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > -		vi->rss_key_size =
> > -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > rss_max_key_size));
> > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > the limit %u.\n",
> > -				vi->rss_key_size,
> > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > -			err = -EINVAL;
> > -			goto free;
> > -		}
> > +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > +rss_max_key_size));
> > +
> > +		vi->rss_key_size = min_t(u16, key_sz,
> > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > +		if (key_sz > vi->rss_key_size)
> > +			dev_warn(&vdev->dev,
> > +				 "rss_max_key_size=%u exceeds driver limit
> > %u, clamping\n",
> > +				 key_sz, vi->rss_key_size);
> > 
> >  		vi->rss_hash_types_supported =
> >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > supported_hash_types));
> > --
> > 2.53.0
> 
> We used `NETDEV_RSS_KEY_LEN` intentionally for clamping.  
> `rss_max_key_size` is the maximum supported by the device,
> while `40` is a spec minimum, not a maximum.
> Clamping to `VIRTIO_NET_RSS_MAX_KEY_SIZE` would unnecessarily
> limit valid devices(for example devices advertising 48/52 bytes) and
> could reintroduce the original issue.
> 
> Could you please share the reason for changing the clamp target
> from `NETDEV_RSS_KEY_LEN` to `VIRTIO_NET_RSS_MAX_KEY_SIZE`?
> 
> Thanks!

Srujana,


do you want to do the stable backport yourself?

-- 
MST



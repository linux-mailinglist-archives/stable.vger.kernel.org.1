Return-Path: <stable+bounces-219596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCxUB9Trnmk/XwQAu9opvQ
	(envelope-from <stable+bounces-219596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:32:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70B19764B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3057831A8C2F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDD3AEF55;
	Wed, 25 Feb 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYZIKKo7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYUuRlBp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5703AEF3F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022305; cv=none; b=d2D7jW98rUtC7OEmAxA7mlkeNItLZPhHiQNUCQBFHqgRO+Udu6d4aVtOIepzBwpgwOpJ9sxBd9A2Lh2g3spwpIdRf6cptGaoErLCcjRcZTxPb/aDoKchGx1wxLQb4y4j9j8S5b53P/nG+Cgqcw5xsm0FZlUkudIGRdM29BUHmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022305; c=relaxed/simple;
	bh=KpzWjtfsWv3qhAGhWyvVbyhPwgnmWZ3Fr4zjNZr3GdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSPeYTHCWxY++aFak51CDI+/wXea991RKXvgNA4/rmS7SDH0Jl+NBGXsuH+KojV4UnuFvJdFAAdWHvZjZfywImIkVYhgFW6hMqM9O3eos34l2fXhqnForlOCIMD5qhWcS4/35HHWPUl5cnE2b49LBZGmEkc/Ob0Ybqjm6RtpXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYZIKKo7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYUuRlBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772022302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMzUQOTDOi7UoTOS/hJ+EQEdYM7FgK5Sbr9EcZoRwiY=;
	b=UYZIKKo79psuCtgoz3gbRTuov8qK59BLTRELMmi6ivTA7krI4F4Rzyt7wzFMUZpgxI9iHZ
	EnGhRuV7sbnFfT37Gcw6L+pPscQ3rzDPVD6IKj/o0bAMnuWdzy9JnI8T2xJVTtvE1xdJ9x
	RKQox9ovBYsDe+8onEFRgPU/XstLNIw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ZCsgkPuVOuuhth-l3us9-g-1; Wed, 25 Feb 2026 07:25:00 -0500
X-MC-Unique: ZCsgkPuVOuuhth-l3us9-g-1
X-Mimecast-MFC-AGG-ID: ZCsgkPuVOuuhth-l3us9-g_1772022300
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so32777005e9.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 04:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772022300; x=1772627100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LMzUQOTDOi7UoTOS/hJ+EQEdYM7FgK5Sbr9EcZoRwiY=;
        b=XYUuRlBpeYjeUgH8v+F4nhnbId548UYou+Bn3XCBOuxVult/7ulLRLBKzQV1B+z7Ct
         ppJjfFMZn7k1OhcA+PPh3E8JQU2IKazKzZ4GYGRcvhzAHQMO2InE/im+tZ3bqcZ78/Ge
         uJ5wsFYWX8sceQnX3+pCAEBeNYu8I6oR+HPGvqdg5l2S2ZoaR1ZKKBLzNyv1fZvjwoRc
         9XB35xAIj7UYQwcOlZVI8M/kq1QmlAwlZKQZY9xqpVCCh/p41XKWSSCbWnIFkVmuw/zv
         BSA7B/lRrQmLdXfGojSi93wUtIVBdQqiufzUdv01Ka3EVQgB+kyh/NNCKfmh3vD2tdWo
         eJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022300; x=1772627100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMzUQOTDOi7UoTOS/hJ+EQEdYM7FgK5Sbr9EcZoRwiY=;
        b=Ir+aiivhbK3ili1ijLbSEaHu++rCXBqTOofIPY6DmCuZlaM5fodxZOXLyNNp/TCnb8
         D3b6vY1GMdmcmdyk0SuNXL2L8nubjf8yKsj6MGKjb+pzHk5kMrG8hgK6iJwx0LNMnuWV
         RvLHQreflMZWjE6+VcwqNaM1VbW00vAsDtraDBLoJLYNbhG4wOj3mfZFcpIGGqMsBtqS
         h6YjN0BuxTXID/sUhTZQF9PfRhQaJKpQkNUAR2q0SSunCHXEs4dwLzTM5iHoSni+t10v
         5VuF9N4ASo1Ncb85fIXG9eACtAmVJM7rgXhyqu6Y/q8MpOMU2jL/yZpd1kl1OJTZzB6T
         2z7g==
X-Forwarded-Encrypted: i=1; AJvYcCWR4maf/Vga9KY5spcF76HviboaHHC8l9cTWsIuQ6iYrTMylXs5sSDC9q+FGZSAWNEYNbhc3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/L5Ai0aIfyOfDiuseeNkX+WbzgjKdeVWNHyg8Hzr2Kr1JXax
	BayifB8cQsUjeSljnHgb+6pWbpvpPaiYgz9S/69VJaY9acclWiZ2jEYCKAsXXoI08niGjFEOQLm
	p6r+CwHJzfiMKdHA6ztrH3Gp641gtjLAP2vA2Ix6+MPOEWAmV/oBNYU+OcQ==
X-Gm-Gg: ATEYQzy6kixgXa23aOUIglohZ81lQM/oDMXpnxgxIJQxDJIs3M0ZLlSWbm1D24h1YCZ
	UhrHE/JmYtZceaPEz4O6tpsmGg3pquT2H64XxofQqrQAiZ4xjUxvDgfPPXI+PIznHaMc7g4XuyW
	5715lHpa/x+psKOh6UOJDeRy4m0WHwj95wlzq9e5sZ9OumiksFoEA0NonCaPbkuqWZPlgXO2GXK
	4P81kVrCjFVa8H17ZxwL6Aq8ywDOkBAEKkz7mo+4HDwjmcd0C6A465vMRVFQTxjCzPo0/NmtU5L
	pLeArAg1p/DHjua7zETe5GlAtqteEV4niRAAwW9zbEOfqHYbH0L2Loqvt7FFfYc7fk2tNpcaJs6
	LY/9muCuNYjqj0YFXAYTnyLKe4xjwF44o5OPJv6IBQEObzQ==
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483c21a57aemr2858135e9.27.1772022299476;
        Wed, 25 Feb 2026 04:24:59 -0800 (PST)
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483c21a57aemr2857655e9.27.1772022299002;
        Wed, 25 Feb 2026 04:24:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm61847325e9.7.2026.02.25.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:24:58 -0800 (PST)
Date: Wed, 25 Feb 2026 07:24:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225072355-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219596-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D70B19764B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:22:50PM +0000, Srujana Challa wrote:
> > On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > > align with kernel's standard RSS key length. Add validation for RSS
> > > key size against spec minimum (40 bytes) and driver maximum. When
> > > validation fails, gracefully disable RSS features and continue
> > > initialization rather than failing completely.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > 
> > --- should come here before changelog.
> > 
> > > v3:
> > > - Moved RSS key validation checks to virtnet_validate.
> > > - Add fixes: tag and CC -stable
> > > v4:
> > > - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
> > size.
> > > ---
> > >  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
> > >  1 file changed, 24 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > db88dcaefb20..eeefe8abc122 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -381,8 +381,6 @@ struct receive_queue {
> > >  	struct xdp_buff **xsk_buffs;
> > >  };
> > >
> > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > -
> > >  /* Control VQ buffers: protected by the rtnl lock */  struct
> > > control_buf {
> > >  	struct virtio_net_ctrl_hdr hdr;
> > > @@ -486,7 +484,7 @@ struct virtnet_info {
> > >
> > >  	/* Must be last as it ends in a flexible-array member. */
> > >  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
> > hash_key_data,
> > > -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> > >  	);
> > >  };
> > >  static_assert(offsetof(struct virtnet_info,
> > > rss_trailer.hash_key_data) == @@ -6627,6 +6625,29 @@ static int
> > virtnet_validate(struct virtio_device *vdev)
> > >  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> > >  	}
> > >
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> > > +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> > > +		u8 key_sz = virtio_cread8(vdev,
> > > +					  offsetof(struct virtio_net_config,
> > > +						   rss_max_key_size));
> > > +		/* Spec requires at least 40 bytes */ #define
> > > +VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> > > +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> > > +			dev_warn(&vdev->dev,
> > > +				 "rss_max_key_size=%u is less than spec
> > minimum %u, disabling RSS\n",
> > > +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > +			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > +		}
> > > +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > +			dev_warn(&vdev->dev,
> > > +				 "rss_max_key_size=%u exceeds driver limit
> > %u, disabling RSS\n",
> > > +				 key_sz, NETDEV_RSS_KEY_LEN);
> > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > +			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > 
> > you flipped the logic here and it makes no sense now.
> > 
> > Did you test this path?
> Yes, tested with Marvell's Octeon device.
> > 
> > 
> > So if device is powerful and supports a very big key size then...
> > we disable the feature? how does this make sense?
> The intent isn’t to disable the feature on capable devices, but to ensure the driver never advertises
> support for RSS key sizes larger than what the net device can actually handle. Even if a device reports
> a very large key size, the driver is constrained by NETDEV_RSS_KEY_LEN, since netdev_rss_key_fill() enforces:
> BUG_ON(len > sizeof(netdev_rss_key));

so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the feature?

> > 
> > 
> > > +		}
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > >  		vi->rss_key_size =
> > >  			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > rss_max_key_size));
> > > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > the limit %u.\n",
> > > -				vi->rss_key_size,
> > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > -			err = -EINVAL;
> > > -			goto free;
> > > -		}
> > > -
> > >  		vi->rss_hash_types_supported =
> > >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > supported_hash_types));
> > >  		vi->rss_hash_types_supported &=
> > > --
> > > 2.25.1
> 



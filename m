Return-Path: <stable+bounces-215968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK0/MibojWkm8gAAu9opvQ
	(envelope-from <stable+bounces-215968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:48:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BF12E800
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7691630692DC
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099C2F12C9;
	Thu, 12 Feb 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLoAGlKb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rTEPpnE+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23042EB847
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907259; cv=none; b=gjp6imJeKvm6AM5U5gXZxi4aBjxGDcjslEQn3GpF6U6UXVA6Veb+PjX1RdcLhtV/JSyVUQvP0iQFRbswl2xOMX5Ku++31PQg4+sBmDOD3s7aru/xkzJjQuvhJuRBXHwmzGrGrDdMAmOESRGJkt1cwvhhIPCAOCX1lpZ/1ctTIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907259; c=relaxed/simple;
	bh=MV+loLSfbym18ym6CF0ldD6FyGE5WQufzZjWV/GujiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKyMoMfUONWvBDjGaYfmuqg637HMmgnJG/JONHC9KOsq45pbhsxt7j10dCBuiT6z/5ubVDUI9fLt1CSVkKOW1FTNtVaafnuVLfSG4sksE26ezFFSlp5hZhGn3gMVV7UaJZEFKWpHalB6b5de2dDLSQtPPbV2ncxZTR/ibQlAN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLoAGlKb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rTEPpnE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770907257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDKQzbGUuJRbgtDN0hG7BvdewQ/ExGQehaybklKCcDA=;
	b=MLoAGlKbfo/xXSs89VRXpTQrzs9zwgpmtjzZj8YyXBzTfnsCfeCvUBGTMrRhHkQblDr8Bp
	lt5blVSGwZIT2Qo9qLiLTwTesE/pdh+cJ0kDZMoRVssBFxXhmHqm/oRfsQ5oaB+qDa0v6G
	z4rCAPdHmVGsUgYfbuWPr3dB8xnvsmI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kfmQWGEDNVq0Ir_PJXQyYA-1; Thu, 12 Feb 2026 09:40:55 -0500
X-MC-Unique: kfmQWGEDNVq0Ir_PJXQyYA-1
X-Mimecast-MFC-AGG-ID: kfmQWGEDNVq0Ir_PJXQyYA_1770907255
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836cf00787so4429525e9.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770907254; x=1771512054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDKQzbGUuJRbgtDN0hG7BvdewQ/ExGQehaybklKCcDA=;
        b=rTEPpnE+eEoCgviilZ+8SMHp5jquRmqyuD/CvRqequ+2GOrNuBnpy9Dtf7geh7GWRR
         PA2zzOuYfpURp3uwNfZnmwkPy9gdbMSQHsGcZrenYlRhVEIA23UM8C7hasnAfseYQhVW
         xszuZZRdXyDvH0rw173ZE2rkBS27CWQwiT4wrfts+uQNi61jV5r845x5lUIBE18izqpb
         rCVQHgqQBOxCD3stIq7t/jLou8qVyG5Kv1kvEiPe3JBp0u9/kYQLyVjx9GL37ZNSI7C6
         eMvku0Fku5AJnh6wDIsSeUG1Qg5e141/YHbLb18Gr8vRMUGS64Y0eFfHraWD27n0n82f
         VBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907254; x=1771512054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDKQzbGUuJRbgtDN0hG7BvdewQ/ExGQehaybklKCcDA=;
        b=RaH0to6SGOeEFnoEhLt8kxpSW+ftES5V6YAxAxWIwt3aPdLQIN5Ai1xv2AmS7CijJl
         0OADo3XUF1qN/izmiA4t+SKDBhc/ziTG9JGYRj+m0lOAsW+NCkKpkazy5StNiKNig+lK
         /8G1FOl2kmg/pCbdsuj3eImPUXtjW31cOqKSvE5oKOZsrO9dp5qsWhxScRbN4dzviROi
         /msZSvWnF9xikBndQBueSjBQvD3U469mvfSSEI81fxh3S5stNKnju8l3iHsA6VdTXjC3
         az5gHBiAa1uVL69CtwjiIJIyg1ycYCq7/kFUrTtFw1s34wPunqAvn7PSxn1yoT5X61mJ
         SKFg==
X-Forwarded-Encrypted: i=1; AJvYcCWarr7WA7IcTV0gZd9qQVcC9N2JUeaXibzkFgRlFOhFlLCBSAYOiYRETR478NKV+SpKOY2m40w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtX4G8PYc9qxd7I43krHVUItugpSDt28AFuFTf+Udcw2xdkgfk
	IiM0nyaE511BYCYDbm2MdOijNyR7U5KZuCU3xtSYFuuDPW9EIEaGrecc81CuB3pbxREXaKBuGv+
	xoaJgu9T1Cl9eMSsFm1+sWARpBa2NZOJZjW1X2NPnwejA3DmzmcJd1YSXTw==
X-Gm-Gg: AZuq6aLnZqLYpzK9oRW26YBSHlMR7WSxhxL66u6Yt1JTC2IArm/QtFiX5/EEqqG3Yvs
	GC1u+a/c60xcWXs18drmA9IHQlrLh+HwtwQt8wwNVCw/bRWGONwSAb9y30yvXdnIVgpYlDVAq6O
	eK9q5JyOmBw9l5xiJTSEj893cirx7+g3dbp412/T0nDddB0Lw3TUzCA7ZW+l8uPqwtOr9g1WrJ+
	dDdKn4p1fHkspK6C8Z4gj/ge/HXAL0CzrvispJSepmuAe3jGj+9siL1fnlloID/kktQysnIvnVg
	sAFy3UwctaKtnOMAUXDxpp6Yhfeh8rGOpzYUMTyF1wSn0dglfUvFVHziFSp04skwf7yOgyI1UYF
	wmG0Y6JQNQdh6ZOtzkzxfRo5pvr4f/6jGQKSS4aKfumd0uQ==
X-Received: by 2002:a05:600c:4d06:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-483660306b6mr26987375e9.16.1770907254303;
        Thu, 12 Feb 2026 06:40:54 -0800 (PST)
X-Received: by 2002:a05:600c:4d06:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-483660306b6mr26986955e9.16.1770907253657;
        Thu, 12 Feb 2026 06:40:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba1670fsm77265075e9.4.2026.02.12.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:40:53 -0800 (PST)
Date: Thu, 12 Feb 2026 09:40:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3,net] virtio_net: Improve RSS key size validation
Message-ID: <20260212093707-mutt-send-email-mst@kernel.org>
References: <20260212130340.3540415-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212130340.3540415-1-schalla@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215968-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 5C4BF12E800
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 06:33:40PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with a type based definition.
> Add validation for RSS key size against spec minimum (40 bytes). When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> 
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..e61cea50dcab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,9 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE \
> +	(type_max(((struct virtio_net_config *)0)->rss_max_key_size) + 1)

+1 here really unintuitive.
It does not look like it's still used, though?


> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> @@ -6627,6 +6629,24 @@ static int virtnet_validate(struct virtio_device *vdev)
>  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> +		u8 key_sz = virtio_cread8(vdev,
> +					  offsetof(struct virtio_net_config,
> +						   rss_max_key_size));
> +		/* Spec requires at least 40 bytes */

move the define here then?

> +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +				__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> +				__virtio_clear_bit(vdev,
> +						   VIRTIO_NET_F_HASH_REPORT);


why not clear them unconditionally?

> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6839,13 +6859,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> -
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
>  		vi->rss_hash_types_supported &=
> -- 
> 2.25.1



Return-Path: <stable+bounces-219599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFPTLG3tnmk/XwQAu9opvQ
	(envelope-from <stable+bounces-219599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:39:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97419779D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 713553023D77
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2999A3B8BA8;
	Wed, 25 Feb 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuqX4oWe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og1JdZQH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54223A1A4C
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023038; cv=none; b=bH8eAfsWURBerq1YTSkE4c7X3/zIQZFTAU+zW0B1MCiTxI2hKYTSHKpeLMzxU2A1MZ8gz79zwZ1XlDHb/vsts+H9Ju233Pp7+DUJqlr+wdLOKsRsLdaTZWMM854faXrah9vtLt31qR6XSTw7a4U97DibM/MIaYWpTkGssRucpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023038; c=relaxed/simple;
	bh=6ESDdsRpQPQ0SeOTN/fV7zbAnEXELUkFgRiXWYOxcoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8+3cp2cl7JTERyM5ZVtqcD+q53Q5EZFSBlaO6HEQeKwdd4P/tihvwQGskSRpB8+CdXZFhX7Wbm7WToXqgEkdO+XqOukxV0zKMKGqO5PIl3zrE4LeFl26o+zTwY/Y/B5TRPUBld3MpyKav8Txy9c+AXWYsu5frl1Q21lQy8KTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuqX4oWe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Og1JdZQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772023033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKkynTuixvnYJo7kGdPVE541D6F3mGdAP62FmXJoy8Y=;
	b=UuqX4oWeanlpbvSgWCfDm11HO1nIYPHcfPPG/cE60u69PYxGaYpXGE63u6hbSjw//XvOMy
	FRZOzrShEwjGDCpkYrw8zk3XYlNcy0lEaA+lM3yqAL06z3Ba/xFv5ES7fqpnaPeRTgZWK+
	Yv8qh+HnYuNar/7S+r3bPvrIIWou3CM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-NAR14iyeNXSFJW5MwkwbKA-1; Wed, 25 Feb 2026 07:37:12 -0500
X-MC-Unique: NAR14iyeNXSFJW5MwkwbKA-1
X-Mimecast-MFC-AGG-ID: NAR14iyeNXSFJW5MwkwbKA_1772023031
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so64754755e9.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 04:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772023031; x=1772627831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKkynTuixvnYJo7kGdPVE541D6F3mGdAP62FmXJoy8Y=;
        b=Og1JdZQHPVzZL/kJb5zvQ9DZ/P8xC4mdnUHnE2F6+CfST3OzWuAohofBA+9a7cHZ/d
         9kvgmT7gbTJ01QNhgAW4U+HYIhtsaTyR0/fPowwDxH1mQA56tFEv8xyO9azhrke4Wcv2
         eUvwJas88HUh32E3H9F/UlxHSbzhaQGbctabpBanE4sMsRfYurOh339K59XzI0uo3slh
         qax0phol/TT20TMp6wAcOxH58ays7tXGZ/1g8Z9lIstGRF5rN23HffMcs+nxFmPmZusD
         bHKgPVGhPh7VrRaM2HM5VAx16maiiHFA3DCqf2R+GV1zRRNj9qkLlrGHzGjSErbZsNNz
         mYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772023031; x=1772627831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKkynTuixvnYJo7kGdPVE541D6F3mGdAP62FmXJoy8Y=;
        b=Op5+WgObZe3ABzRl8lgVyhbW5GuU4MwKsPIZIWr2KPUChkvDUaRZnQbOarmgobVkYu
         o2FzeqQ2aqhQ+Sr/tQ6tZfJ+FJCtksJOwEr6BYVP/MGi3/TJFaR6HN8hoU0QK2ckr6er
         mWtVoXHHryMtPJbOi0YE3k9f+R1VSX2bUoacCgd2Y1fJHY0VFyBa4DXTT5l+2BwT3C7G
         nJxcEKG3PHlTpJVHACN+Ikqoa0t4J4YQsA2S9aL+j3LYpHb1Ud1s/tGOOQNVoY3ldMn3
         2UzbEQt1J8gzrks7mBfWTf8XYQEBUoSexe8PVsnRGQs+S/Cs3Sy2IxhVhGCfkVVawaUH
         OYBA==
X-Forwarded-Encrypted: i=1; AJvYcCXARaoJm0U8LrEGciujS+aaoxJj5h0nYiE5OzQxGt+6ftokVlY8q6oAtPZnMGHcdsM6ccRSHqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aqERHvVTSguxLJRL67EyJuYCKwDS3qeuW33Cq0fKE/YZUbN0
	zSm9GX41eePVoy8KKTUU4Z6HwQ3ABQmxMFYrvBnP33pR+AZi0MwW3eTKSgK8SSgqp8Iyt0xTB9s
	cotng2E4RTtjn1nE/hZydd75826ubrQCNl9WIumppxsGwCoRG9yLtQhyHDg==
X-Gm-Gg: ATEYQzx96vb/Fo9hbP4fRpk5qcXYk+0S/+cSNfAtxYCeXY7paBTwh8VOmWhDftiOi6P
	IX4dmVtN4yHoxxlqhQM+f7m6YB4y+ROz212EDOO3YTWuXLdz7udkqiNcjhhnhi0/tuRdMjDYvNi
	7XLyMW8zI+nQT6Ta3vQLKoWMzhjSFYmNDV1eALrcatwfz+Lbhh3i4i12vFkInYLxZrY8cFa0jJu
	3TFz9Xpu79mkqSEJ7AytrlvwKHKn/lb3dGGiHQz6DXH7YGpRjO1qfOYsh67A0WJtgFDtD6/dGI1
	DyGYGEZubMTb4p9thqC8olkOdNtLfxn938VWEKCNkXcz9fc7n3e3L8O5diAYAk2NeDl9MHGhqKp
	B88yLsZD8r1VCj20oKw+GfxSLxcBaAF48fczfoUdm9aJsrw==
X-Received: by 2002:a05:600c:3105:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483c12c7d04mr19503055e9.15.1772023030979;
        Wed, 25 Feb 2026 04:37:10 -0800 (PST)
X-Received: by 2002:a05:600c:3105:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483c12c7d04mr19502495e9.15.1772023030473;
        Wed, 25 Feb 2026 04:37:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd73ea7esm60009925e9.15.2026.02.25.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:37:09 -0800 (PST)
Date: Wed, 25 Feb 2026 07:37:06 -0500
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
Message-ID: <20260225073537-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219599-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: CD97419779D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:34:28PM +0000, Srujana Challa wrote:
> > > > On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> > > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN
> > > > > to align with kernel's standard RSS key length. Add validation for
> > > > > RSS key size against spec minimum (40 bytes) and driver maximum.
> > > > > When validation fails, gracefully disable RSS features and
> > > > > continue initialization rather than failing completely.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > >
> > > > --- should come here before changelog.
> > > >
> > > > > v3:
> > > > > - Moved RSS key validation checks to virtnet_validate.
> > > > > - Add fixes: tag and CC -stable
> > > > > v4:
> > > > > - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss
> > > > > key
> > > > size.
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
> > > > >  1 file changed, 24 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index
> > > > > db88dcaefb20..eeefe8abc122 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -381,8 +381,6 @@ struct receive_queue {
> > > > >  	struct xdp_buff **xsk_buffs;
> > > > >  };
> > > > >
> > > > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > > > -
> > > > >  /* Control VQ buffers: protected by the rtnl lock */  struct
> > > > > control_buf {
> > > > >  	struct virtio_net_ctrl_hdr hdr;
> > > > > @@ -486,7 +484,7 @@ struct virtnet_info {
> > > > >
> > > > >  	/* Must be last as it ends in a flexible-array member. */
> > > > >  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer,
> > > > > rss_trailer,
> > > > hash_key_data,
> > > > > -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > > > +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> > > > >  	);
> > > > >  };
> > > > >  static_assert(offsetof(struct virtnet_info,
> > > > > rss_trailer.hash_key_data) == @@ -6627,6 +6625,29 @@ static int
> > > > virtnet_validate(struct virtio_device *vdev)
> > > > >  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> > > > >  	}
> > > > >
> > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> > > > > +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> > > > > +		u8 key_sz = virtio_cread8(vdev,
> > > > > +					  offsetof(struct virtio_net_config,
> > > > > +						   rss_max_key_size));
> > > > > +		/* Spec requires at least 40 bytes */ #define
> > > > > +VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> > > > > +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> > > > > +			dev_warn(&vdev->dev,
> > > > > +				 "rss_max_key_size=%u is less than spec
> > > > minimum %u, disabling RSS\n",
> > > > > +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> > > > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > +			__virtio_clear_bit(vdev,
> > > > VIRTIO_NET_F_HASH_REPORT);
> > > > > +		}
> > > > > +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > +			dev_warn(&vdev->dev,
> > > > > +				 "rss_max_key_size=%u exceeds driver limit
> > > > %u, disabling RSS\n",
> > > > > +				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > +			__virtio_clear_bit(vdev,
> > > > VIRTIO_NET_F_HASH_REPORT);
> > > >
> > > > you flipped the logic here and it makes no sense now.
> > > >
> > > > Did you test this path?
> > > Yes, tested with Marvell's Octeon device.
> > > >
> > > >
> > > > So if device is powerful and supports a very big key size then...
> > > > we disable the feature? how does this make sense?
> > > The intent isn’t to disable the feature on capable devices, but to
> > > ensure the driver never advertises support for RSS key sizes larger
> > > than what the net device can actually handle. Even if a device reports a very
> > large key size, the driver is constrained by NETDEV_RSS_KEY_LEN, since
> > netdev_rss_key_fill() enforces:
> > > BUG_ON(len > sizeof(netdev_rss_key));
> > 
> > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the feature?
> Our device mandates that hash_key_length must be identical to rss_max_key_size
> to guarantee symmetric bidirectional flow hashing. If rss_max_key_size is larger than
> VIRTIO_NET_RSS_MAX_KEY_SIZE, clamping the value is not feasible.

I don't know what to tell you. rss_max_key_size is just the max device
supports. driver should be free to use a smaller size.


> > 
> > > >
> > > >
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct
> > > > > virtio_device
> > > > *vdev)
> > > > >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > > > >  		vi->rss_key_size =
> > > > >  			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > > > rss_max_key_size));
> > > > > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > > > > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > > > the limit %u.\n",
> > > > > -				vi->rss_key_size,
> > > > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > > > -			err = -EINVAL;
> > > > > -			goto free;
> > > > > -		}
> > > > > -
> > > > >  		vi->rss_hash_types_supported =
> > > > >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > > > supported_hash_types));
> > > > >  		vi->rss_hash_types_supported &=
> > > > > --
> > > > > 2.25.1
> > >
> 



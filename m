Return-Path: <stable+bounces-232725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGckD+fVzGnnWwYAu9opvQ
	(envelope-from <stable+bounces-232725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:23:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9B376B4B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E980B30532EC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AC3A9018;
	Wed,  1 Apr 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hubbP+T3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjq95id0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87828377574
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031681; cv=none; b=aEegUHdA7o6Pyyd7XjNHK7+ctMlaojC7jGU6OOgLieX96cf9EOJgGAGJzuoIxCVfDnULTLd4RAEwFJfi73YUMIr4fBw8HE/JC+sqJcWwyzdL1M0dAkuUIZvo98lp2/DVFIefTKtyNl4UiV8uSSsUeUaDCkvbh6iiLSZyEuLipeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031681; c=relaxed/simple;
	bh=B5Tle2fRi76KfDMCO8D4EC6UyhUw+743wpGBNKtB0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7ITeGFTN6j717B6LbWv7stgo8tUJfD4qb/Di+Eftw9QnYYA80o+qG9r96GgQinta+a2tU4b9BrpD8YUMIs4MzHup0nX0yeokAMaDcf0TnyucbKCXrSx+B3VcaprpIXYROnBci/z2Bjxkq3Q2K+OW2qGF0X68SXHDqaohpXjpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hubbP+T3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjq95id0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775031678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
	b=hubbP+T3DqH6VmwgNZNLMgRo/DMlAsz6jqpH6AtxboKZDyt3jJwKbkMoA+G/i4y0xn6oDw
	fVh7Rwcmwb50/3G7m7fyk+4QnR5uPlodfOF0PKoSRWtegAkmLtxtNirCNbzYeDG2QdWnNY
	wY+2ow1/EZdIzJd8xIbbvhrpuo+emF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-k1ecntHNN-ynIa2DZCrYeQ-1; Wed, 01 Apr 2026 04:21:17 -0400
X-MC-Unique: k1ecntHNN-ynIa2DZCrYeQ-1
X-Mimecast-MFC-AGG-ID: k1ecntHNN-ynIa2DZCrYeQ_1775031676
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d07f0aca0so1309586f8f.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775031676; x=1775636476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
        b=Fjq95id0xir6J/b+Gbz7A+6NBWMs8P0GMtCNlFhJvMa/+p85jkM/u660o3lR1pBAe5
         aLtzmHE/zvDCzsKcKu42DGH0DKNHlqETcUf3y90leNzUUS89R2l6kClpql2L3sl5JXfP
         RzzFOhierK9x75yBmCy+e6PLLLUeHwuy66dwzu1lNMTL6KaUsiVkuqGSaM2MwDHLSKst
         YyfALx9dOF+8M4ZWDTqlTjMeFwPmLf/EPjNkYSjpsLISu0dHY/9HkZZVoQsGu2ESVS2X
         iD0ZtJCynmed5GxGagplb8TZcVkyCqJZoJnUXNlP39LLlp8DSiBpqVJq5c9rV14O6oZX
         6tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031676; x=1775636476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
        b=JPlYcklL+F0ZZ6wbQtY9LjBFpfabnbgM/GUIAFtyBVhKbgw9f2aWjDV0XhFFXHl1ty
         PoVSvahZV1gDj2eO1TTuC383dAk40Gnf+vniPiX0luxXlGzC8KaxzVU1iGxFRBJ0hMWp
         R9WHu6miiwNjYA2cAFre3to1FmIS3zwbv4ufg/AGbau92zlb164DRv3lt6wKYw8wi9fv
         +U/g8prDqfY+vQUblZZ7HgAalsrWboTKP0IkD0gg6C4zzgs7n86MdhEjy26MpAUTsvpC
         akQpPbPdnUnFdgV8EZ7I/AgK81C5zT88vXjzAZIrlFnuUbiq0kleWWsxmGcHRCNo5y57
         N0nw==
X-Forwarded-Encrypted: i=1; AJvYcCXX69LF+DuTmlt/HFmLeADOaqTT2nQdLC9MR8VUhzhk31KHbtKwWnNF0aa3D/GlZrN9m9UfZH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaUgzVnBrr2X3OIMem28vK8sZPUK8k4ZNHA8TkFN+uEH/GCBM
	4fsdagZnQyRb+moz6hp1vUKRbhSrjfcsf8nN8ZhpDhQWu7L4le9RAQ+1aMRBBe7Mfe6ZKBX+46v
	AdbpJJSCZxKYNRJdIIUGhSIopEI7itxXtbsgMmGGAxv14Uf6PFAABB5bLXQ==
X-Gm-Gg: ATEYQzw3kMCoxY9GrzYad8PX2UfcQa7G+L9cuRv4XOTIB595QklXrEKksSR6Xuvg3Ri
	7Sl1dXTjJRDwxfS8UxnicVzsp0kc6/4FVUvdIFLAQbC4iX0qfG8wAJB6tDZcgs+wv/BEL6Cc3Dn
	o2lTaTvnn77inh4eHhDiASbvjHRRUoaXfw7qRGJnWCWFDXARJDnAsnyYWbViTa3SYbO8Kh+sFUs
	Bh7t/sGQ/XgunH0LH4VdNo80OszQ0vKQIa8fmMqXwKS2yhpr2iCo2gJJllJge/G5sxGav7X8Rkh
	pZrbEdDSRScKp1Yw1jE+GiQbqJBaQrBCj9YJtytUKSMWiJ2ycgjGT9HjrJznLmXLdu4BN/6o+G2
	e+FoE9Ex+DbrFgG4w
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40333115e9.12.1775031675923;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40332415e9.12.1775031675320;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9728sm101815975e9.1.2026.04.01.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:21:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:21:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260401042105-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CED9B376B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:53:44PM +0530, Srujana Challa wrote:
> rss_max_key_size in the virtio spec is the maximum key size supported by
> the device, not a mandatory size the driver must use. Also the value 40
> is a spec minimum, not a spec maximum.
> 
> The current code rejects RSS and can fail probe when the device reports a
> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> and keep RSS enabled.
> 
> This keeps probe working on devices that advertise larger maximum key sizes
> while respecting the netdev RSS key buffer size limit.
> 
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srujana Challa <schalla@marvell.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> v5:
> - Interpret rss_max_key_size as a maximum and clamp it to NETDEV_RSS_KEY_LEN.
> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds NETDEV_RSS_KEY_LEN.
> - Drop the separate patch that replaced the runtime check with BUILD_BUG_ON.
> 
>  drivers/net/virtio_net.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 022f60728721..b241c8dbb4e1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -373,8 +373,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -478,7 +476,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6717,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	struct virtnet_info *vi;
>  	u16 max_queue_pairs;
>  	int mtu = 0;
> +	u16 key_sz;
>  
>  	/* Find if host supports multiqueue/rss virtio_net device */
>  	max_queue_pairs = 1;
> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	if (vi->has_rss || vi->has_rss_hash_report) {
> -		vi->rss_key_size =
> -			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +
> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> +		if (key_sz > vi->rss_key_size)
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
> +				 key_sz, vi->rss_key_size);
>  
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -- 
> 2.25.1



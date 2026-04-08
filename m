Return-Path: <stable+bounces-233916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFX8Cj9f1mkfEwgAu9opvQ
	(envelope-from <stable+bounces-233916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:59:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7906A3BD4AA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D28300CE60
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8D2F3C3E;
	Wed,  8 Apr 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D24BSFF+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsT6pD16"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4B1A4F3C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656483; cv=none; b=m3CDfd50v+6gbr8omQnren+fJM7CCn40eHQngxcSurhI44uEvu0QcPl7gh/oHP23KJ2+3cNv/F8Hif4NFLgu6LS5n3zvd/OkdrzNS8XaCdw0l7f1gOGPq/GpSL5PqYceFZUnvwdZDO5D/VZwvaQxxxr1f+dz+JIRbeMz4REKqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656483; c=relaxed/simple;
	bh=0KOqbOiYJIlnEkVCn8zt7vLTqP3RL3E9EX5XuxwnR/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVV/KExGKDqJ2GKMVQPJpH645VA9jtxiC2XOc1fnRABFITCU7UV4RxgTRF8mHrCqkRvRubhzmYFOZMhN/l1AmGoh4giePSjj2PLnQ9kL4wN2CwYG45zAc6VXs4PSVYoUMMbABzUloiNW2+Fz0k21HFNgWKUmH9idzrqFTKL1U9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D24BSFF+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsT6pD16; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775656481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arj3RsUzQcmlZz7YTDqVVPfYiADusrs5BdhgKgK8KVU=;
	b=D24BSFF+8myE4A4Yn12Cv7pJmHctEGTEwn+sq88+Lg+e0fipVcu86WZfDKObATLjoEHNoA
	RwRf2yFtLPBqXCKpLkvcLWdeOQqGfuufU6B6N2JoyWIcZ6hUPXuf4GEeogBFzzvG3KC5ez
	DY46Icx8EPjXU42x/NchozP9G65KeZs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-UuCxVV8qOt6pLJbDQ3X9yw-1; Wed, 08 Apr 2026 09:54:39 -0400
X-MC-Unique: UuCxVV8qOt6pLJbDQ3X9yw-1
X-Mimecast-MFC-AGG-ID: UuCxVV8qOt6pLJbDQ3X9yw_1775656478
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9c1d5a149cso457412166b.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775656477; x=1776261277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=arj3RsUzQcmlZz7YTDqVVPfYiADusrs5BdhgKgK8KVU=;
        b=fsT6pD16v5RzAY3SehdWvdTuznXAZzmxFP6+AiLI+zmT7HWRT9/3/W8ealwSX7Ox5q
         HCrhSxF4vr/9mhKYGUstnlWbRrfX1SAhRaXrgnCNeiKlpPsbVMPDxOb7nRNq3CEE+sdd
         zSy+aKpQiR2Rbq44h2m2BZEK8S6ScrGS/rJQ/gAiooC5bHP/yJZ5XIHqVrgK/v5pDbsI
         xEdVlQjqpsqQNA6DBSH8ezNHcq6XH7+h8M73EeISOizqkUZEeABVFWM6h6DSsPyhjn9N
         qAXnMwPNkczuCQbm5iJurxDU9idV2zZdTn6Nmw/8k02zl6bst+4JumBpm2Vc7xzJ4Rwr
         lhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775656477; x=1776261277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arj3RsUzQcmlZz7YTDqVVPfYiADusrs5BdhgKgK8KVU=;
        b=Za1MpM2maJQkPQYvOpGDTD2GEe7CYTT5/OhFRQkMoXVocC0HTQB5CuUxh2qk7jPqIr
         FHvKX9a4VTWH0ItQUdefSw2USEX/cAzd4F7JDtmBQtA0GL1yCYyocosxroUnENUNGJzF
         /jwBKBON0xmjfE2bWgjvKtz1PjOcI3+YvgB77yM6IACzLWpjbOe/2//eK+e/2aBPQ658
         nyMoJLhQWKlXFqnoNn2P1I6S/FTTwk69Moq/5wo/3CLdl1jgSmh+66HwWz/ggXo4DOMs
         2vV6KRxxT1NCTyFJSMDuiuLGgVF1CE56iG91r6wqDNhR9WZyifIiSqaCYyqF/4KGPpKA
         TkgA==
X-Gm-Message-State: AOJu0YwG9CP5rL3yJH/1Mfypce/U9Omf+YtNYes11m3CxLvyu2L3MtJg
	ppMd6lDFDzUDYoiiMMO3896ELmLKO7p6Nm9fjFoAC6UY4LmoJTjTfkLzTrCl685ycgnOndOoKeF
	KHMRIymRAc2KIZW0fQKAJbNphOmrv9eIt+5aI1CqKTQQpgvcDZ+Vl6IcsNWZNkV6Fa42K
X-Gm-Gg: AeBDieszBqbjy+V4Br+cbLtBlt1Elg0RRT8UHDtK3hPi4t4YNisKjTamY+HlYtTrcpE
	6oEJdNzTQ9S5eHPXAxKthvI38WcY9/6ozHuZjt4fz+B5vYUi3xzG4SlsznDO5/WXhUEzDXHDf9E
	xKXHeBPhR/2QM8P7mMy4+NApW/CmzOQ3m7g7Qyyze32JMEfNujiT+hfpTU9NA5tVsQA3H7KGgEM
	oYU63c1QYBjgDuzL2B2Aero1UShXDaPmWk4ysYxa8TTkgc7TCcASMXaiSvQnr3fGHxU+heZg0lh
	7VXRKPpeacmscrY+ipiDN0as1cSCgONBos9NYwWEotCq6WbfFyTeWc8EK659Qt3HvGB0hXfdbgl
	B5rfUwA9lk9ogUJGbhT2UKuomP5Bq8su9CnJUIFQxcrs=
X-Received: by 2002:a17:906:209a:b0:b8f:f08a:4b80 with SMTP id a640c23a62f3a-b9c6742fc96mr775328066b.3.1775656477390;
        Wed, 08 Apr 2026 06:54:37 -0700 (PDT)
X-Received: by 2002:a17:906:209a:b0:b8f:f08a:4b80 with SMTP id a640c23a62f3a-b9c6742fc96mr775325466b.3.1775656476874;
        Wed, 08 Apr 2026 06:54:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d0287b5sm650668966b.56.2026.04.08.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 06:54:36 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:54:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260408095309-mutt-send-email-mst@kernel.org>
References: <2026040856-ploy-antiviral-fecc@gregkh>
 <20260408134351.1100654-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408134351.1100654-1-sashal@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233916-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7906A3BD4AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 09:43:51AM -0400, Sasha Levin wrote:
> From: Srujana Challa <schalla@marvell.com>
> 
> [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
> 
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]

Does this not make the subject and the commit log misleading?

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/virtio_net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9ee3465082c5a..0fcd662d15d51 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3796,6 +3796,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	struct virtnet_info *vi;
>  	u16 max_queue_pairs;
>  	int mtu = 0;
> +	u16 key_sz;
>  
>  	/* Find if host supports multiqueue/rss virtio_net device */
>  	max_queue_pairs = 1;
> @@ -3915,14 +3916,13 @@ static int virtnet_probe(struct virtio_device *vdev)
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
> +		vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +		if (key_sz > vi->rss_key_size)
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
> +				 key_sz, vi->rss_key_size);
>  
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -- 
> 2.53.0



Return-Path: <stable+bounces-231441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC50HNjey2m0MAYAu9opvQ
	(envelope-from <stable+bounces-231441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4236B2E0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 112D0302D9D5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96F43FEB11;
	Tue, 31 Mar 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbw6UUw5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKzRnGHj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4D3E3DAB
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968530; cv=none; b=YaZsshFcZS9COC57wWNdVE778rirvVVfdeqXeJ9kVgQmnosaIPSFT6EDB3WKpBfvuJNWhWzY0NQd3dwWCbRpDTjXGzpRO+ah/E+aUbDd2fhbV7Snyp5dHaiEROhs1LhOP4Nfnbp79RkVfhDoTB59BeMidCSZi2YUVk44kxJZehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968530; c=relaxed/simple;
	bh=BJIMrk2MYSv2FDeHUUdOkp6wdcv9uNwI5U0yUBOXYVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3+n0OvjC1JekMcqy4QLvRt6M4yDXnSFsSFhtLgYdIoqnSkS75ZUom7SfJ3a5CE1CG1aVYFG1Sj4RXFgZORkhD+1ynZZJFgKW4DCYFvmm08QbxBM96wUIAVVMLpByWipfihkCii1kOJW7OJE5McD2Iih+P8ximgwRD0PsMuUsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gbw6UUw5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKzRnGHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774968528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO8xgLmSYcxawrJhbHfOO1eOZxDKPmONKgmhbq8TlcY=;
	b=Gbw6UUw5UIaVem2sgIUZv7kq8qOu7s+3iYX95U6fAXT+i+bZ3FINpWloRlm4BClzSevXlK
	qRVk9Z0xrX5z50UeYSEN6pjPJjXnVaoyGWKI4s1RnpGjNJpjftKkxwBG9N5QFkeIfFD/vD
	8ZZC0VAcGMdwAO0IRNm90KDPr0TisDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-NMafxTJNOFm62CuM6mj61g-1; Tue, 31 Mar 2026 10:48:46 -0400
X-MC-Unique: NMafxTJNOFm62CuM6mj61g-1
X-Mimecast-MFC-AGG-ID: NMafxTJNOFm62CuM6mj61g_1774968525
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so41840905e9.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774968525; x=1775573325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uO8xgLmSYcxawrJhbHfOO1eOZxDKPmONKgmhbq8TlcY=;
        b=aKzRnGHj308wMRZPrWd6JJ4TzdRnAFqYuSJK6kD86oVGq7JhzLls1TFbgEQNVeW9Fc
         cfmliZVH/fZDZAjCJriyVaHUoEhNHTOS38mIFnZbXVUFshAal1Me9G6DDKE+Zuuq8y6S
         PKxq5qVasyiR7b5fKIHs3W2YOXiUgglxLUD8NJuV1nDnTyRuJM4Sl6JCBbmBpVaJEw2N
         5sSIw15cXCnjJYnOW/kl3H6ayQSoajx0pfr75mDKa3Oidkx430QZPlmL8F9/cjrj3Ftj
         f7yWgTdpOV5CP6gvUMKyiR2NQgwB9cpGH4/U7ySLmo6MkX3U6JEq0+/b4+N4/9xOXsWG
         LGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968525; x=1775573325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO8xgLmSYcxawrJhbHfOO1eOZxDKPmONKgmhbq8TlcY=;
        b=pgKKSP+4zvn7NioWij7TqQOokhZ1eSiwMBZUP2xEDhqMP/tG4puGMBUt34Jfqc5wVS
         glqjo5yaR/dxjRJmpr9fjqjRTshFnbgRHgHsl0/tx9qT0Fj6Tnda647btZ3xtOD8DbPK
         Mx8sANwkk3Xt/nOSqbfo+f6/Gmj4+GhSuLe+A/ObV3rJUfzCS0RsvJqrYlp1lRNVzS/x
         bLfs67lBcSAKBviusLn84oQryCIZVZtPw5ontzSo+eJKqxkwnJB5N/LAklt1Mb6K7tHW
         nfXmSycsPVVDMEgCaY+byndrvVYjCCospIhXwEFN2Bmqupx6D9X9H3yt7DhwDhcKCIqo
         JULw==
X-Forwarded-Encrypted: i=1; AJvYcCUbyeeG5kDMfc7xOHWM9rPbvumS8s7VZ6z+tFk86sWdGuwxyYMboimgObRCG/6khwPM1DVzQAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzljz+qWMUV1+X1DdYOAv9uGRtpnM/FP34taE6P0fpVgvmtv3vC
	SKhEf51NGnjNeTe/SomSGESB3xC379gkMDcGBK7j6U0u4SaG3CKpiHP4v15i7Xj6nnKOLX4JK8+
	SzwvYk1sXEbDd+w3kU8SCvk5geoY6p2KY3vO0p6pmkTcP832TIZ6QpXPO/Q==
X-Gm-Gg: ATEYQzyWCKLNt8hr4YBsksB0iDZQqS29MYfgvSm3FDKjgf00Du4Wa+PAwlgn+p7lEce
	q5iUzo0xBI3LewuC94VByCQARdbUUnSvgahFX19YmlcsmGRZJUkT2LjWY6ftsBI6zZQD7FLlLZ1
	9y/c3IBn0jwKC7f05Qat8aTOSKUXW54IbRIcVRKMVZB6QZuA0cgksIa14NANZfi6/Gpx5T5hKzU
	GHpjbHrXcqYJX5+xoA33j2CUC1mB7vhfR4VvGqv2qSC0C4qCNcgnQ4Iu+7FtWunAOxQmQUYNPa8
	wJaBZZQ2DfYaaw4mHtUdDuujuv5U31DIcYFUOQqASChCIVL/ExQJX4+22DtJjWa+U3K5UlliW4n
	tvOxmqqjSl2/alCqf
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr267996825e9.26.1774968525210;
        Tue, 31 Mar 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr267995995e9.26.1774968524618;
        Tue, 31 Mar 2026 07:48:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8797ecsm38127025e9.8.2026.03.31.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:48:44 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:48:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Message-ID: <20260331104737-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231441-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 16E4236B2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:39:02PM +0200, Paolo Abeni wrote:
> On 3/31/26 3:29 PM, Srujana Challa wrote:
> >> On 3/26/26 3:23 PM, Srujana Challa wrote:
> >>> rss_max_key_size in the virtio spec is the maximum key size supported
> >>> by the device, not a mandatory size the driver must use. Also the
> >>> value 40 is a spec minimum, not a spec maximum.
> >>>
> >>> The current code rejects RSS and can fail probe when the device
> >>> reports a larger rss_max_key_size than the driver buffer limit.
> >>> Instead, clamp the effective key length to min(device
> >>> rss_max_key_size, NETDEV_RSS_KEY_LEN) and keep RSS enabled.
> >>>
> >>> This keeps probe working on devices that advertise larger maximum key
> >>> sizes while respecting the netdev RSS key buffer size limit.
> >>>
> >>> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Srujana Challa <schalla@marvell.com>
> >>> ---
> >>> v3:
> >>> - Moved RSS key validation checks to virtnet_validate.
> >>> - Add fixes: tag and CC -stable
> >>> v4:
> >>> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
> >> size.
> >>> v5:
> >>> - Interpret rss_max_key_size as a maximum and clamp it to
> >> NETDEV_RSS_KEY_LEN.
> >>> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds
> >> NETDEV_RSS_KEY_LEN.
> >>> - Drop the separate patch that replaced the runtime check with
> >> BUILD_BUG_ON.
> >>>
> >>>  drivers/net/virtio_net.c | 20 +++++++++-----------
> >>>  1 file changed, 9 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> >>> 022f60728721..b241c8dbb4e1 100644
> >>> --- a/drivers/net/virtio_net.c
> >>> +++ b/drivers/net/virtio_net.c
> >>> @@ -373,8 +373,6 @@ struct receive_queue {
> >>>  	struct xdp_buff **xsk_buffs;
> >>>  };
> >>>
> >>> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> >>> -
> >>>  /* Control VQ buffers: protected by the rtnl lock */  struct
> >>> control_buf {
> >>>  	struct virtio_net_ctrl_hdr hdr;
> >>> @@ -478,7 +476,7 @@ struct virtnet_info {
> >>>
> >>>  	/* Must be last as it ends in a flexible-array member. */
> >>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
> >> hash_key_data,
> >>> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> >>>  	);
> >>>  };
> >>>  static_assert(offsetof(struct virtnet_info,
> >>> rss_trailer.hash_key_data) == @@ -6717,6 +6715,7 @@ static int
> >> virtnet_probe(struct virtio_device *vdev)
> >>>  	struct virtnet_info *vi;
> >>>  	u16 max_queue_pairs;
> >>>  	int mtu = 0;
> >>> +	u16 key_sz;
> >>>
> >>>  	/* Find if host supports multiqueue/rss virtio_net device */
> >>>  	max_queue_pairs = 1;
> >>> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device
> >> *vdev)
> >>>  	}
> >>>
> >>>  	if (vi->has_rss || vi->has_rss_hash_report) {
> >>> -		vi->rss_key_size =
> >>> -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> >> rss_max_key_size));
> >>> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> >>> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> >> the limit %u.\n",
> >>> -				vi->rss_key_size,
> >> VIRTIO_NET_RSS_MAX_KEY_SIZE);
> >>> -			err = -EINVAL;
> >>> -			goto free;
> >>> -		}
> >>> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
> >>> +rss_max_key_size));
> >>> +
> >>> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> >>> +		if (key_sz > vi->rss_key_size)
> >>> +			dev_warn(&vdev->dev,
> >>> +				 "rss_max_key_size=%u exceeds driver limit
> >> %u, clamping\n",
> >>> +				 key_sz, vi->rss_key_size);
> >>
> >> NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
> >> not needed, and the warning will never be printed. I think that the
> >> BUILD_BUG_ON() you used in v4 would be better than the above chunk.
> >>
> > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > I added the message to make clamping visible in that case.
> > I will remove the check and send the next version.  
> 
> I'm sorry, I haven't looked at the historical context when I wrote my
> previous reply.
> 
> IMHO the additional check does not make sense in the current net tree.
> On the flip side stable trees will need it. I suggest:
> 
> - dropping the check for the 'net' patch
> - also dropping CC: stable tag
> - explicitly sending to stable the fix variant including the size check.
> 
> @Michael: WDYT?
> 
> /P

I was the one who suggested it, the extra check is harmless, I'm
inclined to always have it.  Less work than maintaining two patches.

-- 
MST



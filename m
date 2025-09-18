Return-Path: <stable+bounces-180547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2ACB855BD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E363AE414
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DD430C620;
	Thu, 18 Sep 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVvuEHXy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADA1DDC2C
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207151; cv=none; b=NnI35k7QpbWNsU3J/aIEfiLoAjRiS2YiRbuzwS78ziR5Jh4Ol+8uBgCc+8IeNYwutAgVQp/6iyyCSj8zVuoLFfutyurlADxu1qXi2LWlIctpkDFcEUTktuNtCR/ITYx1DQQgJwk8e38VCM3dUE8toagSJUWVBDM7kNzE1s8Gq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207151; c=relaxed/simple;
	bh=877fy4JwCj6Yt7dwkYYuI8E/1ziIUPjIl8VIeeaY+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx7/0+dFlo2vrn7tBM/UPg3Tpy3/BtUYVWbyaof7TcHJmhUSoi+6qCA8/VBMfXnIbp5hVAYf29gV855ZJkuojlPGjcQGPpfxnni+gdOsYGqcpyzpjx8SGc3Q3RucaRuOMlZAOhxyiyWCSk0AXvcSUP+HvDE4TmMdKMTA4ag8k0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVvuEHXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
	b=jVvuEHXyyx2qRRl9+A8XcdWiFUC36jVy3Glzrc7VCHOMFIF700KlwkzHADd8FzKXHehWOE
	fH3SyKpjNf4y3VNMXsWBwa66EYZtWhp9J0FHaTVdffoCuyTAHfylPVU8brrwinyiCHHUny
	eA1AJ9rmMf03cJU8dyP6zJIMkaP9/vA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-4nFK8FRFPWqTHHT1rACubA-1; Thu, 18 Sep 2025 10:52:28 -0400
X-MC-Unique: 4nFK8FRFPWqTHHT1rACubA-1
X-Mimecast-MFC-AGG-ID: 4nFK8FRFPWqTHHT1rACubA_1758207147
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso9795145e9.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207147; x=1758811947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
        b=hRZPWP9KXJXzM8ew8YhIt87QWidorFlDbd1wPux3LQ+cJsY7K3yuzxAe4dHSDIXo67
         9/u6R5xhs3x8RxvH6PL1dAqyqgvlG+hR/L02EH6wLwlxBBiOed5NM/eY1ubeGM+lCZkj
         FWn1QYZvtDk4WGDCHrr5ImMP/SfAyxWB9Javwnz97U7LqiRvPGZRMv0z+hghA+N8FWJi
         AKTo2UXwsNdnyG0zF4bTCDKBwVU/KlOaNbk5ifzAOiVoahyEJMHdyRhHHp+/MCQR8A6T
         hz0AaiG3y9uoiJ51acexz1H5kOPFyE7jcc0HgntVQAl2euoZ24YIHVI3afP4JWiGn16x
         i90Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEcGrngk3VfR7oMu+l1xiOomNVUItT9QgcPmIq2uPUsV55o/fsnbt88wxz9aiSCEu1n/yTb4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0A4nYiIzTR8+6T5wch8KpPZyY2cXCzZI0Rvb6ysxpjltYfzw
	fdkGjRiyi+QThE3NrHiM2ePcLvLwOZQHj/LTmtkhVsWCqhLDhsQfbjIY3SDPAn0/sNn3ryBPja8
	3BWxvoXJFib8mYLeg2bXQ5LejCUjwUL0jq1aoHvGBea9kAbo1mwnQ37K/aCWA55CNhA==
X-Gm-Gg: ASbGncuq1lzQYl8mPrrwff4Si4tERD0lQMEuLRvz+iAPyHBTeisPa4vKafSxKhtXPWI
	EAZNMZJU3vPtHWu0bf9EmwJyE5uVSZWe2ULfDGDjkY7smM0j/AdRZZ9buFAHEKauNGoRGWANTYx
	miLqNbsAi5M+89uYzxRXe2VALpjkxTBlgsym72gBwb3C020E/Bbp+V/OL2OnzhsBr1aVwPAS8ZT
	KNYrvBLYxm7PqYf3LltCFjEWFmpWztLRaWqsizfOC6HwIX6s/kb5wDZFmnl6uBj4tI4RqbtOLGu
	g8/DW7D6WcTDHV3aRdyeh/RFqXKZl7z5nhI=
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283928f8f.22.1758207146768;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwMRBHuFFqMWYMrzOGs/Y1LvHSUdwEyMMdSeQZSTNEKri6ViSDAyQsaqS+nlL7xHwrs2MhA==
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283908f8f.22.1758207146339;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm61479685e9.0.2025.09.18.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:52:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:52:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
Message-ID: <20250918105037-mutt-send-email-mst@kernel.org>
References: <20250917063045.2042-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917063045.2042-1-jasowang@redhat.com>

On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
> 
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I queued this but no promises this gets into this release - depending
on whether there is another rc or no. I had the console revert which
I wanted in this release and don't want it to be held up.

for the future, I expect either a cover letter explaining
what unites the patchset, or just separate patches.

> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  }
>  
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> -				      bool *busyloop_intr, unsigned int count)
> +				      bool *busyloop_intr, unsigned int *count)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
> -		vhost_net_signal_used(rnvq, count);
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
>  		/* Both tx vq and rx socket were polled here */
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>  
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> -						      &busyloop_intr, count);
> +						      &busyloop_intr, &count);
>  		if (!sock_len)
>  			break;
>  		sock_len += sock_hlen;
> -- 
> 2.34.1



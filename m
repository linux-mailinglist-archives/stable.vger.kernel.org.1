Return-Path: <stable+bounces-192480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2CC34335
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 08:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29592424965
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68812D23BF;
	Wed,  5 Nov 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csmGWJq0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mzNQI/IZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240C28A3F2
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327079; cv=none; b=dxSBYGUqDt6TVHkqG+nBMJeLg4jeQzpt2CxapV19JghLwyHj8sSuNMsU4OVnDtCVsEZPtSy9brsbxjeCCxUeYA8D32UcbeKrByhHvVbELmTttCt3XsMrt/d9a3FiWPAnPrffjN8SJtid3xkxcdKWvVWL6FMylP0MzOzXh84/n3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327079; c=relaxed/simple;
	bh=LXagqlSMvKmDxH5ta3oYe3mIclEopnmgdrr3vFPfBvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDfZSdTWqVTXSXJ3PzV1vJnJ0w7OLL/qnXbbCt9LVEBDk1P5sVMrzZs+5EaVSRw8Hvirt0Suv+YzFr9dcG8o6caaIpBu3PthBpc/NocUIIehJINAmFqKGwQRmwu7JUIONXvPkb0vdlG2voDU6qe72D6ZUuzgMm27n24VVOreP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csmGWJq0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mzNQI/IZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762327076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
	b=csmGWJq0rYnCRBS1D6nkJ6Z1D+h9tboI87rTPdNu13W+EfduQQtGnx6awHD++KIvkdXGsk
	eyyY9Mc14pySUq05PMQz2VPb/JJiEzjfIPksupU6If3ctCO4G/ZLvIqq2N2iGrocbwS2NU
	gHR1kh3XD3X/Zf/BQLuN30CxWkQw6nU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-JXq1otfUPnyPdnlMuNWE2Q-1; Wed, 05 Nov 2025 02:17:55 -0500
X-MC-Unique: JXq1otfUPnyPdnlMuNWE2Q-1
X-Mimecast-MFC-AGG-ID: JXq1otfUPnyPdnlMuNWE2Q_1762327074
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso3056702f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762327074; x=1762931874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
        b=mzNQI/IZyZlS94B69CpIpUfNlAZXhUA3bD1GHsZ39oTpRTTH3FRXaGpBRQgiWm+xDr
         D3iOzylzkQ3y3V4lUpLqB8Y71cOc/NViPIJI8el+WC65KSe8XEo0dRcXUREgr2rLWFgN
         tN0YvGPu2wfJWNku+6Dh2ImWui9imbABZbWmimc5SHgvlFUGiGghkdKDS7e0km3eL+GT
         O1woCn5nNawvTHDSfLwAuglJziuDE16QpcEKbCZER0eHCtKFxhtSUaNd3OFNLHvvhIM0
         fUak9rJePMOmY0KQ8NoqYCxeepy537fk+ma20uQj8gG8LtFinn46DmttVyu81SPD1TsW
         eFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327074; x=1762931874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
        b=EOH2QYRWOGgEJ9UaJ8QWntQbw22mLVqUGGz7VVCWIU/3un1uWk7Tiw1es42DwYk/ub
         oTVvcirNhcyUZQ61bszpEI2UmN4CuKJxHgSRJ6GciwbhubNseHR28hJ/jG4cIpCC3sjI
         64+y+ZKrsETRuAkGrzuo9WSLym6fV10phm7e4nIM2bMRWOHJeDq4yVpOsJ5pPX4IwyLR
         C/K+2oGNKnXiqOKTP/4eMHfWxKrsL7W/vygPazoT/vgzsTGqtKUvpYLDJM1rn6YwdjF0
         NallNrQtfONBKccwe4vW1GxSP1sTQL/ES62SFwvXfaC2RL3KAL+6WY5gN9Tpi2GSdQaq
         cTIw==
X-Forwarded-Encrypted: i=1; AJvYcCW7t2NzQqBBHQmz/fnQVGV+g9/ngNFYFKdya5unw5k5m3xMHbcxyYH5iUQEDOcGKVP1Zlg+wfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfxfaayds+JT+kL+/5QAmGQR31zVF1XE3MKH37mBjl/m/Ayg7
	iB2ltT5WDa4Z5RpNCr4J1fmMgrhLaUDteWs7oagwkAvpbbq8Xbco2n0z4eM9P9xLRytWN/9L3qa
	sL0J9rDn1AWd8ulPx1zTVI6lKnqo16frJfF6vvFztggjlmvwUqIFvtlsU5Q==
X-Gm-Gg: ASbGncsGKkjEel8wVy+w88SI09anwtRPermtwEJQRXhZY7Bl2MOe9jYCJNCksiRCXfr
	yWzjfVVeLUZDA7cLPZf9j5drTlkOgbYLpEUytC0u7ihJAAsmukjJFWvuKYfEJX1y8PUf7eh8236
	szVVY6/NZbkI5P1ITmqjMccO0L04+vbwiqgCh8DEx1De7/IRcJy3ysv4YdpTvROx/G5DJ8I/OB4
	e/eiNjvqiBLsFcGpjZ7SH6M8WtFOTHWRyvsbT7Eys9uCZoc4jsoXJrd5VBAVZ32/hRvLKkbz/YR
	tiOAbSNYM5mG2m7K/DlRFok04u2z6VmsFdAwoflJttl45zwC/u3DtyDiWM5oipEkHsY=
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745698f8f.58.1762327073610;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWIh69cXdbIz7tujC891g3OcIjbNWMGhZSBD4SjmvD0oB/WuNR9hBtdPZG5O4EQq5uitEgNw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745669f8f.58.1762327073093;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdae2sm8869350f8f.41.2025.11.04.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:17:52 -0800 (PST)
Date: Wed, 5 Nov 2025 02:17:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net V2] virtio_net: fix alignment for
 virtio_net_hdr_v1_hash
Message-ID: <20251105021637-mutt-send-email-mst@kernel.org>
References: <20251031060551.126-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>

On Fri, Oct 31, 2025 at 02:05:51PM +0800, Jason Wang wrote:
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> -        vhdr->hash_hdr.hash_value = 0;
> +	vhdr->hash_hdr.hash_value_lo = 0;
> +	vhdr->hash_hdr.hash_value_hi = 0;
>          vhdr->hash_hdr.hash_report = 0;
>          vhdr->hash_hdr.padding = 0;
>  

BTW is it just me or is old code space-indented here?
We should probably switch it to tabs.

-- 
MST



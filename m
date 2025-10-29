Return-Path: <stable+bounces-191582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB516C1939E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 09:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C82274FB0E9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94741805E;
	Wed, 29 Oct 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbpPYvcj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58C17B425
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726004; cv=none; b=r6e6VCDjgfzZjltlPOW+Eid3FUembYBbJxYBM8reDJdwgEFhknmVzvBQ0l8bn/XdYidkjAdl/NOM/qsQozwdT+td4NHvY3nBrGGXbzoyz8TvNS9DCSfqa536B4WmUAr21ryh1dsUH9BFJGS9CA236UgRCK/f7sYxSSOECZf1nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726004; c=relaxed/simple;
	bh=dF3Bio0TgnJ38n1yJDNKl2Un84TNaqbPbXxpnnYQNmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnVI6ZUmzcLI6jiDGWNtL3FlK8wL58bezkHFZFa9cU1+TB9q9zKy2DYnfffVqveHu6Z4cgFghNf8JgWmiVJbkm9V/mMMquWLiZIN9Fh4e/BMiS7qdaFUZaL5Q4WM9j0bzMVVjXZcCqZ0wCA6u1Mb4PZPe4YkD12JABJvC39aSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbpPYvcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761726002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
	b=bbpPYvcjCJmE3PLd+21MfD5M7J1pQZPlUttyOk9YAbe8sZlxshvOgBHc+6AhU4isEOFKT6
	DurP8pi8qYK4YPBN5i3h6Eo+OymCslatmOSCL2B9wksdcwnKhwe8PfmEGRZ9OzCk8qyA4j
	U/VCaHJ9iEVlJjAiAx5ooE4sqnDr8fM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-2b7z4j5BNm6PsBCaJS8t_Q-1; Wed, 29 Oct 2025 04:20:00 -0400
X-MC-Unique: 2b7z4j5BNm6PsBCaJS8t_Q-1
X-Mimecast-MFC-AGG-ID: 2b7z4j5BNm6PsBCaJS8t_Q_1761726000
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477113a50fcso27945945e9.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725999; x=1762330799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
        b=M7B00FLVDF5exSq8tadzNO+2ZnSL4E+wYfnpnjCgnGkaPlTvDtO/L7lTAe2WUhqboW
         9BkQCY6T0TWtZuc1wzM6A3R63NRVtQXt75JTeoRPjzW3MiBgZi1if8/W2YKxAWe27SJ2
         1JJBdzwabKnejgio4iIT35Br3gYprDhw2Ym/4VLltSwYk0uVPUpqDqVcj5ys15K9MDJW
         Pih3xH3x944TOCZds9+gOrE35Cuh6cszorbFXmaWhwh3XDOsqw/8GTKRCe23mUN/zeKi
         X6LxVvKWXqWmhy6payShe6oes8DK4GzV/gAFFxY9evoS0otWtKE54pJnQEto0DT0pW1w
         cuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUie4WUAwRqbTdjILry+o3WFYfXXZhvIPRFh2RnBq3lDr0w7bgqP94F3Qd97x/ZBPaHeGkSr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRauyZ6/WdqbvNU3fKRh8DMTliXNtZpTV2GJqCOOQTt61IceDt
	r7cNEebFpCrkrmbJN+eW+/PmvLhSDSON9LV9PlvsnK+4iOsggIWO+IdjWaP53vsJHVtdGEPnrxx
	mUecSfKLom7PCKAbI/p1OSrAsQ1NJS0DbHp/EdBO9UpsCfdYY7btbM9nrPw==
X-Gm-Gg: ASbGncsNRHoM/Zu+GLiTE1mWqmV+cNpAFU+wffLHRd3LO+hMnVBqdZaxTf4NYpNZcKP
	bkw+Sa43knhZF0cO9LJk+CXGxLpfuSpLTqfjkS62V2JlygVFpjl8fhlc7nt9DxRSLcxQDXRTxo3
	+Xt6LdNzD+LOgH9WHTlN4rOK/m9z/6OKwfi74fANOaPASlYZuuBAosTyybVXg50TLkS62bA267q
	cKCfXt9VmmmcglLB/vgb0WxR/7yh9tsU2NFY/PDtOQ1NdkaqzbwhR7f8hwCWW7pBwGZyaWC+i+r
	VL+MUNb83InTeOVK+LgdVrXCmZQqu1UHDv4yAy7KjmX3TozhEi0dfEVjMDlVfypKDdo+jtd5C9m
	SG7HmaWZZZ5Ll6aT5zS6M+dR8ljWIxJxPGtekb1FBG4vfwxM=
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216435e9.4.1761725999691;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKqhZC0CRaoe+oh+5iFeCWKZfBRUDuYDM2nN5t0zCHgNGsk8VxrCIMd1bsBbPfplLJXnHhw==
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216155e9.4.1761725999244;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3937b3sm33177645e9.5.2025.10.29.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:19:58 -0700 (PDT)
Message-ID: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
Date: Wed, 29 Oct 2025 09:19:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251029012434.75576-1-jasowang@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 2:24 AM, Jason Wang wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
> 
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Whoops, I replied to the older thread before reading this one.

Acked-by: Paolo Abeni <pabeni@redhat.com>



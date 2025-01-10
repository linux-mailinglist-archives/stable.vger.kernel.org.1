Return-Path: <stable+bounces-108179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8891A08CE7
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 10:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59786188833A
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395620B1F7;
	Fri, 10 Jan 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5TG5MzY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7E209F26
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502554; cv=none; b=nl4KkYjvA4h4jI0Do0E6KrwCaARsU67vNK2oz0bppZYySL1rB8Re89pwJenWHTHbSQxyATCueUvzldECIQ1Gy5dRl3CUfOmMaULJkc5TsTplu9y9VwswgjJU9b2yyfptCiu6Sc0vG0tp7Cay+l+KABgAPfu0QzWHwthoPoIlvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502554; c=relaxed/simple;
	bh=qhsRGNUqK6OAKrKR2V1iKiCXi3FqvXqzYw8GoxWzqw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiuhdXkIvSM7URLBiLr7zvWvxRdSo3ihBhOeVpHS7mEAuUflgBmKEchVmOCscqFe7ZvUqIgNQAxZb8Kt9FM3jpvs1LsqKYdbLdeshKSE7vuDMjcy/M1Hk4UmNUChNZ8Vv5UzMuev5Kuis5yMcxAQRpW07/c7npYVyMOzZUn1ktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5TG5MzY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZr4uP1kpXqvKBmngNwvVhMpySxrRZICu1BEXbGGI18=;
	b=B5TG5MzYjawtiRug+VISUYgaiodKP5t+JySCekzCKzgiSrAt+ch4fbV2omaw4kYZwV64A1
	HiHhnZyW9yx6uYNu9AE/TDNVuLF/6jbiVJV80h7mcsinPGpXHrJ21aV92yIAx/TEep81VD
	0xBF4aAIOo2yBjKbX//FLF+bS8HUuoI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ea2wK7bNOWebdl6w87p_Vw-1; Fri, 10 Jan 2025 04:49:09 -0500
X-MC-Unique: ea2wK7bNOWebdl6w87p_Vw-1
X-Mimecast-MFC-AGG-ID: ea2wK7bNOWebdl6w87p_Vw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a922so2168309a12.1
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 01:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502548; x=1737107348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZr4uP1kpXqvKBmngNwvVhMpySxrRZICu1BEXbGGI18=;
        b=omx28UIvx5qB4cyHwE14E11tQrb5+z16l/HuG3HflFpPRDtsHq4losmJVDylEDz7hz
         F8hFk9F0qfycmGEv7UVwLfNFaiSRcYCVpFlDo9Tw7iAWx6cldz8eBuW0rMGjrxsO++mD
         lh/aERwkQE7rqcwOuYn9QYpet5OVq6sDqQWnSByXd4id4A/9OkYRiYXoHc1i9t1o0HHv
         P97tW9nmCg2zanFzf9lgZOn3+vurybpXotkh9n5NmCZaL8hoBJ/C6e1n7p7Z8dK4Z0lP
         ky/QZF/mDw+cN/RqzySoNMHXURMgaloQ1K/7SV0NQshnNoBg4lcku6S/qBBopmTm7c0o
         voJA==
X-Forwarded-Encrypted: i=1; AJvYcCUVhNT2CmFSarfuMMVKRU7YZo8l4VgonMNW0dwTRGvnsx7Y7tVYOBcaEoYhiowo4UKVL939Cg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYXS7xK3w5aoP07Hf8x2H2NTM+GjhHwhR5ItwE0OvthmrKpGm
	h4Osx2/i6C8GLTmZa6IN/TZG7oQuHAb7DJQPYTDd5YGkAYLydEZjdcwI+1Kpcu2arRQVvpBWNWw
	RhEeMkq4EJ/KT43eD79rz6skBBTSUnzmA4L3XmYmQsV6wFlG36r69Eg==
X-Gm-Gg: ASbGncsZDw8v/VRrHbAiAmi2kl1ywrmE31MvWiOk7GcSjSZvOW1C+V3YEilaGvMPU3W
	xVz5ZZ5yEm04LFmjBaZzna6T7V8Inxo/bhSkaglw9cxvHqS5lPu9SISHVlcQL8QtpSIQQLfsTFA
	dmnpDUXBj8E+nnvtsds2+pIYuEZDqrINyr+OmSTsSm7V8tc5dbaAEGbV15dcuMYezEvYGcr65Tw
	Vp524ofS56AaG34qDYEkwkNSgd0iFFYVSRiobXGweFh6r1o7oQNrx4rptg/
X-Received: by 2002:a05:6402:321a:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5d972e4ee26mr9809168a12.24.1736502548039;
        Fri, 10 Jan 2025 01:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7NcV6qvOmi3pOuIGf31hIeLvRpTDpjsTfMUkfqpvbiE2Dvo13pJInSk8Nx0om0nJMaf5Oqg==
X-Received: by 2002:a05:6402:321a:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5d972e4ee26mr9809135a12.24.1736502547530;
        Fri, 10 Jan 2025 01:49:07 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c29fsm1446933a12.9.2025.01.10.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:49:06 -0800 (PST)
Date: Fri, 10 Jan 2025 10:49:02 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in
 vsock_*[has_data|has_space]
Message-ID: <7ve3d5nuqddbdxbocmexobolzdf4qzsmro7kknnwkuqetznkfk@lispccbzv3lg>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-6-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:11AM +0100, Stefano Garzarella wrote:
>Recent reports have shown how we sometimes call vsock_*_has_data()
>when a vsock socket has been de-assigned from a transport (see attached
>links), but we shouldn't.
>
>Previous commits should have solved the real problems, but we may have
>more in the future, so to avoid null-ptr-deref, we can return 0
>(no space, no data available) but with a warning.
>
>This way the code should continue to run in a nearly consistent state
>and have a warning that allows us to debug future problems.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
>Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
>Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
>Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>Co-developed-by: Wongi Lee <qwerty@theori.io>
>Signed-off-by: Wongi Lee <qwerty@theori.io>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 74d35a871644..fa9d1b49599b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>
> s64 vsock_stream_has_data(struct vsock_sock *vsk)
> {
>+	if (WARN_ON(!vsk->transport))
>+		return 0;
>+
> 	return vsk->transport->stream_has_data(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>@@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
> {
> 	struct sock *sk = sk_vsock(vsk);
>
>+	if (WARN_ON(!vsk->transport))
>+		return 0;
>+
> 	if (sk->sk_type == SOCK_SEQPACKET)
> 		return vsk->transport->seqpacket_has_data(vsk);
> 	else
>@@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
>
> s64 vsock_stream_has_space(struct vsock_sock *vsk)
> {
>+	if (WARN_ON(!vsk->transport))
>+		return 0;
>+
> 	return vsk->transport->stream_has_space(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_space);
>-- 
>2.47.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks!
Luigi



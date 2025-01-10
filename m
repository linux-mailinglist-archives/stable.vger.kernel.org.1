Return-Path: <stable+bounces-108239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D615A09E49
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6C7A1BCB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FE21A456;
	Fri, 10 Jan 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="X7LGfMu8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A25216E0E
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549177; cv=none; b=NSBAtUTWO6n441UEaA5jeG2nlhlXQOrp/7HAgYMkSQuR19aoB1y+qlkwAYmIGFQVkWc/Yq/uaFy8vw8hG2WFA+9PgOuGQftQKwA0nxiJjdd6qtMJevag1IvfC2utXoiw7h0H+MoYSTfHBvoUlSfVORU6MlVDJH3Pelg+UGCendg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549177; c=relaxed/simple;
	bh=tPDB/C/Z9ks/FCQETqMvVx7wDQPCoCWowTG9L7TftAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKj70fGvfW2j40bLYjVYkrhC0DYdeWtBRyZM2R0GSrjA63vTDNbp6FHizYhKLDhN14qJQ/mshOrJVSrV5UxkGrYe7ibarhxrNkuIbMAhPniRjzvqsngTp4TI2+9vrClAK/fMSZUoZlOZdl8O/iGRavFodt1mbcYNJ6NnGXtLXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=X7LGfMu8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso45026035ad.3
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549175; x=1737153975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=X7LGfMu8Kx+XvtR27HCAb0cxK1VT+dQ4pSJyukKCDVVBTl6Mlw2rqxziMybbcM2W38
         SYjYZ4xr3bWOIwgmqs+EcmyVtfVWnjVWK2alYVZ7ctcpSzOGmSO7c85oRSF6qcc3vRxp
         VnJ5Fu1hwexv/JvlDxsxdbxlam7RW5UVdVewo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549175; x=1737153975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=OBkvlr8nicVn0ZO6EOf3QZOUzBGIf07jloODGSwPS39V5U1TTLqX4Rjn3F/P+QUkXW
         clAHT9WpsAAuYmib6FvmzY9kfmae+ZrthBNlrIyqqMBAdm2c9s90hdUvKsa+4gvb6PTK
         vRDCuVzWynWlCcbXVuv4dNsUy7ALRszFs16fSB+cNw/AVYvWI8g/CfTSgPEcihqK1NdK
         pocTi/AA429pBPeNlCd55xqTcfNa+WhwSVaavqwikwV6yiy56nRdCQYpqG2gAxLu5yDg
         LQudzNVQmrra/F3nndmeTKxxlRyHcHbenokbQ8vFIbLShRFWWksz6Qk2u5Gp/vSx90MN
         dcHw==
X-Forwarded-Encrypted: i=1; AJvYcCXAjnpG4p941anCotKcV7qpE5lLUbOpGd4jP9caoNqpKYcx+VSP+6IJN58fApTGli7uInvDEVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2IVkehba0plHxNulCghMzydCnsY9+6/Z7wEq26KJcxY3BJ6z
	4xfjlmasKZWd2VTyEBeHMzTCx5SqZiQHpipp72JLbm88x0fDB/xw84glXEo+4tM=
X-Gm-Gg: ASbGnctyilDbVjNG4qOWAnraAjfiYfg/wnvPBdoxkL77qOiGWA1DkMLKXl4GyVuJoyz
	0RjvcgFam7GJ1hUhcqAwf1+hw/JUhxgRa02zdpaY6eAV31I8VGsUYe1HlWV69yx63yK070TolCN
	g9zlyWhLTfnP2YUtNl57O9OKGCGHHSXdv3vba3jWiCnv7OFg0TXdkcUblnXgAduLdArNiWqMPdS
	8L3JQhOqqzAC0BK+8xnG+643YZitzgRuxnjkfZQlHdXH9ijosVY4gg1dYF/xSQpP5RgXQ==
X-Google-Smtp-Source: AGHT+IHXtYgcYVXlKooOzNrhJ71XOZH467c4tXOeuau5BWKoSSQdakM62UMQxWiX7c5/TI2GCGQ73Q==
X-Received: by 2002:a05:6a21:788f:b0:1e1:a094:f20e with SMTP id adf61e73a8af0-1e88cfa706fmr19490910637.17.1736549175198;
        Fri, 10 Jan 2025 14:46:15 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319a21afe5sm3279259a12.49.2025.01.10.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:46:14 -0800 (PST)
Date: Fri, 10 Jan 2025 17:46:06 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <Z4GjLqPWJBIRdqME@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-2-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:07AM +0100, Stefano Garzarella wrote:
> If the socket has been de-assigned or assigned to another transport,
> we must discard any packets received because they are not expected
> and would cause issues when we access vsk->transport.
> 
> A possible scenario is described by Hyunwoo Kim in the attached link,
> where after a first connect() interrupted by a signal, and a second
> connect() failed, we can find `vsk->transport` at NULL, leading to a
> NULL pointer dereference.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Reported-by: Wongi Lee <qwerty@theori.io>
> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9acc13ab3f82..51a494b69be8 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed before lock_sock */
> -	if (sock_flag(sk, SOCK_DONE)) {
> +	/* Check if sk has been closed or assigned to another transport before
> +	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>  		(void)virtio_transport_reset_no_sock(t, skb);
>  		release_sock(sk);
>  		sock_put(sk);
> -- 
> 2.47.1
> 

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim


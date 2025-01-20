Return-Path: <stable+bounces-109550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7ABA16E8E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541D07A2498
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BD1E3770;
	Mon, 20 Jan 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8DaokOc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317511E376E
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384139; cv=none; b=gbfM8Jw4AJIEmCgwKopV9N9pWkxEIHX/HkzH396GlH/2Ld6tSy3CcKzTFtZZNZLpENEzpZAV855pS7SwDm533872JJ5uip4q77UYuuthkS4JXfH99HBnfF83DqbM1EGdd/Ap06yAQmyAb2JQo9x//slBTE5oXLOfApZQjmIvWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384139; c=relaxed/simple;
	bh=Z4ooKYFFdHdmFp5mp0BImC3/4VdGL6EEZVRPnP0XlY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNp1ll5uDSgdW9rlr5rVDggBYQGIwSjIP3EebSC9Chn5jrEP0qzyV3d1BZHvtOaItZYBnUYB6ltIsENT9eW5SXOq2u8zZGEhj5WlCfrXVlGenUJ6sYBUVDvQGh30jSbplKQnbdpDp8Y0pDe/2GRWtbJesVOf85LAgsatq1G1+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8DaokOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737384135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr9JMAk2+Cc37UHUpd0JdIZB4AAeMafD4YMNeYqFqFU=;
	b=D8DaokOcpjntcsxsB9NsMTnrf2fClEFRI7urulZdqjkoiu39Kz10lvXGdg42ktjlRbgcwY
	QJJ6HnVlRq6pyoTnprApVzCMPEbnzh2V8McEiWkyMOfjz/aGtbgiFmp+UJV3dh1U53IywR
	j8fOZpILGx3bcDBlR6xJpmJE3ke9kN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-LyFTmeOdMIievQ796XxjEw-1; Mon, 20 Jan 2025 09:42:13 -0500
X-MC-Unique: LyFTmeOdMIievQ796XxjEw-1
X-Mimecast-MFC-AGG-ID: LyFTmeOdMIievQ796XxjEw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43626224274so24877475e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 06:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737384132; x=1737988932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr9JMAk2+Cc37UHUpd0JdIZB4AAeMafD4YMNeYqFqFU=;
        b=vDJtRxtgktqYhsQ48XYQiwxw4Uz83MM1AgfFDOqVeBgTwH/a8pB8BX3PJGLgm0gzT3
         s7rOJzXsG1wJjp8FmhHtHpbXgTDqg0S17ZNj1GPO6Duwa68sSMXZP2YiZ+XMrys7Oycd
         Jsb/UYQVVXxmzRz0cFp3kRiaQtplfEo+FTtrHUZuJzb41+ST9pAEHWj+kSaGngOlyV4L
         Kdmki+acjYDNbAbP8G88abZonPjbb6KKLlzAQlNGzPGK1bRLG2NJt3v+ywIctJkicFqm
         UbvkIF1bdYqWxSiodDDb5OuFcPu7z8xLJy6YRG3Ocxpjb7h3OFbAkv2IIvAkeb+gGAWL
         73Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVICrxXe5zSAYQrbW5PM8G/RTVnV4l5N/SphjUChLj0mZNob7gRDdCp+MRq533pzBN1kxU9o9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLy6SgA9uPXUPJeOWdXik6bcxq+gnNXshnw00aqRNeiPFAdBZX
	lS+DEOcxwxNpPpJsZaruk+2oJ5NunvgAsmx59nR7PksflqHARh0byUL6GEtLNJt5J6d66tU3nBN
	NzEslSM7AlwgtyzO20XjUbiafUfFELysSRf8botIQ2xYPu1MJS5jeK/hbZ4gkDg==
X-Gm-Gg: ASbGncvE46tjk2fsPMNa8G1P+RxyKSjnwXJlWStH6zfb3dT5WRycR6bROus8Q4G9M+q
	rQwNweIL9LY7brFuUk3tOnNy/NuSWPuYoAS+u5PTWfn1fT6Yaz6+2a93h9Y5EoFQ9MQGacamiL8
	f9RkDZwvEIcgJ0GLNJOHLjBYIrykhOn4YaBbXAyWqCrlRCcgTFsW9VvI7GoISq6NvGrZ5PkXY0F
	73xOTg6OBpwQOxUI5YB6/R8So3N8RNHHP1ROSEJ1LarrAZNhV6moK1zVUpnDTIVy+sOwYeEQEk1
	wy2dnNzMlB+sUUIk/Hdjn/N51cDSBd9e4dlzQm5seb9SDg==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-438913f86dcmr125714985e9.18.1737384131737;
        Mon, 20 Jan 2025 06:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOTtS+eyAgLS72NOusBwB/vLbIPSeLgvYLbFpIs+SCTNOD923oCIAI+8D9w+SWeY1DKBGV3Q==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-438913f86dcmr125714465e9.18.1737384130979;
        Mon, 20 Jan 2025 06:42:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm144383755e9.5.2025.01.20.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:42:10 -0800 (PST)
Date: Mon, 20 Jan 2025 15:42:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: gregkh@linuxfoundation.org
Cc: pabeni@redhat.com, qwerty@theori.io, v4bel@theori.io, 
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] vsock/virtio: discard packets if the
 transport changes" failed to apply to 5.15-stable tree
Message-ID: <d2ezui7sujjbhqueo4hokoryqnym3l3qa7d7n5i6trspqbdfan@mqlkfrawbxeu>
References: <2025012004-rise-cavity-58aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025012004-rise-cavity-58aa@gregkh>

On Mon, Jan 20, 2025 at 02:40:04PM +0100, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 5.15-stable tree.

There is a "context" conflict due to the fact that we do not have the
following patch in the 5.15-stable tree:

71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

Since backporting that patch is too risky for me, I will send a version
of this patch following the instructions below.

Thanks,
Stefano

>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>
>To reproduce the conflict and resubmit, you may use the following commands:
>
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>git checkout FETCH_HEAD
>git cherry-pick -x 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1
># <resolve conflicts, build, test, etc.>
>git commit -s
>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012004-rise-cavity-58aa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>
>Possible dependencies:
>
>
>
>thanks,
>
>greg k-h
>
>------------------ original commit in Linus's tree ------------------
>
>From 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1 Mon Sep 17 00:00:00 2001
>From: Stefano Garzarella <sgarzare@redhat.com>
>Date: Fri, 10 Jan 2025 09:35:07 +0100
>Subject: [PATCH] vsock/virtio: discard packets if the transport changes
>
>If the socket has been de-assigned or assigned to another transport,
>we must discard any packets received because they are not expected
>and would cause issues when we access vsk->transport.
>
>A possible scenario is described by Hyunwoo Kim in the attached link,
>where after a first connect() interrupted by a signal, and a second
>connect() failed, we can find `vsk->transport` at NULL, leading to a
>NULL pointer dereference.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Reported-by: Hyunwoo Kim <v4bel@theori.io>
>Reported-by: Wongi Lee <qwerty@theori.io>
>Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9acc13ab3f82..51a494b69be8 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>
> 	lock_sock(sk);
>
>-	/* Check if sk has been closed before lock_sock */
>-	if (sock_flag(sk, SOCK_DONE)) {
>+	/* Check if sk has been closed or assigned to another transport before
>+	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	 */
>+	if (sock_flag(sk, SOCK_DONE) ||
>+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> 		(void)virtio_transport_reset_no_sock(t, skb);
> 		release_sock(sk);
> 		sock_put(sk);
>



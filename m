Return-Path: <stable+bounces-109551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A80A16EB4
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B73A38A7
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BA1E47BC;
	Mon, 20 Jan 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVOYR024"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B71E4110
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384218; cv=none; b=smW4/948Cye3Sd7pxrWR+0i3qsKWfRjY2V8G/NBcy5VtQou3nw+Bp4WRfbTDYpRKMqZCzpmranKVAu5a7R4V1o3bXGNKfAN0Q1LoKSQBet7UL1YkTzj8dkGAcNcRoo1GtRHesEXTsCHaix3xMzTRhoPDOf32DKrBkJR4RKlCuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384218; c=relaxed/simple;
	bh=CTrcNSpU7Oxb65ObIlVDcjPqjRxm2DQJ8/i6ugfDSm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbwbDOcnAn7mr+ldIWyS6CgECKy7UOwPQT7lI3n3bOxQ0erO+pRun1EX/nCrWK3EDMQrO4nrCr8yFVns5ZtH9TAnOmik5N3G7VpiVJKQoVGwY47TNxUehwc/aLcAD8OAM7AHCQrf1K4hH5UsH/mi39cLXqjlgSxOyC+l3m0CTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVOYR024; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737384214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ez+3AQAinpyMg7LzTCv1W5bYpFZwoVTj3YiSPOQ/0c=;
	b=dVOYR024Nv3T9hQsoaCLEfLL3wUSWQ2L2DQROIbV8tvOFBC+KtW6QK5Zv+ScBEEq2Tr2vA
	4/ciWIELao9hHZXT3oN4B/DmmWrd4pi0wcWGsYdF1jCpioE5NfPB8mQKBSgj5v9Ywqqr/K
	smpDD47fPxKSB6vMVOH0o3YL6ei2WRc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-VB3-lfuZNzKg25FNxD8HdA-1; Mon, 20 Jan 2025 09:43:33 -0500
X-MC-Unique: VB3-lfuZNzKg25FNxD8HdA-1
X-Mimecast-MFC-AGG-ID: VB3-lfuZNzKg25FNxD8HdA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so22874185e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 06:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737384212; x=1737989012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ez+3AQAinpyMg7LzTCv1W5bYpFZwoVTj3YiSPOQ/0c=;
        b=uL/oB3utU/05XJHwyi5UIh0e24A+701BMr3awmUBvpD6z5MwG2vY8bhiA7BCqoIfTw
         nu2bsadtv5kjKwv5Ca1bz38iEEV/ZkdlJzc/eHYx3j9uMj/qkC+idSbY+GtRDPgg6c9s
         +QP/mOufhk5QEbybZeplzVoldLUWgiRW3E19H0SHJi7L4EEL86zVshclcBjmIrK/w4o5
         RRngEdCspJ0XTiGRS4B6ZNTpflOl6TAtE7qtnOj28Z3DopLUyu2yFHh0KHicXHMq2Nuy
         ARIl2WSKOTY0ZvWYbRN1IFt8Y2rh28PJgTECM0efgLxTpcyNAwk8sqHJg29tew9p/W6m
         +K1g==
X-Forwarded-Encrypted: i=1; AJvYcCU/X64H/D/3zN/KJlujwhL7iw4r0WTeiC7HArNLkwJr4SJL9ch1DAaIblxnSIZ2X+YCAPOP2uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzAszPUblDqAvU9fhPgNd3kuKiUYCZtbJlRWCxhU05X18JbHk
	Enpbe63Fy7xa0wfdKjZqLtl0f5n3RXVlKRhUpCrbhAr/P23lxIxp+7wBw1kqBet3YvhtpB0XUhV
	+ha4jhkMY4d5MYVN2gVQJcEPBWvHgLcM1bxQ+L7i37UR3nvi5LKDHtCvhuBGkUQ==
X-Gm-Gg: ASbGncu1tCw7qR2ysimRVw6YY8OQq0Rg//vuYVHSan5+jYFz3puEFP+j1TNGIIrLX9o
	zmJNR3q4v5mySq/ESOAQ4qBEooSCZa8JaE8J+SChTUkXYeloqGeKMxJeXF8KlnrhHYN2XTdTTsa
	Xrdxpz17tIKrPQcI5hby4KLKfbkYXKGVmnOXMdAwneVXz6TpEhets6Kt0koGqQRxWZYtKGBdN4h
	oXm7mwmJEPzeBaOI2JOccBCynsqtqup/0h8YsixiNhwUlLbgOsC6dvP96iYLzg9a84Bhw5IOP2X
	+ON0PrFnr2rMmv7gWNUm26KI38Efiha2IqY11oxUQ/lKPA==
X-Received: by 2002:a05:600c:26c6:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-437c6b475f9mr200936445e9.15.1737384211779;
        Mon, 20 Jan 2025 06:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNB/+AfOTSXjaug5tAAO1CLyrUblqSFa17id0YcFrXCgO9kP3iwxiNfo8B0koDWdJMA/dFMQ==
X-Received: by 2002:a05:600c:26c6:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-437c6b475f9mr200935995e9.15.1737384211107;
        Mon, 20 Jan 2025 06:43:31 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c16640bcsm134165535e9.1.2025.01.20.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:43:30 -0800 (PST)
Date: Mon, 20 Jan 2025 15:43:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: gregkh@linuxfoundation.org
Cc: pabeni@redhat.com, qwerty@theori.io, v4bel@theori.io, 
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] vsock/virtio: discard packets if the
 transport changes" failed to apply to 5.10-stable tree
Message-ID: <lidnpv7sgfy2r4h73nvz53ngbsm74zwkvzdccbdqnyyuvdhzok@uimd2vukfuly>
References: <2025012005-supervise-armband-ab52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025012005-supervise-armband-ab52@gregkh>

On Mon, Jan 20, 2025 at 02:40:05PM +0100, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 5.10-stable tree.

As for the 5.15-stable tree, there is a "context" conflict due to the 
fact that we do not have the following patch:

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
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
>git checkout FETCH_HEAD
>git cherry-pick -x 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1
># <resolve conflicts, build, test, etc.>
>git commit -s
>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012005-supervise-armband-ab52@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
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



Return-Path: <stable+bounces-98741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D09E4EAA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFEF282AE2
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1D1CEAD0;
	Thu,  5 Dec 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuChJRyi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247B1C8FD7
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384004; cv=none; b=Nd8MPk4pYqjWfb3DyWSeQDBsvcOlM0oWfuC9odlVRXYAuTTLGkP8RTfZxUqF9h3nhyvAHOIZNn0SJ+v4/GfxtuqE2ZtrcHOM9D8gxjxGJ+x6D3bN7no1jrLSrygTAtdGUqQisPMIlHxn36hB+/2wFfTxWvG5rR/1y8sh+QyFNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384004; c=relaxed/simple;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/ht0P1WNCN5q6YV8glG+0j+U+v2JYTA/uS/4AARGS+rmbRikfqpmooZ2jmyImJGZ3eo0DPNMyybYzxxjZcPyQEEqVeAMzbobFWlQ++Juhxvhku14UGYsWlVcycqBKf7+bOZqjoWWXBX5W3FN4fXFLN/DBk8mVLO+LggomeITLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuChJRyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733384002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	b=KuChJRyiL7529Dd9mQYgTJ8YdklBt+JdXQn9KpnPpxvkCT2LCuoRILBQgRQcTad9/ulOAc
	aB78C90Uot8JPUsm29rRRWtq+YcJFY5jXn3bM1FS3vT3qRMjqt/7XBDtNSHnuACU0h0mqX
	Rh70PjoSsbUOjX3LTZvxi3iXrEhOq5w=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-AjdZovdHMLus3RFpNmvd7w-1; Thu, 05 Dec 2024 02:33:20 -0500
X-MC-Unique: AjdZovdHMLus3RFpNmvd7w-1
X-Mimecast-MFC-AGG-ID: AjdZovdHMLus3RFpNmvd7w
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-85bb7ab2ccbso96225241.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384000; x=1733988800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
        b=ANF97NhR6+O3Htg2CaACsmBrkAFR7NR2xQ4OH+4DpV9x7FiYFSo7xtzQApOsEXspo3
         w0EWX30srbA2yKXan81MhiPAKdjwk7GJK87CezT9oHTxApDYYxZTdTQNZQkkffB+me8n
         +N0l8oX6wEPmq2Uua7JwDYXO2Mn+JdNRTNkXN+mdUHqe0eo7bHYuJBd78xH9B5Bh8K7J
         3YmtOGTNylSIbQJ8ZnlpeJY5jOAZf0Td3Ham00BNvjyp4vUuBdHi3MO01a+ugIzJ8zVn
         cpEhqfhFHmrQhIhNWPVEweYAKvyVL682SSQ1NU9jffqIj6EKXawC5KKEfDmCjw8cRxLA
         nKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3WYVXr3WTkIDHzaQSl8fCDn4l80TyaPz0oJmvxbJkuKWQLl5DHXm+/h53AK1VA9AyjrJF5zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ev8gaaxeSjbRGr6Qw4/74V6u05zQd0awbXJ6m0jeOTb3aUqJ
	bENVAlY7CuidNhcYVyIdYCYB4dYOYWy3fzNvuHI3RZpFEYD4Y/naJm/v3IF2vXcU3LvB7l9xixe
	njgFD652dsCiQ8BkJ6CqbHGB5m/57pwDUW27kwK4Se8Shzp4LQkBR8SwOrmAdn/k8rRRcM94PpR
	r0YDuVpOYF76MVZRgqLsEsrgicKEF5
X-Gm-Gg: ASbGncu8XKtcWV6yrkVy/dd8X5eJgPrSHlocyiLRH5Ou2zrpnOLUoCGABJlb1wfZ1v+
	RDG6nFV0x70m7Y1x5TjKulLuY6KI5PSui
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id ada2fe7eead31-4af973616d8mr12754220137.17.1733384000435;
        Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELTyIwlkQV/FRs6ijjhpSGbcHEbQmTZ4PYlrb2mZ2b3HG32XEj4FFiezBBQtrrkcWKDD+bF56IdeIGqAxNni4=
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id
 ada2fe7eead31-4af973616d8mr12754214137.17.1733384000076; Wed, 04 Dec 2024
 23:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-8-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-8-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:33:04 +0800
Message-ID: <CACGkMEtd9-=TD2J-ds_NGnim-EeKYJxLiqJXemMP0JY8EuMeQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue
 is called on bind xsk for tx
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
> DQL counters need to be reset when flushing has actually occurred, Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
> to handle this.
>
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



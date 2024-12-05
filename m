Return-Path: <stable+bounces-98733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAE9E4E69
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F81168782
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFB1B3955;
	Thu,  5 Dec 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHaidylg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21121AF0D1
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383890; cv=none; b=AG3HaiRHOMbh0Z60E5nraeHG/eIhWutLmon/MeKxM308abE+e3DUVo1eIKsLmlldqm4yC6uPSGKK5TggrGnhk1tw2AMOHg2IJep6lyXNVUqxghBMpjNB3zIztEF+T5ulsaDuTOaW8nki2K4xlclMEXnYAPpCKOtmR1ct2cu7JRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383890; c=relaxed/simple;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi2Omd1Q+YHb6XTxe6ZPvE052DLBnguknCJd9R4mIzQY0Ub+wFpgxWT+Dls1mGGUOTg2sdd2WLtlpwF39Kn5JkELwqNhFdJzxGmCcJapP0R3UKo9Y8fkQ2Bt+iDVcWwIvwpsj8I+H9fas5/V87S/uKHRGcK/o7ru/8qWFRQ/Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHaidylg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	b=eHaidylgv+DotOSaDLvT9TEjVOqCChpM7kzwxY9jt5HVWbqGMeSCpjTRRc7754L2LGzmr0
	S00dwI+rgjj193W5raNP4S85N3HwUGdFKwyPsumk/8TSwxbNHMyo0CDoghojAhdUSi4MYK
	K4KRZU8Dp/A2KnsrUCZLdzK+t+fJYIA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-FdhZUJWiPxaPKH5_Cdw6kA-1; Thu, 05 Dec 2024 02:31:26 -0500
X-MC-Unique: FdhZUJWiPxaPKH5_Cdw6kA-1
X-Mimecast-MFC-AGG-ID: FdhZUJWiPxaPKH5_Cdw6kA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso1645187a91.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383885; x=1733988685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
        b=odx86gr3II/K8JYs6lafPX0/aS7Ud4LB1yB4hZ0P5RaKyryYB1fEsG6WcMwz5N9Hye
         906Kn2kQ7lJuo2vJMc2bhh+/vEhYRQoiHpssbvy3aHeKbcqv9+wbnmq3GujTyyrTFOCQ
         tdQOH9SulXPs0/LxvEpijZ0cbxQt+FdbhgZuaWagzM7a0zRnTWIMfALGrkqSX/kH7t+z
         HZXJ3y2xNJP9KNc/N67NBExXspmJ8KUdqyRjmG1POaqCdtjk/3hlp8XT9XLqalO7XdnI
         209cbzSnRN9Exnk7AlAqFqS/96Gp5NNmVFOhz6vtW1uMtF3pga+0CawyU4ZQsm0+DDWq
         /h+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE3aK9EdChUQs0VHO/KNW+xQkdEEjfhb9cMMpZ61j4oxMtv0KCwIsrY7LVeCfZX/+VDh4/mF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hAqS6vIbDi8iSK4ul/vMlS8rGez823tPLVrzusH3UgrgDVTU
	yihFSsSlE5Vss3M2vXCtbURUb9qBn2ROLNU6nSktnV7sOKX9SnjYfIppr5jNcWUGZFQ85KZEo8N
	pvi742hxk3DKVeAw0hYVpu1VLa60BuHsRt7AA9B0sttoLupHL8nI0VZ4ALjlSTySKW5afaltfzB
	U4/1nXKijqaDk60DqBjSdTmuEQrwIL
X-Gm-Gg: ASbGncsMNL8NaM+u5m3Fgll4TezgihOqckcCoLuMmyzkFU3yK+fn+L0cnpjlTG8oRv1
	I2LEmJnWH2UoRrRLnb9BnO/G4XrR01IdG
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id 98e67ed59e1d1-2ef41c99386mr3511947a91.18.1733383885273;
        Wed, 04 Dec 2024 23:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Uz6s1s92mheWZ482J+Pms58UfnRdPDzgkeV+DuxdzrY+WXQ6wsaWOBD+r2THsCYKuaICd9UQwkstxAvMEhs=
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id
 98e67ed59e1d1-2ef41c99386mr3511918a91.18.1733383884870; Wed, 04 Dec 2024
 23:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-4-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:13 +0800
Message-ID: <CACGkMEsmAtguhDbYbgzs0f_ynsDy2UwYR3jun+J_OQQwuXGWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce virtnet_sq_free_unused_buf_done()
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
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



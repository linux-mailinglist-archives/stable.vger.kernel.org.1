Return-Path: <stable+bounces-200437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F9CAEE43
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99CC3023A26
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 04:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933B26CE2B;
	Tue,  9 Dec 2025 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa6kHL1D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGjEYRBU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93925A2A5
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254782; cv=none; b=Dm/FGTf6H7q4sDa55f64+Cs+/nF3qns12OIHd9/OigEugXW1J/0an1wmFZsgkcOeUJgRNcyNC5YswoF03fIipRXOTdnFTK9Pt3h12sRfBaBr69P9fY6A5uAmwGd/56OdF6C9EgifNHDWcoGKnFCTwJHELL0QAwL0MpTjvaYwikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254782; c=relaxed/simple;
	bh=IR1GJIw1WogTr/OB4lNYncQ1ZxCQwr6Kq+gJH+Iw0t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPNVqt5nfSaPp+JL6mJbCAwQE60EB2LdE88prh/VgG/pVBi+b4p8l+LJ7ULKRKsea0ONTyxSczg6rXjHv3LtnIjhY2Yb1kkRyOl8iVEjm3mS5HKAFuzKxdTICMP6g191C40PKRk5L9IOtkiiXBlJPQYxJZ6r7hOlEyTFC4PwXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa6kHL1D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGjEYRBU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7tlj801JGEwEviglxOLZTOSOnNkUWu4oKsf3XJ8MAU=;
	b=aa6kHL1Dt5u3jh8VWsdoMjOqn/04BUwO36pVlyZ15CqMyxanpdDQzubOp8m5BTvqaicHck
	LP5+TdlJn+yI6OITEFM3aTdSOx/iBerZMT5za4mBK8jfV0CqZSoNPWvFKMX5ko3pI2wYMP
	1tzblQ1PScWtxNt2WLFGoOFYjYonUYM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-7n3LDi-UMwWfypTXM-jc8A-1; Mon, 08 Dec 2025 23:32:58 -0500
X-MC-Unique: 7n3LDi-UMwWfypTXM-jc8A-1
X-Mimecast-MFC-AGG-ID: 7n3LDi-UMwWfypTXM-jc8A_1765254777
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34992a92fa0so6716411a91.3
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 20:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765254777; x=1765859577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7tlj801JGEwEviglxOLZTOSOnNkUWu4oKsf3XJ8MAU=;
        b=cGjEYRBU9uyXGvVJR7FkTj8tlz5qNRfRxY5qLuguciAqWUBhWPnvzihuidLf12atnw
         HfKq9E4kAIlWVpy2C7EEp++Kl3V9tSOiJsf4dGbZa/EwkKsNnJXLjv79UTiURXLqGS6T
         /W5YjgwgnEeXIiC4//PlaA+6oM8rrg0YumdGHgyWNrZJW48hRgfhS4Jh/lz3/vIZI6GU
         vrydqTYquhtXd4w9wsj4zRxKeVaCF+Bxz4ItfAXKedP+v//suwT5LboRA7C1qmZOy6jN
         hkBj8lCqSXVSrrz3Fy8/gPG0nCqHYEWYwAKD33xYegRRFoppHe/0edmyNpLY78IPsqLp
         A9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254777; x=1765859577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7tlj801JGEwEviglxOLZTOSOnNkUWu4oKsf3XJ8MAU=;
        b=YxtWZ6UMZsAJOW/JkEZJvE1FktP+TdCTcA3OcbvFJQ7Cx9+xZO/KWFs4rH+nE/ubNP
         O30EH3c7sbtVhqdDrmxMVW7f9OY/hpeb51pSfiExOGT7ZZhtUzO2qE1Ml9JZKDudvkow
         fR6qzGlde0T6SVBr8+qfqOx7hqexzrRnTUtezXnou/hkm+2bhM0zc7dYBTJDsWZBsR/K
         ooMWHKm7RuPc+QlB8qRZWSa9lG64CLbiGUenuPNdDx+7AXi7+5NlLjma7rN/hxipsgDt
         hlystKeBTw7/qN8/cGo6nNbbRLBkp086CS72C7FuFey6lcSnWauh2/2A/zidssNoKbQi
         cjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh7nehLv/5KOzWjW1+VuCasC8Tj+OW+iMCNR48kz4Lr2tb9YOTX4sEk/tTtAhqbdhD8virfOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzTd+U0AQumiihFMZnt3oubLrfuruutqu0+1Sx4/7WdSaGhZA
	lBTxV3iZKK+opVwbJ0EtIDxy05fdKGbJVjQFT4F6qMpjVxiuUYhQQ7tbOj3GNjI314PSA8uLmnu
	C9gJORZVj3e6mRz6f/SUXsvlRUNfUDfnAekQORyJ2DD0Pp8SQRE32nYJrpkx754o93QNAk6C1xh
	RyittFlgN2SyMzZEijlBhmRnuf1rthtWOG
X-Gm-Gg: ASbGncvbuZmc1Go/vmX7+Samp/18h1L4W7nMGr7xlLYkIg2LyMJ1/FwdIx5Tlq6tXKH
	TtouPxDnXJC21zTznxxvFNrsjJOpd3sbuYrUo1+g+szvLkPlQdZ8rzlwxYOV/PWeCumh1DOIbIc
	udBAI9oCakGzp1mqR7bdMBqGdYK/uGq2WKtR6DVL22P4Ndl27U7QLZHP0NgH6CPub1lg==
X-Received: by 2002:a17:90b:4b02:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-349a24e1417mr6855259a91.5.1765254777257;
        Mon, 08 Dec 2025 20:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdw0M8LAPWgyO/elXlfshz40Rlioju2PuyFc9XLzszeCdo7ctlmBpq76QMP0pwFL39U8NEhUcTgC3HIYBdbo8=
X-Received: by 2002:a17:90b:4b02:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-349a24e1417mr6855241a91.5.1765254776843; Mon, 08 Dec 2025
 20:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209022258.4183415-1-maobibo@loongson.cn> <20251209022258.4183415-2-maobibo@loongson.cn>
In-Reply-To: <20251209022258.4183415-2-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:32:45 +0800
X-Gm-Features: AQt7F2oiXNzEXvaoIJ5PYmQS-SgPLwwMhAbf5fZFgBwLJ4Ewmxplg8YGZKVBbKg
Message-ID: <CACGkMEu3rhZy6hiZ14AvXgXLz2KvwvcU81KNrP_XsM475ZM=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] crypto: virtio: Add spinlock protection with
 virtqueue notification
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	wangyangxin <wangyangxin1@huawei.com>, kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:23=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> When VM boots with one virtio-crypto PCI device and builtin backend,
> run openssl benchmark command with multiple processes, such as
>   openssl speed -evp aes-128-cbc -engine afalg  -seconds 10 -multi 32
>
> openssl processes will hangup and there is error reported like this:
>  virtio_crypto virtio0: dataq.0:id 3 is not a head!
>
> It seems that the data virtqueue need protection when it is handled
> for virtio done notification. If the spinlock protection is added
> in virtcrypto_done_task(), openssl benchmark with multiple processes
> works well.
>
> Fixes: fed93fb62e05 ("crypto: virtio - Handle dataq logic with tasklet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



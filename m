Return-Path: <stable+bounces-151520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336ADACEE45
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 13:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0BF3AB089
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E1217F55;
	Thu,  5 Jun 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1T4c85H"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C41D799D
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121392; cv=none; b=DPKeG9LLkrpJYpivW1wNHoh2QaBlfx/ZYHeInkYRkvJnfLbDX64Y7wp6Bab1rnou9Iy+sJE9rKK6YkYi6hC6T/JmtzbXB7dKB9+qLrDX8H0i65CnogW7wgA3teyBAYcrV3Ioq36SUszbUVmgp3jEtYlnRISkcRoDgv5bqWbATmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121392; c=relaxed/simple;
	bh=5iVRkX4FSgcRxi/CvcNtolFKz6k8kFco9qX1fh/s/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seYRyTx9kC6HlMBISkmiwEb0X75ACcJkXxv6kY9/AjGykNz8EGZ4wsNm5nVVBr5t+d7izewq0iOlU1jEHo8/eWXXTVdajIfbDVpLAqgbuz/AoaABRR4QuxsJC3av3W4C0RkK/QAfnEpn/beWNEfT/VzH2+RvktymMdlTCSQghHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1T4c85H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749121390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
	b=U1T4c85HSXKjhNxhVssNIMNNo78+nBwxHQG/L53a7LS26AAX1w2LlqFnw9qf/nyzD6pSsY
	BKzPmLU39Q/1qXwzoMAsP7HvLWO+zQPxGjb5SyjNPWaZcMPKJlyvSaMqbXbez4gPyPAB3b
	7+t097FJWmRzLOsQmPyUY2IoStMWUx0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-fvgpH_pUOBmg5H2Ct08s7Q-1; Thu, 05 Jun 2025 07:03:08 -0400
X-MC-Unique: fvgpH_pUOBmg5H2Ct08s7Q-1
X-Mimecast-MFC-AGG-ID: fvgpH_pUOBmg5H2Ct08s7Q_1749121388
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f3796779so589349f8f.1
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 04:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749121387; x=1749726187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
        b=BWS8DG4qQkGRueS+uTZt9tfuSE8Zc5BnbLpxYgXzZ1rDW9ihK7MQJWaolDB/EpPC5g
         Hf/fw8s2KaCNFsOGcqD5uTuF8tklvZ6CDfAjv/O/kxNpOwlSALvd+1OsEttGGifWHGUL
         yaR75OKVD6aA3xYlRoEWpZK1b2V4RJsALMPr9Cl/MDJTL8YeFOx989bjX6XrMEPHj0Op
         +55Iz8hKFGYVV/1yXIEPydylVoGvR+B/lCwFU9jYQgbHA28w6/EwIjDdyGbUCFpE+H0N
         h2jc3puRhwjhKWYjwzLcVS65bgY7WLUS51O6GueiPnZ6uHTH/HDb4IzzXCiWwk90sQpz
         wRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJjDYqFYwsHrwIaoAq/mpBI5fkyAi9UetxAGLVXp2Loe2L3lhA1oHKZCtXH9b6hxJFGhkGiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgoShPJtbVO1hETPhc0iEniQ5LtrOh8SBFg2WEYMGZwrU4Q8/
	4LySvq4jDjo3XdUtIkA2jOw1f9R83fNvPYXUt9+eBnwwm+3ddeaMytanERY2bfS2dr3PPK9oDem
	Wsl7GpnTpjZiT6cND7d3udiPz2ksaluVGiLNL/RFaNIDv0iefFwNUnLa5xA==
X-Gm-Gg: ASbGnctfNNSinhGWvfKDzzr9ZoQqLK5vD/Pnf98CW0pBZ/+DH6AaEnsS208WgChW+7x
	J/p8bzjUj02gwXRMxrb403zE/ukX9pMaavPw4S4PNn/fJ+rVlRnQCDtJnVavmz43OVgJlxk7s3d
	E3Nm5o1Ucw0vApctCt94UEQwpvxVznF2r++JStfWVMUzo+w9g4GGb+pf4e6+wNgP3YUZW4CbaLX
	FBnwoRCC8ckOXAo/IoFfidwyus3VjNT+2BldS07KaPCLGnvvJOA2j4eJtEzoTUCwzkad9AR9UwC
	VddXVZkdMQ6aaWwUDkE=
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757612f8f.51.1749121384652;
        Thu, 05 Jun 2025 04:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdGUXYZXrNIrCyhAh0tp1ScDeHW0FOJjHuHj6Po7K6huTF1gR9wGCaSTi+dFD3HnrC0pmIFw==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757543f8f.51.1749121383960;
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20995275e9.23.2025.06.05.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Message-ID: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Date: Thu, 5 Jun 2025 13:03:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:06 PM, Bui Quang Minh wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. 

Why? AFAICS the multi-buffer mode depends on features negotiation, which
is not controlled by the VM user.

Let's suppose the user wants to attach an XDP program to do some per
packet stats accounting. That suddenly would cause drop packets
depending on conditions not controlled by the (guest) user. It looks
wrong to me.

XDP_ABORTED looks like a better choice.

/P



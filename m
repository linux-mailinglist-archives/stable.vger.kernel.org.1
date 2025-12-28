Return-Path: <stable+bounces-203440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C593DCE4A5D
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 10:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8046C3011769
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CC2C029F;
	Sun, 28 Dec 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5mmBUkZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPTkC7lQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BE2C0284
	for <stable@vger.kernel.org>; Sun, 28 Dec 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766912536; cv=none; b=u/avsswUnU1hk685vP1AyuyPKFT7jHDuJ/FmPXzKK89EMiMkdYyLOPENLZlHyq1+JA1CVlRigEe9xLQ1Iq7qZs+4aKXb1N+s5jTov+WDMVcldCn4JMu2yaBpFYSP8xOV0OO7ZzJkhfIA1kd6/kV92XN7VEFAJitdm9rLbV+4ZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766912536; c=relaxed/simple;
	bh=Ou7ZaYBTH1zYK+UpXkX/bEMorgWtw0RhmRMfDmefJdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEPwwLUFxk6XQhPrkfZdjjSXWB0L+i8UnrombISKMNP3YGldfL+51ORz9BEt0ouTGDrk7J+cNxZN6SuwFpfjsjgrTQxWTDY/nRm91CMJr6k3ja96uobVr//ZJixp/vf7BY5MKu7744ug3hInTqecgdOhhusbsNYDXceobsiuTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5mmBUkZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPTkC7lQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766912533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
	b=f5mmBUkZIuKzh3iVROnjjw6/1JDZEZ47bAyhqZOh9liONnR4SnpE7YulfnsGtRAb1HGIcH
	OD5/8KC1VHjh6MnNKZEXksHCfl5ZkURpDbKFSxOAd9O2Ftn6aGeS9//hGBXRiA+tu5G8YK
	lZD5jJkz66DzxUIkX0N2IIUomU8SLG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-08msC7K9MDeMBuC8MtvIvA-1; Sun, 28 Dec 2025 04:02:10 -0500
X-MC-Unique: 08msC7K9MDeMBuC8MtvIvA-1
X-Mimecast-MFC-AGG-ID: 08msC7K9MDeMBuC8MtvIvA_1766912529
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f4609e80so4232417f8f.3
        for <stable@vger.kernel.org>; Sun, 28 Dec 2025 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766912529; x=1767517329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
        b=tPTkC7lQl6YAdBfaHihXVV82IZrnUaOshr7tVjA24GW+LWSloIXPiXwzEQqOC7S8yI
         fAcdA/dwzPvS4JwMEj5UyWoTIy9zvfosEHMlMJnhpaJV8vHKLgxRAMvzGDv/5/UvV/yq
         z3rXqP4ESju3p3Pp2V+YldNDaOcSO1yMu6gGCSvE8ukb4pdJVVxs+GXzv/sfVXi4FLPX
         8ajrHYu4osz8csYVRl96TSxjfwP80if2vcqCLerrs0C4hWBZudnI+nKA0vZg7vFEgy+l
         tAzoOwTBqqZmq/2uvgRpMjNkd+osHyolCfE4iqnsbzfafeZ9v1jUENXwrkv4UWscmbUu
         E67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766912529; x=1767517329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
        b=gRI0OHCJI3mBnYyRDH+8WYZmOOUM4BhvFIQ6BA/1uil0e6vijeSGflv0fFitS5IoQD
         JiIq8pVN9N0aDcyMmlqg/XDUuVdZ0KzqgoZkr2eOuGzTvxje2/0zsBrtQpmPV1M+BmRY
         +uZTBice7kPWl/hKM9+13lespCEPw5tepi2gTAT0XUvR8yOS0HWpYrowOZ7liomx3Gpb
         g8x67+KfYZrOQu+x83ey4cauOuZEgro3zKJyOQtDRdzjtuaF71Pd0hZP3AFkWDPeWZS/
         buwC/l3s7HAHRMELlvpCXhiFf0+ehh+7h4V1ZZF72xlDEu5LJq1nOtKmSkDldruqL5e7
         xAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEF5SLIqI3sN6pSJ3KhkqoWIZm8lxHT/bAGBZFdqSeHjKjLhGqyF/7S06g1xQhpvDVQLcvp/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPza8MeNVi7OlS82DJshHo8yQqXZIq2e0Qifk5V8mDy1dH4fh
	HKNQhKQg60SDxvly1NKm+d1RzEY9Z7y0j7OiqCBXvFk+0IY9/IREWLQYjSeZVew7psDe8uUh8u9
	R3ST4D+a8m/PfX0Jb9Eh6wmkyznM/OCO27nyzFNDt69fMzh6GVDEDANWRXg==
X-Gm-Gg: AY/fxX5Gzjom72jUFCdxoc796DXa2IuD5Y2x/dReRQSO7jW2LBdXv/ObCXiiRr1WkZP
	QmwvF3wp2SYER/1aJynG24c0BDAl3ka6pPIJeCoV8ngB1R12dnie16KZ8A45jakUayYVdj5zOH5
	s0qPPcxGVKvCQXdQM3XqYXl+7b+CLWabBDztFK6rw1rlPu6YIrFIk5cpLIuu1omLFwsUnD3DGVl
	ev4rljcp3bMZH7FbVwLuRwGIFP082D++dk3WoRtI+OHhRhd7YNkSWA59mhiskY6tgGv8iyRuLnB
	mV2XIXwXB21A26ll+p3cC9vxbvF1ggkGdKFT2eOhWWPt31/2CoRzLLmdhFlB8ywDwDHA1AkRi7X
	y23jiNpTGiTqRbw==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr31586030f8f.46.1766912528759;
        Sun, 28 Dec 2025 01:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHMspkPwe7S0pZGpEQwfK3oywGl5rinLKECsu6Q7dO5WCye7HQiBnxVQZHRtE7DVSj+K0obA==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr31585991f8f.46.1766912528353;
        Sun, 28 Dec 2025 01:02:08 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm56251992f8f.34.2025.12.28.01.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:02:07 -0800 (PST)
Message-ID: <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Date: Sun, 28 Dec 2025 10:02:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
To: Qianchang Zhao <pioooooooooip@gmail.com>, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
 <20251218025923.22101-2-pioooooooooip@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218025923.22101-2-pioooooooooip@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 3:59 AM, Qianchang Zhao wrote:
> nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().
> 
> In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
> the code used to perform release_sock() and nfc_llcp_sock_put() in the
> CLOSED branch but then continued execution and later performed the same
> cleanup again on the common exit path. This results in refcount imbalance
> (double put) and unbalanced lock release.
> 
> Remove the redundant CLOSED-branch cleanup so that release_sock() and
> nfc_llcp_sock_put() are performed exactly once via the common exit path, 
> while keeping the existing DM_DISC reply behavior.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> ---
>  net/nfc/llcp_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index beeb3b4d2..ed37604ed 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
>  
>  	nfc_llcp_socket_purge(llcp_sock);
>  
> -	if (sk->sk_state == LLCP_CLOSED) {
> -		release_sock(sk);
> -		nfc_llcp_sock_put(llcp_sock);

To rephrase Krzysztof concernt, this does not looks like the correct
fix: later on nfc_llcp_recv_disc() will try a send over a closed socket,
which looks wrong. Instead you could just return after
nfc_llcp_sock_put(), or do something alike:

	if (sk->sk_state == LLCP_CLOSED)
		goto cleanup;

	// ...


cleanup:
	release_sock(sk);
	nfc_llcp_sock_put(llcp_sock);
}

/P



Return-Path: <stable+bounces-203441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD2CE4A69
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 10:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626A0300D422
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA2C0286;
	Sun, 28 Dec 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnMecPlS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSPFrPvr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AF1E572F
	for <stable@vger.kernel.org>; Sun, 28 Dec 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766913370; cv=none; b=S70AaaWK1eAuUvWy8zbvbWfl5xFktek1QadeKFiU73imymdToQoSHTFlFGLWej+da9ZBgM+D7w8NBcWheNpVLv1dS1nkn2HxV7gerRwhey+STLTmu4KUhsj7DKxdAI+ywLrm9d5CQ8aJQ8nUhaQod2HVxnH4HfMfwhBGyXNsnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766913370; c=relaxed/simple;
	bh=nbWeBZR6XGVP524Smmctu9vgqAt5Q8hidLuEr/btmkk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mb8MPHIb5zd5V8Lkag29G9znnHGsdqvCtDhVRmDe2LorTfMgce5ibmEgS9u/VDHBoze1Fo5zuYQB487XsOpHoBGWlbMVt+LCQr2UlUBx6qIowsL5QnJyNYUeW+Y8RE78x8KDJcGC2zHlJ4FEQc5G8nlm0IQpXQEncqCSqogl/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnMecPlS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSPFrPvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766913367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
	b=CnMecPlSSGODzbxaM1b/RyoTrV6e+SL3kgNVlcjdQKkWPfKCoO68Bmcb3W8hisdDiiDfh/
	3dY/q3DJqaFp6m86bJmbUFKDI+Egj/pTmDM+7gg5RKT+rlPw7ZAX7Pw9vd6A11vEygvRih
	9uxUULZlgABQjQvbZmitumAW5mxOjn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-k-GyPVkyOd-LDryHvUa95w-1; Sun, 28 Dec 2025 04:16:06 -0500
X-MC-Unique: k-GyPVkyOd-LDryHvUa95w-1
X-Mimecast-MFC-AGG-ID: k-GyPVkyOd-LDryHvUa95w_1766913365
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so21107155e9.1
        for <stable@vger.kernel.org>; Sun, 28 Dec 2025 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766913365; x=1767518165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
        b=MSPFrPvrE4v2c2UpchBm0vWkmM5wkaBABcFezaTPG9W9yl68ViqBATTmPNRWYS/YWi
         6Ew1xBmu3fh0jw88syyTDDUn/fOJQpbK/pm0+x0bhUwxVjngpQzaXhi6HfU4210+9RR4
         IZ1YRjzgRL0DaT0DojZM1tZD7M83A8yD00wxGFw79nBkwzUHJXo9EgpdqvJhgbnGiAQZ
         ybrTcZEB6YdaN6NaQ3zZWRyXdzcNFiW9kyEVhyFXJd2SmwE2BWJ6MgWMdlUko7zqxykr
         upJfcWHRlxMj4OgJ1aM7+ysd+L6J7e5YplAxbMLY56+RicvdJWp/8skK6HI3xGHlPv07
         h/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766913365; x=1767518165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
        b=CWNCJMpKXQT8Opv1ENpSCatnj5zDuIbTP5O2OGGac8Otfq2xVgSlDSza7MGIVq7IpK
         J4MQJuNOWARSYDs19ZqIcJ6aM1g6P225+FPQ8PSHuknBsVDE+ethFNlfoVe9MVlSoNQb
         UdLPpH76MqJjnBYkYggdoAwz7TCDur4vjnWSLJT1qsEfFw9amUx13JWns7YYeTcEEi5e
         5K59MSeQSdDzw3BBRx6ntkrR//E+b9bkuu2YTa1pwFa8uBd2gFQRtfeFLM/nw//92ZKd
         zUQajLMdB47Kg2Kz+lASUaZjIUDlhnlvS4fYr/1/SWRKYptM9K2GDxYQCYHy2prxczX9
         tA8g==
X-Forwarded-Encrypted: i=1; AJvYcCXj9mKDsGKogih5Xc//EFLqkAcHyxhYFr6QYMWY4NDybfATVO+36M714mbVH/Gm7cp/Tw3Y/v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukPtS6ESssKE22oyWooByzVFTckNmCIiR3Msjv+/ENUbP5dPR
	/94l3tCQvIArUZKthDHLN4UxhgDworSdj17DHbdLKS9Hm/38gYjs8RDCXS7SWNO744aoqv9csbx
	V0TsLi9XkubXDcADGjA/1lXMWwiHQ4S1EgXZQ5uWHmUvVgCIaUt+F4sWJYQ==
X-Gm-Gg: AY/fxX4naWCgZ9hWFZALAn+rSq43jvqbIDYXYSBFFEND2nAwXCCA8cxIpP6u9yWrG78
	DpjYVuzWMi6iko9YWiEYdlCJlaRnFhavN07rGI11LVkc8k0xxrBneK8ugT7G2W2F1FQcI9CpDX3
	VZVGsFlRg1ZDaZf8nyAKGPB5nCBLOalNZBPz15U1AL0fqNmRno1CNr80vNJdDIKXEr1h0WoesfH
	257KOrYttYbQ49U9PEYi8FwXffG8pnCE/GPA3cyiu6XFI7ePIVv7MPa3xeKKk9r8pue6CZ9V+3+
	umFDkPsTlPZkko8P9uaJqvAADZ3ryYiKMtbp/HVBB6PCZ9rbG78RE7v7vCQT0CLhXfKMi/tgjiG
	787PXE9W8gRLYZw==
X-Received: by 2002:a05:600c:46ce:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47d1953c020mr273497925e9.2.1766913365011;
        Sun, 28 Dec 2025 01:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1b7xKiUe0L9lJ/v6U9MSi8Fz0dXWgM5S/Kld+WqDKFXo/imkAnCu4ZFS2hAooiiE7pN9jOg==
X-Received: by 2002:a05:600c:46ce:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47d1953c020mr273497725e9.2.1766913364558;
        Sun, 28 Dec 2025 01:16:04 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm627616145e9.1.2025.12.28.01.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:16:04 -0800 (PST)
Message-ID: <88741cf8-7649-49e1-8d82-5440fccd618f@redhat.com>
Date: Sun, 28 Dec 2025 10:16:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
From: Paolo Abeni <pabeni@redhat.com>
To: Qianchang Zhao <pioooooooooip@gmail.com>, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
 <20251218025923.22101-2-pioooooooooip@gmail.com>
 <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Content-Language: en-US
In-Reply-To: <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/28/25 10:02 AM, Paolo Abeni wrote:
> On 12/18/25 3:59 AM, Qianchang Zhao wrote:
>> nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().
>>
>> In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
>> the code used to perform release_sock() and nfc_llcp_sock_put() in the
>> CLOSED branch but then continued execution and later performed the same
>> cleanup again on the common exit path. This results in refcount imbalance
>> (double put) and unbalanced lock release.
>>
>> Remove the redundant CLOSED-branch cleanup so that release_sock() and
>> nfc_llcp_sock_put() are performed exactly once via the common exit path, 
>> while keeping the existing DM_DISC reply behavior.
>>
>> Fixes: d646960f7986 ("NFC: Initial LLCP support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
>> ---
>>  net/nfc/llcp_core.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>> index beeb3b4d2..ed37604ed 100644
>> --- a/net/nfc/llcp_core.c
>> +++ b/net/nfc/llcp_core.c
>> @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
>>  
>>  	nfc_llcp_socket_purge(llcp_sock);
>>  
>> -	if (sk->sk_state == LLCP_CLOSED) {
>> -		release_sock(sk);
>> -		nfc_llcp_sock_put(llcp_sock);
> 
> To rephrase Krzysztof concernt, this does not looks like the correct
> fix: later on nfc_llcp_recv_disc() will try a send over a closed socket,
> which looks wrong. Instead you could just return after
> nfc_llcp_sock_put(), or do something alike:
> 
> 	if (sk->sk_state == LLCP_CLOSED)
> 		goto cleanup;
> 
> 	// ...
> 
> 
> cleanup:
> 	release_sock(sk);
> 	nfc_llcp_sock_put(llcp_sock);
> }

I'm sorry for the confusing feedback above.

I read the comments on patch 2/2 only after processing this one.

Indeed following the half-interrupted discussion on old revision, with
bad patch splitting is quite difficult.

@Qianchang Zhao: my _guess_ is that on LLCP_CLOSED the code has to
release the final sk reference... In any case discussion an a patch
series revision is not concluded until the reviewer agrees on that.

@Krzysztof: ... but still it looks like in the current code there is a
double release on the sk socket lock, which looks wrong, what am I
missing here?

/P



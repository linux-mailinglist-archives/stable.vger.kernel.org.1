Return-Path: <stable+bounces-207859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200BD0A753
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B8230B333B
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A94359F8C;
	Fri,  9 Jan 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP6aHjod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EED2E8B94;
	Fri,  9 Jan 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965737; cv=none; b=sMW8j5jSmSL8vW+x66ohbI2+pOuM5cNHWSyRFe3hvO5DilLKkfJn0RXHRZpn1k++we17dHpm/KSFGdm3J/xiu1Wc18BhnimgSIrpOOpM+0tL4xNEgLMpfpKeu+dm94qx5tjLfGevLXClkvU2jq0+03fXDPJJtemRjj3hJgWjMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965737; c=relaxed/simple;
	bh=exifGmoeBWKaTcVyJ3wiaGfoVWeC28oP0FSI8jCjcl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUqUqyWum+zDQ5xy9eyav7Q8cFlBLJ5CI7VRL6xirntQ7qfyt8MZK8yaz7jUjQwrwpyKYaWwl9TWzDXNnVU7YWRm3TmS0rloHR++B1t9fw29m0dYEQk3x/JotnIcUuVRHCXx1UbjPObTO/JhaBMBaDwQbUv9pzS00pilsqzSAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP6aHjod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EADC4CEF1;
	Fri,  9 Jan 2026 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767965737;
	bh=exifGmoeBWKaTcVyJ3wiaGfoVWeC28oP0FSI8jCjcl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pP6aHjod+CV1fq62S93+oUyzwnEyxfSqNUY3XaFVSFmapOMT6Bfigb48hI5J1jbHB
	 uCTDiMptwfOAKzz7Dq4va/oC46yrIOiK0ab+KKjE9LaLNLDf5LH/lJt3cbE7q1aNtB
	 QyxGQ4VOwTYN1bH7N/5WhWm0ppX1ybW/PEudFgGmez04Xav2UlflhM/9KUX3d/kCEa
	 257HWHrDRJwF69fAgr2tS3kJhq+kdDTD33AU1sIqk/yvG+Fb2sCJ5M3K3RwWaLqIYO
	 X2OZYG4jJMYG/1WKUsHN1goQq0EJ6G3CSMwA1grYnpttcHMA1N0DjhDnTZlX//oPy8
	 7qvmhYVs/riYA==
Message-ID: <2a77740f-12af-43d7-9a70-43e7afc79a58@kernel.org>
Date: Fri, 9 Jan 2026 14:35:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
To: Paolo Abeni <pabeni@redhat.com>, Qianchang Zhao
 <pioooooooooip@gmail.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
 <20251218025923.22101-2-pioooooooooip@gmail.com>
 <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
 <88741cf8-7649-49e1-8d82-5440fccd618f@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <88741cf8-7649-49e1-8d82-5440fccd618f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/12/2025 10:16, Paolo Abeni wrote:
> On 12/28/25 10:02 AM, Paolo Abeni wrote:
>> On 12/18/25 3:59 AM, Qianchang Zhao wrote:
>>> nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().
>>>
>>> In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
>>> the code used to perform release_sock() and nfc_llcp_sock_put() in the
>>> CLOSED branch but then continued execution and later performed the same
>>> cleanup again on the common exit path. This results in refcount imbalance
>>> (double put) and unbalanced lock release.
>>>
>>> Remove the redundant CLOSED-branch cleanup so that release_sock() and
>>> nfc_llcp_sock_put() are performed exactly once via the common exit path, 
>>> while keeping the existing DM_DISC reply behavior.
>>>
>>> Fixes: d646960f7986 ("NFC: Initial LLCP support")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
>>> ---
>>>  net/nfc/llcp_core.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>>> index beeb3b4d2..ed37604ed 100644
>>> --- a/net/nfc/llcp_core.c
>>> +++ b/net/nfc/llcp_core.c
>>> @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
>>>  
>>>  	nfc_llcp_socket_purge(llcp_sock);
>>>  
>>> -	if (sk->sk_state == LLCP_CLOSED) {
>>> -		release_sock(sk);
>>> -		nfc_llcp_sock_put(llcp_sock);
>>
>> To rephrase Krzysztof concernt, this does not looks like the correct
>> fix: later on nfc_llcp_recv_disc() will try a send over a closed socket,
>> which looks wrong. Instead you could just return after
>> nfc_llcp_sock_put(), or do something alike:
>>
>> 	if (sk->sk_state == LLCP_CLOSED)
>> 		goto cleanup;
>>
>> 	// ...
>>
>>
>> cleanup:
>> 	release_sock(sk);
>> 	nfc_llcp_sock_put(llcp_sock);
>> }
> 
> I'm sorry for the confusing feedback above.
> 
> I read the comments on patch 2/2 only after processing this one.
> 
> Indeed following the half-interrupted discussion on old revision, with
> bad patch splitting is quite difficult.
> 
> @Qianchang Zhao: my _guess_ is that on LLCP_CLOSED the code has to
> release the final sk reference... In any case discussion an a patch
> series revision is not concluded until the reviewer agrees on that.

I would expect the code to return on LLCP_CLOSED, instead of proceeding
to sending nfc_llcp_send_dm() disconnect, because nfc_llcp_send_dm()
should happen earlier (before marking LLCP socket as closed), but that's
more of my assumption than actual knowledge.

> 
> @Krzysztof: ... but still it looks like in the current code there is a
> double release on the sk socket lock, which looks wrong, what am I
> missing here?

Author focused only on get/put and of course from that point of view
there is imbalance. But I asked at v2, for which there was still no
answer, what about releasing the initial reference from
nfc_llcp_sock_from_sn(). Maybe that was the intention here?

Best regards,
Krzysztof


Return-Path: <stable+bounces-255087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLKCKFiKGGrCkwgAu9opvQ
	(envelope-from <stable+bounces-255087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:32:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D35F6530
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D05C301EB61
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321940242B;
	Thu, 28 May 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhRq8O0d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB42D978C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993147; cv=none; b=FBGeVuWskH22GMdzhlaUtzKq/yp3q33q/3z47idZR/HcGbzJJcRfOmwvCdEvQIxJ4MlDFaqiLBSJ8csh6eYCrQEme6pgX6tFu0PL4g3kHHzDfYl+vyYLjzETqPaDXDV2zHIiQ7qikO8VR1uUITn+nCX3gbLVJ0rKLXrsmJbf4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993147; c=relaxed/simple;
	bh=F6dv8TPWW/13dGP+ZBJhBGuAWttYv01S6yZqJ9bd55Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es4AEaFjVOHfzwfMPFs+vN5WnHE2MTwkH6XTMNZ2L7SnZk4UyyyfbfGFoiW+bH3vgEpIbDGL9pzzc+a1X9sDKLzo5TCg8Cul0Dnz5fxOQIaRMbaHQT42rUGKtTQVWYEBoYMeKLwnh7h6D+Mb8Vu9MEu+12J1WMPbWTX+VflD0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhRq8O0d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so70423255e9.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779993143; x=1780597943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgIc6FFWhSDaSLL/Z7NgL4wbq54EDyvmvF+ou2yO3wM=;
        b=RhRq8O0d+RlqfQgi2bF8cVzCvpgalFUFq/BidvQine5M96J7A+pLHzGlscGcY2bOM8
         Bo4LOgxw3NYi9k/8Z0mqLkkVjg+hJ3KfxTOKRJ6+wZVfshKZmYYd7RCSJN//IO30I1jU
         j0OM0gF6sGQQUzdhxTg+/sN9wg0TUW7VbRv0LnYkx2CscweQrHzDMXajHVrhcNg4/+Yt
         BIpAqBm/rxdT8SC2tgv46A6Y4CnbhpFXlsvcd33wVHz+Z5LGFZoCfIUeU/tsGv91b+yK
         tAE9HsB16EwQfKNKbFKhM4gRnPBiwmZVuah6ztKaMre0Q31ymt3T2hcn35oA5Bo2MG87
         GWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779993143; x=1780597943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgIc6FFWhSDaSLL/Z7NgL4wbq54EDyvmvF+ou2yO3wM=;
        b=PVsQmDfkRqBF2bl4TpVC9aBWus08HLvHRXpfDvwrxRDxjeEDHH/XBBGJ/Ww1NjyIbG
         8cgG6CI1O16vNAb7ZTeb9QlAxE0zklgr3AZG1rFi7NV/X5oquZ9bK+lbVMExNYGJlSfO
         R9egjlsoF2XJMbVv8KeQeob4wUAoK/c3tiNjK/g61PEjUDG51RC+BhrXHdUhlXDHuRvY
         +lINFw4CBgewOQ4r4KUfc1mhM5ygXVe1amvs6P14bMk1arzyGievLAsyOM1HFYTLwNSC
         O2E7vTWhWdY0VXWbg2p+RiIHgXKX2aqe9UVChZ5Wfmgnb9nThi3U3WHpUUYbddP1CZu6
         GMvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XrErH/WPPpKBOJ3/ZdEjVA2Q0qFvJP+ol095sXDfg7NDQF9MW25eb8AGYrrMH/6w5li+0M2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7ZynTdzR/apEylS/VHJO8kbvw4/xJ65VoZxN+9vvgfANOgW9
	LVrGZidwhZ47/1r4P48bcwPGAywjbhXwsdGMTOtPNUsMg/sc3i9eixrd
X-Gm-Gg: Acq92OGHo4qZuSJGwTx32u3dSCBndzitzWNW7UH2xD2afG+kqAv3QknUboRe7EdfkZe
	uW90T+jNZAZpLRpXXbxLPYCvnsz6+f08DVQY0tpO74jd32CkXaiOwMdSKcWfjFAqHbnGREjfzmW
	O4lmgScvIGQhqd1sgAHTDnXRvs7D32rmA0ZvO5B9b3RjGj3eegVJKP2N3hFXLUgSPkXdjf9DZu0
	Ixcm+FsGCiBOvIlAqWZQsTCbkjzBfXw7xMVu3oTNnOHHk3tfqT+wKLq9MBMbcLhhFce40MxTK4z
	Wmx8V3Lh+HLxGEPeqyljnsr77O9bWQDsz4V/aU5rbA1Kzrzik9kJL214eSkhQ5gxO8pUric65tv
	UlsHvJKqng2hXEB2mwk2C83F1W3pMb9N1V3iwVMLheh1VeRSUJEwhJXdYCSxpUzKbkxJNBsaGvd
	o7o+dQKqqNUroCny7LDucDYVGsXyDrfXBMQA6eqNyAl9vAVA9N3XQjIvyPo7Ea9PfYQfO67E/sz
	SmPggtej8yHUgv7EDLA/vaJli7MjIW93oOrUD6csP+1MYZK1Tnspar6u6hz/4b7VcxTCEMnOLuQ
	RihdqUqi8Z1z
X-Received: by 2002:a05:600c:c83:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-49042488b81mr468589175e9.1.1779993143226;
        Thu, 28 May 2026 11:32:23 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909235d4e5sm78490035e9.2.2026.05.28.11.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 11:32:22 -0700 (PDT)
Message-ID: <5f63fd24-a0da-4623-b449-1e749c3e2085@gmail.com>
Date: Thu, 28 May 2026 19:32:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
To: lazyming <minhnguyen.080505@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sowmini.varadhan@oracle.com,
 willemdebruijn.kernel@gmail.com, w@1wt.eu, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, achender@kernel.org, mst@redhat.com,
 jasowang@redhat.com, Willem de Bruijn <willemb@google.com>
References: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255087-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,1wt.eu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1B5D35F6530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 05:12, lazyming wrote:
> From: Minh Nguyen <minhnguyen.080505@gmail.com>
> 
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> the old skb_shared_info header into a new buffer via memcpy(), which
> includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> Neither function calls net_zcopy_get() for the new shinfo, creating an
> unaccounted holder: every skb_shared_info with destructor_arg set will
> call skb_zcopy_clear() once when freed, but the corresponding
> net_zcopy_get() was never called for the new copy. Repeated calls
> drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
> TX skbs still hold live destructor_arg pointers.

A bit late but lgtm

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov



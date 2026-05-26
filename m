Return-Path: <stable+bounces-254377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIdHAdO0FWqLYQcAu9opvQ
	(envelope-from <stable+bounces-254377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:57:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE45D8244
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E9B305EAB9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98F3B4423;
	Tue, 26 May 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDxCOmCz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC53FE375
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807058; cv=none; b=OVl29J5p/eR+amY1JxJJRoHqBphnecm/CTAEnsxUa72XDeTzrBW06l/AOObFFDge1gB+cP0XuFAhC3NhAxbCituQoBzUwJ95HCUT/Znrr0CuyVtIzzBelSPR5mUof/iPPAeD2Yk3Q/Q1+xBRkAwmmcgmq5vo61dDkZ2tMWfrq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807058; c=relaxed/simple;
	bh=F5YMabiE8O+ywnrU305U0Znz0rgWJB8UF35MQVPj76k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHFiD8uwGjK1z7T2VYNzWtA0YqJUBEerRaZEFZuO8U2XJdC01UN5uAhJyAEQRQi6RJ/Vrbng36Kkc8iRQMsX3hoIbSo8LFd1t1P2/HehKUY6tRuJVBf10ctuo+2gYXTaXXvi0DapzRznMFb9AFG00QEKeReOwYIsNm1ZClCqdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDxCOmCz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so1953006a12.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779807054; x=1780411854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjQZn0mYVYssmLLf8Ym16szY/Tz1EKrMNloBKoyB+kw=;
        b=sDxCOmCzfmsYyApJVRTicHNKTJncmplELdx5V2OOUIMNYtSkx29uAHcwJxPe/Viq/z
         CSAxuit3weSUfGUTy4cdvH4E7+wSj9nKEwyGwp4k5k9FpNMzTvzy42BWN+NDJ2UrT29J
         JKfik4TN8gJnB7SP1GpHNrKRXujJrubP9QEYXLvkDWhuHj5m9iwfOhrI/KBMR7CqSv2f
         HO2ND/+Yf0JbPabbju5QDM1RQi0Q/ocCWoSQCrt6NwcOS7X5S6OJc49jdNshfWYnS8OF
         vwpIR960FbmKFRRqhky+htJSP+BYHJIJfMRYr2/bWxhphbZqywKgUrCr7B4s+CzDaec8
         7ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807054; x=1780411854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjQZn0mYVYssmLLf8Ym16szY/Tz1EKrMNloBKoyB+kw=;
        b=rdqXxOuHOpRSBuAw0jLAYo05Qyj/2hClOAYIERxK3101Tf9cgUIyw4mUwnkgZJ9w/w
         1ZUxZTAZr40eoQrHTsY9FbLmDLu8ErykQAU9WUo9hqcN6SemAZiCtjXZvW9WrwdPLACd
         7N22D+KTgmQQKOD01pz2rQFgpyWPE92Tl4pmutw00SEqcGwNA4GJ8LBapKls62uvwCgz
         U6uSE6UEIN4zsSoSoJmIQepPvPwR/xe41zqdrD3xsAI2ak+x4EpvgJw8gfR/ZOBBE98B
         RYj0nUXNACKtdh1/H/CB2XAcUQcJJHlKt23hUR1UutqufoJaU7GvrLq7PFvnqnHzsDlO
         LE/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8pce7J6c14b5AErCpbUvHHTKRZ0xNqM169gp5zuJTsgPda+syHjTwtV9BNb+OkzwSXmybQNL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkMYoiBOxb9DtLTPEgg8XvBYk8ValHJMfRTulTAGedx9TU0gj
	uAzEC0DXh1tlKoVGVevJGmEXoJAeMz8/BfYfGPxbQU2w8dluVGPQnJJv
X-Gm-Gg: Acq92OH2Rk+UD4i02UAshvJqT5ioVFyXXURrQoN15MXOM0UZ37LLxmTN7jvk7WOQ35l
	v60xFOr+X22rRedV+O1GFKpUGbIMkinNY3GOQwLfNf9RxmoQ1K/s8SMTQWMwURb41XI6KBhtMko
	v2aL3SCoI1BrwGpn6rAI//MX/qXw8bFoy3rv/d7n9XNdcpwIzWHhoidmf+pFYwGQL7jXYz16wST
	BxXaEt3fn/7lfA0L/Opa3s9kJlFAJYUTioL4+f3O5nJQniJSGn8edeRV/bLy38ppVdjORjlZaHq
	pIV9QNQLcA26eN6RS11g+QIMIA+swfCWl8scM9SU9xoIII79Kh1bDXN6BeeqQHpS+1qW3ei09fz
	CU83xdPiNYyiMRrkprDbqNwj7q9WgEFQbuB5Gsd9ABGkLHtFAX35vNNtRdSAFQ+6Cr8/mFCxzsH
	bT/BLMjhy0Eqk0M0YUwFxRjZrC84EraqzgZ/hqEA07y04ujmhNTlRiwMBnHwCOXaPex4EybQobu
	6OlbWboEEUhpf1haSxFoecplHykg4TeXeP0uTnOSv3ta585KRCjZ1039DZVj30=
X-Received: by 2002:aa7:d859:0:b0:688:9b94:65e2 with SMTP id 4fb4d7f45d1cf-6889b94691bmr6352673a12.7.1779807053827;
        Tue, 26 May 2026 07:50:53 -0700 (PDT)
Received: from [10.109.92.22] (82-132-212-62.dab.02.net. [82.132.212.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9b6d287sm5221421a12.6.2026.05.26.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 07:50:52 -0700 (PDT)
Message-ID: <f2026867-c0dd-4260-ba0b-b20a2eb9bce7@gmail.com>
Date: Tue, 26 May 2026 15:50:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 lazyming <minhnguyen.080505@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, w@1wt.eu, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, achender@kernel.org,
 mst@redhat.com, jasowang@redhat.com
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
 <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
 <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254377-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 96CE45D8244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 16:31, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> Willem de Bruijn wrote:
>>> Willem de Bruijn wrote:
>>>> lazyming wrote:
>>>>> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
>>>>> the old skb_shared_info header into a new buffer via memcpy(), which
>>>>> includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
>>>>
>>>> These functions are not supposed to maintain zerocopy frags.
>>>>
>>>> Both call skb_orphan_frags.
>>>>
>>>> I think what may need to happen is to invert the order of that call
>>>> and the memcpy. Current code:
>>>>
>>>>          memcpy((struct skb_shared_info *)(data + size),
>>>>                 skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
>>>>          if (skb_orphan_frags(skb, gfp_mask)) {
>>>>                  skb_kfree_head(data);
>>>>                  return -ENOMEM;
>>>>          }
>>>
>>> Never mind. This actually corresponds to the first Sashiko report you
>>> mentioned: if zerocopy skbs are converted, then the memcpy prior to
>>> that call will have stale state.
>>>
>>> For skbs where skb_orphan_frags does not do a deep copy, we do need to
>>> take this extra reference.
>>>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>
>> Not sure the potential preexisting issue is reachable.
>>
>> Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
>> refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.
>>
>> So if such an skb reaches pskb_expand_head, it should be guaranteed to
>> not be a clone. Same for the carve methods added later.
>>
>> But, the commit that added zerocopy, commit a6686f2f382b
>> ("skbuff: skb supports zero-copy buffers"), included this
>> pksb_expand_head call to skb_copy_ubufs from the start. That implies
>> that was expected to be reachable. I just don't see how yet.
>>
>> If it is reachable, then all that is needed is to clear shinfo->flags.
>> Or more neatly,
>>
>>      skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
> 
> Also, I'm not the expert on more recent managed frags
> (SKBFL_MANAGED_FRAG_REFS).

For that one, pages are guaranteed to be alive as long as the
ubuf_info is not destroyed, hence we don't hold per shinfo
refs. IOW, the lifetime of the pages is bound to the ubuf_info.

> That calls skb_zcopy_downgrade_managed in pskb_expand_head, but not in
> the two other functions with memcpy before skb_copy_ubufs:
> pskb_carve_inside_header and pskb_carve_inside_nonlinear.
> 
> I assume because those shorten the skb, so no risk of getting mixed
> mode refcounted and non-refcounted frags?

 From a quick glance, if reachable, they should "downgrade", otherwise
they leak pages. The new data inherits SKBFL_MANAGED_FRAG_REFS and
ubuf_info but takes additional references with skb_frag_ref(). I'll
take a closer look.

> In general zerocopy can be split in refcounted and non-refcounted.
> 
> Refcounted zerocopy will not downgrade in these cases, so will not
> modify shinfo->flags after memcpy.
> 
> Non-refcounted should always get converted to copy in skb_clone,
> so will not enter the skb_cloned() branch here.
> 
> If in doubt maybe warrants a rare WARN_ON_ONCE patch.

-- 
Pavel Begunkov



Return-Path: <stable+bounces-60745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC31939EB1
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E36B21E71
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D514D71E;
	Tue, 23 Jul 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlRAv+BN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266A383AB
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730050; cv=none; b=DSrajTU12zMmrXs4KAXkSA0ZmlVcYr80SxASUn1XiNzqnMpkEMCMQBZOIEI+kEdE2dZD3WbEcLsm9FmfCIsevAqXGcT4fBuiwhU5tvKJv9DegQSEDxxJeeP1KxrqehkUQcXpEg62Nndl7NjsTq7rCxoEsUrjUcIZD7zwJ78V0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730050; c=relaxed/simple;
	bh=TBPirh3jKiWxpLLGLgpESD9t7UhyEC115ITRFrnTNJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwQjLfmfvzmV1wiXW8M63ocENrDmodqXrVUPuRyir5Cv0yKBf3EOv2ulKxWSHm3qUsKE66RXx3OPQlsXAZGF8QCUJQ+KeKrq+0yyLPRIfEfZ3I99WumlTo0RlFx3lBaxUJ4GkH1wL0mqLH3KoErl/N0DGUOdXNlxRgoUWOsZm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlRAv+BN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721730048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhNinhvrGP79lOO1c/1IVjAHp19vKxY/aQ0LkZkFu3g=;
	b=KlRAv+BNJLfsV79CRh3bks9rM5Tt16kvt6IPZrj7HQth6fDJt7L+8hSmnJsjjIKKhCOIKL
	KOSQI2t1XChZgcRpyQBrS4lb0zH/tZmd0u9rN9SYzBZGLHNeZVPO5jOJv62TmH7EV7rhCn
	YCSj3Wkeg0oEbgNZWnpcQIup1OdxiW8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-wmKLKENNOnugio6QiL8XiQ-1; Tue, 23 Jul 2024 06:20:46 -0400
X-MC-Unique: wmKLKENNOnugio6QiL8XiQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427d4b0d412so2493135e9.1
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 03:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721730045; x=1722334845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhNinhvrGP79lOO1c/1IVjAHp19vKxY/aQ0LkZkFu3g=;
        b=sYp/qRdOkpdjVwdRThhpnD5LI+D9wPCBnhLInhzwysis6iH/uGIJ+XnWzJv61eVpEI
         KQtoQLeEPE87LDtkAGqpVATWoRuUnJhg+spTX6MG6DxBCJhy4IUnrjHW+ZLfDYcuodgD
         6YWZlWHLYGWkHhhmKkxQoGXk8bWnH1VdPL1Dl8PjtOhM8+3Eu5/CsjIVDofiug/HhIaA
         /5RJE0ge7FOyDCjNOPK/T4DRdfv82S5XFxy8sNFCnq8JWr88KMpGNZow8s+Z8FyEmtlk
         0mwDfaLp+dxUEMZvRa3cHrXVcvZw4O1Fe4qU+biencY0lEtFHH4lBAU2aig0+6gqdzdQ
         w+vA==
X-Forwarded-Encrypted: i=1; AJvYcCXpMpY6y/FJVq9XqsJMw7Ec6V7MrYRfyUtgVu4GWdbAGhVuqodgOwDykmEWoDKcM5JKlDgddFQNdY728BiQoNyYFy4XG1Hs
X-Gm-Message-State: AOJu0Ywmmotiy6lIj1/n3/glBp1FY37R5bWsS4T8MWfOz/M8O+3qgLtR
	xlSH4I6GBcxXt2iZundD8bcJzHpCy8k7ADfeUMj34vTQYR+/ZSeR4biieqhlIH5cFRjFi5CKFH6
	pdd7qmub3UJ/g+jKgdB5cZFrqNYwCHxZ8SPvn1nuJAPCf3Pp4Km1d6e1O5rEMBQ==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr43493955e9.4.1721730045321;
        Tue, 23 Jul 2024 03:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSzqwRL1LIwuRdraAOj+GaUOlgz5u6xwK3jOZXo5lxnKHsVUV0+EQ8JihhdGm97x1Wgb+v/Q==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr43493865e9.4.1721730044949;
        Tue, 23 Jul 2024 03:20:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f1f5d7c5sm9238405e9.1.2024.07.23.03.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:20:44 -0700 (PDT)
Message-ID: <361c9ebd-d161-41a9-8690-b9e115836666@redhat.com>
Date: Tue, 23 Jul 2024 12:20:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Bailey Forrest <bcf@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 willemb@google.com, shailend@google.com, hramamurthy@google.com,
 csully@google.com, jfraker@google.com, stable@vger.kernel.org,
 Jeroen de Borst <jeroendb@google.com>
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
 <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
 <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com>
 <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
 <CANH7hM4FEtF+VNvSg5PPPYWH8HzHpS+oQdW98=MP7cTu+nOA+g@mail.gmail.com>
 <CAF=yD-JHDkDit0wPoKftTt3ZhtJ0gM3+E_YJsACKu916FpuCEg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAF=yD-JHDkDit0wPoKftTt3ZhtJ0gM3+E_YJsACKu916FpuCEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/24 21:10, Willem de Bruijn wrote:
> On Fri, Jul 19, 2024 at 9:56 AM Bailey Forrest <bcf@google.com> wrote:
>> If last_frag_size is evenly divisible by GVE_TX_MAX_BUF_SIZE_DQO, it
>> doesn't hit the edge case we're looking for.
>>
>> - If it's evenly divisible, then we know it will use exactly
>> (last_frag_size / GVE_TX_MAX_BUF_SIZE_DQO) descriptors
> 
> This assumes that gso_segment start is aligned with skb_frag
> start. That is not necessarily true, right?
> 
> If headlen minus protocol headers is 1B, then the first segment
> will have two descriptors { 1B, 9KB - 1 }. And the next segment
> can have skb_frag_size - ( 9KB - 1).
> 
> I think the statement is correct, but because every multiple
> of 16KB is so much larger than the max gso_size of ~9KB,
> that a single segment will never include more than two
> skb_frags.

I'm a bit lost, but what abut big TCP? that should allow (considerably) 
more than 2 frags 16K each per segment.

In any case it looks like this needs at least some comments clarification.

Thanks,

Paolo



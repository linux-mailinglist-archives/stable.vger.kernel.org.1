Return-Path: <stable+bounces-60698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4C938FA8
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FD3B2150B
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D416D312;
	Mon, 22 Jul 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9ZrZl2R"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3E16A38B
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653781; cv=none; b=vArZd6tkZq3fDTAypC+vbG8Nq4phGTXlhP8y5XKVbSDTAIOfFFqzJPcazJePjesa+r34QYP+d5bfiLTrtQHRG3EbMRjV70a3KoJ8qkWF4iSvn9y3Y4RSk1SLiWgzaVKCN411AfflUYjYYDiibcyDKrppMVavdTybz6VovB+83Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653781; c=relaxed/simple;
	bh=dACOo0fmf97BNI4s1f8a/S3c6BJcwbtOOnHYFvk7Yhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iac82V9FOBRXuyQ52X9RmRja9noFwDytSyJ3UZinxRREtY0RMak7bimb/ct0kBP+RgWoIryipgtnHBbXNeGCE1vorhcgEIT7bdVvcgU9FcsCwNSNZhryVUkjr20yA7vRP9XFTSwBk9DABGv4JWObMuCLGNu8fdoqCL7kQMqFEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9ZrZl2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721653778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pPjmGtQSxYLqY3oA0GTldwdaTnqKLEINoaeFI9U5dsc=;
	b=V9ZrZl2Renh/4wI/1Tfj/AEWkqL5LZFWzMvCzuxZ/Tx/Xv/PqKJHZbb0MqiwQvoYhwqJtW
	tlJsK8T0ko3luKukZqiyqXVHpY3fszM9ti4J/D0VzwzsVOka2MCi4H90fLTiAmwCFMBcAR
	BTu1RWN9u/IG+PPTCDm3qC6omttvQOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224--PVg5i3ZOEWoljuu1aNR7Q-1; Mon, 22 Jul 2024 09:09:37 -0400
X-MC-Unique: -PVg5i3ZOEWoljuu1aNR7Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36835daf8b7so3173494f8f.2
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 06:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721653776; x=1722258576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPjmGtQSxYLqY3oA0GTldwdaTnqKLEINoaeFI9U5dsc=;
        b=Nnuu5XPzG77mX6v5M0jc6zEIdbFv2sw60X6w6TsA6qNFH9s49bwa44xmGLe6qavt7B
         W5/Gl5qYUbGgjLshmRsrtkWcRbXKYgL/p77w4uXfQD3ryMmVxQPZ46vNR8cacJDxQJnj
         imnp+aYwjlGit3IPyzu/2iSEwmetwcUKKXruLqELq7WzMZS5x5cCv5d2BuQaiXY9UKeG
         LDoqdmI3gfSQMQ6y69VaW6vRBcAFnDbvvPZr34H0Po2A2cBdY8gTDY3JmmPPGfYhcTNj
         yvi+Eoce+qDPWvvZ39WaYKkoZF2NlWz+IseDbKd8E10mY6HgwxWgbgxuFrN+VsdtW4fJ
         hrGw==
X-Forwarded-Encrypted: i=1; AJvYcCV5euvabRRx44qDFts1myH6cD9rkALG8gWsFCb4cVLLN8d7yoFdxv39A0EiKzYpCqag8JZ//yU4ZDmewS70DOfZ2Hin7RLF
X-Gm-Message-State: AOJu0Yx8rV7Jck7ZrJPUkYHKU5mUq/v1vtMIoiUUVKMJiIZ8AN5Mgag4
	a5eFMRA20++7kEYVM6hyGCS84sLqjSKHYo54TN/I8hXu42FL9N69EnHsvia/Af5zIkr2mi0rVNQ
	Q1dd5nzxL2aeRDt8aqssWY0O3H3KECmBHNjKRxoLyi22hqWmcaouVyg==
X-Received: by 2002:a5d:4444:0:b0:366:f50a:2061 with SMTP id ffacd0b85a97d-369bb2b40cemr4879368f8f.50.1721653776219;
        Mon, 22 Jul 2024 06:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoaG2eLWBIBI8fxbZUOyO7o0VaPNn/aLxAJc2HvsEESpvUDsRZ8oLQx3drcW1lulkUq0Q+3Q==
X-Received: by 2002:a5d:4444:0:b0:366:f50a:2061 with SMTP id ffacd0b85a97d-369bb2b40cemr4879342f8f.50.1721653775728;
        Mon, 22 Jul 2024 06:09:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9? (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de. [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878811bedsm8494497f8f.117.2024.07.22.06.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:09:35 -0700 (PDT)
Message-ID: <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
Date: Mon, 22 Jul 2024 15:09:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
To: Jerome Glisse <jglisse@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240720173543.897972-1-jglisse@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240720173543.897972-1-jglisse@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.07.24 19:35, Jerome Glisse wrote:
> Because maxnode bug there is no way to bind or migrate_pages to the
> last node in multi-node NUMA system unless you lie about maxnodes
> when making the mbind, set_mempolicy or migrate_pages syscall.
> 
> Manpage for those syscall describe maxnodes as the number of bits in
> the node bitmap ("bit mask of nodes containing up to maxnode bits").
> Thus if maxnode is n then we expect to have a n bit(s) bitmap which
> means that the mask of valid bits is ((1 << n) - 1). The get_nodes()
> decrement lead to the mask being ((1 << (n - 1)) - 1).
> 
> The three syscalls use a common helper get_nodes() and first things
> this helper do is decrement maxnode by 1 which leads to using n-1 bits
> in the provided mask of nodes (see get_bitmap() an helper function to
> get_nodes()).
> 
> The lead to two bugs, either the last node in the bitmap provided will
> not be use in either of the three syscalls, or the syscalls will error
> out and return EINVAL if the only bit set in the bitmap was the last
> bit in the mask of nodes (which is ignored because of the bug and an
> empty mask of nodes is an invalid argument).
> 
> I am surprised this bug was never caught ... it has been in the kernel
> since forever.

Let's look at QEMU: backends/hostmem.c

     /*
      * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
      * as argument to mbind() due to an old Linux bug (feature?) which
      * cuts off the last specified node. This means backend->host_nodes
      * must have MAX_NODES+1 bits available.
      */

Which means that it's been known for a long time, and the workaround 
seems to be pretty easy.

So I wonder if we rather want to update the documentation to match reality.

-- 
Cheers,

David / dhildenb



Return-Path: <stable+bounces-87546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D99A6855
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFD1C2169B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093C1F8914;
	Mon, 21 Oct 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL+p08HZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72B1F6695
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513494; cv=none; b=RxyqgJ7xqeYdHrSGJDeel2cn4bc1jkIGPUijjuSNkENVFX/fRRxVcAXcC9i+qlidT0mDvmmqlA0WDPKNIvfdp0OenP5JW0i9+a8c7sO3G0ah/075yEooaT8IdqpeKqmMA45ErzpBZ9+6cHhJesLPigJ3Pa4SYqmNoQ7J84ydjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513494; c=relaxed/simple;
	bh=E6f4GVf4RQ5aZpaECBba5PJGeGtKWzezTHTPyIUKiy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kR16b7if6niO2y3krmjlnbWlFkYzTegXiT7PreHExThz4hwg4W+hPOaZskSSBmW/vWf1LWWGxEutedNx2MesCfz94G7p9TamnM8fHlPhu3H/HhvnAJcSDJfbUl0OgcRO359frWXCXRD+3Zs6yaEQSM9kSqwAewcrjXCxX37yT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XL+p08HZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729513491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeyejyiRdEw6rKsHu+O78eEbFoe39LRLAjs70v2plro=;
	b=XL+p08HZBJOSZG7AaKuslUh7poT/nl3xqSmvZWFK8Y1dc541JnbQQBC2mIMqoKER+TcwWk
	JSnEn1LMxih5k4PG3NIqSUunG6uTFIexPDz1JB6BidU3q1sgaSbPh1xxahhQMvIvElBCHy
	NG/4qtGwJX3Cqf0uC5lXyUV/lUtITZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-VMnFf-2DOXuOVD2FVJA7Lw-1; Mon, 21 Oct 2024 08:24:46 -0400
X-MC-Unique: VMnFf-2DOXuOVD2FVJA7Lw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so35282825e9.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 05:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513485; x=1730118285;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeyejyiRdEw6rKsHu+O78eEbFoe39LRLAjs70v2plro=;
        b=kMW7azAhTSqVvioqwdE44VObMWcBmzMCuVEyleRbBRhqCyKzH555gRbToebSq71sXc
         XCbvznBxzEwDXLmqOAghfnZ4g+OPfnFzBM6eh8NmDvITYjkYhKVr/xWnMB4aBHWvRlfj
         mDbR7xJuEXVMrgnmoIEpWisX3vDCN+5Nw8jm3yTdRZlD/dOc4/O4jQygiR161OwvGpbZ
         h3rw+7gwRzF4/ls96VQpa1Ke24J9exM+2sLhlUGjMavYUeLunIIor32Ev8vVqpXIw6i+
         SUJ1ffBe00iEpUnxGT/ddw28gIxqX34O71kxzeBh8VFw5xHafxy8sm+mRgohCftHtCMS
         DRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqxlQ1W0PfclyNrgJoWEeHTcl+pSADn9kYLjYbJth+3PyE+0NEnIYYavN8Ujki9Hy7Io1WJm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f7MdV5k0+e9AkI/3kWo3anJnDxvxTNmgcezEPZjOEhk+wpF+
	vAHzFnTNxRaV8cwVJMd2k2mkulHRvM1OlZyACrGYwpbgAKD5qSqK9u98ObdJOPLLqy2AjSsUpGy
	xOoi+9xBsgFB8Vef4y1Ze4fKSEmdlPGkIngL1NUvQCThQaWy2FD+Nyg==
X-Received: by 2002:a5d:4d03:0:b0:37d:5103:e41d with SMTP id ffacd0b85a97d-37eb487c2a1mr8191685f8f.39.1729513485574;
        Mon, 21 Oct 2024 05:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvbwpaxMn58GCCzQHMh8yFh3OWKf7NjucI4zP1GwWeXIz3sENhlE0U5+ugdezuC9ROET9juQ==
X-Received: by 2002:a5d:4d03:0:b0:37d:5103:e41d with SMTP id ffacd0b85a97d-37eb487c2a1mr8191650f8f.39.1729513485123;
        Mon, 21 Oct 2024 05:24:45 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc183sm55928715e9.40.2024.10.21.05.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:24:44 -0700 (PDT)
Message-ID: <74c0b70c-8e2b-42be-b81d-cb6b1527b53d@redhat.com>
Date: Mon, 21 Oct 2024 14:24:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm: don't install PMD mappings when THPs
 are disabled by the" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org, bfu@redhat.com,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, hughd@google.com,
 imbrenda@linux.ibm.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 thuth@redhat.com, wangkefeng.wang@huawei.com, willy@infradead.org
References: <2024101837-mammogram-headsman-2dec@gregkh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <2024101837-mammogram-headsman-2dec@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 18.10.24 um 09:57 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2b0f922323ccfa76219bcaacd35cd50aeaa13592
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101837-mammogram-headsman-2dec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 

I'll take a stab at this today.

-- 
Cheers,

David / dhildenb



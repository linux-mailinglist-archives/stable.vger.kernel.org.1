Return-Path: <stable+bounces-179068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD25B4AAF9
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A68E4461AD
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FB31E117;
	Tue,  9 Sep 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoq4x5pF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BB280A5F
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415363; cv=none; b=ShCfdkeiQHo9vlALgmAlGBh7u0ys12O5TfhnLPEcbjq3g9NgqvQt7C+oqk/olObpZOLubZNc5wrP8dZ2zAtIrcnxgA49Y+69qpIz0yJRitA7fA9/2YBgtc/ROlW7qwQfBPURIf9TqD6ZMf2EvE4yeZ0HdpRr2s7zH7o3YauvB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415363; c=relaxed/simple;
	bh=P+FQuJhA1PrMmXPlKv+nsJEpTrgwiKcfidU0cZC6Aa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmhTuIo32bG5qMjE4l/9H1xlQ/SjKl6BRWgdhfN1xdVoYvTL4c6x8//O9YzSXpdLq3ALSJmWuQaYseWhattKiGwjP76O4F5G8Skzw9wRtJaHocyPbY5whiv3MGAFxhq8H+aUp0pWK9GmZiS9aI91zZLz8AxSzs/VRRXUTt4eAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qoq4x5pF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
	b=Qoq4x5pFUGU1DykoFGTXoEO2idhvA2xzWejA//KVtC1m3k7lmMMrjEfxCOath5aZGXAP4v
	kK8DPAj+J0KVpln3nIQLps5jqmMcX41I7cMvuuCr/SQIHUhV8BJEFnT+dkdnlnqOULffOB
	cuoixur8veIJNZfK4w2EsFj3yT7VUK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-5ZuOPtpBP4Wb0eujPlLOtg-1; Tue, 09 Sep 2025 06:55:59 -0400
X-MC-Unique: 5ZuOPtpBP4Wb0eujPlLOtg-1
X-Mimecast-MFC-AGG-ID: 5ZuOPtpBP4Wb0eujPlLOtg_1757415358
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3d3d2472b92so3108573f8f.1
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415358; x=1758020158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
        b=lklgpF8Nc1IiCY0S27LJWZl22A82J3eEp+V9lC0nkOgK6V0qx4O8nF6LDbBdRfbYO3
         nxL63fPnC6ZtZ/rNgwtnzKeY6QVhMgElvFQ/zQYQTQpB1yW48BoSBpvaLDTXhjcJX0cG
         KBRfV7zOiJf06zkv1F10BBvKZ6xRjPQStzVQiupkg0bmIyR4WkeBKtIITqYliNQBdiGn
         T9sUmGbzz2NiULDg2pcBQv3/KE3XzWkTU7iTTNlGIoOB1lDBOSRZbImbKrTYLf5iDW+W
         zqVDzY93vaNAATSgFPEWJ0Cntd/DubQrDT7W2KWsK56TvgHun5eHRbYaTIJ4pCXub8+Y
         k9IQ==
X-Gm-Message-State: AOJu0YzdcLI2ucf+AbD6Zgypds9+ne4XuMkW2zebdfQeFJIyg7JE9yHV
	aQ7wvWluI/LMmRv6AYE/9XXWO5vd9VOgAQQDKZ2B+PopOd8p3ZF/oaW+JWalcrlIoiLYoEtkcCl
	wHKnOx8KotjZ0mrkcMrKpWvqK3KKizHbT6pOsjb/w9bDZJ4gvDxVgciccXw==
X-Gm-Gg: ASbGncsPpAwePG1z3lax0s0uAXWGyoRLveLQpErUYA5P6lAegaLiPKUzgai3TZjm6CV
	z4TTI8cLz44up4YO+NQxqggtv5gutDP0+ZE+6uKpq4ieHRVJ3nCLwmHesfKl759CDcmc37iqqHX
	dZpGneSlOAZ1BncfpYeISXw+XgvV18Dq2mk/dqhl2ak7K0jdrmZSasiyYtIdaq8wvR6H4sYFL/N
	WRkJCpp2OZeCzlXlyXdfhljDm34mEG62ZbRj/RsImlisztXe139guHV4ONRzFbozfLQAOiNjCtj
	O42tYjuwQEaFS96za7+zx1yVJALzriRjWT/KKAao4WOZ1alpvxa07ZX3P6Z8WTh3UaxR6Cu8V/Y
	rLfDz9U2UyEA=
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036209f8f.12.1757415357959;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnmvFRwe+aQHJSfIB96YNcsk+I5KT04KIyycuSAFbcSbi1qXb6O4cvvbjLLpNmJLmEpECY3Q==
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036184f8f.12.1757415357529;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224eb27sm2177631f8f.62.2025.09.09.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Message-ID: <d7026515-433f-4c45-9d24-ea529d5f04b4@redhat.com>
Date: Tue, 9 Sep 2025 12:55:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 1:50 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().
> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

whoops, I replied to v1 by mistake:

https://lore.kernel.org/netdev/d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com/T/#mb92f279c773d443313f9e0951a2107060078802c

But the comments apply here as well.

Thanks,

Paolo



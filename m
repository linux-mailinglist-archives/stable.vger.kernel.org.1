Return-Path: <stable+bounces-179067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC77B4AAEE
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15F81BC32E8
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9E31C59D;
	Tue,  9 Sep 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpCxW0qh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4F31815E
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415259; cv=none; b=gNbHoZTd2YsIlTL13+CTsH8E+yMyPjh77vLB3nVgpvlNH8C74LoFM6iR3yd4juSoNQVgo3FS4WW3QdR3XMY/DiAo+dtKFcSIsI4Z3Xkoli8Lg9GpjUETicgnLzFOcLjdpRPgGq8SxOer2dxe+sCnAJB0u+OauK6duMLM8nbp7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415259; c=relaxed/simple;
	bh=HM2NMJxMcYEfNGGq/oJ04HVM1ReMtP0pTKiI9lNtLO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAz84rEFzvRmrrN+nWiBgNrlU3YF8FqJO9WpaoQSG1KW6/WMxDVt34uRsGfNfEw/2d8faZ6BkpTKVy3S6PnAslYylABx20MGT5Q3M5ObToeLQ7GQpUZnGzQqs10dAGsTc/iQzSQ74V9CsSXKTfA/4l8R9XKrzZQGd1yhhAwgS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpCxW0qh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
	b=gpCxW0qhk1uEeLDpM1/pUgAl4AyIW8/ZxoWq40S02nC66SRj/MnFM2sdqdzlqSL1rBBvvr
	WoX9GE4wlUYeeSEsucKpC59fp9ozXtcoXfakWqtuaODoT0VQaoUiPprs/eMVLmqaZILXax
	vzMrX7rob1OeU464ifRvloqM7u1APZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-61-kgPzCMHad1TcGlviq1g-1; Tue, 09 Sep 2025 06:54:15 -0400
X-MC-Unique: 61-kgPzCMHad1TcGlviq1g-1
X-Mimecast-MFC-AGG-ID: 61-kgPzCMHad1TcGlviq1g_1757415254
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e5190bcba1so2873916f8f.2
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 03:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415254; x=1758020054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
        b=TTqqFbKOQEQbSvZ/6JUJNGddT/TJ3uMcstgqiaK+pc6TxErXaIWbWSKz4+q5gIWR1P
         fQOfgTw99FTjrrffiPLYdW1YCegGiRa+ZlqObeqRTZwDYiTZVN6MK7YH34akwNQ2cTrJ
         hxSjtl3sj7fqlN99bC0gc4NmTgUUufnK6fGzACsFw0XfJB95Z+SwA4TrkZVQS+kt/KcH
         Dst86seMmxFkiMvZiQDBL/Wzoylo3Lxyxd7Axa3DH3rNR3x+e7fTp4Z7WMRSPaGAp52O
         GMOc+P+0zz5F4mjYbepLaDHe2j3lP7POdBqPdyIhaImMZr55/pW7EZA5aWU5R7nNXgcW
         xezw==
X-Gm-Message-State: AOJu0YyUm7uFib62u3EEJuEC+igSjVQkEpXqPMnuBLLEAJPtqvCl77JG
	6xW2kSiId6fTrGWPR32Pd6f04TqD6BdqhxgNQYBJFop5Li8OtwIV+piDQvLSmlBWzREAm8w11To
	e3iQEbYL4Idl1hOznmHRvTdK1fw3YaVAT23J169HQjzQHbo/+2iCtgG5S5A==
X-Gm-Gg: ASbGncv/jo9tEE5cNIzNqUx7DDvcqe4M6nmEantlYzbVs/894OtLrCHaEx1t5AKFohe
	dI6Fhr280Hk7BKUR832J9qbvZPRxSNvs7LDuM0WOToTDGMnwmsNIx8zZzxBd6UBKvOiifzGTVr3
	G+E/BG7XGjFj89D0i6mqIEXoy4hk6tSkKUlNWsdqxKzv+61XqDbpfyaApFbX9+89lv54KiEQFoT
	thYRjRdvj/ngMDtfXv494cTj1CMm+3ygs16fJxtp7AhI+M4Z374IYiixrvph2r9+0+rlNOsYUBy
	bMdbjrILCjnaZfKJ+uxfEtRIxqoInCbfSOnJg6qs0kZWxP/SLA3TvVFN1x5CZzHg+fXlctFiJVo
	2u0SoJargrWA=
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576940f8f.29.1757415254073;
        Tue, 09 Sep 2025 03:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDykjIB4jgP7Ave7E3MW1xUfG9vBdncrD27nwwsMpPlkFkaSDsK+O0VNW6P6FuPNrXfZBbA==
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576920f8f.29.1757415253634;
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca22esm2336206f8f.18.2025.09.09.03.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Message-ID: <d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com>
Date: Tue, 9 Sep 2025 12:54:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/25 6:31 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().

Elaborating a bit more on the `why` could help the review.

> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

[...]
@@ -178,9 +181,11 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
>  	 * being accessed while registration is still pending.
>  	 */
>  	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
> -
>  out:
> +	return ret;
>  
> +out_inc:
> +	atomic_inc(&ibmr->ic->i_fastreg_wrs);

The existing error path on ib_post_send() is left untouched. I think it
would be cleaner and less error prone to let it use the above label, too.

/P



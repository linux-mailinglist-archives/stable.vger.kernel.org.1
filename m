Return-Path: <stable+bounces-121209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDBA547E6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F96D7A41F4
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8F2040B3;
	Thu,  6 Mar 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RddjQ8eS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFD20102E
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257402; cv=none; b=b0yB5rTwbV5048n8vFwn1rnjESL3IbLZEZcZ4k6bwJCHVpeYTSqgOkOb/pgRsbRrDr7vq8/WtnsFH/Y7lxWQOiqXDqLR9h1DVr0YNfuNyQEf1LTl3eG5kdtJMLf5G7s0ch2bZWE+VBGkTJHVOHyWEjghh15iu7Zbr1Wgr67DfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257402; c=relaxed/simple;
	bh=eIviFgFwPx2HwSUMq5kkwtsNyVo5QezffE+/FRZmj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZRpwKmGRk/169l+lnmBrVcwpsmZakfIDToJKSeh5fX8gZeWLLkdyB/Xvt5Mr8zi9jEMQIfKO6b91rSFu1U+9VKMt81n8ss2ET8q/OfTKFjn++k9K56moHR29CvXw/di8vuXHEZofy0oRVjtpCcUkuD80obEVTHTTLZr1WCvQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RddjQ8eS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
	b=RddjQ8eSVs7JuMUGuaPulc0h5IdDOf0daNyK7Sx+6837SIdBjGBYq0IPm98Zj2y2Upt32u
	YZL9YV2m6MRqLw1F5G+ujtqnNA1USCfrWPitOOCTH24Bb+mrisUOE4v0UTkV2LUpClTZe+
	vIITf6dT4KNOnd1V3nE6ab5CVihrTq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-18hPxxTmMNSKb3So0Ytgkw-1; Thu, 06 Mar 2025 05:36:38 -0500
X-MC-Unique: 18hPxxTmMNSKb3So0Ytgkw-1
X-Mimecast-MFC-AGG-ID: 18hPxxTmMNSKb3So0Ytgkw_1741257397
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390fd681712so242235f8f.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257397; x=1741862197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
        b=CoEXqu0NE9NJ9GO/4ATETW6oTRrzgAVOWChZuDdy5R3sK4qfyinLQuQvmOaZL0Ag8j
         +v/UZE8umlZXbnqqOQiPp6Xhz8RiXv8k+bVjZ9VKVWXfsDtw5nLp2qVMor2xW/6lRvw7
         XA5EN7q5L7NDOYMNINIdh9QDZu7nbsZabr+jV2pMY1PfhM0Aw0SnWCbw3NG+fmImNKTC
         ztNYwatkYcSi0CEIcKY6R+ob4OlQ6IRGtk1J4/cpkS7Mfy20hW9FtXTODBeElmcYYWjE
         CErTfFwRz2n/EnyggXpO4VZ5MmFyP0LeSVJ5nlhpD5r1NQRAFvdI5VjXV/mRkAEy2mUg
         Dfpg==
X-Forwarded-Encrypted: i=1; AJvYcCXpjt9aK+6GIvasvPDfppsNv3grl2kgRkhbWK+/abaJhbS840fnt7scHEFvP6Pm4TVhbxPM254=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzts+sw8CHXgJS16RWMeQ97antkXkBRoYHFgUsYvVut9z6nx5RW
	6RmscjMTKIQuM6/6JihZvsy0mbIPAFX4fQVnLd5Q/h6VHkBRX+k0ltwa980jgfpBkRjclJCeEn/
	DGcv1VwV0J6r5JfHML4bWkjVpujyfA6E+XdeFkWZuE89qdEkD/TC00Q==
X-Gm-Gg: ASbGncscHxHlYf0WC2E+2GvnEoqWjf8a6yNjm8AwdaJLdNUmfiOtqioIMgQX9jbfQaA
	1O4IZM2OeA+rsoeI3qTzI8PpyzCwlJJZqrWrD9itQwdpSnnG9IU+Ghr64OyYM+YvF9bn5xGk7US
	bdwP4y4KYjHpe5qvSch/zTaX617TpwCRuksHafrHN0CxexwW791YbAuIQCuKHd+OjO/G9zif2qU
	Fd7la9WsFD5cfbWcQqLbn5nSEDq5qEdxz7U78GA9B5QTYkcWIl4yptpN19p95apCtOYEzOgv5CY
	Q/SyyN71F8HZJuXjhHyOYJloSd37L/7bTXskRXAtWWzxIA==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778417f8f.44.1741257396874;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxqUdlV1rQR47fVsjY5mR2qgd1ZZUfY4cR3vuzXwjWACsfsXX/46BAzCY25BIGbrKimMUnRg==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778406f8f.44.1741257396568;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm1658819f8f.18.2025.03.06.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Message-ID: <7e4122c2-0c0b-4d55-a3aa-e4c15e28c5d5@redhat.com>
Date: Thu, 6 Mar 2025 11:36:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in __qlcnic_pci_sriov_enable()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 jiasheng@iscas.ac.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:18 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails.
> 
> Fixes: 60ec7fcfe768 ("qlcnic: potential dereference null pointer of rx_queue->page_ring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

I think we are better off addressing the problem in
qlcnic_sriov_alloc_vlans(), so that eventual future callers of such
fuction will not need special handling.

Thanks,

Paolo



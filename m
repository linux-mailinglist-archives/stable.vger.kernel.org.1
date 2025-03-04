Return-Path: <stable+bounces-120234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2046A4DC94
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CACD174491
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802A1FF1A0;
	Tue,  4 Mar 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtvz3JgN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E7200BB4
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087731; cv=none; b=msdTJhN5v2ZLuX+Mnwa0P/K90AUNlWueow+z/KQQWiAWpE43QEJ6xcxZ4Sszq/h1bgv8Ek6Q6EqExRKzQN5h2nupqWlDijHYYS+MjHUEO7XFICLxssYeJVegi0oj0Efhu7PxC3rdSFwlOXGK2jqj6ucokObKwGH9z1leOzdrEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087731; c=relaxed/simple;
	bh=KnUdtItjGNYgdCcN9y5Rg4Cul1YLre/02YFHO8L2ZVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vud22S0LIopICBwwVb/eKNmOil2MGDI1CkQOdxAXBQpTzAWdixkQbHixF4qe+s0w+ByT//pNRthQVxRMA4RvT+BV3BHi53IDUoGcTJCUZPc4co9Tt5mojneTgSOFmMaeevwoH+pCD/wwyo4pwlqcObvflHsyV3OR1p7sM6gGG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtvz3JgN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741087729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
	b=dtvz3JgNkYmOqslrHjxbVsIma0BKWxjf85mVxFRZcrq4a65yox9pLpIXizvFka+EtZhkG8
	UwzQ2Yj8draesUCviR8ws50Yz9QKV1TTVo7GGbVJd8Gno94524USdRvWqw8COpEbdZ3IyM
	JNfPMjKs+3hf1kRzCvH01RpZ3nhzntY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-xymrmNoWMHy9co2Q-avNDQ-1; Tue, 04 Mar 2025 06:28:33 -0500
X-MC-Unique: xymrmNoWMHy9co2Q-avNDQ-1
X-Mimecast-MFC-AGG-ID: xymrmNoWMHy9co2Q-avNDQ_1741087712
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390fd681712so1332904f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 03:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087712; x=1741692512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
        b=F5dq4/X4q7lRSppAXTwQU5v0QBYSD2MUqN3c9KMlpZfEk3L+lDWbv8PPedsPv0TlWN
         aNoVjom/wprjO+mTpAocpdYi3ZI8uDVxLmnsDKQgYTTqjhTbeRUDL+UOuD5aUWAqI03y
         sLJCtFlqBXFcI4HByVWNxzQ/d/qZX4jP3YgEKHivmsVtAe9elxA6qLpzSNXj6tTSayvX
         anqUDsLBm+T21Adld01vB78rJJ2cP/JdlyZkIslbDzYDG6yk6t82/5wfX2M9qYZCeV1S
         sXA7A049A6dFnvvyJxm3tCz6zMDGPpU5gLRPyHs0jBR6AEdkfXNKdvUfwibXL3qPb5gY
         hLIw==
X-Forwarded-Encrypted: i=1; AJvYcCUXyk3yHdhpA62R8iPGerWjuo6xcoKLMOyYNcl/mdYn6pJVgGC+kEAiS2ps94c4bFjY3dklf+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmkuenaJXeYy6h5FFh/LnOcBB8QqMu7sB1EtbWrRCAhyKuusAk
	2++awm7uvPsbMHkAs0Rsh2xmqazS/udLXt/SJAoI/f3iMrOKQefHT0Oyt71kBGmYZhwAQCJ/whF
	eM5Qb+zQ1G2ZPMusP3mxaUf/ukN/uxu/CQUgAZ3fP89xlZhlcKw7FHA==
X-Gm-Gg: ASbGncu+M8NAgYqDV/J1bvTU7rx8fCfU8Bpy41zbm27grW8webXzzWrzvHdnXZ27G8b
	bBu3ijtLrdSQ2sdU/KUJSG3CKZIce/FwWlTvqsKkqpUaA7R54sXBB627fpqAT1SNeKR7iVGmId5
	jCh0W79upgEDqXsE8PMM73KTIM9B8Xw4K78hcCY+v4HC7+OtMpSBC1DYQtTfN/4Hy3ostjeyqQG
	jR6YYYK1TLD2x8+5+ESj0FYjR+qclr/6U3iOQ79bepUGhxFUGTuH7Pv5TMBnFiLISBpVotl54GN
	XJYaGK53Kgk/AVvv6Yyk5FqYbuYrjdzHibhUYBGRxD2Y/g==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424446f8f.43.1741087711873;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqZ/TRGcqVpyJ16gAgzdOfvndPozt1EifipipyO5TrSqSLkUzB4NwQLxlVOUb/6RXZ9PIEUQ==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424428f8f.43.1741087711524;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm231184535e9.26.2025.03.04.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Message-ID: <63e68624-3672-4473-be15-ce04eb3cd2ed@redhat.com>
Date: Tue, 4 Mar 2025 12:28:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/25 10:24 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
> be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

AFAICS the fix is not complete: sriov vlans could still be leaked when
qlcnic_sriov_alloc_vlans() fails on any VF with id > 0.

Please handle even such scenario.

Thanks!

Paolo



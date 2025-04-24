Return-Path: <stable+bounces-136540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED14A9A72E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A7792018E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0522541C;
	Thu, 24 Apr 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5nbH4Fa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FE224228
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484856; cv=none; b=KLWIRSLzMQYXKlPKJpS3tdEijvuyESjRvnlEuky3Dif9abX00ikuZFGo9VJrbZT2RXVQMIwn3cdqPu77Jpp4gIQkc19R0njgUIhsFbo8C/SvPsK2rd/xUgBHw1832I/TnrrMMSTIj69EC0ZepAHsRDFwZb//L4pKG8sw6HluaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484856; c=relaxed/simple;
	bh=paGGoyoZnRW1m7g7h1F3XFqoQ0+nQRGX9p7YkqYjVWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1AzS6pHcmzVsUs6kylwfFDK7/9sYlPNgpLA2bJ0jlqyhqWkXEdoB4wnYoMWl8wOo4nICw+WIBR0flkmdUcPljyn32DbxLhmXoW9f+UlxUaerQ/ybMvyvLI3trCAaKCRhhULUkC4jesd2qbzL/NEGdw+QiC0OcFXXfHjw7pb3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5nbH4Fa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745484853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pftB6zmblfz1vCxU5fqCKgvx+TE18dKtjoYVArm5R6Q=;
	b=f5nbH4Fa5ew1W3w0scE3dIlTc0nutCFVdaUCU105ZfhZESbT0S2sp9pKKsNkkJz+5DFOxf
	u2MlQeZL7GXWZVaq7Nl6AO4hXlP3pLFmAYP+0fYw5ok/ii57N3svqgPQC0Wp/SJlg1rDFr
	UZJezust+zvgxFGdra4mwZ1XbV/v+L4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-bBgvrtXiNwmEoYuuxQMBRQ-1; Thu, 24 Apr 2025 04:54:10 -0400
X-MC-Unique: bBgvrtXiNwmEoYuuxQMBRQ-1
X-Mimecast-MFC-AGG-ID: bBgvrtXiNwmEoYuuxQMBRQ_1745484849
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d08915f61so3702875e9.2
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 01:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484849; x=1746089649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pftB6zmblfz1vCxU5fqCKgvx+TE18dKtjoYVArm5R6Q=;
        b=YRRJ7B3ilF++9C3QupyTIt8KADt3zOUMqdaijo4GSeQNcMmGpAcxa3WpJpaY7FvtUd
         U6WuzJe0w/fNhi8hKWusvcUWPDE7xRo1ybxNCWv9Q1uaskCp4xYbnD1Dn+7bYfjpEmq8
         aCqv52z+USteUyM8JkR6wt2E31t2XzBgS1/VV0Vz0fWFHTKC0M+3sPEUiqTKxluh4VGp
         DysCDU1gmTPOi62eHgMFHyVJ+X53R/B76OgPAYt2UfWq3pUs0RvEcDep/lxOPZSm9UcP
         zvFlwFCbZykTylYMhNjYtOIY006C7Rd9xm8Dcsr+FGGXbIEekotfOUd9yy3gnphjFxYF
         WfUg==
X-Gm-Message-State: AOJu0YxpR8g+n567ckgFxhTt9cQAXfmSQ+o74To+1SQlm0eTV9BBoOKX
	OuL20EYTHT547y5PxYT2v3uPXU5+j2+FiwaUYrEYCQZqPCXuzSjfx0zUfIwV3YvgLCossfzi4HI
	2X15zaTJdyJ0t+aG9GOYR26ip2TVHjI3rpieHPF/bFdsc57iUAz9Wwg==
X-Gm-Gg: ASbGncvabJTpEXt6VZoNMXNvWmmKWXelx115raOph/G7UUEWtkNigF+g2LUX69U5GJh
	7oAze+7ehwYTXQuzz18zlxpr6fr8qbcCdHU7sS8DxcE0sMN7QyY3suFgkJyXhiDqTazMkOAS/zo
	Bj012FisQUTzzKvTW8e0u+GCWrkTY5HWVW4xCMonh/qYqbUAWnV3tTAyAAVvjGWw5CBu1Mi56i8
	47bcz1cZ96HbSDzgnkl3a6ph7xXaQFhhiphJWD6wdyqoNEFO6WHpj3HkUyUGihSMYpt+Zu0s7QK
	SnDMwqCKZKXGMvrfBMyoj9r5+ci5XhfLks7uurw=
X-Received: by 2002:a05:600c:4e0c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-4409bd86819mr13058195e9.25.1745484849209;
        Thu, 24 Apr 2025 01:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqstuVMKXRfIfjVGAhmeakWqDfpmADfftb5xQky926OxvT8IMDcEdyz8TdVKcbRypTiAhDLA==
X-Received: by 2002:a05:600c:4e0c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-4409bd86819mr13057925e9.25.1745484848793;
        Thu, 24 Apr 2025 01:54:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a3afbsm11871335e9.16.2025.04.24.01.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 01:54:08 -0700 (PDT)
Message-ID: <d5114fb3-4ca8-4ab8-acb2-120a7b940d6f@redhat.com>
Date: Thu, 24 Apr 2025 10:54:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
To: "Badole, Vishal" <vishal.badole@amd.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, Thomas.Lendacky@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Raju.Rangoju@amd.com
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
 <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
 <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 9:57 AM, Badole, Vishal wrote:
> On 4/23/2025 3:50 AM, Jacob Keller wrote:
>> On 4/21/2025 7:04 AM, Vishal Badole wrote:
>>> According to the XGMAC specification, enabling features such as Layer 3
>>> and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
>>> and Virtualized Network support automatically selects the IPC Full
>>> Checksum Offload Engine on the receive side.
>>>
>>> When RX checksum offload is disabled, these dependent features must also
>>> be disabled to prevent abnormal behavior caused by mismatched feature
>>> dependencies.
>>>
>>> Ensure that toggling RX checksum offload (disabling or enabling) properly
>>> disables or enables all dependent features, maintaining consistent and
>>> expected behavior in the network device.
>>>
>>
>> My understanding based on previous changes I've made to Intel drivers,
>> the netdev community opinion here is that the driver shouldn't
>> automatically change user configuration like this. Instead, it should
>> reject requests to disable a feature if that isn't possible due to the
>> other requirements.
>>
>> In this case, that means checking and rejecting disable of Rx checksum
>> offload whenever the features which depend on it are enabled, and reject
>> requests to enable the features when Rx checksum is disabled.
> 
> Thank you for sharing your perspective and experience with Intel 
> drivers. From my understanding, the fix_features() callback in ethtool 
> handles enabling and disabling the dependent features required for the 
> requested feature to function correctly. It also ensures that the 
> correct status is reflected in ethtool and notifies the user.
> 
> However, if the user wishes to enable or disable those dependent 
> features again, they can do so using the appropriate ethtool settings.

AFAICS there are two different things here:

- automatic update of NETIF_F_RXHASH according to NETIF_F_RXCSUM value:
that should be avoid and instead incompatible changes should be rejected
with a suitable error message.

- automatic update of header split and vxlan depending on NETIF_F_RXCSUM
value: that could be allowed as AFAICS the driver does not currently
offer any other method to flip modify configuration (and make the state
consistent).

Thanks,

Paolo




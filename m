Return-Path: <stable+bounces-128489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68EAA7D87C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C25A3AF83A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D417227EAE;
	Mon,  7 Apr 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V22P3ufQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B161494CF
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015864; cv=none; b=l1NBiix//h0Ou2+9+ztMLbG8xcTSAWg6J1PIc1s4fBaQuUiBwDmJah+WwpKSw7xEV5C3nizOTApyxSZtyvR28NcufJo9jSif8TEdrQk/oxD4DTCFvVBbHI1saVR5t0A2Dop14KVpztGX9QA/ZePTG9NesqJSMjXac5q5k0/CcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015864; c=relaxed/simple;
	bh=ivifpmJA5RzuP+2VfL7wZfuN1Is6XWXXTnQ1F141g1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD0UW4ec5d6qEk+EejOydJl0riSbkp8Q+iM3AV3nyJEcn9WeqL6FRondpBM9+vvdULNClxXYKVPmmcR7mwKmo/9WWIINaPzVroIxy30p3D3WfBMvzen0apD1iEBvv8PojQnPWrrjhvib0V+96JuWq5+LW7YhNwxhobrrTpOz0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V22P3ufQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jdWTVOx71WrbrI+bILmB8IlavscoRW8coYO7NfgYHhI=;
	b=V22P3ufQ1WW1T1hKfV+VMyGj4DiLwYsKJL9F9g/LsiAox7qeCVijUICjISWHLXUEpbsIpD
	hEmIM7Uxc+QindY9czwV7/3mr5uuosRbNEKCdLrkzH46cAW/TWdtGKz4r5asHJcehn4KmH
	RFwipDI/GXaAluqz4JpKVgBl9xzHjgs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-ZSQ_1HfQOMS4Q3gKO3NlMw-1; Mon, 07 Apr 2025 04:50:59 -0400
X-MC-Unique: ZSQ_1HfQOMS4Q3gKO3NlMw-1
X-Mimecast-MFC-AGG-ID: ZSQ_1HfQOMS4Q3gKO3NlMw_1744015859
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39979ad285bso2412632f8f.2
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 01:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015859; x=1744620659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdWTVOx71WrbrI+bILmB8IlavscoRW8coYO7NfgYHhI=;
        b=F3sGmQox45uk/4TZ/Wcld5pdeVhqCdFTGNvvLUZ1ONnQ3+BJ6lB6d/+UanVCrHaEre
         Ckz7b0hz4DDvHVGW3YaL50906pOz60YwmIJ+ALy8lt6oeKI77i11SfxzoF3NvdaLFfws
         J2rQAFtg/Glh/sQUxlA7TeOQwsYGc1QIG30/C0sG9jNMZzs6xGmiIYk1DWh6QRfE+2yE
         BgFJz3JZKX0v1DkIUeDPKntzCr/BjSr8B6AInngOTyqTT19Xo3W+q3VwuJioUKc9TpSW
         MM68ltl1VkjyqDGCQIc9XlLYuf+S6ycHhQR2WVRfd3lJGuepwTQhDtMu32PWC2e4SABZ
         xO1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfK/+iPOtrB2x/y5svQYg5mJRIV3CdScXPb/SGpljEiMrvfadUVHNu70HsElgLud34VE5roEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJDi6mXJcjELTGuWeud/GBa+9aP54IO98I+5ZaEaknN1N+BfJ
	bx+ljODpDJ7f8jXFmJK5FHZSP94AmxlRylO23nZkkjh1LAOHqt5/9oUCXjNuBz2fLwHVqozqMzg
	+QsCI/KaTl2D0/VAW5gNRPMH1v5VAB2Cn9WBQ4jvM5zzN+m7rebJFPg==
X-Gm-Gg: ASbGncvmT/3EfiWWl/9pFd0fYipEs1BdwpA+Lp9I1lN67MCZKemSTh/xqYJKW3ETTVD
	J5dz9DTJyZHIo0rlRMHUlKMcFC/jkNE1jmiQrK6uzDxVyHyo/TECcrcHgglsifGWvas+ibnAg2K
	BCg4wHRFBo7eInbYvHuToTJLCpfa5bWjW3QDlEmlRy8/KZ8nqil5Mzo0HH6yqtQH+69CiOurbjT
	exPS1BzB/oMWV0tD8bcDNPBwURsTFfMlKDvxmfTqX1Ifgtq3Wm5FQVPFIYoE++bmv9h1OYuYeu1
	VpzxY8tmS2oGn4NwSU+vRuElcit8NezmPLAD1thPriNXmrx0uZUcy9QQ9+5JOAfWJaeSfI0lnlC
	yMCTqbuuiuVr/yb8T3UUmquWRmyz0Kj8YirKj++PcS7s=
X-Received: by 2002:a05:6000:40dc:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39d0de29387mr8430336f8f.31.1744015858755;
        Mon, 07 Apr 2025 01:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLN7bHhtvPRoeB2LIslpGvlY/eR4p3LIlYzOev7LpsbPTKPEJQ1+mxYzmjkKRaA1ybGp2MTA==
X-Received: by 2002:a05:6000:40dc:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39d0de29387mr8430310f8f.31.1744015858397;
        Mon, 07 Apr 2025 01:50:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:3c00:8b01:4fd9:b833:e1e9? (p200300cbc7383c008b014fd9b833e1e9.dip0.t-ipconnect.de. [2003:cb:c738:3c00:8b01:4fd9:b833:e1e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226ee4sm11716681f8f.93.2025.04.07.01.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 01:50:57 -0700 (PDT)
Message-ID: <25adc196-1070-4d55-b5bb-34dcdd6639d2@redhat.com>
Date: Mon, 7 Apr 2025 10:50:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
References: <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <39a67ca9-966b-40c1-b080-95d8e2cde376@redhat.com>
 <20250407044246-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407044246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 10:44, Michael S. Tsirkin wrote:
> Wow great job digging through all these hypervisors!
> 
> On Mon, Apr 07, 2025 at 10:38:59AM +0200, David Hildenbrand wrote:
>> crossvm:
>> https://github.com/google/crosvm/blob/main/devices/src/virtio/balloon.rs
>>
>> -> Hard-codes queue numbers; does *not* offer/implement
>>     VIRTIO_BALLOON_F_STATS_VQ but does offer VIRTIO_BALLOON_F_STATS_VQ
>>     and VIRTIO_BALLOON_F_DEFLATE_ON_OOM.
>>
>> -> Implements something that is not in the virtio-spec
>>
>> const VIRTIO_BALLOON_F_WS_REPORTING: u32 = 8; // Working Set Reporting
>> virtqueues
>>
>> and
>>
>> const WS_DATA_VQ: usize = 5;
>> const WS_OP_VQ: usize = 6;
>>
>>
>> IIUC, Linux inside cross-vm might actually be problematic? They would
>> disagree on the virtqueue for free-page-reporting
> 
> 
> That's why things must be tied to negotiated features, not to offered
> ones.

cross-vm also has this weird comment:

"
const VIRTIO_BALLOON_F_PAGE_REPORTING: u32 = 5; // Page reporting virtqueue
                                                 // TODO(b/273973298): 
this should maybe be bit 6? to be changed later
"

Not sure why that should be bit 6, the spec says 5 ...

So maybe whatever they run inside the VM is also out of spec ... Really 
hard to tell.

-- 
Cheers,

David / dhildenb



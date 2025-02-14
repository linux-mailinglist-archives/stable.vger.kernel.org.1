Return-Path: <stable+bounces-116465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB67A36922
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409A0188F9FB
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F71FDA65;
	Fri, 14 Feb 2025 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0l1a3PC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA01FC7C1
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576324; cv=none; b=Nk5Zr0jfcOWUkvWmE6fUzpHLePUVzP2LqgIomU6IrB+l9VSfdgT2VlPyc2o2GZqyQlLQ5Idw5QrrvSB8Al9fJck4284ZSdJcM7lTwTLibrltU+gGKC06RAiN5/ZNyeeGDtWVsWmr6447IbTGWpLVrBAJnPjd5MGy57J+ZwpRc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576324; c=relaxed/simple;
	bh=3FgOVFO8GNqDS2zLxm0cMMBnAmqo1GiengKzpNDRW/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVdpwdW1KkA+XWlnG9yguSETw9xbIu2xJRiKINhEMfvpBjwdvNCpXYY3JArtkHocxyvCbS4wwpMkQedNotJf6HINp58d0ClzSj9CFGrHWijmIY6s/5tdl8rJFEDim34rSo0jFMd38Wj7jeFPUVDyEw3uDtUoMntO/tPuvH3tN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0l1a3PC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739576321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dkl08VAARbn7X2yB9Abn8zNYw7VapeXfiEWGo0rvbzs=;
	b=f0l1a3PCh8mp3Ku6UCEteOQHN3DNRGsDVZbk/iNvy6ce4Dm9W2f69OJ/iBKPFa8vEDEKxA
	U+jAX1pDWNi2k5hR8bhJgFI5pjXEPixMyZEaBptr55qPBXDlKwwIF1zTQqJ/V/aUfLA7IM
	ccEEjvXNxWkBMhFXNg306Eh/JlHSMJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-h1vY8DYbNhS3K3RJJlK5Dw-1; Fri, 14 Feb 2025 18:38:40 -0500
X-MC-Unique: h1vY8DYbNhS3K3RJJlK5Dw-1
X-Mimecast-MFC-AGG-ID: h1vY8DYbNhS3K3RJJlK5Dw_1739576319
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4395fa20a21so15219295e9.1
        for <Stable@vger.kernel.org>; Fri, 14 Feb 2025 15:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739576319; x=1740181119;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkl08VAARbn7X2yB9Abn8zNYw7VapeXfiEWGo0rvbzs=;
        b=fQUKL00d5LocTh9aBm5B8kQgiZnPgbzlawSJVLBpHJIyRl9EfEWOcGZtxPzhy2L84h
         dRe8auy9w7i5UetdKJtTWFGMMNcI89YqtUkHD1uFyme05xYfKk2VEn5yCcN6jTksC19+
         kCtf3crql0izTAjP8X+Pex8ChJV3EnMgC3lztS7FeHPiEpRprdgxzsiGBVLODJ2N1KHf
         FsjHEPiEDLVWWV89H7OC0Fq2PWA6PlHHyeP3U6mCOx8xjjHp1ODmNE+qvLaefdn6rHvS
         kUzciyiOpM5sjTy5RniTkXJSCPwNVAt0e8nTSTHQfIzNSxLcDME+/y2KfjiA987/4nfz
         r/dw==
X-Forwarded-Encrypted: i=1; AJvYcCU6nQEYdzRGkJQ9hnWY2lOIeIc8gat3maLGUPnlqFTma0F1Ia3nlAi2D9NWlLHM1sD0d6/Ni9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAn8rrW/PQbHMbT4M1Cld9uwhV5cLLhFIafEdCCh8AH5kK+br
	bpzfl9g2VJDWTIyeGZL7bGJYJ3/bW3kvMrxd7NpMj9SmcfmaaiE91z/YibRxflce/dd4GMlERLP
	6lMIun+StGJ4pqkUqtn5ZU44t2SQzhxWYShjfKY4iRayAZsWY2qiy/Q==
X-Gm-Gg: ASbGncuVm1e6lc3tyA1m8T0AWFcr4QLCOA94yfCClVBR3cLmyCYoLnAdYRiz3xttsiN
	6jXZn5i160NRiw65gNNJ+BM+I0IIs2B9A113/FEkBl44oDIQcsxplOcdGhxdV21itH72in6uV6s
	l9ZHPkJP1ZsErSFYMCCQXZ7NK7GLvCwmAivHTIGCE9jEXq2XdC+3zv65MZGjS4uexPwln6vRLY2
	vdU+U+3/wV94wx+G0GjepoToiwxyUcIGqJDMrlYZfbdmRJeloDrpaEdnojFZR75yEsMKKLaaeL7
	GRHNyhIzmiE=
X-Received: by 2002:a05:6000:1f8d:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-38f33c20f7cmr1320366f8f.21.1739576319199;
        Fri, 14 Feb 2025 15:38:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuwJR95sgolXJa3JZbal6oWOnodlKaw9NVdzdZq6kdIBfuHesYm3UO/VFsI1pO4iTzeaJo2w==
X-Received: by 2002:a05:6000:1f8d:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-38f33c20f7cmr1320351f8f.21.1739576318838;
        Fri, 14 Feb 2025 15:38:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259f7987sm5694927f8f.87.2025.02.14.15.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 15:38:38 -0800 (PST)
Message-ID: <dbb0ceba-4748-47ca-9aae-affd189e2f92@redhat.com>
Date: Sat, 15 Feb 2025 00:38:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix broken SNP support with KVM module built-in
To: Sean Christopherson <seanjc@google.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 thomas.lendacky@amd.com, john.allen@amd.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 will@kernel.org, robin.murphy@arm.com, michael.roth@amd.com,
 dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org,
 kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, vasant.hegde@amd.com,
 Stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev,
 iommu@lists.linux.dev
References: <cover.1739226950.git.ashish.kalra@amd.com>
 <Z6vByjY9t8X901hQ@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z6vByjY9t8X901hQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 22:31, Sean Christopherson wrote:
> On Mon, Feb 10, 2025, Ashish Kalra wrote:
>> Ashish Kalra (1):
>>    x86/sev: Fix broken SNP support with KVM module built-in
>>
>> Sean Christopherson (2):
>>    crypto: ccp: Add external API interface for PSP module initialization
>>    KVM: SVM: Ensure PSP module is initialized if KVM module is built-in
> 
> Unless I've overlooked a dependency, patch 3 (IOMMU vs. RMP) is entirely
> independent of patches 1 and 2 (PSP vs. KVM).  If no one objects, I'll take the
> first two patches through the kvm-x86 tree, and let the tip/iommu maintainers
> sort out the last patch.
I'll queue them myself (yes I still exist...) since I have a largish PR 
from Marc anyway.

Paolo



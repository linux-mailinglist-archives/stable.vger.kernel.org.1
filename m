Return-Path: <stable+bounces-71413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E5962954
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549221C22A2B
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DC187FF6;
	Wed, 28 Aug 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Arny8OmQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09B175D5A
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853243; cv=none; b=eBfxjSQNCn2lqFZDSIiLVWY+YTmPtkDawIDuGPAOArUYnGETHnEAIeMYbXuNsji7pKUiRz5QMceFbZbgv/unnSv4KM+aioiZY+1Ncx9DV1GmzlkyKJj9ynZmRKB3ileaMkMYtLAo6kasZqkSlzqxCQ4PptYHPadkK9D1AE02kVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853243; c=relaxed/simple;
	bh=y02kOSFsk9Ovek97BpXGahQxjqkYkGuGhI+KoympwwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJ+rKpK2TO4x3rqt7lsPK66s/h+YiTzsDJUu51RCzI1b7K89HTc4L+hU73vk3XdiTGr5oMeDfJyRJcysPra+iv51zi8AyJ4fBAMIhyu3tJaZF2H3/LHX11o1DU3lbahfM7cl52gbI4+bv1lm0UtVbL/H2oUjRP4EsSqyEuqCYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Arny8OmQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8695cc91c8so710449066b.3
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724853240; x=1725458040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=At58Bl9125tzbTcmwgBJNqywpV1jLul1XrCUjHhQfkc=;
        b=Arny8OmQqTgcKFptIo9Ba29xY+H+Itunc8YF8lD6K9Ejyxn3jN39SzRj9Dey8Otwbx
         McG7+EH6PW/zth2TwYiIZ60+1s5bTk/GRx88BuLE1iL1kqUoWfKHKvHamzQbkDEwQYC4
         c8F6mBSBW684UMzzyHfRAMJsKx5MHul0znWUsYOdAZ8uK0FWh37sL9CGrdHctowcBbuG
         +kRmaFlhBcHWQPJw2EbWhuviOtFquV4KATM1BdLM7Y8A8IK1TPxAcGoF1LJV0GYezXGY
         zAFmtBpiFu7MYfDf5IaEHfO4W5qNFp0BMmm/VjaDa3B5nErKg6udzLzPEk+Ja8xRF1Ho
         0oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853240; x=1725458040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At58Bl9125tzbTcmwgBJNqywpV1jLul1XrCUjHhQfkc=;
        b=q/G37Cl/kn23JsnzRmtDt5CtmYNAGjfbMjSBhScq/xDo/cHM5W3QixG6ZPz0+4dSu3
         pSLcYFA0QBkrmrrhptngZu59pwQ07SXZWisVK662Z2+UYILe1C9p2XfG6yCa33Pkld1m
         GofWY2dl4Br4v1Zxu6H0QO8inuz6rnMNOlZnIt3F4oGFVOFgtmyx09qDPG1ucF/1rDWn
         fvPC79QyBBGYoqZkofQOuulvBWzmKLEksSa9UyLuP+vXXBULbFfYFCXci/zQcz4gDS4E
         ceTrK2Fy6zY3OcEMZ9C+NGGchyS3HM/L953yjmyBzVmBqQuUB6oLgQf7ZYlWS10nfAiA
         9fBg==
X-Forwarded-Encrypted: i=1; AJvYcCWgX/LTNKz9P6C3gPYgS8wfqerYq9vXe2eevuXmNrhQM0KWKxzAc4W8BiMFUafKGm82MDQZ4fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSPOOPA47cg8oBDz5d2wX1bBMY9O+tmwiSqHQD7SQj+f97k7e
	oSCV/tjuinDEhW+Cl2XfVA6nxJcSJuS4j2557kXWMuQSeVA+Tg4iG1HLNpie+CU=
X-Google-Smtp-Source: AGHT+IFzCP/vvijom3OckXK6Naejo4uIiolIi31SLZ3eeK6wIavfO/bfj51BVIOfiKhEGMHey8Vawg==
X-Received: by 2002:a17:906:f59a:b0:a86:9880:183 with SMTP id a640c23a62f3a-a870a94fe3amr168921366b.10.1724853239725;
        Wed, 28 Aug 2024 06:53:59 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e587843fsm247147766b.153.2024.08.28.06.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:53:59 -0700 (PDT)
Message-ID: <e042faa6-91be-49bb-ae59-e87792756fa4@suse.com>
Date: Wed, 28 Aug 2024 16:53:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, stable@vger.kernel.org
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
 <20240828093505.2359947-3-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240828093505.2359947-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.08.24 г. 12:35 ч., Kirill A. Shutemov wrote:
> Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
> there.
> 
> The function will be extended to adjust TD configuration.

<offtopic>
Since this deals with renaming, I think it will make sense to rename 
tdx_early_init() to tdx_guest_init/tdx_guest_early_init as it becomes 
confusing as to which parts of the TDX pertain to the host and which to 
the guest. Right now we only have the guest portions under 
arch/x86/coco/tdx but when the kvm/vmx stuff land things will become 
somewhat messy..
</offtopic>


<snip>


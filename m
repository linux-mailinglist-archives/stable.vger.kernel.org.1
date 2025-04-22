Return-Path: <stable+bounces-135135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813CA96DFA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E01889E0A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0A284B3A;
	Tue, 22 Apr 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdzaS3FC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7427D789
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330970; cv=none; b=tdAdT+FMCS0ASgf9QeUAYwyEtwKSb+w+51lhq6yvGS6S73GGhSJ1RT4gPLs6OxcxSTuiF1aVEu0eKE2mH2FgvRGeRFiaBpo+Qzo6Yw7fBjWNZt7QRJz4EZsii/B4K6Cx62IKZ3QmY+/evaYUrTZX5xTbwsRAsbE1qJMGavaQmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330970; c=relaxed/simple;
	bh=4WUL+kRVdXJ4YqP3HWnBAaAj2sgwvzUpdes1f8Ws2HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHmu+An9ld3BaZw/h+JX1K5Hq1L1GBpsj5XYPjrcaT2i+lPBKnfeUklSRhRNUcdTM2YSgj6sGFzXX+IMHsZ4QQqtLjD4PLVUS2W0I1i9I+3gQnlLVNk+FZquLAIB9HqYBuIS0bK1m3uXfeMMnDn8tndiSJeqyEq69gUdWWaSSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdzaS3FC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso25107175e9.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745330966; x=1745935766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etzYKPdfFIVAafOh3+s0YxsgTDS1jvvGazVnTpn/4ZE=;
        b=YdzaS3FCEI75gUzcFq0ZR/CvKwjx+7LxlMwUyeZH7WtmKdAPCUam9nAspSIJw8AS59
         3XGeAs3luRIkjeDoKNG5J9L5Ewlt/7y8PJk3uclWV0SPuERI9frxconG3GkIARcThGr6
         Qbf2J6eC7E/65UA/49BOLlZNXyKFOXn0Tbc7jZ7Te2sXFyvaAivdOtq1pQ6vDK3MBvbj
         HTElDg7g5weo1g+7d0lNIGK7HDRT5zys21TxvbnsjnOwmpxoZRIA+nUmMcp518B7BQVz
         mmxD/x+REBksY8O0/LzdaZY+a8ID0Kh/BXypVgdypvq58tlgz9Hpt+bvWhgs/DEG2KEc
         xQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330966; x=1745935766;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etzYKPdfFIVAafOh3+s0YxsgTDS1jvvGazVnTpn/4ZE=;
        b=HUIQr5YBHq8plHbM6R239I2aegctxY4CNzIQOPA1Mda9jNBs6wY/gquYn5AJ5nmwZd
         pdpfdhFERpIw/UFO2UUQKhuo1866DHRUk2kceYfWhgnEoygJ8OJ6h2hWCzzEse+vJL0f
         9xodMhf1urN5Jighdnr7SvcQ6TyNtgkZAlhOsBbtmIX0I3ZSBrGYCe8lxbx1PY4rbwzd
         9R52Elp8hxRY7SsIwe+P2pXfhQHH7vUg+G+3TUrbtDVp9iliQPqsmzgGC1GagjvW/paN
         b9XuajtHwDxNOJpSeLxUiIl0WN2VRKBxT5aCEVnuhavrXsF/v2ignWxxTtfpas6FwQlO
         R9CA==
X-Forwarded-Encrypted: i=1; AJvYcCXKjaLB1GC4fXZJrGjoMeuFLqAgbTDzZtSnuBN+0p2gyGfGEYyCggBCPJKkHWgEjMSr4D7QKQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywomyx4UmkRhkQVGPohJw+11uOwJi0539IBZom+iPB3/7n11lb3
	wiqOurwHGLZsOtKJ6IZJdjjeDU0Cnt8Lfu4R8TOLTizm84dSmehcoHP1bwZaJqSyaIlaDRH80Kr
	x
X-Gm-Gg: ASbGncuK5zrIXPI9Cax46Hn91orpEVNUaESp58g2ib5J4+GJZKEzZDZD+952kTDGjE7
	0dvVrGLMhy6d0Yeq1/f396dUX6l8fZadTcu1x+WCWWEJyizK03J3Oq6ZhOsIicfeJK6lZEi7gro
	SQ7o27/eOcfpWElmlLcyC+BFLYp8U6pOzT9mnFnQpEtkA31MTeuSD09TUXkvZQOiTYLdXUZsZTx
	vp+SULNMAyscAHKks92mnR086QvVJ38/ze/bpaygXQt9zFIfW4TUhB5d/qfPCGscSkGeDaCsCJm
	4Dy6PPWGqPHHV51dM4M+7x7KybWbrWoaU2bnAuP+ujf/
X-Google-Smtp-Source: AGHT+IGbEm6WLpkN1s6bPsy2k4y3Qs9ExG7sHa0JjGc3i8w4ykBTzS6UnnOmFNbB9lH6qijzORtc4A==
X-Received: by 2002:a05:600c:1c12:b0:43d:7588:66a5 with SMTP id 5b1f17b1804b1-4406ac21bbdmr166257855e9.31.1745330965876;
        Tue, 22 Apr 2025 07:09:25 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5aa100sm178139995e9.7.2025.04.22.07.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 07:09:25 -0700 (PDT)
Message-ID: <99902694-65b0-4c0b-bc71-b082efb15625@suse.com>
Date: Tue, 22 Apr 2025 17:09:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Restrict devmem for confidential VMs
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, Naveen N Rao <naveen@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.04.25 г. 22:11 ч., Dan Williams wrote:
> Changes since v2 [1]:
> * Drop the new x86_platform_op and just use
>    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) directly where needed
>    (Naveen)
> * Make the restriction identical to lockdown and stop playing games with
>    devmem_is_allowed()
> * Ensure that CONFIG_IO_STRICT_DEVMEM is enabled to avoid conflicting
>    mappings for userspace mappings of PCI MMIO.
> 
> The original response to Nikolay's report of an SEPT violation triggered
> by /dev/mem access to private memory was "let's just turn off /dev/mem".
> 
> After some machinations of x86_platform_ops to block a subset of
> problematic access, spelunking the history of devmem_is_allowed()
> returning "2" to enable some compatibility benefits while blocking
> access, and discovering that userspace depends buggy kernel behavior for
> mmap(2) of the first 1MB of memory on x86, the proposal has circled back
> to "disable /dev/mem".
> 
> Require both STRICT_DEVMEM and IO_STRICT_DEVMEM for x86 confidential
> guests to close /dev/mem hole while still allowing for userspace
> mapping of PCI MMIO as long as the kernel and userspace are not mapping
> the range at the same time.
> 
> The range_is_allowed() cleanup is not strictly necessary, but might as
> well close a 17 year-old "TODO".
> 
> ---
> 
> Dan Williams (2):
>        x86/devmem: Remove duplicate range_is_allowed() definition
>        x86/devmem: Drop /dev/mem access for confidential guests
> 
> 
>   arch/x86/Kconfig          |    4 ++++
>   arch/x86/mm/pat/memtype.c |   31 ++++---------------------------
>   drivers/char/mem.c        |   27 +++++++++------------------
>   include/linux/io.h        |   21 +++++++++++++++++++++
>   4 files changed, 38 insertions(+), 45 deletions(-)
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


Return-Path: <stable+bounces-132427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD4A87E32
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038AA175A90
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEF27EC70;
	Mon, 14 Apr 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XmCvxL5y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668227E1C1
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628187; cv=none; b=Xw1PN95vdjQo82kuXd7a7iBD+LZ+gvBqKDQG7o46Dwc4sMeirpgyfpKOgq1k2h82/5dDFh/junEqT3jmkFRUTEh8sPyVwcp+6+SUtrL63L5JvGqYA6fcZwWV/EevLqS7SLm6MPuiVR/QjDZKV8Zwwm85jwaoLU6KRB5M5YNa/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628187; c=relaxed/simple;
	bh=YJKAmLU8sEcOzRICq4h2JLOCaTHgSMdUialUxaQrbMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiamtKUwxjkCRJtKfiuxYTFEPF/gbr2ELyb4sW6YA9SUbkLMvqwAhAGI7eUs3mp26dIQRu0kz69xsl8GrTQmpSRY43LusFnuccj2pSwRYzT/8wQnITNdHdq9BLZVn6Axb6J8VFZWyP1xz1TMSRsyk2TgjigEPsG3/zi7OjO1k8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XmCvxL5y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so686758566b.2
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744628183; x=1745232983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sDnDfLpXfE7PWrKyWCHICC9gvn0J/O7cW+D86gMjszQ=;
        b=XmCvxL5yI7XkX8kyxEigVPkoynp4riEAD88pbA9sL5CYf/aGSlU1pUXHWnClY8rUpU
         0cfdP2HWIehZsh5e3MIssXFlOpr37zS/BjPnfvvpG3b7wWgA3McvA3L7hs44RLFGSASr
         ATKosKe7Oo+XIAIshBRMeOH36VV8O7Mowz4t7l8DAbdFnj6d6f07x2Z+xBnrVNFexX7z
         Aki6GznmDC2SoZsidhRlltXcqVq2CSlwecnAqrIqh5NT+u5ErAqKR+dTVzSa+8CPE5pv
         afYItPptIwo0DKob8zpfr9qtPxATUeMeBUlNKnvpNUolRHGNRmaaaDafI3jogPqeeFD9
         o5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628183; x=1745232983;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDnDfLpXfE7PWrKyWCHICC9gvn0J/O7cW+D86gMjszQ=;
        b=dYQoy5GhhlU46IK3oLtT2P3gsW77wy8gJ2DBAhlM2b2EdEcuZIv6OQxCt9T/Zu3lXJ
         zZygXywC6TOQ4Id3b7ARP6x5jOKavoHzwXGHCWwEslSUEsXTOaAY7barg9GAbbY/c1KR
         k0qBLddhovsigGrKYdOGtWL4UQrTUT+V4GvcD2TA9PaA5bTegVytk2N7koeEw5Np7dJR
         2gRf3j8XEYNFjMeA11xHgqrpyNMeYQ0VXd8fElpP88xvlu5ji2KG0k+cDL4jFQafRyRJ
         TWvEZBdIlVuGYXfzZFHQQeE2m+IAV7FMYbDYS+Jp/LR0K2nqHgYhGz/B+a+ZAKQNXHsB
         iONA==
X-Forwarded-Encrypted: i=1; AJvYcCWnry9CIfV3O65LcYdNJLb5EgfijfiE5Z6vAQHM7qNldxUFklLTp9WD+DJmRd878k6ShupGL7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfpJ9tqvfNReCbpAJmeCBIMqKMyerXYFAmlIxH/46iQRouhS/
	WtNJBCDpH8lb9d+lUt5xBGU8qMboNp3pFVnfXH1Mn/j9HIN5XKaV6AlvkQPEdHs=
X-Gm-Gg: ASbGncuOW17bSrdb8jRc7Hue7UulsP5GEju24BJUz9T4WA93WnthGdkCvdfUQ72FLyS
	nm1Mgsca2T3SozzS+yB+UoB87qMoOEQESq4bw2XxckB4acZ+kYKE0Jd36GE6MsTOOxPvCuMSS0j
	pzK9GIrTfMKflq0WeHBDnUVRUzgomwoP5H1W++D5K7IbZCx+NYqXEWF+xF2cMAu5/qT/zC8fB7r
	uVpLlhrMM97mWa/Nhtx6IfquDGXHaHfuSLLRHIMLe2fudWes745OE2s6KuhBXT8izHiyM0KnXYT
	SxIhGem0mqY/ZZ0HkbsU/dcrx3ueSr3Cv/zhNC/XwD8veg==
X-Google-Smtp-Source: AGHT+IHBgv4chZU26xpAAuoQ+CvN0c7pnhZNwHGP/bnsThoMPPSqzWnD4rBK5YkZvT0T/+/zupdAuQ==
X-Received: by 2002:a17:907:7ea5:b0:abf:6aa4:924c with SMTP id a640c23a62f3a-acad348dd92mr986154866b.17.1744628182845;
        Mon, 14 Apr 2025 03:56:22 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb42casm874100266b.88.2025.04.14.03.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 03:56:22 -0700 (PDT)
Message-ID: <0df1ea92-4386-4237-bf98-02503a5829ba@suse.com>
Date: Mon, 14 Apr 2025 13:56:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Restrict devmem for confidential VMs
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Kees Cook <keescook@chromium.org>,
 stable@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
References: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.25 г. 4:22 ч., Dan Williams wrote:
> Changes since v1 [1]:
> * Fix the fact that devmem_is_allowed() == 2 does not prevent
>    mmap access (Kees)
> * Rather than teach devmem_is_allowed() == 2 to map zero pages in the
>    mmap case, just fail (Nikolay)
> 
> [1]: http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.com.notmuch
> 
> ---
> The story starts with Nikolay reporting an SEPT violation due to
> mismatched encrypted/non-encrypted mappings of the BIOS data space [2].
> 
> An initial suggestion to just make sure that the BIOS data space is
> mapped consistently [3] ran into another issue that TDX and SEV-SNP
> disagree about when that space can be mapped as encrypted.
> 
> Then, in response to a partial patch to allow SEV-SNP to block BIOS data
> space for other reasons [4], Dave asked why not just give up on /dev/mem
> access entirely in the confidential VM case [5].
> 
> Enter this series to:
> 
> 1/ Close a subtle hole whereby /dev/mem that is supposed return zeros in
>     lieu of access only enforces that for read()/write()
> 
> 2/ Use that new closed hole to reliably disable all /dev/mem access for
>     confidential x86 VMs
> 
> [2]: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com
> [3]: http://lore.kernel.org/174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com
> [4]: http://lore.kernel.org/20250403120228.2344377-1-naveen@kernel.org
> [5]: http://lore.kernel.org/fd683daa-d953-48ca-8c5d-6f4688ad442c@intel.com
> ---
> 
> Dan Williams (3):
>        x86/devmem: Remove duplicate range_is_allowed() definition
>        devmem: Block mmap access when read/write access is restricted
>        x86/devmem: Restrict /dev/mem access for potentially unaccepted memory by default
> 
> 
>   arch/x86/Kconfig                |    2 ++
>   arch/x86/include/asm/x86_init.h |    2 ++
>   arch/x86/kernel/x86_init.c      |    6 ++++++
>   arch/x86/mm/init.c              |   23 +++++++++++++++++------
>   arch/x86/mm/pat/memtype.c       |   31 ++++---------------------------
>   drivers/char/mem.c              |   18 ------------------
>   include/linux/io.h              |   26 ++++++++++++++++++++++++++
>   7 files changed, 57 insertions(+), 51 deletions(-)
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>



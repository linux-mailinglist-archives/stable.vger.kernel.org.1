Return-Path: <stable+bounces-139536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A1AA80C4
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3F67A4D53
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293C22C35C;
	Sat,  3 May 2025 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBG+Sy8A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7E54670;
	Sat,  3 May 2025 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746277438; cv=none; b=hrGd/TyAlurEBD5ky4kFsbTqodStJudqHAHTI7ueKy4AsnRPQo2ufrDMpvegaxpEkxTYrZJuAWPfiWSpSn0+JR3JqZLR95n0dht845Cb6EtTJQg7w397y1NZUUgsV1QC0AngJpgRDtHYy4nAOXDCfa75695b04+R4KA9l0MzTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746277438; c=relaxed/simple;
	bh=bc1H7G7SKC9hb+Zvw3wkuYkxicUKo7oDVTVJFB266CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1vX1wBKqvkkCdGGgWHlz1fZ/Aez/sja0dM8nfBORAB+tyh2M0wJybMJ1VwxkPc/MBVkJDn5SbuLF05ig7mQFxxot8NQrTz5L9sZamLJ9ZeaVA+zJMUti0WJdrrj75K6imcCx+xs03mTk6w/fxVFpFleoGlpiYH3Vff9hroofjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBG+Sy8A; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33e5013aso32124735ad.0;
        Sat, 03 May 2025 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746277436; x=1746882236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IIrDRchZvQGY9mZIZCkBaIRsdI4f6csmhNYM7f8RYQ8=;
        b=FBG+Sy8AAj4b9TP1fFKI/m6Z4q1aGH/OQDgwAJjihd4L+9N6mW9azqKc78aqPhC3DS
         JXF2v7CzsKmviz9QtXuKOgIDAncuAN9NACXkSm2jhFEQP7lHZHMWWIA8yrToWhS6zMrs
         vPdFwM1/4/6OrXhpuuBnHqkA7TqncKItz5IXORs44cvOh9Q/qNXp9qcbvWDxU8Z/+3GJ
         XQC06Rgy/RGE0DGGmLS99snuh3qapcMriAdeXQXew2zxF5apCaNTp7C7k7DRxZcCtSYG
         IpLD+IAe16LBgFY0Tjb4OZ8kb6pg6I5bPiefyv9qwne9cgVjHhku0uQ7g1NBgkiE1lVU
         NoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746277436; x=1746882236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIrDRchZvQGY9mZIZCkBaIRsdI4f6csmhNYM7f8RYQ8=;
        b=pzT5DfHaf+pdXNNA+IeKWKLWyddUnwH0aomjLz/RA8TJZmKsWGivsle4Uc6P+hqz2z
         Uy/BHT3MJT+FqsfHBFtAiSR+N2h4JtFbJ32IlGsz7dvIf+rde5mkiMOknZD3xTk/9Iwx
         7DVW99TxhmZKdCRnOThOkT4VzRCxLbu12PKa66lJQV+k38/ZgeL3CSWA89KDUXxwCADD
         6eIx8U+82IynMhGvYNWAyxo6RC2JO0YbsCq3yvK6w85ZWAWt1P++j3kqjQ7RMFMgupY/
         zpMfamR0/BFKYgQMkZHmiZdWjxPDFN6CV4i1Bq/j2vIBQIzVuLzjPLn6Q/LmCj9vm1cj
         0Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCVwYtMEV1Q0XkSh/ep/yPLxK/nbQZIStO4eEkqLxkNiXYhO2XH/glNb++C3P7rD9rEpqztZONMJ@vger.kernel.org, AJvYcCXu1vIXHB1ZZ34U9mTvurCd7XYyt37vDuFf4ak9oDABifB8dzvQUcN8PUeHZUsXluwUxozRP0IYwpUqP+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnTk0eQRLcC47fiOOuH5Be79Gk7BY1CbE/aAnLDaHPEh5wq+M
	8ZgCrxAHMWxdI5v0saXmtiAkWtwiveKtwr1Nk3MF8JD0GWG3kqrCcRdXww==
X-Gm-Gg: ASbGncvF8iQQG6A+JoNXS0MIA94W1XD1+6R5JwhYmVQ+EyUfckCduecx7Y/qqtpgG6k
	UoqIAVHV1LdVgrANktEy8FYU/eGMuI4f08KOFpX6q2dck2yLKN+y0o/OZl8JIDHV9fr4oF0eArQ
	PQvSYcuq66/ZlR3Cr/+FXItvQ1zVxDNCq9d60Di/pRnyNsbKZEuj9U9FKgBW2R0137h0u101yfU
	nvI1prbH1MmKiyZFRju4BnvqkOIkTU11HXAQqUsz7TyxQmAlsmI8XB/N3p4lbmRRpBXXORNKnYF
	KSGrAOVbY3YbBaE8h7sqCKlWOoaNF38ac2LoVQupQUOJJrIDz3f3xSwyIlUQRLi1lZuEgPJSfOI
	tQjqO6FFvVIg6iA==
X-Google-Smtp-Source: AGHT+IG3vnG8591JtW6TBou0vmfxH/iOyzUBh4p2XcUUz9bCtHb2wyRPKzrzPwfhJt04kYeTrBgVjQ==
X-Received: by 2002:a17:903:1904:b0:226:4764:1963 with SMTP id d9443c01a7336-22e1ec39ed5mr12653925ad.51.1746277435868;
        Sat, 03 May 2025 06:03:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd4fsm23470175ad.146.2025.05.03.06.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 06:03:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f978ec9a-b103-40af-b116-6a9238197110@roeck-us.net>
Date: Sat, 3 May 2025 06:03:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250501080849.930068482@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/25 01:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 May 2025 08:08:16 +0000.
> Anything received after that time might be too late.
> 

Building loongarch:defconfig ... failed
--------------
Error log:
arch/loongarch/mm/hugetlbpage.c: In function 'huge_pte_offset':
arch/loongarch/mm/hugetlbpage.c:50:25: error: implicit declaration of function 'pmdp_get'; did you mean 'ptep_get'? [-Werror=implicit-function-declaration]
    50 |         return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
       |                         ^~~~~~~~
       |                         ptep_get
arch/loongarch/mm/hugetlbpage.c:50:25: error: incompatible type for argument 1 of 'pmd_none'
    50 |         return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
       |                         ^~~~~~~~~~~~~
       |                         |
       |                         int
In file included from arch/loongarch/include/asm/uaccess.h:17,
                  from include/linux/uaccess.h:11,
                  from include/linux/sched/task.h:11,
                  from include/linux/sched/signal.h:9,
                  from include/linux/rcuwait.h:6,
                  from include/linux/percpu-rwsem.h:7,
                  from include/linux/fs.h:33,
                  from arch/loongarch/mm/hugetlbpage.c:6:
arch/loongarch/include/asm/pgtable.h:198:34: note: expected 'pmd_t' but argument is of type 'int'
   198 | static inline int pmd_none(pmd_t pmd)
       |                            ~~~~~~^~~
arch/loongarch/mm/hugetlbpage.c:51:1: error: control reaches end of non-void function [-Werror=return-type]

Guenter



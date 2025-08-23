Return-Path: <stable+bounces-172530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A3B32635
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9815A7D19
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64313635C;
	Sat, 23 Aug 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5t/DIxX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7E45C0B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755912753; cv=none; b=mWo7U5fdcwzV0z4yi0eY5o4sW5dbsh66uzHqO639+bVGmroD4QvmEsavL2KRUXYhk0RYe3kuvJETB6RycOfO6j511awdIlMJ+Qfgx+elb8v//vxJt20NGJPPNc/czO8lx7iP5oUkQQz7dnaHOsW0i+u+NAyzazhrIfH9ax5NPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755912753; c=relaxed/simple;
	bh=6fnIg8orOV6OHmdttshaPLan08wkKmQrC/GVret6SBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OufyefkjZqXvZDfsSE7wPSiij6Uq73gdR9K3ewmIx/XOa0AlRg2Ls0AmppmO7k2u+Zw5rrbvYNtFYE1u8JjIj4WlGEdXduf3gPVQ5IvayIHXd9DEHzv2c8RYKzjN97dMwMbyobiZLtggQsOc3E62CGvyfEpr60slvsYZPgYPxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5t/DIxX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c38da68ddso372089a12.2
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755912750; x=1756517550; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJZrbfzvth3UC+HZU+WUnSg75LyO0CB51/ryaxjmXYY=;
        b=O5t/DIxX1AbOCVKuEL+odv0qw2MtaLAb37lTzuNv4ZHWJtwZ3yGtFCWKQfkDMImM9/
         tJ5rucMAeeeMm3E4bQ0M51qjdfQS/pEHvGOLPeJYDMf4PtZxCSQ8Gdv0us6JKWW+nOy8
         a3mvW9VLqf7ocysQzlt03LuLVGTEat3Q72v5JojChFWIe2OfPII4GpQjjqxxJE2Gljdh
         9szACGEbifx7rmEfHBAOsjyB1RJNI34qivDZQz25ChBj7Ww++k4HV94KsF2kPSI6Ms5e
         HIJlFufHlfgkRBIYvBdaOPYyIQcJeL5IlFwKN8QVzT9mCyrAoeFWJ1bqjmNO1AmwdzsF
         SxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755912750; x=1756517550;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJZrbfzvth3UC+HZU+WUnSg75LyO0CB51/ryaxjmXYY=;
        b=qY6mR45UpoqsaFxXTQCgHfKrNClQM5XGSJNTj5v5K5eWu65EIT4wKDXLJBZHqVlKKa
         9nVqwRLaHCM+T4YZC5cDnb2E6c3BszadVevaq+Sw8KxsT+gPqfw7Djw25+OXW9D72Gzz
         etBY4EvUrzEqILQJivrMZystTELp4eHCOuK1iW0DOlJimS2VFg20uydvneAEwYwtMoJL
         Diq5+/WeDJMk6CP7N5gc7m4nM9mGqBRp4OG73CH007CqoTMBbTD0pa38Y7PUaSjBcpfo
         ZEEWDF+jaba0HyvDYT2ROLDml2E6aNCRMn0D7aEbYiDGWEPXclkHL8VNmhO7toXv5Qm2
         Ho9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV8oB1VLhvuxhkRsSNAzIViCQt3sYAqbW8rt1knxsNIhhKffhWRFyDzjp/PWpU7R8q2SbM0KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpb/vQ6TQfA5skxp0/HER641b8DsAQU2ggGw/2015j8pfKwwec
	MUc7MPTF+RKNcUOkPoYjtpZjSOMDMhSbZ1o9w4n0cy6eZLdV1I7RqS48
X-Gm-Gg: ASbGncv+gWv2enQfvMAQ+N7Fqm1trjY/nI9IfliEXKf08JF/oAJzMZyViF4nvsK2nF7
	5BnY4e/HLoPwDmImEbvGRTe82SloixP3FWobV4fSvWJgqvPYtPBinxteA9LTtr6veHSLPPAzzqp
	RNpuAz7X8cMDdKAsG/SltHyCrARlwN49zV9pgk8MwMHLQHQNAKpfHri2snfqycgrsSVOVSH3hxj
	Zw5agzmjPfOHvxgpPYcIb06A5XXzGYaib3JHHEl0ZyvQ4paFiHSgaKAjHHXh090kFwl++pnzLGU
	/Q9XgQYpfQE3k9tNFZ1N8zs8m/2BWmb40VeZtctcvcCUYIV3v5GjcDFIzRFz+78eS5qXR6LThAm
	Oa/Bhx+TJWkGv8YNXu7U9zXkXRgSg/7+CeMYr
X-Google-Smtp-Source: AGHT+IFrUheQ0C0VLXzuSQMa42TWZMqpsBCr2Jh2MxTjESBmMtPLtQ5Hp5XdppMyJWgBmT5t2kHZMg==
X-Received: by 2002:a05:6402:a0c5:b0:618:1706:d48b with SMTP id 4fb4d7f45d1cf-61c1b714110mr3683563a12.20.1755912750201;
        Fri, 22 Aug 2025 18:32:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c312c4cdesm770186a12.23.2025.08.22.18.32.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Aug 2025 18:32:29 -0700 (PDT)
Date: Sat, 23 Aug 2025 01:32:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <20250823013228.5gybt5tuaygyunze@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <a68e4e65-883a-4625-bebf-da4569ccda7c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68e4e65-883a-4625-bebf-da4569ccda7c@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 22, 2025 at 01:04:51PM +0530, Dev Jain wrote:
>
>On 22/08/25 12:03 pm, Wei Yang wrote:
>> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
>> mmu_notifier_test_young(), but we should pass the address need to test.
>> In xxx_scan_pmd(), the actual iteration address is "_address" not
>> "address". We seem to misuse the variable on the very beginning.
>> 
>> Change it to the right one.
>> 
>> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> CC: <stable@vger.kernel.org>
>> 
>> ---
>> The original commit 8ee53820edfd is at 2011.
>> Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
>> extract khugepaged from mm/huge_memory.c") in 2022.
>> ---
>>   mm/khugepaged.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 24e18a7f8a93..b000942250d1 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>               if (cc->is_khugepaged &&
>>                   (pte_young(pteval) || folio_test_young(folio) ||
>>                    folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
>> -                                                                  address)))
>> +                                                                  _address)))
>>                       referenced++;
>>       }
>>       if (!writable) {
>
>Wow, I have gone through this code so many times and never noticed this.
>

Yeah, also I am surprised when noticing it.


-- 
Wei Yang
Help you, Help me


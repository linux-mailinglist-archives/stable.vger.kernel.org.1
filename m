Return-Path: <stable+bounces-132907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68777A914CE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A823BF4F3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D51DDA0C;
	Thu, 17 Apr 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVu7Qa0l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E2153CD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873945; cv=none; b=onRk6cGJrzjb7l8m2LHG/5Bmx2NH6E9TThse6pb6miqi9aSJ9QSgpPWpNXtwPJbf4lpIz0sg+0hiCwOSfT2JymUiY7MDgbzcRof17tQyRm84n/SiO+XFMVcHquN1Z2gYcTHOBOkM1ZqL6Egcijsga7QuaGHZVf2N8P9cu7vElnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873945; c=relaxed/simple;
	bh=tY/DIk2rzj7OpRJyN1f+M/77PeLyklmL5pXwGb0RQiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ptmois5adL3VFp8V8ja9ODXAbqBEhXR7QSW5uwhF+k7Q/1S1rMiphRsv40VRmOfDtWmqJIUaD7WJuGXj6Mmg0ty/1cXQEtygltrKP96rZB4/H41b9X08/XSdGj13RH9pVygxlnkJ3Z/lJrwyGn50Vk9AicjEXmNlHhDoh6RxnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVu7Qa0l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744873942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RS87iO4jmfjt13fRTdwJjBQzE4yIkbYOnPPbfZ4bwRA=;
	b=cVu7Qa0l1AAehz0y6kvx77YTeyoE3phGF7tjK0galdkG3qZ6CJ6u4a1aIFCSUSn/v5/KPb
	F3QD5WreUHxi5PXIYcKGY+kLgZbK36cndNMudEwEjcFHh32FOtICY1JBBMW10jZ7LEQ+Hx
	DRLj78FxAXBmgYN97gEq/PJdVUXeokY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-zqVCXEToOaqIlG0DJsAzRw-1; Thu, 17 Apr 2025 03:12:21 -0400
X-MC-Unique: zqVCXEToOaqIlG0DJsAzRw-1
X-Mimecast-MFC-AGG-ID: zqVCXEToOaqIlG0DJsAzRw_1744873940
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso2196175e9.3
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 00:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873940; x=1745478740;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RS87iO4jmfjt13fRTdwJjBQzE4yIkbYOnPPbfZ4bwRA=;
        b=Yy21mr/fO2GYBcmGVIBiYPYH6jRubEwndXBVBE6j8ad2paOGWUrmOllFSYGsqdxpYT
         F9hfMr+1imzKxrFo06ObJjxx/MzCnBs5tzrcVoW4XKcpWSey1jBNipQ2/nlxRDb0TmK2
         CX3nY6MM7uXO/rfx4FtL9DS+hZ3JO9HlUOI/8zsMCgPqpfWnyue8MoCmeKcercS5rc5T
         fqURsymSHB0dPUd/53n01zs68vrL5KHMw/6kckLJm8xetTlXNSQpFvLM+8QcrLcQZmLn
         MHeacD2ctAuSAHZYvUGXTC04Ln38hwOhix8RYE47jIkBZzXJwtEbxdVfO3sy8Ez5QwKb
         +FeA==
X-Forwarded-Encrypted: i=1; AJvYcCVeYisrJGzB0jeZJqrIWRLrmYIMP0wpiP+mn5reP+CVKO/piN1opYYw1v9Y6wkj7e36x54FptQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqALZ9g12tvhC74F70MVe65pWSYtr6J/Psvluk75rDCYONbMZ
	WUbZt8SRQGdoNQOAO2YLqiX6JCuNla9+e47kybiZi0yPCCkj/NQnAJsK4TGxV0Ylp9K0UfBigqM
	A0eLHXERObjPkWyK94AgVnSE9ZSjssTFpP7uU/+RPDK090pfIzxHKnQ==
X-Gm-Gg: ASbGncsMJsoYkbPvgJ54PO6qvNLi8OxOt9ukIF94GDHF9AQeYhSTpwxBAhmIJbbNf8r
	sl7DP+k5erWsfN/9eQBydUSslsYrQW5JRRdxRsuPxywhEPc0SoX/wjcXw3ITBty0BN7Z6D10RlY
	3g/GgK1iLMRmpokctploYB5Ty6OCpkP3PoQpREbLjRpK0OruGbhJlD4Pdo/FsOPbQ5xQxaHCRqp
	T/FXB4QgJoBr0KMe7lTuACazVFhDOwlFZ/BR6TWhuGfAYH7old8PjquZmHgmH6UKSBlgPmZsOVk
	AnC0wprxc0F9LRda+bTxMVrOlk+3Q1r8vh4hDqZm//siaq9pILtapAusV5IhW6tCDxSOHjSQipC
	7k5b3jOR2TsRk0K0j+A0Te84LM36JeVGD+R2LHyU=
X-Received: by 2002:a5d:64ef:0:b0:39c:30d8:f104 with SMTP id ffacd0b85a97d-39ee5b132f7mr3851744f8f.6.1744873940046;
        Thu, 17 Apr 2025 00:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkzP25I+9dronHGl5AxgAxlFz8k24329bxCBjViqDkpRbnKh4svhpFKfbn/WpzKU6KDTAyFA==
X-Received: by 2002:a5d:64ef:0:b0:39c:30d8:f104 with SMTP id ffacd0b85a97d-39ee5b132f7mr3851719f8f.6.1744873939699;
        Thu, 17 Apr 2025 00:12:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2700:abf9:4eac:588c:adab? (p200300cbc7062700abf94eac588cadab.dip0.t-ipconnect.de. [2003:cb:c706:2700:abf9:4eac:588c:adab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963f62sm18853738f8f.5.2025.04.17.00.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:12:19 -0700 (PDT)
Message-ID: <1eb021d5-3472-4a47-8a3f-d5bae83b8391@redhat.com>
Date: Thu, 17 Apr 2025 09:12:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1] mm: Fix is_zero_page() usage in
 try_grab_page()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Milan Broz
 <gmazyland@gmail.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Sasha Levin <sashal@kernel.org>
References: <20250416202441.3911142-1-alex.williamson@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250416202441.3911142-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.25 22:24, Alex Williamson wrote:
> The backport of upstream commit c8070b787519 ("mm: Don't pin ZERO_PAGE
> in pin_user_pages()") into v6.1.130 noted below in Fixes does not
> account for commit 0f0892356fa1 ("mm: allow multiple error returns in
> try_grab_page()"), which changed the return value of try_grab_page()
> from bool to int.  Therefore returning 0, success in the upstream
> version, becomes an error here.  Fix the return value.
> 
> Fixes: 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")
> Link: https://lore.kernel.org/all/Z_6uhLQjJ7SSzI13@eldamar.lan
> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> Reported-by: Milan Broz <gmazyland@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index b1daaa9d89aa..76a2b0943e2d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -232,7 +232,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   		 * and it is used in a *lot* of places.
>   		 */
>   		if (is_zero_page(page))
> -			return 0;
> +			return true;
>   
>   		/*
>   		 * Similar to try_grab_folio(): be sure to *also*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



Return-Path: <stable+bounces-151512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E51ACECBD
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF53189AD72
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600B2063FD;
	Thu,  5 Jun 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PINwoJIw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493F1F3BAC
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115415; cv=none; b=Lj6iJQIOs8mlCMJMxcyPBlUtT+Ws7C2f2KmljqRHU61ewq9rKRoLNFxCNtjfW9174JJi8L0ReYv99x+ekX0fBbCqC1slprpsD+g5cLrwE78QemCVFR4OTIA2ElD2ZTID7I+j4J5KqQMLOnefK57b/wPOwybjQX0qeG3F2byOxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115415; c=relaxed/simple;
	bh=IGTYhqTEXbrSAlKpdioh062p42LbNyky8/PSpXXUeWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXSFlXApI/RRKdjVrALKlLVZAVnZCQfKYuXO7o0/WGEnrvWCWKbdKTFcovJe2puoqrS7BSA/BOkkwTPr0C18bkqXTJ3OSM4MvaiLlCzA8X3STi+TJWgZvKANDeWNfH7wvoxQ3d51uAE3ViXvotAVQKC52kUnRt24ErBxkWJElSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PINwoJIw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so606662f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749115412; x=1749720212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PMdKYMhvbUkWOEuNMJirqV05bbB8zByRdxXQQcaUe+k=;
        b=PINwoJIwB2Q65iVkHqqSCXLSECyeSZDTQl0L/NmHv3Qixtpx/20WNHRvk9cVNhQBe1
         YZ3uQDL0yoUkFQYdmZQdrZxVhN4n2jJkoXhp/z+df+mmoWZ5uSVPEc50xd6zi1n6VjMw
         3vgmpgwdoc4f52Z9u6tHw/tldc1u/gFuN664sePpvywTeCtTOh2o6020jsihDjhlqMwD
         Tc/35RKPJaKJh4Nx0oTfnTo9waUotZi668RINnoFiWE2eZiJ2GDD60zoNRlSJrCGI00T
         +8G1X3A+HOICi3st72+bPPiGCZcv3rjPrU7znAosl0hvSOAaH8dEITEkAHPlWhr9pmEK
         Kn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115412; x=1749720212;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMdKYMhvbUkWOEuNMJirqV05bbB8zByRdxXQQcaUe+k=;
        b=dD9jtpKxPQdSejiwxbZURb2UvhGobpbE+O2UZUFhVR5hYLiAT0ftmHMHvK4Jkudaea
         Vk5Nwy8fBrkkfH3VhWmBynktikNnpRFTJrdBh61W/4izurTpmnzW49PDB3Y5YIEHM2d2
         yOEK1c2Q5tqlnI3JF5giaAyqXF2zc3jbyKjuLB3IdOv9ngL7S65YkEb8T7tQIZmcR98m
         IKSstRzyxS6aOACLuCyben3jjvP6ktZEHYMlXdzJDIsT4+iR9VKbrKmzXVVMsMd1BNN8
         PVP1nxcMNmr0lhTyupQOmjH6UjMlIDDNRt+bi8gAUT0+H4luUjJShglGeB9xZW0DVZku
         Kilg==
X-Forwarded-Encrypted: i=1; AJvYcCV/xaE+/gHMVXTYHysHxpkUqgJNXaSedRwP84o7HQwuUsXlqLmdPvEvRS0FjRjE5NlfuQgpTac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbSctzayvVTDE7If4/TOpPD1PyvgP4jVrqRgPujbjaHdYfNQR
	jB+8+IcGgCwVmUNkSDo9uaztnOLei+WZx5XKmuU/gwyTtJNBdCO4Ia9rZ6dnyhyagUA=
X-Gm-Gg: ASbGnct94DHmUn7daW7FO3MRDFIsOhMTR7YFeODhx/dS9w12p5TreArGC6u95a56qUM
	3nDuo63wONVrAmof81HFQrHqLpauVyRH3O505QWYx7PQnKMyXu0Ifvsq+Iuh8t7ExVFI/P1+lBJ
	h9TH+ok+nxcYpTinSW9rsG+c9+zVWZZeSs/2IFWZxMZRpnnY3VkrmOwPd3wCS0AQwPHlgE7EmAi
	IhPmW87XoOp2DjPhW3j+ceuu9z8J4/pyw+KlTl8s1v2n0XkMCBqj6C1In38dD0fEHr7GsgiF+FR
	RLSDnnEL/qX+6LNPyVheLh0ob1fi1rOjANgOnulOr0KezqGAFaISrhw0
X-Google-Smtp-Source: AGHT+IFurviFEp8JcHtzr5W6FdDeM2cPQcoATIWyCv0v+8ZL8MzgzKHUiPqDOhR7vij3AFd9SpZEjQ==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c29 with SMTP id ffacd0b85a97d-3a529497006mr1516750f8f.53.1749115411728;
        Thu, 05 Jun 2025 02:23:31 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178379sm12156115e9.10.2025.06.05.02.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 02:23:31 -0700 (PDT)
Message-ID: <652ce9db-0bca-4892-aa16-1c41ef469f51@suse.com>
Date: Thu, 5 Jun 2025 12:23:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/its: explicitly manage permissions for ITS pages
To: Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 =?UTF-8?B?Su+/vXJnZW4gR3Jv77+9?= <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, x86@kernel.org
References: <20250603111446.2609381-1-rppt@kernel.org>
 <20250603111446.2609381-5-rppt@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250603111446.2609381-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/25 14:14, Mike Rapoport wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> execmem_alloc() sets permissions differently depending on the kernel
> configuration, CPU support for PSE and whether a page is allocated
> before or after mark_rodata_ro().
> 
> Add tracking for pages allocated for ITS when patching the core kernel
> and make sure the permissions for ITS pages are explicitly managed for
> both kernel and module allocations.
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


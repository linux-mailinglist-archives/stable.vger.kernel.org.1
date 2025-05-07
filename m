Return-Path: <stable+bounces-142056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569DAAE077
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC38016323E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE64280A2E;
	Wed,  7 May 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsn6A1Kz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7562E40E
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623901; cv=none; b=RMo8WYNUC3Gz9lpo82PH0U9676xrWHl7jA1bMpC65HjRMS7Apt6wqSl593cGFL0mLeQPKzNVKxLxBC6kpQdX5Bn0c3iWhBXb9G94oQQzDXSOd9yN/YaGLfm1LVlpneA+z+vo4tDGihF8tmM5jzk9JEAtBCtEmo1fG2DFHy/BX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623901; c=relaxed/simple;
	bh=MTHG+6AhIYkYS4V+hdQz5Lg0TWLwhQHyiCq/Z2lQxK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DO/FatKx59+qQVQdL9sX+GcWhAD4GUnvrGhRWJ0YpVlj3nXuTVvE+Xddejt2aW/jnQiS7ZWNlcYw9pOKHIECS9EPJnPTitEujGNZcXz/N8T+ntgpYmq9/pDLkq57KGtLZsBKuT/TuF1GliB99ZlJ+PBumpNf0Y7/XMw0tlq7oAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsn6A1Kz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746623897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FG3kNlYcb8YUhDo9rxNXddcYreagTVa77SB8lGY4MHs=;
	b=hsn6A1KzV8X0JCnvA0cpyyGxJBi/RlJWILJreLpgWweFg9+hjC1+gslqAzf30awb4yTWNy
	M/Az2grMxksyM4JN6+PcLVlSpx3O2FgKTB0tUO91tV/nmxexdqbTbVKOru5S/OA9LdDs92
	idSvxUa5aFFZLZtwtlCIjSJIJ/O3NLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-Au1cL66dMcW3vjPcEMVYAA-1; Wed, 07 May 2025 09:18:16 -0400
X-MC-Unique: Au1cL66dMcW3vjPcEMVYAA-1
X-Mimecast-MFC-AGG-ID: Au1cL66dMcW3vjPcEMVYAA_1746623895
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so38500695e9.3
        for <stable@vger.kernel.org>; Wed, 07 May 2025 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623895; x=1747228695;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FG3kNlYcb8YUhDo9rxNXddcYreagTVa77SB8lGY4MHs=;
        b=D0+VB4r1H11+03yJ2ttU6+afY3qG4fr1EsY7//nLet1qMMgN7tJOAOKqgrJoMNEqvG
         7q1BiABLU957XS+8gHVlC1ODvQYPBED3xAb069qMF73gjEgveN6Tos7d0neGrroHP3o9
         yk0WEwvaof8dm7tYlbXkv6gPjaXIyM2JtP6lPLLhgYW2021wMICdMBVaVEQmXLd/A/w5
         yU+7HevgGSZN4mckSiWkmFHFs+O/htuwMAJ7kqqnJy2Dnlp0QnlFPARfyI/TF1lZDlcL
         l5WUicPtCIlhzRLk5RuB0sV1jA1mZrUfO+TiQuIgzwVW4WwgKP+rZSAGPAzdva7/sN4G
         6hpw==
X-Forwarded-Encrypted: i=1; AJvYcCViINip+DGblGP4SW/p22VLXiYLbyGB+dQx1RhRqfGfLtlpP3gR0RY89ZxY2RJ3RQy1VIGzdu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXP1p6e2rGzF5I6bCdspmnt8Sz3MyUXx65bPckw9raYuZLmGJ
	i1zmOxWtbfMTNI38UMaMpr3z4oH5xUGPYuDZ31Zs0aRVb4l6/rNyzKdzKGt3prtdbs/bXq5jfit
	uEquYPIGoDpmIbU8LxvA/+Us7IEBF38qgGJvLMPdUUSRoYMI/i5fQzQ==
X-Gm-Gg: ASbGnctzDHzJCGKb6fE8i28LBKIGTVgEWEC+cJoUTGQwKUeOyPno7vJuQN2B2I+XLbE
	HWwM+wte3sO2OEQn1O8uTOeUNAh//gHjvvHYh3Vhl/mPHpwAZlW82mtZ2aVjCT9VhlsjFa4iTYc
	CSRF6ySQIMJ6yQBbtRjIMM6BYtRHrQ2+PEhRwUgpekbmDZzA/vz0A6LuoJlPHphWJwK1DoTpz8M
	C8kCr71ONBfVQWsynjflinvIS0kfZB+5Rj7U054WQXw08KhF/r4P+AWwLrTYXJ8uefTS4+81mTv
	8PgvLwDGKDoyYilzyn+CUfgjnjF5pZfFytZuLZ2jW5gjtESwBhzIuumONZQehbK5cpP2VAPzK9I
	twwmNPJNjt47jgGR6Hu8IqfgWjye9tZULmsGLuw==
X-Received: by 2002:a05:600c:1d8f:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-441d44c315fmr27666545e9.11.1746623895302;
        Wed, 07 May 2025 06:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGAGKlUk1CojooV02HZaxfdY4EaPWUbdBSLkYEiYIxrFTs1AdessNfp5hENPaPv8+VicTrpg==
X-Received: by 2002:a05:600c:1d8f:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-441d44c315fmr27666305e9.11.1746623894962;
        Wed, 07 May 2025 06:18:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:d400:ed3c:fb0c:1ec0:c628? (p200300d82f12d400ed3cfb0c1ec0c628.dip0.t-ipconnect.de. [2003:d8:2f12:d400:ed3c:fb0c:1ec0:c628])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c5esm16644012f8f.1.2025.05.07.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:18:14 -0700 (PDT)
Message-ID: <4610064f-04f0-47c5-aff9-2584958f71fb@redhat.com>
Date: Wed, 7 May 2025 15:18:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP
 is enabled
To: Ignacio.MorenoGonzalez@kuka.com, lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v4-1-4837c932c2a3@kuka.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v4-1-4837c932c2a3@kuka.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.25 15:13, Ignacio Moreno Gonzalez via B4 Relay wrote:
> From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
> 
> commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
> the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
> CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
> VM_NOHUGEPAGE does not make sense.
> 
> I discovered this issue when trying to use the tool CRIU to checkpoint
> and restore a container. Our running kernel is compiled without
> CONFIG_TRANSPARENT_HUGETABLES.

Like very kernel out there, because this config option does not exist.

:)

You only fixed it in the comment below the ---

-- 
Cheers,

David / dhildenb



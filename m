Return-Path: <stable+bounces-183428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CA2BBDE13
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDDD3B5507
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83F26A08C;
	Mon,  6 Oct 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBW2G1ur"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8F26158C
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750608; cv=none; b=pCrBed1QimOr4DYS40rGmloZCkQBFzmAPqmNA/ErGbahNuBvyqWf/lRphNm5Fit0Pq3TukzfX/LdA0NzMY08kKWI3HrSRrM+vGWVu1piuLyNwnrdkHZvs0Hyvr9LjIe6a978UgFIUU269e3dRRifblGC/Ve1IH8DDgR9MW8SbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750608; c=relaxed/simple;
	bh=jgFmOZy99XKs4DXZwQeTOTDa/EuMGBOdSdGACbwRi6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rejXGOUmIXkAWe9Z+JC7XHTJt1tW0z5D9i631E5YgbklkhhMdHVOWwgJ6/MC/mgqxd9won3dyJ+ZhVmjsbrB1xdCGRH7yK0RhdVxFZLRQFa7BH0jyUq2UYo2vi0Pd8rrtjQF0tmhi0Btg6BmmefHNO1UBtez2fWchsm0EGjD1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBW2G1ur; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759750605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vHN3zB+N3cficB6+biNHEOHdUuG5loOtVKEpUTZFgh4=;
	b=ZBW2G1ur8tF9kzMGrnTy/+s03hSDUY+yUPHR8q5yZmP2nFR74+iFmuZXOqsZyL/Ackn8Kq
	nsQq4LxXCqzAzdgw9KWwh5FxLWb9oHeFh35LlnwTTXnCqiIvZGrwpqAFHEZ2EnIsLTmLc/
	OgVVhlrbANOOwGiZrLSqMDD5cspw5cY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-DdSimhb6ONWvJFF6aZnjsQ-1; Mon, 06 Oct 2025 07:36:44 -0400
X-MC-Unique: DdSimhb6ONWvJFF6aZnjsQ-1
X-Mimecast-MFC-AGG-ID: DdSimhb6ONWvJFF6aZnjsQ_1759750603
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4255d025f41so2900971f8f.1
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 04:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750603; x=1760355403;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHN3zB+N3cficB6+biNHEOHdUuG5loOtVKEpUTZFgh4=;
        b=RwN0eMas9/5S4J+KT8M/6BotaKvH1Ze7uX5pmzeYFPR7xQP1vk6mSgUy8Tnrf4q/fL
         3SY+yyjKhBazpKLxvZ55JqcNIrPgYEmsu19dr4jALTnYxhi2HqdN4WRlI+bJJIUQSt90
         5jUUIIrFH0AT8pf6zipGj8a2eUm/21OuxLlpDxXwpkgPn4qfF75wE42YoeXoNbOn2X+K
         pdIdqX9Iyxu8aIBUc8q2Sj3qsHyDgj/nb67Xp5VktYn822Nt9sAUGagWABA84/17bKtU
         X8uVia9RsQe3skK2odCVvxRgsZBk8+IWCkTrI3inEjGKlNZqRdTgBSbjvtMsIQ6KfNmc
         nKGg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYSfsBZfMZAEIX8xm/XbN9mx0HT/3WuuZaSR5eDHYGT4RZVLzcv+7Qnqp/MMHuD/yuBduFkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUgxRmCVyFwT9f6HjBHDD/qCggoi2xtDjxFnoocVLoLevAdVf
	u2SVybEGbTcMxRAdNAYr55Lh8NLhUT09xUq+7nk0Zv/5iBmmaNIqDCdsE1qUy4nUYtprYnEyENr
	ADj4hrw6CmOpaWUtHJEZLrBJgDw69XrsBA4Vj0ssWP5no6/ju5jJyJm/PIw==
X-Gm-Gg: ASbGnctxXIm9zMfIX0CYUTCoqEl6MLPQS/q/wXaR3pUWaa7BzTw0aVFYe6AQjjunwzR
	6Sf8KzeoEg6c6sDm08Im8n9NMdDCOMJptjiGQecIq/QLOPp8O64iXA9WezjvouoWVcTVkHHNdwl
	q5zE3E2qeadVNiShpirkYo8M265c2NNC9Wvo5usw9I3MNACXJZj4TPBnTB8vFIxvYuKkNulnXpX
	S+tBxwdFXSSmnU4EkWE40aRYw2E6x4Xs/x/PZ4Hj4klgce0bbE56n4Z0DfBRN8D2cRrWFAArWUN
	ETMpK2Su2OpXIGCApCO0mkd6sEUU5dh9z/z8q0WXyzMqymc4mi97jlFN6eqjizHWr+O6AYi7rpS
	EVGKaWhGH
X-Received: by 2002:a5d:584b:0:b0:3ea:f4a1:f063 with SMTP id ffacd0b85a97d-425671c15f9mr7577062f8f.55.1759750602866;
        Mon, 06 Oct 2025 04:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4fa1egcyF8r1G1AFUJgPykSWMK+76QilbNO7Gb4q43iQveNh0omx+isa8IIngfIMXEURqYw==
X-Received: by 2002:a5d:584b:0:b0:3ea:f4a1:f063 with SMTP id ffacd0b85a97d-425671c15f9mr7577044f8f.55.1759750602454;
        Mon, 06 Oct 2025 04:36:42 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8fdsm20309038f8f.15.2025.10.06.04.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:36:42 -0700 (PDT)
Message-ID: <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com>
Date: Mon, 6 Oct 2025 13:36:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003155238.2147410-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.25 17:52, Ryan Roberts wrote:
> fsnotify_mmap_perm() requires a byte offset for the file about to be
> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
> Previously the conversion was done incorrectly so let's fix it, being
> careful not to overflow on 32-bit platforms.
> 
> Discovered during code review.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> Applies against today's mm-unstable (aa05a436eca8).
>

Curious: is there some easy way to write a reproducer? Did you look into 
that?

LGTM, thanks

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb



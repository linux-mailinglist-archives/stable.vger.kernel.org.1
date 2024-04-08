Return-Path: <stable+bounces-36393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6193A89BD67
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BF01C21D17
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374435FBA7;
	Mon,  8 Apr 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJx5ItNa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CB5FB99
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572799; cv=none; b=cx1p/zv1Yi/+Gwz8oBqrNAIJopAFbnd3R405mJk189dOvdiqdRq7rGAT+JPrijJGsQKMm94F4iBqwWnYQVD7bIWMHnq8guNct6bFKLMnbUjJVpSPEiLyYOkHq0ziHdI+08lR78ED1owXZ7cPhKsO9ynxojCAV6Trnq9Gg5d7fOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572799; c=relaxed/simple;
	bh=SceVLA5HwWii61lfpDH+ZSy7B7oLb2FZ/Rg9P7O2Tq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o12MtdUH6oIjI6Bz+GShTZ9AWqZWmpFCYYXZ15IolS6BsBePdoaBKoUZEdUss9p+W/8YgV8yg1UHb7OVO2l6bZ0SS7MPw2I3U1yebzQ7kG8thbsdwJEt5+uAo16zKR7ixXy+URyy0rH6DzQSwJePlX76DKSifkVCLxULNFwlwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJx5ItNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712572796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VeOMZB72woNwVckuSTJ5UxHd7aL3ayjlOTTdsaKKXsw=;
	b=HJx5ItNaA/QxrSXlPCt8ah1oBUH1jYpb6LNuvsvPMgrhmCDZCTEhB7rQkX79j2HmYyaYca
	FnEpyPEFzWwo/rs5+cst7GWCMgqVgv9BsLFO5m7yF6TAHvh3bNwZADNl2VPdCPdXV4Qb26
	7YGdrbLBO7z0cW2+RtnuQnCgKmbZuBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-DpbLwMf7MjWS1P-P8ZsfBA-1; Mon, 08 Apr 2024 06:39:55 -0400
X-MC-Unique: DpbLwMf7MjWS1P-P8ZsfBA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-415591b1500so25883945e9.3
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 03:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712572794; x=1713177594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeOMZB72woNwVckuSTJ5UxHd7aL3ayjlOTTdsaKKXsw=;
        b=Ea3ExpdAFyfyoCAh2QOpatXkm+EVPAvPEkfS1KIn8Ih26fRE1uSw9IZeFScB8K/WIX
         7RpMHUtX44dKJf7hf/EKIEf2Rj6rEA3JkFXOGxMdP096tgPjBfPBRrnNbtOEtKSMa7ZS
         n2h8SBfI4F/6A2aDdcIulRdDCDh2oAGfbZuvC+1Pcyz4++IBEfJQ5IV8mT76/AuS4bE3
         EoaG/r53A93KWSiqXJ2tjdCgTdGTpAVNFUjapJUG4aV10t1/LD9eyUCILddyZEzPv7pl
         qtrop/3p2Mmk/lih20vCAWmT6/eRchn0PeTduwLPn8qJ4CKzuuFe/BDx6h/Lo676T3ks
         LDGg==
X-Gm-Message-State: AOJu0YylDUab8HjmGxfxgUDR84aZzDlFS/mJpXTVdxhSlMtei3wDET69
	6+sPXlCvAvY0ceZ467DHqpBHpa/mnmYRWPT60HtMMsRbORtnt32foJoRZ9/iQ3k7hnNh0N0xv8F
	tbCDMJr+xY87cy+VZONVGhpS/LBwfViREfMPcE/841PyQCJisVnO32lWR0joA/antkfFq2pMzf9
	L0YLZYcAtT0tpeOVA0itsF0HAiIEPAJKL6qQ==
X-Received: by 2002:a05:600c:468b:b0:415:6dae:7759 with SMTP id p11-20020a05600c468b00b004156dae7759mr5526991wmo.19.1712572793840;
        Mon, 08 Apr 2024 03:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJK8JG3BX4OlNlpy1Fh2w3ln6N390AEyRpC9BtLKH8ZDIZssysraEwzGw88C+A1wksF5/Akw==
X-Received: by 2002:a05:600c:468b:b0:415:6dae:7759 with SMTP id p11-20020a05600c468b00b004156dae7759mr5526971wmo.19.1712572793299;
        Mon, 08 Apr 2024 03:39:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b004162020cee2sm16807129wmb.4.2024.04.08.03.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:39:52 -0700 (PDT)
Message-ID: <05c72609-06ed-43bd-94a1-e32788cf5654@redhat.com>
Date: Mon, 8 Apr 2024 12:39:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] mm/secretmem: fix GUP-fast succeeding on secretmem
 folios
To: stable@vger.kernel.org
Cc: xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>,
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>
References: <2024040819-elf-bamboo-00f6@gregkh>
 <20240408103410.81848-1-david@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240408103410.81848-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.24 12:34, David Hildenbrand wrote:
> folio_is_secretmem() currently relies on secretmem folios being LRU
> folios, to save some cycles.
> 
> However, folios might reside in a folio batch without the LRU flag set, or
> temporarily have their LRU flag cleared.  Consequently, the LRU flag is
> unreliable for this purpose.
> 
> In particular, this is the case when secretmem_fault() allocates a fresh
> page and calls filemap_add_folio()->folio_add_lru().  The folio might be
> added to the per-cpu folio batch and won't get the LRU flag set until the
> batch was drained using e.g., lru_add_drain().
> 
> Consequently, folio_is_secretmem() might not detect secretmem folios and
> GUP-fast can succeed in grabbing a secretmem folio, crashing the kernel
> when we would later try reading/writing to the folio, because the folio
> has been unmapped from the directmap.
> 
> Fix it by removing that unreliable check.
> 
> Link: https://lkml.kernel.org/r/20240326143210.291116-2-david@redhat.com
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
> Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> Tested-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706)

Forgot to add when cherry-picking

Signed-off-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



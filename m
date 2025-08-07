Return-Path: <stable+bounces-166768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A7B1D5D4
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA241898F3F
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE621FF24;
	Thu,  7 Aug 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfDRaaRs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40B42AA5
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562667; cv=none; b=Tc2BZ1J8EGUb5E84EicK9uUi0zX5W1Vvqt6j1V1K0FzcaZiCMBPoDumJAQ6uFZlvzdBeRc3In/sdBfE+vH5gaAVTDcuBnytiaOLWSoFjM6mXmQWFc7DvNpiUkN0Syy6EH0g27UYJMdEwqXzPQLSzs3SSsdXR1sw5fIDPfCjvPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562667; c=relaxed/simple;
	bh=dh1uMBzVyCLvxx3aaJ1ZDm8eOvtrxLj4sQbJQKADO1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H38Slj9lUtG7UFjbQ4GLTrqLgaYFa2wSC1pVaf4+YwK/H0ZmuWoSfM+2P9O+iQHKf+cFgUIJ3AbmTzBR6S8gFFvHBmO1y0gqpMWWZpX1rYdulZPQfd3h2gx1JY4I2fncPB16ZQsoIjkyhMrbmBTvk1ZKVSChxbj6zZV3HZ6YOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfDRaaRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754562663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+qVW9cLOj54YF0xIaj0lWIjiH/j6vomCG3o/DXozcQc=;
	b=hfDRaaRsjKFL3HmVG6aWrXzs9HrMXiszjYyz/BsHRlkxeD26fROrUCGML16Me9hmHsTsnD
	7o2VU6GWBc5ro+DqY9s5yEx81pfuHLoLTvZzN878UfZm3ew9k+R/JTZe8sUD+/HcTFc+SS
	cuAHaQEm6IyXT0UUKBMt9Ow5U1L6ob8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-yNGNelkIOZuvVxG5m1KRng-1; Thu, 07 Aug 2025 06:31:02 -0400
X-MC-Unique: yNGNelkIOZuvVxG5m1KRng-1
X-Mimecast-MFC-AGG-ID: yNGNelkIOZuvVxG5m1KRng_1754562661
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7851a096fso498667f8f.1
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754562661; x=1755167461;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+qVW9cLOj54YF0xIaj0lWIjiH/j6vomCG3o/DXozcQc=;
        b=sOkZq/WeiaTFd8N+UEFBrHv96PYl1/EKcik/T6fPTtde81056z4ZrsiYBYum5k1I/y
         rc6Cw1BbLk/LJ/j0Hal1+24Lmqy+0tVhDH/KN2qmsvGqJEaAIxfc8nOMv8a6IxIVjc51
         vignIvCAaLTaTzZw9B/bvh8sMKd/weON81OWI+PUPGDFGOy+3jFL6sBsjinvHnaBtfBU
         xECk677PQrHV8LQuDmAuVh4dlktCZU6hkSMfoQJAqBD8TlnLSRUSxB1W34lLPVPbgQy/
         wdebSxZ+K2poDqnbU5j6OhMh3O5bR0bHce2V2qLCiO2mmI6ZCNAZgrwgVsmPktVxhrUg
         GKsg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOzfpvuoGW95keIhnFlbGxIlP676FzG6zPAUpZ+bBX6D7ht8uACltOGHWBbByWG7qRFp7XVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZpE4S14HmyZ8B5L0mhsxgFVGmQtop3xcNxkruE+1VAl07BeZ
	kcAo43+IbP29wNN3wM2hGhpVhNFowJoayjN3zbRW7O0yg3Z0wjfxs+R9YkHGxZpMbhiMZW5wpvH
	KHkn3gJFD/UVu1P79UVl27EzR/nk8N+tals6Bs8nTSNnIEtk0PkH08GeKJQ==
X-Gm-Gg: ASbGncsMGVP54p36en7rs/+w1fhIjGXsGSqUIcrxijz0RvQGYjut7ObUXVP+POaRFQm
	2m6fMXk5ZKuERBGWlq8nsMFlCboxUlynoIscrgym7nO24R3QEes9p9doRIerWDPpVCM0FSSYiLW
	2xC5v8e3FRzWdSdz997Z7Xe3u/CE8FQvnB3La0FU9zbII3ZQG0YKnd/UqhWM13Y9a3f/ZhQBOIK
	JvIH02CTM+Gg1ky6wzr2+97vt+PdJi+ufkLL/YecYfUXfJnR78BEabAAEAFamc9qK79WNej53al
	LMEzySR9P/z1e3B+DFCVofC+tMkJTIiqlK5FIdQT03GEfLopULj473ejbIJf5WH30FEwyaZcbeV
	TII19g/gcGeBCJ+HgIrUlcx1znqeusXIxU5usicZPPBttVJzyMHrH/DO1UgdivrLITDQ=
X-Received: by 2002:a05:6000:188e:b0:3b7:8473:31bd with SMTP id ffacd0b85a97d-3b8f414c4a7mr5352818f8f.0.1754562661257;
        Thu, 07 Aug 2025 03:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVvmP83x7UutNKzV8FG/fdk3ibG+3w7boHxmbnZj/SXv3iUKT38lto02D3K+S+RQXWyX0Mbg==
X-Received: by 2002:a05:6000:188e:b0:3b7:8473:31bd with SMTP id ffacd0b85a97d-3b8f414c4a7mr5352785f8f.0.1754562660784;
        Thu, 07 Aug 2025 03:31:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95f4sm26154427f8f.23.2025.08.07.03.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 03:31:00 -0700 (PDT)
Message-ID: <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
Date: Thu, 7 Aug 2025 12:30:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterx@redhat.com, aarcange@redhat.com, lokeshgidra@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250806220022.926763-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806220022.926763-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 00:00, Suren Baghdasaryan wrote:
> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> obtaining a folio and accessing it even though the entry is swp_entry_t.
> Add the missing check and let split_huge_pmd() handle migration entries.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v3 [1]
> - Updated the title and changelog, per Peter Xu
> - Added Reviewed-by: per Peter Xu
> 
> [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.com/
> 
>   mm/userfaultfd.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5431c9dd7fd7..116481606be8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>   			/* Check if we can move the pmd without splitting it. */
>   			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>   			    !pmd_none(dst_pmdval)) {
> -				struct folio *folio = pmd_folio(*src_pmd);
> -
> -				if (!folio || (!is_huge_zero_folio(folio) &&
> -					       !PageAnonExclusive(&folio->page))) {
> -					spin_unlock(ptl);
> -					err = -EBUSY;
> -					break;
> +				/* Can be a migration entry */
> +				if (pmd_present(*src_pmd)) {
> +					struct folio *folio = pmd_folio(*src_pmd);
> +
> +					if (!folio


How could you get !folio here? That only makes sense when calling 
vm_normal_folio_pmd(), no?


-- 
Cheers,

David / dhildenb



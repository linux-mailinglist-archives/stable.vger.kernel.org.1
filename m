Return-Path: <stable+bounces-165713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14507B17D67
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E0C17FDCD
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F121F5617;
	Fri,  1 Aug 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fqk0aEbu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75729148FE6
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032901; cv=none; b=Irosr1fElbLbmkx+KisiGRG9W0i3jkYqMgTFSTtmevv0c42Gy2KQNPsdsJEj2MzYcx0eMvkZ1Bjc28e9oQl48THv73vvdC3zYO1zDEs3CdEFmbdR1U8HubJrgnSJrcPENvcFRVLRlb68mUwClCIP8qYLSrbXS7eeDbfqVhBM0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032901; c=relaxed/simple;
	bh=XGM9lwd5EitZ4kWWbFKf6eAJoN5zr21HS4gcAE5c1Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGg7y6wRErClaTo+ZpY8tw6/ZU6QyiMQPuf+dnJ4Q1tA4CGAh8U+GqVYHpsEv2g9muNV4WIU0IYX+o5q9bk04R3XWDKNYL+AlUAyuTbMUeAoxRsO5GZPVmDy4PdF/pZik84x8eI4ETFWmknsJFRn2+6r4nGCK1c1GbFAEpX034I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fqk0aEbu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754032898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k8xuj1kmMyeJuw59snTbgeRO/erNCN9chpx+Tbf452o=;
	b=Fqk0aEbulJZ9f01CtHUEu7sw3ACak8wfko61Q1HSK5FvbpPHIhfXZML14v3+fiG4L05K3C
	k6BNwAWxnDnIW5WSkfDNbn3EQWxJvUDlJlMLIHygTjl5tXNgAzcV85Sg0RazcHmvDyRP5Q
	mrDWkTLuZeToZh5YiwMxIHud5H8auAg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9cS3d6zAOIiWiktjbSvSjw-1; Fri, 01 Aug 2025 03:21:34 -0400
X-MC-Unique: 9cS3d6zAOIiWiktjbSvSjw-1
X-Mimecast-MFC-AGG-ID: 9cS3d6zAOIiWiktjbSvSjw_1754032893
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4560a30a793so1605275e9.3
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 00:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754032893; x=1754637693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k8xuj1kmMyeJuw59snTbgeRO/erNCN9chpx+Tbf452o=;
        b=ryVUljY8SKV/J2eVtPZwcy37bPWKQSZsx4Acn2jUBdMdR6pDZgz1ntKO3szcC8XmIP
         E7QgjoQbj5U+b3L8xWWinyqVrIYin02PYMHK6krLdLECcjUWdz3yN/b6u4Uwwmi02lB9
         By0yOnbRAir4IPen77tE434gJe2yXlJU6Jx9/GzQqkH0sMQi6ZlSxTOhY98kaXpzzFgC
         E2M9x1VkskQqkFUKSBo0g70v7weuF1rKRwo+pf04o9hnMn94hL0YWeEwCWgSBwTutSJH
         G7gie+H1wNJ0DvUQyXfpWs1SSZgJfaBJCcctURdevIdUnpGcOeQQHRe6pRUvPOOZZxtg
         3doQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQOjJggYAVV3dCqe9fBZeliZZ3mpde2qzuaRlFIFBsxdhpMeUHsr37V7JYD9U+HfYU4r+VyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXC3/v9gg3+wVr08FGhL4nXinrL4MtCaOHgLfJtiu1ECyFgGX
	XqanBZ5jHpMy2Xvhxw32zvZFaR1perNn3osNw0Y1fVxixDX+nDwqPtwn3e3MhBvKUvU6XZylI1d
	0XOdwTznU4Xm4j8I5y1aCyVGIqXiSgqSoYumdwoWHQ5TRQ03bLBsQLdvzaQ==
X-Gm-Gg: ASbGncvGYrtSv4PrBbZ6+Jg4oVK6Ejz0Up9yDXolEi8Nch6n/3AzdmesG44GI+DMMyE
	jb58pymVofxj8KrekM/RKpJujExiQQ0Jdj46mhn43ldktC3diQY+ncPIdGlt7vm4ti4L96+X2WR
	iEgMFrY4Aq/2AkatvhbABvGwxSKyjonNrL/ZBGa4cGWvXCjFCKysdpI+nFKbYffU8zOhpKFBuSP
	eHMOTrud0alEsjQ0v/d1ERZYza8R39/NXiVD3whQbdgC07uiUOWoUT4ZP70XethvsxIQkrJK4m6
	JYKJzbgtTPyfn7jLVyL17xO1gHwWNzGqSoquf/7BpMS7iiKhDoljcEgXeonK+xoh8JfY9CSf/Dy
	WOERO8KuTfN+p0mAXGDRwkTfjbFq7OYEEzo/40g706UlQGAQFDsxh7NaG4pMrP16u
X-Received: by 2002:a05:600c:c166:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45892b95290mr88213735e9.6.1754032893002;
        Fri, 01 Aug 2025 00:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGnbWL+2Z46Bx7ewYm1BnyM3pVCWPyXd8fhCoLsU/ONtKYTdZJvEp9DlxsOJ15wsyICfx0Kw==
X-Received: by 2002:a05:600c:c166:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45892b95290mr88213445e9.6.1754032892516;
        Fri, 01 Aug 2025 00:21:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm4788092f8f.55.2025.08.01.00.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 00:21:31 -0700 (PDT)
Message-ID: <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
Date: Fri, 1 Aug 2025 09:21:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterx@redhat.com, aarcange@redhat.com, lokeshgidra@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250731154442.319568-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250731154442.319568-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 17:44, Suren Baghdasaryan wrote:

Hi!

Did you mean in you patch description:

"userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"

Talking about THP holes is very very confusing.

> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> encounters a non-present THP, it fails to properly recognize an unmapped

You mean a "non-present PMD that is not a migration entry".

> hole and tries to access a non-existent folio, resulting in
> a crash. Add a check to skip non-present THPs.

That makes sense. The code we have after this patch is rather 
complicated and hard to read.

> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1 [1]
> - Fixed step size calculation, per Lokesh Gidra
> - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> 
> [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> 
>   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cbed91b09640..b5af31c22731 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>   
>   		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
>   		if (ptl) {
> -			/* Check if we can move the pmd without splitting it. */
> -			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> -			    !pmd_none(dst_pmdval)) {
> -				struct folio *folio = pmd_folio(*src_pmd);
> +			if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> +				/* Check if we can move the pmd without splitting it. */
> +				if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> +				    !pmd_none(dst_pmdval)) {
> +					if (pmd_present(*src_pmd)) {
> +						struct folio *folio = pmd_folio(*src_pmd);
> +
> +						if (!folio || (!is_huge_zero_folio(folio) &&
> +							       !PageAnonExclusive(&folio->page))) {
> +							spin_unlock(ptl);
> +							err = -EBUSY;
> +							break;
> +						}
> +					}

... in particular that. Is there some way to make this code simpler / 
easier to read? Like moving that whole last folio-check thingy into a 
helper?


-- 
Cheers,

David / dhildenb



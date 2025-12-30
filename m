Return-Path: <stable+bounces-204181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C4CE8A30
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 04:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EE530111B9
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1B261B9E;
	Tue, 30 Dec 2025 03:21:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EE7E0E4
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064899; cv=none; b=k9XdbjngAAvZnpIRXKxxRySf/5cZnps6eC5ktcXneGVe6xe6c7BoBWi9oa9wapWK3UGJhujAt38qQ1zJ9sSNmJo1hYJ3exucOX+kvE3cdcmcGLQSypeyQ3nRhEG2tu7jdM6y6S9sMM4tGEJkJmwhHReAUvsiaYyunJ35HDoO1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064899; c=relaxed/simple;
	bh=QbE4Yvvmp0KIoHH7zMg8Lplcm5pkWjceUr6KyatYO24=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=tO4/f0fyiFxqTHege0AAwUrJGrA7ahDuL9Ql3hFluL5mx7+HQJ+VIDl3bRHqb4dqaelcG+UR3Cy1p83LNzpqkOtD9ppQF3HT2xCv3LhLDcOsiYW029J5XseQQIhNx35ySC+UydaJr4R6uA5B0vQT4vebHFwCvy6uwRrdVWHiX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dgJ760m7yzW7m
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 11:12:50 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4dgJ6y22GgzBc3kc
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 11:12:42 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dgJ6n2JXHz6G4Cb
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 11:12:33 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dgJ6Z6sdDz51SWM;
	Tue, 30 Dec 2025 11:12:22 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5BU3CCDa035142;
	Tue, 30 Dec 2025 11:12:13 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 30 Dec 2025 11:12:14 +0800 (CST)
X-Zmail-TransId: 2afb6953430e3db-92178
X-Mailer: Zmail v1.0
Message-ID: <20251230111214190MrIEmGM735qawBDQdXGTo@zte.com.cn>
In-Reply-To: <20251230025443.1980197-1-sashal@kernel.org>
References: 2025122925-designed-overture-2e7d@gregkh,20251230025443.1980197-1-sashal@kernel.org
Date: Tue, 30 Dec 2025 11:12:14 +0800 (CST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: =?UTF-8?B?5b6Q6ZGr?= <xu.xin16@zte.com.cn>
To: <sashal@kernel.org>
Cc: <stable@vger.kernel.org>, <shr@devkernel.io>, <david@redhat.com>,
        <tujinjiang@huawei.com>,
        =?UTF-8?B?546L5Lqa6ZGr?= <wang.yaxin@zte.com.cn>,
        =?UTF-8?B?5p2o5rSL?= <yang.yang29@zte.com.cn>,
        <akpm@linux-foundation.org>, <sashal@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA2LjYueV0gbW0va3NtOiBmaXggZXhlYy9mb3JrIGluaGVyaXRhbmNlIHN1cHBvcnQgZm9yIHByY3Rs?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5BU3CCDa035142
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.121 unknown Tue, 30 Dec 2025 11:12:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69534330.000/4dgJ760m7yzW7m

> Link: https://lkml.kernel.org/r/20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn
> Link: https://lkml.kernel.org/r/20251007182821572h_SoFqYZXEP1mvWI4n9VL@zte.com.cn
> Fixes: 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
> Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Stefan Roesch <shr@devkernel.io>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ changed mm_flags_test() and mm_flags_clear() calls to test_bit() and clear_bit() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/ksm.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 2e4cd681622d..96a0feb19c09 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2451,8 +2451,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		spin_unlock(&ksm_mmlist_lock);
>  
>  		mm_slot_free(mm_slot_cache, mm_slot);
> +		/*
> +		 * Only clear MMF_VM_MERGEABLE. We must not clear
> +		 * MMF_VM_MERGE_ANY, because for those MMF_VM_MERGE_ANY process,
> +		 * perhaps their mm_struct has just been added to ksm_mm_slot
> +		 * list, and its process has not yet officially started running
> +		 * or has not yet performed mmap/brk to allocate anonymous VMAS.
> +		 */
>  		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> -		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>  		mmap_read_unlock(mm);
>  		mmdrop(mm);
>  	} else {
> @@ -2567,8 +2573,16 @@ void ksm_add_vma(struct vm_area_struct *vma)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
>  		__ksm_add_vma(vma);
> +		/*
> +		 * Generally, the flags here always include MMF_VM_MERGEABLE.
> +		 * However, in rare cases, this flag may be cleared by ksmd who
> +		 * scans a cycle without finding any mergeable vma.
> +		 */
> +		if (unlikely(!test_bit(MMF_VM_MERGEABLE, &mm->flags)))
> +			__ksm_enter(mm);
> +	}
>  }

Acked-by: xu xin <xu.xin16@zte.com.cn>

Thanks!


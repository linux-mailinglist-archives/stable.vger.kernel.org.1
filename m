Return-Path: <stable+bounces-204180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054FCE8A0E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 04:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B7C30124CE
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831326463A;
	Tue, 30 Dec 2025 03:15:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF026159E
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064509; cv=none; b=goWZoSXNVl4PlBBjImnZ9K8ltOePiZBEoQ2lQGojQcMZ3CGtYEPuZsAmEbc17BoRWsARKGOqG+c0UavbOoH/oEQGAEpZB/bjqIO+Fo8ZkeivgmcGOZ92P+DwnmlFVZtI8aqQQ0NKYVowKdHJrGZZDgmxohSMSgCsj5WWTkZYi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064509; c=relaxed/simple;
	bh=di8L7v5VLjwv9lUiFOQP3HI1ZBSmZ72qjsd6za14TW0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=YN5R3Z/qmT2CA8A66pgrtsofYsQ51wUqoNnxQ+QfMJuotYGBIN7w2Oajyuh6pjcciUyFyAUPtlBkQOyPfOY4+Alo34IrNN1yYV0vV2EmjH7rxre1FOmjBMva55wch6S2z+86AyALx5l7waQX0D6QmOpHqNU2ATgvAudsSM7PEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dgJ9h4DfRz6G4Cb;
	Tue, 30 Dec 2025 11:15:04 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5BU3EqP0040615;
	Tue, 30 Dec 2025 11:14:52 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 30 Dec 2025 11:14:54 +0800 (CST)
X-Zmail-TransId: 2af9695343ae80a-9a59f
X-Mailer: Zmail v1.0
Message-ID: <20251230111454048UYWSJXSiWI8QBbR_dYjFf@zte.com.cn>
In-Reply-To: <20251230024937.1975419-1-sashal@kernel.org>
References: 2025122924-reproach-foster-4189@gregkh,20251230024937.1975419-1-sashal@kernel.org
Date: Tue, 30 Dec 2025 11:14:54 +0800 (CST)
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA2LjEyLnldIG1tL2tzbTogZml4IGV4ZWMvZm9yayBpbmhlcml0YW5jZSBzdXBwb3J0IGZvciBwcmN0bA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5BU3EqP0040615
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 30 Dec 2025 11:15:04 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 695343B8.001/4dgJ9h4DfRz6G4Cb

> @@ -2820,8 +2826,16 @@ void ksm_add_vma(struct vm_area_struct *vma)
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


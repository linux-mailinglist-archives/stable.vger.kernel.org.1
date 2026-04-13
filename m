Return-Path: <stable+bounces-236103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG19AC363GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:14:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 939513ED29C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22D4B300DCF8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571533D8137;
	Mon, 13 Apr 2026 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U2qrO4/B"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549E3D88F2
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089630; cv=none; b=DXXRQScX5dtjgcMJAztLm6zs62CKkSlVVH0DU+3KOxL30SauThzbMuyfkDOSA5a7oinI2gB4VwIFltkqsLpd/3lcunlLDv2Tkk00zNHlpzO0gEPxER+j/BTuxUVJBz5nN+P+hvD0nJAtPYAr6Ygm9/trFB1A3D2sfpSp6Ji5hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089630; c=relaxed/simple;
	bh=przxY71irLjGb3M1w1Mo47dYsyHXv7/dKtrfZKwKU/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqTB1zW7Rz3B8j83rl5OP6OvJvhRgMapNdGU0UmKCXM3cq8lvSmER1BYGiYUI+2Kw4Rra7MTaGpmfeMigDzmY2HQV0gxGIEUgrWHGrBpFCnICGrNWo94UWYs5AOVL741Rf13MHIEl1PWm2xueKpzadR0AQYjx9i/ff8vZoWE8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2qrO4/B; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8747df25-721f-4813-b81d-8c7275a2f33b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776089616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M+7T8ZcuIplDzLqOqdGKThmKW/nekPSMPdpLelpxjM=;
	b=U2qrO4/BLedHXxuPkTjgI2NHer3fd2VJbGz/lKOBJ4HPiD6R9Uzd86XNZ+k/r78JkhmcJn
	oO50JyjP5yRF18Ia6feGFHQ/voxt99Jfj38P9q17VC/t6iWQPNoFNUlS2GJeaRducNnsGY
	MOODgu6Prd7Fy5mRp7RJ7n0kpAssa+8=
Date: Mon, 13 Apr 2026 22:13:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: thp: Fix refcount leak in thpsize_create() error
 path
Content-Language: en-US
To: Guangshuo Li <lgs201920130244@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: stable@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>, Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>
References: <20260412175428.2613383-1-lgs201920130244@gmail.com>
 <8eda3f8b-b811-4303-aefb-4b23aeeff16c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <8eda3f8b-b811-4303-aefb-4b23aeeff16c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236103-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 939513ED29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/13 19:39, David Hildenbrand (Arm) wrote:
[...]
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 40cf59301c21..c8ffa188a198 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -726,10 +726,8 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>>   
>>   	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>>   				   "hugepages-%lukB", size);
>> -	if (ret) {
>> -		kfree(thpsize);
>> +	if (ret)
>>   		goto err;
>> -	}
> 
> kobject_init_and_add() indeed documents "If this function returns an
> error, kobject_put() must be called".
> 
> As Andrew says, that's not what the "goto err" does.

Right. v1[1] should do the trick: just jump to err_put

-	if (ret) {
-		kfree(thpsize);
-		goto err;
-	}
-
+	if (ret)
+		goto err_put;

Hmm... not sure why this changed to "goto err"

[1] 
https://lore.kernel.org/linux-mm/20260411062152.2092967-1-lgs201920130244@gmail.com/#t


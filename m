Return-Path: <stable+bounces-66272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7E94D193
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8848C287218
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFA195962;
	Fri,  9 Aug 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpBovrYD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38F194C71
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211364; cv=none; b=FSTUqXvLZKcvu1xVEu+B1Ey5vxEON0sFSjZ+059bEgjmYbyV/xHo3wqYCJix5AWxK0WMhO1KjZzZxfaGXBwTrR0nydEHresNJ8AqQwcdshJga9Q7VXO+T7lCsz2Deo/WEMCtNk3Cpjbc+6nSPvdtc2CvlRymCKkFazpzDM+e+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211364; c=relaxed/simple;
	bh=HNB6pfh342t9AnG0iJPolconJkC4Xc2R7QZVU1D94YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnTQfDApj4cpCvYD3A+CrzRK6YkhJiNUsOa9QTdg856DJNGRXQFrb74MMJjBNQaSSU57yFlgAbTEDfvcLTxt7DJ7zvNrV9iPO+YoN+A0xidlLe696Gq3MAWzkttSzYjhAx52lvuLLX8Vf/PNMUygChdYtHoZHvAj8nTMN1NhirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpBovrYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723211362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d8l6dVkBJNiXSWSlF/TpRr+4mGvpOZoEKaGvvIjG4k8=;
	b=PpBovrYDvNQo6gCv0TURD5JrtLUsB8Jhf1ygWL/iZjMjek6SMCHX9thV1bvHSowJ2KDJVF
	RDAKohl+zcmyVLaFgdI+j3OX4yC1M2oKNjlvu3BXymZ6Mx6YjdVpHmkQ00xjRIaJSrb0yS
	3jKUA5Lab1ggiObyJvb95fLpb8algOM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-lMqDt8KGP_C3-CdwFOvExg-1; Fri, 09 Aug 2024 09:49:20 -0400
X-MC-Unique: lMqDt8KGP_C3-CdwFOvExg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36d2c29e4ceso562710f8f.3
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 06:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211359; x=1723816159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d8l6dVkBJNiXSWSlF/TpRr+4mGvpOZoEKaGvvIjG4k8=;
        b=TICv+HZkU8Xu+HqlN2R3bOUCDLeXBlj2kftVSZG6whH26CzcvvjEFZqBXLRBAN6yyF
         S8tVIbdCQKYa+Est8TOmBAhsUMDbktX3XuERhrrum2M/JX3D+41TIUD/ceTPkrzRn6qa
         KLcQ3xxve7L7a9WOnfLyP3LRj6vjIi1wvARty29oHnPQ25izwzwP2Mo2J5qNq8xm9/we
         4HL4uZSX8T8s6DMoxlnp6poTF9IwgEsUYPss56qUNHzq58iVOnN7WrDG0Ea+2V888er8
         egHaHtUPFpBUFwU4OM5zgZDja64o3KR2GAqrAt2hHEhxNO9zCVhxpSq7hf+oMuz3I5Zw
         Z7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6S7D1kLbPR8nwVu8abO/u7ZUz14YEALKPFNxX5AkAEFkGNsFXC4IB7oSmNLVlKvQpy7Fvpmlu52BP7BqKoJTmNpMz2kNv
X-Gm-Message-State: AOJu0YwZBkupO+oF1kZgHw6mDdvtB+q5TAEhvHA6wUOYSMvkCFL9TGK2
	pvIr1KC7HqUcQym6/w6DB2HmW4ZCz6NycNAZYzB0uPjtIoWs/eN+qw94hQ0ypU0hyJwx9/Tlw4S
	Q8JKbR+dfxY4akZ+bn76RkPcv+wl/6UKKzmQ3NeurnLKoFG9WCPtyBw==
X-Received: by 2002:a5d:698d:0:b0:367:2945:4093 with SMTP id ffacd0b85a97d-36d60e02be0mr1202067f8f.40.1723211359475;
        Fri, 09 Aug 2024 06:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Fgphr0/ew/M2B4tBgNWlZeDwEwZSalcRlUdkd7YL6a8ZmcYF/N612CunYj90VETw7tXQQg==
X-Received: by 2002:a5d:698d:0:b0:367:2945:4093 with SMTP id ffacd0b85a97d-36d60e02be0mr1202041f8f.40.1723211358986;
        Fri, 09 Aug 2024 06:49:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718a4edsm5371991f8f.53.2024.08.09.06.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:49:18 -0700 (PDT)
Message-ID: <17712a89-58bb-4e1a-99bb-9571a6dbfbad@redhat.com>
Date: Fri, 9 Aug 2024 15:49:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
To: Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
 <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com>
 <874j7uyvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <6233DD66-9A2E-4885-875D-1E79179146D7@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6233DD66-9A2E-4885-875D-1E79179146D7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Hi Andrew,
> 
> Can you fold the fixup below to this patch? Thanks.

It might be reasonable to send out a new version. At least I am confused 
now what the latest state is :D

-- 
Cheers,

David / dhildenb



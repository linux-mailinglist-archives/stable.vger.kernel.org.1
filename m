Return-Path: <stable+bounces-189177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E36C03F85
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9982F4E01D7
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DA7E110;
	Fri, 24 Oct 2025 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DfLaWJ72"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845932AD25;
	Fri, 24 Oct 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266827; cv=none; b=bhLXOvzD+ASYg7Qvjo17V6pURilORUeghu1udpKHLQ21vbRpffrsBQRVXL6OghfpRnC+ij2cz1/QGlpPl4YK5Sr2JhnnTxzgOOJWdOutmuyvHA6bPzGUOCAu4bhIoSALCxnZbDLrLnh0lFb+X/SBrVkCLU6AJSyECgkbtlEGfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266827; c=relaxed/simple;
	bh=1Komk46U4DDiqfl8LUDvzb6I5UokBYd0SRVPy7f13BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpf1wkUijzy/NVlqOFHUMw2lLRGtYJ6Mu8u/5DdgZjkhALadRTQTfGo2kHAnFTesg5mWwa0Br4lomSehQ7EqH8PVIRYdBkSo8waKU4VZ5hIagiSqVxsKr6WFN5Ncno8FEfwe1pNcwxM3oXAOLzeAG3n6wJ6BhgIh6wO6MwVLb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DfLaWJ72; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761266821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9qJamjzk22RA6jKfjKnU6G0J/c4HWnTcWAnWK01wqPs=;
	b=DfLaWJ72PrWDIU+dYST8GwvCzvGtTVIwnn3CVHRWNp8lSdNS+CLFXD6enIQKJe86YkHdBCRUiZ2Xk/UY0SS9+h+rg30JlwZ55ulnZZePpSzcWn/UPWkjMEaZaMAmZpDL927Cdm/Ne6X4+UOn+TSHX376Aj1QOs0KHThwe02XSw8=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqsGyEe_1761266819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 08:46:59 +0800
Message-ID: <6a0cd943-a3cf-41fe-b666-47d250413a77@linux.alibaba.com>
Date: Fri, 24 Oct 2025 08:46:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Dev Jain <dev.jain@arm.com>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20251023065913.36925-1-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251023065913.36925-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/23 14:59, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The order check and fallback loop is updating the index value on every
> loop, this will cause the index to be wrongly aligned by a larger value
> while the loop shrinks the order.
> 
> This may result in inserting and returning a folio of the wrong index
> and cause data corruption with some userspace workloads [1].
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


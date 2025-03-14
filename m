Return-Path: <stable+bounces-124434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7982AA611D6
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 13:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD7462299
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0A1FF5EB;
	Fri, 14 Mar 2025 12:57:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC71FF1B5;
	Fri, 14 Mar 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957072; cv=none; b=jxWz1t48Rx61ckqPC/BfCBPonwqzOfYR7+ezVhQXA0kGnz14whXiNoNXSCvVcNeLI9ZtPsG56fO+uwIlElI3NKqGPzuooqmcHeQ7nzqz3XB6lTMxOvZIMYxhOZG3d5knSxDQ/8K7UDewYtTdjs5hm1Ps7lpHu1SrOcGW9QavQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957072; c=relaxed/simple;
	bh=RcOkYDUv35MvE/uLyzwk8BISRxmfvXl5ufdaRavJsRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0PH+ekxj9IJ8dxIvPMBqxyaqP59JBpcm+EtGo6//8SApiJkLfkjLeb94ZOlxiL6fUwM/lB2BTVceKjmuO0KNrSHJg26Fix+QSRL86SL6b4oiL78kLbvzm2CXzDzs6fqBBahuYabIEQujZ4uj3nifh/Pi6wAwolIOOTx0pwDlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810651424;
	Fri, 14 Mar 2025 05:57:59 -0700 (PDT)
Received: from [10.174.36.208] (unknown [10.174.36.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9322F3F673;
	Fri, 14 Mar 2025 05:57:46 -0700 (PDT)
Message-ID: <acba6a71-4ee8-445a-aae9-822f88079cb3@arm.com>
Date: Fri, 14 Mar 2025 18:27:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Update mask post pxd_clear_bad()
To: Matthew Wilcox <willy@infradead.org>
Cc: jroedel@suse.de, akpm@linux-foundation.org, ryan.roberts@arm.com,
 david@redhat.com, hch@lst.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250313181414.78512-1-dev.jain@arm.com>
 <Z9NDkFzSj-vnvGOy@casper.infradead.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z9NDkFzSj-vnvGOy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/25 2:14 am, Matthew Wilcox wrote:
> On Thu, Mar 13, 2025 at 11:44:14PM +0530, Dev Jain wrote:
>> Since pxd_clear_bad() is an operation changing the state of the page tables,
>> we should call arch_sync_kernel_mappings() post this.
> 
> Could you explain why?  What effect does not calling
> arch_sync_kernel_mappings() have in this case?

Apologies, I again forgot to explain the userspace effect.
I just found this by code inspection, using the logic the fixes commit 
uses: we should sync when we change the pxd.

The question I have been pondering on is, what is the use of the 
pxd_bad() macros, when do we actually hit a bad state, and why don't we 
just trigger a BUG when we hit pxd_bad()?


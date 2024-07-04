Return-Path: <stable+bounces-57993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96925926CFC
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 03:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5120B284245
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C290C125;
	Thu,  4 Jul 2024 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="P+qp9KtA"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB64C83;
	Thu,  4 Jul 2024 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055710; cv=none; b=HGoEUz8+VVhtfX/rZDIqiQtbvjAkF0VRuw/fv+/YejiCoi7tRmdQ7E1AX9MPEIEqlCFrOEFMuktK+Pg5+B3TUSBGZ+RmJx1glu0LozGKUYXJLUIKaP+NJHxNd6V0+YzZ+aF+4e4wS/JhVKG5xeB6LpL6bNIYw/hh9PmR51LYYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055710; c=relaxed/simple;
	bh=hl7tqM8UQXxV1DLO1bxGWFM5khCBkNdB71K2vwf+aTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef9U9l+R0DanPZzKec7RMBL/KYXjCmT/drp6lV1Yxn0GYeH7UERtPE4x1shySDr/gSxpxIUBdDhhtUTLXedJk0KpdAOs0BAMp0G6RFWq7YOj9/7egcvh5VNvGVAAGAMKKjPwvygOthonqLM4F3Ovaj729kNMF5cb2XZBK1WovCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=P+qp9KtA; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Sgcsx2tAZ8g67PHUjM2qPlMmPPLYQP+xUO4tGYkjnSE=;
	b=P+qp9KtAzlzaJRFzGOFC5dFfksF1bzDSH0RdEEUMiRREHP3P84M+KuuJ06j++z
	Z+MxcG4I7XZjgA392Mi2izopvY/cdZKlDUo8s26mIw1tZbDKmbzT7oVuTXjOYxP5
	0zkom0hw0ly0QsgUc4+wJ7usd8qSl2Y5zO0CzmRfzCFFY=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3XziM84VmfbwtAQ--.20333S2;
	Thu, 04 Jul 2024 08:57:50 +0800 (CST)
Message-ID: <dea5afcf-be7d-4377-8b95-754c2f0245c4@126.com>
Date: Thu, 4 Jul 2024 08:57:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
 aneesh.kumar@linux.ibm.com, liuzixing@hygon.cn
References: <1720008153-16035-1-git-send-email-yangge1116@126.com>
 <20240703130843.ad421344a0f3f05564a7f706@linux-foundation.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20240703130843.ad421344a0f3f05564a7f706@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XziM84VmfbwtAQ--.20333S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWxXrWUtFyUGr1UGr48WFg_yoW8ZFW8pF
	4xJ3W3trWDX3WSkrs7J398ur1Syrs2yr45Jr13Ar1UCwn8Wr12v3y8KF1DW3W3CrWYgF1Y
	vr4UWwn3ua1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjLvtUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQwRG2VLbI9L5QADs-



在 2024/7/4 4:08, Andrew Morton 写道:
> On Wed,  3 Jul 2024 20:02:33 +0800 yangge1116@126.com wrote:
> 
>> From: yangge <yangge1116@126.com>
>>
>> If a large number of CMA memory are configured in system (for example, the
>> CMA memory accounts for 50% of the system memory), starting a virtual
>> virtual machine with device passthrough, it will
>> call pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory.
>> Normally if a page is present and in CMA area, pin_user_pages_remote()
>> will migrate the page from CMA area to non-CMA area because of
>> FOLL_LONGTERM flag. But the current code will cause the migration failure
>> due to unexpected page refcounts, and eventually cause the virtual machine
>> fail to start.
>>
>> If a page is added in LRU batch, its refcount increases one, remove the
>> page from LRU batch decreases one. Page migration requires the page is not
>> referenced by others except page mapping. Before migrating a page, we
>> should try to drain the page from LRU batch in case the page is in it,
>> however, folio_test_lru() is not sufficient to tell whether the page is
>> in LRU batch or not, if the page is in LRU batch, the migration will fail.
>>
>> To solve the problem above, we modify the logic of adding to LRU batch.
>> Before adding a page to LRU batch, we clear the LRU flag of the page so
>> that we can check whether the page is in LRU batch by folio_test_lru(page).
>> Seems making the LRU flag of the page invisible a long time is no problem,
>> because a new page is allocated from buddy and added to the lru batch,
>> its LRU flag is also not visible for a long time.
>>
> 
> Thanks.
> 
> I'll add this to the mm-hotfixes branch for additional testing.  Please
> continue to work with David on the changelog enhancements.
> 
> In mm-hotfixes I'd expect to send it to Linus next week.  I could move
> it into mm-unstable (then mm-stable) for merging into 6.11-rc1.  This
> is for additional testing time - it will still be backported into
> earlier kernels.  We can do this with any patch.

Ok, thanks.



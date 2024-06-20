Return-Path: <stable+bounces-54679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6939690FAC7
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 03:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512B21C217E0
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 01:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B9BA42;
	Thu, 20 Jun 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cEn3jweA"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21F19B;
	Thu, 20 Jun 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845700; cv=none; b=o9mW23thVaDVLVJLeKWPf3SZUU1wgRldtkciwV+zB7vX0d/ukhn/HOQfW+2nS1SbwDRup1vcTEzfgAJKzWFLJEaudfCZd0LL4l0SPNCibte1B3PIGXvz8u5PgjhX2NZim69dp+HESKy5GO/IEXFHcW30K1nFL6llnRed2UhvsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845700; c=relaxed/simple;
	bh=QLkh1CGvArjVy2L7mMQBKKJRBWIDir9p3jyEmpL6JkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPTOjEynziZjodlZga3Zq6W6+DrjBNSOsDs8QTYB9gPxFL7XBc8PKix7q5CFIi0m2nOQ/yE2VcsuS/WojndLWdXoDNA90KGwG4cjpKsuiGQEs1X3REA11R6xs0pKX8cErU0mNZpwwxtgTngLzLpeXqpfIpPqlTReVeoIBtCX/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cEn3jweA; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=HI9YJTlJ4LWCuWr4QsGD88gYqR5a+RaxutAhRnm+t6c=;
	b=cEn3jweAe4M046Pc9ML117T86J/Rleukt5TQTwye/7iVBLJ+3Zz/QxgjDuF6Sj
	+GvNNatP8ES8u4eWWQF1Y/9O4T4zWPFDOMBa9R/9Ic6zE/NdQA8ogyJPw3mZYJ/R
	3hDgdnVU1Wyevvh/YtPLCGWBZBZU+hW24VsAZr7FJAsmo=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD336figHNmqgS3AA--.54731S2;
	Thu, 20 Jun 2024 09:07:47 +0800 (CST)
Message-ID: <e722fc40-336f-4994-929e-ced1698cff03@126.com>
Date: Thu, 20 Jun 2024 09:07:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 mgorman@techsingularity.net, liuzixing@hygon.cn
References: <1718801672-30152-1-git-send-email-yangge1116@126.com>
 <20240619180149.c043cce3f1f84db02fe24f5f@linux-foundation.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20240619180149.c043cce3f1f84db02fe24f5f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD336figHNmqgS3AA--.54731S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF43Kw4xZr1DJFy8tr4ruFg_yoW8Gw43pF
	W8Jw4Yy3y2y392kws2y3Z5ur109as7CrW8Jr9YvFn09rsxuFy293y0yryqq3W3uryDtw1j
	qry0g3ZxuF4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9GYJUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgQEG2VEw5fx2QAAs8



在 2024/6/20 9:01, Andrew Morton 写道:
> On Wed, 19 Jun 2024 20:54:32 +0800 yangge1116@126.com wrote:
> 
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>> THP-sized allocations") no longer differentiates the migration type
>> of pages in THP-sized PCP list, it's possible that non-movable
>> allocation requests may get a CMA page from the list, in some cases,
>> it's not acceptable.
>>
>> If a large number of CMA memory are configured in system (for
>> example, the CMA memory accounts for 50% of the system memory),
>> starting a virtual machine with device passthrough will get stuck.
>> During starting the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
>> if a page is present and in CMA area, pin_user_pages_remote() will
>> migrate the page from CMA area to non-CMA area because of
>> FOLL_LONGTERM flag. But if non-movable allocation requests return
>> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
>> page to another CMA page, which will fail to pass the check in
>> check_and_migrate_movable_pages() and cause migration endless.
>> Call trace:
> 
> Thanks.  I'll add this for testing - please send us a new version which
> addresses Barry's comments.

Ok, thanks.
New version: 
https://lore.kernel.org/lkml/1718845190-4456-1-git-send-email-yangge1116@126.com/




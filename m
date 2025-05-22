Return-Path: <stable+bounces-146031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA463AC045D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39484A2126E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933F221558;
	Thu, 22 May 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hd3ultRN"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175618DF8D;
	Thu, 22 May 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894007; cv=none; b=XweuIRobc5eM8yRl+S1c6QjvtYb8GHcecnnr8mjqpjCU72Axuu33YdPftWJkBd7yrLi3RGhkJzRHbQsoh8stt/YoZKLI5Kbp+mDixil8jIKBDGaa2PX3/socjKJnDQPqlv/nAjdhLtpQgyIdpz1f4y/kc6+9mgAT3DKMiF8ZJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894007; c=relaxed/simple;
	bh=Z3YZFGmPBzJHEaJVNcW8djQNlO87YEyMwv+EAvcvit4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFU9dVb24JnBjJyGPnK1GX0R2AvZH7G6afRNFTSiFmd4y3RfMpcFgN+StmZkQkub/9s4g/+3DNRE7gzz9ClPuTREGrf1c0EijVRsciB+/ZC8k58xEbkWi2dZR/iA+a3saujnrzgV9vHLBmeJEj1ulWJh8twtEU4T6QlI0cW3xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hd3ultRN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fC19oiaKeGnojTcsm4F/+x8uFxZCpfc6ssD2dhIHz+4=; b=hd3ultRN0ZjPGZyUCQpQiZnuMO
	2ZCbjwQFgVawO/XWqbvfmhbSwE+hQViRQ36KyIzVPsI8xaGhXtQWpQ7TMDSP+eWTdm4Vf6+lIaDwV
	7uGD+OCETcQP9/tUyEsMYWYgU6wmMd7o8DQ3LqF4ct8v2v05Nv/EzigVN9WISndwul5AMVOBAN5VC
	W+ekDIfHCO/HElAkD/271cmgAskul2rGPwCFZ9IDfTU9YnOcordOMbUAjWslDor+JuEg2fDCa3i2S
	xjOUxgbJ7KfFM+sC6DQ8VpDcvP89Dg67eFscxfNbqyL4zNE1G3kaeFD0KoQH/yTuYay4FQUHJia9C
	U/cRKbBw==;
Received: from 27-52-199-242.adsl.fetnet.net ([27.52.199.242] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uHz4f-00BZi6-Ez; Thu, 22 May 2025 08:06:37 +0200
Message-ID: <64ca8b7f-2b1f-40e8-b314-d59a3094d99f@igalia.com>
Date: Thu, 22 May 2025 14:06:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
To: Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 akpm@linux-foundation.org, kernel-dev@igalia.com, stable@vger.kernel.org,
 Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
References: <20250521115727.2202284-1-gavinguo@igalia.com>
 <30681817-6820-6b43-1f39-065c5f1b3596@google.com>
 <aC33A65HFJOSO1_R@localhost.localdomain>
 <54bd3d6c-d763-ae09-6ee2-7ef192a97ca9@google.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <54bd3d6c-d763-ae09-6ee2-7ef192a97ca9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 23:58, Hugh Dickins wrote:
> On Wed, 21 May 2025, Oscar Salvador wrote:
>> On Wed, May 21, 2025 at 08:10:46AM -0700, Hugh Dickins wrote:
>>> Unless you have a very strong argument why this folio is invisible to
>>> the rest of the world, including speculative accessors like compaction
>>> (and the name "pagecache_folio" suggests very much the reverse): the
>>> pattern of unlocking a lock when you see it locked is like (or worse
>>> than) having no locking at all - it is potentially unlocking someone
>>> else's lock.
>>
>> hugetlb_fault() locks 'pagecache_folio' and unlocks it after returning
>> from hugetlb_wp().
>> This patch introduces the possibility that hugetlb_wp() can also unlock it for
>> the reasons explained.
>> So, when hugetlb_wp() returns back to hugetlb_fault(), we
>>
>> 1) either still hold the lock (because hugetlb_fault() took it)
>> 2) or we do not anymore because hugetlb_wp() unlocked it for us.
>>
>> So it is not that we are unlocking anything blindly, because if the lock
>> is still 'taken' (folio_test_locked() returned true) it is because we,
>> hugetlb_fault() took it and we are still holding it.
> 
> If we unlocked it, anyone else could have taken it immediately after.
> 
> Hugh
> _______________________________________________
> Kernel-dev mailing list -- kernel-dev@igalia.com
> To unsubscribe send an email to kernel-dev-leave@igalia.com

Sigh, I should have thought of that as well. Next time, I'll be more 
careful.


Return-Path: <stable+bounces-183296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE9BB7923
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC6C734702D
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C452C1594;
	Fri,  3 Oct 2025 16:36:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B472C1590;
	Fri,  3 Oct 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509389; cv=none; b=Haq5TCqnDG/VrSWaZqk4q3pv7xLA3kw1SlWg4ypCb3Zf3fA4gQH8UzTFSlN9v6g4P8F5tcwHqiK/4RtqofEuXRMfVrvgyqt9Ps3DbtUmGvjJ3zzaycpLAa5z/o669zm1Y8KyJp1KYMJapGBmasq15ee06zH8xQTT6pOCGysbfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509389; c=relaxed/simple;
	bh=OCfs19P87VGJo08ZZgcfZKtGbh0uMUtCCXPiocshtKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ17/tqxWhZKVVtLrZlUERCqCHeeizDiDq9pU1evniYqKx0NpBWQCuOwAvdrIJjnkTintD/VktxWCBFLOb67FCe2ED9trlx3d1EefJ+bUtcKnCbOqNU3XiV5H7jQvTvpSCSZU6j/xtSBcNIY51j0FQWoDxCbhOTbn1JrHJ6IBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC161688;
	Fri,  3 Oct 2025 09:36:19 -0700 (PDT)
Received: from [10.57.81.90] (unknown [10.57.81.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D673F5A1;
	Fri,  3 Oct 2025 09:36:25 -0700 (PDT)
Message-ID: <76cd6212-c85f-4337-99cf-67824c3abee7@arm.com>
Date: Fri, 3 Oct 2025 17:36:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Content-Language: en-GB
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <nf7khbu44jzcmyx7wz3ala6ukc2iimf4vej7ffgnezpiosvxal@celav5yumfgw>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <nf7khbu44jzcmyx7wz3ala6ukc2iimf4vej7ffgnezpiosvxal@celav5yumfgw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2025 17:00, Kiryl Shutsemau wrote:
> On Fri, Oct 03, 2025 at 04:52:36PM +0100, Ryan Roberts wrote:
>> fsnotify_mmap_perm() requires a byte offset for the file about to be
>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
>> Previously the conversion was done incorrectly so let's fix it, being
>> careful not to overflow on 32-bit platforms.
>>
>> Discovered during code review.
> 
> Heh. Just submitted fix for the same issue:
> 
> https://lore.kernel.org/all/20251003155804.1571242-1-kirill@shutemov.name/T/#u
> 

Ha... great minds...

I notice that for your version you're just doing "pgoff << PAGE_SHIFT" without
casting pgoff.

I'm not sure if that is safe?

pgoff is unsigned long (so 32 bits on 32 bit systems). loff_t is unsigned long
long (so always 64 bits). So is it possible that you shift off the end of 32
bits and lose those bits without a cast to loff_t first?

TBH my knowledge of the exact rules is shaky...


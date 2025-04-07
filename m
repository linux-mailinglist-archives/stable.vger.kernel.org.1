Return-Path: <stable+bounces-128430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EFA7D15C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6289188A745
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A8EEB1;
	Mon,  7 Apr 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="XhqPwRvR"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306B635;
	Mon,  7 Apr 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743987233; cv=none; b=q9pvwFhr4eW+1rrv9ZHdK0uHcqLCta+RWGn6loAZxnAbY3qldUd2AsZeVtqqeB6qJOBOfKbUnuun+VTMSBSqq9zwFWPmlUuS6CAPcieXXGlYeCzznUHDUDmcdTXAlUZvsFuygbgCiA45g94ANujEVBkA1/OyBPzN+8Xev26uBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743987233; c=relaxed/simple;
	bh=+z+6RvwAvk13OKStinfuWh26FMpU43Q7rwCeXtF8zDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZSnvUy7aUl+rXqdv+4YcwNXKCUZpIKdIRIn7IsC+mSSTcVeg5ZRvfcrZ0K+Ww4NbKVSthfjwnPaaOUB0q/1vKhKvATbyfTyfoRA7ODsfiIaVr8dBFbaron1Zhebv+4QHcJY0La252DSIFSrh8oV5oxzMIzf49hD18qP8MlMa3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=XhqPwRvR; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Message-ID: <78346ff0-d5ee-48f0-ac4d-762a5ec18eb7@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743987228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqzKPwjBEqTWc3+AHr/Ab/QHxnuhXQXBI13sdLNF00Q=;
	b=XhqPwRvRf0YcBHYX9HDnwKhSVrrxPJSKO4ltQKkHQ4k9BaJ3nr7IYuBpZm2mZvNr6EIjsU
	Q5whO0c435pZIawkpnEraWXxlI+vdzR/JCda5MOx42+Frzhj3Ea1fUFiMTr31ZVul/doHY
	IxtOTJTbkAScsqs/V4av6Fpcusb3xy86Qr75BAFPcP6l+gWssJfTRZZSJWKheVztXGkrzE
	w6C8vfsGN4lultLoMFQUaMGM4pr0lZmXeeg5To6Pxp2pxW+/ZEKBNJ1753oA9bcN9tAqWT
	+YCx2AowlfsbMoqNrVFSAYgGzkgVTiBI+I0XFNd/fIAp1hZ2UsGMoBMDAM8d2w==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Mon, 7 Apr 2025 07:53:42 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Subject: Re: [PATCH v3] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Roberto Ricci <io@r-ricci.it>
References: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
 <Z_LGqgUhDrTmzj5r@gmail.com> <Z_LJv9gATY6nk4Yu@gmail.com>
Content-Language: en-US
In-Reply-To: <Z_LJv9gATY6nk4Yu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 4/7/25 01:36, Ingo Molnar wrote:

> * Ingo Molnar<mingo@kernel.org> wrote:
>
>> * Myrrh Periwinkle<myrrhperiwinkle@qtmlabs.xyz> wrote:
>>
>>> The current implementation of e820__register_nosave_regions suffers from
>>> multiple serious issues:
>>>   - The end of last region is tracked by PFN, causing it to find holes
>>>     that aren't there if two consecutive subpage regions are present
>>>   - The nosave PFN ranges derived from holes are rounded out (instead of
>>>     rounded in) which makes it inconsistent with how explicitly reserved
>>>     regions are handled
>>>
>>> Fix this by:
>>>   - Treating reserved regions as if they were holes, to ensure consistent
>>>     handling (rounding out nosave PFN ranges is more correct as the
>>>     kernel does not use partial pages)
>>>   - Tracking the end of the last RAM region by address instead of pages
>>>     to detect holes more precisely
>>>
>>> Cc:stable@vger.kernel.org
>>> Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
>> So why is this SHA1 indicated as the root cause? AFAICS that commit
>> does nothing but cleanups, so it cannot cause such regressions.
> BTW.:
>
>   A) "It was the first random commit that seemed related, sry"
>   B) "It's a 15 years old bug, but I wanted to indicate a fresh, 8-year old bug to get this into -stable. Busted!"

You got me :) How did you know that this is a 15 years old bug? 
(although I didn't think the age of the bug a patch fixes would affect 
its chances of getting to -stable)

This specific revision was picked since it's the latest one that this 
patch can be straightforwardly applied to (there is a (trivial) merge 
conflict with -stable, though).

Later, I managed to track the buggy logic back to 1c10070a55a3 ("i386: 
do not restore reserved memory after hibernation"), which I believe is 
the very first occurrence of this bug. If you prefer, I can send a v4 
with a more correct Fixes: tag (or feel free to do so yourself when 
applying this patch).

> ... are perfectly fine answers in my book. :-)
>
> I'm glad about the fixes, I'm just curious how the Fixes tag came about.
>
> Thanks,
>
> 	Ingo

Regards,

Myrrh



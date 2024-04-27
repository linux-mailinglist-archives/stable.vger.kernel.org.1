Return-Path: <stable+bounces-41574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483D58B47B2
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A515B20EAE
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C241A88;
	Sat, 27 Apr 2024 19:38:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F72FB6
	for <stable@vger.kernel.org>; Sat, 27 Apr 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246734; cv=none; b=r8SNuzP2t5MKFgFfKfZo8Z3E4zYKJITIkerikVDXHHTOxKXhNfeG87S4yHZZcBSkds2CM+XWGGL5khqsdMievTagsdF9BlDshK4ldyaGG4GqiTYoE0jDkfg7+AAKwt5lLpk13r1jGAA9LEd+kpx/vSFjCg4X2Mb3nd4fM0+nPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246734; c=relaxed/simple;
	bh=v1+ZE2uyA6TekGXVo1wGcwErU907kS2bR6YdmBIJ+Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i809eBEhxDe9IQ5ZKFVgs/0f60So0SvxKEFdAKtx/sz3NBr9nW6hEj+5GW4y+iIlUmvuEG2V4mJud648ZRHtTcKchLJBdPZqgKsavEtXOGuus0AjqJV3zph/533+d/s4Uw0AnVA5qKuz9pfGtxtGIQQNeMlNACl9f81Yvk+rk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.30] (p4fee269d.dip0.t-ipconnect.de [79.238.38.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3282961E5FE06;
	Sat, 27 Apr 2024 21:37:42 +0200 (CEST)
Message-ID: <c7f4a6e8-8e29-4be6-9671-8b89d037c889@molgen.mpg.de>
Date: Sat, 27 Apr 2024 21:37:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 108/476] mm/sparsemem: fix race in accessing
 memory_section->usage
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Mel Gorman <mgorman@techsingularity.net>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>,
 it+linux@molgen.mpg.de
References: <20240221130007.738356493@linuxfoundation.org>
 <20240221130011.965182720@linuxfoundation.org>
 <d3adab65-b962-4530-886a-631f0faf1107@molgen.mpg.de>
 <2024042742--0602@gregkh>
Content-Language: en-US
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <2024042742--0602@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/24 16:24, Greg Kroah-Hartman wrote:
> On Thu, Apr 25, 2024 at 04:55:35PM +0200, Donald Buczek wrote:
>> Maybe this is already known, but just FYI I wanted to drop the note that for some
>> reasons I don't understand, this patch prevents me from compiling the proprietary
>> Nvidia Unix driver with versions 510.108.03 and 535.104.05 in the 5.15 series.
> 
> For obvious reasons, we do not, and can not, care one bit about closed
> source kernel modules or any other sort of kernel code that is outside
> of our kernel tree.  The companies involved in doing stuff like this
> take full responsibility for keeping their code up to date, all the
> while forcing you to be the one that violates the license of the kernel.
> 
> In other words, please ask them for support for stuff like this, they
> are the ones you are paying money to for support for this type of thing,
> and the ones that are putting you at risk of legal issues, and there's
> nothing that we could do about it even if we wanted to.

Really? Did I ask anything? Wasn't "just FYI" not clear enough? Maybe you
are not interested, but maybe somebody else is. And if you think my mail
is just noise, why did you reply at all?

Best

   Donald

> best of luck,
> 
> greg k-h

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


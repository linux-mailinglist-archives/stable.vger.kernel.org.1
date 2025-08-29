Return-Path: <stable+bounces-176696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C45B3B9DE
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C81BA084C4
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DB32D2498;
	Fri, 29 Aug 2025 11:21:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66590263F32
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466480; cv=none; b=FdoEP3hdORkA9SuGHsAJqH67Xehwk/+WKg0/I9GvfOq3uOP3QoIYk3TRfZUcgmOLtcGB860baj7iZ0oOyvVeX/ScNVfI3lGHqlmfIiYIc0dyoIiLbBj606mvg+/zDyHE4u9cEBu3B2Qwgr250RliXJRCtmzm2r8c8h6noqzmYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466480; c=relaxed/simple;
	bh=wrGXB3bQpPYd1i8k7VSV0E+aV/6DGOubyOJM3sJamkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTzHFMM9ZxnBlQSeysZd3GpIZDKGo+5VSLlHr93Cknt0RLFvQiNQcmVrZtYqcDvFCU+TAzEjM+Zp8nC/XP5NLc512VQDKYI+t8ca5r4m97DDQ3NaPirawbqBVuCUX/1HXv/1tKyTsefChnHKBDai3iUb/e/sKasFm7it/jsA7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <343ef596-0d4b-4554-874e-a40c2e61ee08@lankhorst.se>
Date: Fri, 29 Aug 2025 13:21:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, stable@vger.kernel.org
References: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
 <e8a176ab-a24c-4b9d-a046-ae386f08f129@lankhorst.se>
 <692711fadc25a6c85c19ae16e9c04e50f1eaa3a9.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <692711fadc25a6c85c19ae16e9c04e50f1eaa3a9.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2025-08-29 kl. 12:55, skrev Thomas Hellström:
> On Fri, 2025-08-29 at 09:42 +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> Den 2025-08-28 kl. 17:42, skrev Thomas Hellström:
>>> VRAM+TT bos that are evicted from VRAM to TT may remain in
>>> TT also after a revalidation following eviction or suspend.
>>>
>>> This manifests itself as applications becoming sluggish
>>> after buffer objects get evicted or after a resume from
>>> suspend or hibernation.
>>>
>>> If the bo supports placement in both VRAM and TT, and
>>> we are on DGFX, mark the TT placement as fallback. This means
>>> that it is tried only after VRAM + eviction.
>>>
>>> This flaw has probably been present since the xe module was
>>> upstreamed but use a Fixes: commit below where backporting is
>>> likely to be simple. For earlier versions we need to open-
>>> code the fallback algorithm in the driver.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
>>> Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags
>>> v6")
>> I'd say it this closes a bug in the original driver, although
>> effectively v6.8 is no longer supported anyway.
>>
>> Should DESIRED also be set on the add_vram flags?
> 
> It looks for me from the TTM code that TTM then *skips* the placement
> when doing a second pass with evictions.
> 
> So that's not really what we want IMO.
> Yeah, seems the flag name is a bit misleading, it's more of an opportunistic placement
when space is available.

Kind regards,
~Maarten Lankhorst


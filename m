Return-Path: <stable+bounces-189227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC4C05997
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957383BC9BA
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2630F93F;
	Fri, 24 Oct 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="CFyH7t4R"
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A23043AF;
	Fri, 24 Oct 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301658; cv=none; b=PlZ3AHCGeUlhtNc/MPFDdkVeE+4yArTUl5jpENysji/iyXNg+LM93UnWF5X4CUOXwEXA7k7NyrNWaMVO7etWqKVdayVSYu96BU7ZtIl6F/fMk5dO5cVqPAVCrxiy1ddvLItTFHcejW0JfJS4zJL53vS+vSw/GexorTA7asScCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301658; c=relaxed/simple;
	bh=qYI6HDh9a/ugUn/uKgtP6q9Z/KM2Dh1Vcc3ewzPmDwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+fRb4xJrWOtzvq4dXCxOgrf6gmRYTXGh7lSLEz0YCEc3GC/6okJ5H4L2ynCIHyKgrlSwOcKKPlm4AeyhGKEj5MhDb1JCP2WjPPxjJCOK0eh60zcA81M0avGa/NJKUntfS51sOcgs3Acel3rwBFQwuLkhyGV+nZZD9nW6JZLZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=CFyH7t4R; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1761301654;
	bh=qYI6HDh9a/ugUn/uKgtP6q9Z/KM2Dh1Vcc3ewzPmDwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFyH7t4REHmQ+bj3mjN5XCQGi82PIbBbGwpJw1gyGLMRiYuuPpxBE0uCte0wdRjkD
	 IBhDCqyfZiYt0TSNFynmmbIl+wZSFTQmB+SjmJSyNHad81BeiFtztIdm5QHlYgkHpc
	 dFp4sNCHhlfe5EKFk7YeLzJeUVDd+helbnrouh40vxloxHS9vg5rMKQGZVGZM6s2yk
	 iahFeVjlN75UN9LpghgqPb9v2ZloO1Tus9r606xwRwMh3xivWnDZzMtzYuSXM/W9SM
	 B3NNEL8KuUNL3mKiSYKbcpoCFGflhKz0JYjou+4PBpWnwmUsIet54ScleOY5mjFgr4
	 qa4pdzgYZjNuA==
Message-ID: <f3398dd1-0d69-4db6-9bfc-ed3c6fe92ab5@lankhorst.se>
Date: Fri, 24 Oct 2025 12:27:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devcoredump: Fix circular locking dependency with
 devcd->mutex.
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org, Mukesh Ojha <quic_mojha@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>
References: <20250723142416.1020423-1-dev@lankhorst.se>
 <e683355a9a9f700d98ae0a057063a975bb11fadc.camel@sipsolutions.net>
 <c4bd0ddb-4104-4074-b04a-27577afeaa46@lankhorst.se>
 <247568f47e1955be454e951e80a9063123f97c66.camel@sipsolutions.net>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <247568f47e1955be454e951e80a9063123f97c66.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-10-24 kl. 10:39, skrev Johannes Berg:
> On Fri, 2025-10-24 at 10:37 +0200, Maarten Lankhorst wrote:
>>>
>>> CPU 0				CPU 1
>>>
>>> dev_coredump_put()		devcd_del()
>>>  -> devcd_free()
>>>    -> locked
>>>      -> !deleted
>>>      -> __devcd_del()
>>> 				-> __devcd_del()
>>>
>>> no?
>>>
>>> johannes
>>
>>
>> Yeah don't you love the races in the design? All intricate and subtle.
> 
> :)
> 
>> In this case it's handled by disable_delayed_work_sync(),
>> which waits for devcd_del() to be completed. devcd_del is called from the workqueue,
>> and the first step devcd_free does is calling disable_delayed_work_sync, which means
>> devcd_del() either fully completed or was not run at all.
> 
> Oh... right, I totally missed the _sync. My bad, sorry.
> 
> I guess I really should say
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> since I finally _did_ review it carefully. Sorry it took forever.
> 
> johannes
No worries. It's an extremely tricky and prone to races part of code especially with the various ways a coredump can be destroyed.

I almost replied with another potential bug, calling read() after calling write(), but that's worked around by the reference
kept on the devcd device.

Kind regards,
~Maarten Lankhorst


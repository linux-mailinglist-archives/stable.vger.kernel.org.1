Return-Path: <stable+bounces-181618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89456B9ADF4
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874497ADA4D
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92153128DE;
	Wed, 24 Sep 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv4cs34/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A430B527;
	Wed, 24 Sep 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731091; cv=none; b=hTMzFv59WW9GDjql6FVvZ/Ldo+FUuswEaZmUCIWjeIKPnDjVBs/SCraZH6mY2ljKNYdSlV8pI6K2A6GlGfL6ASPf0pXRNPiEjgPc82BPHguRVbhTvjV87uBJy87U0VO59jeo6dtgi3m6N7WOvxsGCZH91vQyDS23NT+vaRVT7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731091; c=relaxed/simple;
	bh=YDQXTVGOYTWva8EDpEwYuBr0RgnUKG4x/JRMrHY45WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYR1ruZzyxZjLK/CuI7057Sc7XU+UQLgD1tfctbnFFwz43Yh1EwimOAcO3b6dklvdW+gjx24Kfsng96A3cZ9SdnApO+9k4uikk8HZ6PAoen/P24ovJEf/PRQ/sJEJ06qNCAPA4A3ZAI181K5r62JAcFWpqmr5gDBYj0F0apyyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv4cs34/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629B9C4CEE7;
	Wed, 24 Sep 2025 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758731091;
	bh=YDQXTVGOYTWva8EDpEwYuBr0RgnUKG4x/JRMrHY45WA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rv4cs34/Qim8+evoo8ovxwouSo7ZGm3TI9LuDHjLvPp+9BNsAW86i5ETDW2z9zgbS
	 t1jCkRpP3DUkUTDh/pkjL6LwA58lCk3aAbmFSPmU+fs70OS8Ja80hE4+ougHuXWAdx
	 a8vFkzPrjcaO1uCAFBl37t3oCls0JUSZ0fuZn0l9N1EV531V1cnesgWHxjrkr1Hao8
	 r9rBsgtCOcl8qT7JR2g8zQ9SMGIHZ3sfQREqWI1i74rpoz0CvMeGDKWf/hLsg7wyNX
	 lpAuzlykFkUGgmFZxwgjHgnBF312aBL288V6fwXbKcCgN4y/GEpY5+nI93lu030Fht
	 FjJ6Fs4CbVVCA==
Message-ID: <38a9db70-c6dc-40f0-a506-942fb799fa86@kernel.org>
Date: Wed, 24 Sep 2025 11:24:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: take system_transition_mutex on suspend
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
References: <20250921162853.223116-1-marmarek@invisiblethingslab.com>
 <a8d1d076-81b0-424e-b281-dfbd49130d38@suse.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <a8d1d076-81b0-424e-b281-dfbd49130d38@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 1:06 AM, Jürgen Groß wrote:
> On 21.09.25 18:28, Marek Marczykowski-Górecki wrote:
>> Xen's do_suspend() calls dpm_suspend_start() without taking required
>> system_transition_mutex. Since 12ffc3b1513eb moved the
>> pm_restrict_gfp_mask() call, not taking that mutex results in a WARN.
>>
>> Take the mutex in do_suspend(), and use mutex_trylock() to follow
>> how enter_state() does this.
>>
>> Suggested-by: Jürgen Groß <jgross@suse.com>
>> Fixes: 12ffc3b1513eb "PM: Restrict swap use to later in the suspend 
>> sequence"
>> Link: https://lore.kernel.org/xen-devel/aKiBJeqsYx_4Top5@mail-itl/
>> Signed-off-by: Marek Marczykowski-Górecki 
>> <marmarek@invisiblethingslab.com>
>> Cc: stable@vger.kernel.org # v6.16+
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> 
> Juergen

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>


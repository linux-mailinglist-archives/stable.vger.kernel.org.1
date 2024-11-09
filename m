Return-Path: <stable+bounces-92024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1085F9C2E90
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A039281B48
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED51741D2;
	Sat,  9 Nov 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdPcQH/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7E233D7D
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170922; cv=none; b=rm5UxkivqW0eL8XCktmWoMDMrc++nq/BHGDy3DwGiMaoR6AWalDHQZyiEcm4hkXjkRr96iNEztLglNrhtoMENd31WEerCxpAwCicl4tVVprUwnY9c54L7w5AvY2/tjyEyY94qNMfb0/iuyEg1/5y0TsNlJnoZ2335IMfAUB/wgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170922; c=relaxed/simple;
	bh=+J9fMp7kLunYZrOmbSmQDR1fR8VFwwqT55wtqL1A1F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucck4wQ0mZ8uezZFyD6pNGMG98F+ROzBCUT2ceEFSOUCXV9y6moSDCY/4BedEqJHwtCaWorQ2WfPZt5iKel2HDSzg0MdClhrcQYrkU7cRh/rYJ8YB9+FJDiyjBiConYS5hqYwZPrWTezMo6FVOZHwZ59tuDBowKOR6XcVOOs658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdPcQH/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD3C4CECE;
	Sat,  9 Nov 2024 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731170921;
	bh=+J9fMp7kLunYZrOmbSmQDR1fR8VFwwqT55wtqL1A1F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CdPcQH/Jo/hoPK9oD3s4Kn5QRcNGh6j4j/s4FZbIrbWDpLhEtCcZK6Dc86/7uvcOT
	 9oyZ3ggG89MhdjcvxAEBMEn3zO+0tDA02ejUiL+K0Kc9+k92YHK+BbZh2JBJKLKux4
	 vcudSg7UwkSlbYtmHjsoSb3Zr1UlUk1e/zNKNXYTknZXdBjnPuXH6kdsIhGGvKZ+TB
	 e0FHqm3vIasSlWQPfws9AJlut1DwbZAEr5LMUyl3hP2A9VrNuPiD0T+O4WO3R50qsB
	 raJa24M+IFr94QoOiwhAKGD6sOIpsCrLa/fjkpYkATtdZTQ5iRtjOWyTgPFCpXEXJN
	 m5qbBuANBwjxA==
Message-ID: <da9f1725-01b8-4630-a768-82800f1cc08a@kernel.org>
Date: Sat, 9 Nov 2024 10:48:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD PMF on 6.11.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Gong, Richard" <Richard.Gong@amd.com>
References: <478eac36-fc71-4564-959c-422da304f139@kernel.org>
 <2024110903-previous-sequel-5a74@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2024110903-previous-sequel-5a74@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/24 09:30, Greg KH wrote:
> On Wed, Nov 06, 2024 at 11:52:58PM -0600, Mario Limonciello wrote:
>> Hi,
>>
>> 6.11 already supports most functionality of AMD family 0x1a model 0x60, but
>> the amd-pmf driver doesn't load due to a missing device ID.
>>
>> The device ID was added in 6.12 with:
>>
>> commit 8ca8d07857c69 ("platform/x86/amd/pmf: Add SMU metrics table support
>> for 1Ah family 60h model")
>>
>> Can this please come back to 6.11.y to enable it more widely?
> 
> I would be glad to, but it does not apply cleanly, are you sure you
> tried this?
> 
> thanks,
> 
> greg k-h

Whoops! I had thought we had the context changes already in 6.11.y and 
got fooled by the one line change.

Here's the correct series.

commit 375780541739 ("platform/x86/amd/pmf: Relocate CPU ID macros to 
the PMF header")
commit 8f2407cb3f1e ("platform/x86/amd/pmf: Update SMU metrics table for 
1AH family series")
commit 8ca8d07857c6 ("platform/x86/amd/pmf: Add SMU metrics table 
support for 1Ah family 60h model")

Thanks,


Return-Path: <stable+bounces-23254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550585EC18
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9071F24627
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D64DA10;
	Wed, 21 Feb 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkbwImK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DA5232
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556312; cv=none; b=k12jM/HjLi30voPplQLZUTZKKrbY3RkcBw8/OjpEpNBFu29R2a9uOVXApO3B22tXSglGEnVWJi8naeXNtHutzejfywtCjBGIqM4KrVmmxpH18bp1RCIBphAU//Q+CcFnyJTzqPFcZztGnd4Hm4qZusDe5solO2TNcOHjmXLtdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556312; c=relaxed/simple;
	bh=6lfxiQew9dVR172DMq4/DrW3GgE+LPP7fDBb9+ixYvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfaj57Sqs+T5nvIKVD1bqjKipTefVFFxz5MKkhDtifwQaxNoN66H3vV3PyMgSkqdfYMrscG/77PDtGskssVYFUuF9kmkZjeFS029xU7/oJmLCrjPe2bxY29got2rFfzNqIjHMEX/2uzJAFEGHARbSyhRWIGBGiU9f4VRI+42SRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkbwImK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC7C433F1;
	Wed, 21 Feb 2024 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708556311;
	bh=6lfxiQew9dVR172DMq4/DrW3GgE+LPP7fDBb9+ixYvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkbwImK5cw+IYmeG09l+NAEjBgO1Mtcqe5ZtWqDsEm7yWZ1M31EN4p5vNZpS36ZCo
	 ukxCE7u6POPfY6N5x9oqKPRiojE9d3buCl74QxdpLBU5eUgaWzNATVM/SRRbNAN6xO
	 7NKrqNHZkErev/2Ahs4hPU7xn6N9AtSu+hT5jnAf5cOJufECxonZ2MtFiivl/KVKvo
	 QwSZmdVuP7vMrBMsdr40nhs7NG6JnDh1pCmTMTEeJvmuDKUvFh8gIguFP8quMsNr7Q
	 kXMB2mwoiqTt6TKpkiMZlqdu54cwRycJHPT0YH061kjZGh/uvboQwuiLxiQfvAjbdU
	 Rl+7xwOj8QRYw==
Date: Wed, 21 Feb 2024 17:58:30 -0500
From: Sasha Levin <sashal@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jiri Benc <jbenc@redhat.com>, stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <ZdaAFt_Isq9dGMtP@sashalap>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>

On Wed, Feb 21, 2024 at 07:10:02PM +0100, Vlastimil Babka wrote:
>On 2/21/24 18:57, Greg KH wrote:
>> On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
>>> On středa 21. února 2024 15:53:11 CET Greg KH wrote:
>>> > 	Given the huge patch volume that the stable tree manages (30-40 changes
>>> > 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
>>> > 	do something different only slows down everyone else.
>>>
>>> Lower down the volume then? Raise the bar for what gets backported?
>>> Stable kernel releases got unnecessarily big [1] (Jiří is in Cc).
>>> Those 40 changes a day cannot get a proper review. Each stable release
>>> tries to mimic -rc except -rc is in consistent state while "stable" is
>>> just a bunch of changes picked here and there.
>>
>> If you can point out any specific commits that we should not be taking,
>> please let us know.
>>
>> Personally I think we are not taking enough, and are still missing real
>> fixes.  Overall, this is only a very small % of what goes into Linus's
>> tree every day, so by that measure alone, we know we are missing things.
>
>What % of what goes into Linus's tree do you think fits within the rules
>stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
>"very small" would be my guess, so we should be fine as it is?
>
>Or are the rules actually still being observed? I doubt e.g. many of the
>AUTOSEL backports fit them? Should we rename the file to
>stable-rules-nonsense.rst?

Hey, I have an exercise for you which came up last week during the whole
CVE thing!

Take a look at a random LTS kernel (I picked 5.10), in particular at the
CVEs assigned to the kernel (in my case I relied on
https://github.com/nluedtke/linux_kernel_cves/blob/master/data/5.10/5.10_security.txt).

See how many of those actually have a stable@ tag to let us know that we
need to pull that commit. (spoiler alert: in the 5.10 case it was ~33%)

Do you have a better way for us to fish for the remaining 67%?

Yeah, some have a Fixes tag, (it's not in stable-kernel-rules.rst!), and
in the 5.10 case it would have helped with about half of the commits,
but even then - what do we do with the remaining half?

The argument you're making is in favor of just ignoring it until they
get a CVE assigned (and even then, would we take them if it goes against
stable-kernel-rules.rst?), but then we end up leaving users exposed for *years*
as evidenced by some CVEs.

So if we go with the current workflow, folks complain that we take too
many patches. If we were to lean strictly to what
stable-kernel-rules.rst says, we'd apparently miss most of the
(security) issues affecting users.

-- 
Thanks,
Sasha


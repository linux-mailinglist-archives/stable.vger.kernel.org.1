Return-Path: <stable+bounces-136770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C00A9DDC3
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 01:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0C5A7F5D
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91A1FE471;
	Sat, 26 Apr 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svwzx0gH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD41DE894;
	Sat, 26 Apr 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745710369; cv=none; b=fLPVrTzqzYq2C13IoEpwHuhOLcF7j5/wf+Qh4GmmSK1DLOmqorhdeBvr1BiTWIE8Hm26yAR+k4u0QCS6gI8NNN5G0fXblbioppmO2I1pMNAsXELDdhLRWSFi7Fg2rVPcfuXvKOepsmHKI+vFhCh5Cu8+z01qv8Y+7Mw4uu9Cu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745710369; c=relaxed/simple;
	bh=HEHvu5GjdB8AWR9ycyPuGWSOfm7YTudUOghZabE2+Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzy2lNuD5znF3zpY7K0aap7QroAMqF3NERg2Ut6/HYDEpSG6fKyZPF33jM87pe1DaEhRbmoiNQ8lQ8urG3h9HOheb62pwY9R6XVnZizMR54aL3oEXw3vKDFcmassMf4bwsvYymJRbmolS2h0dhcGPw9OFjoupgDlUfl2VdZbJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svwzx0gH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7DFC4CEE2;
	Sat, 26 Apr 2025 23:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745710369;
	bh=HEHvu5GjdB8AWR9ycyPuGWSOfm7YTudUOghZabE2+Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Svwzx0gHNETqnjwrdhSXHXMq4eYh2AtV7bQleGq3xu5Jjr6Pr18GprNALuT7NH8+h
	 QDvUIIklR3KKYNDXuTTXsrxUd2gi9ZAB59kAtTXGvoa8ZC5AtgA2Zixeq/cPT7r4R+
	 2PTBSTz7gkCC6dXAfJ2ik35YyLaPLJoRu2bZGwArGIBFwaKtsDz/Baa1kkBvuM8M24
	 BCHaH+OYnS5rNkzuGsHR+8nLdEnDHxWW9lGDmLPBi0Luyo5r/UvjpTDu6/5ZFbNbna
	 zHRjfMFFoed0qlFlFkHVp0KHG3rT+DYE7abojgrUPcTHQZzINH3syCHpm+nNeFvsQy
	 RQKYvzpKC/NMA==
Date: Sat, 26 Apr 2025 19:32:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP" has been added to the 6.14-stable tree
Message-ID: <aA1tH4vcHu4jzqnc@lappy>
References: <20250426132510.808646-1-sashal@kernel.org>
 <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>
 <20250426141107.GA3689756@ax162>
 <aAzzMJUz8Gh1uGnr@lappy>
 <20250426151248.GA2377568@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250426151248.GA2377568@ax162>

On Sat, Apr 26, 2025 at 11:12:48AM -0400, Nathan Chancellor wrote:
>On Sat, Apr 26, 2025 at 10:52:32AM -0400, Sasha Levin wrote:
>> On Sat, Apr 26, 2025 at 10:11:07AM -0400, Nathan Chancellor wrote:
>> > Sasha, it is a little insulting to me to have my manual backports
>> > ignored while you pull in extra unnecessary changes to make them apply
>>
>> Appologies: this is a case where some things falls through the cracks
>> between Greg and myself. Let me explain...
>>
>> Greg is usually picking up patches from the mailing list. I have the
>> annoying bot (which you might have seen) that tests backports folks send
>> over, but in reality I would rarely apply a backport someone sent over
>> (even if only so we won't step on each other's toes).
>>
>> On the other hand, I have some automation in place that after a few
>> days, it combs through the FAILED: mails that Greg sends out and will
>> attempt to automatically resolve conflicts by bringing in dependencies
>> and build testing the code.
>
>Maybe that automation could look to see if a patch has already been sent
>to the FAILED thread? Greg's instructions tell people to use
>'--in-reply-to' with the FAILED message ID so it would probably cover
>the vast majority of cases of manually backport.

Yeah, it could be improved like you've suggested.

One of the reasons I'm not tackling it yet is because it's a bit "old"
and I need to rework it to use the lore/lei infra we now have and I'm a
bit overloaded to try and tackle that.

I think that ignoring any "FAILED:" mails that have any replies makes
sense here.

>> I promise I haven't "manually" ignored your backports :)
>
>Sorry, I did not mean for that to sound as harsh and accusatory as it
>was and I appreciate the additional clarification around the process so
>that it can potentially be improved :) thanks for all the work you and
>Greg do.

No worries, thanks for the backports! :)

-- 
Thanks,
Sasha


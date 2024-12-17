Return-Path: <stable+bounces-104515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C99F4F35
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EA71882A30
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3221F7082;
	Tue, 17 Dec 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opg0E0sQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865141F7073;
	Tue, 17 Dec 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448652; cv=none; b=QbvyuDSmUZJLcDdxnXRacNvyf8R7u1fKzERU3M3++u7ztq9S1stwgpCauha91IwQ4XKrs0aDwydbQPObCEFP5D3EiBQuZTcQ+8s67KFi9KKAMVq/0KG/8gTtYOAtcxONAX9LG1m8Yb+Ax5RmOJTXlnGCva3U9yvfdEnb2f8ROb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448652; c=relaxed/simple;
	bh=8Wm0CEtvfU8kZ0Au4MITYjk+Fi7OtomyF/qVcCgGFgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8QhNptR1kpkRkUMNSjMCndmn9CDsdOyRjajARjIr+EklBoQ+wez/PlBuaoCS7tGTie5znOwxLJ6Pk+T/HV+xBZJ8Nu1BRqsEgTQC75c/IpVCkzlH08hrNBrYK7yxcl+FMV0S6tdNpE9rEXun4yynDona7DXfHN+zu+fJxbyG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opg0E0sQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B1C4CED3;
	Tue, 17 Dec 2024 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448652;
	bh=8Wm0CEtvfU8kZ0Au4MITYjk+Fi7OtomyF/qVcCgGFgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opg0E0sQeKc1SLRzVr9n+cAn/CQY5nce8SnhD9NiaunkYBGY1AgDVdqRkXaMrPGSu
	 8bF3jzZRMzVbikdM2vunI54LFioQr/TwulG/8ZtDD3JKFjoFfN9tO961XuyhQwf3/F
	 YbujLMffvEnAoR6A0fOT2pO1mDmHBd5HBbtkcj8saMcvLXE1YuxSVmU/W3SzAc/Ug0
	 kXjprWodU4/wWWia5dXORk6QCH4FU+VvMxjX88p0HFZjyn7dP5OQHFkiFpLLXbbD8R
	 WybJ7t39PnQe6ICxe1+B9Q577YUXLqPaoV0zLzIN0ur8+Nfh048mR1je0o76sd8nOE
	 +kKe2oMKCh2tg==
Date: Tue, 17 Dec 2024 10:17:30 -0500
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gustavo Padovan <gus@collabora.com>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	stable <stable@vger.kernel.org>,
	Engineering - Kernel <kernel@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Message-ID: <Z2GWCli0JpaRyTsp@lappy>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
 <2024121731-famine-vacate-c548@gregkh>
 <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
 <2024121700-spotless-alike-5455@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024121700-spotless-alike-5455@gregkh>

On Tue, Dec 17, 2024 at 03:49:53PM +0100, Greg KH wrote:
>On Tue, Dec 17, 2024 at 11:30:19AM -0300, Gustavo Padovan wrote:
>>
>>
>> ---- On Tue, 17 Dec 2024 11:15:58 -0300 Greg KH  wrote ---
>>
>>  > On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote:
>>  > > Hey Greg, Sasha,
>>  > >
>>  > >
>>  > > We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head.
>>  > >
>>  > > Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested.
>>  > >
>>  > > Is it possible to add 'X-KernelTest-Commit'?
>>  >
>>  > Not really, no.  When I create the -rc branches, I apply them from
>>  > quilt, push out the -rc branch, and then delete the branch locally,
>>  > never to be seen again.
>>  >
>>  > That branch is ONLY for systems that can not handle a quilt series, as
>>  > it gets rebased constantly and nothing there should ever be treated as
>>  > stable at all.
>>  >
>>  > So my systems don't even have that git id around in order to reference
>>  > it in an email, sorry.  Can't you all handle a quilt series?
>>
>> We have no support at all for quilt in KernelCI. The system pulls kernel
>> branches frequently from all the configured trees and build and test them,
>> so it does the same for stable-rc.
>>
>> Let me understand how quilt works before adding a more elaborated
>> answer here as I never used it before.
>
>Ok, in digging, I think I can save off the git id, as I do have it right
>_before_ I create the email.  If you don't do anything with quilt, I
>can try to add it, but for some reason I thought kernelci was handling
>quilt trees in the past.  Did this change?

What if we provide the SHA1 of the stable-queue commit instead? This
will allow us to rebuild the exact tree in question at any point in the
future.

-- 
Thanks,
Sasha


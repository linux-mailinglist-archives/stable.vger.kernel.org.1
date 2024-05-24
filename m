Return-Path: <stable+bounces-46058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E118CE4DB
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846D41F21721
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590F85930;
	Fri, 24 May 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="auxo9UDh"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDC53E31;
	Fri, 24 May 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550096; cv=none; b=my8fCUewBSiy8poEPeWHhyK2Gt6ZUMT+J0n8bcowPK8cLrGhls698QmrNfK7xqk6WMpOcnTKuSU2AXGNeJKHgroqdzO+dWrVrE34DOWtJJQd7X9uGgzGMkzbP81LOqCfbXj67Lb2Y3txJQ5wd0amlOcNNE9O/O7gKNWVRU6Gtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550096; c=relaxed/simple;
	bh=oHA9gc+CrTyin+zUK+uAT3gY9fGy7KJDCFi88foFCBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+lULIRYGxhPdEPkSzPFfdtKKj/V2Xt+Mg3XFs6BRR7O0P/Da8J0EnB8HX20PXVPFKNVqswywrh03kHXdjL6lGCU8OmGpsvp92dzXqo13rN2EoeF+FKedE8MnOzTqVKCzPy7X0dXKE4zqkjey9w/Mts8k0hUnjJiAbBSud7nSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=auxo9UDh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hcK9uKDg9sC6XHkeLqCJBgcdOFQUEGulh79bnSWYMao=;
	t=1716550095; x=1716982095; b=auxo9UDhDQ1HOC77g1uMdbpyjeOPhq663wLpwEwXn+xdlpc
	BlCqAdD6T9cUU/I8lOLSbKwv5TjsTFLZrSl0pDrKWuI9kKEwf3LLClR14UIjVGY/XWIZ0dhs7aHT6
	OfUqVyvbIXfhp2Cglu9Icq9DYcDXvN0RnmutDhOCwXKsOiqUAdsdnOxCRxQrt0+Xb0SZEw+jMwMcn
	Yb8GoVB1XVQqJvr2x9/M4Rfp1c5BQD3RRRbLVEUEJDLZm9Wp2ZxgYulNWMQe3zbyevh3dub0Qfv8x
	OPJ0xxjFgXN5uO+ptdQL/yaJGYWZ/MrUG9a7iV+hZRJPhCCc70IdRhlnq/r+lHJQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sAT5o-0008IF-Oe; Fri, 24 May 2024 13:28:12 +0200
Message-ID: <06f50224-9d9e-4118-adf4-ac89b0a06086@leemhuis.info>
Date: Fri, 24 May 2024 13:28:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [BUG] Linux 6.8.10 NPE
To: Greg KH <gregkh@linuxfoundation.org>,
 Paul Grandperrin <paul.grandperrin@gmail.com>
Cc: rankincj@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>
 <2024052249-cryptic-anthem-5bd2@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2024052249-cryptic-anthem-5bd2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716550095;b262171c;
X-HE-SMSGID: 1sAT5o-0008IF-Oe

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 22.05.24 17:12, Greg KH wrote:
> On Sun, May 19, 2024 at 01:28:58PM +0200, Paul Grandperrin wrote:
>>> I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
>> dmesg log. I have no idea what triggered it, and especially since I
>> have not even mounted any NFS filesystems?!
>>
>> Hi all,
>> I have the exact same bug. I'm using the NixOS kernel but as soon as it was
>> updated to 6.8.10 my server has gone in a crash-reboot-loop.
>>
>> The server is hosting an NFS deamon and it crashes about 10 seconds after
>> the tty login prompt is displayed.
>>
>> Dowgrading to 6.8.9 fixes the issue.
> 
> Any chance you all can use 'git bisect' to track down the offending
> commit?

Paul, any progress on this?

BTW, there is also a report about a NFS related general protection
fault, see this thread:

https://lore.kernel.org/all/CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com/

It was bisected to 4b14885411f74b ("nfsd: make all of the nfsd stats
per-network namespace") [v6.9-rc1, v6.8.10 (abf5fb593c90d3)]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


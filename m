Return-Path: <stable+bounces-52144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E45908411
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C5E1F21E84
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EAA1487DC;
	Fri, 14 Jun 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="J/Ejub4t"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C403142E80;
	Fri, 14 Jun 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348308; cv=none; b=fZzfmF/7v6tO7gmLfZGHZRhUt/iBSasrveIkG+O9VlMNM/AurWmmW7J/U176CqyFhcXgk+oWs5jYxPgT1iENvd/n+yD9Cv5RQ+D5VWgGxILc6fSZH7h32gv79BFZoeiiSXezmgR6XSXaryA3/7gpubakXPDGOrL51XgEns4jaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348308; c=relaxed/simple;
	bh=f9L8+HOT1POEI+Paq5nOZlp5/3RRH8cDd8FQ8Ps8UvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ool5F38yDEWUhEPULa1jFAgnZRD249/IYHA2VqhCC0WDguvtfb3VRdXCD5wG8OvXMKsJeoX3b8tbpyyvScNKL0xxI5sbbAwZeTw+0xDWtUfUB2zyXFFOLU0rVWjFfQzljdzMrXLUOVPs+vrzAszowiz0ZrRPDDDh7srsDSSOveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=J/Ejub4t; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=f8MUtOuGI0H7AJa9ICP7hY51hweem6+bRBdc+smOw7E=;
	t=1718348306; x=1718780306; b=J/Ejub4tOpQ6JNA4Gzim5xjhcD+Jh56J8NfE69WesEYnTu5
	htg32CnFFwAXl32grlomFc9ISSM+GPiR16FzUM/Z7ftsECwY0a30JqmPjQspBIkw+JCUUb+V43+BR
	AOhF+V2ntgeUVFG2/n0nR8KTKZUfXEINDMUeRzZDX9vcSAdc8/PRzTVWmBxpwTPZpn8fnPI9Rq8ve
	YrDRWwsRJoMmIc77lzZOP/PSdhF2+k770/HrvzBxnsPKw26FrvvnwBMZxj7r1VJ86dqQmt5DhD1qc
	ag7kWp6ucQUyHjwMMBKLwqf/7k0yLkTZr6jMRR1WcIovWrNSrdwU8X/QtRWY+JPA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sI0tC-00064y-E5; Fri, 14 Jun 2024 08:58:22 +0200
Message-ID: <6dcfa590-8d09-4d3a-9c35-0294099489ed@leemhuis.info>
Date: Fri, 14 Jun 2024 08:58:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Intel e1000e driver bug on stable (6.9.x)
To: Greg KH <gregkh@linuxfoundation.org>, Ismael Luceno <ismael@iodev.co.uk>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hui Wang <hui.wang@canonical.com>, Hui Wang <hui.wang@canonical.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZmfcJsyCB6M3wr84@pirotess>
 <2024061323-unhappily-mauve-b7ea@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2024061323-unhappily-mauve-b7ea@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718348306;93239a48;
X-HE-SMSGID: 1sI0tC-00064y-E5

On 13.06.24 10:35, Greg KH wrote:
> On Wed, Jun 12, 2024 at 10:33:19PM +0200, Ismael Luceno wrote:
>>
>> I noticed that the NIC started to fail on a couple of notebooks [0]
>> [1] after upgrading to 6.9.1.
>>
>> I tracked down the problem to commit 861e8086029e ("e1000e: move force
>> SMBUS from enable ulp function to avoid PHY loss issue", 2024-03-03),
>> included in all 6.9.x releases.
>>
>> The fix is in commit bfd546a552e1 ("e1000e: move force SMBUS near
>> the end of enable_ulp function", 2024-05-28) from mainline.
>>
>> The NIC fails right after boot on both systems I tried; I mention
>> because the description is a bit unclear about that on the fix, maybe
>> other systems are affected differently.
> 
> Now queued up, thanks.

I see that they are in the latest 6.6.y and 6.9.y stable-rcs. Thing is:

bfd546a552e1 causes other regressions, which is why Hui Wang submitted a
revert for that one:

https://lore.kernel.org/all/20240611062416.16440-1-hui.wang@canonical.com/

Vitaly Lifshits meanwhile submitted a change that afaics is meant to fix
that regression:

https://lore.kernel.org/all/20240613120134.224585-1-vitaly.lifshits@intel.com/

CCed both so they can comment.

Not sure what's the best way forward here, maybe it is "not picking up
bfd546a552e1 for now and waiting a few more days till the dust settles".

Ciao, Thorsten


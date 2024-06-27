Return-Path: <stable+bounces-55988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D791AFE2
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F3EB21161
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86D19B590;
	Thu, 27 Jun 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAf8fG48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCF19AD7B;
	Thu, 27 Jun 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518107; cv=none; b=BQFF7y2Mml19SxtFw/+rZ2YdZPsZqBoNw2rGIGtld/E7ozPDxftPNKHrDg79Iuxrhu0aa6Xk8bu7YUQyXeHYcn6cl5A6XgjNlelM/5q55QHbUN4GnB3semKibL9iJqQ9qWi/7buXfsjxm5xiS7OPtEy6ynfKxvErhfIc/N9u3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518107; c=relaxed/simple;
	bh=hrwvdZWx7IhA0lYFaP6GXEUdbYOx3ORsC1ADYxitptk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwLKq3Mskfe8StUYM6jCH7mYqDQ7huDZIcmN/4DDboEGMIqePDCBub5yPe4mey/PRKnSnNd74Ttc/vvSHWfzBYn0L5KLRXn9zG7iWotB2FZnnPRTi0FkFxKNr6xP0/tKYYxC+weAa8qtgQePsMqGKqlI+8pkaoK4DO69QyDNz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAf8fG48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254EFC2BBFC;
	Thu, 27 Jun 2024 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518106;
	bh=hrwvdZWx7IhA0lYFaP6GXEUdbYOx3ORsC1ADYxitptk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAf8fG4881G0CMiCpfCf0ZzzHM0S5m62lU1dsUVHM8HSkhUGqa/yITbyztb2/iiqI
	 pRJf9v6Tw+rEgWLOjj49zXX6hcCg4FbZByfJDO2NLGmsv0bACSktUhQMod2/ap+ttc
	 zYy+WJmgmF9SzAF8nVjTV2ho+muSDv640t4vGhRvjm534hpB0e7uSkQ0IvdqfUqbVF
	 BdP1S2SlgwHUE+Hp5gQsEm+q2fL3oMEkEflRrZMb68SEigO/JMKtZig0YTDsitgyCt
	 vF8mimpxyq4MUTpidgyxco61Tvtlc4b+ie9Yr7yuCTGTL2xj2y9KwkzxuERz7xNH+1
	 qWvAClKVXh9Hg==
Date: Thu, 27 Jun 2024 15:55:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: memblock: replace dereferences of memblock_region.nid
 with API calls" has been added to the 5.4-stable tree
Message-ID: <Zn3DmKp9SE5p4zG4@sashalap>
References: <20240626190708.2059584-1-sashal@kernel.org>
 <Zn0Q_DKvcVF8P5f-@kernel.org>
 <Zn1zXiis-yqRB2VO@sashalap>
 <Zn15zDM2kjbPOepD@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zn15zDM2kjbPOepD@kernel.org>

On Thu, Jun 27, 2024 at 05:40:12PM +0300, Mike Rapoport wrote:
>On Thu, Jun 27, 2024 at 10:12:46AM -0400, Sasha Levin wrote:
>> On Thu, Jun 27, 2024 at 10:13:00AM +0300, Mike Rapoport wrote:
>> > Hi Sasha,
>> >
>> > On Wed, Jun 26, 2024 at 03:07:08PM -0400, Sasha Levin wrote:
>> > > This is a note to let you know that I've just added the patch titled
>> > >
>> > >     mm: memblock: replace dereferences of memblock_region.nid with API calls
>> > >
>> > > to the 5.4-stable tree which can be found at:
>> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>> > >
>> > > The filename of the patch is:
>> > >      mm-memblock-replace-dereferences-of-memblock_region..patch
>> > > and it can be found in the queue-5.4 subdirectory.
>> > >
>> > > If you, or anyone else, feels it should not be added to the stable tree,
>> > > please let <stable@vger.kernel.org> know about it.
>> > >
>> > >
>> > >
>> > > commit dd8d9169375a725cadd5e3635342a6e2d483cf4c
>> > > Author: Mike Rapoport <rppt@kernel.org>
>> > > Date:   Wed Jun 3 15:56:53 2020 -0700
>> > >
>> > >     mm: memblock: replace dereferences of memblock_region.nid with API calls
>> > >
>> > >     Stable-dep-of: 3ac36aa73073 ("x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()")
>> >
>> > The commit 3ac36aa73073 shouldn't be backported to 5.4 or anything before
>> > 6.8 for that matter, I don't see a need to bring this in as well.
>>
>> Sadly there was no fixes tag :(
>>
>> Should this be reverted from 5.4 and older, or is it ok for it to be
>> there?
>
>It should be reverted from 5.4 and earlier please

Ack

-- 
Thanks,
Sasha


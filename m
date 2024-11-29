Return-Path: <stable+bounces-95838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07149DECBF
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786DE28161E
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AA15B99E;
	Fri, 29 Nov 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLzKyGn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34415B0EE;
	Fri, 29 Nov 2024 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732913460; cv=none; b=lEuHuVuaccExw9A58l9Pa3JAmJbvni7PfX9g3Np2jG2O0N+YWYH5jDtl+twGXxq2A0xRM0gwo55o6SjyyIX0sntMCfeoC08YPzOMqkiKezEoPv2fljL+c8gbmHrJF6b3BxtUnSnn0HAQZv7BrpKLZTbjQYLx4VWCKKRVxRbHrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732913460; c=relaxed/simple;
	bh=LOIG9BSpFHYM/td2BjZkDpvQk8mBag9BFkKQJT+AOOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NozuePd+YIRcqVDzgcCAHXop97I5+VKpMKALZIOSZRgFR3zwtogmtWjbLpLasN6g45lLANfutAKd27YNm/FLk3RpIT5Z1olpmzsqfrxtyc26eVJIYnwA8QdRbsvZ4c4olojl0ca7c94Y7BgllqiLVsoNtHlFNdKsL1jxZCNTH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLzKyGn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D60C4CECF;
	Fri, 29 Nov 2024 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732913459;
	bh=LOIG9BSpFHYM/td2BjZkDpvQk8mBag9BFkKQJT+AOOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLzKyGn0jFczUi2xloW4pdvLTxUdILY1RjHGyKFp5RjbZ6HR5V5MhcqgUSiCXi5RY
	 pXvu0rD8M3pOmEXlISxYPcq7z/m0PkLGPEEt5wPjVkzl4S3W/djtwhPxlFa7WB9ajS
	 gWPE3BLUkJZUsNK6GUkIzDf5y0ryaMzhYZ6EikQ1ZV9NPTaYZqigLsBQXsOnlHGHFg
	 Qiij+wk3pMoOIr5ZPBBj5Afqtn5KNcfh1o9JYnzdc++X0K06V/xYjQwEJkHOIs00Ku
	 +kO72knUeMIfi4kTVJH3VCUpeax/27sjjI97MM5V64W9vaA3YrJIjR7bCpA6RbVyeK
	 3mbn2bdHoRa+A==
Date: Fri, 29 Nov 2024 15:50:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, puwen@hygon.cn,
	seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
	babu.moger@amd.com, peterz@infradead.org,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com,
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com,
	aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0opMka39d0mV3DZ@sashalap>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0mNTEw2vK1nJpOo@duo.ucw.cz>
 <Z0nD6NZc3wmq8_v9@sashalap>
 <Z0olbd3OYQnlmW+D@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z0olbd3OYQnlmW+D@duo.ucw.cz>

On Fri, Nov 29, 2024 at 09:34:53PM +0100, Pavel Machek wrote:
>On Fri 2024-11-29 08:38:48, Sasha Levin wrote:
>> On Fri, Nov 29, 2024 at 10:45:48AM +0100, Pavel Machek wrote:
>> > Hi!
>> >
>> > > > You've missed the 5.10 mail :)
>> > >
>> > > You mean in the flood? ;-P
>> > >
>> > > > Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli7QIGVFT8EtO4@sashalap/
>> > >
>> > > So we're not backporting those anymore? But everything else? :-P
>> > >
>> > > And 5.15 has it already...
>> > >
>> > > Frankly, with the amount of stuff going into stable, I see no problem with
>> > > backporting such patches. Especially if the people using stable kernels will
>> > > end up backporting it themselves and thus multiply work. I.e., Erwan's case.
>> >
>> > Well, some people would prefer -stable to only contain fixes for
>> > critical things, as documented.
>> >
>> > stable-kernel-rules.rst:
>> >
>> > - It must fix a problem that causes a build error (but not for things
>> >   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>> >   security issue, or some "oh, that's not good" issue.  In short, something
>> >   critical.
>> >
>> > Now, you are right that reality and documentation are not exactly
>> > "aligned". I don't care much about which one is fixed, but I'd really
>> > like them to match (because that's what our users expect).
>>
>> You should consider reading past the first bullet in that section :)
>>
>>   - Serious issues as reported by a user of a distribution kernel may also
>>     be considered if they fix a notable performance or interactivity issue.
>>
>> It sounds like what's going on here, no?
>
>Is it? I'd not expect this to be visible in anything but
>microbenchmarks. Do you have user reports hitting this?
>
>It is not like this makes kernel build 10% slower, is it?

On Fri, Nov 29, 2024 at 10:30:11AM +0100, Erwan Velu wrote:
>This patch greatly impacts servers on production with AMD systems that
>have lasted since 5.11, having it backported really improves systems
>performance.
>Since this patch, I can share that our database team is no longer
>paged during the night, that's a real noticeable impact.

-- 
Thanks,
Sasha


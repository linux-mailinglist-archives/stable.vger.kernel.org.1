Return-Path: <stable+bounces-95768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92829DBE3B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 01:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9228261C
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD81361;
	Fri, 29 Nov 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDb2WJ1h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921061BC58;
	Fri, 29 Nov 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839712; cv=none; b=fe3RGqOW7GkqEtNuUu2ygj4jDWb/KLETV3IwEOStTXxBDqQ82POjcvIZoICvsZL6cvAioZ6TRoZLbpSdQldmlW+NSIU/1sWvJ/VYch3TWfTObpQYXa0z44wDzNpJr2323emkvchIICfRjm8gRP96snRD/vCUfBh8tEv4puvLyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839712; c=relaxed/simple;
	bh=nvFcu3/cFL/dBKUFcpgtwC3OqBP9XL4Kc3WBq1zpla8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyEXVpwBqm0bY6PA7yGu2MPO12K2lPPNHG6hEf7tHnf20h12kXEW2XGx19tlOr+tXkoB6e9wxQ+M5KJn9q6clt81jz2vHglbZZogsZA0zT3BCOQD1fVrWWinHYO/GRVSgr64HQeKk5u4soRuBdhRQzjAlqafmQRAacW1mOuQb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDb2WJ1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D96C4CECE;
	Fri, 29 Nov 2024 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732839712;
	bh=nvFcu3/cFL/dBKUFcpgtwC3OqBP9XL4Kc3WBq1zpla8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDb2WJ1hivrEH+tqUwaOnh7UXgdFiUVQK8jg6VRe31fa6dAChFHIxmIjqwjaO+XjM
	 RtS2GFcxFABI9adm9/jTmlalIqgM/ZpWfrTT8lYEs8/omV703B5bvJdZ7NMPBsOPaL
	 1lRundx0mVbz7S2XThsnHtF2uWZtZnpDd2OWOZVg3aoiMTt4APwRwEPNvtg0BExmEI
	 HXCZfT79r6wByhKp1hUWeoEzRf3LRxbGQ1wmTw4wnTN7BV93/TI9v/sCa/sSmRAjJE
	 sVlNCcAwUxxhLccPGJouOgSvY54PBjJ2tdf1VL4Q1pbiEW7WxxeSP2hB4JwGy6VQ/q
	 UFapDSIX5XQdg==
Date: Thu, 28 Nov 2024 19:21:50 -0500
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0kJHvesUl6xJkS7@sashalap>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>

On Thu, Nov 28, 2024 at 05:43:10PM +0100, Borislav Petkov wrote:
>On Thu, Nov 28, 2024 at 10:52:44AM -0500, Sasha Levin wrote:
>> You've missed the 5.10 mail :)
>
>You mean in the flood? ;-P

Suggestions welcome... I don't really insist on a massive flood and was
mostly following what was the convention when I started doing this work.

I thought about cutting it down to one mail per commit, but OTOH I had
folks complain often enough that they missed a mail or that it wasn't
obvious enough.

>> Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli7QIGVFT8EtO4@sashalap/
>
>So we're not backporting those anymore? But everything else? :-P

It was dropped from everywhere. The reason it ended up in 6.6 was
because your AMD friends requested it:
https://lore.kernel.org/all/2024022146-chunk-fencing-1e8f@gregkh/

>And 5.15 has it already...

It might be all those thanksgiving drinks, but I can't find it in
5.15... I see it was part of 6.7.6 and 6.6.18, but nothing older.

>Frankly, with the amount of stuff going into stable, I see no problem with
>backporting such patches. Especially if the people using stable kernels will
>end up backporting it themselves and thus multiply work. I.e., Erwan's case.

The stable kernel rules allow for "notable" performance fixes, and we
already added it to 6.6. No objection to adding it to older kernels...

Happy to do it after the current round of releases goes out.

-- 
Thanks,
Sasha


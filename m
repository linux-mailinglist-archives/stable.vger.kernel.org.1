Return-Path: <stable+bounces-95820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634249DE7C1
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BF2B20A29
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EDA19D091;
	Fri, 29 Nov 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJRBYqpi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E1990C1;
	Fri, 29 Nov 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887531; cv=none; b=gDa8gWOCPCJBLwkbLgKY4b5U+ajhtTPpnr17KSu7HPcDWNSgsnk0qEdJnSYq689J9L8bcYpymYHzlGnsAwcJ1jJufF5TYNMbvK7sBaeB/ls8u+Z8WIlW9+Pr3Clhptwk5Fj2j2cTooKnSB4AZEZ8k7x52P2M+kwuRw5U+s85zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887531; c=relaxed/simple;
	bh=zLpJJbrNi5utNjjPcKQYBObLnLMx/Vub2ZjTihm0Nqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8CbCa0jV63OnHZL9tpsW823nJo1f4pMsPOx8nnmILPI5mxP0jFCrDYeJD8NGj1sboM4lcL9Zl6NI++fKyUEffG0ZbG6Gi4iJ83QXIbs2n5idXbk9BqpNRPEfIIKIO41qLh0nSNl7ePXDaLUZybr4D1OHnxJVOrbJB1alN9FNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJRBYqpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF2DC4CECF;
	Fri, 29 Nov 2024 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887530;
	bh=zLpJJbrNi5utNjjPcKQYBObLnLMx/Vub2ZjTihm0Nqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJRBYqpiyhww8/l2NHH/Tb9ZfKM10EmIxo2PUS/te5l3BkYD/n1yiX57zSQnrI7sA
	 PpCb89nY8S7NUexzGa+rpRuOsk3BX+I8AGBvCOFoAeGChrW+Cyc+h0nuDLis2fQ37p
	 Be+rtoa0emMX89UQtFsCh0S6NAgsq/gfaeisxnOuv7AfzpVmL6U/+9kMpmni5uR560
	 ZAc01OTvu6kcHrI9rmcfzAvSofsHVk6iEWdfdniRtQaojfdwalBldqhAXns2TFZM8i
	 p6ulcQI/w3SQPSCwvDdsHp+fA633mvhWBOjXKBB1pR/dLwsYp3IF7s+nXvKpUuQraO
	 RqOMCTy3H1Q6w==
Date: Fri, 29 Nov 2024 08:38:48 -0500
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
Message-ID: <Z0nD6NZc3wmq8_v9@sashalap>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0mNTEw2vK1nJpOo@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z0mNTEw2vK1nJpOo@duo.ucw.cz>

On Fri, Nov 29, 2024 at 10:45:48AM +0100, Pavel Machek wrote:
>Hi!
>
>> > You've missed the 5.10 mail :)
>>
>> You mean in the flood? ;-P
>>
>> > Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli7QIGVFT8EtO4@sashalap/
>>
>> So we're not backporting those anymore? But everything else? :-P
>>
>> And 5.15 has it already...
>>
>> Frankly, with the amount of stuff going into stable, I see no problem with
>> backporting such patches. Especially if the people using stable kernels will
>> end up backporting it themselves and thus multiply work. I.e., Erwan's case.
>
>Well, some people would prefer -stable to only contain fixes for
>critical things, as documented.
>
>stable-kernel-rules.rst:
>
> - It must fix a problem that causes a build error (but not for things
>   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>   security issue, or some "oh, that's not good" issue.  In short, something
>   critical.
>
>Now, you are right that reality and documentation are not exactly
>"aligned". I don't care much about which one is fixed, but I'd really
>like them to match (because that's what our users expect).

You should consider reading past the first bullet in that section :)

   - Serious issues as reported by a user of a distribution kernel may also
     be considered if they fix a notable performance or interactivity issue.

It sounds like what's going on here, no?

-- 
Thanks,
Sasha


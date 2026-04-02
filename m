Return-Path: <stable+bounces-233038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PPQKh9+zmnBnwYAu9opvQ
	(envelope-from <stable+bounces-233038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:33:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B738A93C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87BFC3054728
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F53ED107;
	Thu,  2 Apr 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI9yc8/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930693E1CE7;
	Thu,  2 Apr 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140062; cv=none; b=PZy0SZB2k5On2XD4pfs6/xW4LH8z/Gy+cy5aJHtOqykyAHllMXVx1AsYELhv/yd70E9feSdvIsbzut9Q1+UZ360FUNIMPGI6J4uWrpSEVPfrZsjgC4WxH0kopzdaBID944YoF+iGasLe8SxwvE1sVtDog+r4tGWS145AojgbSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140062; c=relaxed/simple;
	bh=Y1jMs69HnwStQG3VJRxRCnD3F3uxV50p/MZ44MsIYAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNUkF3XDHnSEwNgS76hKxdccDVGRYPSDtX9s83QmKZF8dgQev1iFGHx+srEVH6YUyxupPo28MFvWIjEnx1tiINJJrkvIQBXqk7wJSVgdBce44tLnvHFLqmAmxD8GieHzIEcJF/lDaiUM+3ITGNjrKtuS4N0yDsTAGPw8bUwoeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI9yc8/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5001BC116C6;
	Thu,  2 Apr 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140062;
	bh=Y1jMs69HnwStQG3VJRxRCnD3F3uxV50p/MZ44MsIYAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fI9yc8/F+k8XSkUa4dmAg6c1TYAqxWYKk0Lc6PbMAgKh31qvqfOz1f+o+i582b77d
	 16OfeGXKSdFEg/B1u4uisFNCVx8WA4sJjarSGF8S0LXrcglZ0HDyo9++Nj/ZR/VHbr
	 bIAgQjsk8mrv4uoUjxIaF46tA5kjYQx8dASdQm5+kEpLKmSH3RlAAnLyPQ8+4WBrVg
	 TINSO8hmkAKRpt/er7HtYNdlI1dE8DWvPnhU8TpnWVA/aB3si2jiwA8nl/p5qUgPeO
	 n4si38cu6EivyGCdad4L+8sZcFkYXwdZ4L/arVXO5y1jlez8Fb7SLEwaFvJ4JStRvA
	 YcZlXtVPsuajg==
Message-ID: <ea00acf0-e743-453c-aaa3-b688cf87f3e6@kernel.org>
Date: Thu, 2 Apr 2026 16:27:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Qi Tang <tpluszz77@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cyrill Gorcunov <gorcunov@openvz.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402111332.55957-1-tpluszz77@gmail.com>
 <686134c9-c2e3-444f-b83a-dd229c7b0102@lucifer.local>
 <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org>
 <5a45a004-9ad1-4503-82b2-cf46b4ed4f9c@lucifer.local>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <5a45a004-9ad1-4503-82b2-cf46b4ed4f9c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,openvz.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233038-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A8B738A93C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 16:21, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Apr 02, 2026 at 03:55:27PM +0200, David Hildenbrand (Arm) wrote:
>> On 4/2/26 15:06, Lorenzo Stoakes (Oracle) wrote:
>>>
>>> We've had a gaping security hole since 2014 and nobody noticed? I find it
>>> hard to believe.
>>>
>>>
>>> Hmm there is already:
>>>
>>> 	if (prctl_map.exe_fd != (u32)-1) {
>>> 		/*
>>> 		 * Check if the current user is checkpoint/restore capable.
>>> 		 * At the time of this writing, it checks for CAP_SYS_ADMIN
>>> 		 * or CAP_CHECKPOINT_RESTORE.
>>> 		 * Note that a user with access to ptrace can masquerade an
>>> 		 * arbitrary program as any executable, even setuid ones.
>>> 		 * This may have implications in the tomoyo subsystem.
>>> 		 */
>>> 		if (!checkpoint_restore_ns_capable(current_user_ns()))
>>> 			return -EPERM;
>>>
>>> And you're proposing _adding_ this check on top of that? Seems super
>>> redundant.
>>
>> Yes, should be moved.
> 
> Well, I don't think this patch should be applied at all...
> 

I mean a v2 would have to do that. Whether we would merge that is
another discussion :)

>>
>>>
>>> but also, this seems super-specific buuut... Then again #ifdef
>>> CONFIG_CHECKPOINT_RESTORE around this. Ugh.
>>>
>>> I _hate_ this inteface. HATE HATE HATE it.
>>>
>>> Anyway, does updating _your own_ auxv really require elevated permissions
>>> like this?
>>>
>>> I don't think so? Couldn't you go and manipulate that anyway without
>>> elevated anything?
>>
>> Hard to believe ...
>>
>> I was wondering whether this could break some users. At least CRIU doc
>> states:
>>
>>     This option tells *criu* to accept the limitations when running
>>     as non-root. Running as non-root requires *criu* at least to have
>>     *CAP_SYS_ADMIN* or *CAP_CHECKPOINT_RESTORE*. For details about
>>     running *criu* as non-root please consult the *NON-ROOT* section.
> 
> Hmm. I wonder if we don't have more users than that though? Hard to rule out
> some weird program somewhere using it for some strange reason.

See my LXC example. My gut feeling is that there are more users.

Which then raises the question why this is still protected by that
kconfig option.

Something is off here, maybe :)

> 
> Commit ebd6de681238 ("prctl: Allow local CAP_CHECKPOINT_RESTORE to change
> /proc/self/exe") explicitly _only_ restricted the exe link.
> 
> So maybe these comment is in reference to _other_ operations other than non-exe
> changing PR_SET_MM_MAP, PR_SET_MM_MAP_SIZE?
> 
>>
>> I mean, the check makes sense given that prctl_set_mm() rejects all
>> these operations without CAP_SYS_RESOURCE.
> 
> Hmm but the CAP_SYS_RESOURCE check is only applicable to commands other than
> PR_SET_MM_MAP or PR_SET_MM_MAP_SIZE?
> 
> #ifdef CONFIG_CHECKPOINT_RESTORE
> 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
> 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
> #endif
> 
> 	if (!capable(CAP_SYS_RESOURCE))
> 		return -EPERM;
> 
> 	... rest ...

My point is that you can perform all these modifications without
CAP_SYS_RESOURCE through prctl_set_mm_map().

Like PR_SET_MM_AUXV.

It's all very inconsistent, that's what I am saying.

> 
>>
>>
>> CAP_CHECKPOINT_RESTORE was not introduced before
>>
>> commit 124ea650d3072b005457faed69909221c2905a1f
>> Author: Adrian Reber <areber@redhat.com>
>> Date:   Sun Jul 19 12:04:11 2020 +0200
>>
>>     capabilities: Introduce CAP_CHECKPOINT_RESTORE
>>
>> So at the time PR_SET_MM_MAP was added there simply was no such capability.
>>
>> Likely, now that we have it, we should indeed use it.
> 
> But we did start using it in the exec_fd != -1 case?

The existing ns check was replaced at some point, yes.

> 
> Hmm actually sorry it does more than just manipulating auxv, you can change a
> bunch of mm->... stuff.
> 
> But if it's your process does it really matter? You can manipulate memory all
> over the place in your process...

Well, I am wondering why e.g., PR_SET_MM_AUXV etc requires CAP_SYS_RESOURCE.

PR_SET_MM_EXE_FILE I understand. The other not.

Extremely inconsistent.

-- 
Cheers,

David


Return-Path: <stable+bounces-233032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPZPOvh3zmk6nwYAu9opvQ
	(envelope-from <stable+bounces-233032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:06:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8938A385
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55290302F9A8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BF3E4C90;
	Thu,  2 Apr 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWTO2q7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A5313E38;
	Thu,  2 Apr 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138722; cv=none; b=lmcNu+rwdfarc08Q7xF9kcFmVFiufRDIcES6DcfGfUa71DjaVOBrIa+EL35ejz9bG9C30OT7seAdSgC0WLL0i9lhsHhXTPtEM8DQDmEzU4OXtWUUEfVRcL5TEZqT0dwjTiK3Ta8UeSzskA5uaYJNBa5s7ovpCsCrcRGaAPpNddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138722; c=relaxed/simple;
	bh=j1ENaQQxbZKRMMr9VxJbrcuncvknRfRVEvty55WyqWg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SjyiP8pR9UQchx/AFFw9E/uiJgCXuDw5zJfGbQ2XO/vrQfYkGpDebFA5UofbB+HvzOJynEVAGbeB4ZYnuNJifCG1TSi+ku2YQ49Jn5zNSEl4ZmNp6ev3X+xU3Z8kO0vmKu8sUM2yCqH/XH0xsVi8DoMelh+PlboR771yJKoT5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWTO2q7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28293C116C6;
	Thu,  2 Apr 2026 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775138721;
	bh=j1ENaQQxbZKRMMr9VxJbrcuncvknRfRVEvty55WyqWg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TWTO2q7MvTsH3lDsiEwoizHDFAAXeg3iA4Pn/Kem3PcaBmNQr2mthKmLp1jyov+hS
	 OD3DyFWKBDkC+8lSvbRrp1TT3vxpfNGcxMcLysiAJFzTFZZTnOQphjENI0EMa7QOzF
	 OTItiQVKBgY7cT1lDxhYR17fKWUA3d9i65OOn4ae020LeGWVkjR3l/rQ7qTovS5iW8
	 qxeudpHJe9O3ID2Z4ZGw/a4tKPU7c6n39sLfDIT+zIQgQrbXmM06N4CCwgD9VzIY0X
	 1sXU+HibO/3lrZOesXxnGyY7JFwhfssCapT7SXQLmQMaFF+2TBImGz4ggUFTnURNLA
	 aq6K5hmlcsOVA==
Message-ID: <698daf83-1d5c-41c6-a36c-23a5b4633fbe@kernel.org>
Date: Thu, 2 Apr 2026 16:05:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Qi Tang <tpluszz77@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Cyrill Gorcunov <gorcunov@openvz.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402111332.55957-1-tpluszz77@gmail.com>
 <686134c9-c2e3-444f-b83a-dd229c7b0102@lucifer.local>
 <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233032-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E8938A385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 15:55, David Hildenbrand (Arm) wrote:
> On 4/2/26 15:06, Lorenzo Stoakes (Oracle) wrote:
>> On Thu, Apr 02, 2026 at 07:13:32PM +0800, Qi Tang wrote:
>>> prctl_set_mm_map() allows modifying all mm_struct boundaries and
>>> the saved auxv vector.  The individual field path (PR_SET_MM_START_CODE
>>> etc.) correctly requires CAP_SYS_RESOURCE, but the PR_SET_MM_MAP path
>>> dispatches before this check and has no capability requirement of its
>>> own when exe_fd is -1.
>>>
>>> This means any unprivileged user on a CONFIG_CHECKPOINT_RESTORE kernel
>>> (nearly all distros) can rewrite mm boundaries including start_brk, brk,
>>> arg_start/end, env_start/end and saved_auxv.  Consequences include:
>>>
>>>   - SELinux PROCESS__EXECHEAP bypass via start_brk manipulation
>>>   - procfs info disclosure by pointing arg/env ranges at other memory
>>>   - auxv poisoning (AT_SYSINFO_EHDR, AT_BASE, AT_ENTRY)
>>>
>>> The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
>>> PR_SET_MM_MAP operation") states "we require the caller to be at least
>>> user-namespace root user", but this was never enforced in the code.
>>>
>>> Add a checkpoint_restore_ns_capable() check at the top of
>>> prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
>>> requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
>>> user namespace, matching the stated design intent and the existing
>>> check for exe_fd changes.
>>>
>>> Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
>>
>> We've had a gaping security hole since 2014 and nobody noticed? I find it
>> hard to believe.
>>
>>> Cc: stable@vger.kernel.org
>>> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
>>> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
>>> ---
>>>  kernel/sys.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>> index c86eba9aa7e9..2b8c57f23a35 100644
>>> --- a/kernel/sys.c
>>> +++ b/kernel/sys.c
>>> @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>>  		return put_user((unsigned int)sizeof(prctl_map),
>>>  				(unsigned int __user *)addr);
>>>
>>> +	if (!checkpoint_restore_ns_capable(current_user_ns()))
>>> +		return -EPERM;
>>
>> Hmm there is already:
>>
>> 	if (prctl_map.exe_fd != (u32)-1) {
>> 		/*
>> 		 * Check if the current user is checkpoint/restore capable.
>> 		 * At the time of this writing, it checks for CAP_SYS_ADMIN
>> 		 * or CAP_CHECKPOINT_RESTORE.
>> 		 * Note that a user with access to ptrace can masquerade an
>> 		 * arbitrary program as any executable, even setuid ones.
>> 		 * This may have implications in the tomoyo subsystem.
>> 		 */
>> 		if (!checkpoint_restore_ns_capable(current_user_ns()))
>> 			return -EPERM;
>>
>> And you're proposing _adding_ this check on top of that? Seems super
>> redundant.
> 
> Yes, should be moved.
> 
>>
>> but also, this seems super-specific buuut... Then again #ifdef
>> CONFIG_CHECKPOINT_RESTORE around this. Ugh.
>>
>> I _hate_ this inteface. HATE HATE HATE it.
>>
>> Anyway, does updating _your own_ auxv really require elevated permissions
>> like this?
>>
>> I don't think so? Couldn't you go and manipulate that anyway without
>> elevated anything?
> 
> Hard to believe ...
> 
> I was wondering whether this could break some users. At least CRIU doc
> states:
> 
>     This option tells *criu* to accept the limitations when running
>     as non-root. Running as non-root requires *criu* at least to have
>     *CAP_SYS_ADMIN* or *CAP_CHECKPOINT_RESTORE*. For details about
>     running *criu* as non-root please consult the *NON-ROOT* section.

Doing some digging, lxc seems to use that interface.

https://github.com/lxc/lxc/blob/3ee89c5d95ee8f31bd81623fd73ad7beea4297f8/src/lxc/initutils.c#L311

I have no clue about capabilities there.

-- 
Cheers,

David


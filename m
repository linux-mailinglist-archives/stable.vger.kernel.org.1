Return-Path: <stable+bounces-233036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHMOEm19zmn0nwYAu9opvQ
	(envelope-from <stable+bounces-233036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:30:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A781538A8B5
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4094E301DDBF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E395317161;
	Thu,  2 Apr 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPRjkquf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AA4315A;
	Thu,  2 Apr 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139713; cv=none; b=MZIk+WlpN0MMbQ1ESiBH6Tu5PevPamRi4XUglrvaT6nAsuO6D3h99EBV+82auv11r97FFTc2zDD4PQIAfFUqeZBFF9KzURjUNpRErqTex1L/uEncI5KYRILvMbKktbjm3o1Sb805/vy1fe21qXxqz6WPzdJe4QziKDNCNnhRkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139713; c=relaxed/simple;
	bh=FaDNpac/lEZ3nC5wwlM1Lk512Opx4/Enbg1HVH79NZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKXnCoQ4T/JsrZZkOUMmA9DnDyUt2T+5DjrxplnH8P+IaSW3ih273Tz8JG2nbOyPVn0557iRO2LK3vixpjwfIunfLCsI6+s6ye4iV+FGOjziiCt9zS1ZncAwLcPTOrOiP2B5Nrww/DSAPz2aNu9hV3bIxcv7EsN2dE9hPyiDVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPRjkquf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0E9C116C6;
	Thu,  2 Apr 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775139713;
	bh=FaDNpac/lEZ3nC5wwlM1Lk512Opx4/Enbg1HVH79NZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPRjkquf4vPj/gWDt9LPeIQdGsdlXgjKjA83r/bEKahQuZ1ZLSEA4yBvxxu8at9tL
	 0uVtqRtEIsGdNc9AptNllA5R+h8QTGKU6M4mSLltkP47uesbyddJSuMJ3jtW+slKtE
	 wurX2HcDwnM2FLBeVGKZdxoIk1WsiSz0d3DBSynfR9kmJmEqXpOdL22gRfRPR72Yhq
	 Tz0dJXSDfi1Q8ObcvcxSwkS2XbEAJ0tE3kO8TYZ0R0/XpZPlz/Vk1mLzFVxcsNAhws
	 ZfEDljP/pkgZlPH0jOOZ8x4rbebFoy6WDC4Z3Nl7NuRMogPZyK2yvVwl2gzePMrZ3O
	 IAduyRBE/RjWg==
Date: Thu, 2 Apr 2026 15:21:49 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Qi Tang <tpluszz77@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@openvz.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-ID: <5a45a004-9ad1-4503-82b2-cf46b4ed4f9c@lucifer.local>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
 <686134c9-c2e3-444f-b83a-dd229c7b0102@lucifer.local>
 <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233036-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,openvz.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvz.org:email,lucifer.local:mid]
X-Rspamd-Queue-Id: A781538A8B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:55:27PM +0200, David Hildenbrand (Arm) wrote:
> On 4/2/26 15:06, Lorenzo Stoakes (Oracle) wrote:
> > On Thu, Apr 02, 2026 at 07:13:32PM +0800, Qi Tang wrote:
> >> prctl_set_mm_map() allows modifying all mm_struct boundaries and
> >> the saved auxv vector.  The individual field path (PR_SET_MM_START_CODE
> >> etc.) correctly requires CAP_SYS_RESOURCE, but the PR_SET_MM_MAP path
> >> dispatches before this check and has no capability requirement of its
> >> own when exe_fd is -1.
> >>
> >> This means any unprivileged user on a CONFIG_CHECKPOINT_RESTORE kernel
> >> (nearly all distros) can rewrite mm boundaries including start_brk, brk,
> >> arg_start/end, env_start/end and saved_auxv.  Consequences include:
> >>
> >>   - SELinux PROCESS__EXECHEAP bypass via start_brk manipulation
> >>   - procfs info disclosure by pointing arg/env ranges at other memory
> >>   - auxv poisoning (AT_SYSINFO_EHDR, AT_BASE, AT_ENTRY)
> >>
> >> The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> >> PR_SET_MM_MAP operation") states "we require the caller to be at least
> >> user-namespace root user", but this was never enforced in the code.
> >>
> >> Add a checkpoint_restore_ns_capable() check at the top of
> >> prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> >> requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> >> user namespace, matching the stated design intent and the existing
> >> check for exe_fd changes.
> >>
> >> Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
> >
> > We've had a gaping security hole since 2014 and nobody noticed? I find it
> > hard to believe.
> >
> >> Cc: stable@vger.kernel.org
> >> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> >> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> >> ---
> >>  kernel/sys.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel/sys.c b/kernel/sys.c
> >> index c86eba9aa7e9..2b8c57f23a35 100644
> >> --- a/kernel/sys.c
> >> +++ b/kernel/sys.c
> >> @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >>  		return put_user((unsigned int)sizeof(prctl_map),
> >>  				(unsigned int __user *)addr);
> >>
> >> +	if (!checkpoint_restore_ns_capable(current_user_ns()))
> >> +		return -EPERM;
> >
> > Hmm there is already:
> >
> > 	if (prctl_map.exe_fd != (u32)-1) {
> > 		/*
> > 		 * Check if the current user is checkpoint/restore capable.
> > 		 * At the time of this writing, it checks for CAP_SYS_ADMIN
> > 		 * or CAP_CHECKPOINT_RESTORE.
> > 		 * Note that a user with access to ptrace can masquerade an
> > 		 * arbitrary program as any executable, even setuid ones.
> > 		 * This may have implications in the tomoyo subsystem.
> > 		 */
> > 		if (!checkpoint_restore_ns_capable(current_user_ns()))
> > 			return -EPERM;
> >
> > And you're proposing _adding_ this check on top of that? Seems super
> > redundant.
>
> Yes, should be moved.

Well, I don't think this patch should be applied at all...

>
> >
> > but also, this seems super-specific buuut... Then again #ifdef
> > CONFIG_CHECKPOINT_RESTORE around this. Ugh.
> >
> > I _hate_ this inteface. HATE HATE HATE it.
> >
> > Anyway, does updating _your own_ auxv really require elevated permissions
> > like this?
> >
> > I don't think so? Couldn't you go and manipulate that anyway without
> > elevated anything?
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

Hmm. I wonder if we don't have more users than that though? Hard to rule out
some weird program somewhere using it for some strange reason.

Commit ebd6de681238 ("prctl: Allow local CAP_CHECKPOINT_RESTORE to change
/proc/self/exe") explicitly _only_ restricted the exe link.

So maybe these comment is in reference to _other_ operations other than non-exe
changing PR_SET_MM_MAP, PR_SET_MM_MAP_SIZE?

>
> I mean, the check makes sense given that prctl_set_mm() rejects all
> these operations without CAP_SYS_RESOURCE.

Hmm but the CAP_SYS_RESOURCE check is only applicable to commands other than
PR_SET_MM_MAP or PR_SET_MM_MAP_SIZE?

#ifdef CONFIG_CHECKPOINT_RESTORE
	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
#endif

	if (!capable(CAP_SYS_RESOURCE))
		return -EPERM;

	... rest ...

>
>
> CAP_CHECKPOINT_RESTORE was not introduced before
>
> commit 124ea650d3072b005457faed69909221c2905a1f
> Author: Adrian Reber <areber@redhat.com>
> Date:   Sun Jul 19 12:04:11 2020 +0200
>
>     capabilities: Introduce CAP_CHECKPOINT_RESTORE
>
> So at the time PR_SET_MM_MAP was added there simply was no such capability.
>
> Likely, now that we have it, we should indeed use it.

But we did start using it in the exec_fd != -1 case?

Hmm actually sorry it does more than just manipulating auxv, you can change a
bunch of mm->... stuff.

But if it's your process does it really matter? You can manipulate memory all
over the place in your process...

>
> --
> Cheers,
>
> David

Thanks, Lorenzo


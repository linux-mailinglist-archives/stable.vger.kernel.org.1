Return-Path: <stable+bounces-256471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AnpDK4IGWr7pggAu9opvQ
	(envelope-from <stable+bounces-256471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E45FCC67
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80866303F2AF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0E35F5E6;
	Fri, 29 May 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl1eTYQr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E402DEA89
	for <stable@vger.kernel.org>; Fri, 29 May 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025115; cv=none; b=UCZ7pgJ/nDYSc6i4zfzdcdsdXWhk3QpSOeT9V7HejyQaugAluYP2EHThsDHRK8RXp5eEreJnH74L8vfFlOWTpOjmnT/SzbBE7VgnYRIMiLLlzCugl23v5PWr3kkcuTG0ddnm+aSnYJS345pWAJHCa0Q8TaryzJ40+AvNJv9OR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025115; c=relaxed/simple;
	bh=fRkjzdlKFB3G8cz1eLu7lHkI1z6MwLqtYeN2gFmkY3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8TOzLil+YrV3eEVD/xH3e/AdnkWxj9GLsW0MHp2jQeQyV2PLxylYL8RS2IyXNoAS4LDObb6Puuhs+Kgm7Bav313g1WASPPlsvYR3O/HRvAZOqoFMQTwbNJ64r5BNbLZGwT+Pmi/4LGDeppCBf9H5z+Q9psd7/qNSvsc+xBVeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl1eTYQr; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e61e251966so3002225a34.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 20:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780025113; x=1780629913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVUdE1OE+AlbBfL0FVFGoI0GSH8ihfJl0i4B0BNMBWI=;
        b=nl1eTYQrQZ/y6W3+9K9oLmpQrKoyp9DbYLkkGVmx2LCHd/hN5cTuLo2Bu07c+Hh08c
         BaUOY0fWX/bd9AN3LMdG0cE0yEMLTj522FjcyRXHxwEoaIsmC41+AlCNcE7YFH8Hp3A+
         O6fRXGO3iz5nS2mU+Bar+NZ4gjAEjBjtXyhxts5Y0gz8fx85SPRJ4yosVC3Yua1mrMvD
         zKai7diPde98BrmdXotxB/oUmlb7l+vHZ/H0qj/BzY3YetU7PDw0TczHOv4yEFen52n4
         3+C0pML85+oWrQif6kp5rn1mXlJHLp9yRGn54MrItp77ifctDolA9natq8agE06UI70p
         0ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025113; x=1780629913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVUdE1OE+AlbBfL0FVFGoI0GSH8ihfJl0i4B0BNMBWI=;
        b=QPOmuMvIcvYWpqaFlps6X+O29A5QLtlf6snlqEKVPrRrqR8Rmp6foC4e2rMbQXRpc7
         7DB4BlqCmNCwYPHinUi+YVw0/huuAeTiX3h8/Wq4nZcIg0M0ta1tzOTdzwZzWI3FQn3e
         H3qjiNQz55BeyYUqnDAOPz005+U3JAX7b4p5Q1ExAGrG+ncLkqlXNGcfr0fJXpjnt73E
         nHi83UCAZiZXTpG9sQmog6UfYgUt1lFfY/rD/sudCOfwv3x4GMYClYTAUVI1JAQSwrwo
         0ragPGD/Z82S23zhLRiArPCWQ6TnA7xjQSOqf6QZ8fQusjKsyOwJIWZbeCotv08uik61
         qBAw==
X-Forwarded-Encrypted: i=1; AFNElJ9i9EJWelQ0b6DgTXZdhACKX0Cwf+h0/QTiZyRWYZuPzXBohNHdWPWhz8D4TffzOl/FqmguR60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66qiulGzYvlS1JSIwEA2vu4Pat4iTT1cBmggZ6QELdiEIzn5m
	KNx5vOSabhy1jAfZWBZ7mVUaZdHM7/kONgyBRpgBpU9MlAAAoQrv0NEz
X-Gm-Gg: Acq92OFlySFBng4IqrL5YH2EsSNgAsENcOTl+5cvvMrDQy2D5jPVUbsWxIjGb6cA/cb
	0dszkEtL1PxHo2C/eTaj5jeAlsF3QDNQ6HHYcueZIbtVragEtXn+CP8ruhNXm++O6L1DlGSjqlb
	cZCEfkD87fcIh5Dgx5OZ/FnDoJkaMC3nWurtZFCBjr5vMyc+kBzMlpBBh5EMwYKywyEhoLU0JIV
	7aacpadl6FbJ4yMQKRRoqC0WH6CupDYzCBQw8Rdo+Jj4/qpi1dEZdi8LCHnGFcgqovtNpNuWuT8
	L6ipCdXJ8JJaB3g+ZhXbFj86sMc+4ea+2Q9qO1Q5aZl/04qNDba5GbNXCIbkoDoDULw5UqbXhRw
	VXn8MkBGRKpQzOmbEmJLx2nkhdFlrDU3hTI5JJ1QKPxLHo4kNPcZw5O0FFa9V0HyWJKBNTCrIaD
	FjrFDO3DvVDZ7YQzwpGN3ArzFrAaQNAItkri+lyshbI1jvyNgyoTjuGAUHFL58Ik7vB19sBCsxC
	g==
X-Received: by 2002:a05:6820:55dc:10b0:69d:521d:a4fc with SMTP id 006d021491bc7-69e03ebc621mr529610eaf.8.1780025113540;
        Thu, 28 May 2026 20:25:13 -0700 (PDT)
Received: from suesslenovo ([2601:281:c981:d860:ca50:ff10:ab81:cd2a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e0696e089sm212603eaf.9.2026.05.28.20.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:25:13 -0700 (PDT)
Date: Thu, 28 May 2026 23:25:12 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: hexlabsecurity@proton.me
Cc: "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN
 to invoker's pgid
Message-ID: <ahkAS5S4SfMa4gJI@suesslenovo>
References: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256471-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email]
X-Rspamd-Queue-Id: 999E45FCC67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:21:50PM +0000, hexlabsecurity@proton.me wrote:
> From 22a0086b44beaaef01883e047dd4a8b8bc3153e9 Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Thu, 28 May 2026 01:30:00 -0500
> Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to
>  invoker's pgid
> 
> A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
> SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
> F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
> producer-side cache-vs-live evaluation gap.
> 
> The SIGIO path in hook_file_send_sigiotask() consults a cached subject
> stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
> (via hook_file_set_fowner()), instead of evaluating the live Landlock
> domain of the invoking task at signal-send time. The capture is gated
> by control_current_fowner(), which returns false (skipping capture)
> when pid_task(fown->pid, fown->pid_type) is in current's thread group.
> 
> This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
> single thread or thread-group leader sharing current's cred. It is
> unsafe for PIDTYPE_PGID and PIDTYPE_SID: when current is at the head
> of its pgid hlist -- the default placement after fork(),
> hlist_add_head_rcu() in kernel/fork.c -- pid_task(pgid, PIDTYPE_PGID)
> resolves to current itself, same_thread_group(current, current) is
> true, the capture is skipped, and fown_subject.domain stays NULL.
> 
> hook_file_send_sigiotask() then short-circuits at
> "if (!subject->domain) return 0;", allowing the kernel to fan the
> signal out to every member of the group, including tasks outside
> current's Landlock domain that the SCOPE_SIGNAL contract is supposed
> to protect.
> 
> The direct kill() path (hook_task_kill) is unaffected: it evaluates
> current's live domain on every call. Only the cached SIGIO path is
> broken.
> 
> Repro (ordinary unprivileged user; sandbox active in the child):
> 
>   int pfd[2]; pipe(pfd);
>   landlock_create_ruleset(&{.scoped = LANDLOCK_SCOPE_SIGNAL},
>                           sizeof(attr), 0);
>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   landlock_restrict_self(rfd, 0);
>   fcntl(pfd[0], F_SETSIG, SIGKILL);
>   fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
>   fcntl(pfd[0], F_SETFL, O_ASYNC);
>   write(pfd[1], "X", 1);                         /* trigger SIGIO  */
>   /* every pgid member receives SIGKILL, including non-sandboxed
>    * parent / supervisor / sibling workers */
>
I was able to reproduce this on mic/next.

Great catch!

> Tighten control_current_fowner() to apply the thread-group exemption
> only when the target identifies a SINGLE task whose Landlock cred is
> necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
> PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
> subject so the consumer's scope check runs against every member of
> the group at delivery time.
> 
> Empirically A/B-verified on a 6.12.90 lab kernel (same .config, only
> the patch hunk differs): pre-fix build exits with "BUG PRESENT --
> SCOPE_SIGNAL BYPASSED", post-fix build exits with "SANDBOX HELD".
> hook_task_kill's direct-kill enforcement and the intra-thread-group
> F_SETOWN cases continue to work post-patch.
> 
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  security/landlock/fs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..edaa52572cbd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1909,6 +1909,18 @@ static bool control_current_fowner(struct fown_struct *const fown)
>  	if (!p)
>  		return true;
> 
> +	/*
> +	 * For PIDTYPE_PGID and PIDTYPE_SID, signal delivery fans out to
> +	 * every member of the group at SIGIO time. Even when pid_task()
> +	 * resolves to current itself (e.g., current is the pgid hlist
> +	 * head post-fork), non-current members of the group are still
> +	 * valid targets that must be checked by hook_file_send_sigiotask().
> +	 * Always capture the current subject for those types so the
> +	 * consumer scope check runs against the live fown_subject.
> +	 */
> +	if (fown->pid_type == PIDTYPE_PGID || fown->pid_type == PIDTYPE_SID)
> +		return true;
This seems right.

So basically we are failing to check the subject on fan-out
signals where type > PIDTYPE_TGID (ie PIDTYPE_PGID/SID).

But this fix seems good as is to me and closed the reproducer hole in my
test. Unless there are some edge cases I'm missing.

The commit message could use some cleanup and shortening. No need to
include the reproducer (though it was helpful) and the "BUG_PRESENT"/
"SANDBOX_HELD"/ AB testing stuff. Just explain the bug and what
it fixes :)

You can add the reproducer and stuff below the --- in the patch and
above the diffstat in the future to make it part of the git notes and
not the actual commit.

That way you can add anything else that doesn't belong in the actual
commit but is important for context.

This may need an erratum entry and a regression test in the future,
but that can be done seperately.

Again great job!

Tested-by: Justin Suess <utilityemal77@gmail.com>
> +
>  	return !same_thread_group(p, current);
>  }
> 
> --
> 2.43.0
> 


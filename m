Return-Path: <stable+bounces-223596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOYJL5mjrmmbHAIAu9opvQ
	(envelope-from <stable+bounces-223596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:40:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CCC2373F8
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABC43055628
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F63921DE;
	Mon,  9 Mar 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob0cqTaM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513838B7AF
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052705; cv=pass; b=Pcb9tp6CqgJsFdKLSjrM17cfM2m/SeCVd7x+oR9lcxr3Y2j5brCRViUWFBnXWCU5+L65LkDQOV3OPkOUdSRtI9kn325He66DjTZWZCsOliY1ub2Arh3MO8CmRuIeSWyyC/EFdBtJLCDqn5QzNeuAZjJsu29bh48bll66y0U4c2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052705; c=relaxed/simple;
	bh=zGQuc34+ynNDoCTXArYQlWm9klqKQ2W0kK6j2oLNx+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+UB9Gx0ZSWRJMZsBSnxu5gBaeLSpSKOKGWP+XNWgwvPI0syMotPQVW/veGFt+PHcp/d25BgDxk0gNAxEwb0V+gIxz8ueWt4FsNBkh2uiTYcgrQUHx+/WDYLwd9FbUJKjtN88CMXKQAapSttwzstuzb11/X6k20Rmayu40tpCMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob0cqTaM; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79901821bb0so4180797b3.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 03:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052703; cv=none;
        d=google.com; s=arc-20240605;
        b=YRdeGuT6kpejwbWoY/YtJuJBEB8dEVTUuv5CHMRGJhlDxpHGhh/KKZqgzIPvI9kiaM
         xFaEpGmmYQJ3nGQGOL0pJ8oDP5MwmqBep7yyy2PoUKZtIAPUqnmBX0rwMDpWdl8041KO
         zUBOA11WludpMfP+NPiwF0+i7yRKbImLhJze0GpN0/nZZvkCozHhJyFeZLekSjSi1S92
         9ks03/SV2K8T2yse366p/9GkzFvO9FLChsbKtEzttAtSYtkim/5yrCIppVn5ZVsg/15V
         v6K/1t9G9rO1+Z1Dh2397/LF6UkT+M87FuzdNSr3HrXj1kdxTDemAU676p1LkEKRQk3A
         bCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pd/QwTFnDfoORdcPMrJQXvD9uG10tJG+M7oMPLvF7XI=;
        fh=TH6PiaOQLdy2xo8xjOu30kEJ5lE9Wc8X+xa6vwgk2BQ=;
        b=kArEr6i77qD3rgszAwXMvYmISGVUpmv1Y9dBQPhw0Yy3tzBELKKlzRN3WudM5HdFyp
         yVYQMe10yC3JTo2SZ1bam/ygRTZ2K+qLYVT4sBIwV/7M4FHdvENzcCR+d94eX5AGLh71
         KciHZWlPctj0zpIoKJ0eNWplD1Clqj6PJhofZ28xGFlXq+/rWgE8BqSWQ0OB7Qsz7tk9
         3reZv2yjvlflWFTZoAXK7nvnh0yIviAGoSCZHozmPtyQeJcOxmc1WmjCaR2NZcUsP4+r
         BZhmB1kuMuV4PfuzfdwpnRd6/oi2e5sdX08vL+A6oCRs4kG5S7HhcHOCrAgQ3uqwoJDq
         CX3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052703; x=1773657503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd/QwTFnDfoORdcPMrJQXvD9uG10tJG+M7oMPLvF7XI=;
        b=Ob0cqTaM09uVsKogdZ/rjHfrDQPPWMwQVUeh7I7s5NoAKBRcO8X1L7XzD0u3lba7Gw
         JhXt1et1VPGMzYlitoNQCkEazk4vasMQc4TQOn2p0ZNisnzsvx4Xs1gfy6Fxaf9tyNjb
         dqBB2UIEsNMwsu1QvfhtIOBQYs7L0DtaqIvIhEpCmvCAJfDkV/gkKfwDisZvC3iW+4OC
         rafsT0/WIhgmedqXMpKw9eYztRmOMIQWKNotP+qtiadhApSa72T9TqIUjwhr+9OTlC0L
         vQrBziNOSM9Qs/uKEoicgsCToiqsmAQYZ7zJXSSkX0v7SxRfD/AJHpt8m66lAdokuR1V
         A9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052703; x=1773657503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd/QwTFnDfoORdcPMrJQXvD9uG10tJG+M7oMPLvF7XI=;
        b=YK6+6nlIW2l/nBMo8hZF4+5n3c15FybqmnUYomc2HIcvT0sHjA7uetCUy74TMGTlC/
         6OaxCf0P9i/mEsccZJ034KY/8QGutIKdgT25TA5nwCFZLKUj8MwtQhe3LfuVIHmKQPG9
         vpJ0DKPH6u7rY2TRBBe5NekqFvrfcqmSAOPgrx3IvDrAfi7ZZyuiOvwvuiGnm2HVVEjf
         Mcon5cDxnU9pJ9OYGI4gBdQ3zoBLM2755gTlAhXf2/v/HUZpY0SJtib91d21tAP4M40f
         WIYTCC0BbiGiQ9PjcYMN4Ne6nycZhwOzXpcZzkyGThD08cGfRRKGg7Nk+5ABosoUVT7b
         EvKA==
X-Forwarded-Encrypted: i=1; AJvYcCWrJNxo6SSKoTzRCjEzZQBKpOnnKAEi/G0NJggp3CYx1r4I7YBQp+wSH+JYRjBXoJIFRCCSGP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydee/yHCWRpD1pfydEIOTVgaQUuPpZP3C62iTagEayNlJlwSUl
	/K19Zio+im9sw3GUqnUPC/ivmrdl6pHeMcKjVZcYV7tv5Q+vtestFDn7EO0aEvSeAIjnGPQtyml
	k+VZXDwVrMT6IKF+I9Bte9agtYs7TIks=
X-Gm-Gg: ATEYQzzRy/QpAsbonwx3pdyHBn7Bpq7RuRp+27pWSuKs8aSWE0SrgFMA4Xi0OxDyyAt
	TZmkQk/90VcZnVOH83jpDtlM3aTbkGcfok41K0WTdYR0U3wOq449Jg/VcLMCoeTjSCv4wY88Uog
	0KbaJBiB7DvZTAVPUXXCquHPzOZSasCpFFGVbeTzmlpL1ZYqW6t5EwjQfM5Z7aNKZVQNoIptPHn
	9c3+qrFOLGBL2pxiSi+whH38EBJ9R+2SvTN8LERAhrXT0zGasEp7chHl+COXYpolz+U6WHdGkB3
	gHPxd4xTiNy9Txh4Kq+cabxNUYd0fYueSDeqktX48xBphJqN/EtC6QWfX4Ji9KT9gUKIjNAa
X-Received: by 2002:a05:690c:d88:b0:797:d7a8:c540 with SMTP id
 00721157ae682-798dd6b3e9cmr104166207b3.26.1773052703456; Mon, 09 Mar 2026
 03:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308213116.7E884C116C6@smtp.kernel.org> <aa6ZrCZoEYgsPXka@redhat.com>
In-Reply-To: <aa6ZrCZoEYgsPXka@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 9 Mar 2026 16:08:11 +0530
X-Gm-Features: AaiRm51hNj-AFGnKqhLbYe8DDZ9RYDSgKSF5XQQrbdVnMc7oHyeFGGWqPOokc7c
Message-ID: <CADhLXY6zH2A88dSDeTdsQJ77dEOPX5fkHu7PvhKL1beXGxs6Tw@mail.gmail.com>
Subject: Re: + kernel-fork-validate-exit_signal-in-clone-syscall.patch added
 to mm-nonmm-unstable branch
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	vschneid@redhat.com, vincent.guittot@linaro.org, surenb@google.com, 
	stable@vger.kernel.org, rppt@kernel.org, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@redhat.com, mhocko@suse.com, mgorman@suse.de, 
	lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, kees@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, david@kernel.org, 
	bsegall@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 40CCC2373F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223596-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:28=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 03/08, Andrew Morton wrote:
> >
> > From: Deepanshu Kartikey <kartikey406@gmail.com>
> > Subject: kernel/fork: validate exit_signal in clone() syscall
> > Date: Sat, 7 Mar 2026 12:12:02 +0530
> >
> > When a child process exits, it sends exit_signal to its parent via
> > do_notify_parent().  The clone() syscall constructs exit_signal as:
> >
> >   (lower_32_bits(clone_flags) & CSIGNAL)
> >
> > CSIGNAL is 0xff, so values in the range 65-255 are possible.  However,
> > valid_signal() only accepts signals up to _NSIG (64 on x86_64), causing=
 a
> > WARN_ON in do_notify_parent() when the process exits:
> >
> >   WARNING: kernel/signal.c:2174 do_notify_parent+0xc7e/0xd70
>
> Aaah. Thanks Deepanshu! My bad, please see below.
>
> > The comment above kernel_clone() states that callers are expected to
> > validate exit_signal.
>
> Yes, and man 2 clone says:
>
>       The termination signal is specified in the low byte of flags (clone=
()) or in cl_args.exit_signal (clone3()).
>       If no signal (i.e., zero) is specified, then the parent process is =
not signaled when the child terminates.
>
> it doesn't document that nonzero non-valid signal acts as .exit_signal =
=3D=3D 0.
>
> > --- a/kernel/fork.c~kernel-fork-validate-exit_signal-in-clone-syscall
> > +++ a/kernel/fork.c
> > @@ -2800,7 +2800,8 @@ SYSCALL_DEFINE5(clone, unsigned long, cl
> >               .stack          =3D newsp,
> >               .tls            =3D tls,
> >       };
> > -
> > +     if (!valid_signal(args.exit_signal))
> > +             return -EINVAL;
> >       return kernel_clone(&args);
>
> Well, kernel_clone() has more users which doesn't validate .exit_signal,
> say sys_ia32_clone().
>
> we need to move the valid_signal() check from copy_clone_args_from_user()
> to kernel_clone() or copy_process()...
>
> So. This should fix my
>
>         [PATCH] do_notify_parent: sanitize the valid_signal() checks
>         https://lore.kernel.org/all/aZsfg0Y055yuAvsq@redhat.com/
>
> do_notify_parent-sanitize-the-valid_signal-checks.patch in -mm tree.
>
> Somehow I was very sure that copy_process() paths already have the valid_=
signal()
> check but my memory fooled me.
>
> But this is a user visible change which can cause other bug reports...
> Perhaps we should revert do_notify_parent-sanitize-the-valid_signal-check=
s.patch
> and this patch?
>
> Even if I think that the new valid_signal() check "fixes" the undocumente=
d
> behaviour, unlikely there is a sane application which passes non-valid ex=
it
> signal to sys_clone(). But who knows...
>
> Oleg.
>

Hi Oleg,

Thank you for the review.

You are correct that fixing only the clone() syscall is incomplete.
sys_ia32_clone() and other kernel_clone() callers would remain
unprotected. I will send a v2 with the valid_signal() check moved
to kernel_clone() to cover all callers.

Regarding your do_notify_parent patch =E2=80=94 since v2 will fix the root
cause at kernel_clone(), your patch in the -mm tree can be dropped.

Regards,
Deepanshu Kartikey


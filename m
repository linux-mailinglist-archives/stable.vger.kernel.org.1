Return-Path: <stable+bounces-116323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AADA34CA0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB57E16C0CD
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352724167D;
	Thu, 13 Feb 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKqet2+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBF241661
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469522; cv=none; b=e66N8HJEpfpfwndy0AniycDV+Go+yIyvaaGh6Be1UkgUIRzIL7fe6FrX5bdNbtrQKzAfVSCT/K0+CQutihfJGwXMzP4ZUb5S99zlN/TRy4W03GijDG44sauLyFPzf21kLMg+OQcLpGfUKu5sCzRZ7rn7r3niaZg/Ze0Qt4oGaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469522; c=relaxed/simple;
	bh=iCD1EJbH1lIRLMhar/vubBdCo81+Zp/krmtY+yjRst0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7mWDeuZidY2XcKMC1lgQZKn++RBKYaUNz35oR94SRbXt5/A1gatVCCNEOQCGg3bWDZdq7ha6X3hu1pK3XaYhJ2m1JlaVyi22SMCUcI1E19EYpLIx96lheay3gOKUkboyr80AXUu+wZcysy4UpZSdEEyKKfy1XP6lFKK0fxWU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKqet2+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64738C4CEE4
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469522;
	bh=iCD1EJbH1lIRLMhar/vubBdCo81+Zp/krmtY+yjRst0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKqet2+zH1t97Tb9PYh+csE5Hdb00pQkostRd2H2ctUmml1g8pGaPSCFUWnd+A+O0
	 bOMyt4JNMnU96lRXLcWJRor87iyLPNItlWNX/iX3dZG/1Uiu89IzQ4X1LtvLTcY/2O
	 7WicsQQbKQWDPk3XgXrgyZQz+ak29vrd2BaMECULVVsLSjv6pwN53nd3BBp1r2DRDD
	 pIZ75RwafjHlIFQ0r/x5yRo8Lo9WUvLtkAcvnfH1UGQHS0RIb9w282c8FYrQtCWJzD
	 mHbM4bZhXbdkWtKXrrOa0kyfEtO0tPU8X02toteJqeRdwmKZL4nLi3fjSdEH7rvIaQ
	 lI+jDpT9mbxmQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso2010310a12.2
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 09:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpKmidSDow+dT+fvDQn/S34lFgqVPC9OpRMdoolSXMmOqKgANTEoQeeQQ7SILi0YG6OM3UeXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnu1A5NyQ/vGH+L4vDjNvQPqwxAmN379HydvxePwhnZDbXQuqT
	iWxc7uvY87U7NlT0mQPt2Cx3NWeOIDqkV9cVBA0wQeP4Ks/oTey6XBTw3fOrAZB9QhtaZcykvGH
	tdJUypBWYj4z8HVg7FKIXqaMnpNp0/Z9ICmlk
X-Google-Smtp-Source: AGHT+IFHopkCd1IJRkVGtcRhcYRjj+s4dlwwFJCs/2tuVCIcDrZdxsclaMkaSiHDnOZupJK47TfVKKdiSuDfdpu5g6U=
X-Received: by 2002:a17:907:3ea2:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-ab7f33cab3bmr916405866b.31.1739469520915; Thu, 13 Feb 2025
 09:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212220433.3624297-1-jolsa@kernel.org> <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
 <Z623ZcZj6Wsbnrhs@krava>
In-Reply-To: <Z623ZcZj6Wsbnrhs@krava>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 13 Feb 2025 09:58:29 -0800
X-Gmail-Original-Message-ID: <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
X-Gm-Features: AWEUYZkKsWtgJBXXFU3xbPGAlALgrkQUHGzWNL5HcC7wERAjq_EEPmO7fwgtv2M
Message-ID: <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> > On Wed, Feb 12, 2025 at 2:04=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Jann reported [1] possible issue when trampoline_check_ip returns
> > > address near the bottom of the address space that is allowed to
> > > call into the syscall if uretprobes are not set up.
> > >
> > > Though the mmap minimum address restrictions will typically prevent
> > > creating mappings there, let's make sure uretprobe syscall checks
> > > for that.
> >
> > It would be a layering violation, but we could perhaps do better here:
> >
> > > -       if (regs->ip !=3D trampoline_check_ip())
> > > +       /* Make sure the ip matches the only allowed sys_uretprobe ca=
ller. */
> > > +       if (unlikely(regs->ip !=3D trampoline_check_ip(tramp)))
> > >                 goto sigill;
> >
> > Instead of SIGILL, perhaps this should do the seccomp action?  So the
> > logic in seccomp would be (sketchily, with some real mode1 mess):
> >
> > if (is_a_real_uretprobe())
> >     skip seccomp;
>
> IIUC you want to move the address check earlier to the seccomp path..
> with the benefit that we would kill not allowed caller sooner?

The benefit would be that seccomp users that want to do something
other than killing a process (returning an error code, getting
notified, etc) could retain that functionality without the new
automatic hole being poked for uretprobe() in cases where uprobes
aren't in use or where the calling address doesn't match the uprobe
trampoline.  IOW it would reduce the scope to which we're making
seccomp behave unexpectedly.

>
> jirka
>
> >
> > where is_a_real_uretprobe() is only true if the nr and arch match
> > uretprobe *and* the address is right.
> >
> > --Andy
>


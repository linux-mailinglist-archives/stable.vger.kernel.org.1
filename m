Return-Path: <stable+bounces-255019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFIiGglRGGpMiwgAu9opvQ
	(envelope-from <stable+bounces-255019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:28:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF05F3A82
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4105B303608B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42231E82A;
	Thu, 28 May 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auhMhcSU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1B2D97A6
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978079; cv=pass; b=WQggKdoLNkUOlRpABHM8iuFyjNELuSEVuVY7VfCBuw+2ANiHQGkOrHtU1mTWib8uDUgKF1B/FvYl/CGzH2bmM1IMormgT0gqPe7Yp4D6IuKlsJkPZI9FG6LvuV4QYvmbyYIyMsykGyndU8cYy0cSPXEOQZXk678alcd5slCoUxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978079; c=relaxed/simple;
	bh=js34c//je42ehN93ZjJa3FU5a9BRF/ma1UygPPSGroA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAJbm+2PcPNt7KjjJ2sfd7LFZgiLnt7IFDOzaeOvtLUFfmF/HzOVNwgf8fLIWFnAbPNQ4TgLp3QLYoEm7OzbJafJaaRdCHKk4Vc1sSk79zQyHt+G0mSqXouL3Qm6KrIqzOId1fqpUC4MsgBKUACLRrCGLWnbSalTHPn1lBbY5GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auhMhcSU; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso140a12.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978076; cv=none;
        d=google.com; s=arc-20240605;
        b=GKhPsKGDNJH18Dj8L4s5ZR2ZZQGu1J92szFecW9/db1jiJ7RXxfvZBfJH3mFl9MkLo
         urTOy/yY5MTCJ+IO9PxaSrBU2t5UXxX9LT5qrEMK+fAQdzAIaSIRG6RlXlc8tHAlVgqJ
         Z+AYDkcSoaGuowKcp9cl42WfgScRDktsfY/PDDKn8uq0XvZF4SrCHszEJVcPMTOafpb5
         dqmDLKHEIlN4bymfjsxmZX6buuomN1x8gvzpj5wvKBtIu5D71S1HBjWVili1euoZqla3
         EbuKBLKuNXmvXNFo5+3GFUUpoUNix9a8umJgJOTbRK64VAjt8Pdk0LiWuL993N+JFl2A
         if1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        fh=fqtuuEDDFizJsEGJbpWzh6Ld5bXY0YgzjTbuc1qrdB0=;
        b=ENcboEf4OFfHqnXUiSFRgPHX1ylm3lqbxctjARTT5EQdDiqoQcPMefKE0oL1g0mvhh
         KNAvcsNfyD9q3Elxs3fur8mqDQkZL0AvDpESwZejpy/rbCL2SudYGdfAvjw5Xoa+FBH0
         4jhA78iJd+oP4IodWOr2Cz5kwDEFigLJk/gtiJv6OWKScsMewfXzG03rXG2l3xEQtiSY
         h0nS0tNHNhME9qdgqLf58/t23p7ILeJCUmDgB5q9VxyfJ8rAHamRqVQh5v3W34aXmCun
         qP1VKPAno0/mvG8YflXLvZXuMf5LEStxSR+njpaqMBawSOV+NafxrsfXnrNUH8c54zdU
         4FgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779978076; x=1780582876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        b=auhMhcSUOfqf1SDln+pkwcH1LO0LM5tOZ68iAt1WXhvNbtiGRp66D8KwdwOcsD/t7x
         ryxmnx+YviSbjQL39qcu4Q6irzP9DR8WHuNfXsqCRpHqNk3VzmiOhcRzq8bAVbxwPB9U
         ROSDkJmDHinuIw3bNFi5rm44TVwv5bYybATe6BgaEqaF6UeWy7+rrsQAMYVIYsIUqr+y
         0gu1vMUh5SjJtslG3q3DsPdoloEEixrCkYL+4hWB6hf5+JYDLGHU2IJUcSOKGliytVRQ
         8n8If5L/wsBLzkm2WDzrYLIUgxe1KbCfcBb9DLGH+Zvigg4cNPArmWPaNfekRm42qmG/
         DnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978076; x=1780582876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        b=gtHXwRH52j9t+1nE3jOchQ4WwSM3ta6Em13JbvtMhr2Ds+RgJ7bmAoUhMxvPv8XmYM
         IXkI7TJbDaMNkU9LQQNneKjxKwwgw6NCjKT5qq86fABgN0mrD8gomXwPcgXtCqIcqhow
         7AuqsmoCmVgmL6Kpiu09F9Z1ng4v5VtT/M+ZJTteie/xOAVB+OJPgiRXBEKI8SzmhakY
         NuTRDZoJyMYQuRRIRBh3f2R8X27ixLaXHNnkjnwWkYCNd2VF18Czl8kS0pEmnI+KdixF
         h/wuI7trHiYOd7ZksNyhwy8/Xa9YhunvB96v67of4aPvKR/QNbv4N10ZGYok2eeid75j
         z5DQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bAQlNrkJxjUhXfKrpPxziVO8mmhXdV7APN4e93CQIqb7WFlJdy4BPafwePIkaME8b+J+uQTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLf/k+d9QlV5IIsNXj9qO5UMCnJUDxZ70mqCoDcr4yXbEtzu9
	peVNanGV8IpyCyvr6BAKuydp0XSKFyC6bM2TuBVIbtyjBPHnxoP/ZdSfEAeN01LdZNz+UMHrpTx
	9CR85nHp2XT4KtDf3cDLVuDME0fDHzyoUuyGNO6g4
X-Gm-Gg: Acq92OHCoi2aLIpj0VbPYmcir9DAcrPEUqhuVv4A+I2v30u+w0+zkbMXUPv4bEbe6j9
	RT0wbEbTxf+3Mxso8Ip5dCcN0qoJxgh+JCUffYx1fFdkvHEx3MMvMEazU//Th5Y8WohoMphlKA/
	aTPfDfx6BIRFVEC30weF6omJhvy9LhJxxxx2xMt9ipKKU1R+5w+TLz/uoOhweWmtT1KXPp38CCg
	kkOSTTuqzPyw5sKeRpwZfeF3i2aBc2rZh7YZPFvfC/qDJsbz6+kXxIEFVvTTN81FZUS58WtMi2R
	RfsgaoD/27h+W6HF+OIOJ3YVAMAr8zPXx7o5NnJ2lbFxzqeS
X-Received: by 2002:a05:6402:128f:b0:67b:6d1c:9585 with SMTP id
 4fb4d7f45d1cf-68b1e0ba9c7mr37591a12.8.1779978075876; Thu, 28 May 2026
 07:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <87wlwny905.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87wlwny905.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 28 May 2026 16:20:39 +0200
X-Gm-Features: AVHnY4JlrfOEpU_4BQJnUmH3-05d24mVTy1oiRn0qweLdreGyUfEGpJa7KT7h7A
Message-ID: <CAG48ez3Wp757fQh1gyTxf-k3p__utUOWM8xdJeUig4gPpSmTEA@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255019-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F3AF05F3A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 3:11=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> >> I have added a couple more people who might be interested.
> >>
> >> Kees Cook because as you have structured this it is an exec problem.
> >>
> >> Oleg Nesterov as he is knowledgable about ptrace.
> >>
> >> Jann Horn <jannh@google.com> writes:
> >>
> >> > My understanding is that procfs is effectively maintained by the VFS
> >> > maintainers (though scripts/get_maintainer.pl claims that there are
> >> > no maintainers for procfs because the VFS entry only claims files
> >> > directly in fs/, and the procfs entry has no maintainers listed on
> >> > it).
> >> >
> >> > In procfs, most uses of ptrace_may_access() should use
> >> > exec_update_lock to avoid TOCTOU issues with concurrent privileged
> >> > execve() (like setuid binary execution).
> >> >
> >> > This series doesn't fix all the remaining issues in procfs, but it f=
ixes
> >> > the easy cases for now; I will probably follow up with fixes for the
> >> > gnarlier cases later unless someone else wants to do that.
> >> >
> >> > I have checked that procfs files still work with these changes and t=
hat
> >> > CONFIG_PROVE_LOCKING=3Dy doesn't generate any warnings.
> >> >
> >> > (checkpatch complains about missing argument names in
> >> > proc_op::proc_get_link, but that was already the case before my
> >> > patch.)
> >>
> >>
> >> I think I finally have my context paged back in so I can intelligently
> >> say something about this series.
> >>
> >> The scenario you are worried about is when exec gains privileges,
> >> and we read through proc and authenticate with the old credentials
> >> instead of the new credentials.
> >>
> >> Question 1.
> >>
> >> Assuming the executable is world readable (which they generally are)
> >> is there anything that becomes accessible in that race that was
> >> not already accessible?
> >
> > I believe so - the gnarliest example I am thinking of is:
> > Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
> > sets S_IRWXUGO), so their access control is purely based on being able
> > to pathwalk to the memfd's inode. If you can race
> > open(/proc/$pid/fd/$n) with the process $pid going through setuid
> > execution and calling memfd_create(), you should be able to get
> > read+write access to the memfd created by the setuid binary that was
> > supposed to be private.
> >
> > (But I have not tested that and don't know if there are actually any
> > setuid binaries that happen to use memfds.)
>
> I don't know about memfds.  I do know it has been a concern in the past
> about opening proc using credentials before exec and then using the
> credentials after exec.
>
> We certainly closed some of those races, if there are still some
> of those races present we should definitely close them.
>
> In my thinking there are the set of races that exist because we fail to
> present exec to userspace as an atomic operation. Then there are larger

Yes, and exec_update_lock is how we make sure we can present the core
of exec to userspace as an atomic operation.

> set of races that exist simply because exec happened.
>
>
> Looking at it proc fd's currently rely on the permission checks
> of the file descriptors themselves and don't make any guarantees
> about the path.

What do you mean by "the permission checks of the file descriptors themselv=
es"?

> The issue you point out with memfd's definitely needs to be fixed.
> It should be separated out from the rest of the races simply because
> it is a completely different kind of issue.
>
> I wonder if anyone even anticipated you could open another file handle
> to memfd's through proc.  If so leaving everything to path based
> permissions assumed a feature of proc that doesn't exist.

I don't think memfds are particularly special here, they are just a
nice, clear example of a case where an inode is protected based on
which processes can path-walk to it.

As another example: Making a directory mode 0700 is also supposed to
prevent other users from accessing things inside it.

> My gut says the best fix for the entire memfd issue is to simply change
> memfd's and probably everything that calls shmem_file_setup to not have
> an open method.  That eliminates any chance anyone will do anything
> clever with proc.  But I can't see why it makes any sense to be able to
> open another file handle into memfd's, or anything else that calls
> shmem_file_setup for that matter.
>
> We can first try to remove the open method of memfd's set by
> shmem_file_setup, and if that doesn't work we can look at fixing proc to
> provide the guarantees that were assumed (as a security fix).
>
>
> As a quality of implementation issue I can see fixing the small race
> where when looking up a file descriptor through proc, exec does not
> appear to be an atomic operation.  I keep wondering if that is something
> that should be done in get_link or d_revalidate.

I don't see how d_revalidate would help, that still wouldn't be atomic.

> I suspect the answer for proc_pid_get_link is to either cache something
> like a seqcount, or simply to repeat the permission and existence checks
> just before calling nd_jump_link.

That seems like it results in complicated semantics, while a mutex
would provide clear semantics. Which is already what we use in places
like __pidfd_fget() and /proc/<pid>/syscall.

> >> Question 2.
> >>
> >> How does this race compare to racing with setresuid?
> >> Do we need to fix the setresuid case as well?
> >
> > Which setresuid case? setresuid clears the dumpable flag and has a
> > memory barrier that is supposed to make that properly ordered against
> > ptrace_may_access(); so setresuid() should normally not cause a task
> > to become traceable, though that could maybe happen in weird
> > scenarios.
>
> The cases where the dumpable flag get set are all part of exec.
>
> I was thinking of cases where we have a daemon that is started by
> root and then it changes it's uid to do something.

(Normally such a daemon would only change its EUID, which is mainly
considered when the daemon acts as a subject, unless it intends to
permanently drop privileges.)

> Looking at ptrace_may_access the uid based checks won't allow
> accessing of such a task unless it changes all of it's uids.
>
> At which point arguably it is on the process that calls setuid to make
> certain ptracing it won't be a problem.  I am not certain that ever
> actually works in practice but that does seem to be what the current
> code is saying.

When a daemon changes its EUID for some reason, commit_creds() will
change that daemon's dumpability to suid_dumpable, which will prevent
ptracing it even if the UIDs match.

The ptrace.2 manpage guarantees that a process which is not
SUID_DUMP_USER can't be accessed without CAP_SYS_PTRACE.

> Now I am wondering if dumpable should get set if setresuid changes
> a uid like I described above.

What do you mean by "get set"?

> > I think another case we should probably care about is what happens if
> > a process which is only protected against ptrace by being non-dumpable
> > goes through execve() - it shouldn't be possible to access resources
> > associated with the pre-execve state while checking against the
> > post-execve dumpability. It might be important for this that the
> > do_close_on_exec() logic currently happens after committing the
> > dumpable state in exec_mmap()...
> >
> >> Question 3.
> >> Do we care about the case when a privileged process calls a setuid
> >> process and drops privileges?
> >
> > I don't understand the question. Hmm - do you mean a case where a
> > process with ruid=3D1000, euid=3D0, suid=3D1000 does execve() on a setu=
id
> > 1000 binary? I think we probably don't specifically care about that...
> >
>
> The general case would be a daemon running as root forks and exec's a
> binary running as some unprivileged user fred.
>
> Mostly I bring it up is that it is easy to forget suid exec can drop
> privileges as well as raise them.

I do not understand the scenario you're describing. Can you give a
specific example you're thinking of - what the ruid/euid/suid would be
before execve(), and which mode the binary would be?


Return-Path: <stable+bounces-249350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIVAB7dIC2o7FQUAu9opvQ
	(envelope-from <stable+bounces-249350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:13:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 771545717B3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7A130B5846
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392037EFFB;
	Mon, 18 May 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9EVSeBU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABF37BE83
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124025; cv=pass; b=V/86s5FB2m1Q2qcNKQgKih8B4s+6/09GjghDpi42wW7BJOddR0ggAIu1bhvUA0sBRDdJk5RUJidRZSwjMcg52NcWPMUhOf3iwoth4FkFHLoPdvuIu31qT17mohZdNSdKh7N+5duQjmM/Jsu4tq0/6cVF2XOGsSzif74hvUYzOAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124025; c=relaxed/simple;
	bh=u+/oyza7yMnBBM1bP4jBLTY0KF+57Saj3R2F9P61tns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsyW3hRkGLwdYMEJXisqFgK9oHE558e66Ir6nNmirRVQKLhnY5XyDqcI521+FsmcdqlMe94CeBD8JULpVm0D+hazj8FOz43MgvfL0PZ8Cp9YaEugKdwBH0wfIfc9DoO8nBC/bowfNcSVlSR5hIByNtNEsRWG/fAm2K4/uT6e1UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9EVSeBU; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso263a12.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779124022; cv=none;
        d=google.com; s=arc-20240605;
        b=HcGC+glez0G9uc0GJ2qqjG3+Wkvi/UVZSemCIhKVn3RL0AEzf3+9efOlRSbaEuL2R3
         5PYkj78p2JxluEonqNg19ejvcrIYo9RX5ev5PayHKXYkzeK/XeKpftm1YL7dW2UfRJpI
         QO+Hhr2McdwQSUsTtPijdkpNJDMEu8RTMFDkE2mWj7wT6bLaE8a79crD21nf4SwsBia0
         I0m8H0M4CgdbMRNL59jNoxszDgQWSQPauPJBcTJhYolAuA2+vplpIsKjr95v19k/ggAD
         Iu8HgeSURMXpGS90c1d4Vksk50o+eLJlZHnkLSHXvxELWAR4ZKPWzWPi6hEXY0+QzW1a
         3tZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dAc2fCMTUkDP1AieE5yiC819W4Ul0vR1PY4hx/ymEks=;
        fh=WYsYpD8Bfi1MYuwDuwR1pYH7gHFBjBWkCvsdzDVNDV0=;
        b=SSUVLy9BE+TQOHuOQ9CNu804BTox1ldjKfxZYovWgk6jlnwc+HtnEUKcclsiQ23+AO
         XseHA9Tc0wFYyergmBvbKDIcOWKsWL7WtCDtz/CB1j6QQeqc52JQV4FtXLRjyYKaoUAy
         xnhDPSEEL2sDtFtb+6h7reBTMnlr94hVQxdLvQ4jmX/ULN5O2hxHA1vTiiwxT62qajAW
         SXDX4xY9X0jf4hDFRu/9mQgvJJbbWVsHjK72vHC7FyrERc4LIXE91kZmxJ1EnHReMTtS
         +FQqja4NkLC7G5kCvKUkq5hMVhLypE79sG9V6zED+tCj+zAwtfBSiT6Y7AI3J+j0E24d
         aVWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124022; x=1779728822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAc2fCMTUkDP1AieE5yiC819W4Ul0vR1PY4hx/ymEks=;
        b=c9EVSeBUbVy5Bh/5MzH/ioHlUYHdJWc1FRoKI+S4tecECQdf0/cLwn1HklB+gWhXQG
         J7DY07N8FGXBfYKdwMXfOuhnBiBUxvTW7GufLPCro9guLjsBjk7CZKElrWNV99Xg89pK
         flZyAo08Sgx1PeBXis1zqrX3mxZ6b34Z1wtwR/QDmrkiBDCBctHUP6BlS15UunQ8EwY3
         YfloHqe0FFHbX5isU2yLHNrpjtZVpkp9Xx0HPk9L5I/kzbbbfMRERw4NuMQN6tnYYAxe
         MGHuiH/lUBmtEyQH64VMxUBs+t+Ut5SfsSnY9Arvm7rrodvyT0p6yUSDIW09GWsK4ffg
         +Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124022; x=1779728822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAc2fCMTUkDP1AieE5yiC819W4Ul0vR1PY4hx/ymEks=;
        b=A7otztQxDWvqzcaFSeB16hLGXEBV+PT4RV+ioMRmDmUsJV1047aLoMIyrumqQTMJYV
         9a1Y86eB8Lhi6aneLsmeQtXUN3J8qPOLT8b/+EIfWi6oLpTlYtfVDqAonU+n+euib5PP
         w242R7jTOmCfv+bvHfi8GhKHNObY82mxFXXraI6BgtavInsJAPnJBpJGLB88T00XS9QT
         Qclx0PCECkR9kfdznEhf33iKYcBgpIj90OE1R6h4pM2c3JKRZ1y0jpgiPMCCZmJtG/LT
         2VOR7KyxOP0hoYpoZ3hOuvpoI2axa1XfGnAhw/Q5R/1NvrPEE//2RvmPFlssBsiB3UbA
         gjjA==
X-Forwarded-Encrypted: i=1; AFNElJ/jETlVZflOm42NVfSRjp6mb/kpFAEqmrY1m0o3C942dCag+NeEy0uuJLAjqYcVNr/f3xiXVOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBa2LWSxsQIrB3xpipoxLl/BW5k4CXde2i9KKwC2QTi5oq0SH
	kA3FFIkVaXiBeDP2czCxRf/FwD2v3VGRGE3lGFxdAMH9j8JG5/MfKeMFIFzCQpo9Z6CbyGrpnmj
	bsMnWf+FZQ5BiazOc814/cwR5Rmnj0bwagQqjTL1d
X-Gm-Gg: Acq92OGN3ChMNXMrqH3Kf4GjYE6VMZsOVVuxIvIVCjzy8NlsXcGf/+TMBOLIKdfMRIo
	+ZuyqQtwM4j/BvahY452jyLNhdilXY/nc53F9b+2E3pYum6NXN+kLwKM4F5HxM3gLOJtxbnONGE
	T6r9wOe+dAlRDlItIyeBFy8vFY/MMkRMpds4V+cdvBXB9CPOUK2yeUnD5qZwMyb2By63REEv0YN
	1BvLC8lyfAiy0h+Gq3GddROWa9il6gVKEgAwo3X+VK5IDX2ouUB74CFgcUzJ3zHyRQT0i6xWAi9
	HKXNs7AOqGBccxsCdNejnCIMkohq7vxBf+lAEcYTjJoZcYk=
X-Received: by 2002:aa7:d994:0:b0:678:93b4:1fd3 with SMTP id
 4fb4d7f45d1cf-68489aadd24mr106742a12.6.1779124021571; Mon, 18 May 2026
 10:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com> <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
In-Reply-To: <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 19:06:25 +0200
X-Gm-Features: AVHnY4J7uTZVu3VWspc9GgfysKp-lVvtARSbXVXvqVI_-MuHqBAL5ClZcJ4MwN8
Message-ID: <CAG48ez3_ocrFct3KJBFFzXoa81dRpBOenx1bkJBdrrzYgMmFsw@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Qualys Security Advisory <qsa@qualys.com>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249350-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 771545717B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 8:04=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
> On Sat, 16 May 2026 at 10:32, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > That mode thing is already a bitmap, so one bit could be "require it
> > to have a MM", but I think it should probably be done in a way that
> > forces the callers to think about it a bit more.
>
> The whole "fscreds or realcreds" bit is completely broken too. So I do
> think that we really need to just fundamentally fix
> ptrace_may_access(), and change the calling convention.
>
> Just as an example, look at proc_pid_wchan(). It uses that
>
>         if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
>
> thing, and that's pure and utter garbage. It's a very traditional bug,
> but it's a bug.
>
> Why?
>
> Because the creds used for IO should *not* be the current creds. They
> should be the *open-time* creds. That code shouldn't use
> "current_cred->fsuid" AT ALL. It should use file->f_cred for
> credential checking.
>
> This is a classic mistake where you make a suid binary a file you
> opened - open it as regular user, pass it in to a suid binary as
> 'stdin' or 'stdout'/ 'stderr', and get information (or overwrite
> things) that way that you shouldn't have had permissions to do.
>
> The user filesystem creds should be used for *open* time checking, not
> for read/write time checking.
>
> Now, this wchan thing is a case of "not really impotant enough to
> worry about", but it's an example of how this ptrace_may_access()
> interface is fundamentally broken.

The current implementation of PTRACE_MODE_READ_FSCREDS is appropriate
for stuff like proc_ns_get_link().

I agree that calling ptrace_may_access() in proc_pid_wchan() is wrong;
but I think a good fix for this is to do the ptrace_may_access() check
at open() time, and only allow read()ing from the resulting file as
long as the target process hasn't called execve() in the meantime.

We could try to do ptrace_may_access() with ->f_cred at read() time,
but it would not entirely work because ptrace_may_access() looks at
things other than the caller's credentials - there is that
same_thread_group() check, and yama_ptrace_access_check() also looks
at process hierarchy (in the case of PTRACE_MODE_ATTACH_FSCREDS).


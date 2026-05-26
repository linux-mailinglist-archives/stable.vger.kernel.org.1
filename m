Return-Path: <stable+bounces-254417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI88JlHoFWqXegcAu9opvQ
	(envelope-from <stable+bounces-254417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:37:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE55DB6CB
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56792302261D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0291421898;
	Tue, 26 May 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYNa8eZl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904B40B6C3
	for <stable@vger.kernel.org>; Tue, 26 May 2026 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820299; cv=pass; b=c7rUgB7i+bXlsg+SEH6Yl2GTAUOa28e5vYOvzsoeX/FjucWFSPOZIMWJvhy2UJPhaEKMur39eGT7IjEqlpNyVnUiUm0cK0QPjVD4QYgzhJK6nanrqEIUMGRqdyv4bIv7yL4Hznhg3BZY1hD/sG/8TB0WPA4kvIrrqkdjbfW7PgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820299; c=relaxed/simple;
	bh=/5+vAEgH6rFZ7VGwpIrcSyHpEzUK+m8zCzYVaRaOEcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R37CRNB1BwastFPlbriaMDrDi0MODmWbxY9THKEhxQWp6ZIYaTmrB5NDa5lftMjsoMJuEbuwCZKQOAA2aVXlSPt7QCLODpEVm2i4ju1QQr+Lyjj2gcdOdWMbWqjXIjjVlwvQOLkJIpV5atI3gA7Rw7AyjiqbYwXFFCivmPWkAJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYNa8eZl; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso185a12.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 11:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779820296; cv=none;
        d=google.com; s=arc-20240605;
        b=l0qJAMBMpHkueM1UEfrUuzVN9uounb1Dp4Deb4YVdnyPY8RNzUwModHTxwJfJyEPO8
         /57qcxBrWyOHVEFpveACJM6XuezYMbKG8Xd8E7IJVxu6ohj3qqeFTlw1VqQ6QZf+9Nu6
         Eb+sHVxSf0k+fxI4IDe4OffL5QUyoM94gY3Gq1O+SVNVHq8Z0rCIfPCuh06orrfRqVyn
         4DVtfGNUpEBoltWsxr44B/a/hcJhloFY6aQHE/uFQIDVqB5VEVJeLU0LG3MFXO7GmDvi
         Va4Mgy6ecT1FwuPviz4FEAinFO5/FY24pylUjkaE/Z7qnlGwOUSI9t//Y3WNHdb14rqA
         NebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        fh=FeePI1P5Vk25q4xJC0ermpz42zTDn1r30R/f0eNCl/E=;
        b=iIf82xeizRZik5F0cXFmhTlJvczVFnQB415HgW5USEzDavsvl5HWaaL304BZaGiSyH
         d+bvsDp9NNg3n+6oWHHi+DS1BM/gRX2GNGnuwxNMK0tsd83B+RbtmxTr6y2mlPB55PYt
         timEyohIdMgdpPq8OIMnJu1dEb1cDTmB0oLRD1T88q3j8vwGVToJ+ge5mUXVFcYrYLbD
         6wcYKP477+qS5/4gC9KIUb1Lcqf1UUfT6usZUW6xleDosYdHCeDoxApdQBQSsTbsIdVK
         VHWcItmd1zvH90QJ+131rlMWmv7v7yjsvgXRCNjrc3/SE49E2Xc0XcVvJotOr3WPtQ3n
         xZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779820296; x=1780425096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        b=JYNa8eZlIsKgeuSgZSJNegqWUB0HqT+gWZlDYW7BVWX0LafSE+UGM3F5OBYR8hyg6I
         y2e2aIGuN8CNv+WqghM5LaOla73x8YRIwzGR1bU1659AKJP3OX3cHRA4BezeQcFRX5zJ
         hZSAP8sSKA1JPyENPqJDgZKYf8541GnZtZwBGwGPG1hP3AEmINADUKUOENMzX6YWkHMk
         Q6Gnt7Kq9ST9bHMOyll+KkCd1vWY/O11/bvi7/uO8ceNKx2RDyQiBRv8T99nCHRSKHQk
         eApdbKlOlw0+2Y0h4azzc4l6SgsprMcUgwEEHqly7MJy8yTqcSrX7xP/45AA2bOuplYm
         WlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820296; x=1780425096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        b=l9iG4gJ6c9DpXO2LMpP+nhNnCBN9d3k784RzyB4SVVJzRZwDp0JDZq7PBCi/eMm0s6
         2wbhX07QM3Qhil5ibwYSzj29N4Vhn0cpkKgO5CZhbXpFvk3FxANOecba/UXBERDg7Kx0
         jJAsUoSQ0xFmx6LHHtRTXoWAQtbvBIOJ7Yj2NXgrQpwTw5bTtJlvMkJqYAEoj16w8PDR
         mJqsiwj6D1vX60YGEpimu9CoMp0CQIm1RpMJEuHYHIPy/1Kj4iF/LQe24FKHnoDhKL7p
         goO8Z4pNSOf4VyDgxaPXM3Gb5e260lIDMI/9cieQWX/8yMXxr4EP4A2ftvFKBYPVXRQb
         4Ttw==
X-Forwarded-Encrypted: i=1; AFNElJ/6jlgcfUv61lMBma7tmbkHXFvdMEpqHJqhJnCCqLhLUBNNG/qcfowBQnvhuys4rOLPbjG4mYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1dru6uYO8UxBXdWjM4kyPSL8guMl6Wzzs1AhQ/yCJXkFdgCH
	PHeEH50C9XRYvEtq+tdoyMGFaDrPxI72dQJXdLVIujhHc7mYN2upa1/xGezml7WpplYZ6Hz/pEr
	cMherUgfXh+vWCMwnxkPXwlh+EBHRsNo4iUedyQKj
X-Gm-Gg: Acq92OEIEgmdtT1LxYjaO69ltyZYKgn7vR0InF9WbpLi3atgYN1cQl/d5E4ag820uHs
	VnLiiv0IF2hw/hUQbu+ck0zIx2wv7FDpow231+PI90KfnbG1mU/JgPsQtB0ZXCuMAcTyip2XnJj
	4NKQdXJz4MBVq4KRn4PM4ZoJJyBsaGC0Qy8Zyw1vgKNuydq8xHPMqCdyIh3GQnqz1L6c5K03S2Y
	cn3YN8QkWEyuTrg0OozlBO3dOCbgmfxFxCfq4k+iKyNJRJcKDzR+N6oy/4yV6GjH5PyncUo3+aG
	4Dp1QjbZ+Cn15O3dUT1fsepYDJwTrrIcAC+j9bH68iD5uwM=
X-Received: by 2002:a05:6402:534b:20b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-688fd0681a6mr139240a12.0.1779820296179; Tue, 26 May 2026
 11:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com> <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
 <ahXk0lBmeewqINHh@redhat.com>
In-Reply-To: <ahXk0lBmeewqINHh@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 20:30:59 +0200
X-Gm-Features: AVHnY4LuoQlinjRspeV8e6aumcDxAU8ZpBjvLoLqcRI91yjMkt2lsu3If10i5cQ
Message-ID: <CAG48ez12wbXQsD4e8EYPS=jLQz3H3dDUn_unbLjvaMgkyQdX9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254417-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 14BE55DB6CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 8:22=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> On 05/26, Jann Horn wrote:
> >
> > On Tue, May 26, 2026 at 10:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > > On 05/18, Jann Horn wrote:
> > > >
> > > > Fix the easy cases where procfs currently calls ptrace_may_access()=
 without
> > > > exec_update_lock protection, where the fix is to simply add the ext=
ra lock
> > > > or use mm_access():
> > >
> > > I thought about this too, but I do not know if it is fine performance=
 wise...
> > >
> > > And what about proc_coredump_filter_write() which doesn't use ptrace_=
may_access() ?
> >
> > Yeah, this series doesn't fix everything,
>
> Aah... Of course, I understand. I wasn't clear. Sorry if it looked as
> "you missed proc_coredump_filter_write" from my side.
>
> What I actually tried to ask:
>
>         - Do you think it makes sense to fix proc_coredump_filter_write()
>           as well?

Yes. Another example I've seen that should probably also be fixed is
seq_show() in fs/proc/fd.c, the handler for /proc/$pid/fdinfo/$fd,
that also currently has zero checks at read() time.

>         - If yes. Do you think we should add another down_read(exec_updat=
e_lock) +
>           ptrace_may_access() into proc_coredump_filter_write() ? Or perh=
aps we
>           should discuss other approaches (exec_id/seqcount/etc) from the=
 very
>           beginning?

I had thought that this series would be the easy, uncontroversial
improvements, and that we could then think about the harder aspect
with read handlers afterwards. I guess I was wrong about this being
the uncontroversial part.


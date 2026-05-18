Return-Path: <stable+bounces-249357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLZUJuFWC2rZFwUAu9opvQ
	(envelope-from <stable+bounces-249357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:13:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F870572095
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2761A3069091
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA238B12F;
	Mon, 18 May 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eaP3uOrg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED9382F03
	for <stable@vger.kernel.org>; Mon, 18 May 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127489; cv=none; b=ZZRsv2hmRsfnt7XykpPTzAPfcJTSeGUcvw1aOpeYwpT6ry84g3j7FaTRn0G0peNvWn+FJJ2mfAQWzpiBWoDsfgVjdlnFZcvj5E0SpClvk/WmVz7Hg62QmYv0AMCKCgs3X4d8l/8TgNla1E8O+jFAa8HTiB5rxLwbtM6XVDyaX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127489; c=relaxed/simple;
	bh=ZTXekycrdcARK8zN+ckCwrh03qpS8uOrR4DktonbkAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbtXjT9BvZ7lUup4m5FeHv40f576j8wRgPFuPlEJxhW0IaC0086NjF0eglmsuDo7hvUh2djwLNIK1bobHKvd6Xz+L3PU4b0dIctRRkdNjgNvAy+fFKS4zVsEqjjbV1Zj8RJVMBQOKCF4qRx6SsOQBCerSXsX1ockdoF7KUEJFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eaP3uOrg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so4543319a12.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779127485; x=1779732285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUFfFGSoptj+X+A+YrFRt/y2F/l8osvryZE4iGTEyPs=;
        b=eaP3uOrgxNNz+H5B0jhNwNgVAOuKeXjk86clcVc84GobvCS1UkEk5qu/aTEBNsnR60
         XJeJ2uQn+RBNjDvL+vERUFU7t/7bFywWvup2w31+nxegN3Zi6DEUV8ZKGj/8CCizu7d+
         bHzalJkRUHaCLSasHj7XXS60/H2JbdNzJQstI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127485; x=1779732285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUFfFGSoptj+X+A+YrFRt/y2F/l8osvryZE4iGTEyPs=;
        b=KwPUb9pZzcL2l1RBZQndKgtV25HN9l3Mj9QfgQPZbYYhudofQD0hIitF0Nq3roEjtr
         HCTKEvccqclflXo+un5LL8mNUDC9PffC+d+78nV2FNNIZRIqUFwb1gaILSq1/E2aPo0b
         6CKvrw8K4x4XYpFa8LYreEmr4YQmz+9XpCQXGOf0EBiiljQ0vtrI7Jx0TF5tOU6BmBBu
         Dq5fGLGzH6VEHDhyXTLIK1CzeQBCSv3HUPWs02ludMcHu9XT0xu70bA0YoQouWGiYqTA
         OKPVfVmyaf9OJnj/br/VnxcG0Rdyom9iDnRI9DWvI8OUSwn8pXALMKCmHMIKlaeAUaib
         c1Gg==
X-Forwarded-Encrypted: i=1; AFNElJ+OdkoxDqpuqvUJCyv7ibwzkPz4a5S7yO5jIt8AZ19YJVfeFcJBtIQ+tFFAyCcwc0NZjWtVhIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplnitWdEU434hGlBUGnknolI2716a4Os428OPflZGeXB0mmH0
	HcIQcfmNbdTs+dGzazAlYM/NliMl8WAAxE3dOmezXL1vBUopc5Oin1btb+WyktTwoIxi7e+lEEA
	7BW0WuOE=
X-Gm-Gg: Acq92OEyd+SNeS5NmBHvaE442CMNLZRYVD952Xtbo/Qnbjgwe1OGzIWFXeR7CHRhUUq
	+jFa7ttBNvpIF6ORwbZU2e4ZXHNJoadpx0fCu2X4wA4O3QZKGt7IK1WhUo83asXafKs/oAh8jxU
	AIohNCZrNbN2ROkUjhF4bwcMQosTqxA9Y68wtgLJKQ5eGcisxyeT2VlTxeFIvv7HsoRc3qV9fyK
	6yBRUSijd0RhKiO0MNy5dBBpboAxHODGtpjM2UixBOs3Cq31Fdi0Yesz6gP5MdZYXkrnt7pXVBF
	G6UFT57yMn2WFVwUfP2FpiT7bPSgyTEKWwPCittvk3iEhJEOanwbpsQmkAIi5hDExMBNqs7fgec
	Goe3yCDEjTnJIMwzP/IcxkdGkg2LgZwYh5paNtRz66w/O8C4hkzlHFWTDwzKqLxblKkmUADKojo
	HUSGXyRRIxtEccvoGCTMT+jjPjvKseU3ee2tk+dhsaxhFoSiuAzvsfBB7bTvmHsoV5ZSpY2HZyC
	MMGgb+Z/A==
X-Received: by 2002:aa7:c78c:0:b0:677:1ce0:c08d with SMTP id 4fb4d7f45d1cf-683bd58a162mr5540620a12.18.1779127485198;
        Mon, 18 May 2026 11:04:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecb7sm5380885a12.29.2026.05.18.11.04.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 11:04:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so5208158a12.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:04:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+FzYCi2Yi3HP5c/Bxs6ceVrwawuLR+OnCPypepHEKW6qa6e0KLAYL6aeYnBNw93QCgOzdst8k=@vger.kernel.org
X-Received: by 2002:a05:6402:13c1:b0:67c:d93d:89ce with SMTP id
 4fb4d7f45d1cf-683bd99e2cfmr7935976a12.23.1779127483190; Mon, 18 May 2026
 11:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com> <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
In-Reply-To: <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 May 2026 11:04:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
X-Gm-Features: AVHnY4Iuqm2qdDMtQoiKT137Zy8z_hIH9OsuwlmdtH8RYsDWTSLR9WP4V5WBXZ0
Message-ID: <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Qualys Security Advisory <qsa@qualys.com>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249357-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F870572095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 at 10:20, Jann Horn <jannh@google.com> wrote:
>
> I mean... /proc/$pid/task/fd/$n probably has the same problem, no?

Possibly. That said, the permissions on that directory changes when
the process becomes a zombie, so it might almost accidentally be ok.

> pidfd_getfd() is just more severe because it directly creates an FD
> for the file, instead of going through normal VFS open() permission
> checks. But /proc/$pid/task/fd/$n is theoretically also dangerous for
> stuff like anonymous pipes or memfds, where security mainly relies on
> not being able to reach the inode.

If your security depends on "not reading the inode", your security is
not security, it's a joke.

The /proc/pid/ interface has been around forever, and that's ignoring
regular ptrace too. Files have absolutely *never* been private, and
anybody who thinks they are some private thing is just wrong.

And being a zombie doesn't even change that - files can stay around
afterwards, and it's not a problem.

I really think the *only* bug was literally the whole "people didn't
think about mm->dumpable as a security thing wrt zombies"

(And the entirely unrelated bug of IO-time vs open-time, which we've
had many many times because it's such an easy mistake to make).

> I think that would be kind of ugly because here, the MM is not
> actually used for memory management thing; instead, the MM is just
> used as the one place we have that stores state that is shared between
> threads

I agree. Except it is *not* "the one place". We have multiple shared places.

In fact, I wonder if we should simply just move "dumpable" into
"struct sighand_struct" instead (or "signal_struct"). Those stay
around until the task is released, and they kind of are more natural
for core dumping, since it's about signals.

I think dumpability being in the mm struct is mostly a historical
accident, and the fact that it was about core-dumping that writes out
the mm image.  And in the very historical setting, the "same thread"
was about the mm.

But core dumping is certainly *also* about the signal state that
writes out the mm image. In fact, the 'struct core_state' pointer is
in 'struct signal_struct'.

And with pthreads, the "same thread" is actually mostly about signal
state (ie the defining feature really is that signal group). Obviously
pthreads doesn't know about clone() and other options.

What I think really matters is that execve() will always unshare
everything, because that's when you get more permissions. So whether
it's the mm or signal_struct or sighand_struct doesn't much metter.

But in some respects the signal structs would really be better options
for all of this. Both for the pthreads reasons and for the "they stay
around for zombies".

Hmm.

              Linus


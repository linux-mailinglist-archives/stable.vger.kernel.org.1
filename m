Return-Path: <stable+bounces-249640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FfnH5mSDGp1jAUAu9opvQ
	(envelope-from <stable+bounces-249640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348358286B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B00F300902F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2987407CF1;
	Tue, 19 May 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DT5YpL3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A053F660E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208527; cv=none; b=i2QNxgxSB+QzR3alHai78Bcob0Yk2Gpvg4QmVXVBiuzJwRPLv0vib238qTHl4tAUEsZTffq4oIk1DXMO2F7n5kEREXw2PuwImnb/TYbqUd2fzVU+FPOawTzYUSn6/ZZJU2BFUi27PR36PRACPn92yY0aR4hcpW2vZsFeNRwKGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208527; c=relaxed/simple;
	bh=k9mbCai1MNnKEsP/pjwtInPRPk68NXdhRhWhHBwjoSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI9mdU3qojQSFl2LQTa8UQX+sH+JoPgyECBZUaZFpmoCCZnypx2+kNNrKtD7PA9v+dC5z0tasKHoqDnzna4LP0Ujb+UjwXFYRFXg90y3IfrvkMEAqUpIBNhMdDEcWfuwqYqSCKvOpizt6sYozRgd/B517jS8VEDCVGMwlpmF9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DT5YpL3C; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6870a365c77so64691a12.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779208524; x=1779813324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NiNM83ZQYTuKfyrru+DlBd9o7+KhR16wDR5z2HsiXKo=;
        b=DT5YpL3C3KcDjTKdeSHYriKR3P3nN56BY9IeZjakYWV0ZfoIoaA1Vlb/k2A8qOzgx9
         BZxF4w2MYIwctPjw06lycM9AMuRI3n4gmggOAE7bihlE3L42bcI577rM9/U+jWt0WleR
         iofCiqGy1VM/+MjqK8ZYlwLWthhfmpEAsLKXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779208524; x=1779813324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiNM83ZQYTuKfyrru+DlBd9o7+KhR16wDR5z2HsiXKo=;
        b=OV4nvFnuKllfu+l9els2jG8NNGyuVu8KA2Zp1xhPbXt29ehUMYfqvt5z4u2MtTbgtZ
         pK5N7I0WegSaN0qpJdRWOFrmoc3gbkgnSv06kJiRMwqo4PGQ0RwwqDV6G2J5Lx57TBnG
         /+2dqYyQRfZf0iRZwe0d4RtiDbhWroYCoEHrhA9EQ8EQ82CrEDb6HPsWEPaKxwaNQD37
         uZ9jCnWLDckyIYdU7RwBun5qIjq8UohIdE5KuhdAz9pnyeAJ9VAjPQzwlWxTI4pBZLYY
         iOHk3qm/CNllGdh8Es+B6Xp9X6yPHTxE3N2fUSH36mjNU0QTxNs8gPvdUNOG5zJspC0l
         Ojag==
X-Forwarded-Encrypted: i=1; AFNElJ+Xx45UuA5OyL/gZU8Zv2/Ua8aJJLzKdPw8ds0e6PNOZ4pg+BZ0vOOkU8aS/t6KKB86EC+jdDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5oNn6PHqv2mACQX1kLaLzgv/76Av06pHMsGC5Tv/9v/31jmJ
	tyDtLu+t6/D2cahofPxpCZnO0RuX1GLw1I3vPzZgNc4ec/BXL/V+VoAx8lzheZJPReuwk3/5S/A
	hq1KIW/0=
X-Gm-Gg: Acq92OEF/MkUXLNsh2JkSdH9rPXV/W2FTq3W1izuNfYWa5oDWy4zDlrcE15X9cTa0DU
	brkckB/eGy3f+NYdDe1ZMzf2GZoLtbEwJ/lj9i320wvQihGjJVkWTjWbxarWPDaPCVk6heu8vQN
	kg6KpTDkXwQFTP8Gc4ke2gOZoTQSWfC3Nyp7XE0HIUkDYsRuhkFqzt+g8OFl3isF9tXF5i/0Nes
	ZnK0DtTxehUnVlSFwSg6BAMjbsdhvZMnLve2o2dTWGy/6S9yvtDGhBqcobTsdPbQ6Uf/HE6zS30
	sKR0vLii2XxcCgGwQZg4juMFvyKNlbB/bwGDqyO3WfsAM0TgbKDyFwkydHONGgtIPBDLWugSJvj
	D1agwk6xSHQynQtIsZFvNfo+cH98hisA4DQEKUpo1PiMlCJCyEiXAeTDoD4tJ4cZPFrhQPaGca8
	5SyhIyp/mExnVCIxgvlKXdeVUdnWred2ibBJLjF4gf0QqS3f18Hy4RkmnvE4DSjqsSz7900hyvE
	M9M1qZX6w==
X-Received: by 2002:a17:906:8e0e:b0:bd1:d244:ca24 with SMTP id a640c23a62f3a-bd517861053mr1207279766b.14.1779208523761;
        Tue, 19 May 2026 09:35:23 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm724883566b.59.2026.05.19.09.35.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 09:35:22 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67e24b8ef55so6434481a12.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 09:35:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Wn79xbXzOOy3ptPsQrvzjwhLohQIM0/5n66hYHsOKMxJPe6LS9FNvKPkoa3EvouqaAPRHsIU=@vger.kernel.org
X-Received: by 2002:a17:907:15d5:b0:bd3:1b44:2ec with SMTP id
 a640c23a62f3a-bd51785f67amr869397266b.15.1779208522442; Tue, 19 May 2026
 09:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
 <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
 <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
 <20260519-gehversuche-lokomotive-cd720c53bab1@brauner> <20260519-lehrling-backt-261d022de809@brauner>
In-Reply-To: <20260519-lehrling-backt-261d022de809@brauner>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 19 May 2026 09:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+NgoDH3GSicJ140SV8OoDd71pLmL3fgFEsTcgoMC6Og@mail.gmail.com>
X-Gm-Features: AVHnY4LU0PA_bfa48mWWsfNlNCKTB0_1yiHae_SgLHiE0_gyU2glxZoUUeLssSY
Message-ID: <CAHk-=wj+NgoDH3GSicJ140SV8OoDd71pLmL3fgFEsTcgoMC6Og@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
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
	TAGGED_FROM(0.00)[bounces-249640-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0348358286B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 08:49, Christian Brauner <brauner@kernel.org> wrote:
>
> One thing I played with is to move dumpability and exec namespace into
> struct task_exec_state which hangs around until the task is freed.

I like that just because it would actually make *sense* to have some
kind of "this is the state that we got at execve time", and just share
it across all processes that started from that execve.

But I'd go much further than you presumably did - I'd not tie it to
'struct mm_struct' AT ALL. Even a regular fork() would just keep the
"this is the execve() that started this all".

Because I'm not 100% convinced we really want to synchronize any of
this with 'struct mm_struct'. Yes, it's what the historical behavior
is, but does it really make a lot of sense?

In reality, all "normal" programs will either share nothing, or share
everything. And in many ways, 'struct mm_struct' is not really special
wrt any of the other things we're sharing. Certainly not for anything
that uses

    ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);

which literally has nothing to do with the mm.

For that one, it would actually make more sense to have dumpability
flag be about 'struct files_struct' (or 'struct fs_struct'). But
keeping it all in some "this was the exec that gave us the original
rules" would actually make a *lot* more sense, even if it then got
shared between fork() cases.

Because imaging that you had a setuid process that started out with
elevated privileges, and then forked a lot of helpers. Those helpers
still have information that may be privileged, and if they do a
'setreuid()' to drop privileges, that information may still be valid.

Only when it really does a new exec has it changed "domains".

Now *that* would actually make a ton of sense to me. And perhaps more
importantly, that kind of "this is the state we got at execve time"
could then contain the actual execve credentials and namespace, so
then ptrace_may_access() could really use *that* information, and not
the odd hodgepodge of "mm->dumpable" and "cred->user_ns" and
"mm->user_ns".

Again: what makes "cred->user_ns" and "mm->user_ns" so special - and
we use both of them for different cred tests - but then we happily
cross pid namespaces, for example, as long as the kernel mapping is
the same?

So I think having a "exec context" would make a *lot* of sense. And be
quite conceptually simple: it would basically be a subset of our
existing 'bprm', except it would be attached to the thread, and then
clone - all forms of it - would just increase the refcount on it.

Yes, this would be *very* different from the current 'tied to 'struct
mm_struct'" model, and very visibly so across fork(), but I really
think it would finally make all of it make *sense*.

Think of the fundamental race of a suid binary that then does a
fork(), drops privileges in the child, and does an 'execve()'. The
child process really has a *lot* of potentially very sensitive
information in its mm, but currently we think it's all accessible to
the user that matches the dropped privileges. Isn't that fundamentally
wrong? Having a exec_state would fix it very naturally..

                     Linus


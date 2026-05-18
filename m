Return-Path: <stable+bounces-249351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IIhMmlKC2o7FQUAu9opvQ
	(envelope-from <stable+bounces-249351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED705718CB
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74E8E3016421
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99C34DCD7;
	Mon, 18 May 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJTGufjX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27B3815D4
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124836; cv=pass; b=ThKfvoAZZbyMJ6WzKYErpbLtrBFeNTgQdVknBlozeAsP4d0GZRynhL+mLuFK2I3YoxEE6ynqDjU4m3BvrywnpIRlaTH3QZTEPepWZs3NI16+xW2Anv7MHAPLc51KceEOn89mIXWdQBOQ8eWKL0qlnn/vAbQLz3XB4cYamTk2cU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124836; c=relaxed/simple;
	bh=1S1j85wWow1fE+PTjvTuFPIBUQaE7MqpQtw1l6nHQJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMNNASAG/xKfksM6svUxukgSsNXB55GDdjpVzTCTnnnPOUFUZ5tIxpbkWEJepm1tGiHzNRqt36ygjtDu5sg/5+sR44sP4apxfrEyzRduYmeQmQvm21ARUJ3A9w5z4gpYAI66lShwbTUf2nbeXCzsFPZM6My2tZCNnMf7+w1DXmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJTGufjX; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso192a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779124833; cv=none;
        d=google.com; s=arc-20240605;
        b=kFy8FEkkDzIw9QzodpQzS9MDoYA2eN+Hlf/Q4bJit3Nic4uheIcDq4ZiwcMtftAXU5
         Fpp0YeGYBHqrYNYvz6zI+3FfZRuutIIEl0qxTgiVq00qX82Lvam7hOuW0TKEYYj/KMdK
         MXJ+ST5tVHnwCoxJpYkCyetxCqA5aJbeZVxhduopjXeHjUz4sYKp0ctS8WOJQyV7l5iy
         7JOObqRBujrnunI1qgjthu4Y3vqVpzVt09Idn4tUJYSpOnRcPkn9iDIHUaWq0FFgLINj
         IEBNIAxf6kRnCjKsN6vb9M/3FFVXh80bmfNnikucbq3aL8y/qmGlMKFeVgcm32ZmFw0K
         B5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1S1j85wWow1fE+PTjvTuFPIBUQaE7MqpQtw1l6nHQJo=;
        fh=7bjHNGix10sGS+5erO2WRwsSaPLn65v1IWwoA3rMxbA=;
        b=IXm30J3JHYq1sVJ5kvKGOcc3jCqWVJGU7oAu6Pmjn7CKWpJCcR5FSPuLjHq+PFcUlk
         /zV3DfCN7iZmJlbDqGO+Tu4+8gBF122Bpk03ZzUsbEqqsQVt/vJkCZ4vEk7sllyI92yP
         IGINDzDgLzdSagTINatkl4xscoBK5LoXXi/G/WMQ3PeOt5daM3GJyiWVQhMQ8U6IlUzg
         gRuL7zfFi+AX6cJYEZvaK0lQQs3AFpM0lXt+9pDPDhUoMwekCTSeYhwJKvkqEqcbh/ku
         kbG90F2CXOYZE/0XDmHgXIKtLJ3BEf3kjqEA4Vamg1b0oWijiK0X5195fAWYgyDpQb6c
         u3BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124833; x=1779729633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S1j85wWow1fE+PTjvTuFPIBUQaE7MqpQtw1l6nHQJo=;
        b=lJTGufjXpOunPLtNR/S19dSxvgz7Wldlc/xknSYm4k2gVVy1ii7cAS4qOiEJ9Xm/uS
         y43kNqeAIS4iueVLsi6KHo9ONpeihC/EknJ1RpDdzISwP7VXZS0cM+DdhluUpbyZPX8k
         Gzs7nnClXRtvvLB+MFSZVIlufpmCGe3QBbi+3cwr9cP8fUwmOVTw549LnFiTTP8a30D8
         e1kfR8pHl8J/s9Pk7TLPBHOJWxwBFvXOGXrnbBWnot5K2Cee18tVHomHwUc+ahzWN/Lp
         p0ldPkgtl1Z7I9RfGZqTqluJM85pHjskOMuCGSUTYCSgU5yGwcomjZ4xyGPRzs9Dn4ff
         EiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124833; x=1779729633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1S1j85wWow1fE+PTjvTuFPIBUQaE7MqpQtw1l6nHQJo=;
        b=UGl/bZwNhMKHCNqUqr9e+JA95wzsaJfuezgpmgpM0jlT9pigQv+HplvnHafChAxj3U
         64L+2tOqhPHU8l1dJn7E32t7Ohqv0ABXJYPYsXT6/eNHMW9xGNlI8IllodCgY+ckaDLb
         6fYWiwM0NRpAUY1Z51v5Fr5vsncFNvwqcyEBsa2ZCJE3lU3OT2izffWo708Lfbjcqyh8
         IuoWjgNsDQ1u7837QWYJrpcVI+qVOp2ye3ZHwHZ44+2PjABn2E+xKpez+qMDEUHqdbpH
         0qU+AU0OYH1jYJfK/eo2Bm56NCYWRsnAdRzool2SBIszoNEhrcXrn08nkrnFc0MzrZaO
         UL+A==
X-Forwarded-Encrypted: i=1; AFNElJ+JaKmV2OOlLuFBWkS8/vbdMeLiCje+gTCFLPE80MyCphh2L1hxyIeLudGstwIzFw9WemDWa4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvmVJXuzlD0nO4b7l1jzzu7nlrhthoz/gOyQwOc4azR+f4S3k
	ATk3Z7g5bHdsmDikkO2718YXS4zpBYw0H+TIYbzcWU35yp/NNKvPBIt3+rEEQA+orUI3trT0+LQ
	erDcmsZ1irJEH6XPt0gnU4ntuX/kTNjdLtll6Kt0M
X-Gm-Gg: Acq92OGNN7LTO/hVEOHPEREtnxfHhDJgD8OT113fMG3cHBobqNMnDc7LcEVXAeYuCtg
	9+p63Y5XTTv/kbBPBAFomHjDAKJaneJYOHZ6Iap/jhfNIRyKdOgMmqK0PXolEJmcVnUBzuNL2MK
	DuH6LZOaOWI4gmuxBAJilqoqy/pwC1FBR5emG9mBtR/mAxP0AvayzVnYdiihmYNH67zhm0zsOTk
	H37TZhLgN4JoNsnGoVK1LG0iDgnVYHNSsEo42PeX3aQNRak0NZoSBED7uPN15PAd75r9xTNFPu7
	i7dcRCxaqEC8W/z8E/wYORicroqJY7sj64qMuIOkq1p0/19K453W5ryPvQ==
X-Received: by 2002:a05:6402:1046:b0:67b:6d1c:9585 with SMTP id
 4fb4d7f45d1cf-68489aadcf4mr104158a12.8.1779124832920; Mon, 18 May 2026
 10:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org> <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
In-Reply-To: <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 19:19:56 +0200
X-Gm-Features: AVHnY4KGdMkqgV8KR_Hs3f46IaO_i9iapO3-_O6QijP4TMBrCn6F8VLhssvFjK0
Message-ID: <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249351-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 8ED705718CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 7:32=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
> On Sat, 16 May 2026 at 10:09, Christian Brauner <brauner@kernel.org> wrot=
e:
> > I massaged the patch a bit and rewrote parts of the commit message.
>
> I still don't really like this. I think it's disgusting to add a
> pointer just for ptrace_may_access(), particularly with 99% of users
> already checking the mm for other reasons _anyway_.
>
> IOW, that user_dumpable bit was a minimal bandaid for bad behavior
> without breaking old code.
>
> And the fix is *NOT* to make the bandaid bigger, but to just fix the
> things that are broken.
>
> And Christian - right now pidfd is broken. THAT was always the real
> security bug here. Let's not change exit just because pidfd did the
> wrong thing and didn't check the mm like it should have.

I mean... /proc/$pid/task/fd/$n probably has the same problem, no?
pidfd_getfd() is just more severe because it directly creates an FD
for the file, instead of going through normal VFS open() permission
checks. But /proc/$pid/task/fd/$n is theoretically also dangerous for
stuff like anonymous pipes or memfds, where security mainly relies on
not being able to reach the inode.

> It might make sense to change the 'mode' argument to be something more
> flexible and something that forces people to *think* about the zombie
> situation.
>
> That mode thing is already a bitmap, so one bit could be "require it
> to have a MM", but I think it sjhould probably be done in a way that
> forces the callers to think about it a bit more.

I think that would be kind of ugly because here, the MM is not
actually used for memory management thing; instead, the MM is just
used as the one place we have that stores state that is shared between
threads, and is not reused across() execve (so if you're looking at
the MM of a task in the middle of exiting, you won't see information
that actually belongs to another thread that has gone through execve()
of a new executable). Basically like a signal_struct that is replaced
on execve().

If we were to have a flag like that, it should probably semantically
be "require the task to not be exiting/dead"; but I think that
wouldn't be very useful, because I think userspace expects procfs to
still mostly work for zombie processes?


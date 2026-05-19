Return-Path: <stable+bounces-249668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JmtEmOyDGrdkwUAu9opvQ
	(envelope-from <stable+bounces-249668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:56:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28F583EE3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A0D300CBD3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1D37268C;
	Tue, 19 May 2026 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUP75IWl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A936D9F6
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216991; cv=none; b=pE8YYXT5M5eryrUYTOprrogEVbZzDcI/g9z2ZPjsD5ajMr5lroY3hO3Av/N7xCx/kDNyistx/nLs18z7biii/LJbp/L0OIlXkdNzs+uJgaeQbX3Zas3F//X5r5SrHTdgEpIUoH7/DWff6s4O88JfMC3ihMsUDfqe536Tw2YJNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216991; c=relaxed/simple;
	bh=ZjnJWgedtmzLQ2IRqYN3U2OF1k577AUl0f4f9cJo2JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei1njUH/4b0nBGgaufvNbXuEChJ+CFXvqHxr3sJNyPJ2yUzv3qzPBiPk+8xob+PG2TjXcLknhusaHgnq3/GBN3GoNvAJIABFOj26FuSCvd1D0pkQdImAT8fKtKPaaXJ7uWMXDZ9SeUD/VxGCK1Furwkl8qVgsA6ehkLVbyNy9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUP75IWl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9358bc9c50so631500266b.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779216988; x=1779821788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=63bmeqgSk7+7aQYOs6wQUlriM8jsLdf5CB2BlAnv074=;
        b=CUP75IWl14m7hWpt6vGbYUO0s4b8KIBv+kZ3CGXPNrOWZsPOmq96OIvp8nm4nD8mN+
         Br+KlxBK111qzDmtWRN8zGQMjKeSsDB9C7x8eusaGCFvsPX8rNCdBZtsxcfzH/jHmcjQ
         /A+jD8JquyBi1P+wenel4IVbjgBw9mPr6W3qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216988; x=1779821788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63bmeqgSk7+7aQYOs6wQUlriM8jsLdf5CB2BlAnv074=;
        b=iQsvFpHkYdP7iYU1OnnzifQW+DkZ6mtjSqwRJ/eCOOZ88DWIz3njNgpCpC8Yj2oWYY
         jk94gaWdLibddrvkxwSZUO/sGaBXPVAwOHqun+CEn/JGkEH+CvUj1c9h344mzWJ7HtwN
         I10qLt96QvUFJKqyyB5lH5yVzxTvefpkBlkSdjBGrnnx5LEWv/coC38uU07/BZrNaXBa
         Uf8kSHz+/d6d/j4m1bKSVKZEMrr3CvlY5QFPkMT20GwUn40XCdFODVot2/IV5WpLn9ZF
         DCcC33Ad1cgcaLuqGIj9WEQpJj5Ke04w2svFfTfOvnkxlCGeqqWFTII9l0EgKE0ftJBj
         5NBw==
X-Forwarded-Encrypted: i=1; AFNElJ8EtvoyXGyHM/12wsXtf9AdmQAxhxOCag8c+vhKkNIMt2zhrUFBKrFRboAwgYUW3NSTnzoSOLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAM/UHEZlzeFSWE6hpq2spuPKRMGcWYxTySQ4O/gytkr7XepA
	tnfVRniAN/01TNsYPeOFQpTPY28n9dAnHix5zg33Xc6hbSrnSbfTw+rXySYaZGQeTiQpV7JYA3Q
	uJc1T7B53fA==
X-Gm-Gg: Acq92OEyFxzjJ3mGzhJpTaIniaX7jhwDJMyM3v7OzhLNuhKCQQyLF2LNXyqzTXFkU1O
	vT5fDDVEGOf4+AVtEuAz5xQLgaKeC7U3j/HFRO6fjWixhElzJG2YGsZ/7tZKwFpZdUL5FydSy9n
	1+hNZnGDGcihDwUI6Hqh5+fpErmJ3W+1Co7ivBo9aJz16tm5Xpy1MREfERi2ZQOpiU7Hk6K3Yez
	zDdK71tvHMCmobMBJENUV2kvmjBNks3kwzBKe1SjlcD+GNv0fQwXwfKJF4Ki9KHClqo214IXaw0
	mhuNuGxWwlLidtG5nHhWilaxXHA4iw4rcN0NU6PgXZWaXTApOcRKEFfMj8dUI828+JUVMRncFmL
	VuAyKEYOyCiJf//COVSC+YEvMQ98PPfK824y1GIic9fgv/VCd8fOwd07m+mWsrUpgM6CfcD9KIw
	wEEBOhI81EtswhmfhyqB2ptHGgzjgDmRGGEnHNbfkFWqMSY6bRGKKoFMA4VhNEm1huDRcYsoo=
X-Received: by 2002:a17:906:6a03:b0:bd4:99f5:52f6 with SMTP id a640c23a62f3a-bd51796da7cmr1087960166b.34.1779216987712;
        Tue, 19 May 2026 11:56:27 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm726928666b.32.2026.05.19.11.56.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 11:56:26 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9358bc9c50so631496366b.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8boBoiQ6dldBBpjLGRSX9GNc20/AQUTv5q92qfz6BmOFPlI1g56yPw2Z91jWaaRXBksJDpRDU=@vger.kernel.org
X-Received: by 2002:a17:907:86a2:b0:bd4:d6a4:ed58 with SMTP id
 a640c23a62f3a-bd51792974fmr1245909566b.28.1779216986416; Tue, 19 May 2026
 11:56:26 -0700 (PDT)
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
 <CAHk-=wj+NgoDH3GSicJ140SV8OoDd71pLmL3fgFEsTcgoMC6Og@mail.gmail.com> <20260519-anfahren-absuchen-715be2b88075@brauner>
In-Reply-To: <20260519-anfahren-absuchen-715be2b88075@brauner>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 19 May 2026 11:56:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=CX5buR3W7w+ZLkAR8KM8K5M9YqKUxB49Lifnx37CdQ@mail.gmail.com>
X-Gm-Features: AVHnY4JYuOjobcYrDL_0WtQpELsSRYfj6YFbBJjIgfy30Qq-1ZCMCZaAJSuiTFQ
Message-ID: <CAHk-=wg=CX5buR3W7w+ZLkAR8KM8K5M9YqKUxB49Lifnx37CdQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249668-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9F28F583EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 10:57, Christian Brauner <brauner@kernel.org> wrote:
>
> I failed to actually append the thing I intended to append...
> So for completeness sake I'm resending it here.

Ok, this looks good, but as mentioned, I think we should *not* do that
"copy_exec_state()" at all.

Because I think it's actively wrong for the reasons outlined: it just
keeps the existing race with anybody doing

  fork -> drop priv -> exec

open. Or, for that matter any suid  binary that relies on the
traditional "fork helpers" model rathe than using threads.

So I'd suggest at least trying to only do the refcount update at
clone() time, regardless of any CLONE_VM.

*If* that causes compatibility problems we might then be forced to do
the bad old copy, but I really suspect it won't. The only semantic
difference will be for fork() that isn't followed by an execve() (and
wasn't dumpable), and that is

 (a) very rare (both the "not dumpable" _and_ the "fork rather than
threads", and the combination is rarer still)

 (b) I really think such a situation has potentially secret data in
the address space and the new semantics are much better and more
logical

Now, I might well not think of some situation where a suid program
forks and drops privileges and we actually *want* the end result to be
dumpable, but as mentioned, at that point we *could* do your
"copy_exec_state()". But I think it would be better to try without it
first.

Other than that issue, this approach really does feel like the
RightThing(tm) to me.

              Linus


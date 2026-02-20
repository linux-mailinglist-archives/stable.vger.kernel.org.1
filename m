Return-Path: <stable+bounces-217539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pO1BAn7ul2kd+QIAu9opvQ
	(envelope-from <stable+bounces-217539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:17:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54256164BEC
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90883019827
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E71FC0EA;
	Fri, 20 Feb 2026 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WT2ASGCa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3C19D093
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771564666; cv=pass; b=ACudVUvqogBlTJsbtt3CVbOOn9tdE5RRChAxRfLmP3q0MJ3WhKCkUaYgYx4XHORrIVDCdPZ//nORkxcsebK+MA+2cgM9EdQHgF61CxNRfEdTvSsgm8HVtPIjZT74Sai2rk0zJMgs3gFnrcJgmvysHAaK89vmRlItKh0Sb7Qq4Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771564666; c=relaxed/simple;
	bh=nqYqK7qYSwiChKPT6YGNR1sWhns+iWH1ykmmdD+MTNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAjC1WtnZc500kKuuh2dPEOQJ9UjO5Ss/+CtMXkx1KTILwHIGjwr8bcyriiiqaMrI8aWQBX2HuJyWKvNDM+CvMbuY5eia5p1jSa0wXKU8v8zCIiX9bcpK5KCpih9Z4IuXS3dYtFrMBydmyyZN+cu6UoHjrdNFHiTm3cm+FR9ZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WT2ASGCa; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a885af8ee7so32525ad.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 21:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771564663; cv=none;
        d=google.com; s=arc-20240605;
        b=Ie/8Ui2J3KAIh5qVNri12EZ2lUZjWcU00AqQVp0eTrUCyWe4DoLkhBetPIG8nZA+CW
         W/RicI8sPSbLV276jMTZNQAqZKg+Z2gm4CBbbbqTD4qq34Zw2oETM+3IOamcZrqt9iq1
         M3RyDYZwO9X8hftLYK14tOuWZL8hDijB4at7NvRUIvsgmToAajoLRsmhPTGuZCHYBxXU
         oxc2sf+IcQEqTECyvKsfUDNlWZ4mgDbHBKLqRVrc4hF3dicQ3t4qRSpS3JUohYFUtsqY
         Y4Czg0bI8tgBzkTQAa6pSMkDjxVjrvyUI0Rl3utFQaXXJUTEMscV5AvScjsk+BIC9d8m
         X4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        fh=7V4UgTt9TrfhyAoz96fHQIIsx9mzOJ3lGMEWd4cDZMs=;
        b=lg5CtdYfLUY7ZvgXQytUCSZ3tk7F7YAQwfXIos+oAZhSC9WvxS/YeoJ2hiNQOpzkvU
         A0IpD/8UY+1hMQlSlerttECvpQmUDWjVF/Ix1g4jD8UEZPVieweKnWA1LX0gQ+tHSIJT
         hrDN0VXPQX5uqC4D1xbdqIOqMgXXx0i5DXuqToqFoFBtsQerxPctUvKl8pOozE2zMdbI
         3RfLJqRL/6HXFbyy/Wxqbz3Dk3zrtOZ8cUT53rZBJBQKckyFEPy1bDREszjoUBm8NMoi
         GgRasHkyYw1tyoKm1m1bhw5w5C2UyFwP1i3P7hqAs32v4Qi09MwVTA26RoKItJJ6QYPs
         fJCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771564663; x=1772169463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        b=WT2ASGCais2o1cG0qjFJKpG6hiabiXDyOgSc5J71i/DZn2vD4RrQmNHHokvRDGWGgT
         4VQDNy2zkZybqDy5SIJ3+Yv/Np1bPwD25eHRCyWbQ3XxGfIcaj/cyL0DcIK3GQVVlasA
         qHxpugmTG5C4FtNCKjyMX3exqbZFDic0SFmrTGFXvdVOsgwf0PgawIKSb3Bn9Ok8Fx7N
         2CFEvwZO1A0FoJVWxtW9tJ6CMHwGyZSeG1V1fXtkjarmqnbcz7By0u944Sb0q1KlK+FZ
         ZPEQet0JFwhCQGS2wZgOjFPJ60avb3/ySAK7l8p1djhaaKxGQB6TiQU9Stls5ACqvYw/
         gsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771564663; x=1772169463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        b=LUj3h/10yQPvT43HDykbbM5Esj2QAidwQD/LQVGFvJWjoP5mcEGwFMkFzEWh2s7raO
         QzxWKKs3NHSPbN3BCHxeii/EWAK67mNNce8qea/63OcyT83DA5ScT8rSTtWNeZEYoI1Y
         /WUNDz7H4pj+v6CqZmDryZcF7yYnY7x1sqry3QJdFUpNUeQDYW9RhccAF9Se7gJladU0
         oOlIHQDTWUoEnLTJYgcF1UbpoYpK09C35qdCuJTqJGlRqbbcT5i1M+dSc7irz1xnsOyu
         w8f5W5oDBQ4uS2HrQ5xeBJW2OX6H7scmV0sccGr/P/GCWf1oAUuykblC7K30LrN6I28O
         lITw==
X-Forwarded-Encrypted: i=1; AJvYcCVzFLWIdvZRMox1SJo8leArIX9rD4Ztc6yrajYkorPJdcr4/dcBFTQg21RiC1zNhh9lygHPUXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCQqJriyLqSxsvytW3xQ8hQV6JCJ7oUWiFLxCHhIV6/VtYsHf
	YbzsHLI6akeW/23l3xDz21QYoLtoPgvA/cYKI7lTDzZZrqaPD+Z0wX4I5ardMzzQm64sesXbgQF
	mcIubhItL5IktT6K5s9YOidPyKzK4/JyTFGcMvqru
X-Gm-Gg: AZuq6aL/p34gX/D8s4bft57KcoyWCd3GJ5xHLsWg/1Ejt8M6FljVJgmdnqFQvWv1SAh
	TX7y+8FLJTVvrZZDlfanRZ5shCdnq49WNIRL9CdZqYa0TaXYM+XixWmSaZtO3d1EDSJmyPXe7hR
	Pa0Yxa6NOg0fwsn1KXSnRWZBIIkqKI3gM/xelcKas8fEx/jMya5MVtgETvB/d7i1Xu9W5DB1k/w
	P1NucVAE6/F7JnlNLS1EZTykI/bj2GT4R3kRHWiShlkCm6SB8xDrKC5UYPzu3DV4Q5+czN5koTy
	BOJUldKXQJQBWIt5pw3RYomheDX91qviMrl6B7o6
X-Received: by 2002:a17:902:d584:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2ad69e114ddmr1414495ad.2.1771564662949; Thu, 19 Feb 2026
 21:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219233708.1971199-1-kaleshsingh@google.com> <20260220011700.127763-1-sj@kernel.org>
In-Reply-To: <20260220011700.127763-1-sj@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 19 Feb 2026 21:17:31 -0800
X-Gm-Features: AaiRm52THFMQu8DD4__rg--y4qYBq0Xcvfy_Nb5EOcRcZKNj46I4M1T8ZW27eX0
Message-ID: <CAC_TJvcdwaUspCXze4grzWeX8Kt_CQd0KmXwKG20Ex52n0hoaQ@mail.gmail.com>
Subject: Re: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread context
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, 
	kernel-team@android.com, android-mm@google.com, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>, 
	Wander Lairson Costa <wander@redhat.com>, Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217539-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaleshsingh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,perfetto.dev:url,linux-foundation.org:email,mail.gmail.com:mid,goodmis.org:email]
X-Rspamd-Queue-Id: 54256164BEC
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 5:17=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 19 Feb 2026 15:36:56 -0800 Kalesh Singh <kaleshsingh@google.com> =
wrote:
>
> > The rss_stat trace event allows userspace tools, like Perfetto [1],
> > to inspect per-process RSS metric changes over time.
> >
> > The curr field was introduced to rss_stat in commit e4dcad204d3a
> > ("rss_stat: add support to detect RSS updates of external mm").
> > It's intent is to  indicate whether the RSS update is for the
> > mm_struct of the current execution context; and is set to false
> > when operating on a remote mm_struct (e.g., via kswapd or a
> > direct reclaimer).
> >
> > However, an issue arises when a kernel thread temporarily adopts
> > a user process's mm_struct. Kernel threads do not have their own
> > mm_struct and normally have current->mm set to NULL. To operate
> > on user memory, they can "borrow" a memory context using
> > kthread_use_mm(), which sets current->mm to the user process's mm.
> >
> > This can be observed, for example, in the USB Function Filesystem
> > (FFS) driver. The ffs_user_copy_worker() handles AIO completions
> > and uses kthread_use_mm() to copy data to a user-space buffer.
> > If a page fault occurs during this copy, the fault handler executes
> > in the kthread's context.
> >
> > At this point, current is the kthread, but current->mm points to the
> > user process's mm. Since the rss_stat event (from the page fault)
> > is for that same mm, the condition current->mm =3D=3D mm becomes true,
> > causing curr to be incorrectly set to true when the trace event is
> > emitted.
> >
> > This is misleading because it suggests the mm belongs to the kthread,
> > confusing userspace tools that track per-process RSS changes and
> > corrupting their mm_id-to-process association.
> >
> > Fix this by ensuring curr is always false when the trace event is
> > emitted from a kthread context by checking for the PF_KTHREAD flag.
> >
> > [1] https://perfetto.dev/
> >
> > Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of ex=
ternal mm")
>
> Sounds like the issue is not that critical, but user-visible?  Would it b=
e
> better to Cc stable@ ?

Thanks for the reviews, SJ and Zi.

I didn't add stable initially because it isn't functionally critical.
However, it would be nice to get it backported, as without it,
observability is much more difficult.

I believe the patch should apply cleanly to stable with minimal risk.
Andrew, if it isn't too much trouble, would you mind folding the
following tag into the staged patch?

Cc: stable@vger.kernel.org # 5.10+

Thanks,
Kalesh

>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
> [...]

